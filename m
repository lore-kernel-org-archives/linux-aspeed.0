From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Wed, 13 Mar 2024 08:30:32 +0100
Subject: [PATCH] pinctrl: pinctrl-aspeed-g6: Fix register offset.
In-Reply-To: <20240313052027.1320489-1-billy_tsai@aspeedtech.com>
References: <20240313052027.1320489-1-billy_tsai@aspeedtech.com>
Message-ID: <173ca80c-1b27-4de9-9424-1f283e9d216b@molgen.mpg.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Billy,


Thank you for your patch. Some formal nits, I noticed.

Could you please name the register, and remove the dot/period in the 
commit message summary/title. Maybe:

pinctrl: pinctrl-aspeed-g6: Fix register offset of GPIOR-T

Am 13.03.24 um 06:20 schrieb Billy Tsai:
> The register offset to disable the internal pull-down of GPIOR~T is 0x630
> instead of 0x620.

Please mention the source (for example datasheet name and revision), and 
a possible reason, why this has been unnoticed several years, as the 
commit introducing this is present since v5.6-rc1.


Kind regards,

Paul


PS: Just a note, that Delphine sent the same patch [1], but replied to 
review the one from Billy instead.


[1]: 
https://lore.kernel.org/all/20240313024210.31452-1-Delphine_CC_Chiu at wiwynn.com/


> Fixes: 15711ba6ff19 ("pinctrl: aspeed-g6: Add AST2600 pinconf support")
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>   drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c | 34 +++++++++++-----------
>   1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
> index d376fa7114d1..029efe16f8cc 100644
> --- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
> +++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
> @@ -43,7 +43,7 @@
>   #define SCU614		0x614 /* Disable GPIO Internal Pull-Down #1 */
>   #define SCU618		0x618 /* Disable GPIO Internal Pull-Down #2 */
>   #define SCU61C		0x61c /* Disable GPIO Internal Pull-Down #3 */
> -#define SCU620		0x620 /* Disable GPIO Internal Pull-Down #4 */
> +#define SCU630		0x630 /* Disable GPIO Internal Pull-Down #4 */
>   #define SCU634		0x634 /* Disable GPIO Internal Pull-Down #5 */
>   #define SCU638		0x638 /* Disable GPIO Internal Pull-Down #6 */
>   #define SCU690		0x690 /* Multi-function Pin Control #24 */
> @@ -2495,38 +2495,38 @@ static struct aspeed_pin_config aspeed_g6_configs[] = {
>   	ASPEED_PULL_DOWN_PINCONF(D14, SCU61C, 0),
>   
>   	/* GPIOS7 */
> -	ASPEED_PULL_DOWN_PINCONF(T24, SCU620, 23),
> +	ASPEED_PULL_DOWN_PINCONF(T24, SCU630, 23),
>   	/* GPIOS6 */
> -	ASPEED_PULL_DOWN_PINCONF(P23, SCU620, 22),
> +	ASPEED_PULL_DOWN_PINCONF(P23, SCU630, 22),
>   	/* GPIOS5 */
> -	ASPEED_PULL_DOWN_PINCONF(P24, SCU620, 21),
> +	ASPEED_PULL_DOWN_PINCONF(P24, SCU630, 21),
>   	/* GPIOS4 */
> -	ASPEED_PULL_DOWN_PINCONF(R26, SCU620, 20),
> +	ASPEED_PULL_DOWN_PINCONF(R26, SCU630, 20),
>   	/* GPIOS3*/
> -	ASPEED_PULL_DOWN_PINCONF(R24, SCU620, 19),
> +	ASPEED_PULL_DOWN_PINCONF(R24, SCU630, 19),
>   	/* GPIOS2 */
> -	ASPEED_PULL_DOWN_PINCONF(T26, SCU620, 18),
> +	ASPEED_PULL_DOWN_PINCONF(T26, SCU630, 18),
>   	/* GPIOS1 */
> -	ASPEED_PULL_DOWN_PINCONF(T25, SCU620, 17),
> +	ASPEED_PULL_DOWN_PINCONF(T25, SCU630, 17),
>   	/* GPIOS0 */
> -	ASPEED_PULL_DOWN_PINCONF(R23, SCU620, 16),
> +	ASPEED_PULL_DOWN_PINCONF(R23, SCU630, 16),
>   
>   	/* GPIOR7 */
> -	ASPEED_PULL_DOWN_PINCONF(U26, SCU620, 15),
> +	ASPEED_PULL_DOWN_PINCONF(U26, SCU630, 15),
>   	/* GPIOR6 */
> -	ASPEED_PULL_DOWN_PINCONF(W26, SCU620, 14),
> +	ASPEED_PULL_DOWN_PINCONF(W26, SCU630, 14),
>   	/* GPIOR5 */
> -	ASPEED_PULL_DOWN_PINCONF(T23, SCU620, 13),
> +	ASPEED_PULL_DOWN_PINCONF(T23, SCU630, 13),
>   	/* GPIOR4 */
> -	ASPEED_PULL_DOWN_PINCONF(U25, SCU620, 12),
> +	ASPEED_PULL_DOWN_PINCONF(U25, SCU630, 12),
>   	/* GPIOR3*/
> -	ASPEED_PULL_DOWN_PINCONF(V26, SCU620, 11),
> +	ASPEED_PULL_DOWN_PINCONF(V26, SCU630, 11),
>   	/* GPIOR2 */
> -	ASPEED_PULL_DOWN_PINCONF(V24, SCU620, 10),
> +	ASPEED_PULL_DOWN_PINCONF(V24, SCU630, 10),
>   	/* GPIOR1 */
> -	ASPEED_PULL_DOWN_PINCONF(U24, SCU620, 9),
> +	ASPEED_PULL_DOWN_PINCONF(U24, SCU630, 9),
>   	/* GPIOR0 */
> -	ASPEED_PULL_DOWN_PINCONF(V25, SCU620, 8),
> +	ASPEED_PULL_DOWN_PINCONF(V25, SCU630, 8),
>   
>   	/* GPIOX7 */
>   	ASPEED_PULL_DOWN_PINCONF(AB10, SCU634, 31),
