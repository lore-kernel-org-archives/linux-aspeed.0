From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 6 Jan 2021 09:54:30 +0000
Subject: [PATCH v2 1/2] misc: Add clock control logic into Aspeed LPC
 SNOOP driver
In-Reply-To: <20201208091748.1920-1-wangzhiqiang.bj@bytedance.com>
References: <20201208091748.1920-1-wangzhiqiang.bj@bytedance.com>
Message-ID: <HK0PR06MB33807C054FCE9E355346E204F2D00@HK0PR06MB3380.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello John, Joel, Jae,
	For this should be set LCLK to be CRITICAL it will fix LPC related driver. (KCS/BT/SNOOP)
	I have send the patch before.	
	https://patchwork.ozlabs.org/project/linux-aspeed/patch/20200928070108.14040-2-ryan_chen at aspeedtech.com/

Hello Joel,
	Will you consider this patch? 
	Beside KCS/BT/SNOOP, UART1/UART2 will be most related issue for host side. 


> -----Original Message-----
> From: Linux-aspeed
> <linux-aspeed-bounces+ryan_chen=aspeedtech.com@lists.ozlabs.org> On
> Behalf Of John Wang
> Sent: Tuesday, December 8, 2020 5:18 PM
> To: xuxiaohan at bytedance.com; yulei.sh at bytedance.com
> Cc: Robert Lippert <rlippert@google.com>; moderated list:ARM/ASPEED
> MACHINE SUPPORT <linux-aspeed@lists.ozlabs.org>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; Vernon Mauery
> <vernon.mauery@linux.intel.com>; open list <linux-kernel@vger.kernel.org>;
> Jae Hyun Yoo <jae.hyun.yoo@intel.com>; Patrick Venture
> <venture@google.com>; moderated list:ARM/ASPEED MACHINE SUPPORT
> <linux-arm-kernel@lists.infradead.org>
> Subject: [PATCH v2 1/2] misc: Add clock control logic into Aspeed LPC SNOOP
> driver
> 
> From: Jae Hyun Yoo <jae.hyun.yoo@intel.com>
> 
> If LPC SNOOP driver is registered ahead of lpc-ctrl module, LPC SNOOP block
> will be enabled without heart beating of LCLK until lpc-ctrl enables the LCLK.
> This issue causes improper handling on host interrupts when the host sends
> interrupt in that time frame.
> Then kernel eventually forcibly disables the interrupt with dumping stack and
> printing a 'nobody cared this irq' message out.
> 
> To prevent this issue, all LPC sub-nodes should enable LCLK individually so this
> patch adds clock control logic into the LPC SNOOP driver.
> 
> Fixes: 3772e5da4454 ("drivers/misc: Aspeed LPC snoop output using misc
> chardev")
> 
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@intel.com>
> Signed-off-by: Vernon Mauery <vernon.mauery@linux.intel.com>
> Signed-off-by: John Wang <wangzhiqiang.bj@bytedance.com>
> ---
> v2:
>   reword: Add fixes line
> ---
>  drivers/soc/aspeed/aspeed-lpc-snoop.c | 30 ++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> index 682ba0eb4eba..20acac6342ef 100644
> --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> @@ -11,6 +11,7 @@
>   */
> 
>  #include <linux/bitops.h>
> +#include <linux/clk.h>
>  #include <linux/interrupt.h>
>  #include <linux/fs.h>
>  #include <linux/kfifo.h>
> @@ -67,6 +68,7 @@ struct aspeed_lpc_snoop_channel {  struct
> aspeed_lpc_snoop {
>  	struct regmap		*regmap;
>  	int			irq;
> +	struct clk		*clk;
>  	struct aspeed_lpc_snoop_channel chan[NUM_SNOOP_CHANNELS];  };
> 
> @@ -282,22 +284,42 @@ static int aspeed_lpc_snoop_probe(struct
> platform_device *pdev)
>  		return -ENODEV;
>  	}
> 
> +	lpc_snoop->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(lpc_snoop->clk)) {
> +		rc = PTR_ERR(lpc_snoop->clk);
> +		if (rc != -EPROBE_DEFER)
> +			dev_err(dev, "couldn't get clock\n");
> +		return rc;
> +	}
> +	rc = clk_prepare_enable(lpc_snoop->clk);
> +	if (rc) {
> +		dev_err(dev, "couldn't enable clock\n");
> +		return rc;
> +	}
> +
>  	rc = aspeed_lpc_snoop_config_irq(lpc_snoop, pdev);
>  	if (rc)
> -		return rc;
> +		goto err;
> 
>  	rc = aspeed_lpc_enable_snoop(lpc_snoop, dev, 0, port);
>  	if (rc)
> -		return rc;
> +		goto err;
> 
>  	/* Configuration of 2nd snoop channel port is optional */
>  	if (of_property_read_u32_index(dev->of_node, "snoop-ports",
>  				       1, &port) == 0) {
>  		rc = aspeed_lpc_enable_snoop(lpc_snoop, dev, 1, port);
> -		if (rc)
> +		if (rc) {
>  			aspeed_lpc_disable_snoop(lpc_snoop, 0);
> +			goto err;
> +		}
>  	}
> 
> +	return 0;
> +
> +err:
> +	clk_disable_unprepare(lpc_snoop->clk);
> +
>  	return rc;
>  }
> 
> @@ -309,6 +331,8 @@ static int aspeed_lpc_snoop_remove(struct
> platform_device *pdev)
>  	aspeed_lpc_disable_snoop(lpc_snoop, 0);
>  	aspeed_lpc_disable_snoop(lpc_snoop, 1);
> 
> +	clk_disable_unprepare(lpc_snoop->clk);
> +
>  	return 0;
>  }
> 
> --
> 2.25.1

