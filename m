From: Cédric Le Goater <clg@kaod.org>
Date: Fri,  3 Jun 2022 09:37:05 +0200
Subject: [PATCH] ARM: dts: aspeed: ast2600-evb: Enable Quad SPI RX tranfers
Message-ID: <20220603073705.1624351-1-clg@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Now that the pinctrl definitions of the ast2600 SoC have been fixed,
see commit 925fbe1f7eb6 ("dt-bindings: pinctrl: aspeed-g6: add FWQSPI
function/group"), it is safe to activate QSPI on the ast2600 evb.

Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Tested-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Signed-off-by: C?dric Le Goater <clg@kaod.org>
---
 arch/arm/boot/dts/aspeed-ast2600-evb.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
index 5a6063bd4508..87a79922ff78 100644
--- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
@@ -182,6 +182,7 @@ flash at 0 {
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc";
+		spi-rx-bus-width = <4>;
 		spi-max-frequency = <50000000>;
 #include "openbmc-flash-layout-64.dtsi"
 	};
@@ -196,6 +197,7 @@ flash at 0 {
 		status = "okay";
 		m25p,fast-read;
 		label = "pnor";
+		spi-rx-bus-width = <4>;
 		spi-max-frequency = <100000000>;
 	};
 };
-- 
2.35.3

