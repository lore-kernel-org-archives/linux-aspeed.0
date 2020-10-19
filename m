From: Tao Ren <rentao.bupt@gmail.com>
Date: Sun, 18 Oct 2020 22:33:25 -0700
Subject: [PATCH] gpio: aspeed: fix ast2600 bank properties
In-Reply-To: <20201019045026.10732-1-billy_tsai@aspeedtech.com>
References: <20201019045026.10732-1-billy_tsai@aspeedtech.com>
Message-ID: <20201019053324.GA4300@taoren-ubuntu-R90MNF91>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Billy,

On Mon, Oct 19, 2020 at 12:50:26PM +0800, Billy Tsai wrote:
> GPIO_T is mapped to the most significant byte of input/output mask, and
> the byte in "output" mask should be 0 because GPIO_T is input only. All
> the other bits need to be 1 because GPIO_Q/R/S support both input and
> output modes.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

You may want to add "Fixes" tag if you take it as a bug fix? For
example:

Fixes: ab4a85534c3e ("gpio: aspeed: Add in ast2600 details to Aspeed driver")

> ---
>  drivers/gpio/gpio-aspeed.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> index d07bf2c3f136..f24754b3f6d1 100644
> --- a/drivers/gpio/gpio-aspeed.c
> +++ b/drivers/gpio/gpio-aspeed.c
> @@ -1114,6 +1114,7 @@ static const struct aspeed_gpio_config ast2500_config =
>  
>  static const struct aspeed_bank_props ast2600_bank_props[] = {
>  	/*     input	  output   */
> +	{4, 0xffffffff,  0x00ffffff}, /* Q/R/S/T */

Reviewed-by: Tao Ren <rentao.bupt@gmail.com>

>  	{5, 0xffffffff,  0xffffff00}, /* U/V/W/X */
>  	{6, 0x0000ffff,  0x0000ffff}, /* Y/Z */
>  	{ },
> -- 
> 2.17.1
> 

Cheers,

Tao
