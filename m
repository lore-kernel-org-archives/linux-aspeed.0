From: Eddie James <eajames@linux.ibm.com>
Date: Tue, 21 Mar 2023 10:16:42 -0500
Subject: [PATCH v2 4/4] ARM: dts: aspeed: bonnell: Add DIMM SPD
In-Reply-To: <20230321151642.461618-1-eajames@linux.ibm.com>
References: <20230321151642.461618-1-eajames@linux.ibm.com>
Message-ID: <20230321151642.461618-5-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add the DIMM SPD to the processor I2C busses.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts
index 79516dc21c01..72186020e75a 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts
@@ -232,18 +232,38 @@ cfam0_i2c1: i2c-bus at 1 {
 
 			cfam0_i2c10: i2c-bus at a {
 				reg = <10>;	/* OP3A */
+
+				eeprom at 50 {
+					compatible = "atmel,at30tse";
+					reg = <0x50>;
+				};
 			};
 
 			cfam0_i2c11: i2c-bus at b {
 				reg = <11>;	/* OP3B */
+
+				eeprom at 50 {
+					compatible = "atmel,at30tse";
+					reg = <0x50>;
+				};
 			};
 
 			cfam0_i2c12: i2c-bus at c {
 				reg = <12>;	/* OP4A */
+
+				eeprom at 50 {
+					compatible = "atmel,at30tse";
+					reg = <0x50>;
+				};
 			};
 
 			cfam0_i2c13: i2c-bus at d {
 				reg = <13>;	/* OP4B */
+
+				eeprom at 50 {
+					compatible = "atmel,at30tse";
+					reg = <0x50>;
+				};
 			};
 
 			cfam0_i2c14: i2c-bus at e {
-- 
2.31.1

