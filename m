From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 07 May 2021 17:06:19 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_v3_5/5]_mmc:_sdhci-of-aspeed:_Assert/Deassert_reset?=
 =?UTF-8?Q?_signal_before_probing_eMMC?=
In-Reply-To: <20210507062416.GD23749@aspeedtech.com>
References: <20210506100312.1638-1-steven_lee@aspeedtech.com>
 <20210506100312.1638-6-steven_lee@aspeedtech.com>
 <20210506102458.GA20777@pengutronix.de>
 <19a81e25-dfa1-4ad3-9628-19f43f4230d2@www.fastmail.com>
 <20210507062416.GD23749@aspeedtech.com>
Message-ID: <2a339218-19d7-4eea-a734-8053dd553dbb@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 7 May 2021, at 15:54, Steven Lee wrote:
> The 05/07/2021 09:32, Andrew Jeffery wrote:
> > 
> > 
> > On Thu, 6 May 2021, at 19:54, Philipp Zabel wrote:
> > > Hi Steven,
> > > 
> > > On Thu, May 06, 2021 at 06:03:12PM +0800, Steven Lee wrote:
> > > > +	if (info) {
> > > > +		if (info->flag & PROBE_AFTER_ASSET_DEASSERT) {
> > > > +			sdc->rst = devm_reset_control_get(&pdev->dev, NULL);
> > > 
> > > Please use devm_reset_control_get_exclusive() or
> > > devm_reset_control_get_optional_exclusive().
> > > 
> > > > +			if (!IS_ERR(sdc->rst)) {
> > > 
> > > Please just return errors here instead of ignoring them.
> > > The reset_control_get_optional variants return NULL in case the
> > > device node doesn't contain a resets phandle, in case you really
> > > consider this reset to be optional even though the flag is set?
> > 
> > It feels like we should get rid of the flag and leave it to the 
> > devicetree.
> > 
> 
> Do you mean adding a flag, for instance, "mmc-reset" in the
> device tree and call of_property_read_bool() in aspeed_sdc_probe()?
> 
> > I'm still kind of surprised it's not something we want to do for the 
> > 2400 and 2500 as well.
> > 
> 
> Per discussion with the chip designer, AST2400 and AST2500 doesn't need
> this implementation since the chip design is different to AST2600.

So digging a bit more deeply on this, it looks like the reset is 
already taken care of by drivers/clk/clk-ast2600.c in the 
clk_prepare_enable() path.

clk-ast2600 handles resets when enabling the clock for most peripherals:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/clk-ast2600.c?h=v5.12#n276

and this is true for both the SD controller and the eMMC controller:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/clk-ast2600.c?h=v5.12#n94
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/clk-ast2600.c?h=v5.12#n88

If this weren't the case you'd specify a reset property in the SD/eMMC 
devicetree nodes for the 2600 and then use 
devm_reset_control_get_optional_exclusive() as Philipp suggested. See 
the reset binding here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/reset/reset.txt?h=v5.12

So on the surface it seems the reset handling in this patch is 
unnecessary. Have you observed an issue with the SoC that means it's 
required?

Andrew
