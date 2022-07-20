From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Wed, 20 Jul 2022 15:52:28 +0700
Subject: [PATCH v2 0/2] Add device tree for Ampere's Mt. Mitchell BMC
Message-ID: <20220720085230.3801945-1-quan@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The Mt. Mitchell BMC is an ASPEED AST2600-based BMC for the Mt. Mitchell
hardware reference platform with AmpereOne(TM) processor.

v2 :
  + Add Ampere Mt. Mitchell BMC compatible                [Krzysztof]
  + Remove bootargs                                       [Krzysztof]
  + Fix gpio-keys nodes name to conform with device tree binding
  documents                                               [Krzysztof]
  + Fix some nodes to use generic name                    [Krzysztof]
  + Remove unnecessary blank line                         [Krzysztof]
  + Fix typo "LTC" to "LLC" in license info and corrected license
  info to GPL-2.0-only

Quan Nguyen (2):
  dt-bindings: arm: aspeed: document Ampere Mt.Mitchell BMC compatibles
  ARM: dts: aspeed: Add device tree for Ampere's Mt. Mitchell BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/aspeed-bmc-ampere-mtmitchell.dts | 577 ++++++++++++++++++
 3 files changed, 579 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts

-- 
2.35.1

