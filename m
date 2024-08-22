From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 22 Aug 2024 12:26:51 +0800
Subject: [PATCH 2/5] usb: pxa27x_udc: Use devm_clk_get_enabled() helpers
In-Reply-To: <20240821121048.31566-3-liulei.rjpt@vivo.com>
References: <20240821121048.31566-1-liulei.rjpt@vivo.com>
 <20240821121048.31566-3-liulei.rjpt@vivo.com>
Message-ID: <2024082240-gallery-stinger-5901@gregkh>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Aug 21, 2024 at 08:10:40PM +0800, Lei Liu wrote:
> The devm_clk_get_enabled() helpers:
>     - call devm_clk_get()
>     - call clk_prepare_enable() and register what is needed in order to
>      call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code and avoids calls to clk_disable_unprepare().
> 
> Signed-off-by: Lei Liu <liulei.rjpt@vivo.com>
> ---
>  drivers/usb/gadget/udc/pxa27x_udc.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/pxa27x_udc.c b/drivers/usb/gadget/udc/pxa27x_udc.c
> index 1a6317e4b2a3..6e99e75f1acb 100644
> --- a/drivers/usb/gadget/udc/pxa27x_udc.c
> +++ b/drivers/usb/gadget/udc/pxa27x_udc.c
> @@ -2398,14 +2398,10 @@ static int pxa_udc_probe(struct platform_device *pdev)
>  	if (udc->gpiod)
>  		gpiod_direction_output(udc->gpiod, 0);
>  
> -	udc->clk = devm_clk_get(&pdev->dev, NULL);
> +	udc->clk = clk_prepare_enable(&pdev->dev, NULL);

You didn't test build this code :(

