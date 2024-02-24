From: Zev Weiss <zev@bewilderbeest.net>
Date: Sat, 24 Feb 2024 02:37:07 -0800
Subject: [PATCH] ARM: dts: aspeed: Add vendor prefixes to lm25066 compat strings
Message-ID: <20240224103712.20864-2-zev@bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Due to the way i2c driver matching works (falling back to the driver's
id_table if of_match_table fails) this didn't actually cause any
misbehavior, but let's add the vendor prefixes so things actually work
the way they were intended to.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts | 4 ++--
 arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts
index 4554abf0c7cd..9aa2de3723b5 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-romed8hm3.dts
@@ -98,14 +98,14 @@ w83773g at 4c {
 
 	/* IPB PMIC */
 	lm25066 at 40 {
-		compatible = "lm25066";
+		compatible = "ti,lm25066";
 		reg = <0x40>;
 		shunt-resistor-micro-ohms = <1000>;
 	};
 
 	/* 12VSB PMIC */
 	lm25066 at 41 {
-		compatible = "lm25066";
+		compatible = "ti,lm25066";
 		reg = <0x41>;
 		shunt-resistor-micro-ohms = <10000>;
 	};
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts
index 6600f7e9bf5e..e830fec0570f 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts
@@ -14,7 +14,7 @@ efuse##n {					\
 
 #define EFUSE(hexaddr, num)							\
 	efuse@##hexaddr {							\
-		compatible = "lm25066";						\
+		compatible = "ti,lm25066";					\
 		reg = <0x##hexaddr>;						\
 		shunt-resistor-micro-ohms = <675>;				\
 		regulators {							\
-- 
2.43.2

