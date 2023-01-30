From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Mon, 30 Jan 2023 16:54:30 +0800
Subject: [PATCH] irqchip: aspeed: scu-ic add initial register
Message-ID: <20230130085430.635583-1-ryan_chen@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add register initial in probe. For avoid isr/ier is not initial.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 drivers/irqchip/irq-aspeed-scu-ic.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-aspeed-scu-ic.c b/drivers/irqchip/irq-aspeed-scu-ic.c
index 279e92cf0b16..94a7223e95df 100644
--- a/drivers/irqchip/irq-aspeed-scu-ic.c
+++ b/drivers/irqchip/irq-aspeed-scu-ic.c
@@ -17,8 +17,9 @@
 
 #define ASPEED_SCU_IC_REG		0x018
 #define ASPEED_SCU_IC_SHIFT		0
-#define ASPEED_SCU_IC_ENABLE		GENMASK(6, ASPEED_SCU_IC_SHIFT)
+#define ASPEED_SCU_IC_ENABLE		GENMASK(15, ASPEED_SCU_IC_SHIFT)
 #define ASPEED_SCU_IC_NUM_IRQS		7
+#define ASPEED_SCU_IC_STATUS		GENMASK(28, 16)
 #define ASPEED_SCU_IC_STATUS_SHIFT	16
 
 #define ASPEED_AST2600_SCU_IC0_REG	0x560
@@ -155,6 +156,8 @@ static int aspeed_scu_ic_of_init_common(struct aspeed_scu_ic *scu_ic,
 		rc = PTR_ERR(scu_ic->scu);
 		goto err;
 	}
+	regmap_write_bits(scu_ic->scu, scu_ic->reg, ASPEED_SCU_IC_STATUS, ASPEED_SCU_IC_STATUS);
+	regmap_write_bits(scu_ic->scu, scu_ic->reg, ASPEED_SCU_IC_ENABLE, 0);
 
 	irq = irq_of_parse_and_map(node, 0);
 	if (!irq) {
-- 
2.34.1

