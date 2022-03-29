From: Howard Chiu <howard_chiu@aspeedtech.com>
Date: Tue, 29 Mar 2022 03:24:10 +0000
Subject: [PATCH v4 3/3] ARM: dts: aspeed: ast2600-evb: Enable virtual hub
Message-ID: <SG2PR06MB23155E8A6193118544A7DBF3E61E9@SG2PR06MB2315.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Enable Aspeed VHub for HID emulation

Signed-off-by: Howard Chiu <howard_chiu@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-ast2600-evb.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
index 158b88f38d2c..b98cdad86e90 100644
--- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
@@ -314,6 +314,11 @@ &sdhci1 {
 	clk-phase-sd-hs = <7>, <200>;
 };
 
+&vhub {
+	status = "okay";
+	pinctrl-names = "default";
+};
+
 &video {
 	status = "okay";
 	memory-region = <&video_engine_memory>;
-- 
2.25.1

