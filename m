From: Stefan Schaeckeler <schaecsn@gmx.net>
Date: Sun, 16 Dec 2018 22:01:55 -0800
Subject: [PATCH 0/2] Add support for the Aspeed AST2500 SoC EDAC driver.
Message-ID: <1545026517-64069-1-git-send-email-schaecsn@gmx.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Stefan M Schaeckeler <schaecsn@gmx.net>

Add support for the Aspeed AST2500 SoC EDAC driver.

Note, I only have access to AST2500 hardware and documentation. The AST2500
documentation explicitly states that the sdram controller is not backward
compatible with AST2400 and hence this driver is not supporting it.

Best, Stefan


Stefan M Schaeckeler (2):
  EDAC: Add Aspeed AST2500 EDAC driver
  dt-bindings: edac: Aspeed AST2500

 .../bindings/edac/aspeed-sdram-edac.txt       |  34 ++
 MAINTAINERS                                   |   6 +
 arch/arm/boot/dts/aspeed-g5.dtsi              |   7 +
 drivers/edac/Kconfig                          |   7 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/aspeed_edac.c                    | 457 ++++++++++++++++++
 6 files changed, 512 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
 create mode 100644 drivers/edac/aspeed_edac.c

-- 
2.19.1

