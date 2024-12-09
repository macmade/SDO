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

import SwiftUI

struct ImageInfoView: View
{
    @State public var image: ImageData

    @Environment( \.dismiss ) var dismiss

    var body: some View
    {
        VStack
        {
            if UIDevice.current.userInterfaceIdiom == .pad
            {
                Spacer()
            }

            Text( self.image.title )
                .font( .largeTitle )
                .bold()

            if let text = self.image.text
            {
                Text( text )
                    .padding( .top, 10 )
                    .frame( maxWidth: .infinity, alignment: .leading )
            }

            VStack( alignment: .leading, spacing: 10 )
            {
                if let location = self.image.location
                {
                    ImageInfoDetailView( title: "Where:", text: location )
                }

                if let wavelength = self.image.wavelength
                {
                    ImageInfoDetailView( title: "Wavelength:", text: wavelength )
                }

                if let ions = self.image.ions
                {
                    ImageInfoDetailView( title: "Primary Ions Seen:", text: ions )
                }

                if let temperature = self.image.temperature
                {
                    ImageInfoDetailView( title: "Characteristic Temperature:", text: temperature )
                }
            }
            .padding( .top, 20 )
            .frame( maxWidth: .infinity, alignment: .leading )

            if UIDevice.current.userInterfaceIdiom == .pad
            {
                Spacer()
                SymbolButton( image: "xmark.circle.fill", title: "Close" )
                {
                    dismiss()
                }
                .padding( .top )
            }
        }
    }
}

#Preview
{
    ImageInfoView( image: PreviewData.images.first! ).padding()
}
