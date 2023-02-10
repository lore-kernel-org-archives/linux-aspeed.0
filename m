From: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Date: Fri, 10 Feb 2023 15:26:43 +0800
Subject: [PATCH 4/4] ARM: dts: aspeed-g6: Add UDMA node
In-Reply-To: <20230210072643.2772-1-chiawei_wang@aspeedtech.com>
References: <20230210072643.2772-1-chiawei_wang@aspeedtech.com>
Message-ID: <20230210072643.2772-5-chiawei_wang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add the device tree node for UART DMA controller.

Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-g6.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index cc2f8b785917..3f4e9da8f6c7 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -850,6 +850,13 @@ fsim1: fsi at 1e79b100 {
 				clocks = <&syscon ASPEED_CLK_GATE_FSICLK>;
 				status = "disabled";
 			};
+
+			udma: uart-dma at 1e79e000 {
+				compatible = "aspeed,ast2600-udma";
+				reg = <0x1e79e000 0x400>;
+				interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
 		};
 	};
 };
-- 
2.25.1

