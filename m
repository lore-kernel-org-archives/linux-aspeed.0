From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 22 Jul 2022 11:44:31 +0930
Subject: [PATCH v2] soc: aspeed: Fix IRQ check in aspeed_lpc_snoop_config_irq
In-Reply-To: <20220603123904.30714-1-linmq006@gmail.com>
References: <20220603123904.30714-1-linmq006@gmail.com>
Message-ID: <0503175d-944d-4ffa-ba39-ff99797e78a1@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Fri, 3 Jun 2022, at 22:09, Miaoqian Lin wrote:
> platform_get_irq() returns negative error number instead 0 on failure.
> And the doc of platform_get_irq() provides a usage example:
>
>     int irq = platform_get_irq(pdev, 0);
>     if (irq < 0)
>         return irq;
>
> Fix the check of return value to catch errors correctly.
>
> Fixes: 9f4f9ae81d0a ("drivers/misc: add Aspeed LPC snoop driver")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
