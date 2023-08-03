From: Rob Herring <robh@kernel.org>
Date: Thu, 03 Aug 2023 16:42:41 -0600
Subject: [PATCH v2 01/23] ARM: l2x0: Add explicit includes for init and
 types
In-Reply-To: <20230803-dt-header-cleanups-for-soc-v2-0-d8de2cc88bff@kernel.org>
References: <20230803-dt-header-cleanups-for-soc-v2-0-d8de2cc88bff@kernel.org>
Message-ID: <20230803-dt-header-cleanups-for-soc-v2-1-d8de2cc88bff@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The cache-l2x0.h header uses u32 type and the __init and __iomem
attributes, so it should have explicit includes for those.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/include/asm/hardware/cache-l2x0.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
index a6d4ee86ba54..5a7ee70f561c 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -9,6 +9,8 @@
 #define __ASM_ARM_HARDWARE_L2X0_H
 
 #include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/types.h>
 
 #define L2X0_CACHE_ID			0x000
 #define L2X0_CACHE_TYPE			0x004

-- 
2.40.1

