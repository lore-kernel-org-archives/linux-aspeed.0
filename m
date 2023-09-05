From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Tue, 5 Sep 2023 06:52:37 +0000
Subject: [PATCH v12 2/2] i2c: aspeed: support ast2600 i2c new register
 mode driver
In-Reply-To: <ZLENe5B3gi/oNTQp@smile.fi.intel.com>
References: <20230714074522.23827-1-ryan_chen@aspeedtech.com>
 <20230714074522.23827-3-ryan_chen@aspeedtech.com>
 <ZLENe5B3gi/oNTQp@smile.fi.intel.com>
Message-ID: <SEZPR06MB5269831E049E2267661F181FF2E8A@SEZPR06MB5269.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Andy,
	Sorry for overquoting, I reply with historical.


> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Friday, July 14, 2023 4:55 PM
> To: Ryan Chen <ryan_chen@aspeedtech.com>
> Cc: jk at codeconstruct.com.au; Brendan Higgins <brendan.higgins@linux.dev>;
> Benjamin Herrenschmidt <benh@kernel.crashing.org>; Joel Stanley
> <joel@jms.id.au>; Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Andrew Jeffery <andrew@aj.id.au>;
> Philipp Zabel <p.zabel@pengutronix.de>; Wolfram Sang <wsa@kernel.org>;
> linux-i2c at vger.kernel.org; Florian Fainelli <f.fainelli@gmail.com>; Jean
> Delvare <jdelvare@suse.de>; William Zhang <william.zhang@broadcom.com>;
> Tyrone Ting <kfting@nuvoton.com>; Tharun Kumar P
> <tharunkumar.pasumarthi@microchip.com>; Conor Dooley
> <conor.dooley@microchip.com>; Phil Edworthy <phil.edworthy@renesas.com>;
> openbmc at lists.ozlabs.org; devicetree at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-aspeed at lists.ozlabs.org;
> =linux-kernel at vger.kernel.org; Andi Shyti <andi.shyti@kernel.org>
> Subject: Re: [PATCH v12 2/2] i2c: aspeed: support ast2600 i2c new register
> mode driver
> 
> On Fri, Jul 14, 2023 at 03:45:22PM +0800, Ryan Chen wrote:
> > Add i2c new register mode driver to support AST2600 i2c new register
> > mode. AST2600 i2c controller have legacy and new register mode. The
> > new register mode have global register support 4 base clock for scl
> > clock selection, and new clock divider mode. The i2c new register mode
> > have separate register set to control i2c master and slave.
> 
> ...
> 
> + bits.h
> 
> > +#include <linux/clk.h>
> > +#include <linux/completion.h>
> > +#include <linux/delay.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/err.h>
> > +#include <linux/i2c.h>
> > +#include <linux/i2c-smbus.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/mfd/syscon.h>
> 
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_irq.h>
> 
> You missed property.h
> and these of*.h probably not needed at all, see below.
> 
> > +#include <linux/regmap.h>
> > +#include <linux/reset.h>
> > +#include <linux/slab.h>
> > +#include <linux/string_helpers.h>
> 
> ...

Modify with following.

#include <linux/bits.h>
#include <linux/clk.h>
#include <linux/completion.h>
#include <linux/delay.h>
#include <linux/dma-mapping.h>
#include <linux/err.h>
#include <linux/i2c.h>
#include <linux/i2c-smbus.h>
#include <linux/interrupt.h>
#include <linux/io.h>
#include <linux/module.h>
#include <linux/mfd/syscon.h>
#include <linux/platform_device.h>
#include <linux/property.h>
#include <linux/regmap.h>
#include <linux/reset.h>
#include <linux/slab.h>
#include <linux/string_helpers.h>


> 
> > +#define AST2600_I2CC_GET_RX_BUFF(x)			(((x) >> 8) &
> GENMASK(7, 0))
> 
> > +#define AST2600_I2CC_GET_RX_BUF_LEN(x)		(((x) >> 24) &
> GENMASK(5, 0))
> 
> > +#define AST2600_I2CC_GET_TX_BUF_LEN(x)		((((x) >> 8) &
> GENMASK(4, 0)) + 1)
> 
> With right shifts it's better to have GENMASK to be applied first, it will show
> exact MSB of the bitfield.
> 
> (Ditto for other cases similar to these)
> 
> ...
It will update next version.
#define AST2600_I2CC_GET_RX_BUF_LEN(x)      (((x) & GENMASK(29, 24)) >> 24)
#define AST2600_I2CC_GET_TX_BUF_LEN(x)      ((((x) & GENMASK(12, 8)) >> 8) + 1)

