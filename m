From: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Date: Mon, 20 Mar 2023 16:11:33 +0800
Subject: [PATCH v3 5/5] ARM: dts: aspeed-g6: Add UDMA node
In-Reply-To: <20230320081133.23655-1-chiawei_wang@aspeedtech.com>
References: <20230320081133.23655-1-chiawei_wang@aspeedtech.com>
Message-ID: <20230320081133.23655-6-chiawei_wang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add the device tree node for the UART DMA (UDMA) controller.

Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-g6.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index 8246a60de0d0..172dd748d807 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -863,6 +863,15 @@ fsim1: fsi at 1e79b100 {
 				clocks = <&syscon ASPEED_CLK_GATE_FSICLK>;
 				status = "disabled";
 			};
+
+			udma: dma-controller at 1e79e000 {
+				compatible = "aspeed,ast2600-udma";
+				reg = <0x1e79e000 0x1000>;
+				interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+				dma-channels = <28>;
+				#dma-cells = <1>;
+				status = "disabled";
+			};
 		};
 	};
 };
-- 
2.25.1

