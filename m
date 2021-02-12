From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 12 Feb 2021 17:26:40 +0100
Subject: [RESEND PATCH v3 2/2] ARM: dts: aspeed: align GPIO hog names with
 dtschema
In-Reply-To: <20210212162640.66677-1-krzk@kernel.org>
References: <20210212162640.66677-1-krzk@kernel.org>
Message-ID: <20210212162640.66677-2-krzk@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

dtschema for pca95xx expects GPIO hogs to end with 'hog' suffix.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts |  2 +-
 arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts  | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index a4b77aec5424..5c98130358c8 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -579,7 +579,7 @@ tca9554 at 40 {
 		gpio-controller;
 		#gpio-cells = <2>;
 
-		smbus0 {
+		smbus0-hog {
 			gpio-hog;
 			gpios = <4 GPIO_ACTIVE_HIGH>;
 			output-high;
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts b/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
index cb85168f6761..577c211c469e 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
@@ -827,7 +827,7 @@ tca9554 at 39 {
 				gpio-controller;
 				#gpio-cells = <2>;
 
-				smbus0 {
+				smbus0-hog {
 					gpio-hog;
 					gpios = <4 GPIO_ACTIVE_HIGH>;
 					output-high;
@@ -852,7 +852,7 @@ tca9554 at 39 {
 				gpio-controller;
 				#gpio-cells = <2>;
 
-				smbus1 {
+				smbus1-hog {
 					gpio-hog;
 					gpios = <4 GPIO_ACTIVE_HIGH>;
 					output-high;
@@ -900,7 +900,7 @@ tca9554 at 39 {
 				gpio-controller;
 				#gpio-cells = <2>;
 
-				smbus2 {
+				smbus2-hog {
 					gpio-hog;
 					gpios = <4 GPIO_ACTIVE_HIGH>;
 					output-high;
@@ -925,7 +925,7 @@ tca9554 at 39 {
 				gpio-controller;
 				#gpio-cells = <2>;
 
-				smbus3 {
+				smbus3-hog {
 					gpio-hog;
 					gpios = <4 GPIO_ACTIVE_HIGH>;
 					output-high;
@@ -992,7 +992,7 @@ tca9554 at 39 {
 				gpio-controller;
 				#gpio-cells = <2>;
 
-				smbus4 {
+				smbus4-hog {
 					gpio-hog;
 					gpios = <4 GPIO_ACTIVE_HIGH>;
 					output-high;
@@ -1017,7 +1017,7 @@ tca9554 at 39 {
 				gpio-controller;
 				#gpio-cells = <2>;
 
-				smbus5 {
+				smbus5-hog {
 					gpio-hog;
 					gpios = <4 GPIO_ACTIVE_HIGH>;
 					output-high;
@@ -1065,7 +1065,7 @@ tca9554 at 39 {
 				gpio-controller;
 				#gpio-cells = <2>;
 
-				smbus6 {
+				smbus6-hog {
 					gpio-hog;
 					gpios = <4 GPIO_ACTIVE_HIGH>;
 					output-high;
@@ -1090,7 +1090,7 @@ tca9554 at 39 {
 				gpio-controller;
 				#gpio-cells = <2>;
 
-				smbus7 {
+				smbus7-hog {
 					gpio-hog;
 					gpios = <4 GPIO_ACTIVE_HIGH>;
 					output-high;
-- 
2.25.1

