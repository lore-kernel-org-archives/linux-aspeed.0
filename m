From: Zev Weiss <zev@bewilderbeest.net>
Date: Mon,  7 Nov 2022 16:15:49 -0800
Subject: [PATCH v2 0/2] ARM: dts: aspeed: Add Delta AHE-50DC BMC
Message-ID: <20221108001551.18175-1-zev@bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

This series adds a device-tree for the BMCs of the Delta AHE-50DC
Open19 power shelf.  The first patch adds a compat entry to the Aspeed
bindings; the second adds the device-tree itself.

Changes since v1 [0]:
 - rearranged patch 2 with macros to reduce boilerplate
 - added ack from Krzysztof on patch 1

Thanks,
Zev

[0] https://lore.kernel.org/lkml/20221105013321.2719-1-zev at bewilderbeest.net/T/

Zev Weiss (2):
  dt-bindings: arm: aspeed: document Delta AHE-50DC BMC
  ARM: dts: aspeed: Add Delta AHE-50DC BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 .../arm/boot/dts/aspeed-bmc-delta-ahe50dc.dts | 418 ++++++++++++++++++
 3 files changed, 420 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-delta-ahe50dc.dts

-- 
2.38.1

