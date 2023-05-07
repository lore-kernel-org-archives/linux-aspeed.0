From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Sun, 7 May 2023 02:21:10 +0000
Subject: [PATCH v11 2/2] i2c: aspeed: support ast2600 i2c new register
 mode driver
In-Reply-To: <ZFFzRL/+73Ftix4Q@smile.fi.intel.com>
References: <20230430041712.3247998-1-ryan_chen@aspeedtech.com>
 <20230430041712.3247998-3-ryan_chen@aspeedtech.com>
 <ZFFzRL/+73Ftix4Q@smile.fi.intel.com>
Message-ID: <SEZPR06MB526906C3DAFFE0A8FA924AA7F2709@SEZPR06MB5269.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Andy,
> 
> On Sun, Apr 30, 2023 at 12:17:12PM +0800, Ryan Chen wrote:
> > Add i2c new register mode driver to support AST2600 i2c new register
> > mode. AST2600 i2c controller have legacy and new register mode. The
> > new register mode have global register support 4 base clock for scl
> > clock selection, and new clock divider mode. The i2c new register mode
> > have separate register set to control i2c master and slave.
> 
> ...
> 
> > +#include <linux/clk.h>
> > +#include <linux/err.h>
> > +#include <linux/i2c.h>
> > +#include <linux/io.h>
> > +#include <linux/slab.h>
> > +#include <linux/delay.h>
> > +#include <linux/reset.h>
> > +#include <linux/module.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/completion.h>
> > +#include <linux/of.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/regmap.h>
> > +#include <linux/of_device.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/i2c-smbus.h>
> 
> Ordered?
Update by alphabetical order

#include <linux/clk.h>
#include <linux/completion.h>
#include <linux/delay.h>
#include <linux/dma-mapping.h>
#include <linux/err.h>
#include <linux/i2c.h>
#include <linux/i2c-smbus.h>
#include <linux/interrupt.h>
#include <linux/io.h>
#include <linux/mfd/syscon.h>
#include <linux/module.h>
#include <linux/of.h>
#include <linux/of_device.h>
#include <linux/of_irq.h>
#include <linux/regmap.h>
#include <linux/reset.h>
#include <linux/slab.h>
> ...
> 
> > +#define AST2600_GLOBAL_INIT				\
> > +			(AST2600_I2CG_CTRL_NEW_REG |	\
> > +			AST2600_I2CG_CTRL_NEW_CLK_DIV)
> 
> Make just a one TAB and put the last two lines on the single one.

Update by following. 

#define AST2600_GLOBAL_INIT		\
	(AST2600_I2CG_CTRL_NEW_REG |	\
	 AST2600_I2CG_CTRL_NEW_CLK_DIV)
> ...
> 
> > +#define I2CCG_DIV_CTRL 0xC6411208
> 
> Is it decimal? Is it combination of bitfields? Can you add a comment what is
> this magic?
> 
This have been comment in previous line. I will move above of this magic code.
/*
 * APB clk : 100Mhz
 * div	: scl		: baseclk [APB/((div/2) + 1)] : tBuf [1/bclk * 16]
 * I2CG10[31:24] base clk4 for i2c auto recovery timeout counter (0xC6)
 * I2CG10[23:16] base clk3 for Standard-mode (100Khz) min tBuf 4.7us
 * 0x3c : 100.8Khz	: 3.225Mhz					  : 4.96us
 * 0x3d : 99.2Khz	: 3.174Mhz					  : 5.04us
 * 0x3e : 97.65Khz	: 3.125Mhz					  : 5.12us
 * 0x40 : 97.75Khz	: 3.03Mhz					  : 5.28us
 * 0x41 : 99.5Khz	: 2.98Mhz					  : 5.36us (default)
 * I2CG10[15:8] base clk2 for Fast-mode (400Khz) min tBuf 1.3us
 * 0x12 : 400Khz	: 10Mhz						  : 1.6us
 * I2CG10[7:0] base clk1 for Fast-mode Plus (1Mhz) min tBuf 0.5us
 * 0x08 : 1Mhz		: 20Mhz						  : 0.8us
 */
