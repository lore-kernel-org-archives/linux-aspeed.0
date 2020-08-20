From: Eddie James <eajames@linux.ibm.com>
Date: Thu, 20 Aug 2020 11:11:52 -0500
Subject: [PATCH 5/5] ARM: dts: Aspeed: Rainier: Add IBM Operation Panel I2C
 device
In-Reply-To: <20200820161152.22751-1-eajames@linux.ibm.com>
References: <20200820161152.22751-1-eajames@linux.ibm.com>
Message-ID: <20200820161152.22751-6-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Set I2C bus 7 to multi-master mode and add the panel device that will
register as a slave.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index b94421f6cbd5..f121f3c26a3a 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -698,6 +698,7 @@ eeprom at 53 {
 };
 
 &i2c7 {
+	multi-master;
 	status = "okay";
 
 	si7021-a20 at 20 {
@@ -831,6 +832,11 @@ gpio at 15 {
 		};
 	};
 
+	ibm-panel at 62 {
+		compatible = "ibm,op-panel";
+		reg = <0x40000062>;	/* I2C_OWN_SLAVE_ADDRESS */
+	};
+
 	dps: dps310 at 76 {
 		compatible = "infineon,dps310";
 		reg = <0x76>;
-- 
2.26.2

