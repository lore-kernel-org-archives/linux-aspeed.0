From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 30 Oct 2020 14:58:21 +1030
Subject: [PATCH] pinctrl: aspeed: Fix GPI only function problem.
In-Reply-To: <20201027084417.10137-1-billy_tsai@aspeedtech.com>
References: <20201027084417.10137-1-billy_tsai@aspeedtech.com>
Message-ID: <0d5e5d0a-cc74-4cb7-aed0-bb8c62661339@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Billy,

On Tue, 27 Oct 2020, at 19:14, Billy Tsai wrote:
> Some gpio pin at aspeed soc is input only and the prefix name of these
> pin is "GPI" only. This patch fine-tune the condition of GPIO check from
> "GPIO" to "GPI".
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

I'd like it if we were a bit more specific in the commit message, and even 
better if we update the comment in the code. A quick look at the code suggests 
this issue affects GPIO banks D and E in the AST2400 and AST2500, and banks T 
and U in the AST2600.

Functionally I think the patch is fine.

Cheers,

Andrew

> ---
>  drivers/pinctrl/aspeed/pinctrl-aspeed.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed.c 
> b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
> index 53f3f8aec695..a2f5ede3f897 100644
> --- a/drivers/pinctrl/aspeed/pinctrl-aspeed.c
> +++ b/drivers/pinctrl/aspeed/pinctrl-aspeed.c
> @@ -292,7 +292,7 @@ static bool aspeed_expr_is_gpio(const struct 
> aspeed_sig_expr *expr)
>  	 *
>  	 * expr->signal might look like "GPIOT3" in the GPIO case.
>  	 */
> -	return strncmp(expr->signal, "GPIO", 4) == 0;
> +	return strncmp(expr->signal, "GPI", 3) == 0;
>  }
>  
>  static bool aspeed_gpio_in_exprs(const struct aspeed_sig_expr **exprs)
> -- 
> 2.17.1
> 
>
