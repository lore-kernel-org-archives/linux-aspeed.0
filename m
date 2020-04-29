From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 29 Apr 2020 08:12:45 +0000
Subject: [PATCH v0 linux master] i2c/busses: Avoid i2c interrupt status
 clear race condition.
In-Reply-To: <20200429075357.GA1957@kunai>
References: <20200429033737.2781-1-ryan_chen@aspeedtech.com>
 <20200429075357.GA1957@kunai>
Message-ID: <56add9c6e6b5410986325a1360466e4b@TWMBX02.aspeed.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

-----Original Message-----
From: Wolfram Sang [mailto:wsa at the-dreams.de] 
Sent: Wednesday, April 29, 2020 3:54 PM
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Brendan Higgins <brendanhiggins@google.com>; Benjamin Herrenschmidt <benh@kernel.crashing.org>; Joel Stanley <joel@jms.id.au>; Andrew Jeffery <andrew@aj.id.au>; linux-i2c at vger.kernel.org; openbmc at lists.ozlabs.org; linux-arm-kernel at lists.infradead.org; linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org
Subject: Re: [PATCH v0 linux master] i2c/busses: Avoid i2c interrupt status clear race condition.

On Wed, Apr 29, 2020 at 11:37:37AM +0800, ryan_chen wrote:
> In AST2600 there have a slow peripheral bus between CPU  and i2c 
> controller.
> Therefore GIC i2c interrupt status clear have delay timing, when CPU 
> issue write clear i2c controller interrupt status.
> To avoid this issue, the driver need have read after write  clear at 
> i2c ISR.
> 
> Signed-off-by: ryan_chen <ryan_chen@aspeedtech.com>

v0? is it a prototype?
[Ryan Chen] It is not prototype it is official patch.
And is there maybe a Fixes: tag for it?
[Ryan Chen] Yes it is a fix patch.

> ---
>  drivers/i2c/busses/i2c-aspeed.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-aspeed.c 
> b/drivers/i2c/busses/i2c-aspeed.c index 07c1993274c5..f51702d86a90 
> 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -603,6 +603,7 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
>  	/* Ack all interrupts except for Rx done */
>  	writel(irq_received & ~ASPEED_I2CD_INTR_RX_DONE,
>  	       bus->base + ASPEED_I2C_INTR_STS_REG);
> +	readl(bus->base + ASPEED_I2C_INTR_STS_REG);
>  	irq_remaining = irq_received;
>  
>  #if IS_ENABLED(CONFIG_I2C_SLAVE)
> @@ -645,9 +646,11 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
>  			irq_received, irq_handled);
>  
>  	/* Ack Rx done */
> -	if (irq_received & ASPEED_I2CD_INTR_RX_DONE)
> +	if (irq_received & ASPEED_I2CD_INTR_RX_DONE) {
>  		writel(ASPEED_I2CD_INTR_RX_DONE,
>  		       bus->base + ASPEED_I2C_INTR_STS_REG);
> +		readl(bus->base + ASPEED_I2C_INTR_STS_REG);
> +	}
>  	spin_unlock(&bus->lock);
>  	return irq_remaining ? IRQ_NONE : IRQ_HANDLED;  }
> --
> 2.17.1
> 
