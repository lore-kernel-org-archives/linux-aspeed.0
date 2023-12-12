From: Ninad Palsule <ninad@linux.ibm.com>
Date: Tue, 12 Dec 2023 10:39:56 -0600
Subject: [PATCH v1 0/8] Add device tree for IBM system1 BMC
Message-ID: <20231212164004.1683589-1-ninad@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patchset adds device tree for IBM system1 bmc board.

Change log:
v1:
 - Added device binding for IBM system1-bmc
 - Added device binding for TIS I2C devices
 - Added device tree for IBM system1 BMC board
 - Added i2c and muxes
 - Added voltage regulators
 - Added GPIO, Fan ctrl, Led
 - Added more compatible strings for tpm_tis_i2c
 - Added power supplies, sensors, EEPROMS, TPM and more

Andrew Geissler (1):
  ARM: dts: aspeed: System1: IBM system1 BMC board

Joel Stanley (1):
  tpm: tis-i2c: Add more compatible strings

Johannes Holland (1):
  dt-bindings: tpm: Add schema for TIS I2C devices

Ninad Palsule (5):
  dt-bindings: arm: aspeed: add IBM system1-bmc
  ARM: dts: aspeed: System1: Add i2c and muxes
  ARM: dts: aspeed: System1: Voltage regulators
  ARM: dts: aspeed: System1: GPIO, Fan ctrl, Led
  ARM: dts: aspeed: System1: PS, sensor and more

 .../bindings/arm/aspeed/aspeed.yaml           |    1 +
 .../bindings/security/tpm/tpm-tis-i2c.yaml    |   50 +
 .../devicetree/bindings/trivial-devices.yaml  |    2 +
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 1644 +++++++++++++++++
 drivers/char/tpm/tpm_tis_i2c.c                |    2 +
 6 files changed, 1700 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts

-- 
2.39.2

