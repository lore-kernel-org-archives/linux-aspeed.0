From: Potin Lai <potin.lai@quantatw.com>
Date: Wed, 16 Feb 2022 00:31:50 +0800
Subject: [PATCH v3 09/10] ARM: dts: aspeed: bletchley: enable mdio3 bus
In-Reply-To: <20220215163151.32252-1-potin.lai@quantatw.com>
References: <20220215163151.32252-1-potin.lai@quantatw.com>
Message-ID: <20220215163151.32252-10-potin.lai@quantatw.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Enable mdio3 bus based on EVT HW
So far lack of c45 support in mdio-aspeed, at least can access mdio bus
by read/write register

TODO: Add Marvell PHY 88X3310 and mdio-aspeed driver c45 support

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index 3ab48420b712..494654338542 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -840,3 +840,8 @@
 		&pinctrl_adc12_default &pinctrl_adc13_default
 		&pinctrl_adc14_default &pinctrl_adc15_default>;
 };
+
+&mdio3 {
+	status = "okay";
+	/* TODO: Add Marvell 88X3310 */
+};
-- 
2.17.1

