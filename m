From: Chanh Nguyen <chanh@os.amperecomputing.com>
Date: Thu,  5 Sep 2024 06:35:21 +0000
Subject: [PATCH 2/2] ARM: dts: aspeed: mtmitchell: Add gpio line names for io expanders
In-Reply-To: <20240905063521.319416-1-chanh@os.amperecomputing.com>
References: <20240905063521.319416-1-chanh@os.amperecomputing.com>
Message-ID: <20240905063521.319416-3-chanh@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add below gpio line names to io expanders for more platform features.

- ext-vref-sel
- presence-hdd-bp5-n
- presence-hdd-bp6-n
- bmc-ocp0-en-n
- bmc-ocp1-en-n
- bmc-riser-en-n
- gpi0, gpi1

Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
index da181f9ae820..2b336aa0146d 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
@@ -677,6 +677,12 @@ gpio at 77 {
 		#size-cells = <0>;
 		#gpio-cells = <2>;
 
+		gpio-line-names =
+		"ext-vref-sel","","presence-hdd-bp5-n","presence-hdd-bp6-n",
+		"","bmc-riser-en-n","bmc-ocp1-en-n","bmc-ocp0-en-n",
+		"","","","",
+		"","","","";
+
 		bmc-ocp0-en-hog {
 			gpio-hog;
 			gpios = <7 GPIO_ACTIVE_LOW>;
@@ -968,7 +974,7 @@ gpio_expander1: gpio-expander at 22 {
 			"fan-fault","psu-fault",
 			"","",
 			"","",
-			"","",
+			"gpi0","gpi1",
 			"","",
 			"","",
 			"","",
-- 
2.43.0

