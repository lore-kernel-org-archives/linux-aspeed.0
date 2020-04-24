From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 24 Apr 2020 20:00:50 +0200
Subject: [PATCH 54/59] drm/aspeed: Drop aspeed_gfx->fbdev
In-Reply-To: <20200415074034.175360-55-daniel.vetter@ffwll.ch>
References: <20200415074034.175360-1-daniel.vetter@ffwll.ch>
 <20200415074034.175360-55-daniel.vetter@ffwll.ch>
Message-ID: <20200424180050.GJ7074@ravnborg.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Apr 15, 2020 at 09:40:29AM +0200, Daniel Vetter wrote:
> No longer used since the conversion to generic fbdev.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: linux-aspeed at lists.ozlabs.org
> Cc: linux-arm-kernel at lists.infradead.org
Acked-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  drivers/gpu/drm/aspeed/aspeed_gfx.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx.h b/drivers/gpu/drm/aspeed/aspeed_gfx.h
> index a10358bb61ec..adc02940de6f 100644
> --- a/drivers/gpu/drm/aspeed/aspeed_gfx.h
> +++ b/drivers/gpu/drm/aspeed/aspeed_gfx.h
> @@ -12,7 +12,6 @@ struct aspeed_gfx {
>  
>  	struct drm_simple_display_pipe	pipe;
>  	struct drm_connector		connector;
> -	struct drm_fbdev_cma		*fbdev;
>  };
>  
>  int aspeed_gfx_create_pipe(struct drm_device *drm);
> -- 
> 2.25.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
