From: Rob Herring <robh@kernel.org>
Date: Thu, 03 Aug 2023 16:42:51 -0600
Subject: [PATCH v2 11/23] ARM: pxa: Drop unused includes
In-Reply-To: <20230803-dt-header-cleanups-for-soc-v2-0-d8de2cc88bff@kernel.org>
References: <20230803-dt-header-cleanups-for-soc-v2-0-d8de2cc88bff@kernel.org>
Message-ID: <20230803-dt-header-cleanups-for-soc-v2-11-d8de2cc88bff@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Several includes are not needed, so drop them.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-pxa/pxa-dt.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa-dt.c b/arch/arm/mach-pxa/pxa-dt.c
index 5e5d543fdf46..a292de91dce5 100644
--- a/arch/arm/mach-pxa/pxa-dt.c
+++ b/arch/arm/mach-pxa/pxa-dt.c
@@ -5,13 +5,7 @@
  *  Copyright (C) 2012 Daniel Mack
  */
 
-#include <linux/irq.h>
-#include <linux/irqdomain.h>
-#include <linux/of_irq.h>
-#include <linux/of_platform.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/time.h>
-#include "irqs.h"
 
 #include "generic.h"
 

-- 
2.40.1

