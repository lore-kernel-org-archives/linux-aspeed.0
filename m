From: Eddie James <eajames@linux.ibm.com>
Date: Wed, 22 May 2024 14:25:04 -0500
Subject: [PATCH v6 00/20] ARM: dts: aspeed: Add IBM P11 BMC systems
Message-ID: <20240522192524.3286237-1-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add the Blueridge and Fuji BMC systems. Document many missing FSI related
properties, and fix existing warnings. Make some minor fixes in OCC and
SCOM drivers for the updated bindings.

Changes since v5:
 - Switch from clock-frequency to bus-frequency for common FSI controller
   properties
 - Add reg properties for AST2700 FSI controller
 - Fix patternProperties for i2c bus nodes under FSI-based I2C controller
 - Add bus-frequency for P11 FSI device tree node
 - Change model name from Blueridge to Blueridge 2U
 - Add missing reset gpio to led controller on Fuji
 - Add Huygens (Rainier with modified FSI wiring)

Eddie James (20):
  spi: dt-bindings: Document the IBM FSI-attached SPI controller
  dt-bindings: fsi: fsi2spi: Document SPI controller child nodes
  dt-bindings: fsi: Document the IBM SCOM engine
  dt-bindings: fsi: p9-occ: Convert to json-schema
  dt-bindings: fsi: Document the IBM SBEFIFO engine
  dt-bindings: fsi: Document the FSI controller common properties
  dt-bindings: fsi: ibm,i2cr-fsi-master: Reference common FSI controller
  dt-bindings: fsi: ast2600-fsi-master: Convert to json-schema
  dt-bindings: fsi: Document the AST2700 FSI controller
  dt-bindings: fsi: Document the FSI Hub Controller
  dt-bindings: i2c: i2c-fsi: Convert to json-schema
  dt-bindings: arm: aspeed: add IBM P11 BMC boards
  ARM: dts: aspeed: Add IBM P11 FSI devices
  ARM: dts: aspeed: Add IBM P11 Blueridge BMC system
  ARM: dts: aspeed: Add IBM P11 Blueridge 4U BMC system
  ARM: dts: aspeed: Add IBM P11 Fuji BMC system
  ARM: dts: aspeed: Add IBM Huygens BMC system
  fsi: occ: Get device number from FSI minor number API
  fsi: occ: Find next available child rather than node name match
  fsi: scom: Update compatible string to match documentation

 .../bindings/arm/aspeed/aspeed.yaml           |    2 +
 .../fsi/aspeed,ast2600-fsi-master.yaml        |  121 +
 .../bindings/fsi/fsi-controller.yaml          |   66 +
 .../bindings/fsi/fsi-master-aspeed.txt        |   36 -
 .../devicetree/bindings/fsi/ibm,fsi2spi.yaml  |   36 +-
 .../bindings/fsi/ibm,i2cr-fsi-master.yaml     |    5 +-
 .../bindings/fsi/ibm,p9-fsi-controller.yaml   |   45 +
 .../devicetree/bindings/fsi/ibm,p9-occ.txt    |   16 -
 .../devicetree/bindings/fsi/ibm,p9-occ.yaml   |   40 +
 .../bindings/fsi/ibm,p9-sbefifo.yaml          |   46 +
 .../devicetree/bindings/fsi/ibm,p9-scom.yaml  |   37 +
 .../devicetree/bindings/i2c/i2c-fsi.txt       |   40 -
 .../devicetree/bindings/i2c/ibm,i2c-fsi.yaml  |   76 +
 .../devicetree/bindings/spi/ibm,spi-fsi.yaml  |   55 +
 MAINTAINERS                                   |    2 +-
 arch/arm/boot/dts/aspeed/Makefile             |    3 +
 .../aspeed/aspeed-bmc-ibm-blueridge-4u.dts    |   21 +
 .../dts/aspeed/aspeed-bmc-ibm-blueridge.dts   | 1691 +++++++
 .../boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts   | 3881 +++++++++++++++++
 .../dts/aspeed/aspeed-bmc-ibm-huygens.dts     |   23 +
 .../arm/boot/dts/aspeed/ibm-power11-quad.dtsi | 1539 +++++++
 drivers/fsi/fsi-occ.c                         |   49 +-
 drivers/fsi/fsi-scom.c                        |    1 +
 23 files changed, 7694 insertions(+), 137 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fsi/aspeed,ast2600-fsi-master.yaml
 create mode 100644 Documentation/devicetree/bindings/fsi/fsi-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,p9-fsi-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,p9-occ.yaml
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,p9-sbefifo.yaml
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,p9-scom.yaml
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-fsi.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/ibm,i2c-fsi.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/ibm,spi-fsi.yaml
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge-4u.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-huygens.dts
 create mode 100644 arch/arm/boot/dts/aspeed/ibm-power11-quad.dtsi

-- 
2.39.3

