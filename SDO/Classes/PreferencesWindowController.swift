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
public class PreferencesWindowController: NSWindowController, NSTableViewDelegate, NSTableViewDataSource
{
    @objc public dynamic var refreshInterval  = Preferences.shared.refreshInterval
    {
        didSet
        {
            Preferences.shared.refreshInterval = self.refreshInterval
        }
    }

    @objc public dynamic var automaticRefresh = Preferences.shared.automaticRefresh
    {
        didSet
        {
            Preferences.shared.automaticRefresh = self.automaticRefresh
        }
    }

    @objc public dynamic var allSelected = false

    @IBOutlet private var imagesController: NSArrayController?
    @IBOutlet private var imagesTableView:  NSTableView?

    private var infoPopover:    NSPopover?
    private var infoController: InfoViewController?

    public override var windowNibName: NSNib.Name?
    {
        "PreferencesWindowController"
    }

    public override func windowDidLoad()
    {
        super.windowDidLoad()
        self.refreshImages()
        self.imagesTableView?.registerForDraggedTypes( [ .string ] )
    }

    @IBAction
    private func restoreDefaults( _ sender: Any? )
    {
        Preferences.shared.restoreDefaults()

        self.refreshInterval  = Preferences.shared.refreshInterval
        self.automaticRefresh = Preferences.shared.automaticRefresh

        self.refreshImages()
    }

    @IBAction
    private func toggleSelection( _ sender: Any? )
    {
        guard let checkbox = sender as? NSButton,
              let images   = self.imagesController?.content as? [ PreferencesImageItem ]
        else
        {
            return
        }

        let checked = checkbox.intValue != 0

        images.forEach
        {
            $0.isChecked = checked
        }

        self.update()
        self.updateSelectionStatus()
    }

    private func refreshImages()
    {
        self.imagesController?.content = NSMutableArray()

        let all = ImageInfo.all.map
        {
            PreferencesImageItem( info: $0 )
        }

        var images: [ PreferencesImageItem ] = Preferences.shared.images.compactMap
        {
            guard let uuid    = $0[ "uuid" ]    as? String,
                  let display = $0[ "display" ] as? Bool
            else
            {
                return nil
            }

            let item        = all.first { $0.uuid == uuid }
            item?.isChecked = display

            return item
        }

        all.forEach
        {
            image in

            if images.contains( where: { $0.uuid == image.uuid } ) == false
            {
                images.append( image )
            }
        }

        images.forEach
        {
            [ weak self ] item in guard let self = self
            else
            {
                return
            }

            item.onCheck =
            {
                [ weak self ] in

                self?.update()
                self?.updateSelectionStatus()
            }

            self.imagesController?.addObject( item )
        }

        self.updateSelectionStatus()
    }

    private func updateSelectionStatus()
    {
        guard let images = self.imagesController?.content as? [ PreferencesImageItem ]
        else
        {
            return
        }

        if images.contains( where: { $0.isChecked == false } )
        {
            self.allSelected = false
        }
        else
        {
            self.allSelected = true
        }
    }

    private func update()
    {
        guard let items = self.imagesController?.content as? [ PreferencesImageItem ]
        else
        {
            return
        }

        Preferences.shared.images = items.map
        {
            [
                "uuid":    $0.uuid,
                "display": $0.isChecked,
            ]
        }
    }

    @objc
    private func showInfo( forView view: Any?, item: Any? )
    {
        guard let view = view as? NSView,
              let item = item as? PreferencesImageItem
        else
        {
            NSSound.beep()

            return
        }

        if let popover = self.infoPopover, popover.isShown
        {
            popover.close()
        }

        let popover                   = NSPopover()
        popover.behavior              = .semitransient
        let controller                = InfoViewController( image: ImageData( info: item.info ) )
        popover.contentViewController = controller
        self.infoPopover              = popover
        self.infoController           = controller

        if let button = view.findSubview( identifier: NSUserInterfaceItemIdentifier( "InfoButton" ), recursively: true )
        {
            popover.show( relativeTo: .zero, of: button, preferredEdge: .maxY )
        }
        else
        {
            popover.show( relativeTo: .zero, of: view, preferredEdge: .minY )
        }
    }

    public func tableView( _ tableView: NSTableView, pasteboardWriterForRow row: Int ) -> ( any NSPasteboardWriting )?
    {
        guard let content = self.imagesController?.content as? [ PreferencesImageItem ]
        else
        {
            return nil
        }

        let item = NSPasteboardItem()

        item.setString( content[ row ].uuid, forType: .string )

        return item
    }

    public func tableView( _ tableView: NSTableView, validateDrop info: any NSDraggingInfo, proposedRow row: Int, proposedDropOperation dropOperation: NSTableView.DropOperation ) -> NSDragOperation
    {
        dropOperation == .above ? .move : []
    }

    public func tableView( _ tableView: NSTableView, acceptDrop info: any NSDraggingInfo, row: Int, dropOperation: NSTableView.DropOperation ) -> Bool
    {
        guard let uuid   = info.draggingPasteboard.string( forType: .string ),
              var images = self.imagesController?.content as? [ PreferencesImageItem ],
              let index  = images.firstIndex( where: { $0.uuid == uuid } )
        else
        {
            return false
        }

        images.move( fromOffsets: IndexSet( integer: index ), toOffset: row )

        self.imagesController?.content = NSMutableArray( array: images )
        self.update()

        return true
    }
}
