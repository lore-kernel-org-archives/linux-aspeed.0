From: Yong Li <yong.b.li@linux.intel.com>
Date: Tue, 1 Mar 2022 08:34:04 +0800
Subject: [PATCH v2 0/2] aspeed: Add LPC mailbox support
In-Reply-To: <20210817025848.19914-1-chiawei_wang@aspeedtech.com>
References: <20210817025848.19914-1-chiawei_wang@aspeedtech.com>
Message-ID: <000501d82d04$0ffa9870$2fefc950$@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

@andrew at aj.id.au @Chia-Wei Wang @joel at jms.id.au

Just want to check the latest status about this mailbox driver. I would like
to get this driver upstreamed too. 

Thanks,
Yong

-----Original Message-----
From: openbmc <openbmc-bounces+yong.b.li=linux.intel.com@lists.ozlabs.org>
On Behalf Of Chia-Wei Wang
Sent: Tuesday, August 17, 2021 10:59 AM
To: robh+dt@kernel.org; joel at jms.id.au; andrew at aj.id.au; cyrilbur at gmail.com;
devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
linux-aspeed at lists.ozlabs.org; linux-kernel at vger.kernel.org;
openbmc at lists.ozlabs.org
Subject: [PATCH v2 0/2] aspeed: Add LPC mailbox support

Add driver support for the LPC mailbox controller of ASPEED SoCs.

v2:
 - Fix error handling for copy_to_user
 - Fix incorrect type in the .poll initializer

Chia-Wei Wang (2):
  soc: aspeed: Add LPC mailbox support
  ARM: dts: aspeed: Add mailbox to device tree

 arch/arm/boot/dts/aspeed-g4.dtsi     |   7 +
 arch/arm/boot/dts/aspeed-g5.dtsi     |   8 +-
 arch/arm/boot/dts/aspeed-g6.dtsi     |   7 +
 drivers/soc/aspeed/Kconfig           |  10 +
 drivers/soc/aspeed/Makefile          |   9 +-
 drivers/soc/aspeed/aspeed-lpc-mbox.c | 418 +++++++++++++++++++++++++++
 6 files changed, 454 insertions(+), 5 deletions(-)  create mode 100644
drivers/soc/aspeed/aspeed-lpc-mbox.c

--
2.17.1

