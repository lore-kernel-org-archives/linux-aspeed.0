From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Fri, 25 Mar 2022 05:19:29 +0000
Subject: [PATCH 2/2] i2c:aspeed:support ast2600 i2c new register mode
 driver
In-Reply-To: <YjsUjB7vr1scHPVy@lunn.ch>
References: <20220323004009.943298-1-ryan_chen@aspeedtech.com>
 <20220323004009.943298-3-ryan_chen@aspeedtech.com> <YjsUjB7vr1scHPVy@lunn.ch>
Message-ID: <HK0PR06MB3380636B12959660E04403CDF21A9@HK0PR06MB3380.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,
> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Wednesday, March 23, 2022 8:38 PM
> To: Ryan Chen <ryan_chen@aspeedtech.com>
> Cc: BMC-SW <BMC-SW@aspeedtech.com>; Rob Herring
> <robh+dt@kernel.org>; Joel Stanley <joel@jms.id.au>; Andrew Jeffery
> <andrew@aj.id.au>; Philipp Zabel <p.zabel@pengutronix.de>;
> linux-arm-kernel at lists.infradead.org; linux-aspeed at lists.ozlabs.org;
> linux-kernel at vger.kernel.org
> Subject: Re: [PATCH 2/2] i2c:aspeed:support ast2600 i2c new register mode
> driver
> 
> On Wed, Mar 23, 2022 at 08:40:09AM +0800, ryan_chen wrote:
> > Add i2c new register mode driver to support AST2600 i2c new register
> > set. AST2600 i2c controller have legacy and new register mode. The new
> > register mode have global register support 4 base clock for scl clock
> > selection, and new clock divider mode. And i2c new register mode have
> > separate register set to control i2c master and slave.
> >
> > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > ---
> >  drivers/i2c/busses/Kconfig                 |   11 +
> >  drivers/i2c/busses/Makefile                |    1 +
> >  drivers/i2c/busses/aspeed-i2c-new-global.c |   91 ++
> >  drivers/i2c/busses/aspeed-i2c-new-global.h |   19 +
> >  drivers/i2c/busses/i2c-new-aspeed.c        | 1698
> ++++++++++++++++++++
> 
> I always find it funny when somebody uses 'new'. What is the next version
> going to be called? 'even-newer', and the version after that 'really-really-new'?
> 
> > +static const struct of_device_id aspeed_new_i2c_bus_of_table[] = {
> > +	{
> > +		.compatible = "aspeed,ast2600-i2c-bus",
> > +	},
> 
> Given this compatible string, why not call it i2c-aspeed-2600.c, and remove
> 'new' everywhere.
> 
Yes, I struggle the naming, but the next generation ast2700 still used.
The name "i2c-aspeed-2600.c" may not adaptable. 
Or How about name it to i2c-aspeed-package.c due to this is major feature
For this new i2c controller design?

Ryan

