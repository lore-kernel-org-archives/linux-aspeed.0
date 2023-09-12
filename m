From: Ninad Palsule <ninad@linux.ibm.com>
Date: Tue, 12 Sep 2023 17:09:21 -0500
Subject: [PATCH v3 0/2] soc/aspeed: Add host side BMC device driver
Message-ID: <20230912220923.3701688-1-ninad@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,
Please review a version 3 of patchset.
    - Fixed warning reported by kernel test robot.
    - Added MAINTAINER for new file.
    - Fixed check patch warning.

Ninad Palsule (2):
  soc/aspeed: Add host side BMC device driver
  MAINTAINERS: Added maintainer for host bmc DD

 MAINTAINERS                              |   7 +
 drivers/soc/aspeed/Kconfig               |  11 +
 drivers/soc/aspeed/Makefile              |   1 +
 drivers/soc/aspeed/aspeed-host-bmc-dev.c | 250 +++++++++++++++++++++++
 4 files changed, 269 insertions(+)
 create mode 100644 drivers/soc/aspeed/aspeed-host-bmc-dev.c

-- 
2.39.2

