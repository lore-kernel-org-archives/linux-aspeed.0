From: Wang, Haiyue <haiyue.wang@linux.intel.com>
Date: Fri, 23 Feb 2018 21:19:16 +0800
Subject: [PATCH arm/aspeed/ast2500 v2] eSPI: add ASPEED AST2500 eSPI
 driver to boot a host with PCH runs on eSPI
In-Reply-To: <1519381535.10722.99.camel@linux.intel.com>
References: <1519369459-12468-1-git-send-email-haiyue.wang@linux.intel.com>
 <1519381535.10722.99.camel@linux.intel.com>
Message-ID: <ae72a9ca-e506-5279-c1b3-114e4eec2be3@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On 2018-02-23 18:25, Andy Shevchenko wrote:
> On Fri, 2018-02-23 at 15:04 +0800, Haiyue Wang wrote:
>> When PCH works under eSPI mode, the PMC (Power Management Controller)
>> in
>> PCH is waiting for SUS_ACK from BMC after it alerts SUS_WARN. It is in
>> dead loop if no SUS_ACK assert. This is the basic requirement for the
>> BMC
>> works as eSPI slave.
> So, do we have an agreement that the driver should go in this shape w/o
> interacting with SPI subsystem?
Not sure, I've added the specification of eSPI, hope people don't feel 
confused with SPI. :-)
> Also few comments below.
>
>> +config ASPEED_ESPI_SLAVE
>> +	depends on (ARCH_ASPEED || COMPILE_TEST) && REGMAP_MMIO
> I would rather split this to two
> 	depends on REGMAP_MMIO
> 	depends on ARCH_ASPEED || COMPILE_TEST
OK, it looks clean. I referred to:
config ASPEED_LPC_CTRL
         depends on (ARCH_ASPEED || COMPILE_TEST) && REGMAP && MFD_SYSCON

>> +	tristate "Aspeed ast2500 eSPI slave device driver"
>> +	---help---
>> +	  Control Aspeed ast2500 eSPI slave controller to handle
>> event
>> +	  which needs the firmware's processing.
>> +#include <linux/of.h>
> What exactly requires this header?
Oh, I ctrl+c / ctrl+v from other device tree usage module. :-(
Remove it now. Thanks for making the code more clean.
>> +static int aspeed_espi_slave_probe(struct platform_device *pdev)
>> +{
>> +	struct aspeed_espi_slave_data *priv;
>> +	struct device *dev = &pdev->dev;
>> +	struct resource *res;
>> +	void __iomem *regs;
>> +	int rc;
>> +
>> +	dev_set_name(dev, DEVICE_NAME);
> Do this after checks and memory allocations.
Fixed!
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	regs = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(regs))
>> +		return PTR_ERR(regs);
>> +
>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	priv->map = devm_regmap_init_mmio(dev, regs,
>> &espi_slave_regmap_cfg);
>> +	if (IS_ERR(priv->map))
>> +		return PTR_ERR(priv->map);
>> +
>> +static const struct of_device_id of_espi_slave_match_table[] = {
>> +	{ .compatible = "aspeed,ast2500-espi-slave" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, of_espi_slave_match_table);
> This one should be closer to the struct of_device_id.
Fixed.

