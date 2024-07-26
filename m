From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 26 Jul 2024 15:30:43 +0930
Subject: [PATCH v1 1/1] ARM: dts: aspeed: minerva: add host0-ready pin
In-Reply-To: <20240711130501.2900301-2-yangchen.openbmc@gmail.com>
References: <20240711130501.2900301-1-yangchen.openbmc@gmail.com>
	 <20240711130501.2900301-2-yangchen.openbmc@gmail.com>
Message-ID: <a4c2a2c25c7582b7b45fc42662b60c589b4748d4.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2024-07-11 at 21:05 +0800, Yang Chen wrote:
> Add host0-ready pin for phosphor-state-manager.
> 
> Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
> ---
>  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
> index f5ac248097b4..41e2246cfbd1 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
> @@ -613,7 +613,7 @@ &gpio0 {
>  	/*P0-P7*/	"","","","","","","","",
>  	/*Q0-Q7*/	"","","","","","power-chassis-control","","",
>  	/*R0-R7*/	"","","","","","","","",
> -	/*S0-S7*/	"","","","","","","","",
> +	/*S0-S7*/	"","","","","","","","host0-ready",
>  	/*T0-T7*/	"","","","","","","","",
>  	/*U0-U7*/	"","","","","","","","",
>  	/*V0-V7*/	"","","","","BAT_DETECT","","power-chassis-good","",

Thanks, I've applied this to a tree for Joel to pick up.

Andrew
