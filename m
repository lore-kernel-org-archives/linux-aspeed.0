From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Thu, 12 Dec 2019 15:16:22 -0800
Subject: [PATCH 2/2] ARM: dts: aspeed: delete no-hw-checksum from yamp dts
In-Reply-To: <20191212231622.302-1-rentao.bupt@gmail.com>
References: <20191212231622.302-1-rentao.bupt@gmail.com>
Message-ID: <20191212231622.302-3-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

Delete "no-hw-checksum" property from yamp dts file because ftgmac100's
checksum issue has been fixed by commit 88824e3bf29a ("net: ethernet:
ftgmac100: Fix DMA coherency issue with SW checksum").

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts
index 52933598aac6..fe2e11c2da15 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts
@@ -35,7 +35,6 @@
 &mac0 {
 	status = "okay";
 	use-ncsi;
-	no-hw-checksum;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rmii1_default>;
 	clocks = <&syscon ASPEED_CLK_GATE_MAC1CLK>,
-- 
2.17.1

