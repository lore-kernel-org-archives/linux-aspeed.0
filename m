From: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Date: Wed, 25 Sep 2024 17:07:32 +0200
Subject: [PATCH v3 1/5] usb: aspeed_udc: Use devm_clk_get_enabled()
 helpers
In-Reply-To: <20240826082140.2311-1-liulei.rjpt@vivo.com>
References: <20240826081900.2284-1-liulei.rjpt@vivo.com>
 <20240826082140.2311-1-liulei.rjpt@vivo.com>
Message-ID: <zi5lq44bc4vd33y42zkmn7hr7rw64wfxe2rvuvkekola6ctckc@buv7ybvq5skt>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

On Mon, Aug 26, 2024 at 04:21:39PM +0800, Lei Liu wrote:
> diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
> index f4781e611aaa..a362e31f7550 100644
> --- a/drivers/usb/gadget/udc/aspeed_udc.c
> +++ b/drivers/usb/gadget/udc/aspeed_udc.c
> @@ -1459,8 +1459,6 @@ static void ast_udc_remove(struct platform_device *pdev)
>  	ctrl = ast_udc_read(udc, AST_UDC_FUNC_CTRL) & ~USB_UPSTREAM_EN;
>  	ast_udc_write(udc, ctrl, AST_UDC_FUNC_CTRL);
>  
> -	clk_disable_unprepare(udc->clk);
> -
>  	spin_unlock_irqrestore(&udc->lock, flags);

Isn't it broken to call clk_disable_unprepare() while holding a
spinlock?

I guess that means that the remove path is untested in practise and this
patches fixes a sleep-in-atomic. IMHO this invalidates Ulf's concern in
his reply to the cover letter for this patch at least.
  
>  	if (udc->ep0_buf)
> @@ -1500,16 +1498,11 @@ static int ast_udc_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, udc);
>  
> -	udc->clk = devm_clk_get(&pdev->dev, NULL);
> +	udc->clk = devm_clk_get_enabled(&pdev->dev, NULL);
>  	if (IS_ERR(udc->clk)) {
>  		rc = PTR_ERR(udc->clk);

An error message here would be nice. Something like

	rc = dev_err_probe(&pdev->dev, PTR_ERR(udc->clk), "Failed to get clock\n");

should work.

>  		goto err;
>  	}
> -	rc = clk_prepare_enable(udc->clk);
> -	if (rc) {
> -		dev_err(&pdev->dev, "Failed to enable clock (0x%x)\n", rc);
> -		goto err;
> -	}
>  
>  	/* Check if we need to limit the HW to USB1 */
>  	max_speed = usb_get_maximum_speed(&pdev->dev);

Best regards
Uwe
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240925/5d621874/attachment-0001.sig>
