From: Chanh Nguyen <chanh@os.amperecomputing.com>
Date: Mon, 21 Oct 2024 08:37:00 +0000
Subject: [PATCH v2 0/2] Add device tree for Ampere's Mt. Jefferson BMC
Message-ID: <20241021083702.9734-1-chanh@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The Mt. Jefferson BMC is an ASPEED AST2600-based BMC for the Mt. Jefferson
hardware reference platform with AmpereOne(TM)M processor.

These patches add a device-tree and binding for the Ampere's Mt. Jefferson
BMC board.

Changes in v2:
 - Document Mt. Jefferson board compatible                      [Krzysztof]
 - Remove the PSU node with pmbus compatible                       [Andrew]
 - Remove clock-names property in mac3 node                        [Andrew]

Chanh Nguyen (2):
  dt-bindings: arm: aspeed: add Mt. Jefferson board
  ARM: dts: aspeed: Add device tree for Ampere's Mt. Jefferson BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../aspeed/aspeed-bmc-ampere-mtjefferson.dts  | 622 ++++++++++++++++++
 3 files changed, 624 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dts

-- 
2.43.0

