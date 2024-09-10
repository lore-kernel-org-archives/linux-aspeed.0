From: Rob Herring (Arm) <robh@kernel.org>
Date: Tue, 10 Sep 2024 16:59:29 -0500
Subject: [PATCH] ARM: dts: aspeed: Fix at24 EEPROM node names
Message-ID: <20240910215929.823913-1-robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

at24.yaml defines the node name for at24 EEPROMs as 'eeprom'.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dts  | 8 ++++----
 arch/arm/boot/dts/aspeed/aspeed-bmc-vegman-rx20.dts | 6 +++---
 arch/arm/boot/dts/aspeed/aspeed-bmc-vegman.dtsi     | 2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dts
index 983853eedaef..fd361cf073c2 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dts
@@ -381,7 +381,7 @@ SMB_IPMB_3V3AUX_SCL: i2c at 5 {
 			#size-cells = <0>;
 			reg = <5>;
 
-			U190_fru at 51 {
+			eeprom at 51 {
 				compatible = "atmel,24c128";
 				reg = <0x51>;
 				pagesize = <32>;
@@ -460,7 +460,7 @@ &i2c3 {
 	status = "okay";
 
 	/* MB FRU (U173) @ 0xA2 */
-	mb_fru: mb_fru at 51 {
+	mb_fru: eeprom at 51 {
 		compatible = "atmel,24c128";
 		reg = <0x51>;
 		pagesize = <32>;
@@ -472,7 +472,7 @@ FP_U1_tmp75 at 4a {
 		reg = <0x4a>;
 	};
 
-	FP_U4_fru at 52 {
+	eeprom at 52 {
 		compatible = "atmel,24c02";
 		reg = <0x52>;
 		pagesize = <16>;
@@ -593,7 +593,7 @@ &i2c14 {
 	status = "okay";
 
 	/* SCM FRU (U19) @ 0xA2 */
-	scm_fru: scm_fru at 51 {
+	scm_fru: eeprom at 51 {
 		compatible = "atmel,24c128";
 		reg = <0x51>;
 		pagesize = <32>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-vegman-rx20.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-vegman-rx20.dts
index b8f0b08018a3..98f3e0437704 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-vegman-rx20.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-vegman-rx20.dts
@@ -154,7 +154,7 @@ i2c at 7 {
 					#address-cells = <1>;
 					#size-cells = <0>;
 					reg = <7>;
-					at24 at 50 {
+					eeprom at 50 {
 						compatible = "atmel,24c64";
 						reg = <0x50>;
 						pagesize = <32>;
@@ -196,7 +196,7 @@ i2c at 7 {
 					#address-cells = <1>;
 					#size-cells = <0>;
 					reg = <7>;
-					at24 at 50 {
+					eeprom at 50 {
 						compatible = "atmel,24c64";
 						reg = <0x50>;
 						pagesize = <32>;
@@ -205,7 +205,7 @@ at24 at 50 {
 					};
 				};
 			};
-			at24 at 50 {
+			eeprom at 50 {
 				compatible = "atmel,24c64";
 				reg = <0x50>;
 				pagesize = <32>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-vegman.dtsi b/arch/arm/boot/dts/aspeed/aspeed-bmc-vegman.dtsi
index 1a5b25b2ea29..16815eede710 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-vegman.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-vegman.dtsi
@@ -291,7 +291,7 @@ &i2c11 {
 	/* SMB_BMC_MGMT_LVC3 */
 	status = "okay";
 
-	at24 at 50 {
+	eeprom at 50 {
 		compatible = "atmel,24c64";
 		reg = <0x50>;
 		pagesize = <32>;
-- 
2.45.2

