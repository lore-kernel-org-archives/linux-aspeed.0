From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Mon, 24 Aug 2020 14:19:44 -0700
Subject: [PATCH 1/5] ARM: dts: aspeed: Remove flash layout from Facebook
 AST2500 Common dtsi
In-Reply-To: <20200824211948.12852-1-rentao.bupt@gmail.com>
References: <20200824211948.12852-1-rentao.bupt@gmail.com>
Message-ID: <20200824211948.12852-2-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

Remove FMC flash layout from ast2500-facebook-netbmc-common.dtsi because
flash size and layout varies across different Facebook AST2500 OpenBMC
platforms.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 .../boot/dts/ast2500-facebook-netbmc-common.dtsi    | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/arm/boot/dts/ast2500-facebook-netbmc-common.dtsi b/arch/arm/boot/dts/ast2500-facebook-netbmc-common.dtsi
index 7468f102bd76..c0c43b8644ee 100644
--- a/arch/arm/boot/dts/ast2500-facebook-netbmc-common.dtsi
+++ b/arch/arm/boot/dts/ast2500-facebook-netbmc-common.dtsi
@@ -47,25 +47,12 @@
 		status = "okay";
 		m25p,fast-read;
 		label = "spi0.0";
-
-#include "facebook-bmc-flash-layout.dtsi"
 	};
 
 	fmc_flash1: flash at 1 {
 		status = "okay";
 		m25p,fast-read;
 		label = "spi0.1";
-
-		partitions {
-			compatible = "fixed-partitions";
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			flash1 at 0 {
-				reg = <0x0 0x2000000>;
-				label = "flash1";
-			};
-		};
 	};
 };
 
-- 
2.17.1

