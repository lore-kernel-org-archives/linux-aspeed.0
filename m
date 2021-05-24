From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 24 May 2021 10:23:36 +0930
Subject: =?UTF-8?Q?Re:_[PATCH_v3_05/16]_ipmi:_kcs=5Fbmc:_Turn_the_driver_data-str?=
 =?UTF-8?Q?uctures_inside-out?=
In-Reply-To: <20210521171412.GI2921206@minyard.net>
References: <20210510054213.1610760-1-andrew@aj.id.au>
 <20210510054213.1610760-6-andrew@aj.id.au>
 <20210521171412.GI2921206@minyard.net>
Message-ID: <79f3c6d1-1f74-46ec-99a0-37faf11517b6@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Sat, 22 May 2021, at 02:44, Corey Minyard wrote:
> On Mon, May 10, 2021 at 03:12:02PM +0930, Andrew Jeffery wrote:
> > Make the KCS device drivers responsible for allocating their own memory.
> > 
> > Until now the private data for the device driver was allocated internal
> > to the private data for the chardev interface. This coupling required
> > the slightly awkward API of passing through the struct size for the
> > driver private data to the chardev constructor, and then retrieving a
> > pointer to the driver private data from the allocated chardev memory.
> > 
> > In addition to being awkward, the arrangement prevents the
> > implementation of alternative userspace interfaces as the device driver
> > private data is not independent.
> > 
> > Peel a layer off the onion and turn the data-structures inside out by
> > exploiting container_of() and embedding `struct kcs_device` in the
> > driver private data.
> 
> All in all a very nice cleanup.  A few nits inline.
> 
> > 
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > Reviewed-by: Zev Weiss <zweiss@equinix.com>
> > ---
> >  drivers/char/ipmi/kcs_bmc.c           | 19 +++++++--
> >  drivers/char/ipmi/kcs_bmc.h           | 12 ++----
> >  drivers/char/ipmi/kcs_bmc_aspeed.c    | 56 +++++++++++++------------
> >  drivers/char/ipmi/kcs_bmc_cdev_ipmi.c | 60 ++++++++++++++++++---------
> >  drivers/char/ipmi/kcs_bmc_npcm7xx.c   | 37 ++++++++++-------
> >  5 files changed, 111 insertions(+), 73 deletions(-)
> > 
> > diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
> > index ef5c48ffe74a..83da681bf49e 100644
> > --- a/drivers/char/ipmi/kcs_bmc.c
> > +++ b/drivers/char/ipmi/kcs_bmc.c
> > @@ -44,12 +44,23 @@ int kcs_bmc_handle_event(struct kcs_bmc *kcs_bmc)
> >  }
> >  EXPORT_SYMBOL(kcs_bmc_handle_event);
> >  
> > -struct kcs_bmc *kcs_bmc_ipmi_alloc(struct device *dev, int sizeof_priv, u32 channel);
> > -struct kcs_bmc *kcs_bmc_alloc(struct device *dev, int sizeof_priv, u32 channel)
> > +int kcs_bmc_ipmi_add_device(struct kcs_bmc *kcs_bmc);
> 
> The above (and it's remove function) should be in an include file.

This is a short-term hack while I'm refactoring the code. It goes away 
in a later patch when we switch to using an ops struct.

I didn't move it to a header as it's an implementation detail at the 
end of the day. I see headers as describing a public interface, and in 
the bigger picture this function isn't part of the public API. But 
maybe it's too tricky by half. My approach here generated some 
discussion with Zev as well.

> 
> > +void kcs_bmc_add_device(struct kcs_bmc *kcs_bmc)
> 
> This should return an error so the probe can be failed and cleaned up
> and so confusing message don't get printed after this in one case.

Hmm. I did this because the end result of the series is that we can 
have multiple chardev interfaces in distinct modules exposing the one 
KCS device in the one kernel. If more than one of the chardev modules 
is configured in and one of them fails to initialise themselves with 
respect to the device driver I didn't think it was right to fail the 
probe of the device driver (and thus remove any chardev interfaces that 
did succeed to initialise against it).

But this does limit the usefulness of the device driver instance in the 
case that only one of the chardev interfaces is configured in and it 
fails to initialise.

So I think we need to decide on the direction before I adjust the 
interface here. The patches are architected around the idea of multiple 
chardevs being configured in to the kernel build and all are exposed at 
runtime.

The serio subsystem does have the 'drvctl' sysfs knob that allows 
userspace to dictate which serio chardev interface they want to connect 
to a serio device driver. Maybe that's preferred over my "connect them 
all" strategy?

Andrew