> 
> > +static u32 ast2600_select_i2c_clock(struct ast2600_i2c_bus *i2c_bus)
> > +{
> > +	unsigned long base_clk[4];
> > +	int baseclk_idx;
> > +	u32 clk_div_reg;
> > +	u32 scl_low;
> > +	u32 scl_high;
> > +	int divisor;
> > +	int inc = 0;
> > +	u32 data;
> > +
> > +	regmap_read(i2c_bus->global_regs, AST2600_I2CG_CLK_DIV_CTRL,
> &clk_div_reg);
> > +	for (int i = 0; i < 4; i++) {
> 
> See below.
> 
> > +		base_clk[i] = (i2c_bus->apb_clk * 10) /
> > +		(((((clk_div_reg >> (i * 8)) & GENMASK(7, 0)) + 2) * 10) / 2);
> 
> Second line is wrongly indented.
> 
> > +	}
> 
> > +	if ((i2c_bus->apb_clk / i2c_bus->bus_frequency) <= 32) {
> > +		baseclk_idx = 0;
> > +		divisor = DIV_ROUND_UP(i2c_bus->apb_clk,
> i2c_bus->bus_frequency);
> > +	} else {
> 
> > +		int i;
> > +
> 
> Just add to the definition block:
> 
> 	unsigned int i;
> 
> > +		for (i = 0; i < 4; i++) {
> > +			if ((base_clk[i] / i2c_bus->bus_frequency) <= 32) {
> 
> > +				baseclk_idx = i + 1;
> > +				divisor = DIV_ROUND_UP(base_clk[i],
> i2c_bus->bus_frequency);
> 
> These two can be moved outside of the loop
> 
> > +				break;
> > +			}
> 
> 			if ((base_clk[i] / i2c_bus->bus_frequency) <= 32)
> 				break;
> 
> > +		}
> > +		if (i == 4) {
> > +			baseclk_idx = 4;
> > +			divisor = DIV_ROUND_UP(base_clk[3],
> i2c_bus->bus_frequency);
> 
> > +			while ((divisor + inc) > 32) {
> > +				inc |= divisor & 0x1;
> > +				divisor >>= 1;
> 
> 	unsigned long divisor;
> 
> 			for_each_set_bit(divisor, ...)
> 
> I.o.w. think about this, maybe you can refactor with the above.
> 
> > +				baseclk_idx++;
> > +			}
> > +			divisor += inc;
> 
> 		} else {
> 			...those two lines...
> 
> > +		}
> 
> > +	}
> > +
> > +	divisor = min_t(int, divisor, 32);
> > +	baseclk_idx &= GENMASK(3, 0);
> 
> > +	scl_low = ((divisor * 9) / 16) - 1;
> > +	scl_low = min_t(u32, scl_low, GENMASK(3, 0));
> 
> (with the divisor being unsigned long) this can be rewritten as
> 
> 	scl_low = min(divisor * 9 / 16 - 1, GENMASK(3, 0));
> 
> which improves type checking and readability.
> 
> > +	scl_high = (divisor - scl_low - 2) & GENMASK(3, 0);
> > +	data = (scl_high - 1) << 20 | scl_high << 16 | scl_low << 12 |
> > +baseclk_idx;
> > +
> > +	if (i2c_bus->timeout) {
> > +		data |= AST2600_I2CC_TOUTBASECLK(AST_I2C_TIMEOUT_CLK);
> > +		data |= AST2600_I2CC_TTIMEOUT(i2c_bus->timeout);
> > +	}
> > +
> > +	return data;
> > +}
> 
> ...
> 
Upon will update in following 

