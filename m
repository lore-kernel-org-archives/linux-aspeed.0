From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Mon,  5 Sep 2022 23:20:26 -0700
Subject: [PATCH net-next v2 2/2] ARM: dts: aspeed: elbert: Enable mac3 controller
In-Reply-To: <20220906062026.57169-1-rentao.bupt@gmail.com>
References: <20220906062026.57169-1-rentao.bupt@gmail.com>
Message-ID: <20220906062026.57169-3-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

Enable mac3 controller in Elbert dts: Elbert MAC3 is connected to the
BCM53134P onboard switch's IMP_RGMII port directly (fixed link, no PHY
between BMC MAC and BCM53134P).

Note: BMC's mdio0 controller is connected to BCM53134P's MDIO interface
for debugging purposes only: BCM53134P always loads configurations from
its EEPROM, and users should not configure the switch via the MDIO
interface. As a result, the MDIO connection is disabled in dts.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 Changes in v2:
  - updated comments and patch description.

 .../boot/dts/aspeed-bmc-facebook-elbert.dts   | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts
index 27b43fe099f1..36657d8fdb73 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts
@@ -183,3 +183,23 @@ imux31: i2c at 7 {
 &i2c11 {
 	status = "okay";
 };
+
+/*
+ * BMC's "mac3" is connected to BCM53134P's IMP_RGMII port directly (no
+ * PHY in between).
+ * Although BMC's "mdio0" controller is connected to BCM53134P's MDIO
+ * interface, it's only for debugging purposes: BCM53134P always loads
+ * configurations from its EEPROM, and users should not configure the
+ * switch through MDIO interface in regular operations. As a result,
+ * the MDIO connection is disabled in dts.
+ */
+&mac3 {
+	status = "okay";
+	phy-mode = "rgmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii4_default>;
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+	};
+};
-- 
2.37.3

