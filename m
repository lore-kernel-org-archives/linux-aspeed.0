From: Chanh Nguyen <chanh@os.amperecomputing.com>
Date: Tue, 25 Apr 2023 13:57:13 +0700
Subject: [PATCH 2/4] ARM: dts: aspeed: mtmitchell: Add I2C Fan
In-Reply-To: <20230425065715.21871-1-chanh@os.amperecomputing.com>
References: <20230425065715.21871-1-chanh@os.amperecomputing.com>
Message-ID: <20230425065715.21871-3-chanh@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add the MAX31790 node as a Fan I2C controller. It controls the
TACH and PWM for Fan Mt.Mitchell system.

Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
---
 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
index e79f56208b89..6455cf80da0e 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
@@ -477,6 +477,18 @@
 			line-name = "bmc-ocp0-en-n";
 		};
 	};
+
+	max31790 at 20 {
+		compatible = "maxim,max31790";
+		reg = <0x20>;
+		pwm-to-tach = <0 0 0 0 1 1>;
+	};
+
+	max31790 at 2f {
+		compatible = "maxim,max31790";
+		reg = <0x2f>;
+		pwm-to-tach = <0 0 0 0 1 1>;
+	};
 };
 
 &i2c9 {
-- 
2.17.1

