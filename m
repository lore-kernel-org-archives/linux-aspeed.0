From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 16 Jan 2023 21:15:47 +0100
Subject: [PATCH 02/22] drm: Remove unnecessary include statements for
 drm_crtc_helper.h
In-Reply-To: <20230116131235.18917-3-tzimmermann@suse.de>
References: <20230116131235.18917-1-tzimmermann@suse.de>
 <20230116131235.18917-3-tzimmermann@suse.de>
Message-ID: <Y8Wwcy3LuknhDQz1@ravnborg.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Thomas.

On Mon, Jan 16, 2023 at 02:12:15PM +0100, Thomas Zimmermann wrote:
> Several DRM core and helper source files include drm_crtc_helper.h
> without needing it or only to get its transitive include statements;
> leading to unnecessary compile-time dependencies.
> 
> Directly include required headers and drop drm_crtc_helper.h where
> possible. The header file, drm_fixed.h, includes <linux/kernel.h>
> for lower_32_bits().
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/drm_crtc_helper.c  | 1 -
>  drivers/gpu/drm/drm_lease.c        | 2 +-
>  drivers/gpu/drm/drm_plane_helper.c | 1 -
>  include/drm/drm_fixed.h            | 1 +
>  4 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc_helper.c
> index a209659a996c..e7a23e18140c 100644
> --- a/drivers/gpu/drm/drm_crtc_helper.c
> +++ b/drivers/gpu/drm/drm_crtc_helper.c
> @@ -39,7 +39,6 @@
>  #include <drm/drm_atomic_uapi.h>
>  #include <drm/drm_bridge.h>
>  #include <drm/drm_crtc.h>
> -#include <drm/drm_crtc_helper.h>

drm_crtc_helper.c may not require drm/drm_crtc_helper.h, but it should
include it so we get a warning in case there is a mismatch between the
header file and the implementation.
I think sparse would also complain that the function is not declared
or something like that.

With this fixed:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

>  #include <drm/drm_drv.h>
>  #include <drm/drm_edid.h>
>  #include <drm/drm_encoder.h>
> diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
> index 08ab75303a00..150fe1555068 100644
> --- a/drivers/gpu/drm/drm_lease.c
> +++ b/drivers/gpu/drm/drm_lease.c
> @@ -6,7 +6,7 @@
>  #include <linux/uaccess.h>
>  
>  #include <drm/drm_auth.h>
> -#include <drm/drm_crtc_helper.h>
> +#include <drm/drm_crtc.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_file.h>
>  #include <drm/drm_lease.h>
> diff --git a/drivers/gpu/drm/drm_plane_helper.c b/drivers/gpu/drm/drm_plane_helper.c
> index ba6a9136a065..c91e454eba09 100644
> --- a/drivers/gpu/drm/drm_plane_helper.c
> +++ b/drivers/gpu/drm/drm_plane_helper.c
> @@ -28,7 +28,6 @@
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_atomic_uapi.h>
> -#include <drm/drm_crtc_helper.h>
>  #include <drm/drm_device.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_encoder.h>
> diff --git a/include/drm/drm_fixed.h b/include/drm/drm_fixed.h
> index 553210c02ee0..255645c1f9a8 100644
> --- a/include/drm/drm_fixed.h
> +++ b/include/drm/drm_fixed.h
> @@ -25,6 +25,7 @@
>  #ifndef DRM_FIXED_H
>  #define DRM_FIXED_H
>  
> +#include <linux/kernel.h>
>  #include <linux/math64.h>
>  
>  typedef union dfixed {
> -- 
> 2.39.0
