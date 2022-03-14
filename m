From: Jacopo Mondi <jacopo@jmondi.org>
Date: Mon, 14 Mar 2022 16:07:45 +0100
Subject: [PATCH] media: Kconfig: cleanup VIDEO_DEV dependencies
In-Reply-To: <42ae3d28d4d822f3e14db76b99f2f4c41688ae3e.1647155467.git.mchehab@kernel.org>
References: <42ae3d28d4d822f3e14db76b99f2f4c41688ae3e.1647155467.git.mchehab@kernel.org>
Message-ID: <20220314150745.ph2jpjpvdft3645v@uno.localdomain>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Mauro

On Sun, Mar 13, 2022 at 08:12:05AM +0100, Mauro Carvalho Chehab wrote:
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
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
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
>  drivers/media/platform/am437x/Kconfig         |   2 +-
>  drivers/media/platform/amphion/Kconfig        |   2 +-
>  drivers/media/platform/aspeed/Kconfig         |   2 +-
>  drivers/media/platform/atmel/Kconfig          |   8 +-
>  drivers/media/platform/cadence/Kconfig        |   4 +-
>  drivers/media/platform/coda/Kconfig           |   2 +-
>  drivers/media/platform/davinci/Kconfig        |  12 +-
>  drivers/media/platform/exynos-gsc/Kconfig     |   2 +-
>  drivers/media/platform/exynos4-is/Kconfig     |   2 +-
>  drivers/media/platform/intel/Kconfig          |   2 +-
>  drivers/media/platform/marvell-ccic/Kconfig   |   4 +-
>  drivers/media/platform/meson/ge2d/Kconfig     |   2 +-
>  drivers/media/platform/mtk-jpeg/Kconfig       |   2 +-
>  drivers/media/platform/mtk-mdp/Kconfig        |   2 +-
>  drivers/media/platform/mtk-vcodec/Kconfig     |   2 +-
>  drivers/media/platform/mtk-vpu/Kconfig        |   2 +-
>  drivers/media/platform/nxp/Kconfig            |   8 +-
>  drivers/media/platform/nxp/imx-jpeg/Kconfig   |   2 +-
>  drivers/media/platform/omap/Kconfig           |   2 +-
>  drivers/media/platform/omap3isp/Kconfig       |   2 +-
>  drivers/media/platform/qcom/camss/Kconfig     |   2 +-
>  drivers/media/platform/qcom/venus/Kconfig     |   2 +-
>  drivers/media/platform/renesas/Kconfig        |  12 +-
>  .../media/platform/renesas/rcar-vin/Kconfig   |   4 +-
>  drivers/media/platform/rockchip/rga/Kconfig   |   2 +-
>  .../media/platform/rockchip/rkisp1/Kconfig    |   2 +-
>  drivers/media/platform/s3c-camif/Kconfig      |   2 +-
>  drivers/media/platform/s5p-g2d/Kconfig        |   2 +-
>  drivers/media/platform/s5p-jpeg/Kconfig       |   2 +-
>  drivers/media/platform/s5p-mfc/Kconfig        |   2 +-
>  drivers/media/platform/sti/bdisp/Kconfig      |   2 +-
>  drivers/media/platform/sti/delta/Kconfig      |   2 +-
>  drivers/media/platform/sti/hva/Kconfig        |   2 +-
>  drivers/media/platform/stm32/Kconfig          |   4 +-
>  .../media/platform/sunxi/sun4i-csi/Kconfig    |   2 +-
>  .../media/platform/sunxi/sun6i-csi/Kconfig    |   2 +-
>  drivers/media/platform/sunxi/sun8i-di/Kconfig |   2 +-
>  .../media/platform/sunxi/sun8i-rotate/Kconfig |   2 +-
>  drivers/media/platform/tegra/vde/Kconfig      |   2 +-
>  drivers/media/platform/ti-vpe/Kconfig         |   4 +-
>  drivers/media/platform/via/Kconfig            |   2 +-
>  drivers/media/platform/xilinx/Kconfig         |   2 +-
>  drivers/media/radio/Kconfig                   |  54 ++--
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
>  116 files changed, 363 insertions(+), 368 deletions(-)
>
> diff --git a/drivers/input/rmi4/Kconfig b/drivers/input/rmi4/Kconfig
> index 16119f760d11..c0163b983ce6 100644
> --- a/drivers/input/rmi4/Kconfig
> +++ b/drivers/input/rmi4/Kconfig
> @@ -110,7 +110,7 @@ config RMI4_F3A
>
>  config RMI4_F54
>  	bool "RMI4 Function 54 (Analog diagnostics)"
> -	depends on VIDEO_V4L2=y || (RMI4_CORE=m && VIDEO_V4L2=m)
> +	depends on VIDEO_DEV=y || (RMI4_CORE=m && VIDEO_DEV=m)
>  	select VIDEOBUF2_VMALLOC
>  	select RMI4_F55
>  	help
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 2f6adfb7b938..ff7794cecf69 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -131,7 +131,7 @@ config TOUCHSCREEN_ATMEL_MXT
>  config TOUCHSCREEN_ATMEL_MXT_T37
>  	bool "Support T37 Diagnostic Data"
>  	depends on TOUCHSCREEN_ATMEL_MXT
> -	depends on VIDEO_V4L2=y || (TOUCHSCREEN_ATMEL_MXT=m && VIDEO_V4L2=m)
> +	depends on VIDEO_DEV=y || (TOUCHSCREEN_ATMEL_MXT=m && VIDEO_DEV=m)
>  	select VIDEOBUF2_VMALLOC
>  	help
>  	  Say Y here if you want support to output data from the T37
> @@ -1252,7 +1252,7 @@ config TOUCHSCREEN_SUN4I
>  config TOUCHSCREEN_SUR40
>  	tristate "Samsung SUR40 (Surface 2.0/PixelSense) touchscreen"
>  	depends on USB && MEDIA_USB_SUPPORT && HAS_DMA
> -	depends on VIDEO_V4L2
> +	depends on VIDEO_DEV
>  	select VIDEOBUF2_DMA_SG
>  	help
>  	  Say Y here if you want support for the Samsung SUR40 touchscreen
> diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
> index 01b536863657..2d02d9a44b94 100644
> --- a/drivers/media/Kconfig
> +++ b/drivers/media/Kconfig
> @@ -160,6 +160,9 @@ menu "Media core support"
>  config VIDEO_DEV
>  	tristate "Video4Linux core"
>  	default MEDIA_CAMERA_SUPPORT || MEDIA_ANALOG_TV_SUPPORT || MEDIA_RADIO_SUPPORT || MEDIA_SDR_SUPPORT || MEDIA_PLATFORM_SUPPORT || MEDIA_TEST_SUPPORT
> +	depends on (I2C || I2C=n)

