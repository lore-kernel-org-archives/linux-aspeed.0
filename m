From: Renze Nicolai <renze@rnplus.nl>
Date: Wed,  3 Apr 2024 15:28:53 +0200
Subject: [PATCH v2 3/3] ARM: dts: Modify I2C bus configuration
In-Reply-To: <20240403133037.37782-1-renze@rnplus.nl>
References: <20240403133037.37782-1-renze@rnplus.nl>
Message-ID: <20240403133037.37782-4-renze@rnplus.nl>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Enable I2C bus 8 which is exposed on the IPMB_1 connector
on the X570D4U mainboard.

Additionally adds a descriptive comment to I2C busses 1 and 5.

Signed-off-by: Renze Nicolai <renze@rnplus.nl>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
index 66318ef8caae..8dee4faa9e07 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
@@ -162,6 +162,7 @@ &i2c0 {
 };
 
 &i2c1 {
+	/* Hardware monitoring SMBus */
 	status = "okay";
 
 	w83773g at 4c {
@@ -219,6 +220,7 @@ i2c4mux0ch3: i2c at 3 {
 };
 
 &i2c5 {
+	/* SMBus on BMC connector (BMC_SMB_1) */
 	status = "okay";
 };
 
@@ -243,6 +245,11 @@ eth1_macaddress: macaddress at 3f88 {
 	};
 };
 
+&i2c8 {
+	/* SMBus on intelligent platform management bus header (IPMB_1) */
+	status = "okay";
+};
+
 &gfx {
 	status = "okay";
 };
-- 
2.44.0

