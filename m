From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Date: Tue, 3 Nov 2020 15:22:00 +0800
Subject: [v2 2/4] ARM: dts: aspeed: ast2600: Update FMC/SPI controller setting
 for spi-aspeed.c
In-Reply-To: <20201103072202.24705-1-chin-ting_kuo@aspeedtech.com>
References: <20201103072202.24705-1-chin-ting_kuo@aspeedtech.com>
Message-ID: <20201103072202.24705-3-chin-ting_kuo@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

- Adjust the value format of "reg" property:
  Instead of platform_get_resource(),
  platform_get_resource_byname() function can be used
  for more human-readable.
- Add "num-cs" property for FMC/SPI controller:
  Each ASPEED FMC/SPI memory controller can support more
  than a chip select. By "num-cs" property, FMC/SPI
  controller driver can know how many chip select related
  registers should be initialized at the probe stage.
  Besdies, with this property, driver can avoid accessing
  chip select which CS number is larger than the maximum
  one supported by the controller.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-g6.dtsi | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index b58220a49cbd..8a5c798db54e 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -89,14 +89,16 @@
 			};
 
 		fmc: spi at 1e620000 {
-			reg = < 0x1e620000 0xc4
-				0x20000000 0x10000000 >;
+			reg = <0x1e620000 0xc4>,
+				<0x20000000 0x10000000>;
+			reg-names = "spi_ctrl_reg", "spi_mmap";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "aspeed,ast2600-fmc";
 			clocks = <&syscon ASPEED_CLK_AHB>;
 			status = "disabled";
 			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+			num-cs = <3>;
 			flash at 0 {
 				reg = < 0 >;
 				compatible = "jedec,spi-nor";
@@ -118,12 +120,14 @@
 		};
 
 		spi1: spi at 1e630000 {
-			reg = < 0x1e630000 0xc4
-				0x30000000 0x10000000 >;
+			reg = <0x1e630000 0xc4>,
+				<0x30000000 0x10000000>;
+			reg-names = "spi_ctrl_reg", "spi_mmap";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "aspeed,ast2600-spi";
 			clocks = <&syscon ASPEED_CLK_AHB>;
+			num-cs = <2>;
 			status = "disabled";
 			flash at 0 {
 				reg = < 0 >;
@@ -140,12 +144,14 @@
 		};
 
 		spi2: spi at 1e631000 {
-			reg = < 0x1e631000 0xc4
-				0x50000000 0x10000000 >;
+			reg = < 0x1e631000 0xc4>,
+				<0x50000000 0x10000000>;
+			reg-names = "spi_ctrl_reg", "spi_mmap";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "aspeed,ast2600-spi";
 			clocks = <&syscon ASPEED_CLK_AHB>;
+			num-cs = <3>;
 			status = "disabled";
 			flash at 0 {
 				reg = < 0 >;
-- 
2.17.1

