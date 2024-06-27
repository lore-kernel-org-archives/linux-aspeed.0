From: Peter Yin <peteryin.openbmc@gmail.com>
Date: Thu, 27 Jun 2024 15:00:09 +0800
Subject: [PATCH v2 07/10] ARM: dts: aspeed: Harma: add fru device
In-Reply-To: <20240627070013.2509150-1-peteryin.openbmc@gmail.com>
References: <20240627070013.2509150-1-peteryin.openbmc@gmail.com>
Message-ID: <20240627070013.2509150-8-peteryin.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add Aegis fru device and gpio expander device in bus 11.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index e10ee54fe472..f55ffe9c4d89 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -427,6 +427,31 @@ eeprom at 52 {
 
 &i2c11 {
 	status = "okay";
+
+	gpio at 30 {
+		compatible = "nxp,pca9555";
+		reg = <0x30>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+	gpio at 31 {
+		compatible = "nxp,pca9555";
+		reg = <0x31>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+		"","","","",
+		"","","presence-cmm","",
+		"","","","",
+		"","","","";
+	};
+
+	// Aegis FRU
+	eeprom at 52 {
+		compatible = "atmel,24c64";
+		reg = <0x52>;
+	};
 };
 
 &i2c12 {
-- 
2.25.1

