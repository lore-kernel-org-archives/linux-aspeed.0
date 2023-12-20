From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 20 Dec 2023 18:00:12 +0100
Subject: [PATCH v8] ARM: dts: aspeed: Adding Facebook Bletchley BMC
In-Reply-To: <F444BFCC-1D44-4AF6-A0E1-B153A217FFE3@stwcx.xyz>
References: <20231220080733.GA30641@wunner.de>
 <F444BFCC-1D44-4AF6-A0E1-B153A217FFE3@stwcx.xyz>
Message-ID: <20231220170012.GA10387@wunner.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Dec 20, 2023 at 06:38:59AM -0600, Patrick Williams wrote:
> On Dec 20, 2023, at 2:07AM, Lukas Wunner <lukas@wunner.de> wrote:
> > On Tue, Dec 07, 2021 at 05:49:24PM +0800, Howard Chiu wrote:
> > > Initial introduction of Facebook Bletchley equipped with
> > > Aspeed 2600 BMC SoC.
> > [...]
> > > +        tpmdev at 0 {
> > > +            compatible = "tcg,tpm_tis-spi";
> > 
> > What's the chip used on this board?  Going forward, the DT schema for TPMs
> > requires the exact chip name in addition to the generic "tcg,tpm_tis-spi".
> 
> Why is this a requirement?  This assumes there is exactly one chip.
> TPMs are often placed on a pluggable module in which multiple vendors
> could be used. There is no way in the DTS to specify multiple compatible
> chips.

It seems to be a convention to provide the name of the chip that's
actually used, in addition to the generic compatible.

One advantage I see is that specific properties can be enforced per-chip.
E.g. Infineon SLB9670 TPMs support an SPI clock of up to 43 MHz,
whereas Atmel ATTPM20P support 36 MHz.  The devicetree schema may
contain those maximum speeds and the validator can check whether
devicetrees observe them.

Similarly, a device driver may use chip-specific quirks based on the
compatible string.

Last not least, it is useful for documentation purposes to specify which
chip is used.

If chips are dual-sourced or triple-sourced, as you say, and they
behave identically, then I think it is fine to specify all of their
compatible strings plus the generic compatible.  If they do not
behave identically, separate devicetrees should be used for each
board version with a different chip.

As for specifying the generic compatible last, this follows from
section 2.3.1 of the devicetree specification:

   "The compatible property value consists of one or more strings
    that define the specific programming model for the device.
    This list of strings should be used by a client program for
    device driver selection. The property value consists of a
    concatenated list of null terminated strings, from most specific
    to most general."

    https://buildmedia.readthedocs.org/media/pdf/devicetree-specification/latest/devicetree-specification.pdf

Thanks,

Lukas
