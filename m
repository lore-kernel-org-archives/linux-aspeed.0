From: Zev Weiss <zev@bewilderbeest.net>
Date: Mon, 20 Nov 2023 04:19:55 -0800
Subject: [PATCH v2 0/2] ARM: dts: aspeed: Add ASRock SPC621D8HM3 BMC
Message-ID: <20231120121954.19926-4-zev@bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

These patches add a device-tree (and a tiny bindings update) for the
Aspeed BMC on the ASRock SPC621D8HM3, so that it can be added as a
supported OpenBMC platform.

Changes since v1 [0]:
 - Removed bootargs [Krzysztof]
 - Renamed LED nodes [Krzysztof]
 - Added function & color properties to LED nodes
 - Added #address-cells and #size-cells to FRU eeprom node

[0] https://lore.kernel.org/lkml/20231114112819.28572-4-zev at bewilderbeest.net/

Thanks,
Zev

Zev Weiss (2):
  dt-bindings: arm: aspeed: document ASRock SPC621D8HM3
  ARM: dts: aspeed: Add ASRock SPC621D8HM3 BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../aspeed/aspeed-bmc-asrock-spc621d8hm3.dts  | 324 ++++++++++++++++++
 3 files changed, 326 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-spc621d8hm3.dts


base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
-- 
2.42.0

