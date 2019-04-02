From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 2 Apr 2019 08:25:55 +0200
Subject: [PATCH v2 2/3] drm: Add ASPEED GFX driver
In-Reply-To: <20190402021933.13071-3-joel@jms.id.au>
References: <20190402021933.13071-1-joel@jms.id.au>
 <20190402021933.13071-3-joel@jms.id.au>
Message-ID: <20190402062555.GA14723@ravnborg.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel

> index 000000000000..fb56e425bd48
> --- /dev/null
> +++ b/drivers/gpu/drm/aspeed/aspeed_gfx.h
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright 2018 IBM Corporation
> +
> +#include <drm/drmP.h>
> +#include <drm/drm_simple_kms_helper.h>

A drmP.h include was left here, can we have this removed too.

> +
> +static struct drm_driver aspeed_gfx_driver = {
> +	.driver_features        = DRIVER_GEM | DRIVER_MODESET |
> +				DRIVER_PRIME | DRIVER_ATOMIC |
> +				DRIVER_HAVE_IRQ,
DRIVER_HAVE_IRQ is obsolete and not needed anymore.
See drm_drv.h for details.

With these few things fixed:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
