From: Peter Yin <peteryin.openbmc@gmail.com>
Date: Wed, 21 Feb 2024 17:39:15 +0800
Subject: [PATCH v3 0/9] Revise Meta(Facebook) Harma BMC(AST2600)
Message-ID: <20240221093925.2393604-1-peteryin.openbmc@gmail.com>
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

v2 -> v3
  - Patch 0007 - Revise max31790 address
  - Patch 0008 - Harma: Add NIC Fru device
  - Patch 0009 - Add ltc4286 device

v1 -> v2
  - Add infineon,slb9670 information for tpm.
  - Patch 0006 - Add PDB temperature.

v1
  - Patch 0001 - Revise SGPIO line name.
  - Patch 0002 - Mapping ttyS2 to UART4.
  - Patch 0003 - Remove Vuart.
  - Patch 0004 - Add cpu power good line name.
  - Patch 0005 - Add spi-gpio.

Peter Yin (9):
  ARM: dts: aspeed: Harma: Revise SGPIO line name.
  ARM: dts: aspeed: Harma: mapping ttyS2 to UART4.
  ARM: dts: aspeed: Harma: Remove Vuart
  ARM: dts: aspeed: Harma: Add cpu power good line name
  ARM: dts: aspeed: Harma: Add spi-gpio
  ARM: dts: aspeed: Harma: Add PDB temperature
  ARM: dts: aspeed: Harma: Revise max31790 address
  ARM: dts: aspeed: Harma: Add NIC Fru device
  ARM: dts: aspeed: Harma: Add ltc4286 device

 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 59 +++++++++++++++----
 1 file changed, 47 insertions(+), 12 deletions(-)

-- 
2.25.1

