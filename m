From: Eddie James <eajames@linux.ibm.com>
Date: Mon, 29 Mar 2021 10:00:03 -0500
Subject: [PATCH 05/22] ARM: dts: aspeed: rainier: Add leds that are off PCA9552
In-Reply-To: <20210329150020.13632-1-eajames@linux.ibm.com>
References: <20210329150020.13632-1-eajames@linux.ibm.com>
Message-ID: <20210329150020.13632-6-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Vishwanatha Subbanna <vishwa@linux.vnet.ibm.com>

These LEDs are on the fans and are connected via a
pca9551 i2c expander.

A comment from Milton on why to expose the pins as GPIOs rather
than configuring the pca955x driver to drive the LEDs directly:

The led system insistes on creating a compact map (no holes) (as
does the reset subsystem).
However, this means the relative led number for a pin changes
as the prior pins change from gpio to led configuration.
For example if pins 2 and 7 are leds, they become leds 0 and 1.
Changing pin 5 to also be an led means that pin 7 is now led 2
not led 1 on the led subsystem.
The workaround we have done for existing systems has been to use
gpio leds for pca family devices.

Signed-off-by: Vishwanatha Subbanna <vishwa@linux.vnet.ibm.com>
Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 41 ++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index aaedd817e1cb..016b0ead5404 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -263,6 +263,47 @@ fan5-presence {
 			linux,code = <11>;
 		};
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		fan0 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca0 0 GPIO_ACTIVE_LOW>;
+		};
+
+		fan1 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca0 1 GPIO_ACTIVE_LOW>;
+		};
+
+		fan2 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca0 2 GPIO_ACTIVE_LOW>;
+		};
+
+		fan3 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca0 3 GPIO_ACTIVE_LOW>;
+		};
+
+		fan4 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca0 4 GPIO_ACTIVE_LOW>;
+		};
+
+		fan5 {
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&pca0 5 GPIO_ACTIVE_LOW>;
+		};
+	};
+
 };
 
 &ehci1 {
-- 
2.27.0

