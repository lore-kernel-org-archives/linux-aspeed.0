From: Potin Lai <potin.lai.pt@gmail.com>
Date: Wed, 10 Aug 2022 00:43:36 +0000
Subject: [PATCH 0/2] Update Facebook Bletchley BMC devicetree
Message-ID: <20220810004338.329832-1-potin.lai.pt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch series add modifications as below
1. add a IPMB node for USB debug card communication.
2. remove hdc1080 node due to incompatible 2nd source (si7021). 

Potin Lai (2):
  ARM: dts: aspeed: bletchley: add USB debug card IPMB node
  ARM: dts: aspeed: bletchley: remove hdc1080 node

 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

-- 
2.31.1

