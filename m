From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Tue, 12 Mar 2024 13:33:19 +0800
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: Enable ipmb device for OCP debug card
Message-ID: <20240312053320.380997-1-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add OCP debug card devicetree config

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 64075cc41d92..b944ed2cf2f8 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -370,6 +370,13 @@ rtc at 6f {
 &i2c13 {
 	status = "okay";
 	bus-frequency = <400000>;
+	multi-master;
+
+	ipmb at 10 {
+		compatible = "ipmb-dev";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		i2c-protocol;
+	};
 };
 
 &i2c14 {
-- 
2.25.1

