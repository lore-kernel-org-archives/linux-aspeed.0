From: Chanh Nguyen <chanh@os.amperecomputing.com>
Date: Tue, 20 Jun 2023 16:25:37 +0700
Subject: [PATCH v3 3/3] ARM: dts: aspeed: mtmitchell: Add MCTP
In-Reply-To: <20230620092537.20007-1-chanh@os.amperecomputing.com>
References: <20230620092537.20007-1-chanh@os.amperecomputing.com>
Message-ID: <20230620092537.20007-4-chanh@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Enable MCTP driver on I2C3 bus for MCTP transaction

Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
---
Changes in v3:
  - Fix build error                            [kernel test robot]
Changes in v2:
  - Update reg for mctp node.                  [Andrew]
---
 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
index d3c7e7c0fd25..2f240a88b382 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
@@ -4,6 +4,7 @@
 /dts-v1/;
 
 #include "aspeed-g6.dtsi"
+#include <dt-bindings/i2c/i2c.h>
 #include <dt-bindings/gpio/aspeed-gpio.h>
 
 / {
@@ -366,6 +367,13 @@
 
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

