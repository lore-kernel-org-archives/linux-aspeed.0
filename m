From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Mon, 02 Dec 2019 13:53:37 +0100
Subject: [PATCH v2 2/2] reset: simple: Add AST2600 compatibility string
In-Reply-To: <20191129000827.650566-3-joel@jms.id.au>
References: <20191129000827.650566-1-joel@jms.id.au>
 <20191129000827.650566-3-joel@jms.id.au>
Message-ID: <2498da189d5e21ae70fb6884df6fc16ecfee2087.camel@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2019-11-29 at 10:38 +1030, Joel Stanley wrote:
> From: Brad Bishop <bradleyb@fuzziesquirrel.com>
> 
> The AST2600 SoC contains the same LPC register set as the AST2500.

If the LPC register set is exactly the same, shouldn't AST2600 reuse the
AST2500 compatible, i.e.:
	compatible = "aspeed,ast2600-lpc-reset", "aspeed,ast2500-lpc-reset";
?

> 
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> Signed-off-by: Brad Bishop <bradleyb@fuzziesquirrel.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  drivers/reset/reset-simple.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
> index 067e7e7b34f1..795c9063fe7b 100644
> --- a/drivers/reset/reset-simple.c
> +++ b/drivers/reset/reset-simple.c
> @@ -125,6 +125,7 @@ static const struct of_device_id reset_simple_dt_ids[] = {
>  		.data = &reset_simple_active_low },
>  	{ .compatible = "aspeed,ast2400-lpc-reset" },
>  	{ .compatible = "aspeed,ast2500-lpc-reset" },
> +	{ .compatible = "aspeed,ast2600-lpc-reset" },
>  	{ .compatible = "bitmain,bm1880-reset",
>  		.data = &reset_simple_active_low },
>  	{ .compatible = "snps,dw-high-reset" },

regards
Philipp

