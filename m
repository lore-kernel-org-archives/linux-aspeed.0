From: Zev Weiss <zev@bewilderbeest.net>
Date: Mon, 26 Feb 2024 01:17:53 -0800
Subject: [PATCH] ARM: dts: aspeed: ahe50dc: Update lm25066 regulator name
Message-ID: <20240226091754.16027-2-zev@bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

A recent change to the lm25066 driver changed the name of its
regulator from vout0 to vout; device-tree users of lm25066's regulator
functionality (of which ahe50dc is the only one) thus require a
corresponding update.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts
index 6600f7e9bf5e..93f3be849071 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts
@@ -18,7 +18,7 @@ efuse@##hexaddr {							\
 		reg = <0x##hexaddr>;						\
 		shunt-resistor-micro-ohms = <675>;				\
 		regulators {							\
-			efuse##num: vout0 {					\
+			efuse##num: vout {					\
 				regulator-name = __stringify(efuse##num##-reg);	\
 			};							\
 		};								\
-- 
2.43.2

