From: Joel Stanley <joel@jms.id.au>
Date: Wed, 21 Aug 2019 15:25:26 +0930
Subject: [PATCH 3/7] ARM: aspeed: Add ASPEED AST2600 architecture
In-Reply-To: <20190821055530.8720-1-joel@jms.id.au>
References: <20190821055530.8720-1-joel@jms.id.au>
Message-ID: <20190821055530.8720-4-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The AST2600 is a Cortex A7 dual core CPU that uses the ARM GIC for
interrupts and ARM timer as a clocksource.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/mach-aspeed/Kconfig | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-aspeed/Kconfig b/arch/arm/mach-aspeed/Kconfig
index 2979aa4daeea..56007b0b6120 100644
--- a/arch/arm/mach-aspeed/Kconfig
+++ b/arch/arm/mach-aspeed/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig ARCH_ASPEED
 	bool "Aspeed BMC architectures"
-	depends on ARCH_MULTI_V5 || ARCH_MULTI_V6
+	depends on ARCH_MULTI_V5 || ARCH_MULTI_V6 || ARCH_MULTI_V7
 	select SRAM
 	select WATCHDOG
 	select ASPEED_WATCHDOG
@@ -33,4 +33,16 @@ config MACH_ASPEED_G5
 	 Say yes if you intend to run on an Aspeed ast2500 or similar
 	 fifth generation Aspeed BMCs.
 
+config MACH_ASPEED_G6
+	bool "Aspeed SoC 6th Generation"
+	depends on ARCH_MULTI_V7
+	select CPU_V7
+	select PINCTRL_ASPEED_G6
+	select ARM_GIC
+	select HAVE_ARM_ARCH_TIMER
+	select HAVE_SMP
+	help
+	 Say yes if you intend to run on an Aspeed ast2600 or similar
+	 sixth generation Aspeed BMCs.
+
 endif
-- 
2.23.0.rc1

