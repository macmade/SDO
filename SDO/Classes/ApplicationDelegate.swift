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
import QuickLook
import QuickLookUI

@main
public class ApplicationDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate, QLPreviewPanelDataSource, QLPreviewPanelDelegate, QLPreviewItem
{
    @objc private dynamic var aboutWindowController       = AboutWindowController()
    @objc private dynamic var mainWindowController        = MainWindowController()
    @objc private dynamic var preferencesWindowController = PreferencesWindowController()

    private var updater     = GitHubUpdater( owner: "macmade", repository: "SDO" )
    private var previewImage: Image?

    public var previewItemURL: URL?

    public func applicationDidFinishLaunching( _ notification: Notification )
    {
        if Preferences.shared.firstLaunch
        {
            self.mainWindowController.window?.center()
        }

        self.mainWindowController.window?.makeKeyAndOrderFront( nil )

        DispatchQueue.main.asyncAfter( deadline: .now() + .seconds( 2 ) )
        {
            self.updater?.checkForUpdates()
        }
    }

    public func applicationWillTerminate( _ notification: Notification )
    {
        Preferences.shared.firstLaunch = false

        if let url = self.previewItemURL
        {
            try? FileManager.default.removeItem( at: url )
        }
    }

    public func applicationShouldTerminateAfterLastWindowClosed( _ sender: NSApplication ) -> Bool
    {
        false
    }

    public func applicationSupportsSecureRestorableState( _ app: NSApplication ) -> Bool
    {
        false
    }

    @IBAction
    public func openDocument( _ sender: Any? )
    {
        self.mainWindowController.window?.makeKeyAndOrderFront( nil )
    }

    @IBAction
    public func showAboutWindow( _ sender: Any? )
    {
        if self.aboutWindowController.window?.isVisible == false
        {
            self.aboutWindowController.window?.layoutIfNeeded()
            self.aboutWindowController.window?.center()
        }

        self.aboutWindowController.window?.makeKeyAndOrderFront( sender )
    }

    @IBAction
    public func showPreferencesWindow( _ sender: Any? )
    {
        if self.preferencesWindowController.window?.isVisible == false
        {
            self.preferencesWindowController.window?.layoutIfNeeded()
            self.preferencesWindowController.window?.center()
        }

        self.preferencesWindowController.window?.makeKeyAndOrderFront( sender )
    }

    @IBAction
    public func invertAppearance( _ sender: Any? )
    {
        switch NSApp.effectiveAppearance.name
        {
            case .accessibilityHighContrastAqua:         NSApp.appearance = NSAppearance( named: .accessibilityHighContrastDarkAqua )
            case .accessibilityHighContrastDarkAqua:     NSApp.appearance = NSAppearance( named: .accessibilityHighContrastAqua )
            case .accessibilityHighContrastVibrantLight: NSApp.appearance = NSAppearance( named: .accessibilityHighContrastVibrantDark )
            case .accessibilityHighContrastVibrantDark:  NSApp.appearance = NSAppearance( named: .accessibilityHighContrastVibrantLight )
            case .aqua:                                  NSApp.appearance = NSAppearance( named: .darkAqua )
            case .darkAqua:                              NSApp.appearance = NSAppearance( named: .aqua )
            case .vibrantLight:                          NSApp.appearance = NSAppearance( named: .vibrantDark )
            case .vibrantDark:                           NSApp.appearance = NSAppearance( named: .vibrantLight )

            default: break
        }
    }

    @IBAction
    public func saveDocument( _ sender: Any? )
    {
        self.mainWindowController.saveDocument( sender )
    }

    public func showQuickLookPanel( image: Image )
    {
        if self.previewItemURL == nil
        {
            guard let data  = image.image?.tiffRepresentation,
                  let rep   = NSBitmapImageRep( data: data ),
                  let png   = rep.representation( using: .png, properties: [ : ] )
            else
            {
                NSSound.beep()

                return
            }

            let url             = URL( fileURLWithPath: NSTemporaryDirectory() ).appendingPathComponent( NSUUID().uuidString ).appendingPathExtension( "png" )
            self.previewItemURL = url
            self.previewImage   = image

            do
            {
                try png.write( to: url )
            }
            catch
            {
                NSSound.beep()

                return
            }
        }

        QLPreviewPanel.shared().makeKeyAndOrderFront( nil )
    }

    public override func acceptsPreviewPanelControl( _ panel: QLPreviewPanel! ) -> Bool
    {
        true
    }

    public override func beginPreviewPanelControl( _ panel: QLPreviewPanel! )
    {
        panel.delegate   = self
        panel.dataSource = self
    }

    public override func endPreviewPanelControl( _ panel: QLPreviewPanel! )
    {
        if let url = self.previewItemURL
        {
            try? FileManager.default.removeItem( at: url )
        }

        self.previewItemURL = nil
        self.previewImage   = nil
        panel.delegate      = nil
        panel.dataSource    = nil
    }

    public func numberOfPreviewItems( in panel: QLPreviewPanel! ) -> Int
    {
        1
    }

    public func previewPanel( _ panel: QLPreviewPanel!, previewItemAt index: Int ) -> ( any QLPreviewItem )!
    {
        self
    }

    public var previewItemTitle: String!
    {
        self.previewImage?.title ?? "Unknown"
    }
}
