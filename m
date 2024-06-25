From: Yang Chen <yangchen.openbmc@gmail.com>
Date: Tue, 25 Jun 2024 20:18:34 +0800
Subject: [PATCH 16/17] ARM: dts: aspeed: minerva: remove unused power device
In-Reply-To: <20240625121835.751013-1-yangchen.openbmc@gmail.com>
References: <20240625121835.751013-1-yangchen.openbmc@gmail.com>
Message-ID: <20240625121835.751013-17-yangchen.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Remove unused power device.

Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts    | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index 8dd2bbb15576..288d4ba06b99 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -165,16 +165,6 @@ power-monitor at 41 {
 		shunt-resistor = <1000>;
 	};
 
-	power-monitor at 67 {
-		compatible = "adi,ltc2945";
-		reg = <0x67>;
-	};
-
-	power-monitor at 68 {
-		compatible = "adi,ltc2945";
-		reg = <0x68>;
-	};
-
 	power-monitor at 43 {
 		compatible = "infineon,xdp710";
 		reg = <0x43>;
-- 
2.34.1

