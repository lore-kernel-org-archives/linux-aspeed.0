From: Eddie James <eajames@linux.ibm.com>
Date: Tue, 21 Mar 2023 10:16:38 -0500
Subject: [PATCH v2 0/4] eeprom: ee1004: Enable devices on multiple busses
Message-ID: <20230321151642.461618-1-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The driver previously prevented probing devices on more than one
bus due to locking constraints with the special page addresses. This
constraint can be removed by allocating a reference-counted bus
structure containing the lock, rather than using global variables.
In addition, add devicetree bindings for the EE1004 driver for the
AT30TSE device and add the devices to the Bonnell BMC system.

Changes since v1:
 - Add the devicetree changes

Eddie James (4):
  eeprom: ee1004: Enable devices on multiple busses
  doc: Add Atmel AT30TSE serial eeprom
  eeprom: ee1004: Add devicetree binding
  ARM: dts: aspeed: bonnell: Add DIMM SPD

 .../devicetree/bindings/trivial-devices.yaml  |   2 +
 arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts  |  20 ++
 drivers/misc/eeprom/ee1004.c                  | 182 +++++++++++-------
 3 files changed, 135 insertions(+), 69 deletions(-)

-- 
2.31.1

