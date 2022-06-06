From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Mon, 6 Jun 2022 15:18:41 +0200
Subject: [PATCH 00/14] mtd: Fix platform remove callbacks to always
 return 0
In-Reply-To: <20220603210758.148493-1-u.kleine-koenig@pengutronix.de>
References: <20220603210758.148493-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20220606151841.682a5939@xps-13>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Folks,

u.kleine-koenig at pengutronix.de wrote on Fri,  3 Jun 2022 23:07:44 +0200:

> Hello,
> 
> this series prepares to make platform remove callbacks return void.
> Therefor first update them to always return 0. The rationale is that the
> Linux device model doesn't handle failures on remove and if a remove
> callback returns an error, it just emits a quite generic error message
> and still removes the device.

Tudor, Pratyush, Richard, Vignesh,

The series looks good to me (besides the atmel patch), I think it's
best to take it directly through mtd/next instead of going through all
the different internal branches, please let me know if you disagree
with the idea.

Cheers,
Miqu?l

> 
> Best regards
> Uwe
> 
> Uwe Kleine-K?nig (14):
>   mtd: hyperbus: Make hyperbus_unregister_device() return void
>   mtd: spi-nor: aspeed-smc: Make aspeed_smc_unregister() return void
>   mtd: powernv_flash: Warn about failure to unregister mtd device
>   mtd: st-spi_fsm: Warn about failure to unregister mtd device
>   mtd: lpddr2_nvm: Warn about failure to unregister mtd device
>   mtd: spear_smi: Don't skip cleanup after mtd_device_unregister()
>     failed
>   mtd: spear_smi: Drop if with an always false condition
>   mtd: rawnand: atmel: Warn about failure to unregister mtd device
>   mtd: rawnand: omap2: Suppress error message after WARN in .remove()
>   mtd: rawnand: tegra: Don't skip cleanup after mtd_device_unregister()
>     failed
>   mtd: rawnand: meson: Don't skip cleanup after mtd_device_unregister()
>     failed
>   mtd: rawnand: meson: Drop cleaning platform data in .remove()
>   mtd: physmap: Don't skip cleanup after mtd_device_unregister() failed
>   mtd: physmap: Drop if with an always false condition
> 
>  drivers/mtd/devices/powernv_flash.c          |  4 +++-
>  drivers/mtd/devices/spear_smi.c              | 10 ++--------
>  drivers/mtd/devices/st_spi_fsm.c             |  4 +++-
>  drivers/mtd/hyperbus/hbmc-am654.c            |  6 +++---
>  drivers/mtd/hyperbus/hyperbus-core.c         |  8 ++------
>  drivers/mtd/hyperbus/rpc-if.c                |  5 +++--
>  drivers/mtd/lpddr/lpddr2_nvm.c               |  4 +++-
>  drivers/mtd/maps/physmap-core.c              | 13 +++----------
>  drivers/mtd/nand/raw/atmel/nand-controller.c |  5 ++++-
>  drivers/mtd/nand/raw/meson_nand.c            | 16 +++-------------
>  drivers/mtd/nand/raw/omap2.c                 |  6 ++----
>  drivers/mtd/nand/raw/tegra_nand.c            |  5 +----
>  drivers/mtd/spi-nor/controllers/aspeed-smc.c |  8 ++++----
>  include/linux/mtd/hyperbus.h                 |  4 +---
>  14 files changed, 37 insertions(+), 61 deletions(-)
> 
> base-commit: 4b0986a3613c92f4ec1bdc7f60ec66fea135991f

