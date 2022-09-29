From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 29 Sep 2022 09:31:30 +0800
Subject: [PATCH 2/2] ARM: dts: aspeed: bletchley: enable emmc and ehci1
In-Reply-To: <20220929013130.1916525-1-potin.lai.pt@gmail.com>
References: <20220929013130.1916525-1-potin.lai.pt@gmail.com>
Message-ID: <20220929013130.1916525-3-potin.lai.pt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Enable both emmc-controller and emmc nodes for storage soultion on
bletchley, and enable ehci1 node as second storage plan.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index f5986f5909cd0..a619eec70633a 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -1046,6 +1046,18 @@ &ehci0 {
 	status = "okay";
 };
 
+&ehci1 {
+	status = "okay";
+};
+
+&emmc_controller {
+	status = "okay";
+};
+
+&emmc {
+	status = "okay";
+};
+
 &pinctrl {
 	pinctrl_gpiov2_unbiased_default: gpiov2 {
 		pins = "AD14";
-- 
2.31.1

