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

struct ImageListView< Header: View, Footer: View >: View
{
    @State public var images:         [ ImageData ]
    @State public var displayAsGrid = false

    public var onRefresh: () -> Void

    let header: () -> Header
    let footer: () -> Footer

    var body: some View
    {
        ScrollView
        {
            self.header()

            VStack( spacing: 10 )
            {
                if self.displayAsGrid
                {
                    ForEach( self.imageGroups, id: \.0.uuid )
                    {
                        image1, image2, image3 in HStack
                        {
                            ImageView( image: image1 ).frame( maxHeight: .infinity )

                            if let image2 = image2
                            {
                                ImageView( image: image2 ).frame( maxHeight: .infinity )
                            }
                            else
                            {
                                ImageView( image: image1 ).frame( maxHeight: .infinity ).hidden()
                            }

                            if let image3 = image3
                            {
                                ImageView( image: image3 ).frame( maxHeight: .infinity )
                            }
                            else
                            {
                                ImageView( image: image1 ).frame( maxHeight: .infinity ).hidden()
                            }
                        }
                    }
                }
                else
                {
                    ForEach( self.images, id: \.uuid )
                    {
                        ImageView( image: $0 )
                    }
                }
            }
            .fixedSize( horizontal: false, vertical: true )
            .padding( .horizontal )

            self.footer()
        }
        .refreshable
        {
            self.onRefresh()
        }
        .onAppear
        {
            self.displayAsGrid = UIDevice.current.userInterfaceIdiom == .pad || UIDevice.current.orientation.isLandscape
        }
        .onReceive( NotificationCenter.default.publisher( for: UIDevice.orientationDidChangeNotification ) )
        {
            _ in

            if UIDevice.current.userInterfaceIdiom == .pad
            {
                self.displayAsGrid = true
            }
            else if UIDevice.current.orientation.isLandscape
            {
                self.displayAsGrid = true
            }
            else if UIDevice.current.orientation.isPortrait
            {
                self.displayAsGrid = false
            }
        }
    }

    private var imageGroups: [ ( ImageData, ImageData?, ImageData? ) ]
    {
        let col1 = self.images.enumerated().filter { $0.offset % 3 == 0 }.map { $0.element }.enumerated()
        let col2 = self.images.enumerated().filter { $0.offset % 3 == 1 }.map { $0.element }.enumerated()
        let col3 = self.images.enumerated().filter { $0.offset % 3 == 2 }.map { $0.element }.enumerated()

        return col1.map
        {
            item in

            let image1 = item.element
            let image2 = col2.first { $0.offset == item.offset }?.element
            let image3 = col3.first { $0.offset == item.offset }?.element

            return ( image1, image2, image3 )
        }
    }
}

#Preview
{
    ImageListView( images: PreviewData.images )
    {
        print( "Refreshing..." )
    }
    header:
    {
        Text( "Header" )
    }
    footer:
    {
        Text( "Footer" )
    }
}
