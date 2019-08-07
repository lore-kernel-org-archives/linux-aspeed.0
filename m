From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed,  7 Aug 2019 10:06:27 +0930
Subject: [PATCH v5 0/2] mmc: Add support for the ASPEED SD controller
Message-ID: <20190807003629.2974-1-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

v5 of the ASPEED SDHCI patches fixes an error-path cleanup issue pointed out by
Adrian.

v4 can be found here:

http://patchwork.ozlabs.org/cover/1141949/

Please review!

Andrew

Andrew Jeffery (2):
  dt-bindings: mmc: Document Aspeed SD controller
  mmc: Add support for the ASPEED SD controller

 .../devicetree/bindings/mmc/aspeed,sdhci.yaml | 105 ++++++
 drivers/mmc/host/Kconfig                      |  12 +
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/sdhci-of-aspeed.c            | 332 ++++++++++++++++++
 4 files changed, 450 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
 create mode 100644 drivers/mmc/host/sdhci-of-aspeed.c

-- 
2.20.1

