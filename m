From: Julian Braha <julianbraha@gmail.com>
Date: Wed, 15 Dec 2021 16:40:22 -0500
Subject: [PATCH v1] pinctrl: aspeed: fix unmet dependencies on MFD_SYSCON for
 PINCTRL_ASPEED
Message-ID: <20211215214022.146391-1-julianbraha@gmail.com>
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

This is because MACH_ASPEED_G* depend on (ARCH_ASPEED || COMPILE_TEST).
ARCH_ASPEED enables the MFD_SYSCON dependency, but COMPILE_TEST doesn't.

These unmet dependency bugs were detected by Kismet,
a static analysis tool for Kconfig. Please advise
if this is not the appropriate solution.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 drivers/pinctrl/aspeed/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/aspeed/Kconfig b/drivers/pinctrl/aspeed/Kconfig
index de8b185c4fee..1a4e5b9ed471 100644
--- a/drivers/pinctrl/aspeed/Kconfig
+++ b/drivers/pinctrl/aspeed/Kconfig
@@ -2,7 +2,7 @@
 config PINCTRL_ASPEED
 	bool
 	depends on (ARCH_ASPEED || COMPILE_TEST) && OF
-	depends on MFD_SYSCON
+	select MFD_SYSCON
 	select PINMUX
 	select PINCONF
 	select GENERIC_PINCONF
-- 
2.32.0

