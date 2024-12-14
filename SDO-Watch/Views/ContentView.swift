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
                VStack( spacing: 10 )
                {
                    Image( systemName: "sun.max.trianglebadge.exclamationmark.fill" )
                        .resizable()
                        .frame( width: 25, height: 25 )
                        .padding()
                    Button( "Refresh" )
                    {
                        self.refresh()
                    }
                }
                .padding()
            }
            else if self.images.isEmpty == false
            {
                ScrollView
                {
                    VStack( spacing: 0 )
                    {
                        Button()
                        {
                            self.refresh()
                        }
                        label:
                        {
                            Label( "Refresh", systemImage: "arrow.trianglehead.2.counterclockwise" )
                        }
                        .buttonStyle( .borderless )

                        ForEach( self.images, id: \.uuid )
                        {
                            if let image = $0.image
                            {
                                Image( uiImage: image )
                                    .resizable()
                                    .aspectRatio( contentMode: .fill )
                                Text( $0.title )
                                    .font( .caption2 )
                                    .bold()
                                    .multilineTextAlignment( .center )
                                    .padding( 10 )
                            }
                        }
                    }
                }
                .blur( radius: self.isLoading ? 75 : 0 )
                .disabled( self.isLoading )
            }

            if self.isLoading
            {
                VStack
                {
                    ProgressView()
                        .scaleEffect( 1.5 )
                        .padding()
                    Text( "Loading Images" )
                        .foregroundStyle( .secondary )
                        .multilineTextAlignment( .center )
                }
            }
        }
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