Is this I2C || I2C=n intentional ?

> +	select RATIONAL
> +	select VIDEOBUF2_V4L2 if VIDEOBUF2_CORE
>  	help
>  	  Enables the V4L2 API, used by cameras, analog TV, video grabbers,
>  	  radio devices and by some input devices.
> diff --git a/drivers/media/common/saa7146/Kconfig b/drivers/media/common/saa7146/Kconfig
> index 3e85c0c3fd9a..a0aa155e5d85 100644
> --- a/drivers/media/common/saa7146/Kconfig
> +++ b/drivers/media/common/saa7146/Kconfig
> @@ -5,6 +5,6 @@ config VIDEO_SAA7146
>
>  config VIDEO_SAA7146_VV
>  	tristate
> -	depends on VIDEO_V4L2
> +	depends on VIDEO_DEV
>  	select VIDEOBUF_DMA_SG
>  	select VIDEO_SAA7146
> diff --git a/drivers/media/dvb-core/Kconfig b/drivers/media/dvb-core/Kconfig
> index 6ffac618417b..8b3f2d53cd62 100644
> --- a/drivers/media/dvb-core/Kconfig
> +++ b/drivers/media/dvb-core/Kconfig
> @@ -6,7 +6,7 @@
>  config DVB_MMAP
>  	bool "Enable DVB memory-mapped API (EXPERIMENTAL)"
>  	depends on DVB_CORE
> -	depends on VIDEO_V4L2=y || VIDEO_V4L2=DVB_CORE
> +	depends on VIDEO_DEV=y || VIDEO_DEV=DVB_CORE
>  	select VIDEOBUF2_VMALLOC
>  	help
>  	  This option enables DVB experimental memory-mapped API, which
> diff --git a/drivers/media/dvb-frontends/Kconfig b/drivers/media/dvb-frontends/Kconfig
> index 2c1ed98d43c5..4101f9b1e731 100644
> --- a/drivers/media/dvb-frontends/Kconfig
> +++ b/drivers/media/dvb-frontends/Kconfig
> @@ -510,7 +510,7 @@ config DVB_RTL2832
>
>  config DVB_RTL2832_SDR
>  	tristate "Realtek RTL2832 SDR"
> -	depends on DVB_CORE && I2C && I2C_MUX && VIDEO_V4L2 && MEDIA_SDR_SUPPORT && USB
> +	depends on DVB_CORE && I2C && I2C_MUX && VIDEO_DEV && MEDIA_SDR_SUPPORT && USB
>  	select DVB_RTL2832
>  	select VIDEOBUF2_VMALLOC
>  	default m if !MEDIA_SUBDRV_AUTOSELECT
> @@ -681,7 +681,7 @@ config DVB_AU8522_DTV
>
>  config DVB_AU8522_V4L
>  	tristate "Auvitek AU8522 based ATV demod"
> -	depends on VIDEO_V4L2 && DVB_CORE && I2C
> +	depends on VIDEO_DEV && DVB_CORE && I2C
>  	select DVB_AU8522
>  	default m if !MEDIA_SUBDRV_AUTOSELECT
>  	help
> diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
> index e7194c1be4d2..5abc169f0a5c 100644
> --- a/drivers/media/i2c/Kconfig
> +++ b/drivers/media/i2c/Kconfig
> @@ -3,7 +3,7 @@
>  # Multimedia Video device configuration
>  #
>
> -if VIDEO_V4L2
> +if VIDEO_DEV
>
>  comment "IR I2C driver auto-selected by 'Autoselect ancillary drivers'"
>  	depends on MEDIA_SUBDRV_AUTOSELECT && I2C && RC_CORE
> @@ -36,7 +36,7 @@ menu "Audio decoders, processors and mixers"
>
>  config VIDEO_TVAUDIO
>  	tristate "Simple audio decoder chips"
> -	depends on VIDEO_V4L2 && I2C
> +	depends on VIDEO_DEV && I2C

