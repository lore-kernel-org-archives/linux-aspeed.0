From: Cédric Le Goater <clg@kaod.org>
Date: Fri, 25 Mar 2022 11:08:48 +0100
Subject: [PATCH v4 10/11] ARM: dts: aspeed-g4: Set spi-max-frequency for all
 flashes
In-Reply-To: <20220325100849.2019209-1-clg@kaod.org>
References: <20220325100849.2019209-1-clg@kaod.org>
Message-ID: <20220325100849.2019209-11-clg@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

Set "spi-max-frequency" to 50 MHz for all the flashes under the FMC
controller to ensure the clock frequency is calculated correctly.

Suggested-by: C?dric Le Goater <clg@kaod.org>
Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
Signed-off-by: C?dric Le Goater <clg@kaod.org>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 31e6569db97e..d3d919dcb8d4 100644
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
2.34.1

