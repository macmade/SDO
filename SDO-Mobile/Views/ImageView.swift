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

struct ImageView: View
{
    @State public var image:                 ImageData
    @State private var isShowingInfoSheet  = false
    @State private var isShowingVideoSheet = false
    @State private var isShowingShareSheet = false

    var body: some View
    {
        ZStack
        {
            VStack( spacing: 0 )
            {
                if let image = self.image.image
                {
                    Image( uiImage: image )
                        .resizable()
                        .scaledToFit()
                }
                Spacer()
                HStack( alignment: .bottom )
                {
                    Text( self.image.title )
                        .bold()
                        .font( .headline )
                    Spacer()

                    if let video = self.image.video
                    {
                        SymbolButton( image: "video.circle.fill", title: "Show Video" )
                        {
                            self.isShowingVideoSheet = true
                        }
                        .iPadOnly
                        {
                            $0.fullScreenCover( isPresented: $isShowingVideoSheet )
                            {
                                VideoView( title: self.image.title, video: video )
                            }
                        }
                        .iPhoneOnly
                        {
                            $0.sheet( isPresented: $isShowingVideoSheet )
                            {
                                VideoView( title: self.image.title, video: video )
                            }
                        }
                    }

                    if self.image.text != nil
                    {
                        SymbolButton( image: "info.circle.fill", title: "Show Info" )
                        {
                            self.isShowingInfoSheet = true
                        }
                        .sheet( isPresented: $isShowingInfoSheet )
                        {
                            ImageInfoView( image: self.image )
                                .padding()
                                .presentationBackground( .regularMaterial )
                        }
                    }

                    if let url = self.image.imageURL
                    {
                        SymbolButton( image: "paperplane.circle.fill", title: "Share" )
                        {
                            self.isShowingShareSheet = true
                        }
                        .sheet( isPresented: $isShowingShareSheet )
                        {
                            ActivityViewController( activityItems: [ url ] )
                        }
                    }
                }
                .padding( [ .horizontal, .bottom ] )
            }
        }
        .background( .black )
        .cornerRadius( 10 )
        .cornerRadius( 10 )
        .overlay( RoundedRectangle( cornerRadius: 10 ).stroke( .white.opacity( 0.2 ), lineWidth: 1 ) )
        .shadow( color: .black, radius: 5, x: 0, y: 2 )
    }
}

#Preview
{
    ImageView( image: PreviewData.images.first! ).padding()
}
