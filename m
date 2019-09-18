From: Alexander Filippov <a.filippov@yadro.com>
Date: Wed, 18 Sep 2019 15:38:15 +0300
Subject: [PATCH] ARM: dts: vesnin: Add power_green led
Message-ID: <20190918123815.20653-1-a.filippov@yadro.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Adds a new power_green led to show the host state.

Signed-off-by: Alexander Filippov <a.filippov@yadro.com>
---
 arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts b/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
index a27c88d23056..affd2c8743b1 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts
@@ -43,6 +43,10 @@
 			gpios = <&gpio ASPEED_GPIO(N, 1) GPIO_ACTIVE_LOW>;
 		};
 
+		power_green {
+			gpios = <&gpio ASPEED_GPIO(F, 1) GPIO_ACTIVE_LOW>;
+		};
+
 		id_blue {
 			gpios = <&gpio ASPEED_GPIO(O, 0) GPIO_ACTIVE_LOW>;
 		};
-- 
2.21.0

