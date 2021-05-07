From: Steven Lee <steven_lee@aspeedtech.com>
Date: Fri, 7 May 2021 14:24:17 +0800
Subject: [PATCH v3 5/5] mmc: sdhci-of-aspeed: Assert/Deassert reset
 signal before probing eMMC
In-Reply-To: <19a81e25-dfa1-4ad3-9628-19f43f4230d2@www.fastmail.com>
References: <20210506100312.1638-1-steven_lee@aspeedtech.com>
 <20210506100312.1638-6-steven_lee@aspeedtech.com>
 <20210506102458.GA20777@pengutronix.de>
 <19a81e25-dfa1-4ad3-9628-19f43f4230d2@www.fastmail.com>
Message-ID: <20210507062416.GD23749@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The 05/07/2021 09:32, Andrew Jeffery wrote:
> 
> 
> On Thu, 6 May 2021, at 19:54, Philipp Zabel wrote:
> > Hi Steven,
> > 
> > On Thu, May 06, 2021 at 06:03:12PM +0800, Steven Lee wrote:
> > > +	if (info) {
> > > +		if (info->flag & PROBE_AFTER_ASSET_DEASSERT) {
> > > +			sdc->rst = devm_reset_control_get(&pdev->dev, NULL);
> > 
> > Please use devm_reset_control_get_exclusive() or
> > devm_reset_control_get_optional_exclusive().
> > 
> > > +			if (!IS_ERR(sdc->rst)) {
> > 
> > Please just return errors here instead of ignoring them.
> > The reset_control_get_optional variants return NULL in case the
> > device node doesn't contain a resets phandle, in case you really
> > consider this reset to be optional even though the flag is set?
> 
> It feels like we should get rid of the flag and leave it to the 
> devicetree.
> 

Do you mean adding a flag, for instance, "mmc-reset" in the
device tree and call of_property_read_bool() in aspeed_sdc_probe()?

> I'm still kind of surprised it's not something we want to do for the 
> 2400 and 2500 as well.
> 

Per discussion with the chip designer, AST2400 and AST2500 doesn't need
this implementation since the chip design is different to AST2600.

> Andrew
