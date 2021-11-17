From: Joel Stanley <joel@jms.id.au>
Date: Wed, 17 Nov 2021 11:51:03 +0800
Subject: [PATCH 0/3] ARM: aspeed: Secure Boot Controller support
Message-ID: <20211117035106.321454-1-joel@jms.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This adds the reporting of the secure boot state to the ASPEED socinfo
driver.

Joel Stanley (3):
  dt-bindings: aspeed: Add Secure Boot Controller bindings
  ARM: dts: aspeed: Add secure boot controller node
  ARM: aspeed: Add secure boot controller support

 .../bindings/arm/aspeed/aspeed,sbc.yaml       | 37 ++++++++++
 arch/arm/boot/dts/aspeed-g6.dtsi              |  5 ++
 drivers/soc/aspeed/aspeed-socinfo.c           | 73 +++++++++++++++++++
 3 files changed, 115 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/aspeed/aspeed,sbc.yaml

-- 
2.33.0

