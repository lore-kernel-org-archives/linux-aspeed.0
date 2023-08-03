From: Rob Herring <robh@kernel.org>
Date: Thu, 03 Aug 2023 16:42:52 -0600
Subject: [PATCH v2 12/23] ARM: rockchip: Drop unused includes
In-Reply-To: <20230803-dt-header-cleanups-for-soc-v2-0-d8de2cc88bff@kernel.org>
References: <20230803-dt-header-cleanups-for-soc-v2-0-d8de2cc88bff@kernel.org>
Message-ID: <20230803-dt-header-cleanups-for-soc-v2-12-d8de2cc88bff@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Several includes are not needed, so drop them.

of_platform.h is not needed, but it implicitly includes of.h which is
needed.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-rockchip/rockchip.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/mach-rockchip/rockchip.c b/arch/arm/mach-rockchip/rockchip.c
index beea4564eed4..82102fbabf92 100644
--- a/arch/arm/mach-rockchip/rockchip.c
+++ b/arch/arm/mach-rockchip/rockchip.c
@@ -9,15 +9,11 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/of.h>
 #include <linux/of_clk.h>
-#include <linux/of_platform.h>
-#include <linux/irqchip.h>
 #include <linux/clocksource.h>
-#include <linux/mfd/syscon.h>
-#include <linux/regmap.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
-#include <asm/hardware/cache-l2x0.h>
 #include "core.h"
 #include "pm.h"
 

-- 
2.40.1

