From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Wed, 30 Sep 2020 17:06:03 +0800
Subject: [RESEND PATCH] ARM: dts: aspeed-g6: Fix gpio memory region
In-Reply-To: <20200930051113.32465-1-billy_tsai@aspeedtech.com>
References: <20200930051113.32465-1-billy_tsai@aspeedtech.com>
Message-ID: <20200930090603.19891-1-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-g6.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index 97ca743363d7..b9ec8b579f73 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -357,7 +357,7 @@
 				#gpio-cells = <2>;
 				gpio-controller;
 				compatible = "aspeed,ast2600-gpio";
-				reg = <0x1e780000 0x800>;
+				reg = <0x1e780000 0x500>;
 				interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 				gpio-ranges = <&pinctrl 0 0 208>;
 				ngpios = <208>;
-- 
2.17.1

