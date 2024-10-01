From: Ninad Palsule <ninad@linux.ibm.com>
Date: Tue,  1 Oct 2024 14:17:48 -0500
Subject: [PATCH v1 1/3] ARM: dts: aspeed: system1: Bump up i2c busses freq
In-Reply-To: <20241001191756.234096-1-ninad@linux.ibm.com>
References: <20241001191756.234096-1-ninad@linux.ibm.com>
Message-ID: <20241001191756.234096-2-ninad@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Bump up i2c8 and i2c15 bus frequency so that PCIe slot and FPGA runs
faster

Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
index f3efecc7eb8d0..1cbf257fb0a0b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
@@ -1007,6 +1007,7 @@ i2c7mux0chn7: i2c at 7 {
 
 &i2c8 {
 	status = "okay";
+	bus-frequency = <400000>;
 
 	i2c-mux at 71 {
 		compatible = "nxp,pca9548";
@@ -1468,6 +1469,7 @@ i2c14mux0chn7: i2c at 7 {
 
 &i2c15 {
 	status = "okay";
+	bus-frequency = <400000>;
 
 	i2c-mux at 71 {
 		compatible = "nxp,pca9548";
-- 
2.43.0

