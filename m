From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 5 Jun 2020 11:37:29 +0300
Subject: [PATCH v3 43/43] drm: Remove struct drm_driver.gem_print_info
In-Reply-To: <20200605073247.4057-44-tzimmermann@suse.de>
References: <20200605073247.4057-1-tzimmermann@suse.de>
 <20200605073247.4057-44-tzimmermann@suse.de>
Message-ID: <20200605083729.GA11426@pendragon.ideasonboard.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Thomas,

Thank you for the patch.

On Fri, Jun 05, 2020 at 09:32:47AM +0200, Thomas Zimmermann wrote:
> The .gem_print_info callback in struct drm_driver is obsolete and has
> no users left. Remove it.

I like code removal :-) Looking forward to the removal of more
GEM-related fields from struct drm_driver.

> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Suggested-by: Emil Velikov <emil.velikov@collabora.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/drm_gem.c |  2 --
>  include/drm/drm_drv.h     | 17 -----------------
>  2 files changed, 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index efc0367841e2b..08b3fa27ec406 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -1191,8 +1191,6 @@ void drm_gem_print_info(struct drm_printer *p, unsigned int indent,
>  
>  	if (obj->funcs && obj->funcs->print_info)
>  		obj->funcs->print_info(p, indent, obj);
> -	else if (obj->dev->driver->gem_print_info)
> -		obj->dev->driver->gem_print_info(p, indent, obj);
>  }
>  
>  int drm_gem_pin(struct drm_gem_object *obj)
> diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> index bb924cddc09c1..8f110a28b6a23 100644
> --- a/include/drm/drm_drv.h
> +++ b/include/drm/drm_drv.h
> @@ -353,23 +353,6 @@ struct drm_driver {
>  	 */
>  	void (*gem_close_object) (struct drm_gem_object *, struct drm_file *);
>  
> -	/**
> -	 * @gem_print_info:
> -	 *
> -	 * This callback is deprecated in favour of
> -	 * &drm_gem_object_funcs.print_info.
> -	 *
> -	 * If driver subclasses struct &drm_gem_object, it can implement this
> -	 * optional hook for printing additional driver specific info.
> -	 *
> -	 * drm_printf_indent() should be used in the callback passing it the
> -	 * indent argument.
> -	 *
> -	 * This callback is called from drm_gem_print_info().
> -	 */
> -	void (*gem_print_info)(struct drm_printer *p, unsigned int indent,
> -			       const struct drm_gem_object *obj);
> -
>  	/**
>  	 * @gem_create_object: constructor for gem objects
>  	 *

-- 
Regards,

Laurent Pinchart