static u32 ast2600_select_i2c_clock(struct ast2600_i2c_bus *i2c_bus)
{
	unsigned long base_clk[4];
	unsigned long divisor;
	int baseclk_idx;
	u32 clk_div_reg;
	u32 scl_low;
	u32 scl_high;
	u32 data;


	regmap_read(i2c_bus->global_regs, AST2600_I2CG_CLK_DIV_CTRL, &clk_div_reg);
	for (int i = 0; i < 4; i++) {
		base_clk[i] = (i2c_bus->apb_clk * 2) /
			(((clk_div_reg >> (i * 8)) & GENMASK(7, 0)) + 2);
	}

	if ((i2c_bus->apb_clk / i2c_bus->timing_info.bus_freq_hz) <= 32) {
		baseclk_idx = 0;
		divisor = DIV_ROUND_UP(i2c_bus->apb_clk, i2c_bus->timing_info.bus_freq_hz);
	} else {
		unsigned int i;

		for (i = 0; i < 4; i++) {
			if ((base_clk[i] / i2c_bus->timing_info.bus_freq_hz) <= 32)
				break;
		}
		if (i == 4) {
			baseclk_idx = 4;
			divisor = DIV_ROUND_UP(base_clk[3], i2c_bus->timing_info.bus_freq_hz);
			for_each_set_bit(divisor, &divisor, 32) {
				if ((divisor + 1) <= 32)
					break;
				divisor >>= 1;
				baseclk_idx++;
			}
		} else {
			baseclk_idx = i + 1;
			divisor = DIV_ROUND_UP(base_clk[i], i2c_bus->timing_info.bus_freq_hz);
		}
	}

	divisor = min_t(unsigned long, divisor, 32);
	baseclk_idx &= GENMASK(3, 0);
	scl_low = min(divisor * 9 / 16 - 1, GENMASK(3, 0));
	scl_high = (divisor - scl_low - 2) & GENMASK(3, 0);
	data = (scl_high - 1) << 20 | scl_high << 16 | scl_low << 12 | baseclk_idx;
	if (i2c_bus->timeout) {
		data |= AST2600_I2CC_TOUTBASECLK(AST_I2C_TIMEOUT_CLK);
		data |= AST2600_I2CC_TTIMEOUT(i2c_bus->timeout);
	}

	return data;
}

