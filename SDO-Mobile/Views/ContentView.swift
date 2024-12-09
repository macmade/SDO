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

struct ContentView: View
{
    @State private var images: [ ImageData ] = []
    @State private var lastRefresh           = Date()

    var body: some View
    {
        VStack
        {
            if self.images.isEmpty
            {
                LoadingView( text: "Loading Latest Images from SDO\nPlease Wait" )
            }
            else
            {
                ImageListView( images: self.images )
                {
                    self.refresh()
                }
                header:
                {
                    HStack
                    {
                        Text( "Last Refresh: \( self.lastRefreshText )" )
                            .font( .caption2 )
                            .foregroundStyle( .secondary )
                    }
                }
                footer:
                {
                    AboutView().padding()
                }
            }
        }
        .frame( maxWidth: .infinity, maxHeight: .infinity )
        .background( .white.opacity( 0.05 ) )
        .onAppear
        {
            self.refresh()
        }
    }

    private func refresh()
    {
        self.images.removeAll()
        SDO.shared?.downloadAll
        {
            self.lastRefresh = Date()

            $0.forEach
            {
                self.images.append( $0 )
            }
        }
    }

    private var lastRefreshText: String
    {
        let formatter = DateFormatter()

        formatter.dateStyle                  = .short
        formatter.timeStyle                  = .short
        formatter.doesRelativeDateFormatting = true

        return formatter.string( from: self.lastRefresh )
    }
}

#Preview
{
    ContentView()
}
