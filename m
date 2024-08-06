From: Chanh Nguyen <chanh@os.amperecomputing.com>
Date: Tue,  6 Aug 2024 07:18:03 +0000
Subject: [PATCH v2 2/5] ARM: dts: aspeed: mtmitchell: Add I2C temperature sensor alias ports
In-Reply-To: <20240806071806.1666550-1-chanh@os.amperecomputing.com>
References: <20240806071806.1666550-1-chanh@os.amperecomputing.com>
Message-ID: <20240806071806.1666550-3-chanh@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add the I2C alias ports to read temperature sensors via channels
of the I2C muxes.

Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
---
Changes in v2:
  - None
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
index 3a97e88278d5..1679911e4fd8 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
@@ -15,6 +15,14 @@ aliases {
 		serial7 = &uart8;
 		serial8 = &uart9;
 
+		/*
+		 * I2C temperature alias port
+		 */
+		i2c20 = &i2c4_bus70_chn0;
+		i2c21 = &i2c4_bus70_chn1;
+		i2c22 = &i2c4_bus70_chn2;
+		i2c23 = &i2c4_bus70_chn3;
+
 		/*
 		 *  i2c bus 30-31 assigned to OCP slot 0-1
 		 */
-- 
2.43.0

