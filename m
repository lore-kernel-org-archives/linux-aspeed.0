From: Hongwei Zhang <hongweiz@ami.com>
Date: Wed, 25 Sep 2019 15:22:15 -0400
Subject: [v2, 0/2] gpio: dts: aspeed: Add SGPIO driver 
Message-ID: <1569439337-10482-1-git-send-email-hongweiz@ami.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

This short series introduce the Kconfig, Makefile, and dts for the 
Aspeed AST2500 SGPIO controller. This is the last patch set.
Please review.

[v2]:	changes between v1 and v2:
	- split the patches based on review feedback.

[v1]:	Initial commit

The related SGPIO driver has been accepted and merged into v5.4:
_http://patchwork.ozlabs.org/patch/1150357/

The related SGPM pinmux dt-binding document, dts, and pinctrl driver
updates have been accepted and merged:
_http://patchwork.ozlabs.org/patch/1110210/

Thanks!
Hongwei Zhang (1):
  gpio: dts: aspeed: Add SGPIO driver

 arch/arm/Kconfig                 |  2 ++
 arch/arm/boot/dts/aspeed-g5.dtsi | 16 +++++++++++++++-
 drivers/gpio/Kconfig             |  8 ++++++++
 drivers/gpio/Makefile            |  1 +
 4 files changed, 26 insertions(+), 1 deletion(-)

-- 
2.7.4

