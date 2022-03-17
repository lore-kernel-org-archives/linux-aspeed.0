From: Lukasz Stelmach <l.stelmach@samsung.com>
Date: Thu, 17 Mar 2022 20:21:35 +0100
Subject: [PATCH v2 65/67] media: Kconfig: cleanup VIDEO_DEV dependencies
In-Reply-To: <d5b6678363c4374436014137fecc22ff666e3ebc.1647274407.git.mchehab@kernel.org>
 (Mauro Carvalho Chehab's message of "Mon, 14 Mar 2022 17:35:00 +0100")
References: <d5b6678363c4374436014137fecc22ff666e3ebc.1647274407.git.mchehab@kernel.org>
 <CGME20220317192136eucas1p185dfbf79e792ebdc4c5614a90c1b0cd8@eucas1p1.samsung.com>
Message-ID: <dleftj1qz0mlkw.fsf%l.stelmach@samsung.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

It was <2022-03-14 pon 17:35>, when Mauro Carvalho Chehab wrote:
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
> Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
>
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH v2 00/67] at: https://lore.kernel.org/all/cover.1647274406.git.mchehab at kernel.org/
>
>  drivers/input/rmi4/Kconfig                    |   2 +-
>  drivers/input/touchscreen/Kconfig             |   4 +-
>  drivers/media/Kconfig                         |   3 +
>  drivers/media/common/saa7146/Kconfig          |   2 +-
>  drivers/media/dvb-core/Kconfig                |   2 +-
>  drivers/media/dvb-frontends/Kconfig           |   4 +-
>  drivers/media/i2c/Kconfig                     | 250 +++++++++---------
>  drivers/media/i2c/ccs/Kconfig                 |   2 +-
>  drivers/media/i2c/cx25840/Kconfig             |   2 +-
>  drivers/media/i2c/et8ek8/Kconfig              |   2 +-
>  drivers/media/i2c/m5mols/Kconfig              |   2 +-
>  drivers/media/pci/Kconfig                     |   2 +-
>  drivers/media/pci/bt8xx/Kconfig               |   2 +-
>  drivers/media/pci/cobalt/Kconfig              |   2 +-
>  drivers/media/pci/cx18/Kconfig                |   2 +-
>  drivers/media/pci/dt3155/Kconfig              |   2 +-
>  drivers/media/pci/intel/ipu3/Kconfig          |   2 +-
>  drivers/media/pci/ivtv/Kconfig                |   2 +-
>  drivers/media/pci/meye/Kconfig                |   2 +-
>  drivers/media/pci/saa7146/Kconfig             |   6 +-
>  drivers/media/pci/sta2x11/Kconfig             |   2 +-
>  drivers/media/pci/tw5864/Kconfig              |   2 +-
>  drivers/media/pci/tw68/Kconfig                |   2 +-
>  drivers/media/pci/tw686x/Kconfig              |   2 +-
>  drivers/media/platform/Kconfig                |   6 +-
>  drivers/media/platform/allegro-dvt/Kconfig    |   2 +-
>  .../platform/allwinner/sun4i-csi/Kconfig      |   2 +-
>  .../platform/allwinner/sun6i-csi/Kconfig      |   2 +-
>  .../media/platform/allwinner/sun8i-di/Kconfig |   2 +-
>  .../platform/allwinner/sun8i-rotate/Kconfig   |   2 +-
>  .../media/platform/amlogic/meson-ge2d/Kconfig |   2 +-
>  drivers/media/platform/amphion/Kconfig        |   1 -
>  drivers/media/platform/aspeed/Kconfig         |   2 +-
>  drivers/media/platform/atmel/Kconfig          |   8 +-
>  drivers/media/platform/cadence/Kconfig        |   4 +-
>  drivers/media/platform/chips-media/Kconfig    |   2 +-
>  drivers/media/platform/intel/Kconfig          |   2 +-
>  drivers/media/platform/marvell/Kconfig        |   4 +-
>  .../media/platform/mediatek/mtk-jpeg/Kconfig  |   2 +-
>  .../media/platform/mediatek/mtk-mdp/Kconfig   |   2 +-
>  .../platform/mediatek/mtk-vcodec/Kconfig      |   2 +-
>  .../media/platform/mediatek/mtk-vpu/Kconfig   |   2 +-
>  .../media/platform/nvidia/tegra-vde/Kconfig   |   2 +-
>  drivers/media/platform/nxp/Kconfig            |   6 +-
>  drivers/media/platform/nxp/imx-jpeg/Kconfig   |   2 +-
>  drivers/media/platform/qcom/camss/Kconfig     |   2 +-
>  drivers/media/platform/qcom/venus/Kconfig     |   2 +-
>  drivers/media/platform/renesas/Kconfig        |  30 +--
>  .../media/platform/renesas/rcar-vin/Kconfig   |   4 +-
>  drivers/media/platform/rockchip/rga/Kconfig   |   2 +-
>  .../media/platform/rockchip/rkisp1/Kconfig    |   2 +-
>  .../media/platform/samsung/exynos-gsc/Kconfig |   2 +-
>  .../media/platform/samsung/exynos4-is/Kconfig |   2 +-
>  .../media/platform/samsung/s3c-camif/Kconfig  |   2 +-
>  .../media/platform/samsung/s5p-g2d/Kconfig    |   2 +-
>  .../media/platform/samsung/s5p-jpeg/Kconfig   |   2 +-
>  .../media/platform/samsung/s5p-mfc/Kconfig    |   2 +-
>  drivers/media/platform/stm/sti/bdisp/Kconfig  |   2 +-
>  drivers/media/platform/stm/sti/delta/Kconfig  |   2 +-
>  drivers/media/platform/stm/sti/hva/Kconfig    |   2 +-
>  drivers/media/platform/stm/stm32/Kconfig      |   4 +-
>  drivers/media/platform/ti/am437x/Kconfig      |   2 +-
>  drivers/media/platform/ti/davinci/Kconfig     |  12 +-
>  drivers/media/platform/ti/omap/Kconfig        |   2 +-
>  drivers/media/platform/ti/omap3isp/Kconfig    |   2 +-
>  drivers/media/platform/via/Kconfig            |   2 +-
>  drivers/media/platform/xilinx/Kconfig         |   2 +-
>  drivers/media/radio/Kconfig                   |  42 ++-
>  drivers/media/radio/si470x/Kconfig            |   2 +-
>  drivers/media/radio/wl128x/Kconfig            |   2 +-
>  drivers/media/spi/Kconfig                     |   4 +-
>  drivers/media/test-drivers/Kconfig            |   2 +-
>  drivers/media/test-drivers/vicodec/Kconfig    |   2 +-
>  drivers/media/test-drivers/vimc/Kconfig       |   2 +-
>  drivers/media/test-drivers/vivid/Kconfig      |   2 +-
>  drivers/media/tuners/Kconfig                  |   6 +-
>  drivers/media/tuners/e4000.c                  |   6 +-
>  drivers/media/tuners/fc2580.c                 |   6 +-
>  drivers/media/usb/airspy/Kconfig              |   2 +-
>  drivers/media/usb/au0828/Kconfig              |   6 +-
>  drivers/media/usb/cpia2/Kconfig               |   2 +-
>  drivers/media/usb/dvb-usb-v2/Kconfig          |   8 +-
>  drivers/media/usb/dvb-usb/Kconfig             |   4 +-
>  drivers/media/usb/gspca/Kconfig               |  96 +++----
>  drivers/media/usb/gspca/gl860/Kconfig         |   2 +-
>  drivers/media/usb/gspca/m5602/Kconfig         |   2 +-
>  drivers/media/usb/hackrf/Kconfig              |   2 +-
>  drivers/media/usb/hdpvr/Kconfig               |   2 +-
>  drivers/media/usb/msi2500/Kconfig             |   2 +-
>  drivers/media/usb/pvrusb2/Kconfig             |   2 +-
>  drivers/media/usb/pwc/Kconfig                 |   2 +-
>  drivers/media/usb/s2255/Kconfig               |   2 +-
>  drivers/media/usb/stkwebcam/Kconfig           |   2 +-
>  drivers/media/usb/usbtv/Kconfig               |   2 +-
>  drivers/media/usb/uvc/Kconfig                 |   2 +-
>  drivers/media/usb/zr364xx/Kconfig             |   2 +-
>  drivers/media/v4l2-core/Kconfig               |  12 +-
>  drivers/media/v4l2-core/Makefile              |   2 +-
>  drivers/staging/media/atomisp/Kconfig         |   2 +-
>  drivers/staging/media/atomisp/i2c/Kconfig     |  14 +-
>  drivers/staging/media/hantro/Kconfig          |   2 +-
>  drivers/staging/media/imx/Kconfig             |   2 +-
>  drivers/staging/media/ipu3/Kconfig            |   2 +-
>  drivers/staging/media/max96712/Kconfig        |   2 +-
>  drivers/staging/media/meson/vdec/Kconfig      |   2 +-
>  drivers/staging/media/omap4iss/Kconfig        |   2 +-
>  drivers/staging/media/rkvdec/Kconfig          |   2 +-
>  drivers/staging/media/sunxi/cedrus/Kconfig    |   2 +-
>  drivers/staging/media/tegra-video/Kconfig     |   2 +-
>  drivers/staging/media/zoran/Kconfig           |   2 +-
>  drivers/staging/most/video/Kconfig            |   2 +-
>  .../vc04_services/bcm2835-camera/Kconfig      |   2 +-
>  drivers/usb/gadget/Kconfig                    |   2 +-
>  drivers/usb/gadget/legacy/Kconfig             |   2 +-
>  sound/pci/Kconfig                             |   4 +-
>  115 files changed, 356 insertions(+), 374 deletions(-)
>

Acked-by: ?ukasz Stelmach <l.stelmach@samsung.com>

[...]


> diff --git a/drivers/media/platform/samsung/s5p-g2d/Kconfig b/drivers/media/platform/samsung/s5p-g2d/Kconfig
> index 9bc9d90a666a..28ab88fc2d7c 100644
> --- a/drivers/media/platform/samsung/s5p-g2d/Kconfig
> +++ b/drivers/media/platform/samsung/s5p-g2d/Kconfig
> @@ -1,7 +1,7 @@
>  config VIDEO_SAMSUNG_S5P_G2D
>  	tristate "Samsung S5P and EXYNOS4 G2D 2d graphics accelerator driver"
>  	depends on V4L_MEM2MEM_DRIVERS
> -	depends on VIDEO_DEV && VIDEO_V4L2
> +	depends on VIDEO_DEV
>  	depends on ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
>  	select VIDEOBUF2_DMA_CONTIG
>  	select V4L2_MEM2MEM_DEV

[...]


-- 
?ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 487 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20220317/0ce6c9bf/attachment.sig>
