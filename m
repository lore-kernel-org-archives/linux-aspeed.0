From: Zev Weiss <zev@bewilderbeest.net>
Date: Fri,  3 Feb 2023 02:54:04 -0800
Subject: [PATCH 1/2] ARM: dts: aspeed: romed8hm3: Fix GPIO polarity of system-fault LED
In-Reply-To: <20230203105405.21942-1-zev@bewilderbeest.net>
References: <20230203105405.21942-1-zev@bewilderbeest.net>
Message-ID: <20230203105405.21942-2-zev@bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Turns out it's in fact not the same as the heartbeat LED.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
Cc: stable at vger.kernel.org # v5.18+
Fixes: a9a3d60b937a ("ARM: dts: aspeed: Add ASRock ROMED8HM3 BMC")
---
 arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts b/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts
index ff4c07c69af1..00efe1a93a69 100644
--- a/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts
@@ -31,7 +31,7 @@ heartbeat {
 		};
 
 		system-fault {
-			gpios = <&gpio ASPEED_GPIO(Z, 2) GPIO_ACTIVE_LOW>;
+			gpios = <&gpio ASPEED_GPIO(Z, 2) GPIO_ACTIVE_HIGH>;
 			panic-indicator;
 		};
 	};
-- 
2.39.1.236.ga8a28b9eace8

