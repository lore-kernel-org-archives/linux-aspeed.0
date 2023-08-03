From: Rob Herring <robh@kernel.org>
Date: Thu, 03 Aug 2023 16:42:47 -0600
Subject: [PATCH v2 07/23] ARM: mmp: Drop unused includes
In-Reply-To: <20230803-dt-header-cleanups-for-soc-v2-0-d8de2cc88bff@kernel.org>
References: <20230803-dt-header-cleanups-for-soc-v2-0-d8de2cc88bff@kernel.org>
Message-ID: <20230803-dt-header-cleanups-for-soc-v2-7-d8de2cc88bff@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Several includes are not needed, so drop them.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-mmp/mmp-dt.c  | 3 ---
 arch/arm/mach-mmp/mmp2-dt.c | 4 ----
 arch/arm/mach-mmp/mmp3.c    | 4 ----
 3 files changed, 11 deletions(-)

diff --git a/arch/arm/mach-mmp/mmp-dt.c b/arch/arm/mach-mmp/mmp-dt.c
index 3f43c0867dca..8479996a8f2e 100644
--- a/arch/arm/mach-mmp/mmp-dt.c
+++ b/arch/arm/mach-mmp/mmp-dt.c
@@ -6,12 +6,9 @@
  *  Author: Haojian Zhuang <haojian.zhuang@marvell.com>
  */
 
-#include <linux/irqchip.h>
-#include <linux/of_platform.h>
 #include <linux/of_clk.h>
 #include <linux/clocksource.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/time.h>
 #include <asm/hardware/cache-tauros2.h>
 
 #include "common.h"
diff --git a/arch/arm/mach-mmp/mmp2-dt.c b/arch/arm/mach-mmp/mmp2-dt.c
index 34a5fe4b3949..e5ddc327651b 100644
--- a/arch/arm/mach-mmp/mmp2-dt.c
+++ b/arch/arm/mach-mmp/mmp2-dt.c
@@ -6,13 +6,9 @@
  *  Author: Haojian Zhuang <haojian.zhuang@marvell.com>
  */
 
-#include <linux/io.h>
-#include <linux/irqchip.h>
-#include <linux/of_platform.h>
 #include <linux/of_clk.h>
 #include <linux/clocksource.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/time.h>
 #include <asm/hardware/cache-tauros2.h>
 
 #include "common.h"
diff --git a/arch/arm/mach-mmp/mmp3.c b/arch/arm/mach-mmp/mmp3.c
index b0e86964f302..073a4ee219cb 100644
--- a/arch/arm/mach-mmp/mmp3.c
+++ b/arch/arm/mach-mmp/mmp3.c
@@ -5,10 +5,6 @@
  *  Copyright (C) 2019 Lubomir Rintel <lkundrak@v3.sk>
  */
 
-#include <linux/io.h>
-#include <linux/irqchip.h>
-#include <linux/of_platform.h>
-#include <linux/clk-provider.h>
 #include <asm/mach/arch.h>
 #include <asm/hardware/cache-l2x0.h>
 

-- 
2.40.1

