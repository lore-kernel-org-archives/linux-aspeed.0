From: Tao Ren <rentao.bupt@gmail.com>
Date: Tue, 2 Jan 2024 16:11:28 -0800
Subject: [PATCH v2 3/6] ARM: dts: aspeed: Common dtsi for Facebook
 AST2600 Network BMCs
In-Reply-To: <20231220081402.GA3831@wunner.de>
References: <20210805222818.8391-1-rentao.bupt@gmail.com>
 <20210805222818.8391-4-rentao.bupt@gmail.com>
 <20231220081402.GA3831@wunner.de>
Message-ID: <ZZSmMJ//l972Qbxu@fedora>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Lukas,

On Wed, Dec 20, 2023 at 09:14:02AM +0100, Lukas Wunner wrote:
> On Thu, Aug 05, 2021 at 03:28:15PM -0700, rentao.bupt at gmail.com wrote:
> > This common descirption is included by all Facebook AST2600 Network BMC
> > platforms to minimize duplicated device entries across Facebook Network
> > BMC device trees.
> [...]
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi
> [...]
> > +		tpmdev at 0 {
> > +			compatible = "tcg,tpm_tis-spi";
> 
> What's the chip used on this board?  Going forward, the DT schema for TPMs
> requires the exact chip name in addition to the generic "tcg,tpm_tis-spi".

Sorry about the late response. It's "infineon,slb9670", and I will
submit a patch for fix it soon.


Cheers,

- Tao
