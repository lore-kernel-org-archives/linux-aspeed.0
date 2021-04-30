From: Eddie James <eajames@linux.ibm.com>
Date: Fri, 30 Apr 2021 13:59:56 -0500
Subject: [PATCH 0/4] ARM: dts: aspeed: Rainier and Everest updates
Message-ID: <20210430190000.31646-1-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This series fixes a few new issues found in the Rainier and Everest
machine device trees. It also adds the LEDs that are directly
connected to the AST2600 and controlled by GPIO.

Andrew Geissler (1):
  ARM: dts: aspeed: Rainier 1S4U: Fix fan channels

Eddie James (1):
  ARM: dts: aspeed: Rainier 4U: Remove fan updates

Santosh Puranik (1):
  ARM: dts: aspeed: Everest: Fix cable card PCA chips

Vishwanatha Subbanna (1):
  ARM: dts: aspeed: Everest: Add directly controlled LEDs

 arch/arm/boot/dts/aspeed-bmc-ibm-everest.dts  | 201 ++++++++++--------
 .../boot/dts/aspeed-bmc-ibm-rainier-1s4u.dts  |   2 +-
 .../boot/dts/aspeed-bmc-ibm-rainier-4u.dts    |  30 ---
 3 files changed, 115 insertions(+), 118 deletions(-)

-- 
2.27.0

