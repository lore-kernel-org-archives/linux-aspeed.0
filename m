From: Oskar Senft <osk@google.com>
Date: Thu,  4 Nov 2021 23:29:10 -0400
Subject: [PATCH v3] ARM: dts: aspeed: tyan-s7106: Update nct7802 config
Message-ID: <20211105032910.446492-1-osk@google.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This change updates the configuration for the nct7802 hardware
monitor to correctly configure its temperature sensors.

Signed-off-by: Oskar Senft <osk@google.com>
---
Changes from PATCH v2:
- Add missing address-cells, size-cells configuration.
- Add missing new line between channel 0 and 1.

Changes from PATCH v1:
- Removed superfluous "status" from channels.
---
 arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts | 24 +++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts b/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts
index 68f332ee1886..60ac6d3f03b5 100644
--- a/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-tyan-s7106.dts
@@ -213,6 +213,30 @@ &i2c0 {
 	nct7802 at 28 {
 		compatible = "nuvoton,nct7802";
 		reg = <0x28>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		channel at 0 { /* LTD */
+			reg = <0>;
+		};
+
+		channel at 1 { /* RTD1 */
+			reg = <1>;
+			sensor-type = "temperature";
+			temperature-mode = "thermistor";
+		};
+
+		channel at 2 { /* RTD2 */
+			reg = <2>;
+			sensor-type = "temperature";
+			temperature-mode = "thermistor";
+		};
+
+		channel at 3 { /* RTD3 */
+			reg = <3>;
+			sensor-type = "temperature";
+		};
 	};
 
 	/* Also connected to:
-- 
2.34.0.rc0.344.g81b53c2807-goog

