From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 23 Dec 2023 09:36:23 +0100
Subject: [PATCH v8] ARM: dts: aspeed: Adding Facebook Bletchley BMC
In-Reply-To: <ZYYP1C0h4ms9kEjA@heinlein.vulture-banana.ts.net>
References: <20231220080733.GA30641@wunner.de>
 <F444BFCC-1D44-4AF6-A0E1-B153A217FFE3@stwcx.xyz>
 <20231220170012.GA10387@wunner.de>
 <ZYYP1C0h4ms9kEjA@heinlein.vulture-banana.ts.net>
Message-ID: <20231223083623.GA17734@wunner.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Dec 22, 2023 at 04:38:12PM -0600, Patrick Williams wrote:
> On Wed, Dec 20, 2023 at 06:00:12PM +0100, Lukas Wunner wrote:
> > If chips are dual-sourced or triple-sourced, as you say, and they
> > behave identically, then I think it is fine to specify all of their
> > compatible strings plus the generic compatible.  
> 
> This has explicitly been rejected before; having multiple incompatible
> chips listed in the same compatible.  I've tried to search lore but I
> can't find a reference unfortunately.

I'll let devicetree maintainers comment on that.


> Furthermore, what you're suggesting does not jive with what is in the
> devicetree binding documentation for tpm_tis-spi [2]:
> 
> - compatible: should be **one** of the following (emphasis mine)

That's superseded by:

https://lore.kernel.org/all/cover.1702806810.git.lukas at wunner.de/

I don't really have a dog in this fight, I merely stepped up to
convert TPM DT bindings to YAML.  There have been multiple attempts
to convert them in the past but none of them have been pursued into
mainline.

I looked at compatible string usage in arch/arm{,64}/boot/dts
and was under the impression that the majority of devicetrees
use a combo matching this pattern:
"vendor,chip", "tcg,tpm[_-]tis-{spi,i2c,mmio}"

So that's what I went for in the conversion.  It would be inconsistent
to enforce a generic compatible for i2c and mmio, but not for spi.

I ran the validator against all arm/arm64 devicetrees and there are
four devicetrees which only use a generic compatible and not a
"vendor,chip" compatible:
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
arch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi
arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts
arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi

So, three Aspeed Facebook and one Moxa.  There's a fifth case (phyTEC)
but the devicetree author clarified it's an Infineon SLB9670.
The authors of the other four devicetrees listed above did not respond.

Patches to fix up schema violations are here:
https://github.com/l1k/linux/commit/7813a455ed15393df7d9d353173635b98ae23387
https://github.com/l1k/linux/commit/a958be44952b1de170100be1007780a72ce7d861


> As I said,
> these are pluggable modules and not simply second-source builds.  There
> are a collection of modules that can all be plugged into the same header.
> They might not even be shipped with the device...

If those TPM modules might not even be plugged in or are interchangeable,
I think they ought to be represented as DT overlays.

Honestly I'm wondering how common the scenario you're describing is.
If it's an edge case, it might not be worth holding up the YAML
conversion because of it.  The missing YAML conversion is a constant
cause of pain for a lot of people.

Thanks,

Lukas
