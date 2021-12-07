From: Thierry Reding <thierry.reding@gmail.com>
Date: Tue,  7 Dec 2021 15:17:22 +0100
Subject: [PATCH] i2c: aspeed: Remove unused includes
Message-ID: <20211207141722.440213-1-thierry.reding@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Thierry Reding <treding@nvidia.com>

No symbols from the linux/irqchip/chained_irq.h and linux/irqdomain.h
headers are used in the driver, so they can be removed.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/i2c/busses/i2c-aspeed.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
index 67e8b97c0c95..771e53d3d197 100644
--- a/drivers/i2c/busses/i2c-aspeed.c
+++ b/drivers/i2c/busses/i2c-aspeed.c
@@ -16,8 +16,6 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
-#include <linux/irqchip/chained_irq.h>
-#include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
-- 
2.33.1

