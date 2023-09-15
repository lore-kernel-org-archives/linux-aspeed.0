From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 15 Sep 2023 10:19:17 +0200
Subject: [PATCH 3/3] ARM: dts: aspeed: yosemite4: use proper "mellanox" DT vendor prefix
In-Reply-To: <20230915081917.22368-1-krzysztof.kozlowski@linaro.org>
References: <20230915081917.22368-1-krzysztof.kozlowski@linaro.org>
Message-ID: <20230915081917.22368-3-krzysztof.kozlowski@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

"mlx" Devicetree vendor prefix is not documented and instead "mellanox"
should be used.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 64075cc41d92..1bd555a6c3ba 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -88,7 +88,7 @@ &mac2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rmii3_default>;
 	use-ncsi;
-	mlx,multi-host;
+	mellanox,multi-host;
 };
 
 &mac3 {
@@ -96,7 +96,7 @@ &mac3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rmii4_default>;
 	use-ncsi;
-	mlx,multi-host;
+	mellanox,multi-host;
 };
 
 &fmc {
-- 
2.34.1

