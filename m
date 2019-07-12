From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 12 Jul 2019 13:02:12 +0930
Subject: [PATCH v2 0/2] mmc: Add support for the ASPEED SD controller
Message-ID: <20190712033214.24713-1-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

This is v2 of the ASPEED SD controller driver. v2 primarily addresses Rob's
comments on the bindings in v1. The v1 series can be found here:

https://lists.ozlabs.org/pipermail/linux-aspeed/2019-July/001988.html

Please review!

Andrew

Andrew Jeffery (2):
  dt-bindings: mmc: Document Aspeed SD controller
  mmc: Add support for the ASPEED SD controller

 .../devicetree/bindings/mmc/aspeed,sdhci.yaml |  90 +++++
 drivers/mmc/host/Kconfig                      |  12 +
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/sdhci-of-aspeed.c            | 326 ++++++++++++++++++
 4 files changed, 429 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
 create mode 100644 drivers/mmc/host/sdhci-of-aspeed.c

-- 
2.20.1