> ...
> 
> > +struct ast2600_i2c_timing_table {
> > +	u32 divisor;
> > +	u32 timing;
> > +};
> 
> Is it even used?
> 
Will remove. 
> ...
> 
> > +enum xfer_mode {
> > +	BYTE_MODE = 0,
> 
> Why explicit assignment?

Will remove.
> 
> > +	BUFF_MODE,
> > +	DMA_MODE,
> > +};
> 
> ...
> 
> > +	base_clk1 = (i2c_bus->apb_clk * 10) / ((((clk_div_reg & 0xff) + 2) * 10) /
> 2);
> > +	base_clk2 = (i2c_bus->apb_clk * 10) /
> > +			(((((clk_div_reg >> 8) & 0xff) + 2) * 10) / 2);
> > +	base_clk3 = (i2c_bus->apb_clk * 10) /
> > +			(((((clk_div_reg >> 16) & 0xff) + 2) * 10) / 2);
> > +	base_clk4 = (i2c_bus->apb_clk * 10) /
> > +			(((((clk_div_reg >> 24) & 0xff) + 2) * 10) / 2);
> 
> The same equation is used per each byte of clk_div_reg? Can it be rewritten to
> avoid this and using loop, so you will have an array of base_clk to be filled?
> 
> Don't forget to use GENMASK().
> 
Will update for loop.
	for (i = 0; i < AST2600_NUM_CLK_DIV_BYTES; i++) {
		u32 byte_val = (clk_div_reg >> (i * 8)) & GENMASK(7, 0);
		base_clk[i] = (i2c_bus->apb_clk * 10) / ((byte_val + 2) * 5);
	}
> ...
> 
> > +	if ((i2c_bus->apb_clk / i2c_bus->bus_frequency) <= 32) {
> > +		baseclk_idx = 0;
> > +		divisor = DIV_ROUND_UP(i2c_bus->apb_clk,
> i2c_bus->bus_frequency);
> > +	} else if ((base_clk1 / i2c_bus->bus_frequency) <= 32) {
> > +		baseclk_idx = 1;
> > +		divisor = DIV_ROUND_UP(base_clk1, i2c_bus->bus_frequency);
> > +	} else if ((base_clk2 / i2c_bus->bus_frequency) <= 32) {
> > +		baseclk_idx = 2;
> > +		divisor = DIV_ROUND_UP(base_clk2, i2c_bus->bus_frequency);
> > +	} else if ((base_clk3 / i2c_bus->bus_frequency) <= 32) {
> > +		baseclk_idx = 3;
> > +		divisor = DIV_ROUND_UP(base_clk3, i2c_bus->bus_frequency);
> 
> Will be optimized with above suggestion, I believe.

Will up with previous
> 
> > +	} else {
> > +		baseclk_idx = 4;
> > +		divisor = DIV_ROUND_UP(base_clk4, i2c_bus->bus_frequency);
> > +		inc = 0;
> > +		while ((divisor + inc) > 32) {
> > +			inc |= divisor & 0x1;
> > +			divisor >>= 1;
> > +			baseclk_idx++;
> > +		}
> > +		divisor += inc;
> 
> I think the above loop can be rewritten to have better representation.
> 
Will up with previous

> > +	}
> 
> ...
> 
> > +	baseclk_idx &= 0xf;
> 
> GENMASK()?
> 
Will update 
> ...
> 
> > +	scl_low = ((divisor * 9) / 16) - 1;
> > +	scl_low = min_t(u32, scl_low, 0xf);
> 
> This can be done in one line. Also, why not 15?
> 
> ...
> 
> > +	scl_high = (divisor - scl_low - 2) & 0xf;
> 
> GENMASK()?
Will update

> 
> ...
> 
> > +	data = ((scl_high - 1) << 20) | (scl_high << 16) | (scl_low << 12) |
> > +(baseclk_idx);
> 
> Too many parentheses.
Update to 
data = ((scl_high - 1) << 20) | (scl_high << 16) | (scl_low << 12) | baseclk_idx;