> > +static u8 ast2600_i2c_recover_bus(struct ast2600_i2c_bus *i2c_bus) {
> > +	int ret = 0;
> > +	u32 ctrl;
> > +	u32 state;
> > +	int r;
> 
> > +	dev_dbg(i2c_bus->dev, "%d-bus recovery bus [%x]\n", i2c_bus->adap.nr,
> > +		readl(i2c_bus->reg_base + AST2600_I2CC_STS_AND_BUFF));
> 
> Why you can't reuse "state" (assigned below)?
> If not, then something like
> 
> 	/* ...comment that state can be changed... */
> 	state = ...
> 	dev_dbg(state);
> 
> > +	ctrl = readl(i2c_bus->reg_base + AST2600_I2CC_FUN_CTRL);
> > +
> > +	writel(ctrl & ~(AST2600_I2CC_MASTER_EN | AST2600_I2CC_SLAVE_EN),
> > +	       i2c_bus->reg_base + AST2600_I2CC_FUN_CTRL);
> > +
> > +	writel(readl(i2c_bus->reg_base + AST2600_I2CC_FUN_CTRL) |
> > +AST2600_I2CC_MASTER_EN,
> 
> will it be different from ctrl value?
> 
> > +	       i2c_bus->reg_base + AST2600_I2CC_FUN_CTRL);
> > +
> > +	reinit_completion(&i2c_bus->cmd_complete);
> > +	i2c_bus->cmd_err = 0;
> > +
> > +	/* Check 0x14's SDA and SCL status */
> > +	state = readl(i2c_bus->reg_base + AST2600_I2CC_STS_AND_BUFF);
> > +	if (!(state & AST2600_I2CC_SDA_LINE_STS) && (state &
> AST2600_I2CC_SCL_LINE_STS)) {
> > +		writel(AST2600_I2CM_RECOVER_CMD_EN, i2c_bus->reg_base +
> AST2600_I2CM_CMD_STS);
> > +		r = wait_for_completion_timeout(&i2c_bus->cmd_complete,
> i2c_bus->adap.timeout);
> > +		if (r == 0) {
> > +			dev_dbg(i2c_bus->dev, "recovery timed out\n");
> > +			ret = -ETIMEDOUT;
> 
> > +		} else {
> > +			if (i2c_bus->cmd_err) {
> 
> 		} else if (...) {
> 
> > +				dev_dbg(i2c_bus->dev, "recovery error\n");
> > +				ret = -EPROTO;
> > +			}
> > +		}
> > +	}
> > +
> > +	dev_dbg(i2c_bus->dev, "Recovery done [%x]\n",
> > +		readl(i2c_bus->reg_base + AST2600_I2CC_STS_AND_BUFF));
> 
> As above.
> 
> > +	if (readl(i2c_bus->reg_base + AST2600_I2CC_STS_AND_BUFF) &
> > +AST2600_I2CC_BUS_BUSY_STS) {
> 
> Two sequential reads may give you different values?
> 
> > +		dev_dbg(i2c_bus->dev, "Can't recover bus [%x]\n",
> > +			readl(i2c_bus->reg_base + AST2600_I2CC_STS_AND_BUFF));
> 
> Again? With this inconsistency it will be "nice" to debug.
> 
> > +		ret = -EPROTO;
> > +	}
> > +
> > +	writel(ctrl, i2c_bus->reg_base + AST2600_I2CC_FUN_CTRL);
> > +	return ret;
> > +}
> 
> ...
> 
Will read state in the function begin.
static u8 ast2600_i2c_recover_bus(struct ast2600_i2c_bus *i2c_bus)
{
	u32 state = readl(i2c_bus->reg_base + AST2600_I2CC_STS_AND_BUFF);
-----

> > +#ifdef CONFIG_I2C_SLAVE
> 
> For (at least) review purposes I recommend to split slave out to the separate
> change. This driver is 16 hundreds LoCs long...
> 
> > +#endif
> 
> ...
> 
Sorry I don't catch this split slave out to separate change?
Do you mean go for another file name example ast2600_i2c_slave.c ?


> > +		} else if (i2c_bus->mode == BUFF_MODE) {
> > +			/* buff mode */
> > +			cmd |= AST2600_I2CM_RX_BUFF_EN;
> 
> > +			if (msg->flags & I2C_M_RECV_LEN) {
> > +				dev_dbg(i2c_bus->dev, "smbus read\n");
> > +				xfer_len = 1;
> > +			} else {
> > +				if (msg->len > i2c_bus->buf_size) {
> > +					xfer_len = i2c_bus->buf_size;
> > +				} else {
> > +					xfer_len = msg->len;
> > +					if (i2c_bus->msgs_index + 1 == i2c_bus->msgs_count)
> > +						cmd |= MASTER_TRIGGER_LAST_STOP;
> > +				}
> > +			}
> 
> This...
> 
> > +			writel(AST2600_I2CC_SET_RX_BUF_LEN(xfer_len),
> > +			       i2c_bus->reg_base + AST2600_I2CC_BUFF_CTRL);
> > +		} else {
> 
> > +			/* byte mode */
> > +			xfer_len = 1;
> > +			if (msg->flags & I2C_M_RECV_LEN) {
> > +				dev_dbg(i2c_bus->dev, "smbus read\n");
> > +			} else {
> > +				if (i2c_bus->msgs_index + 1 == i2c_bus->msgs_count) {
> > +					if (msg->len == 1)
> > +						cmd |= MASTER_TRIGGER_LAST_STOP;
> > +				}
> > +			}
> 
> ...and this have a lot in common, can it be deduplicated?
> 
> > +		}
> 
> ...
> 
> > +			if (msg->len > AST2600_I2C_DMA_SIZE) {
> > +				xfer_len = AST2600_I2C_DMA_SIZE;
> > +			} else {
> > +				if (i2c_bus->msgs_index + 1 == i2c_bus->msgs_count)
> > +					cmd |= AST2600_I2CM_STOP_CMD;
> > +				xfer_len = msg->len;
> > +			}
> 
> See above.
> 
> ...

I will modify by following for deduplicated.
That can reuse the tx/rx function.

