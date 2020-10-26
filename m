From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 26 Oct 2020 11:56:59 +1030
Subject: [PATCH 3/3] pinctrl: aspeed-g6: Add sgpiom2 pinctrl setting
In-Reply-To: <20201012033150.21056-4-billy_tsai@aspeedtech.com>
References: <20201012033150.21056-1-billy_tsai@aspeedtech.com>
 <20201012033150.21056-4-billy_tsai@aspeedtech.com>
Message-ID: <ce3dce98-1daa-47bb-a688-0d5a743e45b2@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Mon, 12 Oct 2020, at 14:01, Billy Tsai wrote:
> At ast2600a1 we change feature of master sgpio to 2 sets.
> So this patch is used to add the pinctrl setting of the new sgpio.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi   |  5 ++++
>  drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c | 30 +++++++++++++++++++---
>  2 files changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi 
> b/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi
> index 7028e21bdd98..a16ecf08e307 100644
> --- a/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi
> @@ -862,6 +862,11 @@
>  		groups = "SGPM1";
>  	};
>  
> +	pinctrl_sgpm2_default: sgpm2_default {
> +		function = "SGPM2";
> +		groups = "SGPM2";
> +	};
> +
>  	pinctrl_sgps1_default: sgps1_default {
>  		function = "SGPS1";
>  		groups = "SGPS1";
> diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c 
> b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
> index 34803a6c7664..b673a44ffa3b 100644
> --- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
> +++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
> @@ -46,8 +46,10 @@
>  #define SCU620		0x620 /* Disable GPIO Internal Pull-Down #4 */
>  #define SCU634		0x634 /* Disable GPIO Internal Pull-Down #5 */
>  #define SCU638		0x638 /* Disable GPIO Internal Pull-Down #6 */
> +#define SCU690		0x690 /* Multi-function Pin Control #24 */
>  #define SCU694		0x694 /* Multi-function Pin Control #25 */
>  #define SCU69C		0x69C /* Multi-function Pin Control #27 */
> +#define SCU6D0		0x6D0 /* Multi-function Pin Control #28 */
>  #define SCUC20		0xC20 /* PCIE configuration Setting Control */
>  
>  #define ASPEED_G6_NR_PINS 256
> @@ -81,13 +83,21 @@ FUNC_GROUP_DECL(I2C12, L26, K24);
>  #define K26 4
>  SIG_EXPR_LIST_DECL_SESG(K26, MACLINK1, MACLINK1, SIG_DESC_SET(SCU410, 4));
>  SIG_EXPR_LIST_DECL_SESG(K26, SCL13, I2C13, SIG_DESC_SET(SCU4B0, 4));
> -PIN_DECL_2(K26, GPIOA4, MACLINK1, SCL13);
> +/*SGPM2 is A1 Only */
> +SIG_EXPR_LIST_DECL_SESG(K26, SGPM2CLK, SGPM2, SIG_DESC_SET(SCU6D0, 4),
> +			  SIG_DESC_CLEAR(SCU410, 4), SIG_DESC_CLEAR(SCU4B0, 4),
> +			  SIG_DESC_CLEAR(SCU690, 4));
> +PIN_DECL_3(K26, GPIOA4, SGPM2CLK, MACLINK1, SCL13);
>  FUNC_GROUP_DECL(MACLINK1, K26);
>  
>  #define L24 5
>  SIG_EXPR_LIST_DECL_SESG(L24, MACLINK2, MACLINK2, SIG_DESC_SET(SCU410, 5));
>  SIG_EXPR_LIST_DECL_SESG(L24, SDA13, I2C13, SIG_DESC_SET(SCU4B0, 5));
> -PIN_DECL_2(L24, GPIOA5, MACLINK2, SDA13);
> +/*SGPM2 is A1 Only */
> +SIG_EXPR_LIST_DECL_SESG(L24, SGPM2LD, SGPM2, SIG_DESC_SET(SCU6D0, 5),
> +			  SIG_DESC_CLEAR(SCU410, 5), SIG_DESC_CLEAR(SCU4B0, 5),
> +			  SIG_DESC_CLEAR(SCU690, 5));

A few things:

1. It looks like the Multi-function Pins Mapping and Control table in section 5.1 of the datasheet only tells part of the story. It lists SGPS2 on the pins you've modified in this patch but not SGPM2. However, the table in section 2.1 (Pin Description) does outline SGPM2 and SGPS2 are routed via the same pins, though this does not listed the associated registers and bit fields. Can we fix the table in 5.1 so it's easier to review this patch?

2. We don't need to specify the _CLEAR() behaviour here as this is implied by the process to disable the higher priority mux configurations. It should be enough to do:

SIG_EXPR_LIST_DECL_SESG(L24, SGPM2LD, SGPM2, SIG_DESC_SET(SCU6D0, 5));

However, this requires that we also define the priorities correctly, so:

3. Can we add both the SGPS2 and SGPM2 configurations so we have a complete definition for the pins?

Cheers,

Andrew
