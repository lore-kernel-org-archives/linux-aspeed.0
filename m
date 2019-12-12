From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Thu, 12 Dec 2019 15:16:21 -0800
Subject: [PATCH 1/2] ARM: dts: aspeed: delete no-hw-checksum from Facebook
 NetBMC Common dtsi
In-Reply-To: <20191212231622.302-1-rentao.bupt@gmail.com>
References: <20191212231622.302-1-rentao.bupt@gmail.com>
Message-ID: <20191212231622.302-2-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

Delete "no-hw-checksum" property from ast2500-facebook-netbmc-common.dtsi
because ftgmac100's checksum issue has been fixed by commit 88824e3bf29a
("net: ethernet: ftgmac100: Fix DMA coherency issue with SW checksum").

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 arch/arm/boot/dts/ast2500-facebook-netbmc-common.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/ast2500-facebook-netbmc-common.dtsi b/arch/arm/boot/dts/ast2500-facebook-netbmc-common.dtsi
index 7a395ba56512..7468f102bd76 100644
--- a/arch/arm/boot/dts/ast2500-facebook-netbmc-common.dtsi
+++ b/arch/arm/boot/dts/ast2500-facebook-netbmc-common.dtsi
@@ -71,7 +71,6 @@
 
 &mac1 {
 	status = "okay";
-	no-hw-checksum;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rgmii2_default &pinctrl_mdio2_default>;
 };
-- 
2.17.1