static int ast2600_i2c_do_start(struct ast2600_i2c_bus *i2c_bus)
{
	struct i2c_msg *msg = &i2c_bus->msgs[i2c_bus->msgs_index];
	int ret;

	/* send start */
	dev_dbg(i2c_bus->dev, "[%d] %sing %d byte%s %s 0x%02x\n",
		i2c_bus->msgs_index, str_read_write(msg->flags & I2C_M_RD),
		msg->len, msg->len > 1 ? "s" : "",
		msg->flags & I2C_M_RD ? "from" : "to", msg->addr);

	i2c_bus->master_xfer_cnt = 0;
	i2c_bus->buf_index = 0;

	if (msg->flags & I2C_M_RD) {
		if (i2c_bus->mode == DMA_MODE)
			ret = ast2600_i2c_setup_dma_rx(i2c_bus);
		else if (i2c_bus->mode == BUFF_MODE)
			ret = ast2600_i2c_setup_buff_rx(i2c_bus);
		else
			ret = ast2600_i2c_setup_byte_rx(i2c_bus);
	} else {
		if (i2c_bus->mode == DMA_MODE)
			ret = ast2600_i2c_setup_dma_tx(AST2600_I2CM_START_CMD, i2c_bus);
		else if (i2c_bus->mode == BUFF_MODE)
			ret = ast2600_i2c_setup_buff_tx(AST2600_I2CM_START_CMD, i2c_bus);
		else
			ret = ast2600_i2c_setup_byte_tx(AST2600_I2CM_START_CMD, i2c_bus);
	}

	return ret;
}

> 
> > +			u8 wbuf[4];
> > +			/* buff mode */
> > +			if (msg->len > i2c_bus->buf_size) {
> > +				xfer_len = i2c_bus->buf_size;
> > +			} else {
> > +				if (i2c_bus->msgs_index + 1 == i2c_bus->msgs_count)
> > +					cmd |= AST2600_I2CM_STOP_CMD;
> > +				xfer_len = msg->len;
> > +			}
> > +			if (xfer_len) {
> > +				cmd |= AST2600_I2CM_TX_BUFF_EN |
> AST2600_I2CM_TX_CMD;
> > +				if (readl(i2c_bus->reg_base + AST2600_I2CS_ISR))
> > +					return -ENOMEM;
> > +				writel(AST2600_I2CC_SET_TX_BUF_LEN(xfer_len),
> > +				       i2c_bus->reg_base + AST2600_I2CC_BUFF_CTRL);
> > +				if (readl(i2c_bus->reg_base + AST2600_I2CS_ISR))
> > +					return -ENOMEM;
> > +				for (i = 0; i < xfer_len; i++) {
> > +					wbuf[i % 4] = msg->buf[i];
> > +					if (i % 4 == 3)
> 
> > +						writel(*(u32 *)wbuf, i2c_bus->buf_base + i - 3);
> 
> This is incorrect memory accessor.
> 
> > +				}
> > +				if (--i % 4 != 3)
> > +					writel(*(u32 *)wbuf, i2c_bus->buf_base + i - (i % 4));
> 
> Ditto.
> 
> > +			}
> 
> ...
> 
> > +static int ast2600_i2c_is_irq_error(u32 irq_status)
> 
> This function is not boolean, so "_is_" seems misleading.
> 
> This is basically error code conversion, something like
> 
> ast2600_i2c_irq_err_to_errno(u32 irq_status)
> 
> > +{
> > +	if (irq_status & AST2600_I2CM_ARBIT_LOSS)
> > +		return -EAGAIN;
> > +	if (irq_status & (AST2600_I2CM_SDA_DL_TO |
> AST2600_I2CM_SCL_LOW_TO))
> > +		return -EBUSY;
> > +	if (irq_status & (AST2600_I2CM_ABNORMAL))
> > +		return -EPROTO;
> > +
> > +	return 0;
> > +}
> 
> ...
> 
Will update in next patch.

> > +				u8 wbuf[4];
> > +
> > +				cmd |= AST2600_I2CM_TX_BUFF_EN;
> > +				xfer_len = msg->len - i2c_bus->master_xfer_cnt;
> > +				if (xfer_len > i2c_bus->buf_size) {
> > +					xfer_len = i2c_bus->buf_size;
> > +				} else {
> > +					if (i2c_bus->msgs_index + 1 == i2c_bus->msgs_count)
> > +						cmd |= AST2600_I2CM_STOP_CMD;
> > +				}
> > +				for (i = 0; i < xfer_len; i++) {
> > +					wbuf[i % 4] = msg->buf[i2c_bus->master_xfer_cnt + i];
> > +					if (i % 4 == 3)
> > +						writel(*(u32 *)wbuf, i2c_bus->buf_base + i - 3);
> > +				}
> > +				if (--i % 4 != 3)
> > +					writel(*(u32 *)wbuf, i2c_bus->buf_base + i - (i % 4));
> > +				writel(AST2600_I2CC_SET_TX_BUF_LEN(xfer_len),
> > +				       i2c_bus->reg_base + AST2600_I2CC_BUFF_CTRL);
> 
> Wrong memory accessors. You should use something from asm/byteorder.h
> which includes linux/byteorder/generic.h.
> 
> ...

