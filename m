From: Zev Weiss <zev@bewilderbeest.net>
Date: Fri,  3 Feb 2023 02:54:03 -0800
Subject: [PATCH 0/2] ARM: dts: aspeed: ASRock BMC updates
Message-ID: <20230203105405.21942-1-zev@bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

This patch series contains two small device-tree updates for ASRock
BMCs -- an LED polarity fix for romed8hm3, and enabling the ast2500
PECI device on e3c246d4i.


Thanks,
Zev


Zev Weiss (2):
  ARM: dts: aspeed: romed8hm3: Fix GPIO polarity of system-fault LED
  ARM: dts: aspeed: e3c246d4i: Add PECI device

 arch/arm/boot/dts/aspeed-bmc-asrock-e3c246d4i.dts | 4 ++++
 arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.39.1.236.ga8a28b9eace8

