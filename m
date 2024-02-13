From: Zev Weiss <zev@bewilderbeest.net>
Date: Mon, 12 Feb 2024 17:51:36 -0800
Subject: [PATCH] ARM: dts: aspeed: asrock: Add BIOS SPI flash chips
Message-ID: <20240213015138.12452-2-zev@bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On e3c246d4i, e3c256d4i, romed8hm3, and spc621d8hm3 the host firmware
flash is accessible to the BMC via the AST2500 SPI1 interface with an
external GPIO-controlled mux switching the flash chip between the host
and the BMC.

The default state of the mux GPIO leaves it connected to the host, so
the BMC's attempt to bind a driver to it during its boot sequence will
fail, but a write to a sysfs 'bind' file after toggling the mux GPIO
(along with whatever other preparatory steps are required) can later
allow it to be attached and accessed by the BMC.  It's not an ideal
arrangement, but in the absence of DT overlays or any other
alternative it is at least a functional one, if somewhat clumsily so.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---

Note that this patch is based on Joel's for-next tree, since the
e3c256d4i and spc621d8hm3 device-trees haven't been merged in mainline
yet.

 .../boot/dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts  | 12 ++++++++++++
 .../boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts  | 12 ++++++++++++
 .../boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts  | 12 ++++++++++++
 .../dts/aspeed/aspeed-bmc-asrock-spc621d8hm3.dts     | 12 ++++++++++++
 4 files changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts
index c4b2efbfdf56..557ce20e305d 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts
@@ -68,6 +68,18 @@ flash at 0 {
 	};
 };
 
+&spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default>;
+	flash at 0 {
+		status = "okay";
+		label = "bios";
+		m25p,fast-read;
+		spi-max-frequency = <25000000>; /* 25 MHz */
+	};
+};
+
 &uart5 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts
index 263fcc8106ff..bf752ff8204f 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts
@@ -69,6 +69,18 @@ flash at 0 {
 	};
 };
 
+&spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default>;
+	flash at 0 {
+		status = "okay";
+		label = "bios";
+		m25p,fast-read;
+		spi-max-frequency = <25000000>; /* 25 MHz */
+	};
+};
+
 &uart1 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts
index 4554abf0c7cd..8dff2cbf042b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts
@@ -56,6 +56,18 @@ flash at 0 {
 	};
 };
 
+&spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default>;
+	flash at 0 {
+		status = "okay";
+		label = "bios";
+		m25p,fast-read;
+		spi-max-frequency = <33000000>; /* 33 MHz */
+	};
+};
+
 &uart5 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-spc621d8hm3.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-spc621d8hm3.dts
index 555485871e7a..54b40776c7e3 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-spc621d8hm3.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-spc621d8hm3.dts
@@ -66,6 +66,18 @@ flash at 0 {
 	};
 };
 
+&spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default>;
+	flash at 0 {
+		status = "okay";
+		label = "bios";
+		m25p,fast-read;
+		spi-max-frequency = <17000000>; /* 17 MHz */
+	};
+};
+
 &uart5 {
 	status = "okay";
 };
-- 
2.43.0

