From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 06 Jul 2018 11:48:36 +1000
Subject: [PATCH 1/2] dt-bindings: fsi: Add optional chip-id to CFAMs
In-Reply-To: <CAL_JsqKZunLyRJQJgQrcBvv2s=HEd=E2ZG1ZgkgwTQkzJ88mcA@mail.gmail.com>
References: <20180622043756.21158-1-benh@kernel.crashing.org>
 <20180703193017.GA23230@rob-hp-laptop>
 <23be30ebb2c661ef304c78a85cff591c515ba65b.camel@kernel.crashing.org>
 <CAL_JsqKZunLyRJQJgQrcBvv2s=HEd=E2ZG1ZgkgwTQkzJ88mcA@mail.gmail.com>
Message-ID: <a6331cdbababea893bcde5f8ca9529dd89dafd67.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2018-07-05 at 12:49 -0600, Rob Herring wrote:
> On Tue, Jul 3, 2018 at 7:07 PM Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > 
> > On Tue, 2018-07-03 at 13:30 -0600, Rob Herring wrote:
> > > On Fri, Jun 22, 2018 at 02:37:55PM +1000, Benjamin Herrenschmidt wrote:
> > > > This represents a physical chip in the system and allows
> > > > a stable numbering scheme to be passed to udev for userspace
> > > > to recognize which chip is which.
> > > 
> > > I'm sure you're aware, stable numbers is generally not something the
> > > kernel guarantees...
> > 
> > This has nothing to do with any kernel guarantee. Not sure what you are
> > mixing up here :-)
> 
> I was referring to /dev node names like sda/sdb/sdc or ttyS0/ttyS1.

Ah yes. I do have code to make those "somewhat stable" using the chip
ID by default (unless overriden) as a backward compat thing for small
systems but the long term goal is indeed to not rely on this.

> > The IDs will get exposed via sysfs in order to allow udev rules to
> > create appropriate symlinks such as by-id or by-path as is traditional
> > (we haven't completely decided some of the udev side details yet)
> 
> Yeah, that's a bit different.

Yup, that's the right way actually :-)

> > > In the cases where we do have them, we've used aliases.
> > 
> > This is necessary, though Aliases may do the job too. This is the
> > device-tree that represents the "host" system that the BMC is managing.
> > 
> > We need to be able to identify using a stable numbering scheme the
> > processors on the FSI topology otherwise we would do "interesting"
> > things such as turn the fan for CPU 1 when CPU 0 gets hot :-)
> > 
> > (This is just a silly example, there are plenty of other reasons why we
> > need to understand the HW topology of a given system, including
> > debuggers using FSI as a backend etc...)
> > 
> > Traditionally POWER has used ibm,chip-id properties for the host side,
> > so I just did something similar here for the BMC side, but I can look
> > into using aliases if you prefer.
> 
> That is specifically for CPUs though, right?

No, it's for host "chips".

IE, this is the device-tree of the BMC, consumed by the BMC. So we are
in the context of Linux running on the BMC ARM SoC.

That BMC is connected to the "Host" POWER9 chips via a service
interface called FSI (think as a kind of PECI or JTAG on steroids),
which it uses to crank them up or do various monitoring/management
tasks.

So while they are CPUs they are actually "Devices" in the context of
the consumer here.

Additionally, on some systems, there can be other type of chips
connected to FSI, such as memory buffer chips etc... all get a "chip
ID" assigned.

>  Is the same true here? If
> so, I guess this is fine. A set of indexes for any device on a bus
> would be more concerning.

There can be multiple FSI links connecting to the same chips, some are
accessed via cascaded FSI masters etc... so it's not about indices on
the bus. It's really about identifying a physical package on the
motherboard.

> > Note: I'm not sure what you have against DT provided names or IDs, this
> > has been a rather standard way of doing things even before we did the
> > FDT. For example that's what slot-names properties are for, or location
> > codes etc... Yes we invented that alias trick later on but it's not
> > necessarily the best approach (in fact I don't really like it to be
> > honest).
> 
> I'm no fan of aliases either, but just trying to keep some consistency
> in how we deal with various problems. My main concern is folks trying
> to create some made-up index numbering of devices. Often it's not
> really needed as there are other ways to address or identify devices.
> In many cases we end up using 'reg' if there's no other means of
> addressing a device.
> 
> We've generally standardized around "label" for things like slots,
> ports, connectors, etc. that need to be physically identified.

Yes, label would be an option too, probably a better one that aliases.

> "slot-names" it seems hasn't gotten used for FDT. Since there aren't
> DT's published for OF based systems nor any documentation, newbies
> like me (that only have 8 years of DT experience) don't have any
> insight into how things used to be done.

In a pretty much ad-hoc way :-) In this case, though, chip-id is a
simple solution and works well (and I have the code already written and
tested :-)

Cheers,
Ben.


> Rob
