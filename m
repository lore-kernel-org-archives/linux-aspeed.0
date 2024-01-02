From: Peter Yin <peteryin.openbmc@gmail.com>
Date: Tue,  2 Jan 2024 12:44:04 +0800
Subject: [PATCH v1 0/5] Revise Meta(Facebook) Harma BMC(AST2600)
Message-ID: <20240102044409.3810873-1-peteryin.openbmc@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Summary:
Revise linux device tree entry related to Meta(Facebook) Harma
specific devices connected to BMC(AST2600) SoC.

Base on : https://lore.kernel.org/all/CACPK8XePx+PvDKzPMjPRn_g9z8yrtAmLvP8Qbepm1AVjuCbaKw at mail.gmail.com/

Change log:

v1
  - Patch 0001 - Revise SGPIO line name.
  - Patch 0002 - Mapping ttyS2 to UART4.
  - Patch 0003 - Remove Vuart.
  - Patch 0004 - Add cpu power good line name.
  - Patch 0005 - Add spi-gpio.

Peter Yin (5):
  ARM: dts: aspeed: Harma: Revise SGPIO line name.
  ARM: dts: aspeed: Harma: mapping ttyS2 to UART4.
  ARM: dts: aspeed: Harma: Remove Vuart
  ARM: dts: aspeed: Harma: Add cpu power good line name
  ARM: dts: aspeed: Harma: Add spi-gpio

 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 33 ++++++++++++++-----
 1 file changed, 25 insertions(+), 8 deletions(-)

-- 
2.25.1

