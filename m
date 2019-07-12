From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 12 Jul 2019 15:47:21 +0930
Subject: [PATCH] dt-bindings: pinctrl: aspeed: Strip unnecessary quotes
Message-ID: <20190712061721.26645-1-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Rob pointed out that we didn't need the noise of the quotes in a
separate review[1], so strip them out for consistency and avoid setting
a bad example.

[1] https://lists.ozlabs.org/pipermail/linux-aspeed/2019-July/002009.html

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---

This patch applies to the tip of pinctrl/devel where the aspeed pinctrl binding
conversion patches have already landed.

 .../pinctrl/aspeed,ast2400-pinctrl.yaml       | 40 ++++++++---------
 .../pinctrl/aspeed,ast2500-pinctrl.yaml       | 45 +++++++++----------
 2 files changed, 38 insertions(+), 47 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
index 61a110a7db8a..faedfed0769c 100644
--- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
@@ -33,28 +33,24 @@ patternProperties:
         "^function|groups$":
           allOf:
             - $ref: "/schemas/types.yaml#/definitions/string"
-            - enum: [ "ACPI", "ADC0", "ADC1", "ADC10", "ADC11", "ADC12", "ADC13",
-              "ADC14", "ADC15", "ADC2", "ADC3", "ADC4", "ADC5", "ADC6", "ADC7",
-              "ADC8", "ADC9", "BMCINT", "DDCCLK", "DDCDAT", "EXTRST", "FLACK",
-              "FLBUSY", "FLWP", "GPID", "GPID0", "GPID2", "GPID4", "GPID6",
-              "GPIE0", "GPIE2", "GPIE4", "GPIE6", "I2C10", "I2C11", "I2C12",
-              "I2C13", "I2C14", "I2C3", "I2C4", "I2C5", "I2C6", "I2C7", "I2C8",
-              "I2C9", "LPCPD", "LPCPME", "LPCRST", "LPCSMI", "MAC1LINK",
-              "MAC2LINK", "MDIO1", "MDIO2", "NCTS1", "NCTS2", "NCTS3", "NCTS4",
-              "NDCD1", "NDCD2", "NDCD3", "NDCD4", "NDSR1", "NDSR2", "NDSR3",
-              "NDSR4", "NDTR1", "NDTR2", "NDTR3", "NDTR4", "NDTS4", "NRI1",
-              "NRI2", "NRI3", "NRI4", "NRTS1", "NRTS2", "NRTS3", "OSCCLK",
-              "PWM0", "PWM1", "PWM2", "PWM3", "PWM4", "PWM5", "PWM6", "PWM7",
-              "RGMII1", "RGMII2", "RMII1", "RMII2", "ROM16", "ROM8", "ROMCS1",
-              "ROMCS2", "ROMCS3", "ROMCS4", "RXD1", "RXD2", "RXD3", "RXD4",
-              "SALT1", "SALT2", "SALT3", "SALT4", "SD1", "SD2", "SGPMCK",
-              "SGPMI", "SGPMLD", "SGPMO", "SGPSCK", "SGPSI0", "SGPSI1", "SGPSLD",
-              "SIOONCTRL", "SIOPBI", "SIOPBO", "SIOPWREQ", "SIOPWRGD", "SIOS3",
-              "SIOS5", "SIOSCI", "SPI1", "SPI1DEBUG", "SPI1PASSTHRU", "SPICS1",
-              "TIMER3", "TIMER4", "TIMER5", "TIMER6", "TIMER7", "TIMER8", "TXD1",
-              "TXD2", "TXD3", "TXD4", "UART6", "USB11D1", "USB11H2", "USB2D1",
-              "USB2H1", "USBCKI", "VGABIOS_ROM", "VGAHS", "VGAVS", "VPI18",
-              "VPI24", "VPI30", "VPO12", "VPO24", "WDTRST1", "WDTRST2" ]
+            - enum: [ ACPI, ADC0, ADC1, ADC10, ADC11, ADC12, ADC13, ADC14,
+              ADC15, ADC2, ADC3, ADC4, ADC5, ADC6, ADC7, ADC8, ADC9, BMCINT,
+              DDCCLK, DDCDAT, EXTRST, FLACK, FLBUSY, FLWP, GPID, GPID0, GPID2,
+              GPID4, GPID6, GPIE0, GPIE2, GPIE4, GPIE6, I2C10, I2C11, I2C12,
+              I2C13, I2C14, I2C3, I2C4, I2C5, I2C6, I2C7, I2C8, I2C9, LPCPD,
+              LPCPME, LPCRST, LPCSMI, MAC1LINK, MAC2LINK, MDIO1, MDIO2, NCTS1,
+              NCTS2, NCTS3, NCTS4, NDCD1, NDCD2, NDCD3, NDCD4, NDSR1, NDSR2,
+              NDSR3, NDSR4, NDTR1, NDTR2, NDTR3, NDTR4, NDTS4, NRI1, NRI2,
+              NRI3, NRI4, NRTS1, NRTS2, NRTS3, OSCCLK, PWM0, PWM1, PWM2, PWM3,
+              PWM4, PWM5, PWM6, PWM7, RGMII1, RGMII2, RMII1, RMII2, ROM16,
+              ROM8, ROMCS1, ROMCS2, ROMCS3, ROMCS4, RXD1, RXD2, RXD3, RXD4,
+              SALT1, SALT2, SALT3, SALT4, SD1, SD2, SGPMCK, SGPMI, SGPMLD,
+              SGPMO, SGPSCK, SGPSI0, SGPSI1, SGPSLD, SIOONCTRL, SIOPBI, SIOPBO,
+              SIOPWREQ, SIOPWRGD, SIOS3, SIOS5, SIOSCI, SPI1, SPI1DEBUG,
+              SPI1PASSTHRU, SPICS1, TIMER3, TIMER4, TIMER5, TIMER6, TIMER7,
+              TIMER8, TXD1, TXD2, TXD3, TXD4, UART6, USB11D1, USB11H2, USB2D1,
+              USB2H1, USBCKI, VGABIOS_ROM, VGAHS, VGAVS, VPI18, VPI24, VPI30,
+              VPO12, VPO24, WDTRST1, WDTRST2 ]
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
index cf561bd55128..d1984f619b74 100644
--- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
@@ -42,31 +42,26 @@ patternProperties:
         "^function|groups$":
           allOf:
             - $ref: "/schemas/types.yaml#/definitions/string"
