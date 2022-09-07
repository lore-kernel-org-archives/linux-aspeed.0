From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Tue,  6 Sep 2022 22:44:53 -0700
Subject: [PATCH net-next v3 2/2] ARM: dts: aspeed: elbert: Enable mac3 controller
In-Reply-To: <20220907054453.20016-1-rentao.bupt@gmail.com>
References: <20220907054453.20016-1-rentao.bupt@gmail.com>
Message-ID: <20220907054453.20016-3-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

Enable mac3 controller in Elbert dts: Elbert MAC3 is connected to the
BCM53134P onboard switch's IMP_RGMII port directly (fixed link, no PHY
between BMC MAC and BCM53134P).

Note: BMC's mdio0 controller is connected to BCM53134P's MDIO interface,
and the MDIO channel will be enabled later, when BCM53134 is added to
"bcm53xx" DSA driver.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 Changes in v3:
  - updated comments and patch description.
 Changes in v2:
  - updated comments and patch description.
 .../boot/dts/aspeed-bmc-facebook-elbert.dts    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts
index 27b43fe099f1..8e1a1d1b282d 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts
@@ -183,3 +183,21 @@ imux31: i2c at 7 {
 &i2c11 {
 	status = "okay";
 };
+
+/*
+ * BMC's "mac3" controller is connected to BCM53134P's IMP_RGMII port
+ * directly (fixed link, no PHY in between).
+ * Note: BMC's "mdio0" controller is connected to BCM53134P's MDIO
+ * interface, and the MDIO channel will be enabled in dts later, when
+ * BCM53134 is added to "bcm53xx" DSA driver.
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

