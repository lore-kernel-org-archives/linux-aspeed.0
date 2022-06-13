From: Potin Lai <potin.lai.pt@gmail.com>
Date: Mon, 13 Jun 2022 17:51:46 +0800
Subject: [PATCH 0/4] Update Facebook Bletchley BMC DTS
Message-ID: <20220613095150.21917-1-potin.lai.pt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Update below items for Facebook Bletchley BMC devicetree.

Potin Lai (4):
  ARM: dts: aspeed: bletchley: change LED sys_log_id to active low
  ARM: dts: aspeed: bletchley: disable GPIOV2 pull-down
  ARM: dts: aspeed: bletchley: bind presence-sledX pins via gpio-keys
  ARM: dts: aspeed: bletchley: update fusb302 nodes

 .../dts/aspeed-bmc-facebook-bletchley.dts     | 197 +++++++++++++-----
 1 file changed, 148 insertions(+), 49 deletions(-)

-- 
2.17.1

