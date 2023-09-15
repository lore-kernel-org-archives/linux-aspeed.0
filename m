From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 15 Sep 2023 10:19:16 +0200
Subject: [PATCH 2/3] ARM: dts: aspeed: yosemitev2: use proper "mellanox" DT vendor prefix
In-Reply-To: <20230915081917.22368-1-krzysztof.kozlowski@linaro.org>
References: <20230915081917.22368-1-krzysztof.kozlowski@linaro.org>
Message-ID: <20230915081917.22368-2-krzysztof.kozlowski@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

"mlx" Devicetree vendor prefix is not documented and instead "mellanox"
should be used:

  aspeed-bmc-facebook-yosemitev2.dtb: ethernet at 1e660000: 'mlx,multi-host' does not match any of the regexes

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemitev2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemitev2.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemitev2.dts
index 6bf2ff85a40e..5143f85fbd70 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemitev2.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemitev2.dts
@@ -95,7 +95,7 @@ &mac0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rmii1_default>;
 	use-ncsi;
-	mlx,multi-host;
+	mellanox,multi-host;
 };
 
 &adc {
-- 
2.34.1

