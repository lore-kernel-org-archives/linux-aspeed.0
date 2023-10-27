From: Dan Carpenter <dan.carpenter@linaro.org>
Date: Fri, 27 Oct 2023 07:38:19 +0300
Subject: [PATCH] soc: aspeed: lpc: Fix impossible judgment condition
In-Reply-To: <20231027020703.1231875-1-suhui@nfschina.com>
References: <20231027020703.1231875-1-suhui@nfschina.com>
Message-ID: <b0fb2821-42e2-40e1-88f4-0a697cdb2a97@kadam.mountain>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Oct 27, 2023 at 10:07:04AM +0800, Su Hui wrote:
> smatch error?
> drivers/soc/aspeed/aspeed-lpc-snoop.c:169
> aspeed_lpc_snoop_config_irq() warn: platform_get_irq() does not return zero
> 
> platform_get_irq() return non-zero IRQ number or negative error code,
> change '!lpc_snoop->irq' to 'lpc_snoop->irq < 0' to fix this.
> 
> Fixes: 9f4f9ae81d0a ("drivers/misc: add Aspeed LPC snoop driver")
> Signed-off-by: Su Hui <suhui@nfschina.com>

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

