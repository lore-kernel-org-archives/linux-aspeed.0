From: Ninad Palsule <ninad@linux.ibm.com>
Date: Mon, 21 Aug 2023 13:35:24 -0500
Subject: [PATCH v1 0/1] Host side BMC device driver
Message-ID: <20230821183525.3427144-1-ninad@linux.ibm.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,
This patch includes support for host side BMC device driver.

Ninad Palsule (1):
  soc/aspeed: Add host side BMC device driver

 drivers/soc/aspeed/Kconfig               |   9 +
 drivers/soc/aspeed/Makefile              |   1 +
 drivers/soc/aspeed/aspeed-host-bmc-dev.c | 251 +++++++++++++++++++++++
 3 files changed, 261 insertions(+)
 create mode 100644 drivers/soc/aspeed/aspeed-host-bmc-dev.c

-- 
2.39.2

