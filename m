From: Peter Delevoryas <peter@pjd.dev>
Date: Thu, 21 Jul 2022 20:08:24 -0700
Subject: [PATCH] i2c: aspeed: Fix slave mode unexpected irq handler
In-Reply-To: <20220531093140.28770-1-ryan_chen@aspeedtech.com>
References: <20220531093140.28770-1-ryan_chen@aspeedtech.com>
Message-ID: <YtoUqH6uSNEKBbt5@pdel-mbp>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, May 31, 2022 at 05:31:40PM +0800, ryan_chen wrote:
> When i2c master send the new i2c transfer immediately
> after stop. the i2c slave will see the stop and new
> address match stage together. And it needs handle the
> stop first. otherwise will occur unexpected handle
> isr.

I think it would be helpful if you could include some driver trace messages to
indicate the sequence of events that lead you to make this change, like an
example of the problem happening.

> 
> Fixes: f327c686d3ba ("i2c: aspeed: added drover for Aspeed I2C)

Typo on "drover"? Actually, slave support wasn't included in this commit. I
think it should be:

Fixes: f9eb91350bb2 ("i2c: aspeed: added slave support for Aspeed I2C driver")

> Signed-off-by: ryan_chen <ryan_chen@aspeedtech.com>
> ---
>  drivers/i2c/busses/i2c-aspeed.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index 771e53d3d197..9f21e090ce47 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -252,6 +252,12 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
>  
>  	/* Slave was requested, restart state machine. */
>  	if (irq_status & ASPEED_I2CD_INTR_SLAVE_MATCH) {
> +		if (irq_status & ASPEED_I2CD_INTR_NORMAL_STOP &&
> +			bus->slave_state == ASPEED_I2C_SLAVE_WRITE_RECEIVED) {
> +			irq_handled |= ASPEED_I2CD_INTR_NORMAL_STOP;
> +			irq_status &= ~ASPEED_I2CD_INTR_NORMAL_STOP;
> +			i2c_slave_event(slave, I2C_SLAVE_STOP, &value);
> +		}

Ok, we might receive the STOP and START signals at the same time.

So, we need to make sure that we handle the STOP first. [1]

Why is this within the START case then? Can't we untangle this from the START
handling?

irq_status & ASPEED_I2CD_INTR_SLAVE_MATCH means SLAVE START, right?

We know we're in slave mode already because this is the slave IRQ handler.

And we can access the state of the bus through bus->slave_state, to see if it's
a spurious STOP or an expected one.

It would also be nice to unify the STOP handling code too, to make sure this
matches the normal STOP path that already exists below here.

[1] Although if that's the case, it seems like we might need to handle the
START first sometimes, depending on the current state, right?

Can we have the reverse case, where we see a START and the matching STOP
simultaneously? Perhaps that's already handled properly by the code since
it's structured chronologically.

>  		irq_handled |= ASPEED_I2CD_INTR_SLAVE_MATCH;
>  		bus->slave_state = ASPEED_I2C_SLAVE_START;
>  	}
> -- 
> 2.17.1
> 
