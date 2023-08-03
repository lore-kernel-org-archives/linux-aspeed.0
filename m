From: Rob Herring <robh@kernel.org>
Date: Thu, 03 Aug 2023 16:42:49 -0600
Subject: [PATCH v2 09/23] ARM: npcm: Drop unused includes
In-Reply-To: <20230803-dt-header-cleanups-for-soc-v2-0-d8de2cc88bff@kernel.org>
References: <20230803-dt-header-cleanups-for-soc-v2-0-d8de2cc88bff@kernel.org>
Message-ID: <20230803-dt-header-cleanups-for-soc-v2-9-d8de2cc88bff@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Several includes are not needed, so drop them.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/mach-npcm/platsmp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-npcm/platsmp.c b/arch/arm/mach-npcm/platsmp.c
index 21633c70fe7f..41891d3aa124 100644
--- a/arch/arm/mach-npcm/platsmp.c
+++ b/arch/arm/mach-npcm/platsmp.c
@@ -5,12 +5,9 @@
 #define pr_fmt(fmt) "nuvoton,npcm7xx-smp: " fmt
 
 #include <linux/delay.h>
-#include <linux/device.h>
 #include <linux/smp.h>
 #include <linux/io.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
-#include <linux/of_platform.h>
 #include <linux/of_address.h>
 #include <asm/cacheflush.h>
 #include <asm/smp.h>

-- 
2.40.1

