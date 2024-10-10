From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Thu, 10 Oct 2024 03:07:13 +0000
Subject: [PATCH v5 3/3] clk: aspeed: add AST2700 clock driver.
In-Reply-To: <cc7faea42df6281a24360090d99cef8f99aa7736.camel@pengutronix.de>
References: <20241009060521.2971168-1-ryan_chen@aspeedtech.com>
	 <20241009060521.2971168-4-ryan_chen@aspeedtech.com>
 <cc7faea42df6281a24360090d99cef8f99aa7736.camel@pengutronix.de>
Message-ID: <OS8PR06MB75412523C3F28F07A32B8E28F2782@OS8PR06MB7541.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Subject: Re: [PATCH v5 3/3] clk: aspeed: add AST2700 clock driver.
> 
> On Mi, 2024-10-09 at 14:05 +0800, Ryan Chen wrote:
> > Add AST2700 clock controller driver and also use axiliary device
> > framework register the reset controller driver.
> > Due to clock and reset using the same register region.
> >
> > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > ---
> >  drivers/clk/Kconfig       |    8 +
> >  drivers/clk/Makefile      |    1 +
> >  drivers/clk/clk-ast2700.c | 1554
> > +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 1563 insertions(+)
> >  create mode 100644 drivers/clk/clk-ast2700.c
> >
> [...]
> > diff --git a/drivers/clk/clk-ast2700.c b/drivers/clk/clk-ast2700.c new
> > file mode 100644 index 000000000000..ef1f939b1c9f
> > --- /dev/null
> > +++ b/drivers/clk/clk-ast2700.c
> > @@ -0,0 +1,1554 @@
> [...]
> > +static void aspeed_reset_unregister_adev(void *_adev) {
> > +	struct auxiliary_device *adev = _adev;
> > +
> > +	auxiliary_device_delete(adev);
> > +	auxiliary_device_uninit(adev);
> > +}
> > +
> > +static void aspeed_reset_adev_release(struct device *dev) {
> > +	struct auxiliary_device *adev = to_auxiliary_dev(dev);
> > +
> > +	kfree(adev);
> > +}
> > +
> > +static int aspeed_reset_controller_register(struct device *clk_dev,
> > +					    void __iomem *base, const char *adev_name) {
> > +	struct auxiliary_device *adev;
> > +	int ret;
> > +
> > +	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
> > +	if (!adev)
> > +		return -ENOMEM;
> > +
> > +	adev->name = adev_name;
> > +	adev->dev.parent = clk_dev;
> > +	adev->dev.release = aspeed_reset_adev_release;
> > +	adev->id = 666u;
> > +
> > +	ret = auxiliary_device_init(adev);
> > +	if (ret) {
> > +		kfree(adev);
> > +		return ret;
> > +	}
> > +
> > +	ret = auxiliary_device_add(adev);
> > +	if (ret) {
> > +		auxiliary_device_uninit(adev);
> > +		return ret;
> > +	}
> > +
> > +	adev->dev.platform_data = (__force void *)base;
> > +
> > +	return devm_add_action_or_reset(clk_dev,
> > +aspeed_reset_unregister_adev, adev); }
> 
> Should this be moved into reset-aspeed.c?
If move to reset-aspeed.c that will have EXPORT_SYMBOL_GPL(aspeed_reset_controller_register);
And add one header ./drivers/reset/reset-aspeed.h. 
That is expected? Am I right?
> 
> regards
> Philipp
