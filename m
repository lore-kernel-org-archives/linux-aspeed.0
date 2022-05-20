From: Howard Chiu <howard_chiu@aspeedtech.com>
Date: Fri, 20 May 2022 05:36:34 +0000
Subject: [PATCH v5 3/3] ARM: dts: aspeed: ast2600-evb: Enable virtual hub
Message-ID: <SG2PR06MB23150BC7CBC564E04385C6D8E6D39@SG2PR06MB2315.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

1. Disable EHCI0
2. Enable Aspeed vHub for HID emulation
3. Remove duplicated EHCI1

Tested with AST2600
Signed-off-by: Howard Chiu <howard_chiu@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-ast2600-evb.dts | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
index 1db7aa0beea9..4452b6953c23 100644
--- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
@@ -321,11 +321,7 @@ &sdhci1 {
 	clk-phase-sd-hs = <7>, <200>;
 };
 
-&ehci0 {
-	status = "okay";
-};
-
-&ehci1 {
+&vhub {
 	status = "okay";
 };
 
-- 
2.25.1

