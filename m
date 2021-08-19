From: Dylan Hung <dylan_hung@aspeedtech.com>
Date: Thu, 19 Aug 2021 03:29:27 +0000
Subject: [PATCH] soc: aspeed: socinfo: Add AST2625 variant
In-Reply-To: <20210818010534.2508122-1-joel@jms.id.au>
References: <20210818010534.2508122-1-joel@jms.id.au>
Message-ID: <HK0PR06MB28347997935D31D1F0799C8B9CC09@HK0PR06MB2834.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: joel.stan at gmail.com [mailto:joel.stan at gmail.com] On Behalf Of Joel
> Stanley
> Sent: 2021?8?18? 9:06 AM
> To: Dylan Hung <dylan_hung@aspeedtech.com>; Andrew Jeffery
> <andrew@aj.id.au>
> Cc: linux-arm-kernel at lists.infradead.org; linux-aspeed at lists.ozlabs.org
> Subject: [PATCH] soc: aspeed: socinfo: Add AST2625 variant
> 
> Add AST26XX series AST2625-A3 SOC ID, taken from the vendor u-boot SDK:
> 
>  arch/arm/mach-aspeed/ast2600/scu_info.c
>  +       SOC_ID("AST2625-A3", 0x0503040305030403),
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> Dylan, can you please review this for me?
> 
>  drivers/soc/aspeed/aspeed-socinfo.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/aspeed/aspeed-socinfo.c
> b/drivers/soc/aspeed/aspeed-socinfo.c
> index e3215f826d17..1ca140356a08 100644
> --- a/drivers/soc/aspeed/aspeed-socinfo.c
> +++ b/drivers/soc/aspeed/aspeed-socinfo.c
> @@ -26,6 +26,7 @@ static struct {
>  	{ "AST2600", 0x05000303 },
>  	{ "AST2620", 0x05010203 },
>  	{ "AST2605", 0x05030103 },
> +	{ "AST2625", 0x05030403 },
>  };
> 
>  static const char *siliconid_to_name(u32 siliconid)
> --
> 2.32.0

Reviewed-by: Dylan Hung <dylan_hung@aspeedtech.com>
