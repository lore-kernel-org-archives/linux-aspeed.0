From: Ninad Palsule <ninad@linux.ibm.com>
Date: Wed, 23 Aug 2023 12:31:03 -0500
Subject: [PATCH v2 0/1] Host side BMC device driver
Message-ID: <20230823173104.3219128-1-ninad@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,
This is a version 2 patch. I have incorporated review comments
and fixed warning reported by kernel test robot.

Ninad Palsule (1):
  soc/aspeed: Add host side BMC device driver

 drivers/soc/aspeed/Kconfig               |   8 +
 drivers/soc/aspeed/Makefile              |   1 +
 drivers/soc/aspeed/aspeed-host-bmc-dev.c | 250 +++++++++++++++++++++++
 3 files changed, 259 insertions(+)
 create mode 100644 drivers/soc/aspeed/aspeed-host-bmc-dev.c

-- 
2.39.2

