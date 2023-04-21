From: Andi Shyti <andi.shyti@kernel.org>
Date: Fri, 21 Apr 2023 02:05:29 +0200
Subject: [PATCH v10 2/2] i2c: aspeed: support ast2600 i2c new register
 mode driver
In-Reply-To: <20230415012848.1777768-3-ryan_chen@aspeedtech.com>
References: <20230415012848.1777768-1-ryan_chen@aspeedtech.com>
 <20230415012848.1777768-3-ryan_chen@aspeedtech.com>
Message-ID: <20230421000529.6awtnawqgbk5orcp@intel.intel>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Ryan,

On Sat, Apr 15, 2023 at 09:28:48AM +0800, Ryan Chen wrote:
> Add i2c new register mode driver to support AST2600 i2c
> new register mode. AST2600 i2c controller have legacy and
> new register mode. The new register mode have global register
> support 4 base clock for scl clock selection, and new clock
> divider mode. The i2c new register mode have separate register
> set to control i2c master and slave.

This commit message is a bit messy, could you please write it
more clear?

[...]

> +static int ast2600_i2c_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct device *dev = &pdev->dev;
> +	struct ast2600_i2c_bus *i2c_bus;
> +	struct resource *res;
> +	u32 global_ctrl;
> +	int ret = 0;
> +
> +	i2c_bus = devm_kzalloc(dev, sizeof(*i2c_bus), GFP_KERNEL);
> +	if (!i2c_bus)
> +		return -ENOMEM;

Let's use dev_err_probe whenever possible, at least we keep a
coherent style.

[...]

> +	ret = devm_request_irq(dev, i2c_bus->irq, ast2600_i2c_bus_irq, 0,
> +			       dev_name(dev), i2c_bus);

isn't it better to use threaded irq? You have quite an elaborate
irq handler, you may want to use a thread for it.

> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Unable to request irq %d\n", i2c_bus->irq);
> +
> +	if (of_property_read_bool(dev->of_node, "smbus-alert")) {
> +		i2c_bus->alert_enable = 1;

true;

alert_enable is boolean, make it bool.

> +		i2c_bus->ara = i2c_new_smbus_alert_device(&i2c_bus->adap, &i2c_bus->alert_data);
> +		if (!i2c_bus->ara)
> +			dev_warn(dev, "Failed to register ARA client\n");
> +
> +		writel(AST2600_I2CM_PKT_DONE | AST2600_I2CM_BUS_RECOVER | AST2600_I2CM_SMBUS_ALT,
> +		       i2c_bus->reg_base + AST2600_I2CM_IER);
> +	} else {
> +		i2c_bus->alert_enable = 0;

false;

I'm not going to review any further, please send the patch after
you have run checkpatch.pl on it. Thanks!

Andi
