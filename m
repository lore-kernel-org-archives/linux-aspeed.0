From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 18 Dec 2020 12:33:50 +1030
Subject: [PATCH v3] driver: aspeed: g6: Fix PWMG0 pinctrl setting
In-Reply-To: <20201217024912.3198-1-billy_tsai@aspeedtech.com>
References: <1e823780-b1ef-42dd-bb60-321b4d482d31@www.fastmail.com>
 <20201217024912.3198-1-billy_tsai@aspeedtech.com>
Message-ID: <890073c1-3905-4602-83f7-b823c4a4ee13@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 17 Dec 2020, at 13:19, Billy Tsai wrote:
> The SCU offset for signal PWM8 in group PWM8G0 is wrong, fix it from
> SCU414 to SCU4B4.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

Thanks Billy.

> ---
>  drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c 
> b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
> index b673a44ffa3b..aa53e9d3489b 100644
> --- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
> +++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
> @@ -367,7 +367,7 @@ FUNC_GROUP_DECL(RMII4, F24, E23, E24, E25, C25, 
> C24, B26, B25, B24);
>  
>  #define D22 40
>  SIG_EXPR_LIST_DECL_SESG(D22, SD1CLK, SD1, SIG_DESC_SET(SCU414, 8));
> -SIG_EXPR_LIST_DECL_SEMG(D22, PWM8, PWM8G0, PWM8, SIG_DESC_SET(SCU414, 8));
> +SIG_EXPR_LIST_DECL_SEMG(D22, PWM8, PWM8G0, PWM8, SIG_DESC_SET(SCU4B4, 8));
>  PIN_DECL_2(D22, GPIOF0, SD1CLK, PWM8);
>  GROUP_DECL(PWM8G0, D22);
>  
> -- 
> 2.17.1
> 
>
