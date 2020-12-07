From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 07 Dec 2020 10:42:52 +1030
Subject: =?UTF-8?Q?Re:_[PATCH]_usb:_gadget:_aspeed:_Remove_redundant_null_check_b?=
 =?UTF-8?Q?efore_clk=5Fdisable=5Funprepare?=
In-Reply-To: <20201204085150.3063-1-vulab@iscas.ac.cn>
References: <20201204085150.3063-1-vulab@iscas.ac.cn>
Message-ID: <661ad7bc-b299-4ada-be93-4e2925d79143@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 4 Dec 2020, at 19:21, Xu Wang wrote:
> Because clk_disable_unprepare() already checked NULL clock parameter,
> so the additional check is unnecessary, just remove it.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>

Pity we have to dig through the implementation of clk_disable_unprepare() to 
figure this out, but oh well.

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  drivers/usb/gadget/udc/aspeed-vhub/core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c 
> b/drivers/usb/gadget/udc/aspeed-vhub/core.c
> index be7bb64e3594..ea47f4b98de9 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
> @@ -282,8 +282,7 @@ static int ast_vhub_remove(struct platform_device 
> *pdev)
>  	       VHUB_CTRL_PHY_RESET_DIS,
>  	       vhub->regs + AST_VHUB_CTRL);
>  
> -	if (vhub->clk)
> -		clk_disable_unprepare(vhub->clk);
> +	clk_disable_unprepare(vhub->clk);
>  
>  	spin_unlock_irqrestore(&vhub->lock, flags);
>  
> -- 
> 2.17.1
> 
>
