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

    @IBOutlet private var imagesController: NSArrayController?
    @IBOutlet private var imagesTableView:  NSTableView?

    public override var windowNibName: NSNib.Name?
    {
        "PreferencesWindowController"
    }

    public override func windowDidLoad()
    {
        super.windowDidLoad()
        self.refreshImages()
    }

    @IBAction
    private func restoreDefaults( _ sender: Any? )
    {
        Preferences.shared.restoreDefaults()

        self.refreshInterval  = Preferences.shared.refreshInterval
        self.automaticRefresh = Preferences.shared.automaticRefresh

        self.refreshImages()
    }

    private func refreshImages()
    {
        self.imagesController?.content = NSMutableArray()

        ImageInfo.all.map
        {
            PreferencesImageItem( info: $0 )
        }
        .forEach
        {
            [ weak self ] item in guard let self = self
            else
            {
                return
            }

            item.isChecked = Preferences.shared.images.contains
            {
                $0 == item.uuid
            }

            item.onCheck =
            {
                [ weak self ] in self?.update()
            }

            self.imagesController?.addObject( item )
        }
    }

    private func update()
    {
        guard let items = self.imagesController?.content as? [ PreferencesImageItem ]
        else
        {
            return
        }

        Preferences.shared.images = items.filter
        {
            $0.isChecked
        }
        .map
        {
            $0.uuid
        }
    }
}
