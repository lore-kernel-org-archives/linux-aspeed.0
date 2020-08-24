From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Mon, 24 Aug 2020 11:29:55 -0700
Subject: [PATCH 2/2] ARM: dts: aspeed: wedge40: Update UART4 pin settings
In-Reply-To: <20200824182955.7988-1-rentao.bupt@gmail.com>
References: <20200824182955.7988-1-rentao.bupt@gmail.com>
Message-ID: <20200824182955.7988-3-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

Enable UART4's NRTS4 (A19) pin because the pin is used for RS485
software emulation.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
index 3f2a48fa77b3..8c426ba2f8ab 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
@@ -71,7 +71,8 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_txd4_default
-		     &pinctrl_rxd4_default>;
+		     &pinctrl_rxd4_default
+		     &pinctrl_ndts4_default>;
 };
 
 &uart5 {
-- 
2.17.1

