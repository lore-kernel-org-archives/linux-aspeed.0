From: Julian Braha <julianbraha@gmail.com>
Date: Fri, 29 Oct 2021 17:21:57 -0400
Subject: [PATCH] pinctrl: aspeed: fix unmet dependencies on MFD_SYSCON for
 PINCTRL_ASPEED
Message-ID: <20211029212157.14230-1-julianbraha@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

When PINCTRL_ASPEED_G* is selected,
and MFD_SYSCON is not selected,
Kbuild gives the following warnings:

WARNING: unmet direct dependencies detected for PINCTRL_ASPEED
  Depends on [n]: PINCTRL [=y] && (ARCH_ASPEED [=n] || COMPILE_TEST [=y]) && OF [=y] && MFD_SYSCON [=n]
  Selected by [y]:
  - PINCTRL_ASPEED_G4 [=y] && PINCTRL [=y] && (MACH_ASPEED_G4 [=n] || COMPILE_TEST [=y]) && OF [=y]

WARNING: unmet direct dependencies detected for PINCTRL_ASPEED
  Depends on [n]: PINCTRL [=y] && (ARCH_ASPEED [=n] || COMPILE_TEST [=y]) && OF [=y] && MFD_S>
  Selected by [y]:
  - PINCTRL_ASPEED_G5 [=y] && PINCTRL [=y] && (MACH_ASPEED_G5 [=n] || COMPILE_TEST [=y]) && O>

WARNING: unmet direct dependencies detected for PINCTRL_ASPEED
  Depends on [n]: PINCTRL [=y] && (ARCH_ASPEED [=n] || COMPILE_TEST [=y]) && OF [=y] && MFD_S>
  Selected by [y]:
  - PINCTRL_ASPEED_G6 [=y] && PINCTRL [=y] && (MACH_ASPEED_G6 [=n] || COMPILE_TEST [=y]) && O>

This is because PINCTRL_ASPEED_G* selects PINCTRL_ASPEED,
without selecting or depending on MFD_SYSCON, despite
PINCTRL_ASPEED depending on MFD_SYSCON.

These unmet dependency bugs were detected by Kismet,
a static analysis tool for Kconfig. Please advise
if this is not the appropriate solution.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 drivers/pinctrl/aspeed/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/aspeed/Kconfig b/drivers/pinctrl/aspeed/Kconfig
index de8b185c4fee..b0bae6144fc2 100644
--- a/drivers/pinctrl/aspeed/Kconfig
+++ b/drivers/pinctrl/aspeed/Kconfig
@@ -11,6 +11,7 @@ config PINCTRL_ASPEED
 config PINCTRL_ASPEED_G4
 	bool "Aspeed G4 SoC pin control"
 	depends on (MACH_ASPEED_G4 || COMPILE_TEST) && OF
+	depends on MFD_SYSCON
 	select PINCTRL_ASPEED
 	help
 	  Say Y here to enable pin controller support for Aspeed's 4th
@@ -19,6 +20,7 @@ config PINCTRL_ASPEED_G4
 config PINCTRL_ASPEED_G5
 	bool "Aspeed G5 SoC pin control"
 	depends on (MACH_ASPEED_G5 || COMPILE_TEST) && OF
+	depends on MFD_SYSCON
 	select PINCTRL_ASPEED
 	help
 	  Say Y here to enable pin controller support for Aspeed's 5th
@@ -27,6 +29,7 @@ config PINCTRL_ASPEED_G5
 config PINCTRL_ASPEED_G6
 	bool "Aspeed G6 SoC pin control"
 	depends on (MACH_ASPEED_G6 || COMPILE_TEST) && OF
+	depends on MFD_SYSCON
 	select PINCTRL_ASPEED
 	help
 	  Say Y here to enable pin controller support for Aspeed's 6th
-- 
2.30.2

