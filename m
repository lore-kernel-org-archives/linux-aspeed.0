From: Cédric Le Goater <clg@kaod.org>
Date: Mon,  9 May 2022 19:56:15 +0200
Subject: [PATCH v7 10/11] ARM: dts: aspeed-g4: Set spi-max-frequency for all
 flashes
In-Reply-To: <20220509175616.1089346-1-clg@kaod.org>
References: <20220509175616.1089346-1-clg@kaod.org>
Message-ID: <20220509175616.1089346-11-clg@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

Set "spi-max-frequency" to 50 MHz for all the flashes under the FMC
controller to ensure the clock frequency is calculated correctly.

Suggested-by: C?dric Le Goater <clg@kaod.org>
Tested-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
Signed-off-by: C?dric Le Goater <clg@kaod.org>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 1c6354cec9f2..530491ae5eb2 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -72,24 +72,28 @@ flash at 1 {
 				reg = < 1 >;
 				compatible = "jedec,spi-nor";
 				spi-rx-bus-width = <2>;
+				spi-max-frequency = <50000000>;
 				status = "disabled";
 			};
 			flash at 2 {
 				reg = < 2 >;
 				compatible = "jedec,spi-nor";
 				spi-rx-bus-width = <2>;
+				spi-max-frequency = <50000000>;
 				status = "disabled";
 			};
 			flash at 3 {
 				reg = < 3 >;
 				compatible = "jedec,spi-nor";
 				spi-rx-bus-width = <2>;
+				spi-max-frequency = <50000000>;
 				status = "disabled";
 			};
 			flash at 4 {
 				reg = < 4 >;
 				compatible = "jedec,spi-nor";
 				spi-rx-bus-width = <2>;
+				spi-max-frequency = <50000000>;
 				status = "disabled";
 			};
 		};
-- 
2.35.1

