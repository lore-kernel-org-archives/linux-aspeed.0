From: Konstantin Aladyshev <aladyshev22@gmail.com>
Date: Sat, 11 Jun 2022 12:58:26 +0300
Subject: [PATCH 2/4] ARM: dts: aspeed: ethanolx: Configure RTS/CTS for UART1
In-Reply-To: <20220611095828.1090-1-aladyshev22@gmail.com>
References: <20220611095828.1090-1-aladyshev22@gmail.com>
Message-ID: <20220611095828.1090-3-aladyshev22@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

UART1 is used for connection to the main EPYC CPU. Besides the main
TX/RX signals this connection has flow control signals RTS/CTS,
therefore configure this pins on the BMC side.

Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
index 889b2fdd19cf..0354a7d8f9f5 100644
--- a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
@@ -79,7 +79,9 @@ &uart1 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_txd1_default
-		     &pinctrl_rxd1_default>;
+		     &pinctrl_rxd1_default
+		     &pinctrl_nrts1_default
+		     &pinctrl_ncts1_default>;
 };
 
 &uart5 {
-- 
2.25.1

