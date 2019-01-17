From: Stefan Schaeckeler <schaecsn@gmx.net>
Date: Thu, 17 Jan 2019 08:38:15 -0800
Subject: [PATCH v2 0/2] Add support for the Aspeed AST2500 SoC EDAC driver
Message-ID: <1547743097-5236-1-git-send-email-schaecsn@gmx.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Stefan M Schaeckeler <sschaeck@cisco.com>

Add support for the Aspeed AST2500 SoC EDAC driver.

Changes since v1:
- Addressed all cosmetic issues
- Fixed (un-)recoverable address calculation in reg58 and reg5c
- Removed status field from the example device tree binding
- Added little more text to Kconfig


Stefan M Schaeckeler (2):
  EDAC: Add Aspeed AST2500 EDAC driver
  dt-bindings: edac: Aspeed AST2500

 .../bindings/edac/aspeed-sdram-edac.txt       |  25 ++
 MAINTAINERS                                   |   6 +
 arch/arm/boot/dts/aspeed-g5.dtsi              |   7 +
 drivers/edac/Kconfig                          |   8 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/aspeed_edac.c                    | 421 ++++++++++++++++++
 6 files changed, 468 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
 create mode 100644 drivers/edac/aspeed_edac.c

-- 
2.19.1

