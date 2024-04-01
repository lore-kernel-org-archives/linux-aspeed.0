From: Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>
Date: Mon,  1 Apr 2024 17:05:09 +0800
Subject: [PATCH v1] Revise duty cycle for SMB9 and SMB10
Message-ID: <20240401090509.2338027-1-Delphine_CC_Chiu@Wiwynn.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

ARM: dts: aspeed: yosemite4:
Revise duty cycle for SMB9 and SMB10 to 40:60
To meet 400kHz-i2c clock low time spec (> 1.3 us).

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 64075cc41d92..b3a2aa8f53a5 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -257,6 +257,7 @@ power-sensor at 40 {
 &i2c8 {
 	status = "okay";
 	bus-frequency = <400000>;
+	i2c-clk-high-min-percent = <40>;
 	i2c-mux at 70 {
 		compatible = "nxp,pca9544";
 		idle-state = <0>;
@@ -268,6 +269,7 @@ i2c-mux at 70 {
 &i2c9 {
 	status = "okay";
 	bus-frequency = <400000>;
+	i2c-clk-high-min-percent = <40>;
 	i2c-mux at 71 {
 		compatible = "nxp,pca9544";
 		idle-state = <0>;
-- 
2.25.1

