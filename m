From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Mon, 24 May 2021 10:06:12 +0000
Subject: [PATCH v3 5/7] i2c: aspeed: Add aspeed_set_slave_busy()
In-Reply-To: <20210519074934.20712-6-quan@os.amperecomputing.com>
References: <20210519074934.20712-1-quan@os.amperecomputing.com>
 <20210519074934.20712-6-quan@os.amperecomputing.com>
Message-ID: <HK0PR06MB3380FD2B7649CFB48BEA2D4FF2269@HK0PR06MB3380.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: openbmc
> <openbmc-bounces+ryan_chen=aspeedtech.com@lists.ozlabs.org> On Behalf
> Of Quan Nguyen
> Sent: Wednesday, May 19, 2021 3:50 PM
> To: Corey Minyard <minyard@acm.org>; Rob Herring <robh+dt@kernel.org>;
> Joel Stanley <joel@jms.id.au>; Andrew Jeffery <andrew@aj.id.au>; Brendan
> Higgins <brendanhiggins@google.com>; Benjamin Herrenschmidt
> <benh@kernel.crashing.org>; Wolfram Sang <wsa@kernel.org>; Philipp Zabel
> <p.zabel@pengutronix.de>; openipmi-developer at lists.sourceforge.net;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org;
> linux-i2c at vger.kernel.org
> Cc: Open Source Submission <patches@amperecomputing.com>; Thang Q .
> Nguyen <thang@os.amperecomputing.com>; Phong Vo
> <phong@os.amperecomputing.com>; openbmc at lists.ozlabs.org
> Subject: [PATCH v3 5/7] i2c: aspeed: Add aspeed_set_slave_busy()
> 
> Slave i2c device on AST2500 received a lot of slave irq while it is busy
> processing the response. To handle this case, adds and exports
> aspeed_set_slave_busy() for controller to temporary stop slave irq while slave
> is handling the response, and re-enable them again when the response is ready.
> 
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> ---
> v3:
>   + First introduce in v3 [Quan]
> 
>  drivers/i2c/busses/i2c-aspeed.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index b2e9c8f0ddf7..9926d04831a2 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -944,6 +944,26 @@ static int aspeed_i2c_init(struct aspeed_i2c_bus
> *bus,
>  	return 0;
>  }
> 
> +#if IS_ENABLED(CONFIG_I2C_SLAVE)
> +void aspeed_set_slave_busy(struct i2c_adapter *adap, bool busy) {
> +	struct aspeed_i2c_bus *bus = i2c_get_adapdata(adap);
> +	unsigned long current_mask, flags;
> +
> +	spin_lock_irqsave(&bus->lock, flags);
> +
> +	current_mask = readl(bus->base + ASPEED_I2C_INTR_CTRL_REG);
Hello 
	Where the bus->base to be remap?

> +	if (busy)
> +		current_mask &= ~(ASPEED_I2CD_INTR_RX_DONE |
> ASPEED_I2CD_INTR_SLAVE_MATCH);
> +	else
> +		current_mask |= ASPEED_I2CD_INTR_RX_DONE |
> ASPEED_I2CD_INTR_SLAVE_MATCH;
> +	writel(current_mask, bus->base + ASPEED_I2C_INTR_CTRL_REG);
> +
> +	spin_unlock_irqrestore(&bus->lock, flags); }
> +EXPORT_SYMBOL_GPL(aspeed_set_slave_busy);
> +#endif
> +
>  static int aspeed_i2c_reset(struct aspeed_i2c_bus *bus)  {
>  	struct platform_device *pdev = to_platform_device(bus->dev);
> --
> 2.28.0

