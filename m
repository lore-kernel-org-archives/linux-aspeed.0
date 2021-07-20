From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Mon, 19 Jul 2021 17:27:04 -0700
Subject: [PATCH] ARM: dts: aspeed: minipack: Update flash partition table
Message-ID: <20210720002704.7390-1-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

Update firmware flash "data0" partition size from 4MB to 8MB for larger
persistent storage on minipack BMC.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-minipack.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-minipack.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-minipack.dts
index 9eb23e874f19..230d16cd9967 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-minipack.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-minipack.dts
@@ -265,19 +265,19 @@
 		};
 
 		/*
-		 * FIT image: 59.5 MB.
+		 * FIT image: 55.5 MB.
 		 */
 		fit at 80000 {
-			reg = <0x80000 0x3b80000>;
+			reg = <0x80000 0x3780000>;
 			label = "fit";
 		};
 
 		/*
-		 * "data0" partition (4MB) is reserved for persistent
+		 * "data0" partition (8MB) is reserved for persistent
 		 * data store.
 		 */
 		data0 at 3800000 {
-			reg = <0x3c00000 0x400000>;
+			reg = <0x3800000 0x800000>;
 			label = "data0";
 		};
 
-- 
2.17.1

