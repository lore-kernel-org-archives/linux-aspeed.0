From: Lei Liu <liulei.rjpt@vivo.com>
Date: Wed, 21 Aug 2024 20:10:38 +0800
Subject: [PATCH 0/5] usb drivers use devm_clk_get_enabled() helpers
Message-ID: <20240821121048.31566-1-liulei.rjpt@vivo.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids calls to clk_disable_unprepare().

Lei Liu (5):
  usb: aspeed_udc: Use devm_clk_get_enabled() helpers
  usb: pxa27x_udc: Use devm_clk_get_enabled() helpers
  usb: r8a66597-udc: Use devm_clk_get_enabled() helpers
  usb: mpfs: Use devm_clk_get_enabled() helpers
  usb: ux500: Use devm_clk_get_enabled() helpers

 drivers/usb/gadget/udc/aspeed_udc.c   |  9 +--------
 drivers/usb/gadget/udc/pxa27x_udc.c   |  6 +-----
 drivers/usb/gadget/udc/r8a66597-udc.c | 16 ++++------------
 drivers/usb/musb/mpfs.c               | 22 ++++++----------------
 drivers/usb/musb/ux500.c              | 18 ++++--------------
 5 files changed, 16 insertions(+), 55 deletions(-)

-- 
2.34.1

