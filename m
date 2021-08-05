From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Thu,  5 Aug 2021 15:28:14 -0700
Subject: [PATCH v2 2/6] ARM: dts: aspeed: wedge400: Use common flash layout
In-Reply-To: <20210805222818.8391-1-rentao.bupt@gmail.com>
References: <20210805222818.8391-1-rentao.bupt@gmail.com>
Message-ID: <20210805222818.8391-3-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

Simplify wedge400 flash layout by using the common layout defined in
"facebook-bmc-flash-layout-128.dtsi".

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 Changes in v2:
  - None.

 .../boot/dts/aspeed-bmc-facebook-wedge400.dts | 48 +------------------
 1 file changed, 1 insertion(+), 47 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts
index 63a3dd548f30..a901c8be49b9 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts
@@ -91,53 +91,7 @@
  * Both firmware flashes are 128MB on Wedge400 BMC.
  */
 &fmc_flash0 {
-	partitions {
-		compatible = "fixed-partitions";
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		/*
-		 * u-boot partition: 384KB.
-		 */
-		u-boot at 0 {
-			reg = <0x0 0x60000>;
-			label = "u-boot";
-		};
-
-		/*
-		 * u-boot environment variables: 128KB.
-		 */
-		u-boot-env at 60000 {
-			reg = <0x60000 0x20000>;
-			label = "env";
-		};
-
-		/*
-		 * FIT image: 123.5 MB.
-		 */
-		fit at 80000 {
-			reg = <0x80000 0x7b80000>;
-			label = "fit";
-		};
-
-		/*
-		 * "data0" partition (4MB) is reserved for persistent
-		 * data store.
-		 */
-		data0 at 7c00000 {
-			reg = <0x7c00000 0x400000>;
-			label = "data0";
-		};
-
-		/*
-		 * "flash0" partition (covering the entire flash) is
-		 * explicitly created to avoid breaking legacy applications.
-		 */
-		flash0 at 0 {
-			reg = <0x0 0x8000000>;
-			label = "flash0";
-		};
-	};
+#include "facebook-bmc-flash-layout-128.dtsi"
 };
 
 &fmc_flash1 {
-- 
2.17.1

