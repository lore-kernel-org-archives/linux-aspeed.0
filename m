From: Stephen Boyd <sboyd@kernel.org>
Date: Fri, 30 Aug 2024 15:16:18 -0700
Subject: [PATCH v2 3/3] clk: aspeed: add AST2700 clk driver
In-Reply-To: <OS8PR06MB7541BFDC6D2E490ECDAE085CF2972@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20240828062740.1614744-1-ryan_chen@aspeedtech.com> <20240828062740.1614744-4-ryan_chen@aspeedtech.com> <61c8234139fcd2b27610ef18e9d9fbf7.sboyd@kernel.org> <OS8PR06MB7541F12972412AE565A93287F2962@OS8PR06MB7541.apcprd06.prod.outlook.com> <3569ef6d81adc41330c4002752ba3aa9.sboyd@kernel.org> <OS8PR06MB7541BFDC6D2E490ECDAE085CF2972@OS8PR06MB7541.apcprd06.prod.outlook.com>
Message-ID: <45c7cf75876c5822f8c51f05375af507.sboyd@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Quoting Ryan Chen (2024-08-30 00:50:21)
> > Subject: RE: [PATCH v2 3/3] clk: aspeed: add AST2700 clk driver
> > 
> > Quoting Ryan Chen (2024-08-29 00:09:12)
> > > > Subject: Re: [PATCH v2 3/3] clk: aspeed: add AST2700 clk driver
> > > >
> > > > Quoting Ryan Chen (2024-08-27 23:27:40)
> > > > > a/drivers/clk/clk-ast2700.c b/drivers/clk/clk-ast2700.c new file
> > > > > mode
> > > > > 100644 index 000000000000..7e0466e73980
> > > > > --- /dev/null
> > > > > +++ b/drivers/clk/clk-ast2700.c
> > > > > @@ -0,0 +1,1198 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +/*
> > > > > + * Copyright (c) 2024 ASPEED Technology Inc.
> > > > > + * Author: Ryan Chen <ryan_chen@aspeedtech.com>  */
> > > > > +
> > > > > +#include <linux/bits.h>
> > > > > +#include <linux/clk-provider.h>
> > > > [...]
> > > > > +
> > > > > +struct ast2700_reset {
> > > > > +       void __iomem *base;
> > > > > +       struct ast2700_reset_signal const *signal;
> > > > > +       struct reset_controller_dev rcdev; };
> > > >
> > > > Please move the reset controller to the drivers/reset directory by
> > > > means of using an auxiliary device. There are some existing examples
> > > > in there if you grep for auxiliary_device in drivers/reset to help guide.
> > >
> > > Do you mean to have another reset controller driver?
> > > If yes, I may need syscon for remap two drivers.
> > 
> > Yes. A syscon is not necessary to do that.
> Thanks for point out auxiliary device.
> Since our SoC reset and clock share the same register region.
> Your recommend will use clk auxiliary_device_add for reset driver am I right?

Yes. Either the clk or the reset driver can be a platform driver and the
other an auxiliary driver.
