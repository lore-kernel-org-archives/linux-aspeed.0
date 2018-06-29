From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 29 Jun 2018 13:51:00 +1000
Subject: [PATCH 1/7] arm: dts: aspeed: Add aspeed G4 USB pinmux
In-Reply-To: <20180629035106.27181-1-benh@kernel.crashing.org>
References: <20180629035106.27181-1-benh@kernel.crashing.org>
Message-ID: <20180629035106.27181-2-benh@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Set the default pinmux for EHCI so boards don't have to do
it an document why it is not set for UHCI.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 75df1573380e..1d7ffa9fdb11 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -113,6 +113,8 @@
 			reg = <0x1e6a1000 0x100>;
 			interrupts = <5>;
 			clocks = <&syscon ASPEED_CLK_GATE_USBPORT1CLK>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usb2h_default>;
 			status = "disabled";
 		};
 
@@ -123,6 +125,10 @@
 			#ports = <3>;
 			clocks = <&syscon ASPEED_CLK_GATE_USBUHCICLK>;
 			status = "disabled";
+			/*
+			 * No default pinmux, it will follow EHCI, use an explicit pinmux
+			 * override if you don't enable EHCI
+			 */
 		};
 
 		apb {
-- 
2.17.1

