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
    @State public var image:                   ImageData
    @State private var isShowingInfoPopover  = false
    @State private var isShowingVideoPopover = false

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

                HStack
                {
                    if self.image.image != nil
                    {
                        SymbolButton( image: "square.and.arrow.up", title: "Share" )
                        {
                            self.share()
                        }
                    }

                    Spacer()
                    ImageTitleView( image: self.image )
                    {
                        self.isShowingInfoPopover = true
                    }
                    .popover( isPresented: $isShowingInfoPopover, arrowEdge: .bottom )
                    {
                        ImageInfoView( image: self.image ).padding()
                    }
                    Spacer()

                    if let video = self.image.video
                    {
                        SymbolButton( image: "video.fill", title: "Show Info" )
                        {
                            self.isShowingVideoPopover = true
                        }
                        .popover( isPresented: $isShowingVideoPopover, arrowEdge: .bottom )
                        {
                            VideoView( video: video )
                        }
                    }
                }
                .padding( .horizontal )
            }
        }
        .background( .white.opacity( 0.1 ) )
        .cornerRadius( 10 )
        .cornerRadius( 10 )
        .overlay( RoundedRectangle( cornerRadius: 10 ).stroke( .white.opacity( 0.2 ), lineWidth: 1 ) )
    }

    private func share()
    {
        guard let image = self.image.image,
              let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        else
        {
            return
        }

        let sheet = UIActivityViewController( activityItems: [ image ], applicationActivities: nil )

        scene.keyWindow?.rootViewController?.present( sheet, animated: true, completion: nil )
    }
}

#Preview
{
    ImageView( image: PreviewData.images.first! ).padding()
}
