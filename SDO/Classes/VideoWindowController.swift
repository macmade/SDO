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

import AVKit
import Cocoa

@objc
public class VideoWindowController: NSWindowController, NSWindowDelegate
{
    private static var controllers = [ VideoWindowController ]()

    @objc private dynamic var title:          String
    @objc private dynamic var url:            URL
    @objc private dynamic var downloadedFile: URL?
    @objc private dynamic var loading       = true

    @IBOutlet private var player: AVPlayerView?

    public class func showWindow( for image: Image ) -> Bool
    {
        guard let video = image.video, let url = URL( string: "https://sdo.gsfc.nasa.gov/assets/img/latest/mpeg/\( video )" )
        else
        {
            return false
        }

        let controller = VideoWindowController( title: image.title, url: url )

        self.controllers.append( controller )
        controller.window?.center()
        controller.window?.makeKeyAndOrderFront( nil )

        return true
    }

    private init( title: String, url: URL )
    {
        self.title = title
        self.url   = url

        super.init( window: nil )
    }

    required init?( coder: NSCoder )
    {
        nil
    }

    public override var windowNibName: NSNib.Name?
    {
        "VideoWindowController"
    }

    public override func windowDidLoad()
    {
        super.windowDidLoad()

        self.window?.title    = self.title
        self.window?.delegate = self

        self.download()
    }

    public func windowWillClose( _ notification: Notification )
    {
        VideoWindowController.controllers.removeAll
        {
            $0 === self
        }

        if let file = self.downloadedFile
        {
            try? FileManager.default.removeItem( at: file )
        }
    }

    private func showError( message: String )
    {
        DispatchQueue.main.async
        {
            let alert             = NSAlert()
            alert.messageText     = "Downbload Failed"
            alert.informativeText = message

            if let window = self.window
            {
                alert.beginSheetModal( for: window )
                {
                    _ in DispatchQueue.main.async
                    {
                        window.performClose( nil )
                    }
                }
            }
            else
            {
                alert.runModal()
                DispatchQueue.main.async
                {
                    self.window?.performClose( nil )
                }
            }
        }
    }

    private func download()
    {
        self.loading = true

        let session = URLSession( configuration: .ephemeral )
        let request = URLRequest( url: self.url )
        let task    = session.downloadTask( with: request )
        {
            ( tempURL, response, error ) in

            if let error = error
            {
                self.showError( message: error.localizedDescription )

                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200
            else
            {
                self.showError( message: "An unknown error occured." )

                return
            }

            guard let tempURL = tempURL
            else
            {
                self.showError( message: "An unknown error occured." )

                return
            }

            let copy = URL( fileURLWithPath: NSTemporaryDirectory() ).appendingPathComponent( NSUUID().uuidString ).appendingPathExtension( "mp4" )

            do
            {
                try FileManager.default.copyItem( at: tempURL, to: copy )
            }
            catch
            {
                self.showError( message: error.localizedDescription )

                return
            }

            DispatchQueue.main.async
            {
                self.loading        = false
                self.downloadedFile = copy

                let player          = AVPlayer( url: copy )
                self.player?.player = player

                player.play()
            }
        }

        task.resume()
    }
}
