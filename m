From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Mon, 24 Aug 2020 14:19:47 -0700
Subject: [PATCH 4/5] ARM: dts: aspeed: minipack: Update 64MB FMC flash layout
In-Reply-To: <20200824211948.12852-1-rentao.bupt@gmail.com>
References: <20200824211948.12852-1-rentao.bupt@gmail.com>
Message-ID: <20200824211948.12852-5-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

Set 64Mb FMC flash layout in Minipack device tree explicitly because the
flash layout was removed from "ast2500-facebook-netbmc-common.dtsi".

Please note "data0" partition' size is updated to 4MB to be consistent
with other Facebook OpenBMC platforms.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 .../boot/dts/aspeed-bmc-facebook-minipack.dts | 47 ++++++++++++++++++-
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-minipack.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-minipack.dts
index 88ce4ff9f47e..c34741dbd268 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-minipack.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-minipack.dts
@@ -88,17 +88,60 @@
  */
 &fmc_flash0 {
 	partitions {
-		data0 at 1c00000 {
-			reg = <0x1c00000 0x2400000>;
+		compatible = "fixed-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		/*
+		 * u-boot partition: 384KB.
+		 */
+		u-boot at 0 {
+			reg = <0x0 0x60000>;
+			label = "u-boot";
 		};
+
+		/*
+		 * u-boot environment variables: 128KB.
+		 */
+		u-boot-env at 60000 {
+			reg = <0x60000 0x20000>;
+			label = "env";
+		};
+
+		/*
+		 * FIT image: 59.5 MB.
+		 */
+		fit at 80000 {
+			reg = <0x80000 0x3b80000>;
+			label = "fit";
+		};
+
+		/*
+		 * "data0" partition (4MB) is reserved for persistent
+		 * data store.
+		 */
+		data0 at 3800000 {
+			reg = <0x3c00000 0x400000>;
+			label = "data0";
+		};
+
+		/*
+		 * "flash0" partition (covering the entire flash) is
+		 * explicitly created to avoid breaking legacy applications.
+		 */
 		flash0 at 0 {
 			reg = <0x0 0x4000000>;
+			label = "flash0";
 		};
 	};
 };
 
 &fmc_flash1 {
 	partitions {
+		compatible = "fixed-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
 		flash1 at 0 {
 			reg = <0x0 0x4000000>;
 		};
-- 
2.17.1

