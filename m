From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Mon,  5 Sep 2022 23:20:24 -0700
Subject: [PATCH net-next v2 0/2] net: ftgmac100: support fixed link
Message-ID: <20220906062026.57169-1-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

The patch series adds fixed link support to ftgmac100 driver.

Patch #1 adds fixed link logic into ftgmac100 driver.

Patch #2 enables mac3 controller in Elbert dts: Elbert mac3 is connected
to the onboard switch BCM53134P's IMP_RGMII port directly (no PHY
between BMC MAC and BCM53134P).

Tao Ren (2):
  net: ftgmac100: support fixed link
  ARM: dts: aspeed: elbert: Enable mac3 controller

 .../boot/dts/aspeed-bmc-facebook-elbert.dts   | 20 ++++++++++++++++
 drivers/net/ethernet/faraday/ftgmac100.c      | 24 +++++++++++++++++++
 2 files changed, 44 insertions(+)

-- 
2.37.3

