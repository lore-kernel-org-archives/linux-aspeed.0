From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sat, 13 Apr 2024 20:22:51 -0000
Subject: [PATCH v3 1/4] arm: dts: nxp: lpc: lpc32xx: drop 'clocks' form rtc
In-Reply-To: <20240413-rtc_dtschema-v3-0-eff368bcc471@gmail.com>
References: <20240413-rtc_dtschema-v3-0-eff368bcc471@gmail.com>
Message-ID: <20240413-rtc_dtschema-v3-1-eff368bcc471@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The RTC does not provide a controllable clock signal (it uses a fixed
32768 Hz crystal, the input clock of the SoC). Remove the 'clocks'
property to better describe the device and avoid errors when checking
the dts against the nxp,lpc3220-rtc binding.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi b/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
index 974410918f35..f78d67e672b4 100644
--- a/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
@@ -384,7 +384,6 @@ rtc: rtc at 40024000 {
 				reg = <0x40024000 0x1000>;
 				interrupt-parent = <&sic1>;
 				interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk LPC32XX_CLK_RTC>;
 			};
 
 			gpio: gpio at 40028000 {

-- 
2.40.1

