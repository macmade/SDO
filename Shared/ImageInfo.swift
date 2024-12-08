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

public struct ImageInfo
{
    public static let all: [ ImageInfo ] = [
        ImageInfo(
            uuid:        "46BD849E-4840-4BE8-ADF1-7976BA52EEAA",
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
            uuid:        "D3ECCF39-6EFE-4148-BCAD-02181E9B66FA",
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
            uuid:        "88665DF7-4565-433B-B7D3-230157FD5027",
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
            uuid:        "9B0D7501-8448-4487-8C39-57B0578286AB",
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
            uuid:        "33EB35C5-5652-45A4-A16C-0CE9BE8436A3",
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
            uuid:        "DF11BB5E-ED8F-433F-BE75-26DC0094DAAB",
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
            uuid:        "9B095D28-F7F9-4F14-97DD-23ED67222D8D",
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
            uuid:        "FDB67CD7-0970-4503-9BA6-C41317F9B896",
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
            uuid:        "4DC4D33A-C46E-4FFC-8BEE-62C139762508",
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
            uuid:        "3D11B74A-A222-4368-8416-4AC630DACE6D",
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
            uuid:        "E9178963-202A-4826-B2D1-64DC01029C06",
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
            uuid:        "60CE7AB0-3030-4956-89E6-36EBDC01E250",
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
            uuid:        "A92C8CB6-6F7F-4B0C-B516-B980DA923C1B",
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
            uuid:        "492F2A11-8766-4EC7-B79D-C59939210765",
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
            uuid:        "0FE74086-89D9-498A-BC02-11B4CF2AECDD",
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
            uuid:        "6FF89A11-7495-4F16-B1FF-5D5E722BA1DA",
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
            uuid:        "36AFB08B-100A-45F2-9502-DBBB28C0F877",
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
            uuid:        "C5D4F40B-F428-4C3D-857C-3F0719FC89E7",
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
            uuid:        "8EFD8ECA-2CF7-485F-A189-1AB1A391B892",
            file:        "latest_1024_HMID.jpg",
            title:       "HMI Dopplergram",
            text:        nil,
            location:    nil,
            wavelength:  nil,
            ions:        nil,
            temperature: nil,
            video:       nil
        ),
        ImageInfo(
            uuid:        "106DCB48-CFDD-4F1E-B1C4-10DCA625742E",
            file:        "latest_ar_map.png",
            title:       "AR Map",
            text:        nil,
            location:    nil,
            wavelength:  nil,
            ions:        nil,
            temperature: nil,
            video:       "latest_ar_map.mp4"
        ),
        ImageInfo(
            uuid:        "9A0134F9-E7C1-4CF5-91EF-D3154EB692452",
            file:        "latest_composite_map.png",
            title:       "Composite Map",
            text:        nil,
            location:    nil,
            wavelength:  nil,
            ions:        nil,
            temperature: nil,
            video:       "latest_composite_map.mp4"
        ),
        ImageInfo(
            uuid:        "34622904-5349-4D22-A10F-0605BEE52DC0",
            file:        "SDO_2D.jpg",
            title:       "Location - 2D",
            text:        nil,
            location:    nil,
            wavelength:  nil,
            ions:        nil,
            temperature: nil,
            video:       "latest48_SDO_2D.mp4"
        ),
        ImageInfo(
            uuid:        "6A86AFE6-A331-4DF1-96B4-C53299A8A487",
            file:        "SDO_VO1.jpg",
            title:       "Location - VO1",
            text:        nil,
            location:    nil,
            wavelength:  nil,
            ions:        nil,
            temperature: nil,
            video:       "latest48_SDO_VO3.mp4"
        ),
        ImageInfo(
            uuid:        "838E08FE-ECC2-4DAC-9C3E-5D2CD2DDCBFD",
            file:        "SDO_VO2.jpg",
            title:       "Location - VO2",
            text:        nil,
            location:    nil,
            wavelength:  nil,
            ions:        nil,
            temperature: nil,
            video:       "latest48_SDO_VO2.mp4"
        ),
        ImageInfo(
            uuid:        "4B964800-BE80-4EFB-A331-A8E5A134D0B1",
            file:        "SDO_VO3.jpg",
            title:       "Location - VO3",
            text:        nil,
            location:    nil,
            wavelength:  nil,
            ions:        nil,
            temperature: nil,
            video:       "latest48_SDO_VO3.mp4"
        ),
    ]

    public var uuid:        String
    public var file:        String
    public var title:       String
    public var text:        String?
    public var location:    String?
    public var wavelength:  String?
    public var ions:        String?
    public var temperature: String?
    public var video:       String?
}
