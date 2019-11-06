From: Sebastian Reichel <sre@kernel.org>
Date: Wed, 6 Nov 2019 13:08:46 +0100
Subject: [PATCH v2 0/2] Add definition for GPIO direction
In-Reply-To: <cover.1573029228.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1573029228.git.matti.vaittinen@fi.rohmeurope.com>
Message-ID: <20191106120846.5bunrqj3uz4khih5@earth.universe>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

On Wed, Nov 06, 2019 at 10:51:06AM +0200, Matti Vaittinen wrote:
> The patch series adds definitions for GPIO line directions.
> 
> For occasional GPIO contributor like me it is always a pain to remember
> whether 1 or 0 was used for GPIO direction INPUT/OUTPUT. Judging the
> fact that I removed few comments like:
> 
> /* Return 0 if output, 1 if input */
> /* This means "out" */
> return 1; /* input */
> return 0; /* output */
> 
> it seems at least some others may find it hard to remember too. Adding
> defines for these values helps us who really have good - but short
> duration - memory :]
> 
> This idea comes from RFC series for ROHM BD71828 PMIC and was initially
> discussed with Linus Walleij here:
> https://lore.kernel.org/lkml/c06725c3dd34118a324907137758d8b85b3d4043.camel at fi.rohmeurope.com/
> but as this has no dependencies to BD71828 work (which probably takes a
> while) I decided to make it independent series.
> 
> Patches are compile-tested only. I have no HW to really test them. Thus I'd
> appreciate carefull review. This work is mainly about converting zeros
> and ones to the new defines but it wouldn't be first time I get it
> wrong.
> 
> Changelog v2:
>  - squashed patches 2-61 into patch 2.
>  - dropped patch 62 (can be applied later)
>  - rebased (cherry-picked) changes on top of GPIO devel branch.
> 
> Patch 1:
>  - adds the defines
> Patch 2:
>  - convert drivers to use new defines
> 
> This patch series is based on GPIO tree devel branch.
> 
> ---
> 
> Matti Vaittinen (2):
>   gpio: Add definition for GPIO direction
>   gpio: Use new GPIO_LINE_DIRECTION
> 
>  drivers/gpio/*
>  include/linux/gpio/driver.h         |  3 +++
>  61 files changed, 214 insertions(+), 102 deletions(-)

Maybe also update the GPIO drivers in pinctrl?

$ git grep -l gpio_get_direction drivers/pinctrl
drivers/pinctrl/bcm/pinctrl-bcm2835.c
drivers/pinctrl/bcm/pinctrl-iproc-gpio.c
drivers/pinctrl/intel/pinctrl-baytrail.c
drivers/pinctrl/intel/pinctrl-cherryview.c
drivers/pinctrl/intel/pinctrl-intel.c
drivers/pinctrl/mediatek/pinctrl-mtk-common.c
drivers/pinctrl/mediatek/pinctrl-paris.c
drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
drivers/pinctrl/pinctrl-amd.c
drivers/pinctrl/pinctrl-at91.c
drivers/pinctrl/pinctrl-axp209.c
drivers/pinctrl/pinctrl-ingenic.c
drivers/pinctrl/pinctrl-ocelot.c
drivers/pinctrl/pinctrl-oxnas.c
drivers/pinctrl/pinctrl-pic32.c
drivers/pinctrl/pinctrl-pistachio.c
drivers/pinctrl/pinctrl-rk805.c
drivers/pinctrl/pinctrl-rockchip.c
drivers/pinctrl/pinctrl-rza1.c
drivers/pinctrl/pinctrl-st.c
drivers/pinctrl/pinctrl-stmfx.c
drivers/pinctrl/pinctrl-sx150x.c
drivers/pinctrl/qcom/pinctrl-msm.c
drivers/pinctrl/stm32/pinctrl-stm32.c
drivers/pinctrl/vt8500/pinctrl-wmt.c

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20191106/88d4bb95/attachment-0001.sig>
