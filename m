From: Zev Weiss <zev@bewilderbeest.net>
Date: Tue, 14 Nov 2023 03:28:20 -0800
Subject: [PATCH 0/2] ARM: dts: aspeed: Add ASRock SPC621D8HM3 BMC
Message-ID: <20231114112819.28572-4-zev@bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

These patches add a device-tree (and a tiny bindings update) for the
Aspeed BMC on the ASRock SPC621D8HM3, so that it can be added as a
supported OpenBMC platform.

Thanks,
Zev


Zev Weiss (2):
  dt-bindings: arm: aspeed: document ASRock SPC621D8HM3
  ARM: dts: aspeed: Add ASRock SPC621D8HM3 BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../aspeed/aspeed-bmc-asrock-spc621d8hm3.dts  | 316 ++++++++++++++++++
 3 files changed, 318 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-spc621d8hm3.dts

-- 
2.42.0

