From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 02 Aug 2024 13:55:19 +0930
Subject: [PATCH 2/7] ARM: dts: aspeed: Specify correct generic compatible
 for CVIC
In-Reply-To: <20240802-dt-warnings-bmc-dts-cleanups-v1-0-1cb1378e5fcd@codeconstruct.com.au>
References: <20240802-dt-warnings-bmc-dts-cleanups-v1-0-1cb1378e5fcd@codeconstruct.com.au>
Message-ID: <20240802-dt-warnings-bmc-dts-cleanups-v1-2-1cb1378e5fcd@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The ASPEED CVIC binding documents `aspeed,cvic` as the required generic
compatible, but the devicetrees contained `aspeed-cvic`. Update the
devictrees to use `aspeed,cvic` as documented and as required by
the driver implementation. Presumably the bug was the result of some
incoherent thoughts while removing the SoC name at the time of
writing.

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 arch/arm/boot/dts/aspeed/aspeed-g4.dtsi | 2 +-
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
index 267a0c8e828b..ec9563c629df 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
@@ -123,7 +123,7 @@ vic: interrupt-controller at 1e6c0080 {
 		};
 
 		cvic: interrupt-controller at 1e6c2000 {
-			compatible = "aspeed,ast2400-cvic", "aspeed-cvic";
+			compatible = "aspeed,ast2400-cvic", "aspeed,cvic";
 			valid-sources = <0x7fffffff>;
 			reg = <0x1e6c2000 0x80>;
 		};
diff --git a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
index 4d805cf344a1..a846df1a65ff 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
@@ -140,7 +140,7 @@ vic: interrupt-controller at 1e6c0080 {
 		};
 
 		cvic: interrupt-controller at 1e6c2000 {
-			compatible = "aspeed,ast2500-cvic", "aspeed-cvic";
+			compatible = "aspeed,ast2500-cvic", "aspeed,cvic";
 			valid-sources = <0xffffffff>;
 			copro-sw-interrupts = <1>;
 			reg = <0x1e6c2000 0x80>;

-- 
2.39.2