> 
> ...
> 
> > +	/* due to master slave is common buffer, so need force the master stop
> not issue */
> > +	if (readl(i2c_bus->reg_base + AST2600_I2CM_CMD_STS) & 0xffff) {
> 
> GENMASK() ?
> 
> > +		writel(0, i2c_bus->reg_base + AST2600_I2CM_CMD_STS);
> > +		i2c_bus->cmd_err = -EBUSY;
> > +		writel(0, i2c_bus->reg_base + AST2600_I2CC_BUFF_CTRL);
> > +		complete(&i2c_bus->cmd_complete);
> > +	}
> 
> ...
> 
> > +	/* send start */
> > +	dev_dbg(i2c_bus->dev, "[%d] %sing %d byte%s %s 0x%02x\n",
> > +		i2c_bus->msgs_index, msg->flags & I2C_M_RD ? "read" : "write",
> 
> str_read_write() ?
Sorry do you mean there have a function call str_read_write?
Can you point me where it is for refer?
> 
> > +		msg->len, msg->len > 1 ? "s" : "",
> > +		msg->flags & I2C_M_RD ? "from" : "to", msg->addr);
> 
> ...
> 
> > +				for (i = 0; i < xfer_len; i++) {
> > +					wbuf[i % 4] = msg->buf[i];
> > +					if (i % 4 == 3)
> > +						writel(*(u32 *)wbuf, i2c_bus->buf_base + i - 3);
> 
> Err.. There can be alignment issues.

Will update
> 
> > +				}
> > +				if (--i % 4 != 3)
> > +					writel(*(u32 *)wbuf, i2c_bus->buf_base + i - (i % 4));
> 
> The above code is ugly. Can you think about it and write in a better way?
Sorry, that is because the register only support for 4 byte align write.
That the reason I need put for byte write to 4 byte align write.
> 
> ...
> 
> > +				for (i = 0; i < xfer_len; i++) {
> > +					wbuf[i % 4] = msg->buf[i2c_bus->master_xfer_cnt + i];
> > +					if (i % 4 == 3)
> > +						writel(*(u32 *)wbuf, i2c_bus->buf_base + i - 3);
> > +				}
> > +				if (--i % 4 != 3)
> > +					writel(*(u32 *)wbuf, i2c_bus->buf_base + i - (i % 4));
> 
> Ditto.
Will update

> 
> ...
> 
> Do you have similar code pieces? Why not doing it in a separate function with
> parameters?
> 
I will think it to be MICRO function call.
> ...
> 
> > +	return ast2600_i2c_master_irq(i2c_bus) ? IRQ_HANDLED : IRQ_NONE;
> 
> IRQ_RETVAL() ?
Sorry, most return is handled or not handled.
Do you mean replace it just " return IRQ_RETVAL(ret);"

> 
> ...
> 
> > +	writel(0xfffffff, i2c_bus->reg_base + AST2600_I2CM_ISR);
> 
> GENMASK()
> 
Will Update
> ...
> 
> > +	writel(0xfffffff, i2c_bus->reg_base + AST2600_I2CS_ISR);
> 
> Ditto.
Will Update
> 
> > +	if (i2c_bus->mode == BYTE_MODE) {
> > +		writel(0xffff, i2c_bus->reg_base + AST2600_I2CS_IER);
> 
> Ditto.
Will Update
> 
> > +	} else {
> > +		/* Set interrupt generation of I2C slave controller */
> > +		writel(AST2600_I2CS_PKT_DONE, i2c_bus->reg_base +
> AST2600_I2CS_IER);
> > +	}
> 
> ...
> 
> > +	WARN_ON(!i2c_bus->slave);
> 
> Why?
It can be removed. 
> 
> ...
> 
> > +static const struct of_device_id ast2600_i2c_bus_of_table[] = {
> > +	{
> > +		.compatible = "aspeed,ast2600-i2cv2",
> > +	},
> > +	{}
> > +};
> 
> > +
> 
> Redundant blank line.
Will removed.
> 
> > +MODULE_DEVICE_TABLE(of, ast2600_i2c_bus_of_table);
> 
> ...
> 
> > +	i2c_bus = devm_kzalloc(dev, sizeof(*i2c_bus), GFP_KERNEL);
> > +	if (!i2c_bus)
> > +		return dev_err_probe(dev, -ENOMEM, "no memory allocated\n");
> 
> No. We do not print error message for ENOMEM.
> You homework to find why.
> 
Got it, will update.

