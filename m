From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Fri, 4 Oct 2024 06:58:27 +0000
Subject: [PATCH v14 0/3] Add ASPEED AST2600 I2Cv2 controller driver
In-Reply-To: <Zv6QdUuiUFvXjcd4@smile.fi.intel.com>
References: <20241002070213.1165263-1-ryan_chen@aspeedtech.com>
 <Zv1aOedi9xl2mg9b@smile.fi.intel.com>
 <SI6PR06MB75359904E108D7D0CC89A329F2712@SI6PR06MB7535.apcprd06.prod.outlook.com>
 <Zv5u1gTK9yug7rbK@smile.fi.intel.com>
 <dun5dterlkikft4p2yuuebb2e4nyzed7xeofmeivzldeardhmf@kzv3iokk6cxn>
 <Zv6QdUuiUFvXjcd4@smile.fi.intel.com>
Message-ID: <OS8PR06MB75411555216E89213DA0933EF2722@OS8PR06MB7541.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Subject: Re: [PATCH v14 0/3] Add ASPEED AST2600 I2Cv2 controller driver
> 
> On Thu, Oct 03, 2024 at 02:20:54PM +0200, Andi Shyti wrote:
> > On Thu, Oct 03, 2024 at 01:15:50PM GMT, Andy Shevchenko wrote:
> > > On Thu, Oct 03, 2024 at 03:41:57AM +0000, Ryan Chen wrote:
> > > > > On Wed, Oct 02, 2024 at 03:02:10PM +0800, Ryan Chen wrote:
> 
> ...
> 
> > > > > Is it possible to switch to new terminology wherever it's possible?
> > > > > I.e. master --> controller, slave --> target. See, for example,
> > > > > f872d28500bd
> > > > > ("i2c: uniphier-f: reword according to newest specification").
> > > > >
> > > > Just for cover latter? Or I should modify for each patches commit
> message?
> > > > Or entire i2c driver statement need switch to target?
> > >
> > > I believe everywhere, where it applies: driver code, comments,
> > > documentation, commit messages...
> >
> > If the datasheet refers to a register, state, or any other hardware
> > property as master/slave, we should retain the master/slave
> > terminology. Otherwise, we should follow the i2c and smbus
> > specifications and use controller/target.
> 
> Indeed, makes sense. Thank you, Andi, for the corrections!
> 
Thanks, I will modify with controller/target in sw driver parts. Keep the hw datasheet statement. 
> --
> With Best Regards,
> Andy Shevchenko
> 

