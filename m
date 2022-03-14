From: Neil Armstrong <narmstrong@baylibre.com>
Date: Mon, 14 Mar 2022 09:01:19 +0100
Subject: [PATCH 64/64] media: Kconfig: cleanup VIDEO_DEV dependencies
In-Reply-To: <decd26e90adc5c16470e4f738810f22fe6478b27.1647242579.git.mchehab@kernel.org>
References: <cover.1647242578.git.mchehab@kernel.org>
 <decd26e90adc5c16470e4f738810f22fe6478b27.1647242579.git.mchehab@kernel.org>
Message-ID: <18f984ff-36c8-dbe5-6dd0-404c4fe9deab@baylibre.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 14/03/2022 08:55, Mauro Carvalho Chehab wrote:
> media Kconfig has two entries associated to V4L API:
> VIDEO_DEV and VIDEO_V4L2.
> 
> On Kernel 2.6.x, there were two V4L APIs, each one with its own flag.
> VIDEO_DEV were meant to:
> 	1) enable Video4Linux and make its Kconfig options to appear;
> 	2) it makes the Kernel build the V4L core.
> 
> while VIDEO_V4L2 where used to distinguish between drivers that
> implement the newer API and drivers that implemented the former one.
> 
> With time, such meaning changed, specially after the removal of
> all V4L version 1 drivers.
> 
> At the current implementation, VIDEO_DEV only does (1): it enables
> the media options related to V4L, that now has:
> 
> 	menu "Video4Linux options"
> 		visible if VIDEO_DEV
> 
> 	source "drivers/media/v4l2-core/Kconfig"
> 	endmenu
> 
> but it doesn't affect anymore the V4L core drivers.
> 
> The rationale is that the V4L2 core has a "soft" dependency
> at the I2C bus, and now requires to select a number of other
> Kconfig options:
> 
> 	config VIDEO_V4L2
> 		tristate
> 		depends on (I2C || I2C=n) && VIDEO_DEV
> 		select RATIONAL
> 		select VIDEOBUF2_V4L2 if VIDEOBUF2_CORE
> 		default (I2C || I2C=n) && VIDEO_DEV
> 
> In the past, merging them would be tricky, but it seems that it is now
> possible to merge those symbols, in order to simplify V4L dependencies.
> 
> Let's keep VIDEO_DEV, as this one is used on some make *defconfig
> configurations.
> 
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
> 
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH 00/64] at: https://lore.kernel.org/all/cover.1647242578.git.mchehab at kernel.org/
> 
>   drivers/input/rmi4/Kconfig                    |   2 +-
>   drivers/input/touchscreen/Kconfig             |   4 +-
>   drivers/media/Kconfig                         |   3 +
>   drivers/media/common/saa7146/Kconfig          |   2 +-
>   drivers/media/dvb-core/Kconfig                |   2 +-
>   drivers/media/dvb-frontends/Kconfig           |   4 +-
>   drivers/media/i2c/Kconfig                     | 250 +++++++++---------
>   drivers/media/i2c/ccs/Kconfig                 |   2 +-
>   drivers/media/i2c/cx25840/Kconfig             |   2 +-
>   drivers/media/i2c/et8ek8/Kconfig              |   2 +-
>   drivers/media/i2c/m5mols/Kconfig              |   2 +-
>   drivers/media/pci/Kconfig                     |   2 +-
>   drivers/media/pci/bt8xx/Kconfig               |   2 +-
>   drivers/media/pci/cobalt/Kconfig              |   2 +-
>   drivers/media/pci/cx18/Kconfig                |   2 +-
>   drivers/media/pci/dt3155/Kconfig              |   2 +-
>   drivers/media/pci/intel/ipu3/Kconfig          |   2 +-
>   drivers/media/pci/ivtv/Kconfig                |   2 +-
>   drivers/media/pci/meye/Kconfig                |   2 +-
>   drivers/media/pci/saa7146/Kconfig             |   6 +-
>   drivers/media/pci/sta2x11/Kconfig             |   2 +-
>   drivers/media/pci/tw5864/Kconfig              |   2 +-
>   drivers/media/pci/tw68/Kconfig                |   2 +-
>   drivers/media/pci/tw686x/Kconfig              |   2 +-
>   drivers/media/platform/Kconfig                |   6 +-
>   drivers/media/platform/allegro-dvt/Kconfig    |   2 +-
>   .../platform/allwinner/sun4i-csi/Kconfig      |   2 +-
>   .../platform/allwinner/sun6i-csi/Kconfig      |   2 +-
>   .../media/platform/allwinner/sun8i-di/Kconfig |   2 +-
>   .../platform/allwinner/sun8i-rotate/Kconfig   |   2 +-
>   .../media/platform/amlogic/meson-ge2d/Kconfig |   2 +-
>   drivers/media/platform/aspeed/Kconfig         |   2 +-
>   drivers/media/platform/atmel/Kconfig          |   8 +-
>   drivers/media/platform/cadence/Kconfig        |   4 +-
>   drivers/media/platform/chips-media/Kconfig    |   2 +-
>   drivers/media/platform/intel/Kconfig          |   2 +-
>   drivers/media/platform/marvell/Kconfig        |   4 +-
>   .../media/platform/mediatek/mtk-jpeg/Kconfig  |   2 +-
>   .../media/platform/mediatek/mtk-mdp/Kconfig   |   2 +-
>   .../platform/mediatek/mtk-vcodec/Kconfig      |   2 +-
>   .../media/platform/mediatek/mtk-vpu/Kconfig   |   2 +-
>   .../media/platform/nvidia/tegra-vde/Kconfig   |   2 +-
>   drivers/media/platform/nxp/Kconfig            |   6 +-
>   drivers/media/platform/nxp/amphion/Kconfig    |   2 +-
>   drivers/media/platform/nxp/imx-jpeg/Kconfig   |   2 +-
>   drivers/media/platform/qcom/camss/Kconfig     |   2 +-
>   drivers/media/platform/qcom/venus/Kconfig     |   2 +-
>   drivers/media/platform/renesas/Kconfig        |  30 +--
>   .../media/platform/renesas/rcar-vin/Kconfig   |   4 +-
>   drivers/media/platform/rockchip/rga/Kconfig   |   2 +-
>   .../media/platform/rockchip/rkisp1/Kconfig    |   2 +-
>   .../media/platform/samsung/exynos-gsc/Kconfig |   2 +-
>   .../media/platform/samsung/exynos4-is/Kconfig |   2 +-
>   .../media/platform/samsung/s3c-camif/Kconfig  |   2 +-
>   .../media/platform/samsung/s5p-g2d/Kconfig    |   2 +-
>   .../media/platform/samsung/s5p-jpeg/Kconfig   |   2 +-
>   .../media/platform/samsung/s5p-mfc/Kconfig    |   2 +-
>   drivers/media/platform/sti/bdisp/Kconfig      |   2 +-
>   drivers/media/platform/sti/delta/Kconfig      |   2 +-
>   drivers/media/platform/sti/hva/Kconfig        |   2 +-
>   drivers/media/platform/sti/stm32/Kconfig      |   4 +-
>   drivers/media/platform/ti/am437x/Kconfig      |   2 +-
>   drivers/media/platform/ti/davinci/Kconfig     |  12 +-
>   drivers/media/platform/ti/omap/Kconfig        |   2 +-
>   drivers/media/platform/ti/omap3isp/Kconfig    |   2 +-
>   drivers/media/platform/ti/vpe/Kconfig         |   4 +-
>   drivers/media/platform/via/Kconfig            |   2 +-
>   drivers/media/platform/xilinx/Kconfig         |   2 +-
>   drivers/media/radio/Kconfig                   |  54 ++--
>   drivers/media/radio/si470x/Kconfig            |   2 +-
>   drivers/media/radio/wl128x/Kconfig            |   2 +-
>   drivers/media/spi/Kconfig                     |   4 +-
>   drivers/media/test-drivers/Kconfig            |   2 +-
>   drivers/media/test-drivers/vicodec/Kconfig    |   2 +-
>   drivers/media/test-drivers/vimc/Kconfig       |   2 +-
>   drivers/media/test-drivers/vivid/Kconfig      |   2 +-
>   drivers/media/tuners/Kconfig                  |   6 +-
>   drivers/media/tuners/e4000.c                  |   6 +-
>   drivers/media/tuners/fc2580.c                 |   6 +-
>   drivers/media/usb/airspy/Kconfig              |   2 +-
>   drivers/media/usb/au0828/Kconfig              |   6 +-
>   drivers/media/usb/cpia2/Kconfig               |   2 +-
>   drivers/media/usb/dvb-usb-v2/Kconfig          |   8 +-
>   drivers/media/usb/dvb-usb/Kconfig             |   4 +-
>   drivers/media/usb/gspca/Kconfig               |  96 +++----
>   drivers/media/usb/gspca/gl860/Kconfig         |   2 +-
>   drivers/media/usb/gspca/m5602/Kconfig         |   2 +-
>   drivers/media/usb/hackrf/Kconfig              |   2 +-
>   drivers/media/usb/hdpvr/Kconfig               |   2 +-
>   drivers/media/usb/msi2500/Kconfig             |   2 +-
>   drivers/media/usb/pvrusb2/Kconfig             |   2 +-
>   drivers/media/usb/pwc/Kconfig                 |   2 +-
>   drivers/media/usb/s2255/Kconfig               |   2 +-
>   drivers/media/usb/stkwebcam/Kconfig           |   2 +-
>   drivers/media/usb/usbtv/Kconfig               |   2 +-
>   drivers/media/usb/uvc/Kconfig                 |   2 +-
>   drivers/media/usb/zr364xx/Kconfig             |   2 +-
>   drivers/media/v4l2-core/Kconfig               |  12 +-
>   drivers/media/v4l2-core/Makefile              |   2 +-
>   drivers/staging/media/atomisp/Kconfig         |   2 +-
>   drivers/staging/media/atomisp/i2c/Kconfig     |  14 +-
>   drivers/staging/media/hantro/Kconfig          |   2 +-
>   drivers/staging/media/imx/Kconfig             |   2 +-
>   drivers/staging/media/ipu3/Kconfig            |   2 +-
>   drivers/staging/media/max96712/Kconfig        |   2 +-
>   drivers/staging/media/meson/vdec/Kconfig      |   2 +-
>   drivers/staging/media/omap4iss/Kconfig        |   2 +-
>   drivers/staging/media/rkvdec/Kconfig          |   2 +-
>   drivers/staging/media/sunxi/cedrus/Kconfig    |   2 +-
>   drivers/staging/media/tegra-video/Kconfig     |   2 +-
>   drivers/staging/media/zoran/Kconfig           |   2 +-
>   drivers/staging/most/video/Kconfig            |   2 +-
>   .../vc04_services/bcm2835-camera/Kconfig      |   2 +-
>   drivers/usb/gadget/Kconfig                    |   2 +-
>   drivers/usb/gadget/legacy/Kconfig             |   2 +-
>   sound/pci/Kconfig                             |   4 +-
>   116 files changed, 371 insertions(+), 376 deletions(-)


Reviewed-by: Neil Armstrong <narmstrong@baylibre.com> # for meson-vdec & meson-ge2d
