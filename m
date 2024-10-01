From: Ninad Palsule <ninad@linux.ibm.com>
Date: Tue,  1 Oct 2024 14:17:47 -0500
Subject: [PATCH v1 0/3] Device tree changes for system1 BMC
Message-ID: <20241001191756.234096-1-ninad@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

Please review the device tree changes for BMC for system1 machine.

Ninad Palsule (3):
  ARM: dts: aspeed: system1: Bump up i2c busses freq
  ARM: dts: aspeed: system1: Enable serial gpio0
  ARM: dts: aspeed: system1: Add GPIO line names

 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

-- 
2.43.0