> ...
> 
> > +	if (of_property_read_bool(pdev->dev.of_node, "aspeed,enable-dma"))
> 
> device_property_read_bool() ?
> 
> > +		i2c_bus->mode = DMA_MODE;
> 
> ...
> 
> > +	if (i2c_bus->mode == BUFF_MODE) {
> > +		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > +		if (res && resource_size(res) >= 2) {
> > +			i2c_bus->buf_base = devm_ioremap_resource(dev, res);
> > +
> > +			if (!IS_ERR_OR_NULL(i2c_bus->buf_base))
> > +				i2c_bus->buf_size = resource_size(res) / 2;
> > +		} else {
> > +			i2c_bus->mode = BYTE_MODE;
> > +		}
> > +	}
> 
> Can be done without additional checks and with a simple call to
> devm_platform_ioremap_resource(). No?
> 
Sorry, I can't catch your point, can you guide me more about it?
> ...
> 
> > +	/* i2c timeout counter: use base clk4 1Mhz,
> > +	 * per unit: 1/(1000/4096) = 4096us
> > +	 */
> 
> Wrong multi-line style of the comment.
> 
Will update to
/*
 * i2c timeout counter: use base clk4 1Mhz,
 * per unit: 1/(1000/4096) = 4096us
 */
> ...
> 
> > +	ret = of_property_read_u32(dev->of_node,
> > +				   "i2c-scl-clk-low-timeout-us",
> > +				   &i2c_bus->timeout);
> > +	if (!ret)
> > +		i2c_bus->timeout /= 4096;
> 
> What is this and why I2C core timings (standard) can't be utilized here?
It is scl clk timout setting. That have been discuss with following.
https://lore.kernel.org/lkml/20230314221614.24205-1-andi.shyti at kernel.org/T/

> 
> ...
> 
> > +	ret = of_property_read_u32(dev->of_node, "clock-frequency",
> &i2c_bus->bus_frequency);
> > +	if (ret < 0) {
> > +		dev_warn(dev, "Could not read clock-frequency property\n");
> > +		i2c_bus->bus_frequency = 100000;
> > +	}
> 
> There are macro for standard speeds. Moreover, there is a function to parse
> properties, no need to open code.
> 
Will update
ret = of_property_read_u32(dev->of_node, "clock-frequency", &bus_freq);
if (ret < 0) {
    dev_warn(dev, "Could not read clock-frequency property\n");
    i2c_bus->bus_frequency = I2C_SPEED_STANDARD;
} else {
    i2c_bus->bus_frequency = bus_freq;
}
> ...
> 
> > +	i2c_bus->adap.dev.of_node = dev->of_node;
> 
> device_set_node()
> 
> ...
> 
> > +	if (of_property_read_bool(dev->of_node, "smbus-alert")) {
> 
> Doesn't core have already support for this?
Will remove it. 
> 
> > +		i2c_bus->alert_enable = true;
> > +		i2c_bus->ara = i2c_new_smbus_alert_device(&i2c_bus->adap,
> &i2c_bus->alert_data);
> > +		if (!i2c_bus->ara)
> > +			dev_warn(dev, "Failed to register ARA client\n");
> > +
> > +		writel(AST2600_I2CM_PKT_DONE | AST2600_I2CM_BUS_RECOVER |
> AST2600_I2CM_SMBUS_ALT,
> > +		       i2c_bus->reg_base + AST2600_I2CM_IER);
> > +	} else {
> > +		i2c_bus->alert_enable = false;
> > +		/* Set interrupt generation of I2C master controller */
> > +		writel(AST2600_I2CM_PKT_DONE | AST2600_I2CM_BUS_RECOVER,
> > +		       i2c_bus->reg_base + AST2600_I2CM_IER);
> > +	}
> 
> ...
> 
> > +	dev_info(dev, "%s [%d]: adapter [%d khz] mode [%d]\n",
> > +		 dev->of_node->name, i2c_bus->adap.nr, i2c_bus->bus_frequency /
> 1000,
> > +		 i2c_bus->mode);
> 
> Useless noise.
> 
Will remove it.

Thanks your review.

Best Regards,
Ryan Chen.
