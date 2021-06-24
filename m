From: Joel Stanley <joel@jms.id.au>
Date: Thu, 24 Jun 2021 18:37:42 +0930
Subject: [PATCH] ARM: dts: aspeed: Fix AST2600 machines line names
Message-ID: <20210624090742.56640-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Tacoma and Rainier both have a line-names array that is too long:

 gpio gpiochip0: gpio-line-names is length 232 but should be at most length 208

This was probably copied from an AST2500 device tree that did have more
GPIOs on the controller.

Fixes: e9b24b55ca4f ("ARM: dts: aspeed: rainier: Add gpio line names")
Fixes: 2f68e4e7df67 ("ARM: dts: aspeed: tacoma: Add gpio line names")
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 5 +----
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts  | 5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index 941c0489479a..481d0ee1f85f 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -280,10 +280,7 @@ &gpio0 {
 	/*W0-W7*/	"","","","","","","","",
 	/*X0-X7*/	"","","","","","","","",
 	/*Y0-Y7*/	"","","","","","","","",
-	/*Z0-Z7*/	"","","","","","","","",
-	/*AA0-AA7*/	"","","","","","","","",
-	/*AB0-AB7*/	"","","","","","","","",
-	/*AC0-AC7*/	"","","","","","","","";
+	/*Z0-Z7*/	"","","","","","","","";
 
 	pin_mclr_vpp {
 		gpio-hog;
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
index e863ec088970..48038b2ef3df 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
@@ -136,10 +136,7 @@ &gpio0 {
 	/*W0-W7*/	"","","","","","","","",
 	/*X0-X7*/	"","","","","","","","",
 	/*Y0-Y7*/	"","","","","","","","",
-	/*Z0-Z7*/	"","","","","","","","",
-	/*AA0-AA7*/	"","","","","","","","",
-	/*AB0-AB7*/	"","","","","","","","",
-	/*AC0-AC7*/	"","","","","","","","";
+	/*Z0-Z7*/	"","","","","","","","";
 };
 
 &fmc {
-- 
2.32.0

