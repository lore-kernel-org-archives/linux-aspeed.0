From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 18 Sep 2019 06:39:12 -0700
Subject: [PATCH] hwmon: (aspeed-pwm-tacho) Use
 devm_platform_ioremap_resource() in aspeed_pwm_tacho_probe()
In-Reply-To: <cd5bab7b-9333-2a43-bcf0-a47bbbe719eb@web.de>
References: <cd5bab7b-9333-2a43-bcf0-a47bbbe719eb@web.de>
Message-ID: <20190918133912.GA14788@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Sep 18, 2019 at 10:20:09AM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 18 Sep 2019 10:12:31 +0200
> 
> Simplify this function implementation by using a known wrapper function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/aspeed-pwm-tacho.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> --
> 2.23.0
> 
> diff --git a/drivers/hwmon/aspeed-pwm-tacho.c b/drivers/hwmon/aspeed-pwm-tacho.c
> index 40c489be62ea..33fb54845bf6 100644
> --- a/drivers/hwmon/aspeed-pwm-tacho.c
> +++ b/drivers/hwmon/aspeed-pwm-tacho.c
> @@ -891,17 +891,12 @@ static int aspeed_pwm_tacho_probe(struct platform_device *pdev)
>  	struct device_node *np, *child;
>  	struct aspeed_pwm_tacho_data *priv;
>  	void __iomem *regs;
> -	struct resource *res;
>  	struct device *hwmon;
>  	struct clk *clk;
>  	int ret;
> 
>  	np = dev->of_node;
> -
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res)
> -		return -ENOENT;
> -	regs = devm_ioremap_resource(dev, res);
> +	regs = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(regs))
>  		return PTR_ERR(regs);
>  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
