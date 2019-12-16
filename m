From: Joel Stanley <joel@jms.id.au>
Date: Mon, 16 Dec 2019 17:41:32 +1100
Subject: [PATCH] ARM: dts: aspeed: AST2400 disables hw checksum
Message-ID: <20191216064132.78015-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

There is no need to specify this property in the device tree as the
AST2400 does not have working hardware checksum and disables it in the
driver.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-wedge100.dts | 1 -
 arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts  | 1 -
 arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts        | 3 ---
 3 files changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge100.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge100.dts
index b1e10f0c85c9..322587b7b67d 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge100.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge100.dts
@@ -76,7 +76,6 @@ &uart5 {
 
 &mac1 {
 	status = "okay";
-	no-hw-checksum;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii2_default &pinctrl_mdio2_default>;
 };
diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
index aaa77a597d1a..54e508530dce 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
@@ -75,7 +75,6 @@ &uart5 {
 
 &mac1 {
 	status = "okay";
-	no-hw-checksum;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii2_default &pinctrl_mdio2_default>;
 };
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts b/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
index affd2c8743b1..041f28e3ac10 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
@@ -107,10 +107,7 @@ flash at 0 {
 
 &mac0 {
 	status = "okay";
-
 	use-ncsi;
-	no-hw-checksum;
-
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rmii1_default>;
 };
-- 
2.24.0

