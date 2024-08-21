From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 21 Aug 2024 06:43:01 +0000
Subject: [PATCH v13 2/3] i2c: aspeed: support AST2600 i2c new register
 mode driver
In-Reply-To: <ZsNT7LPZ7-szrgBJ@smile.fi.intel.com>
References: <20240819092850.1590758-1-ryan_chen@aspeedtech.com>
 <20240819092850.1590758-3-ryan_chen@aspeedtech.com>
 <ZsNT7LPZ7-szrgBJ@smile.fi.intel.com>
Message-ID: <OS8PR06MB7541EE5BA5B400445FE0295EF28E2@OS8PR06MB7541.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Subject: Re: [PATCH v13 2/3] i2c: aspeed: support AST2600 i2c new register
> mode driver
> 
> On Mon, Aug 19, 2024 at 05:28:49PM +0800, Ryan Chen wrote:
> > Add i2c new register mode driver to support AST2600 i2c new register
> > mode. AST2600 i2c controller have legacy and new register mode. The
> > new register mode have global register support 4 base clock for scl
> > clock selection, and new clock divider mode. The new register mode
> > have separate register set to control i2c master and slave. This patch
> > is for i2c master mode driver.
> 
> ...
> 
> > +struct ast2600_i2c_bus {
> 
> Have you run `pahole` to be sure the layout is optimal?

It will replace by following.
struct ast2600_i2c_bus {
	struct i2c_adapter	adap;
	struct device		*dev;
	void __iomem		*reg_base;
	struct regmap		*global_regs;
	struct reset_control	*rst;
	struct clk		*clk;
	struct i2c_timings	timing_info;
	struct completion	cmd_complete;
	struct i2c_client	*ara;
	struct i2c_msg		*msgs;
	u8			*master_safe_buf;
	dma_addr_t		master_dma_addr;
	u32			apb_clk;
	u32			timeout;
	int			irq;
	int			cmd_err;
	int			msgs_index;
	int			msgs_count;
	int			master_xfer_cnt;
	size_t			buf_index;
	size_t			buf_size;
	enum xfer_mode		mode;
	bool			alert_enable;
	bool			multi_master;
	/* Buffer mode */
	void __iomem		*buf_base;
	struct i2c_smbus_alert_setup	alert_data;
};

> 
> > +	struct i2c_adapter		adap;
> > +	struct device			*dev;
> > +	void __iomem			*reg_base;
> > +	struct regmap			*global_regs;
> > +	struct reset_control		*rst;
> > +	int				irq;
> > +	enum xfer_mode			mode;
> > +	struct clk			*clk;
> > +	u32				apb_clk;
> > +	struct i2c_timings		timing_info;
> > +	u32				timeout;
> > +	/* smbus alert */
> > +	bool			alert_enable;
> > +	struct i2c_smbus_alert_setup	alert_data;
> > +	struct i2c_client		*ara;
> > +	/* Multi-master */
> > +	bool				multi_master;
> > +	/* master structure */
> > +	int				cmd_err;
> > +	struct completion		cmd_complete;
> > +	struct i2c_msg			*msgs;
> > +	size_t				buf_index;
> > +	/* cur xfer msgs index*/
> > +	int				msgs_index;
> > +	int				msgs_count;
> > +	u8				*master_safe_buf;
> > +	dma_addr_t			master_dma_addr;
> > +	/*total xfer count */
> > +	int				master_xfer_cnt;
> > +	/* Buffer mode */
> > +	void __iomem			*buf_base;
> > +	size_t				buf_size;
> > +};
> 
> ...
> 
> > +static u32 ast2600_select_i2c_clock(struct ast2600_i2c_bus *i2c_bus)
> > +{
> > +	unsigned long base_clk[16];
> > +	int baseclk_idx;
> > +	u32 clk_div_reg;
> > +	u32 scl_low;
> > +	u32 scl_high;
> > +	int divisor;
> > +	u32 data;
> > +
> > +	regmap_read(i2c_bus->global_regs, AST2600_I2CG_CLK_DIV_CTRL,
> > +&clk_div_reg);
> > +
> > +	for (int i = 0; i < 16; i++) {
> 
> unsigned int
> ARRAY_SIZE(base_clk) // Will need array_size.h

Will update to for (int i = 0; i < ARRAY_SIZE(base_clk); i++)
And add include array_size.h
> 
> 
> > +		if (i == 0)
> > +			base_clk[i] = i2c_bus->apb_clk;
> > +		else if ((i > 0) || (i < 5))
> > +			base_clk[i] = (i2c_bus->apb_clk * 2) /
> > +				(((clk_div_reg >> ((i - 1) * 8)) & GENMASK(7, 0)) + 2);
> > +		else
> > +			base_clk[i] = base_clk[4] / (1 << (i - 5));
> 
> This is the same as
> 
> 		if (i == 0)
> 			base_clk[i] = i2c_bus->apb_clk;
> 		else if (i < 5)
> 			base_clk[i] = (i2c_bus->apb_clk * 2) /
> 				      (((clk_div_reg / BIT((i - 1) * 8)) & GENMASK(7, 0)) +
> 2);
> 		else
> 			base_clk[i] = base_clk[4] / BIT(i - 5);
> 
> Alternatively
> 
> 		if (i == 0)
> 			base_clk[i] = i2c_bus->apb_clk;
> 		else if (i < 5)
> 			base_clk[i] = (i2c_bus->apb_clk * 2) /
> 				      (((clk_div_reg >> ((i - 1) * 8)) & GENMASK(7, 0)) + 2);
> 		else
> 			base_clk[i] = base_clk[4] >> (i - 5);
> 

Will take the for better understand.
	if (i == 0)
			base_clk[i] = i2c_bus->apb_clk;
		else if (i < 5)
			base_clk[i] = (i2c_bus->apb_clk * 2) /
				      (((clk_div_reg >> ((i - 1) * 8)) & GENMASK(7, 0)) + 2);
		else
			base_clk[i] = base_clk[4] >> (i - 5);

> > +
> > +		if ((base_clk[i] / i2c_bus->timing_info.bus_freq_hz) <= 32) {
> > +			baseclk_idx = i;
> > +			divisor = DIV_ROUND_UP(base_clk[i],
> i2c_bus->timing_info.bus_freq_hz);
> > +			break;
> > +		}
> > +	}
> 
> > +	baseclk_idx = min(baseclk_idx, 15);
> 
> If the last conditional inside the loop is never true, you are going to use\ a
> garbage here.

I will give initial int baseclk_idx = 0; in function begin.
> 
> > +	divisor = min(divisor, 32);
> 
> Ditto.

I will give u32 divisor = 32; in function begin.
> 
> > +	scl_low = min(divisor * 9 / 16 - 1, 15);
> 
> Missing minmax.h in the inclusion block.
Will add.
> 
> > +	scl_high = (divisor - scl_low - 2) & GENMASK(3, 0);
> > +	data = (scl_high - 1) << 20 | scl_high << 16 | scl_low << 12 | baseclk_idx;
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
> > +static u8 ast2600_i2c_recover_bus(struct ast2600_i2c_bus *i2c_bus) {
> > +	u32 state = readl(i2c_bus->reg_base + AST2600_I2CC_STS_AND_BUFF);
> > +	int ret = 0;
> > +	u32 ctrl;
> > +	int r;
> > +
> > +	dev_dbg(i2c_bus->dev, "%d-bus recovery bus [%x]\n",
> > +i2c_bus->adap.nr, state);
> > +
> > +	ctrl = readl(i2c_bus->reg_base + AST2600_I2CC_FUN_CTRL);
> > +
> > +	/* Disable master/slave mode */
> > +	writel(ctrl & ~(AST2600_I2CC_MASTER_EN | AST2600_I2CC_SLAVE_EN),
> > +	       i2c_bus->reg_base + AST2600_I2CC_FUN_CTRL);
> > +
> > +	/* Enable master mode only */
> > +	writel(readl(i2c_bus->reg_base + AST2600_I2CC_FUN_CTRL) |
> AST2600_I2CC_MASTER_EN,
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
> > +		} else {
> > +			if (i2c_bus->cmd_err) {
> > +				dev_dbg(i2c_bus->dev, "recovery error\n");
> > +				ret = -EPROTO;
> > +			}
> > +		}
> > +	}
> 
> ret is set but maybe overridden.
> 

If will modify by following.
		if (r == 0) {
			dev_dbg(i2c_bus->dev, "recovery timed out\n");
			ret = -ETIMEDOUT;
		} else if (i2c_bus->cmd_err) {
			dev_dbg(i2c_bus->dev, "recovery error\n");
			ret = -EPROTO;
		}
If no error keep ret = 0;

> > +	/* Recovery done */
> 
> Even if it fails above?

This will keep check the bus status, if bus busy, will give ret = -EPROTO;

> 
> > +	state = readl(i2c_bus->reg_base + AST2600_I2CC_STS_AND_BUFF);
> > +	if (state & AST2600_I2CC_BUS_BUSY_STS) {
> > +		dev_dbg(i2c_bus->dev, "Can't recover bus [%x]\n", state);
> > +		ret = -EPROTO;
> > +	}
> > +
> > +	/* restore original master/slave setting */
> > +	writel(ctrl, i2c_bus->reg_base + AST2600_I2CC_FUN_CTRL);
> > +	return ret;
> > +}
> 
> ...
> 
> > +static int ast2600_i2c_setup_dma_tx(u32 cmd, struct ast2600_i2c_bus
> > +*i2c_bus) {
> > +	struct i2c_msg *msg = &i2c_bus->msgs[i2c_bus->msgs_index];
> > +	int xfer_len;
> > +
> > +	cmd |= AST2600_I2CM_PKT_EN;
> > +	xfer_len = msg->len - i2c_bus->master_xfer_cnt;
> > +	if (xfer_len > AST2600_I2C_DMA_SIZE) {
> > +		xfer_len = AST2600_I2C_DMA_SIZE;
> 
> > +	} else {
> > +		if (i2c_bus->msgs_index + 1 == i2c_bus->msgs_count)
> 
> 	else if (...)

Will update to else if(...).
> 
> > +			cmd |= AST2600_I2CM_STOP_CMD;
> > +	}
> > +
> > +	if (cmd & AST2600_I2CM_START_CMD) {
> > +		cmd |= AST2600_I2CM_PKT_ADDR(msg->addr);
> > +		i2c_bus->master_safe_buf = i2c_get_dma_safe_msg_buf(msg, 1);
> > +		if (!i2c_bus->master_safe_buf)
> > +			return -ENOMEM;
> > +		i2c_bus->master_dma_addr =
> > +			dma_map_single(i2c_bus->dev, i2c_bus->master_safe_buf,
> > +				       msg->len, DMA_TO_DEVICE);
> 
> > +		if (dma_mapping_error(i2c_bus->dev, i2c_bus->master_dma_addr))
> {
> > +			i2c_put_dma_safe_msg_buf(i2c_bus->master_safe_buf, msg,
> false);
> > +			i2c_bus->master_safe_buf = NULL;
> 
> > +			return -ENOMEM;
> 
> Why is the dma_mapping_error() returned error code shadowed?

Sorry, please point me why you are think it is shadowed?
As I know dma_mapping_error() will return 0 or -ENOMEM. So I check if it is !=0.
Than return -ENOMEM. 
> 
> > +		}
> > +	}
> > +
> > +	if (xfer_len) {
> > +		cmd |= AST2600_I2CM_TX_DMA_EN | AST2600_I2CM_TX_CMD;
> > +		writel(AST2600_I2CM_SET_TX_DMA_LEN(xfer_len - 1),
> > +		       i2c_bus->reg_base + AST2600_I2CM_DMA_LEN);
> > +		writel(i2c_bus->master_dma_addr + i2c_bus->master_xfer_cnt,
> > +		       i2c_bus->reg_base + AST2600_I2CM_TX_DMA);
> > +	}
> > +
> > +	writel(cmd, i2c_bus->reg_base + AST2600_I2CM_CMD_STS);
> > +
> > +	return 0;
> > +}
> > +
> > +static int ast2600_i2c_setup_buff_tx(u32 cmd, struct ast2600_i2c_bus
> > +*i2c_bus) {
> > +	struct i2c_msg *msg = &i2c_bus->msgs[i2c_bus->msgs_index];
> > +	u32 wbuf_dword;
> > +	int xfer_len;
> > +	u8 wbuf[4];
> 
> > +	int i;
> 
> Why signed?

Because it is for xfer len plus, also align with xfer_len and master_xfer_cnt in struct i2c_bus struct.

> 
> > +	cmd |= AST2600_I2CM_PKT_EN;
> > +	xfer_len = msg->len - i2c_bus->master_xfer_cnt;
> > +	if (xfer_len > i2c_bus->buf_size) {
> > +		xfer_len = i2c_bus->buf_size;
> 
> > +	} else {
> > +		if (i2c_bus->msgs_index + 1 == i2c_bus->msgs_count)
> 
> 	else if (...)

Will update else if (...).
> 
> > +			cmd |= AST2600_I2CM_STOP_CMD;
> > +	}
> > +
> > +	if (cmd & AST2600_I2CM_START_CMD)
> > +		cmd |= AST2600_I2CM_PKT_ADDR(msg->addr);
> > +
> > +	if (xfer_len) {
> > +		cmd |= AST2600_I2CM_TX_BUFF_EN | AST2600_I2CM_TX_CMD;
> 
> > +		/*
> > +		 * The controller's buffer register supports dword writes only.
> > +		 * Therefore, write dwords to the buffer register in a 4-byte aligned,
> > +		 * and write the remaining unaligned data at the end.
> > +		 */
> > +		for (i = 0; i < xfer_len; i++) {
> > +			wbuf[i % 4] = msg->buf[i2c_bus->master_xfer_cnt + i];
> > +			if ((i % 4) == 3 || i == xfer_len - 1) {
> > +				wbuf_dword = get_unaligned_le32(wbuf);
> > +				writel(wbuf_dword, i2c_bus->buf_base + i - (i % 4));
> > +			}
> > +		}
> 
> This is overcomplicated and can be simplified.
> Why you can't perform
> 
> 	get_unaligned_leXX(msg->buf[i2c_bus->master_xfer_cnt + i]);
> 
> ?
> 
> 		for (i = 0; i < xfer_len; i += 4) {
> 			switch (min(xfer_len - i, 4) % 4) {
> 			case 1:
> 				wbuf_dword = ...;
> 				writel(wbuf_dword, i2c_bus->buf_base + i);
> 				break;
> 			case 2:
> 				wbuf_dword = get_unaligned_le16(...);
> 				writel(wbuf_dword, i2c_bus->buf_base + i);
> 				break;
> 			case 3:
> 				wbuf_dword = get_unaligned_le24(...);
> 				writel(wbuf_dword, i2c_bus->buf_base + i);
> 				break;
> 			default:
> 				wbuf_dword = get_unaligned_le32(...);
> 				writel(wbuf_dword, i2c_bus->buf_base + i);
> 				break;
> 			}
> 		}
> 
> 
> Now, with this it's can be a helper, with which
> 
> 		for (i = 0; i < xfer_len; i += 4) {
> 			switch (min(xfer_len - i, 4) % 4) {
> 			case 1:
> 				ast2600_write_data(i2c_bus, i, ...);
> 				break;
> 			case 2:
> 				ast2600_write_data(i2c_bus, i, get_unaligned_le16(...));
> 				break;
> 			case 3:
> 				ast2600_write_data(i2c_bus, i, get_unaligned_le24(...));
> 				break;
> 			default:
> 				ast2600_write_data(i2c_bus, i, get_unaligned_le32(...));
> 				break;
> 			}
> 		}
> 
OK, I will modify by this.
		for (i = 0; i < xfer_len; i += 4) {
			switch (min(xfer_len - i, 4) % 4) {
			case 1:
				ast2600_write_data(i2c_bus, i, ...);
				break;
			case 2:
				ast2600_write_data(i2c_bus, i, get_unaligned_le16(...));
				break;
			case 3:
				ast2600_write_data(i2c_bus, i, get_unaligned_le24(...));
				break;
			default:
				ast2600_write_data(i2c_bus, i, get_unaligned_le32(...));
				break;
			}
		}

> > +		writel(AST2600_I2CC_SET_TX_BUF_LEN(xfer_len),
> > +		       i2c_bus->reg_base + AST2600_I2CC_BUFF_CTRL);
> > +	}
> > +
> > +	writel(cmd, i2c_bus->reg_base + AST2600_I2CM_CMD_STS);
> > +
> > +	return 0;
> > +}
> 
> ...
> 
> > +static int ast2600_i2c_setup_dma_rx(struct ast2600_i2c_bus *i2c_bus)
> > +{
> > +	struct i2c_msg *msg = &i2c_bus->msgs[i2c_bus->msgs_index];
> > +	int xfer_len;
> > +	u32 cmd;
> > +
> > +	cmd = AST2600_I2CM_PKT_EN | AST2600_I2CM_PKT_ADDR(msg->addr)
> |
> > +	      AST2600_I2CM_START_CMD | AST2600_I2CM_RX_DMA_EN;
> > +
> > +	if (msg->flags & I2C_M_RECV_LEN) {
> > +		xfer_len = 1;
> 
> > +	} else {
> > +		if (msg->len > AST2600_I2C_DMA_SIZE) {
> 
> 	} else if (...) {
> 
Will update to else if (...) {
> > +			xfer_len = AST2600_I2C_DMA_SIZE;
> > +		} else {
> > +			xfer_len = msg->len;
> > +			if (i2c_bus->msgs_index + 1 == i2c_bus->msgs_count)
> > +				cmd |= MASTER_TRIGGER_LAST_STOP;
> > +		}
> > +	}
> > +	writel(AST2600_I2CM_SET_RX_DMA_LEN(xfer_len - 1),
> i2c_bus->reg_base + AST2600_I2CM_DMA_LEN);
> > +	i2c_bus->master_safe_buf = i2c_get_dma_safe_msg_buf(msg, 1);
> > +	if (!i2c_bus->master_safe_buf)
> > +		return -ENOMEM;
> > +	i2c_bus->master_dma_addr =
> > +		dma_map_single(i2c_bus->dev, i2c_bus->master_safe_buf, msg->len,
> DMA_FROM_DEVICE);
> > +	if (dma_mapping_error(i2c_bus->dev, i2c_bus->master_dma_addr)) {
> > +		i2c_put_dma_safe_msg_buf(i2c_bus->master_safe_buf, msg, false);
> > +		i2c_bus->master_safe_buf = NULL;
> > +		return -ENOMEM;
> > +	}
> > +	writel(i2c_bus->master_dma_addr, i2c_bus->reg_base +
> > +AST2600_I2CM_RX_DMA);
> > +
> > +	writel(cmd, i2c_bus->reg_base + AST2600_I2CM_CMD_STS);
> > +
> > +	return 0;
> > +}
> > +
> > +static int ast2600_i2c_setup_buff_rx(struct ast2600_i2c_bus *i2c_bus)
> > +{
> > +	struct i2c_msg *msg = &i2c_bus->msgs[i2c_bus->msgs_index];
> > +	int xfer_len;
> > +	u32 cmd;
> > +
> > +	cmd = AST2600_I2CM_PKT_EN | AST2600_I2CM_PKT_ADDR(msg->addr)
> |
> > +	      AST2600_I2CM_START_CMD | AST2600_I2CM_RX_BUFF_EN;
> > +
> > +	if (msg->flags & I2C_M_RECV_LEN) {
> > +		dev_dbg(i2c_bus->dev, "smbus read\n");
> > +		xfer_len = 1;
> 
> > +	} else {
> > +		if (msg->len > i2c_bus->buf_size) {
> 
> 	} else if (...) {
Will update to else if (...) {

> 
> > +			xfer_len = i2c_bus->buf_size;
> > +		} else {
> > +			xfer_len = msg->len;
> > +			if (i2c_bus->msgs_index + 1 == i2c_bus->msgs_count)
> > +				cmd |= MASTER_TRIGGER_LAST_STOP;
> > +		}
> > +	}
> > +	writel(AST2600_I2CC_SET_RX_BUF_LEN(xfer_len), i2c_bus->reg_base +
> > +AST2600_I2CC_BUFF_CTRL);
> > +
> > +	writel(cmd, i2c_bus->reg_base + AST2600_I2CM_CMD_STS);
> > +
> > +	return 0;
> > +}
> > +
> > +static int ast2600_i2c_setup_byte_rx(struct ast2600_i2c_bus *i2c_bus)
> > +{
> > +	struct i2c_msg *msg = &i2c_bus->msgs[i2c_bus->msgs_index];
> > +	u32 cmd;
> > +
> > +	cmd = AST2600_I2CM_PKT_EN | AST2600_I2CM_PKT_ADDR(msg->addr)
> |
> > +	      AST2600_I2CM_START_CMD | AST2600_I2CM_RX_CMD;
> > +
> > +	if (msg->flags & I2C_M_RECV_LEN) {
> > +		dev_dbg(i2c_bus->dev, "smbus read\n");
> 
> > +	} else {
> > +		if (i2c_bus->msgs_index + 1 == i2c_bus->msgs_count) {
> 
> 	} else if (...) {
> 
Will update to else if (...) {

> > +			if (msg->len == 1)
> > +				cmd |= MASTER_TRIGGER_LAST_STOP;
> > +		}
> > +	}
> > +
> > +	writel(cmd, i2c_bus->reg_base + AST2600_I2CM_CMD_STS);
> > +
> > +	return 0;
> > +}
> 
> ...
> 
> > +static int ast2600_i2c_do_start(struct ast2600_i2c_bus *i2c_bus) {
> > +	struct i2c_msg *msg = &i2c_bus->msgs[i2c_bus->msgs_index];
> > +
> > +	/* send start */
> > +	dev_dbg(i2c_bus->dev, "[%d] %sing %d byte%s %s 0x%02x\n",
> 
> Drop 'ing', no need to have this in the debug message.
Will Drop 'ing'
> 
> > +		i2c_bus->msgs_index, str_read_write(msg->flags & I2C_M_RD),
> > +		msg->len, msg->len > 1 ? "s" : "",
> 
> str_plural()

Will replace by following. 

dev_dbg(i2c_bus->dev, "[%d] %s %d byte%s %s 0x%02x\n",
        i2c_bus->msgs_index, str_read_write(msg->flags & I2C_M_RD),
        msg->len, str_plural(msg->len),

> 
> > +		msg->flags & I2C_M_RD ? "from" : "to", msg->addr);
> 
> > +	i2c_bus->master_xfer_cnt = 0;
> > +	i2c_bus->buf_index = 0;
> > +
> > +	if (msg->flags & I2C_M_RD) {
> > +		if (i2c_bus->mode == DMA_MODE)
> > +			return ast2600_i2c_setup_dma_rx(i2c_bus);
> > +		else if (i2c_bus->mode == BUFF_MODE)
> > +			return ast2600_i2c_setup_buff_rx(i2c_bus);
> > +		else
> > +			return ast2600_i2c_setup_byte_rx(i2c_bus);
> > +	} else {
> > +		if (i2c_bus->mode == DMA_MODE)
> > +			return
> ast2600_i2c_setup_dma_tx(AST2600_I2CM_START_CMD, i2c_bus);
> > +		else if (i2c_bus->mode == BUFF_MODE)
> > +			return ast2600_i2c_setup_buff_tx(AST2600_I2CM_START_CMD,
> i2c_bus);
> > +		else
> > +			return
> ast2600_i2c_setup_byte_tx(AST2600_I2CM_START_CMD, i2c_bus);
> > +	}
> > +}
> 
> ...
> 
> > +master_out:
> > +	if (i2c_bus->mode == DMA_MODE) {
> > +		kfree(i2c_bus->master_safe_buf);
> > +	    i2c_bus->master_safe_buf = NULL;
> > +	}
> 
> Indentation issues.

Will update
> 
> > +	return ret;
> 
> ...
> 
> 
> > +MODULE_DEVICE_TABLE(of, ast2600_i2c_bus_of_table);
> 
> Why do you need this table before _probe()? Isn't the only user is below?

It is for next generation table list. Do you suggest remove it?

> 
> > +static int ast2600_i2c_probe(struct platform_device *pdev)
> 
> ...
> 
> > +	i2c_bus->global_regs =
> syscon_regmap_lookup_by_phandle(dev->of_node,
> > +"aspeed,global-regs");
> 
> dev_of_node(dev)

Will update i2c_bus->global_regs = syscon_regmap_lookup_by_phandle(dev_of_node(dev), "aspeed,global-regs");
> 

> > +	if (IS_ERR(i2c_bus->global_regs))
> > +		return PTR_ERR(i2c_bus->global_regs);
> 
> ...
> 
> > +	if (device_property_read_bool(&pdev->dev, "aspeed,enable-dma"))
> 
> You have 'dev' Why not use it?
Will update
	if (device_property_read_bool(dev, "aspeed,enable-dma"))
> 
> > +		i2c_bus->mode = DMA_MODE;
> 
> ...
> 
> > +	if (i2c_bus->mode == BUFF_MODE) {
> > +		i2c_bus->buf_base =
> devm_platform_get_and_ioremap_resource(pdev, 1, &res);
> > +		if (!IS_ERR_OR_NULL(i2c_bus->buf_base))
> > +			i2c_bus->buf_size = resource_size(res) / 2;
> > +		else
> > +			i2c_bus->mode = BYTE_MODE;
> 
> What's wrong with positive conditional? And is it even possible to have NULL
> here?
> 
Yes, if dtsi fill not following yaml example have reg 1, that will failure at buffer mode.
And I can swith to byte mode. 

reg = <0x80 0x80>, <0xc00 0x20>;
> > +	}
> 
> ...
> 
> > +	strscpy(i2c_bus->adap.name, pdev->name, sizeof(i2c_bus->adap.name));
> 
> Use 2-argument strscpy().
Do you mean strscpy(i2c_bus->adap.name, pdev->name); is acceptable?
> 
> ...
> 
> > +	i2c_bus->alert_enable = device_property_read_bool(dev, "smbus-alert");
> > +	if (i2c_bus->alert_enable) {
> > +		i2c_bus->ara = i2c_new_smbus_alert_device(&i2c_bus->adap,
> &i2c_bus->alert_data);
> > +		if (!i2c_bus->ara)
> > +			dev_warn(dev, "Failed to register ARA client\n");
> > +
> > +		writel(AST2600_I2CM_PKT_DONE | AST2600_I2CM_BUS_RECOVER
> | AST2600_I2CM_SMBUS_ALT,
> > +		       i2c_bus->reg_base + AST2600_I2CM_IER);
> > +	} else {
> > +		i2c_bus->alert_enable = false;
> > +		/* Set interrupt generation of I2C master controller */
> > +		writel(AST2600_I2CM_PKT_DONE | AST2600_I2CM_BUS_RECOVER,
> > +		       i2c_bus->reg_base + AST2600_I2CM_IER);
> > +	}
> 
> I2C core calls i2c_setup_smbus_alert() when registering the adapter. Why do
> you need to have something special here?
The ast2600 i2c support smbus alert, and according my reference.
If enable alert, that will need i2c_new_smbus_alert_device for alert handler.
When interrupt coming driver can use this hander to up use i2c_handle_smbus_alert
And update layer will handle alert.
Does I mis-understand. If yes, I will remove this in next.
> 
> --
> With Best Regards,
> Andy Shevchenko
> 

