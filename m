From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 8 Oct 2021 07:41:06 +0200
Subject: [PATCH 0/9] Dynamic DT device nodes
In-Reply-To: <CAL_JsqLk-CqKVgWp3=XccHrCdQgdGoezB6=HAXMDe1Q5R4-0HA@mail.gmail.com>
References: <20211007000954.30621-1-zev@bewilderbeest.net>
 <CAHp75VdYBB_FaMr-uKswdvDBdobTYZkiE6ncoALuG+YYVoMwyw@mail.gmail.com>
 <YV64ZbcsHvBObH2j@hatter.bewilderbeest.net>
 <YV7Miz9RMMx/17A0@kroah.com>
 <YV8VGeMreR6NJad4@hatter.bewilderbeest.net>
 <CAL_JsqLk-CqKVgWp3=XccHrCdQgdGoezB6=HAXMDe1Q5R4-0HA@mail.gmail.com>
Message-ID: <YV/Z8mSCxhk3rD8Z@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Oct 07, 2021 at 03:03:43PM -0500, Rob Herring wrote:
> On Thu, Oct 7, 2021 at 10:41 AM Zev Weiss <zev@bewilderbeest.net> wrote:
> >
> > On Thu, Oct 07, 2021 at 03:31:39AM PDT, Greg Kroah-Hartman wrote:
> > >On Thu, Oct 07, 2021 at 02:05:41AM -0700, Zev Weiss wrote:
> > >> On Thu, Oct 07, 2021 at 12:04:41AM PDT, Andy Shevchenko wrote:
> > >> > On Thu, Oct 7, 2021 at 3:10 AM Zev Weiss <zev@bewilderbeest.net> wrote:
> > >> > > This patch series is in some ways kind of a v2 for the "Dynamic
> > >> > > aspeed-smc flash chips via 'reserved' DT status" series I posted
> > >> > > previously [0], but takes a fairly different approach suggested by Rob
> > >> > > Herring [1] and doesn't actually touch the aspeed-smc driver or
> > >> > > anything in the MTD subsystem, so I haven't marked it as such.
> > >> > >
> > >> > > To recap a bit of the context from that series, in OpenBMC there's a
> > >> > > need for certain devices (described by device-tree nodes) to be able
> > >> > > to be attached and detached at runtime (for example the SPI flash for
> > >> > > the host's firmware, which is shared between the BMC and the host but
> > >> > > can only be accessed by one or the other at a time).
> > >> >
> > >> > This seems quite dangerous. Why do you need that?
> > >>
> > >> Sometimes the host needs access to the flash (it's the host's firmware,
> > >> after all), sometimes the BMC needs access to it (e.g. to perform an
> > >> out-of-band update to the host's firmware).  To achieve the latter, the
> > >> flash needs to be attached to the BMC, but that requires some careful
> > >> coordination with the host to arbitrate which one actually has access to it
> > >> (that coordination is handled by userspace, which then tells the kernel
> > >> explicitly when the flash should be attached and detached).
> > >>
> > >> What seems dangerous?
> > >>
> > >> > Why can't device tree overlays be used?
> > >>
> > >> I'm hoping to stay closer to mainline.  The OpenBMC kernel has a documented
> > >> policy strongly encouraging upstream-first development:
> > >> https://github.com/openbmc/docs/blob/master/kernel-development.md
> > >>
> > >> I doubt Joel (the OpenBMC kernel maintainer) would be eager to start
> > >> carrying the DT overlay patches; I'd likewise strongly prefer to avoid
> > >> carrying them myself as additional downstream patches.  Hence the attempt at
> > >> getting a solution to the problem upstream.
> > >
> > >Then why not work to get device tree overlays to be merged properly?
> 
> TBC, it's 'just' the general purpose userspace interface to apply
> overlays that's missing.
> 
> I did suggest what's done here as overlays are kind of an overkill for
> this usecase. Much easier to write to a sysfs file than write an
> overlay, compile it with dtc, and provide it to the kernel all just to
> enable a device.
> 
> Perhaps this could also be supported in the driver model directly.
> Given the "what about ACPI question", that is probably what should be
> done unless the answer is we don't care. I think we'd just need a flag
> to create devices, but not bind automatically. Or maybe abusing
> driver_override can accomplish that.

The driver model already allows devices to be bound/unbound from
drivers, but no, it does not allow new devices to be "created" from
userspace as that is a very bus-specific thing to have happen.

If this is "just" a platform device, perhaps add that logic to the
platform bus code?

thanks,

greg k-h
