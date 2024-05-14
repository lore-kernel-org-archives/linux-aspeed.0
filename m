From: Eddie James <eajames@linux.ibm.com>
Date: Tue, 14 May 2024 16:35:06 -0500
Subject: [PATCH v5 0/4] ARM: dts: aspeed: Add IBM P11 BMC systems
Message-ID: <20240514213510.159144-1-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This series was previously included in
https://lore.kernel.org/all/20240429210131.373487-1-eajames at linux.ibm.com/
The series now depends on
https://lore.kernel.org/all/20240514212555.158788-1-eajames at linux.ibm.com/
https://lore.kernel.org/all/20240514205454.158157-1-eajames at linux.ibm.com/
https://lore.kernel.org/all/20240514195435.155372-1-eajames at linux.ibm.com/
https://lore.kernel.org/all/20240514192630.152747-1-eajames at linux.ibm.com/

Changes since v4:
 - Update SPI frequencies
 - Add Blueridge 4U system

Eddie James (4):
  ARM: dts: aspeed: Add IBM P11 FSI devices
  ARM: dts: aspeed: Add IBM P11 Blueridge BMC system
  ARM: dts: aspeed: Add IBM P11 Blueridge 4U BMC system
  ARM: dts: aspeed: Add IBM P11 Fuji BMC system

 arch/arm/boot/dts/aspeed/Makefile             |    2 +
 .../aspeed/aspeed-bmc-ibm-blueridge-4u.dts    |   21 +
 .../dts/aspeed/aspeed-bmc-ibm-blueridge.dts   | 1691 +++++++
 .../boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts   | 3880 +++++++++++++++++
 .../arm/boot/dts/aspeed/ibm-power11-quad.dtsi | 1538 +++++++
 5 files changed, 7132 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge-4u.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts
 create mode 100644 arch/arm/boot/dts/aspeed/ibm-power11-quad.dtsi

-- 
2.39.3

