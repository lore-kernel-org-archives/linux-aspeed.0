From: Jernej Škrabec <jernej.skrabec@gmail.com>
Date: Thu, 21 Jul 2022 17:03:56 +0200
Subject: [PATCH 1/6] ARM: refresh defconfig files
In-Reply-To: <20220721141325.2413920-2-arnd@kernel.org>
References: <20220721141325.2413920-1-arnd@kernel.org> <20220721141325.2413920-2-arnd@kernel.org>
Message-ID: <2073800.OBFZWjSADL@jernej-laptop>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dne ?etrtek, 21. julij 2022 ob 16:13:20 CEST je Arnd Bergmann napisal(a):
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A lot of Kconfig options have changed over the years, and we tend
> to not do a blind 'make defconfig' to refresh the files, to ensure
> we catch options that should not have gone away.
> 
> I used some a bit of scripting to only rework the bits where an
> option moved around in any of the defconfig files, without also
> dropping any of the other lines, to make it clearer which options
> we no longer have.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/configs/am200epdkit_defconfig    |  26 ++---
>  arch/arm/configs/aspeed_g4_defconfig      |  16 +--
>  arch/arm/configs/aspeed_g5_defconfig      |  16 +--
>  arch/arm/configs/assabet_defconfig        |   8 +-
>  arch/arm/configs/at91_dt_defconfig        |  10 +-
>  arch/arm/configs/axm55xx_defconfig        |  22 ++--
>  arch/arm/configs/badge4_defconfig         |   8 +-
>  arch/arm/configs/bcm2835_defconfig        |  36 +++----
>  arch/arm/configs/cerfcube_defconfig       |  16 +--
>  arch/arm/configs/clps711x_defconfig       |   2 +-
>  arch/arm/configs/cm_x300_defconfig        |  26 ++---
>  arch/arm/configs/cns3420vb_defconfig      |  18 ++--
>  arch/arm/configs/colibri_pxa270_defconfig |  32 +++---
>  arch/arm/configs/colibri_pxa300_defconfig |  10 +-
>  arch/arm/configs/collie_defconfig         |  20 ++--
>  arch/arm/configs/corgi_defconfig          |  44 ++++----
>  arch/arm/configs/davinci_all_defconfig    |  26 ++---
>  arch/arm/configs/dove_defconfig           |  28 ++---
>  arch/arm/configs/ep93xx_defconfig         |  16 +--
>  arch/arm/configs/eseries_pxa_defconfig    |  26 ++---
>  arch/arm/configs/exynos_defconfig         |  20 ++--
>  arch/arm/configs/ezx_defconfig            |  72 ++++++-------
>  arch/arm/configs/footbridge_defconfig     |  14 +--
>  arch/arm/configs/h3600_defconfig          |  10 +-
>  arch/arm/configs/h5000_defconfig          |  18 ++--
>  arch/arm/configs/hackkit_defconfig        |   4 +-
>  arch/arm/configs/hisi_defconfig           |  24 ++---
>  arch/arm/configs/imx_v4_v5_defconfig      |   8 +-
>  arch/arm/configs/imx_v6_v7_defconfig      |   8 +-
>  arch/arm/configs/integrator_defconfig     |   2 +-
>  arch/arm/configs/iop32x_defconfig         |  20 ++--
>  arch/arm/configs/jornada720_defconfig     |  10 +-
>  arch/arm/configs/keystone_defconfig       |  62 +++++------
>  arch/arm/configs/lart_defconfig           |   6 +-
>  arch/arm/configs/lpc18xx_defconfig        |  12 +--
>  arch/arm/configs/lpc32xx_defconfig        |   8 +-
>  arch/arm/configs/lpd270_defconfig         |   6 +-
>  arch/arm/configs/lubbock_defconfig        |  10 +-
>  arch/arm/configs/magician_defconfig       |  30 +++---
>  arch/arm/configs/mainstone_defconfig      |   4 +-
>  arch/arm/configs/milbeaut_m10v_defconfig  |   6 +-
>  arch/arm/configs/mini2440_defconfig       |   6 +-
>  arch/arm/configs/mmp2_defconfig           |  28 ++---
>  arch/arm/configs/moxart_defconfig         |  18 ++--
>  arch/arm/configs/mps2_defconfig           |  14 +--
>  arch/arm/configs/multi_v4t_defconfig      |   4 +-
>  arch/arm/configs/multi_v5_defconfig       |  12 +--
>  arch/arm/configs/multi_v7_defconfig       |  62 +++++------
>  arch/arm/configs/mv78xx0_defconfig        |  32 +++---
>  arch/arm/configs/mvebu_v5_defconfig       |  28 ++---
>  arch/arm/configs/mvebu_v7_defconfig       |   2 +-
>  arch/arm/configs/mxs_defconfig            |   4 +-
>  arch/arm/configs/neponset_defconfig       |  24 ++---
>  arch/arm/configs/netwinder_defconfig      |  10 +-
>  arch/arm/configs/nhk8815_defconfig        |   6 +-
>  arch/arm/configs/omap1_defconfig          |  74 ++++++-------
>  arch/arm/configs/omap2plus_defconfig      |  16 +--
>  arch/arm/configs/orion5x_defconfig        |  32 +++---
>  arch/arm/configs/oxnas_v6_defconfig       |  14 +--
>  arch/arm/configs/palmz72_defconfig        |  14 +--
>  arch/arm/configs/pcm027_defconfig         |  22 ++--
>  arch/arm/configs/pleb_defconfig           |   6 +-
>  arch/arm/configs/pxa168_defconfig         |  18 ++--
>  arch/arm/configs/pxa255-idp_defconfig     |  10 +-
>  arch/arm/configs/pxa3xx_defconfig         |  18 ++--
>  arch/arm/configs/pxa910_defconfig         |  22 ++--
>  arch/arm/configs/pxa_defconfig            | 126 +++++++++++-----------
>  arch/arm/configs/qcom_defconfig           |  60 +++++------
>  arch/arm/configs/realview_defconfig       |   8 +-
>  arch/arm/configs/rpc_defconfig            |  18 ++--
>  arch/arm/configs/s3c2410_defconfig        |   8 +-
>  arch/arm/configs/s3c6400_defconfig        |   2 +-
>  arch/arm/configs/s5pv210_defconfig        |   4 +-
>  arch/arm/configs/sama5_defconfig          |   8 +-
>  arch/arm/configs/sama7_defconfig          |   8 +-
>  arch/arm/configs/shannon_defconfig        |   8 +-
>  arch/arm/configs/simpad_defconfig         |  18 ++--
>  arch/arm/configs/socfpga_defconfig        |   4 +-
>  arch/arm/configs/spear13xx_defconfig      |  16 +--
>  arch/arm/configs/spear3xx_defconfig       |  10 +-
>  arch/arm/configs/spear6xx_defconfig       |   8 +-
>  arch/arm/configs/spitz_defconfig          |  44 ++++----
>  arch/arm/configs/stm32_defconfig          |  14 +--
>  arch/arm/configs/sunxi_defconfig          |   2 +-

For sunxi:
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>  arch/arm/configs/tct_hammer_defconfig     |  12 +--
>  arch/arm/configs/tegra_defconfig          |  18 ++--
>  arch/arm/configs/trizeps4_defconfig       |  58 +++++-----
>  arch/arm/configs/u8500_defconfig          |   2 +-
>  arch/arm/configs/versatile_defconfig      |   4 +-
>  arch/arm/configs/vexpress_defconfig       |   4 +-
>  arch/arm/configs/vf610m4_defconfig        |   2 +-
>  arch/arm/configs/viper_defconfig          |  28 ++---
>  arch/arm/configs/vt8500_v6_v7_defconfig   |   2 +-
>  arch/arm/configs/xcep_defconfig           |  30 +++---
>  arch/arm/configs/zeus_defconfig           |  26 ++---



