From: Patrick Williams <patrick@stwcx.xyz>
Date: Fri, 22 Dec 2023 16:38:12 -0600
Subject: [PATCH v8] ARM: dts: aspeed: Adding Facebook Bletchley BMC
In-Reply-To: <20231220170012.GA10387@wunner.de>
References: <20231220080733.GA30641@wunner.de>
 <F444BFCC-1D44-4AF6-A0E1-B153A217FFE3@stwcx.xyz>
 <20231220170012.GA10387@wunner.de>
Message-ID: <ZYYP1C0h4ms9kEjA@heinlein.vulture-banana.ts.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

(cc'd TPM mailing list for awareness)

On Wed, Dec 20, 2023 at 06:00:12PM +0100, Lukas Wunner wrote:
> On Wed, Dec 20, 2023 at 06:38:59AM -0600, Patrick Williams wrote:
> > On Dec 20, 2023, at 2:07AM, Lukas Wunner <lukas@wunner.de> wrote:
> > > On Tue, Dec 07, 2021 at 05:49:24PM +0800, Howard Chiu wrote:
> > > > Initial introduction of Facebook Bletchley equipped with
> > > > Aspeed 2600 BMC SoC.
> > > [...]
> > > > +        tpmdev at 0 {
> > > > +            compatible = "tcg,tpm_tis-spi";
> > > 
> > > What's the chip used on this board?  Going forward, the DT schema for TPMs
> > > requires the exact chip name in addition to the generic "tcg,tpm_tis-spi".
> > 
> > Why is this a requirement?  This assumes there is exactly one chip.
> > TPMs are often placed on a pluggable module in which multiple vendors
> > could be used. There is no way in the DTS to specify multiple compatible
> > chips.
> 
> It seems to be a convention to provide the name of the chip that's
> actually used, in addition to the generic compatible.

My impression is that this is subsystem dependent.  The MTD SPI-NOR
subsystem, for example, does not want any compatible or additional devices
added and instead `compatible = "jedic,spi-nor"` is all you need.  The
subsystem does the SFDP detection of the specific device (and
parameters) [1].

> One advantage I see is that specific properties can be enforced per-chip.
> E.g. Infineon SLB9670 TPMs support an SPI clock of up to 43 MHz,
> whereas Atmel ATTPM20P support 36 MHz.  The devicetree schema may
> contain those maximum speeds and the validator can check whether
> devicetrees observe them.

Noble goal.

For the Aspeed SOC that we use to interact with the TPM module, the
hardware logic doesn't properly implement bi-directional access, so we
end up using the SPI-GPIO driver and running at speeds far far below any
device maximum (obviously this isn't everyone's problem).

> Similarly, a device driver may use chip-specific quirks based on the
> compatible string.

IMO, if a chip requires quirks in order to function properly then it
isn't compatible with "tcg,tpm_tis-spi" is it?  Standards exist for a
reason.  If a chip can't follow them, don't claim it does.

> Last not least, it is useful for documentation purposes to specify which
> chip is used.
> 
> If chips are dual-sourced or triple-sourced, as you say, and they
> behave identically, then I think it is fine to specify all of their
> compatible strings plus the generic compatible.  

This has explicitly been rejected before; having multiple incompatible
chips listed in the same compatible.  I've tried to search lore but I
can't find a reference unfortunately.  We've had similar scenarios with
second-source scenarios and have been told to: change the DTS in u-boot,
use user-space bind calls, or work with the DTS overlay project to get
that working.  Frankly, all of those options are a challenge for
something fundamental like the TPM.

Furthermore, what you're suggesting does not jive with what is in the
devicetree binding documentation for tpm_tis-spi [2]:

- compatible: should be **one** of the following (emphasis mine)

> If they do not
> behave identically, separate devicetrees should be used for each
> board version with a different chip.

I am not following how that would work in a reasonable way.  As I said,
these are pluggable modules and not simply second-source builds.  There
are a collection of modules that can all be plugged into the same header.
They might not even be shipped with the device...  You might want TPM
modules provisioned under control of your own process, rather than the
device manufacturer, and you plug them in prior to using the device.

The only way I can conceive of doing this is to have a good chunk of u-boot
code that detects which module is plugged in and manually modifies the
compatible string in the DTS before loading the kernel.  Of course,
doing this changes your measurements and has to be done in the CRTM,
both of which decrease your security posture.

1. https://lore.kernel.org/lkml/4817515e-2833-6d39-03c3-30470344ac3a at microchip.com/
2. https://github.com/torvalds/linux/blob/c0f65a7c112b3cfa691cead54bcf24d6cc2182b5/Documentation/devicetree/bindings/security/tpm/tpm_tis_spi.txt#L2

-- 
Patrick Williams
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20231222/b03720ca/attachment.sig>
