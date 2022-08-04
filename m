From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu,  4 Aug 2022 11:27:27 +0200
Subject: [PATCH] ARM: dts: ast2600-evb: correct compatible (drop -a1)
Message-ID: <20220804092727.64742-1-krzysztof.kozlowski@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Due to copy-paste, the ast2600-evb and ast2600-evb-a1 got the same
compatible.  Drop the '-a1' suffix from the first to match what is
expected by bindings.

Fixes: aa5e06208500 ("ARM: dts: ast2600-evb: fix board compatible")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/aspeed-ast2600-evb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
index c698e6538269..2010e3cb6158 100644
--- a/arch/arm/boot/dts/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2600-evb.dts
@@ -8,7 +8,7 @@
 
 / {
 	model = "AST2600 EVB";
-	compatible = "aspeed,ast2600-evb-a1", "aspeed,ast2600";
+	compatible = "aspeed,ast2600-evb", "aspeed,ast2600";
 
 	aliases {
 		serial4 = &uart5;
-- 
2.34.1

