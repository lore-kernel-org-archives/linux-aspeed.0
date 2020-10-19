From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 20 Oct 2020 10:26:17 +1100
Subject: [PATCH 4/4] ftgmac100: Restart MAC HW once
In-Reply-To: <20201019085717.32413-5-dylan_hung@aspeedtech.com>
References: <20201019085717.32413-1-dylan_hung@aspeedtech.com>
 <20201019085717.32413-5-dylan_hung@aspeedtech.com>
Message-ID: <fee066de5355c015da4e30957a1d8b8b5da1ef4d.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2020-10-19 at 16:57 +0800, Dylan Hung wrote:
> The interrupt handler may set the flag to reset the mac in the
> future,
> but that flag is not cleared once the reset has occured.
> 
> Fixes: 10cbd6407609 ("ftgmac100: Rework NAPI & interrupts handling")
> Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  drivers/net/ethernet/faraday/ftgmac100.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/faraday/ftgmac100.c
> b/drivers/net/ethernet/faraday/ftgmac100.c
> index 0c67fc3e27df..57736b049de3 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.c
> +++ b/drivers/net/ethernet/faraday/ftgmac100.c
> @@ -1326,6 +1326,7 @@ static int ftgmac100_poll(struct napi_struct
> *napi, int budget)
>  	 */
>  	if (unlikely(priv->need_mac_restart)) {
>  		ftgmac100_start_hw(priv);
> +		priv->need_mac_restart = false;
>  
>  		/* Re-enable "bad" interrupts */
>  		ftgmac100_write(FTGMAC100_INT_BAD, priv->base +
> FTGMAC100_OFFSET_IER);

