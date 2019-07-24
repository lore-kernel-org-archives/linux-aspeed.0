From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 24 Jul 2019 17:43:11 +0930
Subject: [PATCH 1/3] dts: ARM: aspeed: Migrate away from aspeed,
 g[45].* compatibles
In-Reply-To: <20190724081313.12934-1-andrew@aj.id.au>
References: <20190724081313.12934-1-andrew@aj.id.au>
Message-ID: <20190724081313.12934-2-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use the SoC-specific compatible strings instead.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 2 +-
 arch/arm/boot/dts/aspeed-g5.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index dd4b0b15afcf..7f06dc21dc19 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -162,7 +162,7 @@
 				#reset-cells = <1>;
 
 				pinctrl: pinctrl {
-					compatible = "aspeed,g4-pinctrl";
+					compatible = "aspeed,ast2400-pinctrl";
 				};
 
 				p2a: p2a-control {
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 5b1ca265c2ce..04c97138e18b 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -215,7 +215,7 @@
 				#reset-cells = <1>;
 
 				pinctrl: pinctrl {
-					compatible = "aspeed,g5-pinctrl";
+					compatible = "aspeed,ast2500-pinctrl";
 					aspeed,external-nodes = <&gfx &lhc>;
 
 				};
-- 
2.20.1

