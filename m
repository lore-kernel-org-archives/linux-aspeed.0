From: yangchen.openbmc@gmail.com <yangchen.openbmc@gmail.com>
Date: Tue, 12 Sep 2023 22:05:30 +0800
Subject: [PATCH 0/2] Add CMC of Facebook Minerva platform
Message-ID: <20230912140532.3797736-1-yangchen.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Yang Chen <yangchen.openbmc@gmail.com>

Add linux device tree entry related to Minerva Chassis Management Controller
(CMC) specific devices connected to the Aspeed SoC (AST2600).

Yang Chen (2):
  dt-bindings: arm: aspeed: document board compatibles
  ARM: dts: aspeed: Minerva: Add Facebook Minerva CMC board

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../aspeed-bmc-facebook-minerva-cmc.dts       | 265 ++++++++++++++++++
 3 files changed, 267 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva-cmc.dts

-- 
2.34.1

