From: rentao.bupt@gmail.com <rentao.bupt@gmail.com>
Date: Mon, 24 Aug 2020 11:29:53 -0700
Subject: [PATCH 0/2] ARM: dts: aspeed: wedge40: fix a few nits
Message-ID: <20200824182955.7988-1-rentao.bupt@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Tao Ren <rentao.bupt@gmail.com>

This patch series fixes a few nits in wedge40 device tree.

Patch #1 updates FMC flash label so it's consistent with other Facebook
OpenBMC platforms.

Patch #2 updates UART4 pin settings for the purpose of RS485 software
emulation.

Tao Ren (2):
  ARM: dts: aspeed: wedge40: Update FMC flash0 label
  ARM: dts: aspeed: wedge40: Update UART4 pin settings

 arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.17.1

