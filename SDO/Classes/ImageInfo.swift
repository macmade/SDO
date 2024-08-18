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

public struct ImageInfo
{
    public static let all: [ ImageInfo ] = [
        ImageInfo(
            file:        "latest_1024_0193.jpg",
            title:       "AIA 0193 Å",
            text:        "This channel highlights the outer atmosphere of the Sun - called the corona - as well as hot flare plasma. Hot active regions, solar flares, and coronal mass ejections will appear bright here. The dark areas - called coronal holes - are places where very little radiation is emitted, yet are the main source of solar wind particles.",
            location:    "Corona and hot flare plasma",
            wavelength:  "193 angstroms (0.0000000193 m) = Extreme Ultraviolet",
            ions:        "11 times ionized iron (Fe XII)",
            temperature: "1.25 million K (2.25 million F)",
            video:       "latest_1024_0193.mp4"
        ),
        ImageInfo(
            file:        "latest_1024_0304.jpg",
            title:       "AIA 0304 Å",
            text:        "This channel is especially good at showing areas where cooler dense plumes of plasma (filaments and prominences) are located above the visible surface of the Sun. Many of these features either can't be seen or appear as dark lines in the other channels. The bright areas show places where the plasma has a high density.",
            location:    "Upper chromosphere and lower transition region",
            wavelength:  "304 angstroms (0.0000000304 m) = Extreme Ultraviolet",
            ions:        "Singly ionized helium (He II)",
            temperature: "50,000 K (90,000 F)",
            video:       "latest_1024_0304.mp4"
        ),
        ImageInfo(
            file:        "latest_1024_0171.jpg",
            title:       "AIA 0171 Å",
            text:        "This channel is especially good at showing coronal loops - the arcs extending off of the Sun where plasma moves along magnetic field lines. The brightest spots seen here are locations where the magnetic field near the surface is exceptionally strong",
            location:    "Quiet corona and upper transition region",
            wavelength:  "171 angstroms (0.0000000171 m) = Extreme Ultraviolet",
            ions:        "8 times ionized iron (Fe IX)",
            temperature: "1 million K (1.8 million F)",
            video:       "latest_1024_0171.mp4"
        ),
        ImageInfo(
            file:        "latest_1024_0211.jpg",
            title:       "AIA 0211 Å",
            text:        "This channel (as well as AIA 335) highlights the active region of the outer atmosphere of the Sun - the corona. Active regions, solar flares, and coronal mass ejections will appear bright here. The dark areas - called coronal holes - are places where very little radiation is emitted, yet are the main source of solar wind particles.",
            location:    "Active regions of the corona",
            wavelength:  "211 angstroms (0.0000000211 m) = Extreme Ultraviolet",
            ions:        "13 times ionized iron (Fe XIV)",
            temperature: "2 million K (3.6 million F)",
            video:       "latest_1024_0211.mp4"
        ),
        ImageInfo(
            file:        "latest_1024_0131.jpg",
            title:       "AIA 0131 Å",
            text:        "This channel (as well as AIA 094) is designed to study solar flares. It measures extremely hot temperatures around 10 million K (18 million F), as well as cool plasmas around 400,000 K (720,000 F). It can take images every 2 seconds (instead of 10) in a reduced field of view in order to look at flares in more detail.",
            location:    "Flaring regions of the corona",
            wavelength:  "131 angstroms (0.0000000131 m) = Extreme Ultraviolet",
            ions:        "20 and 7 times ionized iron (Fe VIII, Fe XXI)",
            temperature: "10 million K (18 million F)",
            video:       "latest_1024_0131.mp4"
        ),
        ImageInfo(
            file:        "latest_1024_0335.jpg",
            title:       "AIA 0335 Å",
            text:        "This channel (as well as AIA 211) highlights the active region of the outer atmosphere of the Sun - the corona. Active regions, solar flares, and coronal mass ejections will appear bright here. The dark areas - or coronal holes - are places where very little radiation is emitted, yet are the main source of solar wind particles.",
            location:    "Active regions of the corona",
            wavelength:  "335 angstroms (0.0000000335 m) = Extreme Ultraviolet",
            ions:        "15 times ionized iron (Fe XVI)",
            temperature: "2.8 million K (5 million F)",
            video:       "latest_1024_0335.mp4"
        ),
        ImageInfo(
            file:        "latest_1024_0094.jpg",
            title:       "AIA 0094 Å",
            text:        "This channel (as well as AIA 131) is designed to study solar flares. It measures extremely hot temperatures around 6 million Kelvin (10.8 million F). It can take images every 2 seconds (instead of 10) in a reduced field of view in order to look at flares in more detail.",
            location:    "Flaring regions of the corona",
            wavelength:  "94 angstroms (0.0000000094 m) = Extreme Ultraviolet/soft X-rays",
            ions:        "17 times ionized iron (Fe XVIII)",
            temperature: "6 million K (10.8 million F)",
            video:       "latest_1024_0094.mp4"
        ),
        ImageInfo(
            file:        "latest_1024_1600.jpg",
            title:       "AIA 1600 Å",
            text:        "This channel (as well as AIA 1700) often shows a web-like pattern of bright areas that highlight places where bundles of magnetic fields lines are concentrated. However, small areas with a lot of field lines will appear black, usually near sunspots and active regions.",
            location:    "Transition region and upper photosphere",
            wavelength:  "1600 angstroms (0.00000016 m) = Far Ultraviolet",
            ions:        "Thrice ionized carbon (C IV) and Continuum",
            temperature: "6,000 K (11,000 F), and 100,000 K (180,000 F)",
            video:       "latest_1024_1600.mp4"
        ),
        ImageInfo(
            file:        "latest_1024_1700.jpg",
            title:       "AIA 1700 Å",
            text:        "This channel (as well as AIA 1600) often shows a web-like pattern of bright areas that highlight places where bundles of magnetic fields lines are concentrated. However, small areas with a lot of field lines will appear black, usually near sunspots and active regions.",
            location:    "Temperature minimum and photosphere",
            wavelength:  "1700 angstroms (0.00000017 m) = Far Ultraviolet",
            ions:        "Continuum",
            temperature: "6,000 K (11,000 F)",
            video:       "latest_1024_1700.mp4"
        ),
        ImageInfo(
            file:        "latest_1024_211193171.jpg",
            title:       "AIA 211 Å, 193 Å, 171 Å",
            text:        "This image combines three images with different, but very similar, temperatures. The colors are assigned differently than in the single images. Here AIA 211 is red, AIA 193 is green, and AIA 171 is blue. Each highlights a different part of the corona.",
            location:    nil,
            wavelength:  nil,
            ions:        nil,
            temperature: nil,
            video:       nil
        ),
        ImageInfo(
            file:        "f_304_211_171_1024.jpg",
            title:       "AIA 304 Å, 211 Å, 171 Å",
            text:        "This image combines three images with quite different temperatures. The colors are assigned differently than in the single images. Here AIA 304 is red (showing the chromosphere), AIA 211 is green (corona), and AIA 171 is dark blue (corona).",
            location:    nil,
            wavelength:  nil,
            ions:        nil,
            temperature: nil,
            video:       nil
        ),
        ImageInfo(
            file:        "f_094_335_193_1024.jpg",
            title:       "AIA 094 Å, 335 Å, 193 Å",
            text:        "This image combines three images with different temperatures. Each image is assigned a color, and they are not the same used in the single images. Here AIA 094 is red, AIA 335 is green, and AIA 193 is blue. Each highlights a different part of the corona.",
            location:    nil,
            wavelength:  nil,
            ions:        nil,
            temperature: nil,
            video:       nil
        ),
        ImageInfo(
            file:        "f_HMImag_171_1024.jpg",
            title:       "AIA 171 Å & HMIB",
            text:        nil,
            location:    nil,
            wavelength:  nil,
            ions:        nil,
            temperature: nil,
            video:       nil
        ),
        ImageInfo(
            file:        "latest_1024_HMIB.jpg",
            title:       "HMI Magnetogram",
            text:        nil,
            location:    nil,
            wavelength:  nil,
            ions:        nil,
            temperature: nil,
            video:       nil
        ),
        ImageInfo(
            file:        "latest_1024_HMIBC.jpg",
            title:       "HMI Colorized Magnetogram",
            text:        nil,
            location:    nil,
            wavelength:  nil,
            ions:        nil,
            temperature: nil,
            video:       nil
        ),
        ImageInfo(
            file:        "latest_1024_HMIIC.jpg",
            title:       "HMI Intensitygram - Colored",
            text:        nil,
            location:    nil,
            wavelength:  nil,
            ions:        nil,
            temperature: nil,
            video:       nil
        ),
        ImageInfo(
            file:        "latest_1024_HMIIF.jpg",
            title:       "HMI Intensitygram - Flattened",
            text:        nil,
            location:    nil,
            wavelength:  nil,
            ions:        nil,
            temperature: nil,
            video:       nil
        ),
        ImageInfo(
            file:        "latest_1024_HMII.jpg",
            title:       "HMI Intensitygram",
            text:        nil,
            location:    nil,
            wavelength:  nil,
            ions:        nil,
            temperature: nil,
            video:       nil
        ),
        ImageInfo(
            file:        "latest_1024_HMID.jpg",
            title:       "HMI Dopplergram",
            text:        nil,
            location:    nil,
            wavelength:  nil,
            ions:        nil,
            temperature: nil,
            video:       nil
        ),
    ]

    public var file:        String
    public var title:       String
    public var text:        String?
    public var location:    String?
    public var wavelength:  String?
    public var ions:        String?
    public var temperature: String?
    public var video:       String?
}
