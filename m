From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 02 Aug 2024 13:55:18 +0930
Subject: [PATCH 1/7] ARM: dts: aspeed: Fix coprocessor interrupt controller
 node name
In-Reply-To: <20240802-dt-warnings-bmc-dts-cleanups-v1-0-1cb1378e5fcd@codeconstruct.com.au>
References: <20240802-dt-warnings-bmc-dts-cleanups-v1-0-1cb1378e5fcd@codeconstruct.com.au>
Message-ID: <20240802-dt-warnings-bmc-dts-cleanups-v1-1-1cb1378e5fcd@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Squash schema warnings such as:

```
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: copro-interrupt-controller at 1e6c2000: $nodename:0: 'copro-interrupt-controller at 1e6c2000' does not match '^interrupt-controller(@[0-9a-f,]+)*$'
```

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 arch/arm/boot/dts/aspeed/aspeed-g4.dtsi | 2 +-
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
index c669ec202085..267a0c8e828b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
@@ -122,7 +122,7 @@ vic: interrupt-controller at 1e6c0080 {
 			reg = <0x1e6c0080 0x80>;
 		};
 
-		cvic: copro-interrupt-controller at 1e6c2000 {
+		cvic: interrupt-controller at 1e6c2000 {
 			compatible = "aspeed,ast2400-cvic", "aspeed-cvic";
 			valid-sources = <0x7fffffff>;
 			reg = <0x1e6c2000 0x80>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
index 6e05cbcce49c..4d805cf344a1 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
@@ -139,7 +139,7 @@ vic: interrupt-controller at 1e6c0080 {
 			reg = <0x1e6c0080 0x80>;
 		};
 
-		cvic: copro-interrupt-controller at 1e6c2000 {
+		cvic: interrupt-controller at 1e6c2000 {
 			compatible = "aspeed,ast2500-cvic", "aspeed-cvic";
 			valid-sources = <0xffffffff>;
 			copro-sw-interrupts = <1>;

-- 
2.39.2

