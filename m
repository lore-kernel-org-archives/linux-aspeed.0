From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 3 Jan 2024 13:45:02 +0100
Subject: [PATCH v2 3/6] ARM: dts: aspeed: Common dtsi for Facebook
 AST2600 Network BMCs
In-Reply-To: <ZZSmMJ//l972Qbxu@fedora>
References: <20210805222818.8391-1-rentao.bupt@gmail.com>
 <20210805222818.8391-4-rentao.bupt@gmail.com>
 <20231220081402.GA3831@wunner.de>
 <ZZSmMJ//l972Qbxu@fedora>
Message-ID: <20240103124502.GB23899@wunner.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jan 02, 2024 at 04:11:28PM -0800, Tao Ren wrote:
> On Wed, Dec 20, 2023 at 09:14:02AM +0100, Lukas Wunner wrote:
> > On Thu, Aug 05, 2021 at 03:28:15PM -0700, rentao.bupt at gmail.com wrote:
> > > This common descirption is included by all Facebook AST2600 Network BMC
> > > platforms to minimize duplicated device entries across Facebook Network
> > > BMC device trees.
> > [...]
> > > --- /dev/null
> > > +++ b/arch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi
> > [...]
> > > +		tpmdev at 0 {
> > > +			compatible = "tcg,tpm_tis-spi";
> > 
> > What's the chip used on this board?  Going forward, the DT schema for TPMs
> > requires the exact chip name in addition to the generic "tcg,tpm_tis-spi".
> 
> Sorry about the late response. It's "infineon,slb9670", and I will
> submit a patch for fix it soon.

Thank you Tao and Patrick for the replies.  I've prepared two commits
to fix all violations of the TPM schema on this branch:

  https://github.com/l1k/linux/commits/tpm-dt3

The commits are named:

  e95bdbc arm64: dts: Fix TPM schema violations
  63e5dfd ARM: dts: Fix TPM schema violations

I've now amended the ARM commit to use "infineon,slb9670" for:

  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
  arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi

I intend to submit the two commits once the TPM schema is applied
either to Jarkko's or Rob's tree:

  https://lore.kernel.org/all/20231220160422.GA282877-robh at kernel.org/

Thanks,

Lukas
