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

import Foundation

public class VideoDownload
{
    public var url: URL?

    private let remoteURL:  URL
    private var completion: ( ( VideoDownload ) -> Void )?

    private static var downloads: [ VideoDownload ] = []

    public init( remoteURL: URL, completion: @escaping ( VideoDownload ) -> Void )
    {
        self.remoteURL  = remoteURL
        self.completion = completion

        let session = URLSession( configuration: .ephemeral )
        let request = URLRequest( url: remoteURL )
        let task    = session.downloadTask( with: request )
        {
            location, response, error in

            guard let location = location,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200
            else
            {
                self.complete()

                return
            }

            let name = remoteURL.lastPathComponent
            let dir  = URL( fileURLWithPath: NSTemporaryDirectory() ).appendingPathComponent( NSUUID().uuidString )
            let copy = dir.appendingPathComponent( name )

            do
            {
                try FileManager.default.createDirectory( at: dir, withIntermediateDirectories: true )
                try FileManager.default.copyItem( at: location, to: copy )
            }
            catch
            {
                self.complete()

                return
            }

            DispatchQueue.main.async
            {
                self.url = copy

                self.complete()
            }
        }

        task.resume()
    }

    private func complete()
    {
        DispatchQueue.main.async
        {
            self.completion?( self )
            VideoDownload.downloads.removeAll( where: { $0 === self } )

            self.completion = nil
        }
    }

    deinit
    {
        if let url = self.url
        {
            try? FileManager.default.removeItem( at: url )
            try? FileManager.default.removeItem( at: url.deletingLastPathComponent() )
        }
    }

    public class func download( video: String, completion: @escaping ( VideoDownload ) -> Void )
    {
        guard let url = URL( string: "https://sdo.gsfc.nasa.gov/assets/img/latest/mpeg/\( video )" )
        else
        {
            return
        }

        DispatchQueue.main.async
        {
            VideoDownload.downloads.append( VideoDownload( remoteURL: url, completion: completion ) )
        }
    }
}
