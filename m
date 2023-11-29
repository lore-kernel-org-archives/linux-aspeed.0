From: Andi Shyti <andi.shyti@kernel.org>
Date: Wed, 29 Nov 2023 01:45:09 +0100
Subject: [PATCH v2 RESEND 2/2] i2c: aspeed: Acknowledge Tx done with and
 without ACK irq late
In-Reply-To: <20231128075236.2724038-3-quan@os.amperecomputing.com>
References: <20231128075236.2724038-1-quan@os.amperecomputing.com>
 <20231128075236.2724038-3-quan@os.amperecomputing.com>
Message-ID: <20231129004509.ilriuwm3hulvy67l@zenone.zhora.eu>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Quan,

On Tue, Nov 28, 2023 at 02:52:36PM +0700, Quan Nguyen wrote:
> Commit 2be6b47211e1 ("i2c: aspeed: Acknowledge most interrupts early in
> interrupt handler") acknowledges most interrupts early before the slave
> irq handler is executed, except for the "Receive Done Interrupt status"
> which is acknowledged late in the interrupt.
> However, it is observed that the early acknowledgment of "Transmit Done
> Interrupt Status" (with ACK or NACK) often causes the interrupt to be
> raised in READ REQUEST state, resulting in "Unexpected ACK on read
> request." complaint messages.
> 
> Assuming that the "Transmit Done" interrupt should only be acknowledged
> once it is truly processed, this commit fixes this issue by acknowledging
> this interrupt for both ACK and NACK cases late in the interrupt handler
> also.
> 
> Fixes: 2be6b47211e1 ("i2c: aspeed: Acknowledge most interrupts early in interrupt handler")
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> ---
> v2:
>   + Split to separate series [Joel]
>   + Added the Fixes line [Joel]
>   + Fixed multiline comment [Joel]
>   + Refactor irq clearing code [Joel, Guenter]
>   + Revised commit message [Joel]
>   + Revised commit message [Quan]
>   + About a note to remind why the readl() should immediately follow the
> writel() to fix the race condition when clearing irq status from commit
> c926c87b8e36 ("i2c: aspeed: Avoid i2c interrupt status clear race
> condition"), I think it looks straight forward in this patch and decided
> not to add that note. [Joel]
> 
> v1:
>   + First introduced in
> https://lore.kernel.org/all/20210519074934.20712-1-quan at os.amperecomputing.com/
> ---
>  drivers/i2c/busses/i2c-aspeed.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index 79476b46285b..3231f430e335 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -611,8 +611,9 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
>  
>  	spin_lock(&bus->lock);
>  	irq_received = readl(bus->base + ASPEED_I2C_INTR_STS_REG);
> -	/* Ack all interrupts except for Rx done */
> -	writel(irq_received & ~ASPEED_I2CD_INTR_RX_DONE,
> +	/* Ack all interrupts except for Rx done and Tx done with/without ACK */
> +	writel(irq_received &
> +	       ~(ASPEED_I2CD_INTR_RX_DONE | ASPEED_I2CD_INTR_TX_ACK | ASPEED_I2CD_INTR_TX_NAK),
>  	       bus->base + ASPEED_I2C_INTR_STS_REG);
>  	readl(bus->base + ASPEED_I2C_INTR_STS_REG);
>  	irq_received &= ASPEED_I2CD_INTR_RECV_MASK;
> @@ -657,12 +658,12 @@ static irqreturn_t aspeed_i2c_bus_irq(int irq, void *dev_id)
>  			"irq handled != irq. expected 0x%08x, but was 0x%08x\n",
>  			irq_received, irq_handled);
>  
> -	/* Ack Rx done */
> -	if (irq_received & ASPEED_I2CD_INTR_RX_DONE) {
> -		writel(ASPEED_I2CD_INTR_RX_DONE,
> -		       bus->base + ASPEED_I2C_INTR_STS_REG);
> -		readl(bus->base + ASPEED_I2C_INTR_STS_REG);
> -	}
> +	/* Ack Rx done and Tx done with/without ACK */
> +	writel(irq_received &
> +	       (ASPEED_I2CD_INTR_RX_DONE | ASPEED_I2CD_INTR_TX_ACK | ASPEED_I2CD_INTR_TX_NAK),
> +	       bus->base + ASPEED_I2C_INTR_STS_REG);
> +	readl(bus->base + ASPEED_I2C_INTR_STS_REG);

So, you are acknowledging everything here. Why wasn?t it done
this way in the first place?

I would appreciate a comment here from Guenter, whose commit you
are fixing.

Thanks,
Andi

>  	spin_unlock(&bus->lock);
>  	return irq_remaining ? IRQ_NONE : IRQ_HANDLED;
>  }
> -- 
> 2.35.1
> 
