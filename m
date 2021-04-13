From: Eddie James <eajames@linux.ibm.com>
Date: Tue, 13 Apr 2021 14:43:04 -0500
Subject: [PATCH 0/4] ARM: dts: aspeed: Rainier: Various fixes and update
Message-ID: <20210413194308.36930-1-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This series fixes a number of issues introduced in the Rainier device tree.
It also brings the device tree up to date with the latest hardware revision.

Eddie James (4):
  ARM: dts: aspeed: Rainier: Fix PCA9552 on bus 8
  ARM: dts: aspeed: Rainier: Fix humidity sensor bus address
  ARM: dts: aspeed: Rainier 1S4U: Fix fan nodes
  ARM: dts: aspeed: Rainier: Update to pass 2 hardware

 .../boot/dts/aspeed-bmc-ibm-rainier-1s4u.dts  |   2 +-
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts  | 306 ++++++++++--------
 2 files changed, 166 insertions(+), 142 deletions(-)

-- 
2.27.0

