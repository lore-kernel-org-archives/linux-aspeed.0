From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
Date: Mon, 17 Jan 2022 00:05:48 +0000
Subject: [PATCH] soc: aspeed: Fix IRQ check in aspeed_lpc_snoop_config_irq
In-Reply-To: <20220114064357.18562-1-linmq006@gmail.com>
References: <20220114064357.18562-1-linmq006@gmail.com>
Message-ID: <HK0PR06MB377975CCF8230EB9FE35EC6A91579@HK0PR06MB3779.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> From: Miaoqian Lin <linmq006@gmail.com>
> Sent: Friday, January 14, 2022 2:44 PM
> 
> platform_get_irq() returns negative error number instead 0 on failure.
> And the doc of platform_get_irq() provides a usage example:
> 
>     int irq = platform_get_irq(pdev, 0);
>     if (irq < 0)
>         return irq;
> 
> Fix the check of return value to catch errors correctly.
> 
> Fixes: 524feb799408 ("soc: add aspeed folder and misc drivers")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>

Thanks.
