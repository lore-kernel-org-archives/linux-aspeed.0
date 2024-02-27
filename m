From: Peter Yin <peteryin.openbmc@gmail.com>
Date: Tue, 27 Feb 2024 09:47:12 +0800
Subject: [PATCH v4 03/10] ARM: dts: aspeed: Harma: Remove Vuart
In-Reply-To: <20240227014719.3037588-1-peteryin.openbmc@gmail.com>
References: <20240227014719.3037588-1-peteryin.openbmc@gmail.com>
Message-ID: <20240227014719.3037588-4-peteryin.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Remove vuart to avoid port conflict with uart2

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index a0056d633eb1..5d692e9f541e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -100,10 +100,6 @@ &uart_routing {
 	status = "okay";
 };
 
-&vuart1 {
-	status = "okay";
-};
-
 &wdt1 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.25.1

