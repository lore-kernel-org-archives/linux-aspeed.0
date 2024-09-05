From: Chanh Nguyen <chanh@os.amperecomputing.com>
Date: Thu,  5 Sep 2024 06:35:20 +0000
Subject: [PATCH 1/2] ARM: dts: aspeed: mtmitchell: Add I2C FAN controllers
In-Reply-To: <20240905063521.319416-1-chanh@os.amperecomputing.com>
References: <20240905063521.319416-1-chanh@os.amperecomputing.com>
Message-ID: <20240905063521.319416-2-chanh@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add the MAX31790 nodes as i2c fan controllers.

Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
---
 .../boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts   | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
index 0295f5adcfbc..da181f9ae820 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
@@ -684,6 +684,16 @@ bmc-ocp0-en-hog {
 			line-name = "bmc-ocp0-en-n";
 		};
 	};
+
+	fan-controller0 at 20 {
+		compatible = "maxim,max31790";
+		reg = <0x20>;
+	};
+
+	fan-controller1 at 2f {
+		compatible = "maxim,max31790";
+		reg = <0x2f>;
+	};
 };
 
 &i2c9 {
-- 
2.43.0

