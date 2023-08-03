From: Rob Herring <robh@kernel.org>
Date: Thu, 03 Aug 2023 16:42:53 -0600
Subject: [PATCH v2 13/23] ARM: versatile: Drop unused includes
In-Reply-To: <20230803-dt-header-cleanups-for-soc-v2-0-d8de2cc88bff@kernel.org>
References: <20230803-dt-header-cleanups-for-soc-v2-0-d8de2cc88bff@kernel.org>
Message-ID: <20230803-dt-header-cleanups-for-soc-v2-13-d8de2cc88bff@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Several includes are not needed, so drop them.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-versatile/realview.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-versatile/realview.c b/arch/arm/mach-versatile/realview.c
index feab66080ba2..a3933e2373d5 100644
--- a/arch/arm/mach-versatile/realview.c
+++ b/arch/arm/mach-versatile/realview.c
@@ -4,9 +4,7 @@
  *
  * Author: Linus Walleij <linus.walleij@linaro.org>
  */
-#include <linux/of_platform.h>
 #include <asm/mach/arch.h>
-#include <asm/hardware/cache-l2x0.h>
 
 static const char *const realview_dt_platform_compat[] __initconst = {
 	"arm,realview-eb",

-- 
2.40.1

