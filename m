From: Zev Weiss <zev@bewilderbeest.net>
Date: Wed, 30 Mar 2022 19:24:24 -0700
Subject: [PATCH 1/2] ARM: dts: aspeed: romed8hm3: Add lm25066 sense resistor
 values
Message-ID: <20220331022425.28606-1-zev@bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

With this property set the sensor readings from these devices can now
be calibrated properly.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts b/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts
index e71ccfd1df63..572a43e57cac 100644
--- a/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts
@@ -100,12 +100,14 @@ w83773g at 4c {
 	lm25066 at 40 {
 		compatible = "lm25066";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <1000>;
 	};
 
 	/* 12VSB PMIC */
 	lm25066 at 41 {
 		compatible = "lm25066";
 		reg = <0x41>;
+		shunt-resistor-micro-ohms = <10000>;
 	};
 };
 
-- 
2.35.1

