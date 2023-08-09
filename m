From: Dylan Hung <dylan_hung@aspeedtech.com>
Date: Wed, 9 Aug 2023 21:44:13 +0800
Subject: [PATCH v2] ARM: dts: pinctrl-aspeed-g6: Add I3C1 and I3C2 control pins
Message-ID: <20230809134413.3614535-1-dylan_hung@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add pinctrl support for the I3C1 and I3C2 pins.

Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
Reviewed-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
changes in v2:
There are no code or message changes in v2. This commit is being made as
a standalone patch separate from the original patch series, as the other
patches from the original series are no longer necessary.
 
 arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi
index 7cd4f075e325..289668f051eb 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi
@@ -297,6 +297,16 @@ pinctrl_i2c9_default: i2c9_default {
 		groups = "I2C9";
 	};
 
+	pinctrl_i3c1_default: i3c1_default {
+		function = "I3C1";
+		groups = "I3C1";
+	};
+
+	pinctrl_i3c2_default: i3c2_default {
+		function = "I3C2";
+		groups = "I3C2";
+	};
+
 	pinctrl_i3c3_default: i3c3_default {
 		function = "I3C3";
 		groups = "I3C3";
-- 
2.25.1

