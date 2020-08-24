From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Mon, 24 Aug 2020 11:29:54 -0700
Subject: [PATCH 1/2] ARM: dts: aspeed: wedge40: Update FMC flash0 label
In-Reply-To: <20200824182955.7988-1-rentao.bupt@gmail.com>
References: <20200824182955.7988-1-rentao.bupt@gmail.com>
Message-ID: <20200824182955.7988-2-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

Update FMC flash0's label to "spi0.0" so it's consistent with all the
other Facebook OpenBMC platforms.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
index 8ac23ff6b09e..3f2a48fa77b3 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
@@ -48,7 +48,7 @@
 	flash at 0 {
 		status = "okay";
 		m25p,fast-read;
-		label = "fmc0";
+		label = "spi0.0";
 #include "facebook-bmc-flash-layout.dtsi"
 	};
 };
-- 
2.17.1

