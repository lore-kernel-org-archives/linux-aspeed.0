From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Mon,  5 Sep 2022 16:56:34 -0700
Subject: [PATCH net-next 2/2] ARM: dts: aspeed: elbert: Enable mac3 controller
In-Reply-To: <20220905235634.20957-1-rentao.bupt@gmail.com>
References: <20220905235634.20957-1-rentao.bupt@gmail.com>
Message-ID: <20220905235634.20957-3-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

Enable mac3 controller in Elbert dts: Elbert MAC3 is connected to the
onboard switch directly (fixed link).

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts
index 27b43fe099f1..52cb617783ac 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dts
@@ -183,3 +183,14 @@ imux31: i2c at 7 {
 &i2c11 {
 	status = "okay";
 };
+
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
2.30.2

