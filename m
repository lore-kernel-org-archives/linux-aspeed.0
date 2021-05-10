From: Zev Weiss <zev@bewilderbeest.net>
Date: Sun,  9 May 2021 20:42:28 -0500
Subject: [PATCH 0/3] serial: 8250_aspeed_vuart: fix duplicate
 __release_region() on unbind
Message-ID: <20210510014231.647-1-zev@bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

This series addresses a bug reported by Andrew Jeffery [0] wherein the
aspeed-vuart driver triggers a "Trying to free nonexistent resource"
warning from __release_region() when unbound from a device.  The first
two patches provide some preparatory refactoring and cleanups; the
actual fix is in the final patch.

Joel, note that this series has a dependency on the "generalized DT
properties" series [1] (specifically the second patch), which has been
merged upstream but is not yet in the OpenBMC dev-5.10 tree.

[0] https://github.com/openbmc/linux/issues/203
[1] https://lore.kernel.org/openbmc/20210412034712.16778-1-zev at bewilderbeest.net/

Zev Weiss (3):
  serial: 8250_aspeed_vuart: factor out aspeed_vuart_{read,write}b()
    helper functions
  serial: 8250_aspeed_vuart: initialize vuart->port in
    aspeed_vuart_probe()
  serial: 8250_aspeed_vuart: use UPF_IOREMAP to set up register mapping

 drivers/tty/serial/8250/8250_aspeed_vuart.c | 50 +++++++++++----------
 1 file changed, 27 insertions(+), 23 deletions(-)

-- 
2.31.1

