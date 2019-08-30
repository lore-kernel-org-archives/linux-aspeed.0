From: Eddie James <eajames@linux.ibm.com>
Date: Fri, 30 Aug 2019 11:09:42 -0500
Subject: [PATCH 0/3] pmbus: ibm-cffps: Add support for version 2 of PSU
Message-ID: <1567181385-22129-1-git-send-email-eajames@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Version 2 of this PSU supports a second page of data and changes the
format of the FW version command. Use the devicetree binding (or the I2C
device ID) to determine which version the driver should use. Therefore add
the new compatible string to the devicetree documentation and change the
Swift system devicetree to use version 2.

Eddie James (3):
  dt-bindings: hwmon: Document ibm,cffps2 compatible string
  ARM: dts: aspeed: swift: Change power supplies to version 2
  pmbus: ibm-cffps: Add support for version 2 of the PSU

 .../devicetree/bindings/hwmon/ibm,cffps1.txt       |   8 +-
 arch/arm/boot/dts/aspeed-bmc-opp-swift.dts         |   4 +-
 drivers/hwmon/pmbus/ibm-cffps.c                    | 109 ++++++++++++++++-----
 3 files changed, 94 insertions(+), 27 deletions(-)

-- 
1.8.3.1

