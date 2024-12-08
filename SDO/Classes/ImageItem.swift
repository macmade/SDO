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
public class ImageItem: NSCollectionViewItem
{
    @objc public dynamic var image: ImageData?

    private var infoViewController: InfoViewController?
    private var popover           = NSPopover()

    public override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    @IBAction
    private func share( _ sender: Any? )
    {
        guard let view  = sender as? NSView,
              let image = self.image?.image
        else
        {
            NSSound.beep()

            return
        }

        NSSharingServicePicker( items: [ image ] ).show( relativeTo: .zero, of: view, preferredEdge: .maxX )
    }

    @IBAction
    private func showInfo( _ sender: Any? )
    {
        guard let view  = sender as? NSView,
              let image = self.image
        else
        {
            NSSound.beep()

            return
        }

        if self.popover.isShown
        {
            self.popover.close()

            return
        }

        self.infoViewController            = InfoViewController( image: image )
        self.popover.behavior              = .semitransient
        self.popover.contentViewController = self.infoViewController

        self.popover.show( relativeTo: .zero, of: view, preferredEdge: .maxY )
    }

    @IBAction
    public func viewImage( _ sender: Any? )
    {
        guard let image    = self.image,
              let delegate = NSApp.delegate as? ApplicationDelegate
        else
        {
            NSSound.beep()

            return
        }

        delegate.showQuickLookPanel( image: image )
    }

    @IBAction
    public func viewVideo( _ sender: Any? )
    {
        guard let image = self.image, VideoWindowController.showWindow( for: image )
        else
        {
            NSSound.beep()

            return
        }
    }
}
