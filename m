From: Howard Chiu <howard_chiu@aspeedtech.com>
Date: Fri, 1 Apr 2022 06:59:06 +0000
Subject: [PATCH v2] ARM: dts: aspeed: ast2600-evb: Enable RX delay for
 MAC0/MAC1
Message-ID: <SG2PR06MB23152A548AAE81140B57DD69E6E09@SG2PR06MB2315.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Since mac0/1 and mac2/3 are physically located on different die,
they have different properties by nature, which is mac0/1 has smaller delay step.

The property 'phy-mode' on ast2600 mac0 and mac1 is recommended to set to 'rgmii-rxid'
which enables the RX interface delay from the PHY chip.
Refer page 45 of SDK User Guide v08.00
https://github.com/AspeedTech-BMC/openbmc/releases/download/v08.00/SDK_User_Guide_v08.00.pdf

Signed-off-by: Howard Chiu <howard_chiu@aspeedtech.com>
---
Change since v1:
1. Remove mac*-clk-delay due to lack of driver support

 arch/arm/boot/dts/aspeed-ast2600-evb.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
index b7eb552640cb..788448cdd6b3 100644
--- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
@@ -103,7 +103,7 @@ ethphy3: ethernet-phy at 0 {
 &mac0 {
 	status = "okay";
 
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-rxid";
 	phy-handle = <&ethphy0>;
 
 	pinctrl-names = "default";
@@ -114,7 +114,7 @@ &mac0 {
 &mac1 {
 	status = "okay";
 
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-rxid";
 	phy-handle = <&ethphy1>;
 
 	pinctrl-names = "default";
-- 
2.25.1

