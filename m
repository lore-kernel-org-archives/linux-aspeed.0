From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Thu,  3 Aug 2023 16:03:22 -0700
Subject: [PATCH 1/3] ARM: dts: aspeed: Update spi alias in Facebook AST2500 Common dtsi
In-Reply-To: <20230803230324.731268-1-rentao.bupt@gmail.com>
References: <20230803230324.731268-1-rentao.bupt@gmail.com>
Message-ID: <20230803230324.731268-2-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

Set FMC controller to "spi0" in ast2500-facebook-netbmc-common.dtsi so
the spi bus is consistent with the flash labels defined in flash layout.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 arch/arm/boot/dts/aspeed/ast2500-facebook-netbmc-common.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/ast2500-facebook-netbmc-common.dtsi b/arch/arm/boot/dts/aspeed/ast2500-facebook-netbmc-common.dtsi
index c0c43b8644ee..7f1ae3f4df9d 100644
--- a/arch/arm/boot/dts/aspeed/ast2500-facebook-netbmc-common.dtsi
+++ b/arch/arm/boot/dts/aspeed/ast2500-facebook-netbmc-common.dtsi
@@ -4,6 +4,10 @@
 #include "aspeed-g5.dtsi"
 
 / {
+	aliases {
+		spi0 = &fmc;
+	};
+
 	memory at 80000000 {
 		reg = <0x80000000 0x40000000>;
 	};
-- 
2.40.1

