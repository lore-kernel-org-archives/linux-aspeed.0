From: Ninad Palsule <ninad@linux.ibm.com>
Date: Mon,  8 Jan 2024 14:41:11 -0600
Subject: [PATCH v2 0/3] Add device tree for IBM system1 BMC
Message-ID: <20240108204114.1041390-1-ninad@linux.ibm.com>
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

v2:
 - Incorporated review comments from Conor Dooley, Jarkko Sakkinen,
   Guenter Roeck, Rob Herring, Krzysztof Kozlowski
 - Merge all patches into single patch.
 - Split the trivial device patch.
 - Cleanup commit messages.
 - Fixed bootargs string.
 - Fixed node names.
 - Dropped tpm schema patch as it is covered by Lukas's patch.
 - Dropped "tpm: tis-i2c: Add more compatible strings" patch and
   send it as a separate patch.

Andrew Geissler (1):
  ARM: dts: aspeed: System1: IBM system1 BMC board

Ninad Palsule (2):
  dt-bindings: arm: aspeed: add IBM system1-bmc
  dt-bindings: Add DPS310 as trivial device

 .../bindings/arm/aspeed/aspeed.yaml           |    1 +
 .../devicetree/bindings/trivial-devices.yaml  |    2 +
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 1623 +++++++++++++++++
 4 files changed, 1627 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts

-- 
2.39.2

