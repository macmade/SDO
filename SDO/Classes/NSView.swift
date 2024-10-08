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

public extension NSView
{
    func addFillingSubview( _ view: NSView )
    {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame                                     = self.bounds

        self.addSubview( view )
        self.addConstraint( NSLayoutConstraint( item: view, attribute: .width,   relatedBy: .equal, toItem: self, attribute: .width,   multiplier: 1, constant: 0 ) )
        self.addConstraint( NSLayoutConstraint( item: view, attribute: .height,  relatedBy: .equal, toItem: self, attribute: .height,  multiplier: 1, constant: 0 ) )
        self.addConstraint( NSLayoutConstraint( item: view, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0 ) )
        self.addConstraint( NSLayoutConstraint( item: view, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0 ) )
    }

    func findSubview( identifier: NSUserInterfaceItemIdentifier, recursively: Bool ) -> NSView?
    {
        for v in self.subviews
        {
            if v.identifier == identifier
            {
                return v
            }

            if recursively, let v = v.findSubview( identifier: identifier, recursively: recursively )
            {
                return v
            }
        }

        return nil
    }
}
