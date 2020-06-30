From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Mon, 29 Jun 2020 17:08:49 -0700
Subject: [PATCH 1/3] ARM: dts: aspeed: wedge40: disable a few i2c controllers
In-Reply-To: <20200630000851.26879-1-rentao.bupt@gmail.com>
References: <20200630000851.26879-1-rentao.bupt@gmail.com>
Message-ID: <20200630000851.26879-2-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

Disable i2c bus #9, #10 and #13 as these i2c controllers are not used on
Wedge40.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
index 54e508530dce..aea23c313088 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
@@ -115,14 +115,6 @@
 	status = "okay";
 };
 
-&i2c9 {
-	status = "okay";
-};
-
-&i2c10 {
-	status = "okay";
-};
-
 &i2c11 {
 	status = "okay";
 };
@@ -131,10 +123,6 @@
 	status = "okay";
 };
 
-&i2c13 {
-	status = "okay";
-};
-
 &vhub {
 	status = "okay";
 };
-- 
2.17.1

