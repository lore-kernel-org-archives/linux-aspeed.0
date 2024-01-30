From: Corona, Ernesto <ernesto.corona@intel.com>
Date: Tue, 30 Jan 2024 23:32:48 +0000
Subject: [PATCH 30 7/7] Add AST2500 and AST2600 JTAG device in DTS
Message-ID: <LV8PR11MB8463F88C2364A08DEF3ABAC28B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Adding aspeed jtag device to device tree

Signed-off-by: Ernesto Corona <ernesto.corona@intel.com>
Signed-off-by: Omar Castro <omar.eduardo.castro@linux.intel.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Cc: Jiri Pirko <jiri@nvidia.com>
Cc: Vadim Pasternak <vadimp@mellanox.com>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Steven Filary <steven.a.filary@intel.com>
Cc: Amithash Prasad <amithash@fb.com>
Cc: Patrick Williams <patrickw3@fb.com>
Cc: Luke Chen <luke_chen@aspeedtech.com>
Cc: Billy Tsai <billy_tsai@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi |  9 +++++++++
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 20 ++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
index 04f98d1dbb97..3610aa758702 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
@@ -445,6 +445,15 @@ vuart: serial at 1e787000 {
 				status = "disabled";
 			};
 
+			jtag: jtag at 1e6e4000 {
+				compatible = "aspeed,ast2500-jtag";
+				reg = <0x1e6e4000 0x1c>;
+				clocks = <&syscon ASPEED_CLK_APB>;
+				resets = <&syscon ASPEED_RESET_JTAG_MASTER>;
+				interrupts = <43>;
+				status = "disabled";
+			};
+
 			lpc: lpc at 1e789000 {
 				compatible = "aspeed,ast2500-lpc-v2", "simple-mfd", "syscon";
 				reg = <0x1e789000 0x1000>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index c4d1faade8be..d5353f728689 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -411,6 +411,26 @@ xdma: xdma at 1e6e7000 {
 				status = "disabled";
 			};
 
+			jtag0: jtag at 1e6e4000 {
+				compatible = "aspeed,ast2600-jtag";
+				reg = <0x1e6e4000 0x40>;
+				clocks = <&syscon ASPEED_CLK_APB1>;
+				resets = <&syscon ASPEED_RESET_JTAG_MASTER>;
+				interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
+			jtag1: jtag at 1e6e4100 {
+				compatible = "aspeed,ast2600-jtag";
+				reg = <0x1e6e4100 0x40>;
+				clocks = <&syscon ASPEED_CLK_APB1>;
+				resets = <&syscon ASPEED_RESET_JTAG_MASTER2>;
+				interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_jtagm_default>;
+				status = "disabled";
+			};
+
 			adc0: adc at 1e6e9000 {
 				compatible = "aspeed,ast2600-adc0";
 				reg = <0x1e6e9000 0x100>;
-- 
2.25.1
