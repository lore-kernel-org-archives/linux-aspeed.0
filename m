From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 16 Sep 2020 17:57:00 +0200
Subject: [PATCH v3 00/15] ARM: dts: / gpio: Add dtschema for NXP PCA953x and
 correct dts
Message-ID: <20200916155715.21009-1-krzk@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


Hi,

Changes since v2:
1. Add Rob's review,
2. Minor fixup in patch #1,
3. Add acks to 11 and 13.

Changes since v1:
1. Patch 1: Use additionalProperties, Add wakeup-source, Add hogs, Extend example with hogs.
2. New patches: 3, 4, 5, 6, 7, 9, 10, 12, 14 and 15.

The patches could be picked up independently if dtschema makes sense.
The fixes for pins make sense anyway, regardless of dtschema.

Best regards,
Krzysztof


Krzysztof Kozlowski (15):
  dt-bindings: gpio: convert bindings for NXP PCA953x family to dtschema
  dt-bindings: gpio: convert bindings for Maxim MAX732x family to
    dtschema
  arm64: dts: mediatek: fix tca6416 reset GPIOs in pumpkin
  arm64: dts: mediatek: align GPIO hog names with dtschema
  arm64: dts: renesas: align GPIO hog names with dtschema
  arm64: dts: ti: align GPIO hog names with dtschema
  arm64: dts: xilinx: align GPIO hog names with dtschema
  ARM: dts: am335x: lxm: fix PCA9539 GPIO expander properties
  ARM: dts: am335x: t335: align GPIO hog names with dtschema
  ARM: dts: am3874: iceboard: fix GPIO expander reset GPIOs
  ARM: dts: aspeed: fix PCA95xx GPIO expander properties on Portwell
  ARM: dts: aspeed: align GPIO hog names with dtschema
  ARM: dts: dove: fix PCA95xx GPIO expander properties on A510
  ARM: dts: armada: align GPIO hog names with dtschema
  ARM: dts: imx6q: align GPIO hog names with dtschema

 .../devicetree/bindings/gpio/gpio-max732x.txt |  58 -----
 .../devicetree/bindings/gpio/gpio-pca953x.txt |  90 -------
 .../bindings/gpio/gpio-pca95xx.yaml           | 232 ++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |   4 -
 arch/arm/boot/dts/am335x-lxm.dts              |   4 +
 arch/arm/boot/dts/am335x-sbc-t335.dts         |   4 +-
 arch/arm/boot/dts/am3874-iceboard.dts         |   8 +-
 arch/arm/boot/dts/armada-388-clearfog.dts     |   4 +-
 arch/arm/boot/dts/armada-388-clearfog.dtsi    |  10 +-
 arch/arm/boot/dts/armada-388-helios4.dts      |   6 +-
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts  |   2 +-
 arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts   |  16 +-
 .../boot/dts/aspeed-bmc-portwell-neptune.dts  |   2 +
 arch/arm/boot/dts/dove-sbc-a510.dts           |   1 +
 arch/arm/boot/dts/imx6q-b450v3.dts            |  14 +-
 arch/arm/boot/dts/imx6q-b650v3.dts            |  12 +-
 arch/arm/boot/dts/imx6q-b850v3.dts            |   4 +-
 arch/arm/boot/dts/imx6q-bx50v3.dtsi           |  12 +-
 .../boot/dts/mediatek/pumpkin-common.dtsi     |  28 +--
 .../boot/dts/renesas/r8a77951-salvator-xs.dts |   2 +-
 .../boot/dts/renesas/r8a77965-salvator-xs.dts |   2 +-
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi      |  14 +-
 .../dts/ti/k3-j721e-common-proc-board.dts     |   4 +-
 .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    |   8 +-
 24 files changed, 314 insertions(+), 227 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-max732x.txt
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml

-- 
2.17.1

