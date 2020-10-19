From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 20 Oct 2020 10:19:25 +1100
Subject: [PATCH 1/4] ftgmac100: Fix race issue on TX descriptor[0]
In-Reply-To: <20201019085717.32413-2-dylan_hung@aspeedtech.com>
References: <20201019085717.32413-1-dylan_hung@aspeedtech.com>
 <20201019085717.32413-2-dylan_hung@aspeedtech.com>
Message-ID: <be7a978c48c9f1c6c29583350dee6168385c3039.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2020-10-19 at 16:57 +0800, Dylan Hung wrote:
> These rules must be followed when accessing the TX descriptor:
> 
> 1. A TX descriptor is "cleanable" only when its value is non-zero
> and the owner bit is set to "software"

Can you elaborate ? What is the point of that change ? The owner bit
should be sufficient, why do we need to check other fields ?

> 2. A TX descriptor is "writable" only when its value is zero
> regardless the edotr mask.

Again, why is that ? Can you elaborate ? What race are you trying to
address here ?

Cheers,
Ben.

> Fixes: 52c0cae87465 ("ftgmac100: Remove tx descriptor accessors")
> Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  drivers/net/ethernet/faraday/ftgmac100.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/net/ethernet/faraday/ftgmac100.c
> b/drivers/net/ethernet/faraday/ftgmac100.c
> index 00024dd41147..7cacbe4aecb7 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.c
> +++ b/drivers/net/ethernet/faraday/ftgmac100.c
> @@ -647,6 +647,9 @@ static bool ftgmac100_tx_complete_packet(struct
> ftgmac100 *priv)
>  	if (ctl_stat & FTGMAC100_TXDES0_TXDMA_OWN)
>  		return false;
>  
> +	if ((ctl_stat & ~(priv->txdes0_edotr_mask)) == 0)
> +		return false;
> +
>  	skb = priv->tx_skbs[pointer];
>  	netdev->stats.tx_packets++;
>  	netdev->stats.tx_bytes += skb->len;
> @@ -756,6 +759,9 @@ static netdev_tx_t
> ftgmac100_hard_start_xmit(struct sk_buff *skb,
>  	pointer = priv->tx_pointer;
>  	txdes = first = &priv->txdes[pointer];
>  
> +	if (le32_to_cpu(txdes->txdes0) & ~priv->txdes0_edotr_mask)
> +		goto drop;
> +
>  	/* Setup it up with the packet head. Don't write the head to
> the
>  	 * ring just yet
>  	 */
> @@ -787,6 +793,10 @@ static netdev_tx_t
> ftgmac100_hard_start_xmit(struct sk_buff *skb,
>  		/* Setup descriptor */
>  		priv->tx_skbs[pointer] = skb;
>  		txdes = &priv->txdes[pointer];
> +
> +		if (le32_to_cpu(txdes->txdes0) & ~priv-
> >txdes0_edotr_mask)
> +			goto dma_err;
> +
>  		ctl_stat = ftgmac100_base_tx_ctlstat(priv, pointer);
>  		ctl_stat |= FTGMAC100_TXDES0_TXDMA_OWN;
>  		ctl_stat |= FTGMAC100_TXDES0_TXBUF_SIZE(len);