-            - enum: [ "ACPI", "ADC0", "ADC1", "ADC10", "ADC11", "ADC12", "ADC13",
-              "ADC14", "ADC15", "ADC2", "ADC3", "ADC4", "ADC5", "ADC6", "ADC7",
-              "ADC8", "ADC9", "BMCINT", "DDCCLK", "DDCDAT", "ESPI", "FWSPICS1",
-              "FWSPICS2", "GPID0", "GPID2", "GPID4", "GPID6", "GPIE0", "GPIE2",
-              "GPIE4", "GPIE6", "I2C10", "I2C11", "I2C12", "I2C13", "I2C14",
-              "I2C3", "I2C4", "I2C5", "I2C6", "I2C7", "I2C8", "I2C9", "LAD0",
-              "LAD1", "LAD2", "LAD3", "LCLK", "LFRAME", "LPCHC", "LPCPD",
-              "LPCPLUS", "LPCPME", "LPCRST", "LPCSMI", "LSIRQ", "MAC1LINK",
-              "MAC2LINK", "MDIO1", "MDIO2", "NCTS1", "NCTS2", "NCTS3", "NCTS4",
-              "NDCD1", "NDCD2", "NDCD3", "NDCD4", "NDSR1", "NDSR2", "NDSR3",
-              "NDSR4", "NDTR1", "NDTR2", "NDTR3", "NDTR4", "NRI1", "NRI2",
-              "NRI3", "NRI4", "NRTS1", "NRTS2", "NRTS3", "NRTS4", "OSCCLK",
-              "PEWAKE", "PNOR", "PWM0", "PWM1", "PWM2", "PWM3", "PWM4", "PWM5",
-              "PWM6", "PWM7", "RGMII1", "RGMII2", "RMII1", "RMII2", "RXD1",
-              "RXD2", "RXD3", "RXD4", "SALT1", "SALT10", "SALT11", "SALT12",
-              "SALT13", "SALT14", "SALT2", "SALT3", "SALT4", "SALT5", "SALT6",
-              "SALT7", "SALT8", "SALT9", "SCL1", "SCL2", "SD1", "SD2", "SDA1",
-              "SDA2", "SGPS1", "SGPS2", "SIOONCTRL", "SIOPBI", "SIOPBO",
-              "SIOPWREQ", "SIOPWRGD", "SIOS3", "SIOS5", "SIOSCI", "SPI1",
-              "SPI1CS1", "SPI1DEBUG", "SPI1PASSTHRU", "SPI2CK", "SPI2CS0",
-              "SPI2CS1", "SPI2MISO", "SPI2MOSI", "TIMER3", "TIMER4", "TIMER5",
-              "TIMER6", "TIMER7", "TIMER8", "TXD1", "TXD2", "TXD3", "TXD4",
-              "UART6", "USB11BHID", "USB2AD", "USB2AH", "USB2BD", "USB2BH",
-              "USBCKI", "VGABIOSROM", "VGAHS", "VGAVS", "VPI24", "VPO",
-              "WDTRST1", "WDTRST2", ]
+            - enum: [ ACPI, ADC0, ADC1, ADC10, ADC11, ADC12, ADC13, ADC14,
+              ADC15, ADC2, ADC3, ADC4, ADC5, ADC6, ADC7, ADC8, ADC9, BMCINT,
+              DDCCLK, DDCDAT, ESPI, FWSPICS1, FWSPICS2, GPID0, GPID2, GPID4,
+              GPID6, GPIE0, GPIE2, GPIE4, GPIE6, I2C10, I2C11, I2C12, I2C13,
+              I2C14, I2C3, I2C4, I2C5, I2C6, I2C7, I2C8, I2C9, LAD0, LAD1,
+              LAD2, LAD3, LCLK, LFRAME, LPCHC, LPCPD, LPCPLUS, LPCPME, LPCRST,
+              LPCSMI, LSIRQ, MAC1LINK, MAC2LINK, MDIO1, MDIO2, NCTS1, NCTS2,
+              NCTS3, NCTS4, NDCD1, NDCD2, NDCD3, NDCD4, NDSR1, NDSR2, NDSR3,
+              NDSR4, NDTR1, NDTR2, NDTR3, NDTR4, NRI1, NRI2, NRI3, NRI4, NRTS1,
+              NRTS2, NRTS3, NRTS4, OSCCLK, PEWAKE, PNOR, PWM0, PWM1, PWM2,
+              PWM3, PWM4, PWM5, PWM6, PWM7, RGMII1, RGMII2, RMII1, RMII2, RXD1,
+              RXD2, RXD3, RXD4, SALT1, SALT10, SALT11, SALT12, SALT13, SALT14,
+              SALT2, SALT3, SALT4, SALT5, SALT6, SALT7, SALT8, SALT9, SCL1,
+              SCL2, SD1, SD2, SDA1, SDA2, SGPS1, SGPS2, SIOONCTRL, SIOPBI,
+              SIOPBO, SIOPWREQ, SIOPWRGD, SIOS3, SIOS5, SIOSCI, SPI1, SPI1CS1,
+              SPI1DEBUG, SPI1PASSTHRU, SPI2CK, SPI2CS0, SPI2CS1, SPI2MISO,
+              SPI2MOSI, TIMER3, TIMER4, TIMER5, TIMER6, TIMER7, TIMER8, TXD1,
+              TXD2, TXD3, TXD4, UART6, USB11BHID, USB2AD, USB2AH, USB2BD,
+              USB2BH, USBCKI, VGABIOSROM, VGAHS, VGAVS, VPI24, VPO, WDTRST1,
+              WDTRST2, ]
 
 required:
   - compatible
-- 
2.20.1

