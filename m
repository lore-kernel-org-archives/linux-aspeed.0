From: Chrisanthus, Anitha <anitha.chrisanthus@intel.com>
Date: Mon, 6 Mar 2023 17:18:50 +0000
Subject: [PATCH 09/22] drm/kmb: Use GEM DMA fbdev emulation
In-Reply-To: <20230301153101.4282-10-tzimmermann@suse.de>
References: <20230301153101.4282-1-tzimmermann@suse.de>
 <20230301153101.4282-10-tzimmermann@suse.de>
Message-ID: <BY5PR11MB418232ED63F992E309C9B2D18CB69@BY5PR11MB4182.namprd11.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Acked-by: Anitha Chrisanthus <anitha.chrisanthus@intel.com>

> -----Original Message-----
> From: Thomas Zimmermann <tzimmermann@suse.de>
> Sent: Wednesday, March 1, 2023 7:31 AM
> To: javierm at redhat.com; maarten.lankhorst at linux.intel.com;
> mripard at kernel.org; airlied at gmail.com; daniel at ffwll.ch; andrew at aj.id.au;
> laurentiu.palcu at oss.nxp.com; l.stach at pengutronix.de;
> shawnguo at kernel.org; s.hauer at pengutronix.de; kernel at pengutronix.de;
> festevam at gmail.com; linux-imx at nxp.com; p.zabel at pengutronix.de;
> Chrisanthus, Anitha <anitha.chrisanthus@intel.com>;
> edmund.j.dea at intel.com; khilman at baylibre.com; jbrunet at baylibre.com;
> martin.blumenstingl at googlemail.com; alain.volmat at foss.st.com;
> yannick.fertre at foss.st.com; raphael.gallais-pou at foss.st.com;
> philippe.cornu at foss.st.com; mcoquelin.stm32 at gmail.com;
> alexandre.torgue at foss.st.com; jernej.skrabec at gmail.com;
> samuel at sholland.org; jyri.sarha at iki.fi; tomba at kernel.org;
> linus.walleij at linaro.org; hyun.kwon at xilinx.com;
> laurent.pinchart at ideasonboard.com
> Cc: dri-devel at lists.freedesktop.org; linux-aspeed at lists.ozlabs.org; linux-arm-
> kernel at lists.infradead.org; linux-amlogic at lists.infradead.org; linux-
> stm32 at st-md-mailman.stormreply.com; linux-sunxi at lists.linux.dev; Thomas
> Zimmermann <tzimmermann@suse.de>
> Subject: [PATCH 09/22] drm/kmb: Use GEM DMA fbdev emulation
> 
> Use the fbdev emulation that is optimized for DMA helpers. Avoids
> possible shadow buffering and makes the code simpler.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/kmb/kmb_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/kmb/kmb_drv.c
> b/drivers/gpu/drm/kmb/kmb_drv.c
> index d29c678f6c91..24035b53441c 100644
> --- a/drivers/gpu/drm/kmb/kmb_drv.c
> +++ b/drivers/gpu/drm/kmb/kmb_drv.c
> @@ -15,7 +15,7 @@
> 
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_drv.h>
> -#include <drm/drm_fbdev_generic.h>
> +#include <drm/drm_fbdev_dma.h>
>  #include <drm/drm_gem_dma_helper.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
>  #include <drm/drm_module.h>
> @@ -562,7 +562,7 @@ static int kmb_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_register;
> 
> -	drm_fbdev_generic_setup(&kmb->drm, 0);
> +	drm_fbdev_dma_setup(&kmb->drm, 0);
> 
>  	return 0;
> 
> --
> 2.39.2

