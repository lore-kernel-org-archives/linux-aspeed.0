From: Eddie James <eajames@linux.ibm.com>
Date: Mon, 29 Mar 2021 10:00:11 -0500
Subject: [PATCH 13/22] ARM: dts: Aspeed: Everest: Add max31785 fan controller
 device
In-Reply-To: <20210329150020.13632-1-eajames@linux.ibm.com>
References: <20210329150020.13632-1-eajames@linux.ibm.com>
Message-ID: <20210329150020.13632-14-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Matthew Barth <msbarth@us.ibm.com>

Add the max31785 configuration at address 0x52 on i2c14 behind mux0
channel 3.

Signed-off-by: Matthew Barth <msbarth@us.ibm.com>
Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts | 71 ++++++++++++++++++--
 1 file changed, 67 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
index ab7be4d511a5..cc45608b0cbc 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
@@ -59,10 +59,11 @@ aliases {
 		i2c27 = &i2c14mux0chn0;
 		i2c28 = &i2c14mux0chn1;
 		i2c29 = &i2c14mux0chn2;
-		i2c30 = &i2c14mux1chn0;
-		i2c31 = &i2c14mux1chn1;
-		i2c32 = &i2c14mux1chn2;
-		i2c33 = &i2c14mux1chn3;
+		i2c30 = &i2c14mux0chn3;
+		i2c31 = &i2c14mux1chn0;
+		i2c32 = &i2c14mux1chn1;
+		i2c33 = &i2c14mux1chn2;
+		i2c34 = &i2c14mux1chn3;
 
 		serial4 = &uart5;
 
@@ -457,6 +458,68 @@ eeprom at 50 {
 				reg = <0x50>;
 			};
 		};
+
+		i2c14mux0chn3: i2c at 3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+			max31785 at 52 {
+				compatible = "maxim,max31785a";
+				reg = <0x52>;
+
+				fan at 0 {
+					compatible = "pmbus-fan";
+					reg = <0>;
+					tach-pulses = <2>;
+					maxim,fan-rotor-input = "tach";
+					maxim,fan-pwm-freq = <25000>;
+					maxim,fan-dual-tach;
+					maxim,fan-no-watchdog;
+					maxim,fan-no-fault-ramp;
+					maxim,fan-ramp = <2>;
+					maxim,fan-fault-pin-mon;
+				};
+
+				fan at 1 {
+					compatible = "pmbus-fan";
+					reg = <1>;
+					tach-pulses = <2>;
+					maxim,fan-rotor-input = "tach";
+					maxim,fan-pwm-freq = <25000>;
+					maxim,fan-dual-tach;
+					maxim,fan-no-watchdog;
+					maxim,fan-no-fault-ramp;
+					maxim,fan-ramp = <2>;
+					maxim,fan-fault-pin-mon;
+				};
+
+				fan at 2 {
+					compatible = "pmbus-fan";
+					reg = <2>;
+					tach-pulses = <2>;
+					maxim,fan-rotor-input = "tach";
+					maxim,fan-pwm-freq = <25000>;
+					maxim,fan-dual-tach;
+					maxim,fan-no-watchdog;
+					maxim,fan-no-fault-ramp;
+					maxim,fan-ramp = <2>;
+					maxim,fan-fault-pin-mon;
+				};
+
+				fan at 3 {
+					compatible = "pmbus-fan";
+					reg = <3>;
+					tach-pulses = <2>;
+					maxim,fan-rotor-input = "tach";
+					maxim,fan-pwm-freq = <25000>;
+					maxim,fan-dual-tach;
+					maxim,fan-no-watchdog;
+					maxim,fan-no-fault-ramp;
+					maxim,fan-ramp = <2>;
+					maxim,fan-fault-pin-mon;
+				};
+			};
+		};
 	};
 
 	i2c-switch at 71 {
-- 
2.27.0