Sorry, about these parts. I quit no idea.
This is chip register limited, it only support dword write, not support byte write.
So the only way I have is use get_unaligned_le32 function get the byte buffer to align dword write.
Or I may need your help point me a good way.

 	for (i = 0; i < xfer_len; i++) {
 		wbuf[i % 4] = msg->buf[i2c_bus->master_xfer_cnt + i];
 		if (i % 4 == 3) {
 			wbuf_dword = get_unaligned_le32(wbuf);
 			writel(wbuf_dword, i2c_bus->buf_base + i - 3);
 		}
 	}
 
 	if (--i % 4 != 3) {
 		wbuf_dword = get_unaligned_le32(wbuf);
 		writel(wbuf_dword, i2c_bus->buf_base + i - (i % 4));
 	} 


> 
> > +#ifdef CONFIG_I2C_SLAVE
> > +		/* Workaround for master/slave package mode enable rx done stuck
> issue
> > +		 * When master go for first read (RX_DONE), slave mode will also
> effect
> > +		 * Then controller will send nack, not operate anymore.
> > +		 */
> 
> /*
>  * Wrong style of multi-line
>  * comments. You need to fix
>  * them in the entire driver.
>  */
> 
> > +		if (readl(i2c_bus->reg_base + AST2600_I2CS_CMD_STS) &
> AST2600_I2CS_PKT_MODE_EN) {
> > +			u32 slave_cmd = readl(i2c_bus->reg_base +
> AST2600_I2CS_CMD_STS);
> > +
> > +			writel(0, i2c_bus->reg_base + AST2600_I2CS_CMD_STS);
> > +			writel(slave_cmd, i2c_bus->reg_base +
> AST2600_I2CS_CMD_STS);
> > +		}
> > +		fallthrough;
> > +#endif
> 
> ...
Will update in next patch.

