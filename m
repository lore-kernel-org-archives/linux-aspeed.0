From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Mon,  5 Sep 2022 16:56:32 -0700
Subject: [PATCH net-next 0/2] net: ftgmac100: support fixed link
Message-ID: <20220905235634.20957-1-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <taoren@fb.com>

The patch series adds fixed link support to ftgmac100 driver.

Patch #1 adds fixed link logic into ftgmac100 driver.

Patch #2 enables mac3 controller in Elbert dts, and mac3 is connected to
the onboard switch directly.

Tao Ren (2):
  net: ftgmac100: support fixed link
  ARM: dts: aspeed: elbert: Enable mac3 controller

 .../boot/dts/aspeed-bmc-facebook-elbert.dts   | 11 +++++++++
 drivers/net/ethernet/faraday/ftgmac100.c      | 24 +++++++++++++++++++
 2 files changed, 35 insertions(+)

-- 
2.30.2

