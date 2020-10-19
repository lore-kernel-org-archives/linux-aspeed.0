From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 20 Oct 2020 10:25:27 +1100
Subject: [PATCH 3/4] ftgmac100: Add a dummy read to ensure running sequence
In-Reply-To: <20201019085717.32413-4-dylan_hung@aspeedtech.com>
References: <20201019085717.32413-1-dylan_hung@aspeedtech.com>
 <20201019085717.32413-4-dylan_hung@aspeedtech.com>
Message-ID: <32d828b5f7046cd3682e49bbbdd4e17178c4d456.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2020-10-19 at 16:57 +0800, Dylan Hung wrote:
> On the AST2600 care must be taken to ensure writes appear correctly when
> modifying the interrupt reglated registers.
> 
> Add a function to perform a read after all writes to the IER and ISR registers.

You need to elaborate here. MMIO writes shouldn't get out of order,
though they can get posted. I thus object to that "blanket"
ftgmac100_write(). Instead, specifically add reads to flush posted
writes where they are necessary and document it with a comment. Unless
there's a deeper problem in the HW, in which case you need a better
explanation.

Cheers,
Ben.

> Fixes: 39bfab8844a0 ("net: ftgmac100: Add support for DT phy-handle property")
> Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  drivers/net/ethernet/faraday/ftgmac100.c | 38 ++++++++++++------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
> index 810bda80f138..0c67fc3e27df 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.c
> +++ b/drivers/net/ethernet/faraday/ftgmac100.c
> @@ -111,6 +111,14 @@ struct ftgmac100 {
>  	bool is_aspeed;
>  };
>  
> +/* Helper to ensure writes are observed with the correct ordering. Use only
> + * for IER and ISR accesses. */
> +static void ftgmac100_write(u32 val, void __iomem *addr)
> +{
> +	iowrite32(val, addr);
> +	ioread32(addr);
> +}
> +
>  static int ftgmac100_reset_mac(struct ftgmac100 *priv, u32 maccr)
>  {
>  	struct net_device *netdev = priv->netdev;
> @@ -1048,7 +1056,7 @@ static void ftgmac100_adjust_link(struct net_device *netdev)
>  		return;
>  
>  	/* Disable all interrupts */
> -	iowrite32(0, priv->base + FTGMAC100_OFFSET_IER);
> +	ftgmac100_write(0, priv->base + FTGMAC100_OFFSET_IER);
>  
>  	/* Reset the adapter asynchronously */
>  	schedule_work(&priv->reset_task);
> @@ -1246,7 +1254,7 @@ static irqreturn_t ftgmac100_interrupt(int irq, void *dev_id)
>  
>  	/* Fetch and clear interrupt bits, process abnormal ones */
>  	status = ioread32(priv->base + FTGMAC100_OFFSET_ISR);
> -	iowrite32(status, priv->base + FTGMAC100_OFFSET_ISR);
> +	ftgmac100_write(status, priv->base + FTGMAC100_OFFSET_ISR);
>  	if (unlikely(status & FTGMAC100_INT_BAD)) {
>  
>  		/* RX buffer unavailable */
> @@ -1266,7 +1274,7 @@ static irqreturn_t ftgmac100_interrupt(int irq, void *dev_id)
>  			if (net_ratelimit())
>  				netdev_warn(netdev,
>  					   "AHB bus error ! Resetting chip.\n");
> -			iowrite32(0, priv->base + FTGMAC100_OFFSET_IER);
> +			ftgmac100_write(0, priv->base + FTGMAC100_OFFSET_IER);
>  			schedule_work(&priv->reset_task);
>  			return IRQ_HANDLED;
>  		}
> @@ -1281,7 +1289,7 @@ static irqreturn_t ftgmac100_interrupt(int irq, void *dev_id)
>  	}
>  
>  	/* Only enable "bad" interrupts while NAPI is on */
> -	iowrite32(new_mask, priv->base + FTGMAC100_OFFSET_IER);
> +	ftgmac100_write(new_mask, priv->base + FTGMAC100_OFFSET_IER);
>  
>  	/* Schedule NAPI bh */
>  	napi_schedule_irqoff(&priv->napi);
> @@ -1320,8 +1328,7 @@ static int ftgmac100_poll(struct napi_struct *napi, int budget)
>  		ftgmac100_start_hw(priv);
>  
>  		/* Re-enable "bad" interrupts */
> -		iowrite32(FTGMAC100_INT_BAD,
> -			  priv->base + FTGMAC100_OFFSET_IER);
> +		ftgmac100_write(FTGMAC100_INT_BAD, priv->base + FTGMAC100_OFFSET_IER);
>  	}
>  
>  	/* As long as we are waiting for transmit packets to be
> @@ -1336,13 +1343,7 @@ static int ftgmac100_poll(struct napi_struct *napi, int budget)
>  		 * they were masked. So we clear them first, then we need
>  		 * to re-check if there's something to process
>  		 */
> -		iowrite32(FTGMAC100_INT_RXTX,
> -			  priv->base + FTGMAC100_OFFSET_ISR);
> -
> -		/* Push the above (and provides a barrier vs. subsequent
> -		 * reads of the descriptor).
> -		 */
> -		ioread32(priv->base + FTGMAC100_OFFSET_ISR);
> +		ftgmac100_write(FTGMAC100_INT_RXTX, priv->base + FTGMAC100_OFFSET_ISR);
>  
>  		/* Check RX and TX descriptors for more work to do */
>  		if (ftgmac100_check_rx(priv) ||
> @@ -1353,8 +1354,7 @@ static int ftgmac100_poll(struct napi_struct *napi, int budget)
>  		napi_complete(napi);
>  
>  		/* enable all interrupts */
> -		iowrite32(FTGMAC100_INT_ALL,
> -			  priv->base + FTGMAC100_OFFSET_IER);
> +		ftgmac100_write(FTGMAC100_INT_ALL, priv->base + FTGMAC100_OFFSET_IER);
>  	}
>  
>  	return work_done;
> @@ -1382,7 +1382,7 @@ static int ftgmac100_init_all(struct ftgmac100 *priv, bool ignore_alloc_err)
>  	netif_start_queue(priv->netdev);
>  
>  	/* Enable all interrupts */
> -	iowrite32(FTGMAC100_INT_ALL, priv->base + FTGMAC100_OFFSET_IER);
> +	ftgmac100_write(FTGMAC100_INT_ALL, priv->base + FTGMAC100_OFFSET_IER);
>  
>  	return err;
>  }
> @@ -1508,7 +1508,7 @@ static int ftgmac100_open(struct net_device *netdev)
>   err_irq:
>  	netif_napi_del(&priv->napi);
>   err_hw:
> -	iowrite32(0, priv->base + FTGMAC100_OFFSET_IER);
> +	ftgmac100_write(0, priv->base + FTGMAC100_OFFSET_IER);
>  	ftgmac100_free_rings(priv);
>  	return err;
>  }
> @@ -1526,7 +1526,7 @@ static int ftgmac100_stop(struct net_device *netdev)
>  	 */
>  
>  	/* disable all interrupts */
> -	iowrite32(0, priv->base + FTGMAC100_OFFSET_IER);
> +	ftgmac100_write(0, priv->base + FTGMAC100_OFFSET_IER);
>  
>  	netif_stop_queue(netdev);
>  	napi_disable(&priv->napi);
> @@ -1549,7 +1549,7 @@ static void ftgmac100_tx_timeout(struct net_device *netdev, unsigned int txqueue
>  	struct ftgmac100 *priv = netdev_priv(netdev);
>  
>  	/* Disable all interrupts */
> -	iowrite32(0, priv->base + FTGMAC100_OFFSET_IER);
> +	ftgmac100_write(0, priv->base + FTGMAC100_OFFSET_IER);
>  
>  	/* Do the reset outside of interrupt context */
>  	schedule_work(&priv->reset_task);

