From: Hongwei Zhang <hongweiz@ami.com>
Date: Tue, 30 Jul 2019 11:24:26 -0400
Subject: [v6 0/2] gpio: aspeed: Add SGPIO driver
Message-ID: <1564500268-2627-1-git-send-email-hongweiz@ami.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

This short series introduce dt-binding document and a driver for the 
Aspeed AST2500 SGPIO controller. Please review.

[v6]:	Changes between v5 and v6:
	- fix a bug in aspeed_sgpio_dir_out()
	- v5 feedback updates, some comments cleanup

The related SGPM pinmux dt-binding document, dts, and pinctrl driver
updates have been accepted and merged:
_http://patchwork.ozlabs.org/patch/1110210/


Hongwei Zhang (2):
  dt-bindings: gpio: aspeed: Add SGPIO support
  gpio: aspeed: Add SGPIO driver

 .../devicetree/bindings/gpio/sgpio-aspeed.txt      |  55 +++
 drivers/gpio/sgpio-aspeed.c                        | 521 +++++++++++++++++++++
 2 files changed, 576 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt
 create mode 100644 drivers/gpio/sgpio-aspeed.c

-- 
2.7.4

