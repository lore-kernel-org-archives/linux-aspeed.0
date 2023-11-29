From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Wed, 29 Nov 2023 10:49:08 +1030
Subject: [PATCH v2 RESEND 1/2] i2c: aspeed: Fix unhandled Tx done with
 NAK
In-Reply-To: <20231128075236.2724038-2-quan@os.amperecomputing.com>
References: <20231128075236.2724038-1-quan@os.amperecomputing.com>
	 <20231128075236.2724038-2-quan@os.amperecomputing.com>
Message-ID: <4a9fe86f0349106adaa4e0c04c5839bab631f26c.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2023-11-28 at 14:52 +0700, Quan Nguyen wrote:
> Under normal conditions, after the last byte is sent by the Slave, the
> TX_NAK interrupt is raised.  However, it is also observed that
> sometimes the Master issues the next transaction too quickly while the
> Slave IRQ handler is not yet invoked and the TX_NAK interrupt for the
> last byte of the previous READ_PROCESSED state has not been ack?ed.
> This TX_NAK interrupt is then raised together with SLAVE_MATCH interrupt
> and RX_DONE interrupt of the next coming transaction from Master. The
> Slave IRQ handler currently handles the SLAVE_MATCH and RX_DONE, but
> ignores the TX_NAK, causing complaints such as
> "aspeed-i2c-bus 1e78a040.i2c-bus: irq handled != irq. Expected
> 0x00000086, but was 0x00000084"
> 
> This commit adds code to handle this case by emitting a SLAVE_STOP event
> for the TX_NAK before processing the RX_DONE for the coming transaction
> from the Master.
> 
> Fixes: f9eb91350bb2 ("i2c: aspeed: added slave support for Aspeed I2C driver")
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> ---
> v2:
>   + Split to separate series [Joel]
>   + Added the Fixes line [Joel]
>   + Revised commit message [Quan]
> 
> v1:
>   + First introduced in
> https://lore.kernel.org/all/20210519074934.20712-1-quan at os.amperecomputing.com/
> ---
>  drivers/i2c/busses/i2c-aspeed.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index 28e2a5fc4528..79476b46285b 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -253,6 +253,11 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
>  
>  	/* Slave was requested, restart state machine. */
>  	if (irq_status & ASPEED_I2CD_INTR_SLAVE_MATCH) {
> +		if (irq_status & ASPEED_I2CD_INTR_TX_NAK &&
> +		    bus->slave_state == ASPEED_I2C_SLAVE_READ_PROCESSED) {
> +			irq_handled |= ASPEED_I2CD_INTR_TX_NAK;
> +			i2c_slave_event(slave, I2C_SLAVE_STOP, &value);
> +		}

So we're already (partially) processing this a bit later on line 287:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/i2c/busses/i2c-aspeed.c?h=v6.7-rc3#n287

From the description of the problem in the commit message it sounds
like the ordering of the interrupt processing is incorrect. Prior to
this patch we have the following abstract ordering of interrupt
processing:

1. Process ASPEED_I2CD_INTR_SLAVE_MATCH
2. Process ASPEED_I2CD_INTR_TX_NAK when in ASPEED_I2C_SLAVE_READ_PROCESSED

With this patch we have:

1. If ASPEED_I2CD_INTR_SLAVE_MATCH then process ASPEED_I2CD_INTR_TX_NAK when in ASPEED_I2C_SLAVE_READ_PROCESSED
2. Process ASPEED_I2CD_INTR_SLAVE_MATCH
3. Process ASPEED_I2CD_INTR_TX_NAK when in ASPEED_I2C_SLAVE_READ_PROCESSED

That feels a bit complex and redundant. What I think we can have is:

1. Process ASPEED_I2CD_INTR_TX_NAK when in ASPEED_I2C_SLAVE_READ_PROCESSED
1. Process ASPEED_I2CD_INTR_SLAVE_MATCH

Moving back from the abstract to the concrete, implementing what I
believe we need would look something like this patch:

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 28e2a5fc4528..98dd0f35c9d3 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -251,6 +251,14 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
 
        command = readl(bus->base + ASPEED_I2C_CMD_REG);
 
+       /* Complete any active read */
+       if (irq_status & ASPEED_I2CD_INTR_TX_NAK &&
+           bus->slave_state == ASPEED_I2C_SLAVE_READ_PROCESSED) {
+               irq_handled |= ASPEED_I2CD_INTR_TX_NAK;
+               i2c_slave_event(slave, I2C_SLAVE_STOP, &value);
+               bus->slave_state = ASPEED_I2C_SLAVE_STOP;
+       }
+
        /* Slave was requested, restart state machine. */
        if (irq_status & ASPEED_I2CD_INTR_SLAVE_MATCH) {
                irq_handled |= ASPEED_I2CD_INTR_SLAVE_MATCH;
@@ -284,11 +292,6 @@ static u32 aspeed_i2c_slave_irq(struct aspeed_i2c_bus *bus, u32 irq_status)
                irq_handled |= ASPEED_I2CD_INTR_NORMAL_STOP;
                bus->slave_state = ASPEED_I2C_SLAVE_STOP;
        }
-       if (irq_status & ASPEED_I2CD_INTR_TX_NAK &&
-           bus->slave_state == ASPEED_I2C_SLAVE_READ_PROCESSED) {
-               irq_handled |= ASPEED_I2CD_INTR_TX_NAK;
-               bus->slave_state = ASPEED_I2C_SLAVE_STOP;
-       }
 
        switch (bus->slave_state) {
        case ASPEED_I2C_SLAVE_READ_REQUESTED:

Thoughts? I haven't tested it, it's just something to throw darts at.

Andrew

