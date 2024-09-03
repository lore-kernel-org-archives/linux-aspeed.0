From: Greg KH <gregkh@linuxfoundation.org>
Date: Tue, 3 Sep 2024 14:59:31 +0200
Subject: [PATCH] usb: gadget: aspeed_udc: use the defined variable to
 simplify code
In-Reply-To: <20240903123152.6980-1-tangbin@cmss.chinamobile.com>
References: <20240903123152.6980-1-tangbin@cmss.chinamobile.com>
Message-ID: <2024090325-thud-penalty-0283@gregkh>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Sep 03, 2024 at 08:31:52PM +0800, tangbin wrote:
> Use the defined variable 'dev' to make the code cleaner.
> 
> Signed-off-by: tangbin <tangbin@cmss.chinamobile.com>

Please use your full name, not your email alias.

> ---
>  drivers/usb/gadget/udc/aspeed_udc.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
> index f4781e611..702d4806c 100644
> --- a/drivers/usb/gadget/udc/aspeed_udc.c
> +++ b/drivers/usb/gadget/udc/aspeed_udc.c
> @@ -1479,7 +1479,7 @@ static int ast_udc_probe(struct platform_device *pdev)
>  	struct ast_udc_dev *udc;
>  	int rc;
>  
> -	udc = devm_kzalloc(&pdev->dev, sizeof(struct ast_udc_dev), GFP_KERNEL);
> +	udc = devm_kzalloc(dev, sizeof(struct ast_udc_dev), GFP_KERNEL);

<snip>

I see the goal, but unless you have this hardware and can test this
change out, I'm going to leave it as-is as nothing should have been
changed here.

sorry,

greg k-h
