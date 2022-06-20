From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Mon, 20 Jun 2022 10:50:55 +0200
Subject: [PATCH] pinctrl: aspeed: Fix typo in comment
In-Reply-To: <20220618130854.12321-1-wangxiang@cdjrlc.com>
References: <20220618130854.12321-1-wangxiang@cdjrlc.com>
Message-ID: <7dde0710-411d-52ef-df83-dcb3d667a9dc@molgen.mpg.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Xiang,


Am 18.06.22 um 15:08 schrieb Xiang wangx:
> Delete the redundant word 'and'.
> 
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>

Should this be Xiang Wang?

> ---
>   drivers/pinctrl/aspeed/pinmux-aspeed.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/aspeed/pinmux-aspeed.h b/drivers/pinctrl/aspeed/pinmux-aspeed.h
> index 4d7548686f39..aaa78a613196 100644
> --- a/drivers/pinctrl/aspeed/pinmux-aspeed.h
> +++ b/drivers/pinctrl/aspeed/pinmux-aspeed.h
> @@ -632,7 +632,7 @@ struct aspeed_pin_desc {
>   	SIG_EXPR_LIST_ALIAS(pin, sig, group)
>   
>   /**
> - * Similar to the above, but for pins with a dual expressions (DE) and
> + * Similar to the above, but for pins with a dual expressions (DE)
>    * and a single group (SG) of pins.
>    *
>    * @pin: The pin the signal will be routed to

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards

Paul
