From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Fri, 14 Sep 2018 09:28:43 -0700
Subject: [PATCH] i2c: aspeed: Acknowledge most interrupts early in
 interrupt handler
In-Reply-To: <1536895810-28903-1-git-send-email-linux@roeck-us.net>
References: <1536895810-28903-1-git-send-email-linux@roeck-us.net>
Message-ID: <fbf54ca6-16b3-5e35-eac8-b3dab8118543@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 9/13/2018 8:30 PM, Guenter Roeck wrote:
> Commit 3e9efc3299dd ("i2c: aspeed: Handle master/slave combined irq events
> properly") moved interrupt acknowledgment to the end of the interrupt
> handler. In part this was done because the AST2500 datasheet says:
> 
>   I2CD10 Interrupt Status Register
>     bit 2 Receive Done Interrupt status
>           S/W needs to clear this status bit to allow next data receiving.
> 
> Acknowledging Receive Done before receive data was handled resulted in
> receive errors on high speed I2C busses.
> 
> However, interrupt acknowledgment was not only moved to the end of the
> interrupt handler for Receive Done Interrupt status, but for all interrupt
> status bits. This could result in race conditions if a second interrupt was
> received during interrupt handling and not handled but still acknowledged
> at the end of the interrupt handler.
> 
> Acknowledge only "Receive Done Interrupt status" late in the interrupt
> handler to solve the problem.
> 
> Fixes: 3e9efc3299dd ("i2c: aspeed: Handle master/slave combined irq events properly")
> Cc: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>   drivers/i2c/busses/i2c-aspeed.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index c258c4d9a4c0..3d518e09369f 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -552,6 +552,9 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
>   
>   	spin_lock(&bus->lock);
>   	irq_received = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
> +	/* Ack all interrupts except for Rx done */
> +	writel(irq_received & ~ASPEED_I2CD_INTR_RX_DONE,
> +	       bus->base + ASPEED_I2C_INTR_STS_REG);
>   	irq_remaining = irq_received;
>   
>   #if IS_ENABLED(CONFIG_I2C_SLAVE)
> @@ -584,8 +587,10 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
>   			"irq handled != irq. expected 0x%08x, but was 0x%08x\n",
>   			irq_received, irq_handled);
>   
> -	/* Ack all interrupt bits. */
> -	writel(irq_received, bus->base + ASPEED_I2C_INTR_STS_REG);
> +	/* Ack Rx done */
> +	if (irq_received & ASPEED_I2CD_INTR_RX_DONE)
> +		writel(ASPEED_I2CD_INTR_RX_DONE,
> +		       bus->base + ASPEED_I2C_INTR_STS_REG);
>   	spin_unlock(&bus->lock);
>   	return irq_remaining ? IRQ_NONE : IRQ_HANDLED;
>   }
> 

Looks good to me. Thanks! :)

Acked-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
