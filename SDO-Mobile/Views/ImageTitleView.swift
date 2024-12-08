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

struct ImageTitleView: View
{
    @State public var image: ImageData

    public var action: () -> Void

    var body: some View
    {
        Button
        {
            self.action()
        }
        label:
        {
            HStack
            {
                Text( self.image.title )
                    .font( .subheadline )
                    .foregroundColor( .white.opacity( 0.75 ) )

                if self.image.text != nil
                {
                    Image( systemName: "info.circle.fill" )
                        .scaleEffect( 0.75 )
                        .foregroundColor( .white.opacity( 0.75 ) )
                }
            }
            .padding( .horizontal, 10 )
            .padding( .vertical, 5 )
            .background( .white.opacity( 0.25 ) )
            .cornerRadius( 5 )
            .padding()
        }
        .disabled( self.image.text == nil )
    }
}

#Preview
{
    ImageTitleView( image: PreviewData.images.first! )
    {
        print( "Tapped" )
    }
    .padding()
}
