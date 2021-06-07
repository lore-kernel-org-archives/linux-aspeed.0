From: Joel Stanley <joel@jms.id.au>
Date: Mon,  7 Jun 2021 12:42:54 +0930
Subject: [PATCH 1/6] ARM: dts: aspeed: everest: Add system level indicator leds
In-Reply-To: <20210607031259.475020-1-joel@jms.id.au>
References: <20210607031259.475020-1-joel@jms.id.au>
Message-ID: <20210607031259.475020-2-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Vishwanatha Subbanna <vishwa@linux.vnet.ibm.com>

These are the system level indicator leds that are driven by
PCA9551 connected to the Operator Panel.

Signed-off-by: Vishwanatha Subbanna <vishwa@linux.vnet.ibm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts | 42 ++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
index 2ddd10e93a80..6a17b75b5d5b 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts
@@ -890,6 +890,48 @@ eeprom at 50 {
 				compatible = "atmel,24c32";
 				reg = <0x50>;
 			};
+
+			pca_oppanel: pca9551 at 60 {
+				compatible = "nxp,pca9551";
+				reg = <0x60>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+
+				led at 0 {
+					label = "front-sys-id0";
+					reg = <0>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 1 {
+					label = "front-check-log0";
+					reg = <1>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 2 {
+					label = "front-enc-fault1";
+					reg = <2>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+
+				led at 3 {
+					label = "front-sys-pwron0";
+					reg = <3>;
+					retain-state-shutdown;
+					default-state = "keep";
+					type = <PCA955X_TYPE_LED>;
+				};
+			};
 		};
 
 		i2c14mux0chn3: i2c at 3 {
-- 
2.30.2