Are there symbols in drivers/media/i2c that do not depend on I2C ?
Could we make the menu conditional on I2C presence ?

>  	help
>  	  Support for several audio decoder chips found on some bt8xx boards:
>  	  Philips: tda9840, tda9873h, tda9874h/a, tda9850, tda985x, tea6300,
> @@ -48,7 +48,7 @@ config VIDEO_TVAUDIO

[snip]

> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config VIDEO_TW5864
>  	tristate "Techwell TW5864 video/audio grabber and encoder"
> -	depends on VIDEO_DEV && PCI && VIDEO_V4L2
> +	depends on VIDEO_DEV && PCI && VIDEO_DEV

Double VIDEO_DEV

>  	select VIDEOBUF2_DMA_CONTIG
>  	help
>  	  Support for boards based on Techwell TW5864 chip which provides
> diff --git a/drivers/media/pci/tw68/Kconfig b/drivers/media/pci/tw68/Kconfig
> index af0cb60337bb..ef29be7db493 100644
> --- a/drivers/media/pci/tw68/Kconfig
> +++ b/drivers/media/pci/tw68/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config VIDEO_TW68
>  	tristate "Techwell tw68x Video For Linux"
> -	depends on VIDEO_DEV && PCI && VIDEO_V4L2
> +	depends on VIDEO_DEV && PCI && VIDEO_DEV

Same here

>  	select VIDEOBUF2_DMA_SG
>  	help
>  	  Support for Techwell tw68xx based frame grabber boards.

[snip]

> diff --git a/drivers/media/platform/amphion/Kconfig b/drivers/media/platform/amphion/Kconfig
> index 13899649f766..e9ddca7a9e4a 100644
> --- a/drivers/media/platform/amphion/Kconfig
> +++ b/drivers/media/platform/amphion/Kconfig
> @@ -5,7 +5,7 @@ config VIDEO_AMPHION_VPU
>  	depends on ARCH_MXC || COMPILE_TEST
>  	depends on MEDIA_SUPPORT
>  	depends on VIDEO_DEV
> -	depends on VIDEO_V4L2
> +	depends on VIDEO_DEV

VIDEO_DEV already listed

>  	select MEDIA_CONTROLLER
>  	select V4L2_MEM2MEM_DEV
>  	select VIDEOBUF2_DMA_CONTIG

[snip]

>
> -if RADIO_ADAPTERS && VIDEO_V4L2
> +if RADIO_ADAPTERS && VIDEO_DEV
>
>  config RADIO_TEA575X
>  	tristate
> @@ -20,13 +20,13 @@ source "drivers/media/radio/si470x/Kconfig"
>
>  config RADIO_SI4713
>  	tristate "Silicon Labs Si4713 FM Radio with RDS Transmitter support"
> -	depends on VIDEO_V4L2
> +	depends on VIDEO_DEV

Isn't this menu section already conditional to VIDEO_DEV

[snip]

With the above minors fixed

Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>

Thanks
   j
