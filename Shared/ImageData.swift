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

#if os( macOS )
    import Cocoa
#else
    import SwiftUI
#endif

@objc
public class ImageData: NSObject
{
    @objc public dynamic var uuid:        String
    @objc public dynamic var file:        String
    @objc public dynamic var title:       String
    @objc public dynamic var text:        String?
    @objc public dynamic var location:    String?
    @objc public dynamic var wavelength:  String?
    @objc public dynamic var ions:        String?
    @objc public dynamic var temperature: String?
    @objc public dynamic var video:       String?

    #if os( macOS )
        @objc public dynamic var image: NSImage?
    #else
        public dynamic var image: UIImage?
    #endif

    public init( info: ImageInfo )
    {
        self.uuid        = info.uuid
        self.file        = info.file
        self.title       = info.title
        self.text        = info.text
        self.location    = info.location
        self.wavelength  = info.wavelength
        self.ions        = info.ions
        self.temperature = info.temperature
        self.video       = info.video
    }
}