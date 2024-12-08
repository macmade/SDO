/*******************************************************************************
 * The MIT License (MIT)
 *
 * Copyright (c) 2023, Jean-David Gadina - www.xs-labs.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the Software), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 ******************************************************************************/

import Cocoa

@objc
public class MainWindowController: NSWindowController, NSCollectionViewDataSource, NSCollectionViewDelegate
{
    private let itemID = NSUserInterfaceItemIdentifier( "ImageItem" )

    @objc private dynamic var allImages  = [ ImageData ]()
    @objc private dynamic var images     = [ ImageData ]()
    @objc private dynamic var loading    = true
    @objc private dynamic var refreshing = false
    @objc private dynamic var empty      = false
    @objc private dynamic var lastRefresh: String?

    @objc private dynamic var imageSize = Preferences.shared.imageSize
    {
        didSet
        {
            Preferences.shared.imageSize = self.imageSize

            self.updateLayout()
        }
    }

    @IBOutlet private var collectionView: NSCollectionView?
    @IBOutlet private var slider:         Slider?

    private var imageSizeObserver:        NSKeyValueObservation?
    private var imagesObserver:           NSKeyValueObservation?
    private var refreshIntervalObserver:  NSKeyValueObservation?
    private var automaticRefreshObserver: NSKeyValueObservation?
    private var refreshTimer:             Timer?

    public init()
    {
        super.init( window: nil )
    }

    public required init?( coder: NSCoder )
    {
        nil
    }

    public override var windowNibName: NSNib.Name?
    {
        "MainWindowController"
    }

    public override func windowDidLoad()
    {
        super.windowDidLoad()
        self.updateRefreshTimer()

        self.imageSizeObserver = Preferences.shared.observe( \.imageSize )
        {
            [ weak self ] _, _ in guard let self = self
            else
            {
                return
            }

            if Preferences.shared.imageSize != self.imageSize
            {
                self.imageSize = Preferences.shared.imageSize
            }
        }

        self.imagesObserver = Preferences.shared.observe( \.images )
        {
            [ weak self ] _, _ in guard let self = self
            else
            {
                return
            }

            self.updateImages()
            self.collectionView?.reloadData()
        }

        self.refreshIntervalObserver = Preferences.shared.observe( \.refreshInterval )
        {
            [ weak self ] _, _ in self?.updateRefreshTimer()
        }

        self.automaticRefreshObserver = Preferences.shared.observe( \.automaticRefresh )
        {
            [ weak self ] _, _ in self?.updateRefreshTimer()
        }

        self.collectionView?.register( NSNib( nibNamed: "ImageItem", bundle: nil ), forItemWithIdentifier: self.itemID )
        self.refresh( nil )
        self.updateLayout()

        self.slider?.onDoubleClick =
        {
            [ weak self ] in DispatchQueue.main.async
            {
                self?.resetImageSize( nil )
            }
        }
    }

    private func updateRefreshTimer()
    {
        self.refreshTimer?.invalidate()

        if Preferences.shared.automaticRefresh
        {
            self.refreshTimer = Timer.scheduledTimer( withTimeInterval: TimeInterval( Preferences.shared.refreshInterval ), repeats: true )
            {
                [ weak self ] _ in self?.refresh( nil )
            }
        }
    }

    private func showError( title: String, message: String )
    {
        let alert             = NSAlert()
        alert.messageText     = title
        alert.informativeText = message

        if let window = self.window
        {
            alert.beginSheetModal( for: window )
        }
        else
        {
            alert.runModal()
        }
    }

    private func showError( error: Error )
    {
        let alert = NSAlert( error: error )

        if let window = self.window
        {
            alert.beginSheetModal( for: window )
        }
        else
        {
            alert.runModal()
        }
    }

