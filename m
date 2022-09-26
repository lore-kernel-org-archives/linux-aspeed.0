From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Mon, 26 Sep 2022 14:58:46 +0700
Subject: [PATCH v3 RESEND 0/2] Add device tree for Ampere's Mt. Mitchell BMC
Message-ID: <20220926075848.206918-1-quan@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The Mt. Mitchell BMC is an ASPEED AST2600-based BMC for the Mt. Mitchell
hardware reference platform with AmpereOne(TM) processor.

v3 :
  + Change adc-i2c node to generic adc node               [Krzysztof]
  + Remove unused status property in adc node             [Krzysztof]
  + Remove trailing blank line at the end of file         [Krzysztof]
  + Fix alphabetical order in dt-binding documentation    [Krzysztof]
  + Remove the wrong comment on vga_memory nodes             [Andrew]
  + Remove gpio-keys                                         [Andrew]
  + Remove the line-name for bmc-debug-mode, eth-phy-rst-n,
    eth-phy-int-n, bmc-salt12-s0-ssif-n, fpga-program-b,
    bmc-uart-cts1, bmc-spi-fm-boot-abr-pd, emmc-rst-n gpios  [Andrew]
  + Update line-name for hs-csout-prochot, s1-spi-auth-fail-n  [Quan]
  + Add line-name [s0|s1]-heartbeat                            [Quan]

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
 .../boot/dts/aspeed-bmc-ampere-mtmitchell.dts | 546 ++++++++++++++++++
 3 files changed, 548 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts

-- 
2.35.1

