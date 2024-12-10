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

struct TextButtonView: View
{
    @State public var text:   String
    @State public var button: String
    @State public var symbol: String?

    public var action: () -> Void

    var body: some View
    {
        VStack
        {
            Text( self.text ).font( .headline )
            Button
            {
                self.action()
            }
            label:
            {
                if let symbol = self.symbol
                {
                    Label( self.button, systemImage: symbol )
                        .padding( .vertical, 10 )
                        .padding( .horizontal, 15 )
                }
                else
                {
                    Text( self.button )
                        .padding( .vertical, 10 )
                        .padding( .horizontal, 15 )
                }
            }
            .background( Color.accentColor )
            .foregroundColor( .white )
            .cornerRadius( 15 )
            .padding()
        }
    }
}

#Preview
{
    VStack
    {
        TextButtonView( text: "Lorem Ipsum", button: "Dolor", symbol: "swift" )
        {
            print( "Tap" )
        }
        TextButtonView( text: "Lorem Ipsum", button: "Dolor", symbol: nil )
        {
            print( "Tap" )
        }
    }
}
