From: Rob Herring <robh@kernel.org>
Date: Thu, 03 Aug 2023 16:42:48 -0600
Subject: [PATCH v2 08/23] ARM: nomadik: Drop unused includes
In-Reply-To: <20230803-dt-header-cleanups-for-soc-v2-0-d8de2cc88bff@kernel.org>
References: <20230803-dt-header-cleanups-for-soc-v2-0-d8de2cc88bff@kernel.org>
Message-ID: <20230803-dt-header-cleanups-for-soc-v2-8-d8de2cc88bff@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Several includes are not needed, so drop them.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-nomadik/cpu-8815.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
index 51f88a297c4e..0eed60917dcf 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -5,25 +5,12 @@
 
 #include <linux/types.h>
 #include <linux/init.h>
-#include <linux/device.h>
-#include <linux/amba/bus.h>
-#include <linux/platform_device.h>
 #include <linux/io.h>
-#include <linux/slab.h>
-#include <linux/irq.h>
-#include <linux/dma-mapping.h>
-#include <linux/of_irq.h>
-#include <linux/of_address.h>
-#include <linux/of_platform.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <asm/mach/time.h>
 #include <asm/mach-types.h>
 
-#include <asm/cacheflush.h>
-#include <asm/hardware/cache-l2x0.h>
-
 /*
  * These are the only hard-coded address offsets we still have to use.
  */

-- 
2.40.1

