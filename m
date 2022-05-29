From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 29 May 2022 12:49:27 +0200
Subject: [PATCH 6/7] ARM: dts: ast2600-evb-a1: fix board compatible
In-Reply-To: <20220529104928.79636-1-krzysztof.kozlowski@linaro.org>
References: <20220529104928.79636-1-krzysztof.kozlowski@linaro.org>
Message-ID: <20220529104928.79636-6-krzysztof.kozlowski@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The AST2600 EVB A1 board should have dedicated compatible.

Fixes: a72955180372 ("ARM: dts: aspeed: ast2600evb: Add dts file for A1 and A0")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts b/arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts
index dd7148060c4a..d0a5c2ff0fec 100644
--- a/arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts
+++ b/arch/arm/boot/dts/aspeed-ast2600-evb-a1.dts
@@ -5,6 +5,7 @@
 
 / {
 	model = "AST2600 A1 EVB";
+	compatible = "aspeed,ast2600-evb-a1", "aspeed,ast2600";
 
 	/delete-node/regulator-vcc-sdhci0;
 	/delete-node/regulator-vcc-sdhci1;
-- 
2.34.1

