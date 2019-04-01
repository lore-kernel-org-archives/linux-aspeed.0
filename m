From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 1 Apr 2019 20:48:31 +0200
Subject: [PATCH 2/2] drm: Add ASPEED GFX driver
In-Reply-To: <730c140f-b4a2-7df9-3d90-9d47d720f643@tronnes.org>
References: <20190328054316.17939-1-joel@jms.id.au>
 <20190328054316.17939-3-joel@jms.id.au>
 <730c140f-b4a2-7df9-3d90-9d47d720f643@tronnes.org>
Message-ID: <20190401184831.GA14599@ravnborg.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel.

Replying to Noralf's mail as I lost the original mail.

> > diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c b/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
> > new file mode 100644
> > index 000000000000..e2d1d7497352
> > --- /dev/null
> > +++ b/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
> > @@ -0,0 +1,248 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +// Copyright 2018 IBM Corporation
> > +
> > +#include <linux/clk.h>
> > +#include <linux/reset.h>
> > +#include <linux/regmap.h>
> > +
> > +#include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_device.h>
> > +#include <drm/drm_fb_cma_helper.h>
> > +#include <drm/drm_gem_cma_helper.h>
> > +#include <drm/drm_simple_kms_helper.h>
> > +#include <drm/drm_gem_framebuffer_helper.h>
> > +#include <drm/drm_panel.h>
> 
> I prefer includes sorted alphabetically, but no requirement.
Please sort them as Noralf suggest, as this makes it much more obvious
when one is adding a duplicate header.

> > +
> > +	priv->rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
> > +	if (IS_ERR(priv->rst)) {
> > +		dev_err(&pdev->dev,
> > +			"missing or invalid reset controller device tree entry");
Add error code to your dev_err() calls, so one later better
can tell what was wrong if river fails to load.
Same goes for other dev_xxx calls in this function / dirver.
(Most dev_xxx have the return code, only a few seems to miss it)

> > +static const struct of_device_id aspeed_gfx_match[] = {
> > +	{ .compatible = "aspeed,ast2400-gfx" },
> > +	{ .compatible = "aspeed,ast2500-gfx" },
> > +	{ }
Many drivers put a /* sentinel */ comment inside the empty {}

With the few things suggested above considered this is
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

	Sam
