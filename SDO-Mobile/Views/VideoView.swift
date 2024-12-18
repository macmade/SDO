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

import AVKit
import SwiftUI

struct VideoView: View
{
    @State public var title:    String
    @State public var video:    String
    @State public var download: VideoDownload?
    @State public var error:    RuntimeError?
    @State public var loading = false

    @State private var isShowingShareSheet = false

    @Environment( \.dismiss ) var dismiss

    var body: some View
    {
        VStack
        {
            if UIDevice.current.userInterfaceIdiom == .pad
            {
                Spacer()
            }

            ZStack
            {
                if self.loading
                {
                    LoadingView( text: "Loading Video - Please Wait" )
                }
                else if let url = self.download?.url
                {
                    VStack
                    {
                        ZStack( alignment: .trailing )
                        {
                            Text( self.title )
                                .font( .largeTitle )
                                .bold()
                                .frame( maxWidth: .infinity )
                            SymbolButton( image: "paperplane.circle.fill", title: "Share" )
                            {
                                self.isShowingShareSheet = true
                            }
                            .sheet( isPresented: $isShowingShareSheet )
                            {
                                ActivityViewController( activityItems: [ url ] )
                            }
                            .padding( .trailing )
                        }
                        .padding( .vertical )
                        VideoPlayer( player: self.player( url: url ) )
                    }
                }
                else
                {
                    VStack
                    {
                        Image( systemName: "video.slash.fill" )
                            .resizable()
                            .frame( width: 50, height: 50 )
                            .padding()
                        TextButtonView( text: "Error Loading Video", button: "Refresh", symbol: "arrow.clockwise.circle.fill" )
                        {
                            self.refresh()
                        }
                    }
                }
            }

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
        .frame( maxWidth: .infinity, maxHeight: .infinity )
        .background( .black )
        .onAppear
        {
            self.refresh()
        }
    }

    private func refresh()
    {
        self.loading = true

        VideoDownload.download( video: self.video )
        {
            result in DispatchQueue.main.asyncAfter( deadline: .now() + .milliseconds( 500 ) )
            {
                switch result
                {
                    case .success( let download ): self.download = download
                    case .failure( let error ):    self.error    = error
                }

                self.loading = false
            }
        }
    }

    private func player( url: URL ) -> AVPlayer?
    {
        let player = AVPlayer( url: url )

        player.play()

        return player
    }
}

#Preview
{
    VideoView( title: PreviewData.images.first!.title, video: PreviewData.images.first!.video! )
}
