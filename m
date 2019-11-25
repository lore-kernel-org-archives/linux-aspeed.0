From: Roy van Doormaal <roy.van.doormaal@prodrive-technologies.com>
Date: Mon, 25 Nov 2019 21:29:37 +0100
Subject: [PATCH] irqchip/aspeed-i2c-ic: Fix irq domain name memory leak
Message-ID: <20191125202937.23133-1-roy.van.doormaal@prodrive-technologies.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The aspeed irqchip driver overwrites the default irq domain name,
but doesn't free the existing domain name.
This patch frees the irq domain name before overwriting it.

kmemleak trace:

unreferenced object 0xb8004c40 (size 64):
comm "swapper", pid 0, jiffies 4294937303 (age 747.660s)
hex dump (first 32 bytes):
3a 61 68 62 3a 61 70 62 3a 62 75 73 40 31 65 37 :ahb:apb:bus at 1e7
38 61 30 30 30 3a 69 6e 74 65 72 72 75 70 74 2d 8a000:interrupt-
backtrace:
[<086b59b8>] kmemleak_alloc+0xa8/0xc0
[<b5a3490c>] __kmalloc_track_caller+0x118/0x1a0
[<f59c7ced>] kvasprintf+0x5c/0xc0
[<49275eec>] kasprintf+0x30/0x50
[<5713064b>] __irq_domain_add+0x184/0x25c
[<53c594d0>] aspeed_i2c_ic_of_init+0x9c/0x128
[<d8d7017e>] of_irq_init+0x1ec/0x314
[<f8405bf1>] irqchip_init+0x1c/0x24
[<7ef974b3>] init_IRQ+0x30/0x90
[<87a1438f>] start_kernel+0x28c/0x458
[< (null)>] (null)
[<f0763fdf>] 0xffffffff

Signed-off-by: Roy van Doormaal <roy.van.doormaal@prodrive-technologies.com>
---
 drivers/irqchip/irq-aspeed-i2c-ic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-aspeed-i2c-ic.c b/drivers/irqchip/irq-aspeed-i2c-ic.c
index 8d591c179f81..8081b8483a79 100644
--- a/drivers/irqchip/irq-aspeed-i2c-ic.c
+++ b/drivers/irqchip/irq-aspeed-i2c-ic.c
@@ -92,6 +92,8 @@ static int __init aspeed_i2c_ic_of_init(struct device_node *node,
 		goto err_iounmap;
 	}
 
+	if (i2c_ic->irq_domain->flags & IRQ_DOMAIN_NAME_ALLOCATED)
+		kfree(i2c_ic->irq_domain->name);
 	i2c_ic->irq_domain->name = "aspeed-i2c-domain";
 
 	irq_set_chained_handler_and_data(i2c_ic->parent_irq,
-- 
2.20.1

