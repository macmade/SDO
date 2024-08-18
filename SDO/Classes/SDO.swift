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

import Cocoa

public class SDO
{
    public static let shared = SDO()

    private var url:    URL
    private let queue = DispatchQueue( label: "com.xs-labs.SDO", attributes: .concurrent, autoreleaseFrequency: .workItem )

    @objc public private( set ) dynamic var latest: [ Image ] = []

    private init?()
    {
        guard let url = URL( string: "https://sdo.gsfc.nasa.gov/assets/img/latest/" )
        else
        {
            return nil
        }

        self.url = url
    }

    public func downloadAll( completion: @escaping ( [ Image ] ) -> Void )
    {
        DispatchQueue.global( qos: .userInitiated ).async
        {
            let session = URLSession( configuration: .ephemeral )

            let workers: [ ( image: Image, group: DispatchGroup ) ] = ImageInfo.all.map
            {
                ( Image( info: $0 ), DispatchGroup() )
            }

            workers.forEach
            {
                worker in

                worker.group.enter()

                self.queue.async
                {
                    self.download( worker: worker, session: session )
                }
            }

            workers.forEach
            {
                $0.group.wait()
            }

            let images = workers.map
            {
                $0.image
            }

            DispatchQueue.main.async
            {
                self.latest = images

                completion( images )
            }
        }
    }

    private func download( worker: ( image: Image, group: DispatchGroup ), session: URLSession )
    {
        Task
        {
            defer
            {
                worker.group.leave()
            }

            let url = self.url.appendingPathComponent( worker.image.file )

            if let ( data, _ ) = try? await session.data( from: url ),
               let image       = NSImage( data: data )
            {
                worker.image.image = image
            }
        }
    }
}
