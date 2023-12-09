From: Andi Shyti <andi.shyti@kernel.org>
Date: Sat, 9 Dec 2023 21:44:55 +0100
Subject: [PATCH v3 2/2] i2c: aspeed: Acknowledge Tx done with and without
 ACK irq late
In-Reply-To: <20231208033142.1673232-3-quan@os.amperecomputing.com>
References: <20231208033142.1673232-1-quan@os.amperecomputing.com>
 <20231208033142.1673232-3-quan@os.amperecomputing.com>
Message-ID: <20231209204455.jxize3muvx7hhpos@zenone.zhora.eu>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Quan,

[...]

> -	/* Ack all interrupts except for Rx done */
> -	writel(irq_received & ~ASPEED_I2CD_INTR_RX_DONE,
> -	       bus->base + ASPEED_I2C_INTR_STS_REG);
> +
> +	/*
> +	 * Early acking of INTR_RX_DONE and INTR_TX_[ACK|NAK] would indicate HW to
> +	 * start receiving or sending new data, and this may cause a race condition
> +	 * as the irq handler has not yet handled these irqs but is being acked.
> +	 * Let's ack them late at the end of the irq handler when those are truly processed.
> +	 */
> +	irq_ack_last = ASPEED_I2CD_INTR_RX_DONE | ASPEED_I2CD_INTR_TX_ACK | ASPEED_I2CD_INTR_TX_NAK;
> +	writel(irq_received & ~irq_ack_last, bus->base + ASPEED_I2C_INTR_STS_REG);

I like Andrews suggestion of having irq_ack_last as a define that
is already negated, instead of negating it in the writel, which
makes it a bit difficult to read.

Besides, ack_last, as a name is not very meaningful, I'd rather
call it irq_ack_rx_tx (or something similar).

But I'm not going to block it for this, up to you if you want to
send a new version.

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
