From: Hongwei Zhang <hongweiz@ami.com>
Date: Tue, 20 Aug 2019 17:05:27 -0400
Subject: [v8]  gpio: aspeed: Add SGPIO driver
Message-ID: <1566335128-31498-1-git-send-email-hongweiz@ami.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

This short series introduce dt-binding document and a driver for the 
Aspeed AST2500 SGPIO controller. Please review.

[v8]:   Changes between v7 and v8:
        - v7 updates based on Linus' feedback 
        - since Linus has already merged sgpio-aspeed.txt, I only include
	  the driver here to avoid confusion.

[v7]:   Changes between v6 and v7:
        - fix missing variable 'reg' assign issue in aspeed_sgpio_set()
        - v6 feedback updates

[v6]:   Changes between v5 and v6:
        - fix a bug in aspeed_sgpio_dir_out()
        - v5 feedback updates, some comments cleanup

The related SGPM pinmux dt-binding document, dts, and pinctrl driver
updates have been accepted and merged:
_http://patchwork.ozlabs.org/patch/1110210/

Hongwei Zhang (1):
  gpio: aspeed: Add SGPIO driver

 drivers/gpio/sgpio-aspeed.c | 533 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 533 insertions(+)
 create mode 100644 drivers/gpio/sgpio-aspeed.c

-- 
2.7.4

