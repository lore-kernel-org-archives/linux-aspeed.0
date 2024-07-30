From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 30 Jul 2024 14:44:34 -0000
Subject: [PATCH 1/5] crypto: arm/xor - add missing MODULE_DESCRIPTION()
 macro
In-Reply-To: <20240730-module_description_orphans-v1-0-7094088076c8@quicinc.com>
References: <20240730-module_description_orphans-v1-0-7094088076c8@quicinc.com>
Message-ID: <20240730-module_description_orphans-v1-1-7094088076c8@quicinc.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

With ARCH=arm and CONFIG_KERNEL_MODE_NEON=y, make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in arch/arm/lib/xor-neon.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 arch/arm/lib/xor-neon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
index 522510baed49..cf57fca97908 100644
--- a/arch/arm/lib/xor-neon.c
+++ b/arch/arm/lib/xor-neon.c
@@ -8,6 +8,7 @@
 #include <linux/raid/xor.h>
 #include <linux/module.h>
 
+MODULE_DESCRIPTION("NEON accelerated XOR implementation");
 MODULE_LICENSE("GPL");
 
 #ifndef __ARM_NEON__

-- 
2.42.0