    @IBAction
    public func saveDocument( _ sender: Any? )
    {
        let images: [ ( title: String, file: String, image: NSImage ) ] = self.images.compactMap
        {
            if let image = $0.image
            {
                return ( $0.title, $0.file, image )
            }

            return nil
        }

        guard let window = self.window, self.loading == false, images.isEmpty == false
        else
        {
            NSSound.beep()

            return
        }

        let panel                     = NSOpenPanel()
        panel.canChooseFiles          = false
        panel.canChooseDirectories    = true
        panel.allowsMultipleSelection = false
        panel.canCreateDirectories    = true

        panel.beginSheetModal( for: window )
        {
            var isDir = ObjCBool( false )

            guard $0 == .OK,
                  let url = panel.url,
                  FileManager.default.fileExists( atPath: url.path, isDirectory: &isDir ),
                  isDir.boolValue
            else
            {
                return
            }

            images.forEach
            {
                guard let data = $0.image.tiffRepresentation
                else
                {
                    self.showError( title: "Error", message: "Could not save image: \( $0.title )" )

                    return
                }

                let name = "\( NSString( string: $0.file ).deletingPathExtension ).tif"

                do
                {
                    try data.write( to: self.uniqueFilename( name: name, inDirectory: url ) )
                }
                catch
                {
                    self.showError( error: error )
                }
            }
        }
    }

    private func uniqueFilename( name: String, inDirectory url: URL ) -> URL
    {
        let ext   = ( name as NSString ).pathExtension
        let name  = ( name as NSString ).deletingPathExtension
        var index = 0

        while true
        {
            let num = index > 0 ? "-\( index )" : ""
            let url = url.appendingPathComponent( "\( name )\( num ).\( ext )" )

            if FileManager.default.fileExists( atPath: url.path ) == false
            {
                return url
            }

            index += 1
        }
    }

    @IBAction
    public func resetImageSize( _ sender: Any? )
    {
        self.imageSize = 256
    }

    @IBAction
    public func refresh( _ sender: Any? )
    {
        if self.refreshing
        {
            return
        }

        self.refreshing = true

        SDO.shared?.downloadAll
        {
            images in DispatchQueue.main.async
            {
                if let _ = images.first( where: { $0.image == nil } )
                {
                    self.showError( title: "Missing Images", message: "Some images could not be downloaded at this time." )
                }

                self.loading    = false
                self.refreshing = false
                self.allImages  = images

                self.updateImages()

                let fmt                        = DateFormatter()
                fmt.dateStyle                  = .short
                fmt.timeStyle                  = .medium
                fmt.doesRelativeDateFormatting = true
                self.lastRefresh               = "Last Refreshed: \( fmt.string( from: Date() ) )"

                self.collectionView?.reloadData()
            }
        }
    }

    private func updateImages()
    {
        var images: [ ( image: ImageData, display: Bool ) ] = Preferences.shared.images.compactMap
        {
            guard let uuid    = $0[ "uuid" ]    as? String,
                  let display = $0[ "display" ] as? Bool,
                  let image   = self.allImages.first( where: { $0.uuid == uuid } )
            else
            {
                return nil
            }

            return ( image, display )
        }

        self.allImages.forEach
        {
            image in if images.contains( where: { $0.image.uuid == image.uuid } ) == false
            {
                images.append( ( image, true ) )
            }
        }

        self.images = images.filter
        {
            $0.display
        }
        .map
        {
            $0.image
        }

        self.empty = self.images.isEmpty
    }

    public func numberOfSections( in collectionView: NSCollectionView ) -> Int
    {
        1
    }

    public func collectionView( _ collectionView: NSCollectionView, numberOfItemsInSection section: Int ) -> Int
    {
        self.images.count
    }

    public func collectionView( _ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath ) -> NSCollectionViewItem
    {
        guard let item = collectionView.makeItem( withIdentifier: self.itemID, for: indexPath ) as? ImageItem
        else
        {
            return NSCollectionViewItem()
        }

        item.image = self.images[ indexPath.item ]

        return item
    }

    private func updateLayout()
    {
        DispatchQueue.main.async
        {
            guard let layout = self.collectionView?.collectionViewLayout as? CollectionViewLayout
            else
            {
                return
            }

            layout.itemSize = NSSize( width: self.imageSize, height: self.imageSize )

            DispatchQueue.main.async
            {
                layout.invalidateLayout()
            }
        }
    }

    @IBAction
    private func openSDOWebsite( _ sender: Any? )
    {
        guard let url = URL( string: "https://sdo.gsfc.nasa.gov" )
        else
        {
            NSSound.beep()

            return
        }

        NSWorkspace.shared.open( url )
    }

    @IBAction
    private func showPreferences( _ sender: Any? )
    {
        guard let delegate = NSApp.delegate as? ApplicationDelegate
        else
        {
            NSSound.beep()

            return
        }

        delegate.showPreferencesWindow( sender )
    }
}
