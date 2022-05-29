From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 29 May 2022 12:49:28 +0200
Subject: [PATCH 7/7] ARM: dts: aspeed: centriq2400: use qcom compatible
In-Reply-To: <20220529104928.79636-1-krzysztof.kozlowski@linaro.org>
References: <20220529104928.79636-1-krzysztof.kozlowski@linaro.org>
Message-ID: <20220529104928.79636-7-krzysztof.kozlowski@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

"qualcomm" is not a documented compatible and instead "qcom" should be
used.

Fixes: 3719a1b13056 ("ARM: dts: aspeed: Add Qualcomm Centriq 2400 REP BMC")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts b/arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts
index 3395de96ee11..2e8b87783717 100644
--- a/arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts
@@ -6,7 +6,7 @@
 
 / {
 	model = "Qualcomm Centriq 2400  REP AST2520";
-	compatible = "qualcomm,centriq2400-rep-bmc", "aspeed,ast2500";
+	compatible = "qcom,centriq2400-rep-bmc", "aspeed,ast2500";
 
 	chosen {
 		stdout-path = &uart5;
-- 
2.34.1

