From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 19 Sep 2019 16:26:38 +0200
Subject: [PATCH] ARM: aspeed: ast2500 is ARMv6K
Message-ID: <20190919142654.1578823-1-arnd@arndb.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Linux supports both the original ARMv6 level (early ARM1136) and ARMv6K
(later ARM1136, ARM1176 and ARM11mpcore).

ast2500 falls into the second categoy, being based on arm1176jzf-s.
This is enabled by default when using ARCH_MULTI_V6, so we should
not 'select CPU_V6'.

Removing this will lead to more efficient use of atomic instructions.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-aspeed/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-aspeed/Kconfig b/arch/arm/mach-aspeed/Kconfig
index a293137f5814..163931a03136 100644
--- a/arch/arm/mach-aspeed/Kconfig
+++ b/arch/arm/mach-aspeed/Kconfig
@@ -26,7 +26,6 @@ config MACH_ASPEED_G4
 config MACH_ASPEED_G5
 	bool "Aspeed SoC 5th Generation"
 	depends on ARCH_MULTI_V6
-	select CPU_V6
 	select PINCTRL_ASPEED_G5 if !CC_IS_CLANG
 	select FTTMR010_TIMER
 	help
-- 
2.20.0

