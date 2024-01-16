From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Date: Tue, 16 Jan 2024 14:53:42 +0800
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: add I3C config for Yosemite 4
Message-ID: <20240116065343.3657378-1-Delphine_CC_Chiu@wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add linux device tree of I3C for Yosemite 4 to enable the I3C path
to the I3C hubs between BMC and Sentinel Dome BICs.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-yosemite4.dts     | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 64075cc41d92..81b1fcca97ff 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -595,6 +595,18 @@ i2c-mux at 72 {
 	};
 };
 
+&i3c0 {
+       status = "okay";
+       pinctrl-names = "default";
+       pinctrl-0 = <&pinctrl_i3c1_default>;
+};
+
+&i3c1 {
+       status = "okay";
+       pinctrl-names = "default";
+       pinctrl-0 = <&pinctrl_i3c2_default>;
+};
+
 &adc0 {
 	ref_voltage = <2500>;
 	status = "okay";
-- 
2.25.1

