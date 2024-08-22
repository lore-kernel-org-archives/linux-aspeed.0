From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Thu, 22 Aug 2024 02:24:26 +0000
Subject: [PATCH v13 2/3] i2c: aspeed: support AST2600 i2c new register
 mode driver
In-Reply-To: <ZsXVU2qy0GIANFrc@smile.fi.intel.com>
References: <20240819092850.1590758-1-ryan_chen@aspeedtech.com>
 <20240819092850.1590758-3-ryan_chen@aspeedtech.com>
 <ZsNT7LPZ7-szrgBJ@smile.fi.intel.com>
 <OS8PR06MB7541EE5BA5B400445FE0295EF28E2@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <ZsXVU2qy0GIANFrc@smile.fi.intel.com>
Message-ID: <OS8PR06MB7541945591A62B956DA28AD9F28F2@OS8PR06MB7541.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Subject: Re: [PATCH v13 2/3] i2c: aspeed: support AST2600 i2c new register
> mode driver
> 
> On Wed, Aug 21, 2024 at 06:43:01AM +0000, Ryan Chen wrote:
> > > On Mon, Aug 19, 2024 at 05:28:49PM +0800, Ryan Chen wrote:
> 
> ...
> 
> > > > +	/* Check 0x14's SDA and SCL status */
> > > > +	state = readl(i2c_bus->reg_base + AST2600_I2CC_STS_AND_BUFF);
> > > > +	if (!(state & AST2600_I2CC_SDA_LINE_STS) && (state &
> > > AST2600_I2CC_SCL_LINE_STS)) {
> > > > +		writel(AST2600_I2CM_RECOVER_CMD_EN, i2c_bus->reg_base
> +
> > > AST2600_I2CM_CMD_STS);
> > > > +		r = wait_for_completion_timeout(&i2c_bus->cmd_complete,
> > > i2c_bus->adap.timeout);
> > > > +		if (r == 0) {
> > > > +			dev_dbg(i2c_bus->dev, "recovery timed out\n");
> > > > +			ret = -ETIMEDOUT;
> > > > +		} else {
> > > > +			if (i2c_bus->cmd_err) {
> > > > +				dev_dbg(i2c_bus->dev, "recovery error\n");
> > > > +				ret = -EPROTO;
> > > > +			}
> > > > +		}
> > > > +	}
> > >
> > > ret is set but maybe overridden.
> >
> > If will modify by following.
> > 		if (r == 0) {
> > 			dev_dbg(i2c_bus->dev, "recovery timed out\n");
> > 			ret = -ETIMEDOUT;
> > 		} else if (i2c_bus->cmd_err) {
> > 			dev_dbg(i2c_bus->dev, "recovery error\n");
> > 			ret = -EPROTO;
> > 		}
> > If no error keep ret = 0;
> 
> It doesn't change the behaviour. Still ret can be overridden below...

Yes, it is expectable, previous is issue recovery command out then the following is double confirm the bus status.
If bus still busy, the function still return recovery fail.

Or should I modify by following?
	/* Check 0x14's SDA and SCL status */
	state = readl(i2c_bus->reg_base + AST2600_I2CC_STS_AND_BUFF);
	if (!(state & AST2600_I2CC_SDA_LINE_STS) && (state & AST2600_I2CC_SCL_LINE_STS)) {
		writel(AST2600_I2CM_RECOVER_CMD_EN, i2c_bus->reg_base + AST2600_I2CM_CMD_STS);
		r = wait_for_completion_timeout(&i2c_bus->cmd_complete, i2c_bus->adap.timeout);
		if (r == 0) {
			dev_dbg(i2c_bus->dev, "recovery timed out\n");
			ret = -ETIMEDOUT;
		} else if (i2c_bus->cmd_err) {
				dev_dbg(i2c_bus->dev, "recovery error\n");
				ret = -EPROTO;
		}
		/* check bus status */
		state = readl(i2c_bus->reg_base + AST2600_I2CC_STS_AND_BUFF);
		if (state & AST2600_I2CC_BUS_BUSY_STS) {
			dev_dbg(i2c_bus->dev, "Can't recover bus [%x]\n", state);
			ret = -EPROTO;
		}
	}