> 
> > +static int ast2600_i2c_master_irq(struct ast2600_i2c_bus *i2c_bus) {
> > +	u32 sts = readl(i2c_bus->reg_base + AST2600_I2CM_ISR);
> > +	u32 ier = readl(i2c_bus->reg_base + AST2600_I2CM_IER);
> > +	u32 ctrl = 0;
> 
> Redundant assignment.

Will update in next patch.
> 
> > +	if (!i2c_bus->alert_enable)
> > +		sts &= ~AST2600_I2CM_SMBUS_ALT;
> > +
> > +	if (AST2600_I2CM_BUS_RECOVER_FAIL & sts) {
> > +		writel(AST2600_I2CM_BUS_RECOVER_FAIL, i2c_bus->reg_base +
> AST2600_I2CM_ISR);
> > +		ctrl = readl(i2c_bus->reg_base + AST2600_I2CC_FUN_CTRL);
> > +		writel(0, i2c_bus->reg_base + AST2600_I2CC_FUN_CTRL);
> > +		writel(ctrl, i2c_bus->reg_base + AST2600_I2CC_FUN_CTRL);
> > +		i2c_bus->cmd_err = -EPROTO;
> > +		complete(&i2c_bus->cmd_complete);
> > +		return 1;
> > +	}
> > +
> > +	if (AST2600_I2CM_BUS_RECOVER & sts) {
> > +		writel(AST2600_I2CM_BUS_RECOVER, i2c_bus->reg_base +
> AST2600_I2CM_ISR);
> > +		i2c_bus->cmd_err = 0;
> > +		complete(&i2c_bus->cmd_complete);
> > +		return 1;
> > +	}
> > +
> > +	if (AST2600_I2CM_SMBUS_ALT & sts) {
> > +		if (ier & AST2600_I2CM_SMBUS_ALT) {
> > +			/* Disable ALT INT */
> > +			writel(ier & ~AST2600_I2CM_SMBUS_ALT, i2c_bus->reg_base +
> AST2600_I2CM_IER);
> > +			i2c_handle_smbus_alert(i2c_bus->ara);
> > +			writel(AST2600_I2CM_SMBUS_ALT, i2c_bus->reg_base +
> AST2600_I2CM_ISR);
> > +			dev_err(i2c_bus->dev,
> > +				"ast2600_master_alert_recv bus id %d, Disable Alt, Please
> Imple\n",
> > +				i2c_bus->adap.nr);
> > +			return 1;
> > +		}
> > +	}
> > +
> > +	i2c_bus->cmd_err = ast2600_i2c_is_irq_error(sts);
> > +	if (i2c_bus->cmd_err) {
> > +		writel(AST2600_I2CM_PKT_DONE, i2c_bus->reg_base +
> AST2600_I2CM_ISR);
> > +		complete(&i2c_bus->cmd_complete);
> > +		return 1;
> > +	}
> > +
> > +	if (AST2600_I2CM_PKT_DONE & sts) {
> > +		ast2600_i2c_master_package_irq(i2c_bus, sts);
> > +		return 1;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> ...
> 
> > +	if (of_property_read_bool(pdev->dev.of_node, "multi-master"))
> > +		i2c_bus->multi_master = true;
> > +	else
> > +		fun_ctrl |= AST2600_I2CC_MULTI_MASTER_DIS;
> 
> 	i2c_bus->multi_master = device_property_read_bool(&pdev->dev,
> "multi-master");
> 	if (!i2c_bus->multi_master)
> 		fun_ctrl |= AST2600_I2CC_MULTI_MASTER_DIS;
> 
> ...
Will update in next patch.

> 
> > +	struct device_node *np = pdev->dev.of_node;
> 
> It should use dev, but see below.
> 
> > +	struct device *dev = &pdev->dev;
> > +	struct ast2600_i2c_bus *i2c_bus;
> > +	struct resource *res;
> > +	u32 global_ctrl;
> 
> > +	int ret = 0;
> 
> Do you need this assignment?

Will update in next patch.
> 
> ...
> 
> > +		i2c_bus->buf_base = devm_platform_ioremap_resource(pdev, 1);
> 
> > +		if (!IS_ERR_OR_NULL(i2c_bus->buf_base))
> 
> Why not positive check?
If dtsi file don't claim resource index 1(that for buffer mode register), it will use default BYTE_MODE.

> 
> > +			i2c_bus->buf_size = resource_size(res) / 2;
> > +		else
> > +			i2c_bus->mode = BYTE_MODE;
> > +	}
> 
> ...
> 
> > +	ret = of_property_read_u32(dev->of_node,
> > +				   "i2c-scl-clk-low-timeout-us",
> > +				   &i2c_bus->timeout);
> 
> 	device_property_read_u32()
> 
> > +	if (!ret)
> > +		i2c_bus->timeout /= 4096;
> 
> ...
> 
> > +	ret = device_property_read_u32(&pdev->dev, "clock-frequency",
> &i2c_bus->bus_frequency);
> > +	if (ret < 0) {
> > +		dev_warn(dev, "Could not read clock-frequency property\n");
> > +		i2c_bus->bus_frequency = I2C_MAX_STANDARD_MODE_FREQ;
> > +	}
> 
> Use standard API from I2C core for this.

Will use i2c_parse_fw_timings(i2c_bus->dev, &i2c_bus->timing_info, true); to do.

> 
> ...
> 
> > +	if (of_property_read_bool(dev->of_node, "smbus-alert")) {
> 
> device_property_read_bool()
Update
	i2c_bus->alert_enable = device_property_read_bool(dev, "smbus-alert");

> 
> Doesn't I2C core handle this property?
Sorry, I don't see any in i2c core.
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
> > +	devm_free_irq(&pdev->dev, i2c_bus->irq, i2c_bus);
> 
> Why explicit call?

Will remove. 

>
> ...
> 
> > +		dmam_free_coherent(i2c_bus->dev, I2C_SLAVE_MSG_BUF_SIZE,
> > +				   i2c_bus->slave_dma_buf, i2c_bus->slave_dma_addr);
> 
> Ditto.
Will remove
> 
> ...
> 
> It looks to me like you ignored part of my comments. If so, I would like to know
> why.
> 
> --
> With Best Regards,
> Andy Shevchenko
> 

