From: Vijay Khemka <vijaykhemka@fb.com>
Date: Mon, 22 Jul 2019 12:24:47 -0700
Subject: [PATCH 1/2] ARM: dts: aspeed: tiogapass: Add VR devices
Message-ID: <20190722192451.1947348-1-vijaykhemka@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Addes Voltage regulators Infineon pxe1610 devices to Facebook
tiogapass platform.

Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
---
 .../dts/aspeed-bmc-facebook-tiogapass.dts     | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
index c4521eda787c..b7783833a58c 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
@@ -144,6 +144,42 @@
 &i2c5 {
 	status = "okay";
 	// CPU Voltage regulators
+	vr at 48 {
+		compatible = "infineon,pxe1610";
+		reg = <0x48>;
+	};
+	vr at 4a {
+		compatible = "infineon,pxe1610";
+		reg = <0x4a>;
+	};
+	vr at 50 {
+		compatible = "infineon,pxe1610";
+		reg = <0x50>;
+	};
+	vr at 52 {
+		compatible = "infineon,pxe1610";
+		reg = <0x52>;
+	};
+	vr at 58 {
+		compatible = "infineon,pxe1610";
+		reg = <0x58>;
+	};
+	vr at 5a {
+		compatible = "infineon,pxe1610";
+		reg = <0x5a>;
+	};
+	vr at 68 {
+		compatible = "infineon,pxe1610";
+		reg = <0x68>;
+	};
+	vr at 70 {
+		compatible = "infineon,pxe1610";
+		reg = <0x70>;
+	};
+	vr at 72 {
+		compatible = "infineon,pxe1610";
+		reg = <0x72>;
+	};
 };
 
 &i2c6 {
-- 
2.17.1

