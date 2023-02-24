From: Zev Weiss <zev@bewilderbeest.net>
Date: Thu, 23 Feb 2023 16:03:57 -0800
Subject: [PATCH v2 0/3] ARM: dts: aspeed: ASRock BMC updates
Message-ID: <20230224000400.12226-1-zev@bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

This patch series contains a few small device-tree updates for ASRock
BMCs: an LED polarity fix for romed8hm3, enabling the ast2500 PECI
device on e3c246d4i, and a SPI flash clock frequency fix for both.

Thanks,
Zev

Changes since v1 [0]:
 - Added patch 3 correcting SPI flash clocks

[0] https://lore.kernel.org/linux-devicetree/20230203105405.21942-1-zev at bewilderbeest.net/

Zev Weiss (3):
  ARM: dts: aspeed: romed8hm3: Fix GPIO polarity of system-fault LED
  ARM: dts: aspeed: e3c246d4i: Add PECI device
  ARM: dts: aspeed: asrock: Correct firmware flash SPI clocks

 arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts | 6 +++++-
 arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts | 4 ++--
 2 files changed, 7 insertions(+), 3 deletions(-)

-- 
2.39.1.438.gdcb075ea9396.dirty

