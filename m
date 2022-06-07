From: Pratyush Yadav <p.yadav@ti.com>
Date: Tue, 7 Jun 2022 15:02:36 +0530
Subject: [PATCH 00/14] mtd: Fix platform remove callbacks to always
 return 0
In-Reply-To: <20220606151841.682a5939@xps-13>
References: <20220603210758.148493-1-u.kleine-koenig@pengutronix.de>
 <20220606151841.682a5939@xps-13>
Message-ID: <20220607093236.67txulke76mi6t75@ti.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Miquel,

On 06/06/22 03:18PM, Miquel Raynal wrote:
> Hi Folks,
> 
> u.kleine-koenig at pengutronix.de wrote on Fri,  3 Jun 2022 23:07:44 +0200:
> 
> > Hello,
> > 
> > this series prepares to make platform remove callbacks return void.
> > Therefor first update them to always return 0. The rationale is that the
> > Linux device model doesn't handle failures on remove and if a remove
> > callback returns an error, it just emits a quite generic error message
> > and still removes the device.
> 
> Tudor, Pratyush, Richard, Vignesh,
> 
> The series looks good to me (besides the atmel patch), I think it's
> best to take it directly through mtd/next instead of going through all
> the different internal branches, please let me know if you disagree
> with the idea.

Patch 2 does not look good to me. It modifies the aspeed-smc driver in 
drivers/mtd/spi-nor/controllers/ but the driver has been moved to 
drivers/spi/ in Mark's next branch [0]. The patch would likely conflict 
with that.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit?id=9c63b846e6df43e5b3d31263f7db545f32deeda3

> 
> Cheers,
> Miqu?l
> 
> > 
> > Best regards
> > Uwe
> > 
> > Uwe Kleine-K?nig (14):
> >   mtd: hyperbus: Make hyperbus_unregister_device() return void
> >   mtd: spi-nor: aspeed-smc: Make aspeed_smc_unregister() return void
> >   mtd: powernv_flash: Warn about failure to unregister mtd device
> >   mtd: st-spi_fsm: Warn about failure to unregister mtd device
> >   mtd: lpddr2_nvm: Warn about failure to unregister mtd device
> >   mtd: spear_smi: Don't skip cleanup after mtd_device_unregister()
> >     failed
> >   mtd: spear_smi: Drop if with an always false condition
> >   mtd: rawnand: atmel: Warn about failure to unregister mtd device
> >   mtd: rawnand: omap2: Suppress error message after WARN in .remove()
> >   mtd: rawnand: tegra: Don't skip cleanup after mtd_device_unregister()
> >     failed
> >   mtd: rawnand: meson: Don't skip cleanup after mtd_device_unregister()
> >     failed
> >   mtd: rawnand: meson: Drop cleaning platform data in .remove()
> >   mtd: physmap: Don't skip cleanup after mtd_device_unregister() failed
> >   mtd: physmap: Drop if with an always false condition
> > 
> >  drivers/mtd/devices/powernv_flash.c          |  4 +++-
> >  drivers/mtd/devices/spear_smi.c              | 10 ++--------
> >  drivers/mtd/devices/st_spi_fsm.c             |  4 +++-
> >  drivers/mtd/hyperbus/hbmc-am654.c            |  6 +++---
> >  drivers/mtd/hyperbus/hyperbus-core.c         |  8 ++------
> >  drivers/mtd/hyperbus/rpc-if.c                |  5 +++--
> >  drivers/mtd/lpddr/lpddr2_nvm.c               |  4 +++-
> >  drivers/mtd/maps/physmap-core.c              | 13 +++----------
> >  drivers/mtd/nand/raw/atmel/nand-controller.c |  5 ++++-
> >  drivers/mtd/nand/raw/meson_nand.c            | 16 +++-------------
> >  drivers/mtd/nand/raw/omap2.c                 |  6 ++----
> >  drivers/mtd/nand/raw/tegra_nand.c            |  5 +----
> >  drivers/mtd/spi-nor/controllers/aspeed-smc.c |  8 ++++----
> >  include/linux/mtd/hyperbus.h                 |  4 +---
> >  14 files changed, 37 insertions(+), 61 deletions(-)
> > 
> > base-commit: 4b0986a3613c92f4ec1bdc7f60ec66fea135991f
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
