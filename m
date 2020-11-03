From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Date: Tue, 3 Nov 2020 15:22:01 +0800
Subject: [v2 3/4] ARM: dts: aspeed: ast2600-evb: Adjust SPI flash configuration
In-Reply-To: <20201103072202.24705-1-chin-ting_kuo@aspeedtech.com>
References: <20201103072202.24705-1-chin-ting_kuo@aspeedtech.com>
Message-ID: <20201103072202.24705-4-chin-ting_kuo@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

- Enable FMC CS1 and SPI2 CS0 SPI NOR flashes since both of
  these two flashes are mounted on AST2600 EVB by default.
- Remove spi-max-frequency setting: 50MHz is usual SPI bus
  frequency adopted on AST2600 EVB which has already been
  configured in aspeed-g6.dtsi.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-ast2600-evb.dts | 26 ++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
index 8d0f4656aa05..5a2e4612d155 100644
--- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
@@ -96,12 +96,11 @@
 
 &fmc {
 	status = "okay";
+
 	flash at 0 {
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc";
-		spi-max-frequency = <50000000>;
-
 		partitions {
 			compatible = "fixed-partitions";
 			#address-cells = <1>;
@@ -133,18 +132,37 @@
 			};
 		};
 	};
+
+	flash at 1 {
+		status = "okay";
+		m25p,fast-read;
+		label = "fmc0:1";
+	};
 };
 
 &spi1 {
 	status = "okay";
+
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_spi1_default>;
 
 	flash at 0 {
 		status = "okay";
 		m25p,fast-read;
-		label = "pnor";
-		spi-max-frequency = <100000000>;
+		label = "spi1:0";
+	};
+};
+
+&spi2 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi2_default>;
+
+	flash at 0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "spi2:0";
 	};
 };
 
-- 
2.17.1

