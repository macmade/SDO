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
    @State private var isLoading             = false

    var body: some View
    {
        ZStack
        {
            if self.images.isEmpty, self.isLoading == false
            {
                VStack
                {
                    Image( systemName: "sun.max.trianglebadge.exclamationmark.fill" )
                        .resizable()
                        .frame( width: 50, height: 50 )
                        .padding()
                    TextButtonView( text: "Could Not Load Images...", button: "Refresh", symbol: "arrow.clockwise.circle.fill" )
                    {
                        self.refresh()
                    }
                }
            }
            else if self.images.isEmpty == false
            {
                ImageListView( images: self.images )
                {
                    DispatchQueue.main.asyncAfter( deadline: .now() + .milliseconds( 500 ) )
                    {
                        self.refresh()
                    }
                }
                header:
                {
                    HStack
                    {
                        Text( "Last Refresh: \( self.lastRefreshText )" )
                            .font( .caption2 )
                            .foregroundStyle( .secondary )
                            .padding( .top )
                    }
                }
                footer:
                {
                    AboutView().padding()
                }
                .blur( radius: self.isLoading ? 75 : 0 )
                .disabled( self.isLoading )
            }

            if self.isLoading
            {
                LoadingView( text: "Loading Latest Images from SDO\nPlease Wait" )
            }
        }
        .frame( maxWidth: .infinity, maxHeight: .infinity )
        .background( .white.opacity( 0.075  ) )
        .onAppear
        {
            self.refresh()
        }
    }

    private func refresh()
    {
        self.isLoading = true

        SDO.shared?.downloadAll
        {
            images in DispatchQueue.main.asyncAfter( deadline: .now() + .milliseconds( 500 ) )
            {
                self.lastRefresh = Date()
                self.images      = images.filter { $0.image != nil }
                self.isLoading   = false
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
