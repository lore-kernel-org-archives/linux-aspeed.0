From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 02 Aug 2024 13:55:23 +0930
Subject: [PATCH 6/7] ARM: dts: aspeed-g6: Use generic 'ethernet' for
 ftgmac100 nodes
In-Reply-To: <20240802-dt-warnings-bmc-dts-cleanups-v1-0-1cb1378e5fcd@codeconstruct.com.au>
References: <20240802-dt-warnings-bmc-dts-cleanups-v1-0-1cb1378e5fcd@codeconstruct.com.au>
Message-ID: <20240802-dt-warnings-bmc-dts-cleanups-v1-6-1cb1378e5fcd@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Squash warnings such as:

```
arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dtb: ftgmac at 1e670000: $nodename:0: 'ftgmac at 1e670000' does not match '^ethernet(@.*)?$'
```

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 6505eebf91af..ae8aa54508b2 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -231,7 +231,7 @@ mdio3: mdio at 1e650018 {
 			resets = <&syscon ASPEED_RESET_MII>;
 		};
 
-		mac0: ftgmac at 1e660000 {
+		mac0: ethernet at 1e660000 {
 			compatible = "aspeed,ast2600-mac", "faraday,ftgmac100";
 			reg = <0x1e660000 0x180>;
 			#address-cells = <1>;
@@ -241,7 +241,7 @@ mac0: ftgmac at 1e660000 {
 			status = "disabled";
 		};
 
-		mac1: ftgmac at 1e680000 {
+		mac1: ethernet at 1e680000 {
 			compatible = "aspeed,ast2600-mac", "faraday,ftgmac100";
 			reg = <0x1e680000 0x180>;
 			#address-cells = <1>;
@@ -251,7 +251,7 @@ mac1: ftgmac at 1e680000 {
 			status = "disabled";
 		};
 
-		mac2: ftgmac at 1e670000 {
+		mac2: ethernet at 1e670000 {
 			compatible = "aspeed,ast2600-mac", "faraday,ftgmac100";
 			reg = <0x1e670000 0x180>;
 			#address-cells = <1>;
@@ -261,7 +261,7 @@ mac2: ftgmac at 1e670000 {
 			status = "disabled";
 		};
 
-		mac3: ftgmac at 1e690000 {
+		mac3: ethernet at 1e690000 {
 			compatible = "aspeed,ast2600-mac", "faraday,ftgmac100";
 			reg = <0x1e690000 0x180>;
 			#address-cells = <1>;

-- 
2.39.2

