From: Lei Liu <liulei.rjpt@vivo.com>
Date: Mon, 26 Aug 2024 16:18:56 +0800
Subject: [PATCH v3 0/5] usb drivers use devm_clk_get_enabled() helpers
Message-ID: <20240826081900.2284-1-liulei.rjpt@vivo.com>
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

---
version 3 changes
Fix the email thread.

---
version 2 changes

The files ux500.c, mpfs.c, and pxa27x_udc.c have incorrect usage of 
certain interfaces due to the lack of synchronization during the 
commit updates. These issues have been corrected in the v1 version.

1.ux500: Incorrect usage of clk_prepare_enable() should be corrected to
  devm_clk_get_enabled().
2.mpfs: Incorrect usage of devm_clk_get_enable() should be corrected to
  devm_clk_get_enabled().
3.pxa27x_udc: Incorrect usage of clk_prepare_enable() should be
  corrected to devm_clk_get_enabled().

Lei Liu (5):
  usb: aspeed_udc: Use devm_clk_get_enabled() helpers
  usb: pxa27x_udc: Use devm_clk_get_enabled() helpers
  usb: r8a66597-udc: Use devm_clk_get_enabled() helpers
  usb: mpfs: Use devm_clk_get_enabled() helpers
  sb: ux500: Use devm_clk_get_enabled() helpers

 drivers/usb/gadget/udc/aspeed_udc.c   |  9 +--------
 drivers/usb/gadget/udc/pxa27x_udc.c   |  6 +-----
 drivers/usb/gadget/udc/r8a66597-udc.c | 16 ++++------------
 drivers/usb/musb/mpfs.c               | 22 ++++++----------------
 drivers/usb/musb/ux500.c              | 18 ++++--------------
 5 files changed, 16 insertions(+), 55 deletions(-)

-- 
2.34.1

