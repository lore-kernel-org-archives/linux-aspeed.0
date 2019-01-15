From: Stefan Schaeckeler <schaecsn@gmx.net>
Date: Tue, 15 Jan 2019 09:57:48 -0800 (PST)
Subject: [PATCH 1/2] EDAC: Add Aspeed AST2500 EDAC driver
In-Reply-To: <20190110095049.GB17621@zn.tnic> (message from Borislav Petkov on
 Thu, 10 Jan 2019 10:50:49 +0100)
References: <1545026517-64069-1-git-send-email-schaecsn@gmx.net>
 <1545026517-64069-2-git-send-email-schaecsn@gmx.net>
 <20190110095049.GB17621@zn.tnic>
Message-ID: <20190115175749.01E3C6E85603@corona.crabdance.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Boris,

Thank you for your feedback.

> From: Borislav Petkov <bp@alien8.de>
> 
> On Sun, Dec 16, 2018 at 10:01:56PM -0800, Stefan Schaeckeler wrote:
> > From: Stefan M Schaeckeler <sschaeck@cisco.com>
> > 
> > Add support for the Aspeed AST2500 SoC EDAC driver.
> > 
> > Signed-off-by: Stefan M Schaeckeler <sschaeck@cisco.com>
> > ---
> >  MAINTAINERS                      |   6 +
> >  arch/arm/boot/dts/aspeed-g5.dtsi |   7 +
> >  drivers/edac/Kconfig             |   7 +
> >  drivers/edac/Makefile            |   1 +
> >  drivers/edac/aspeed_edac.c       | 457 +++++++++++++++++++++++++++++++
> >  5 files changed, 478 insertions(+)
> >  create mode 100644 drivers/edac/aspeed_edac.c
> 
> I couldn't see anything out of the ordinary - only nitpicks below.

[...]


> > diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
> > new file mode 100644
> > index 000000000000..d6ed119909eb
> > --- /dev/null
> > +++ b/drivers/edac/aspeed_edac.c
> > @@ -0,0 +1,457 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright 2018 Cisco Systems
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; either version
> > + * 2 of the License, or (at your option) any later version.
> 
> You have the SPDX license identifier - no need for that text.

That's interesting. I did a grep over all 16944 GPL licensed files with an SPDX
identifier.

785 of them have a license text while 16159 don't. I will remove mine.


> > +static int aspeed_edac_regmap_reg_write(void *context, unsigned int reg,
> > +					unsigned int val)
> 
> All the static functions don't need the "aspeed_edac" prefix.

When stripping off aspeed_edac_, some static function names will become quite
"bare-bone":

aspeed_edac_init(), aspeed_edac_exit(), aspeed_edac_probe(),
aspeed_edac_remove(), aspeed_edac_of_match(), aspeed_edac_isr(),
aspeed_edac_config_irq().


Does your suggestion also apply to static variables? E.g. aspeed_edac_regmap,
aspeed_edac_regmap_config, aspeed_edac_driver? Also, here some variable names
would become quite "bare-bone".

 Stefan
