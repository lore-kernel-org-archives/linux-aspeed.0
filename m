From: Joel Stanley <joel@jms.id.au>
Date: Fri,  4 Mar 2022 11:40:10 +1030
Subject: [PATCH] ARM: dts: aspeed: Fix AST2600 quad spi group
Message-ID: <20220304011010.974863-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Requesting quad mode for the FMC resulted in an error:

  &fmc {
         status = "okay";
 +       pinctrl-names = "default";
 +       pinctrl-0 = <&pinctrl_fwqspi_default>'

[    0.742963] aspeed-g6-pinctrl 1e6e2000.syscon:pinctrl: invalid function FWQSPID in map table
?

This is because the quad mode pins are a group of pins, not a function.

After applying this patch we can request the pins and the QSPI data
lines are muxed:

 # cat /sys/kernel/debug/pinctrl/1e6e2000.syscon\:pinctrl-aspeed-g6-pinctrl/pinmux-pins |grep 1e620000.spi
 pin 196 (AE12): device 1e620000.spi function FWSPID group FWQSPID
 pin 197 (AF12): device 1e620000.spi function FWSPID group FWQSPID
 pin 240 (Y1): device 1e620000.spi function FWSPID group FWQSPID
 pin 241 (Y2): device 1e620000.spi function FWSPID group FWQSPID
 pin 242 (Y3): device 1e620000.spi function FWSPID group FWQSPID
 pin 243 (Y4): device 1e620000.spi function FWSPID group FWQSPID

Fixes: f510f04c8c83 ("ARM: dts: aspeed: Add AST2600 pinmux nodes")
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi b/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi
index 6dde51c2aed3..e4775bbceecc 100644
--- a/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi
@@ -118,7 +118,7 @@ pinctrl_fwspid_default: fwspid_default {
 	};
 
 	pinctrl_fwqspid_default: fwqspid_default {
-		function = "FWQSPID";
+		function = "FWSPID";
 		groups = "FWQSPID";
 	};
 
-- 
2.34.1

