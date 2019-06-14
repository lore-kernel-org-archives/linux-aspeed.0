From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 14 Jun 2019 23:36:06 +0200
Subject: [PATCH 06/59] drm/prime: Actually remove DRIVER_PRIME everywhere
In-Reply-To: <20190614203615.12639-7-daniel.vetter@ffwll.ch>
References: <20190614203615.12639-1-daniel.vetter@ffwll.ch>
 <20190614203615.12639-7-daniel.vetter@ffwll.ch>
Message-ID: <20190614213606.GB19476@ravnborg.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Daniel.

Minor nitpick..

> diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
> index 65d599065709..4fd09a9ad67a 100644
> --- a/drivers/gpu/drm/i915/i915_drv.c
> +++ b/drivers/gpu/drm/i915/i915_drv.c
> @@ -3193,7 +3193,7 @@ static struct drm_driver driver = {
>  	 * deal with them for Intel hardware.
>  	 */
>  	.driver_features =
> -	    DRIVER_GEM | DRIVER_PRIME |
> +	    DRIVER_GEM | 
>  	    DRIVER_RENDER | DRIVER_MODESET | DRIVER_ATOMIC | DRIVER_SYNCOBJ,
Adds a whitespace.

	Sam
