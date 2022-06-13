From: Potin Lai <potin.lai.pt@gmail.com>
Date: Mon, 13 Jun 2022 17:51:48 +0800
Subject: [PATCH 2/4] ARM: dts: aspeed: bletchley: disable GPIOV2 pull-down
In-Reply-To: <20220613095150.21917-1-potin.lai.pt@gmail.com>
References: <20220613095150.21917-1-potin.lai.pt@gmail.com>
Message-ID: <20220613095150.21917-3-potin.lai.pt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The external pull-up cannot drive GPIOV2, so disable GPIOV2 internal
pull-down resistor by the request form HW team.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index d34bfa50620e..ee33cc3efae4 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -860,6 +860,9 @@
 };
 
 &gpio0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpiov2_unbiased_default>;
+
 	gpio-line-names =
 	/*A0-A7*/	"","","","","","","","",
 	/*B0-B7*/	"FUSB302_SLED1_INT_N","FUSB302_SLED2_INT_N",
@@ -950,3 +953,10 @@
 &ehci0 {
 	status = "okay";
 };
+
+&pinctrl {
+	pinctrl_gpiov2_unbiased_default: gpiov2 {
+		pins = "AD14";
+		bias-disable;
+	};
+};
-- 
2.17.1

