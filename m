From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Mon, 11 Dec 2023 11:06:45 +0700
Subject: [PATCH v3 2/2] i2c: aspeed: Acknowledge Tx done with and without
 ACK irq late
In-Reply-To: <20231209204455.jxize3muvx7hhpos@zenone.zhora.eu>
References: <20231208033142.1673232-1-quan@os.amperecomputing.com>
 <20231208033142.1673232-3-quan@os.amperecomputing.com>
 <20231209204455.jxize3muvx7hhpos@zenone.zhora.eu>
Message-ID: <8822a211-678f-49e5-8e6b-50b46dfc61b3@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 10/12/2023 03:44, Andi Shyti wrote:
> Hi Quan,
> 
> [...]
> 
>> -	/* Ack all interrupts except for Rx done */
>> -	writel(irq_received & ~ASPEED_I2CD_INTR_RX_DONE,
>> -	       bus->base + ASPEED_I2C_INTR_STS_REG);
>> +
>> +	/*
>> +	 * Early acking of INTR_RX_DONE and INTR_TX_[ACK|NAK] would indicate HW to
>> +	 * start receiving or sending new data, and this may cause a race condition
>> +	 * as the irq handler has not yet handled these irqs but is being acked.
>> +	 * Let's ack them late at the end of the irq handler when those are truly processed.
>> +	 */
>> +	irq_ack_last = ASPEED_I2CD_INTR_RX_DONE | ASPEED_I2CD_INTR_TX_ACK | ASPEED_I2CD_INTR_TX_NAK;
>> +	writel(irq_received & ~irq_ack_last, bus->base + ASPEED_I2C_INTR_STS_REG);
> 
> I like Andrews suggestion of having irq_ack_last as a define that
> is already negated, instead of negating it in the writel, which
> makes it a bit difficult to read.
> 

Yes, but the it still need to negate again when do the write to late ack 
them later in the end of irq handler. So I'll keep the define as below 
in my v4:

+#define ASPEED_I2CD_INTR_ACK_RX_TX	    \
+		(ASPEED_I2CD_INTR_RX_DONE | \
+		 ASPEED_I2CD_INTR_TX_ACK |  \
+		 ASPEED_I2CD_INTR_TX_NAK)

The early ack will look like this:

+		writel(irq_received & ~ASPEED_I2CD_INTR_ACK_RX_TX,
+		       bus->base + ASPEED_I2C_INTR_STS_REG);
+		readl(bus->base + ASPEED_I2C_INTR_STS_REG);

And the late ack:

-	/* Ack Rx done */
-	if (irq_received & ASPEED_I2CD_INTR_RX_DONE) {
-		writel(ASPEED_I2CD_INTR_RX_DONE,
+	if (irq_received & ASPEED_I2CD_INTR_ACK_RX_TX) {
+		writel(irq_received & ASPEED_I2CD_INTR_ACK_RX_TX,
  		       bus->base + ASPEED_I2C_INTR_STS_REG);
  		readl(bus->base + ASPEED_I2C_INTR_STS_REG);
  	}

> Besides, ack_last, as a name is not very meaningful, I'd rather
> call it irq_ack_rx_tx (or something similar).
> 
> But I'm not going to block it for this, up to you if you want to
> send a new version.
> 
> Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
> 

Thanks, Andi for the comments.

I will send out v4 to address those.

- Quan
