From: Vijay Khemka <vijaykhemka@fb.com>
Date: Thu, 13 Aug 2020 12:04:30 -0700
Subject: [PATCH] ARM: dts: aspeed: tiogapass: Remove vuart
Message-ID: <20200813190431.3331026-1-vijaykhemka@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Removed vuart for facebook tiogapass platform as it uses uart2 and
uart3 pin with aspeed uart routing feature.

Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
index 2d44d9ad4e40..e6ad821a8635 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
@@ -82,11 +82,6 @@ &lpc_ctrl {
 	status = "okay";
 };
 
-&vuart {
-	// VUART Host Console
-	status = "okay";
-};
-
 &uart1 {
 	// Host Console
 	status = "okay";
-- 
2.24.1

