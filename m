From: Chanh Nguyen <chanh@os.amperecomputing.com>
Date: Fri, 19 May 2023 15:52:00 +0700
Subject: [PATCH v2 3/3] ARM: dts: aspeed: mtmitchell: Add MCTP
In-Reply-To: <20230519085200.22020-1-chanh@os.amperecomputing.com>
References: <20230519085200.22020-1-chanh@os.amperecomputing.com>
Message-ID: <20230519085200.22020-4-chanh@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Enable MCTP driver on I2C3 bus for MCTP transaction

Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
---
Changes in v2:
   - Update reg for mctp node.                       [Andrew]
---
 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
index d3c7e7c0fd25..c0316c198a88 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
@@ -366,6 +366,13 @@
 
 &i2c3 {
 	status = "okay";
+	bus-frequency = <1000000>;
+	multi-master;
+	mctp-controller;
+	mctp at 10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
 };
 
 &i2c4 {
-- 
2.17.1