> 
> > > > +	/* Recovery done */
> > >
> > > Even if it fails above?
> >
> > This will keep check the bus status, if bus busy, will give ret =
> > -EPROTO;
> >
> > > > +	state = readl(i2c_bus->reg_base + AST2600_I2CC_STS_AND_BUFF);
> > > > +	if (state & AST2600_I2CC_BUS_BUSY_STS) {
> > > > +		dev_dbg(i2c_bus->dev, "Can't recover bus [%x]\n", state);
> > > > +		ret = -EPROTO;
> 
> ...here.
> 
> > > > +	}
> > > > +
> > > > +	/* restore original master/slave setting */
> > > > +	writel(ctrl, i2c_bus->reg_base + AST2600_I2CC_FUN_CTRL);
> > > > +	return ret;
> 
> ...
> 
> 
> > > > +		i2c_bus->master_dma_addr =
> > > > +			dma_map_single(i2c_bus->dev, i2c_bus->master_safe_buf,
> > > > +				       msg->len, DMA_TO_DEVICE);
> > >
> > > > +		if (dma_mapping_error(i2c_bus->dev,
> i2c_bus->master_dma_addr))
> > > {
> > > > +			i2c_put_dma_safe_msg_buf(i2c_bus->master_safe_buf,
> msg,
> > > false);
> > > > +			i2c_bus->master_safe_buf = NULL;
> > >
> > > > +			return -ENOMEM;
> > >
> > > Why is the dma_mapping_error() returned error code shadowed?
> >
> > Sorry, please point me why you are think it is shadowed?
> > As I know dma_mapping_error() will return 0 or -ENOMEM. So I check if it
> is !=0.
> > Than return -ENOMEM.
> 
> First of all, it is a bad style to rely on the implementation details where it's not
> crucial. Second, today it may return only ENOMEM, tomorrow it can return a
> different code or codes. And in general, one should not shadow an error code
> without justification.
> 
Understood, The following is better, am I right? (if yest, those will update in driver)
		Int ret;
		.....
		ret = dma_mapping_error(i2c_bus->dev, i2c_bus->master_dma_addr)
		if (ret) {
			i2c_put_dma_safe_msg_buf(i2c_bus->master_safe_buf, msg, false);
			i2c_bus->master_safe_buf = NULL;
			return ret;
		}

> > > > +		}
> 
> ...
> 
> > > > +MODULE_DEVICE_TABLE(of, ast2600_i2c_bus_of_table);
> > >
> > > Why do you need this table before _probe()? Isn't the only user is below?
> >
> > It is for next generation table list. Do you suggest remove it?
> 
> My question was regarding to the location of this table in the code, that's it, no
> other implications.
> 
I will move before platform_driver ast2600_i2c_bus_driver, like following.

static const struct of_device_id ast2600_i2c_bus_of_table[] = {
	{
		.compatible = "aspeed,ast2600-i2cv2",
	},
	{}
};
MODULE_DEVICE_TABLE(of, ast2600_i2c_bus_of_table);

static struct platform_driver ast2600_i2c_bus_driver = {
.......
}

> ...
> 
> > > > +	if (i2c_bus->mode == BUFF_MODE) {
> > > > +		i2c_bus->buf_base =
> > > devm_platform_get_and_ioremap_resource(pdev, 1, &res);
> > > > +		if (!IS_ERR_OR_NULL(i2c_bus->buf_base))
> > > > +			i2c_bus->buf_size = resource_size(res) / 2;
> > > > +		else
> > > > +			i2c_bus->mode = BYTE_MODE;
> > >
> > > What's wrong with positive conditional? And is it even possible to
> > > have NULL here?
> > >
> > Yes, if dtsi fill not following yaml example have reg 1, that will failure at buffer
> mode.
> > And I can swith to byte mode.
> >
> > reg = <0x80 0x80>, <0xc00 0x20>;
> 
> I was asking about if (!IS_ERR_OR_NULL(...)) line:
> 1) Why 'if (!foo) {} else {}' instead of 'if (foo) {} else {}'?
I will update to following.
		if (IS_ERR(i2c_bus->buf_base))
			i2c_bus->mode = BYTE_MODE;
		else
			i2c_bus->buf_size = resource_size(res) / 2;
			
> 2) Why _NULL?
	If dtsi file is claim only 1 reg offset. reg = <0x80 0x80>; that will goto byte mode.
	reg = <0x80 0x80>, <0xc00 0x20>; can support buffer mode.
	due to 2nd is buffer register offset.
> 
> > > > +	}
> 
> ...
> 
> > > > +	strscpy(i2c_bus->adap.name, pdev->name,
> > > > +sizeof(i2c_bus->adap.name));
> > >
> > > Use 2-argument strscpy().
> > Do you mean strscpy(i2c_bus->adap.name, pdev->name); is acceptable?
> 
> Yes. And not only acceptable but robust for the copying to the [string] arrays.
Got it.
> 
> ...
> 
> > > > +	i2c_bus->alert_enable = device_property_read_bool(dev,
> "smbus-alert");
> > > > +	if (i2c_bus->alert_enable) {
> > > > +		i2c_bus->ara = i2c_new_smbus_alert_device(&i2c_bus->adap,
> > > &i2c_bus->alert_data);
> > > > +		if (!i2c_bus->ara)
> > > > +			dev_warn(dev, "Failed to register ARA client\n");
> > > > +
> > > > +		writel(AST2600_I2CM_PKT_DONE |
> AST2600_I2CM_BUS_RECOVER
> > > | AST2600_I2CM_SMBUS_ALT,
> > > > +		       i2c_bus->reg_base + AST2600_I2CM_IER);
> > > > +	} else {
> > > > +		i2c_bus->alert_enable = false;
> > > > +		/* Set interrupt generation of I2C master controller */
> > > > +		writel(AST2600_I2CM_PKT_DONE |
> AST2600_I2CM_BUS_RECOVER,
> > > > +		       i2c_bus->reg_base + AST2600_I2CM_IER);
> > > > +	}
> > >
> > > I2C core calls i2c_setup_smbus_alert() when registering the adapter.
> > > Why do you need to have something special here?
> > The ast2600 i2c support smbus alert, and according my reference.
> > If enable alert, that will need i2c_new_smbus_alert_device for alert handler.
> > When interrupt coming driver can use this hander to up use
> > i2c_handle_smbus_alert And update layer will handle alert.
> > Does I mis-understand. If yes, I will remove this in next.
> 
> Have you seen i2c_new_smbus_alert_device() ?
No, I think I will remove it, when if it is more clear. Thanks a lot.
> 
> --
> With Best Regards,
> Andy Shevchenko
> 

