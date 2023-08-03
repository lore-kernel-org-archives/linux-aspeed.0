From: Rob Herring <robh@kernel.org>
Date: Thu, 03 Aug 2023 16:42:55 -0600
Subject: [PATCH v2 15/23] ARM: spear: Explicitly include correct DT
 includes
In-Reply-To: <20230803-dt-header-cleanups-for-soc-v2-0-d8de2cc88bff@kernel.org>
References: <20230803-dt-header-cleanups-for-soc-v2-0-d8de2cc88bff@kernel.org>
Message-ID: <20230803-dt-header-cleanups-for-soc-v2-15-d8de2cc88bff@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it was merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-spear/spear1340.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-spear/spear1340.c b/arch/arm/mach-spear/spear1340.c
index a391f154eff9..70986ef6c877 100644
--- a/arch/arm/mach-spear/spear1340.c
+++ b/arch/arm/mach-spear/spear1340.c
@@ -10,7 +10,7 @@
 
 #define pr_fmt(fmt) "SPEAr1340: " fmt
 
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <asm/mach/arch.h>
 #include "generic.h"
 

-- 
2.40.1

