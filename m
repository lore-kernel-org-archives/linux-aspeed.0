From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 03 Apr 2019 21:04:44 -0400
Subject: [PATCH v3 3/3] MAINTAINERS: Add ASPEED BMC GFX DRM driver entry
In-Reply-To: <20190403001909.31637-4-joel@jms.id.au>
References: <20190403001909.31637-1-joel@jms.id.au>
 <20190403001909.31637-4-joel@jms.id.au>
Message-ID: <3c142c1e-e863-4f21-b313-3564e3a9d5d6@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 3 Apr 2019, at 10:49, Joel Stanley wrote:
> This hardware is found inside ASPEED Baseboard Management Controller
> (BMC) system on chips. It is called the 'SOC Display Controller' or 'GFX'.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Acked-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c18f5f10cf91..c3ad730e26f3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4909,6 +4909,14 @@ M:	Dave Airlie <airlied@redhat.com>
>  S:	Odd Fixes
>  F:	drivers/gpu/drm/ast/
>  
> +DRM DRIVER FOR ASPEED BMC GFX
> +M: 	Joel Stanley <joel@jms.id.au>
> +L:	linux-aspeed at lists.ozlabs.org
> +T:	git git://anongit.freedesktop.org/drm/drm-misc
> +S:	Supported
> +F:	drivers/gpu/drm/aspeed/
> +F:	Documentation/devicetree/bindings/gpu/aspeed-gfx.txt
> +
>  DRM DRIVER FOR BOCHS VIRTUAL GPU
>  M:	Gerd Hoffmann <kraxel@redhat.com>
>  L:	virtualization at lists.linux-foundation.org
> -- 
> 2.20.1
> 
>
