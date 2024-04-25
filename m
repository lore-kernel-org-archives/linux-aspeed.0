From: Eddie James <eajames@linux.ibm.com>
Date: Thu, 25 Apr 2024 16:36:47 -0500
Subject: [PATCH v3 00/14] ARM: dts: aspeed: Add IBM P11 BMC Boards
Message-ID: <20240425213701.655540-1-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add the Blueridge and Fuji BMC systems. Document many missing FSI related
properties, and fix existing warnings.

Changes since v2:
 - Split up the DTS patches
 - Add documentation patches

Eddie James (14):
  dt-bindings: spi: Document the IBM Power SPI controller
  dt-bindings: fsi: fsi2spi: Document SPI controller child nodes
  dt-bindings: fsi: Document the FSI2PIB engine
  dt-bindings: fsi: p9-occ: Switch to yaml format
  dt-bindings: fsi: Document the IBM SBEFIFO engine
  dt-bindings: fsi: Document the FSI controller common properties
  dt-bindings: fsi: ibm,i2cr-fsi-master: Reference common FSI controller
  dt-bindings: fsi: ast2600-fsi-master: Switch to yaml format
  dt-bindings: fsi: Document the FSI Hub Controller
  dt-bindings: i2c: i2c-fsi: Switch to yaml format
  dt-bindings: arm: aspeed: add IBM P11 BMC boards
  ARM: dts: aspeed: Add IBM P11 FSI devices
  ARM: dts: aspeed: Add IBM P11 Blueridge BMC system
  ARM: dts: aspeed: Add IBM P11 Fuji BMC system

 .../bindings/arm/aspeed/aspeed.yaml           |    2 +
 .../fsi/aspeed,ast2600-fsi-master.yaml        |   72 +
 .../bindings/fsi/fsi-controller.yaml          |   65 +
 .../bindings/fsi/fsi-master-aspeed.txt        |   36 -
 .../devicetree/bindings/fsi/ibm,fsi2pib.yaml  |   38 +
 .../devicetree/bindings/fsi/ibm,fsi2spi.yaml  |   11 +
 .../bindings/fsi/ibm,hub-fsi-controller.yaml  |   44 +
 .../bindings/fsi/ibm,i2cr-fsi-master.yaml     |    5 +-
 .../devicetree/bindings/fsi/ibm,p9-occ.txt    |   16 -
 .../devicetree/bindings/fsi/ibm,p9-occ.yaml   |   41 +
 .../bindings/fsi/ibm,p9-sbefifo.yaml          |   50 +
 .../devicetree/bindings/i2c/i2c-fsi.txt       |   40 -
 .../devicetree/bindings/i2c/ibm,i2c-fsi.yaml  |   59 +
 .../devicetree/bindings/spi/ibm,p10-spi.yaml  |   56 +
 arch/arm/boot/dts/aspeed/Makefile             |    2 +
 .../dts/aspeed/aspeed-bmc-ibm-blueridge.dts   | 1711 +++++++
 .../boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts   | 3984 +++++++++++++++++
 .../arm/boot/dts/aspeed/ibm-power11-quad.dtsi | 1696 +++++++
 18 files changed, 7835 insertions(+), 93 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fsi/aspeed,ast2600-fsi-master.yaml
 create mode 100644 Documentation/devicetree/bindings/fsi/fsi-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,fsi2pib.yaml
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,hub-fsi-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,p9-occ.yaml
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,p9-sbefifo.yaml
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-fsi.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/ibm,i2c-fsi.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/ibm,p10-spi.yaml
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts
 create mode 100644 arch/arm/boot/dts/aspeed/ibm-power11-quad.dtsi

-- 
2.39.3

