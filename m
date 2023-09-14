From: Yang Chen <yangchen.openbmc@gmail.com>
Date: Thu, 14 Sep 2023 20:56:46 +0800
Subject: [PATCH v2 0/2] Add CMC of Facebook Minerva platform
Message-ID: <20230914125648.3966519-1-yangchen.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add linux device tree entry related to the Minerva Chassis Management
Controller (CMC) specific devices connected to the Aspeed SoC (AST2600).

Changes from v1:
- Change adc0 and adc1 "ref_voltage" property to
  "aspeed,int-vref-microvolt" which is defined in the binding file, and
choose the ADC internal reference voltage to 2500000 microvolts.

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

