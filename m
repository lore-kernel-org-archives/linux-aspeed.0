From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 8 Aug 2023 18:00:01 +0200
Subject: [PATCH 3/3] i3c: ast2600: Add reset deassertion for global
 registers
In-Reply-To: <20230808154241.749641-4-dylan_hung@aspeedtech.com>
References: <20230808154241.749641-1-dylan_hung@aspeedtech.com>
 <20230808154241.749641-4-dylan_hung@aspeedtech.com>
Message-ID: <f85df327-c321-8c1e-2043-c60210fbed56@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 08/08/2023 17:42, Dylan Hung wrote:
> Add missing reset deassertion of the I3C global control registers.
> 
> Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
> ---
>  drivers/i3c/master/ast2600-i3c-master.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/i3c/master/ast2600-i3c-master.c b/drivers/i3c/master/ast2600-i3c-master.c
> index 09ed19d489e9..5d9d060134e0 100644
> --- a/drivers/i3c/master/ast2600-i3c-master.c
> +++ b/drivers/i3c/master/ast2600-i3c-master.c
> @@ -11,6 +11,7 @@
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> +#include <linux/reset.h>
>  
>  #include "dw-i3c-master.h"
>  
> @@ -128,6 +129,7 @@ static int ast2600_i3c_probe(struct platform_device *pdev)
>  	struct device_node *np = pdev->dev.of_node;
>  	struct of_phandle_args gspec;
>  	struct ast2600_i3c *i3c;
> +	struct reset_control *rst;
>  	int rc;
>  
>  	i3c = devm_kzalloc(&pdev->dev, sizeof(*i3c), GFP_KERNEL);
> @@ -156,6 +158,13 @@ static int ast2600_i3c_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "invalid sda-pullup value %d\n",
>  			i3c->sda_pullup);
>  
> +	rst = devm_reset_control_get_shared(&pdev->dev, "global_rst");
> +	if (IS_ERR(rst)) {
> +		dev_err(&pdev->dev, "missing of invalid reset entry");
> +		return PTR_ERR(rst);

return dev_err_probe

Best regards,
Krzysztof

