From: Hongwei Zhang <hongweiz@ami.com>
Date: Fri, 19 Jul 2019 15:24:49 -0400
Subject: [v5 0/2] gpio: aspeed: Add SGPIO driver
Message-ID: <1563564291-9692-1-git-send-email-hongweiz@ami.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

This short series introduce dt-binding document and a driver for the 
Aspeed AST2500 SGPIO controller. Please review.

The related SGPM pinmux dt-binding document, dts, and pinctrl driver
updates have been accepted and merged:
_http://patchwork.ozlabs.org/patch/1110210/

Hongwei Zhang (2):
  dt-bindings: gpio: aspeed: Add SGPIO support
  gpio: aspeed: Add SGPIO driver

 .../devicetree/bindings/gpio/sgpio-aspeed.txt      |  55 +++
 drivers/gpio/sgpio-aspeed.c                        | 522 +++++++++++++++++++++
 2 files changed, 577 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/sgpio-aspeed.txt
 create mode 100644 drivers/gpio/sgpio-aspeed.c

-- 
2.7.4

