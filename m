From: Juerg Haefliger <juerg.haefliger@canonical.com>
Date: Mon, 23 May 2022 08:05:32 +0200
Subject: [PATCH] ARM: aspeed: Kconfig: Fix indentation
Message-ID: <20220523060532.7864-1-juergh@canonical.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The convention for indentation seems to be a single tab. Help text is
further indented by an additional two whitespaces. Fix the lines that
violate these rules.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 arch/arm/mach-aspeed/Kconfig | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-aspeed/Kconfig b/arch/arm/mach-aspeed/Kconfig
index ea96d11b8502..e05997ec2f82 100644
--- a/arch/arm/mach-aspeed/Kconfig
+++ b/arch/arm/mach-aspeed/Kconfig
@@ -19,9 +19,9 @@ config MACH_ASPEED_G4
 	select PINCTRL_ASPEED_G4
 	select FTTMR010_TIMER
 	help
-	 Say yes if you intend to run on an Aspeed ast2400 or similar
-	 fourth generation BMCs, such as those used by OpenPower Power8
-	 systems.
+	  Say yes if you intend to run on an Aspeed ast2400 or similar
+	  fourth generation BMCs, such as those used by OpenPower Power8
+	  systems.
 
 config MACH_ASPEED_G5
 	bool "Aspeed SoC 5th Generation"
@@ -29,8 +29,8 @@ config MACH_ASPEED_G5
 	select PINCTRL_ASPEED_G5
 	select FTTMR010_TIMER
 	help
-	 Say yes if you intend to run on an Aspeed ast2500 or similar
-	 fifth generation Aspeed BMCs.
+	  Say yes if you intend to run on an Aspeed ast2500 or similar
+	  fifth generation Aspeed BMCs.
 
 config MACH_ASPEED_G6
 	bool "Aspeed SoC 6th Generation"
@@ -40,7 +40,7 @@ config MACH_ASPEED_G6
 	select ARM_GIC
 	select HAVE_ARM_ARCH_TIMER
 	help
-	 Say yes if you intend to run on an Aspeed ast2600 or similar
-	 sixth generation Aspeed BMCs.
+	  Say yes if you intend to run on an Aspeed ast2600 or similar
+	  sixth generation Aspeed BMCs.
 
 endif
-- 
2.32.0

