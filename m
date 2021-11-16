From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
Date: Tue, 16 Nov 2021 07:26:28 +0100
Subject: [PATCH v3 06/13] peci: Add device detection
In-Reply-To: <368c990c30c5bacde15ac4bce5db8389aea3ec9c.camel@intel.com>
References: <20211115182552.3830849-1-iwona.winiarska@intel.com>
 <20211115182552.3830849-7-iwona.winiarska@intel.com>
 <YZKr1Rqfx6Cmw+Ok@kroah.com>
 <368c990c30c5bacde15ac4bce5db8389aea3ec9c.camel@intel.com>
Message-ID: <YZNPFGPXfCLfJMq3@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Nov 15, 2021 at 10:35:23PM +0000, Winiarska, Iwona wrote:
> On Mon, 2021-11-15 at 19:49 +0100, Greg Kroah-Hartman wrote:
> > On Mon, Nov 15, 2021 at 07:25:45PM +0100, Iwona Winiarska wrote:
> > > +void peci_device_destroy(struct peci_device *device)
> > > +{
> > > +???????bool killed;
> > > +
> > > +???????device_lock(&device->dev);
> > > +???????killed = kill_device(&device->dev);
> > 
> > Eeek, why call this?
> > 
> > > +???????device_unlock(&device->dev);
> > > +
> > > +???????if (!killed)
> > > +???????????????return;
> > 
> > What happened if something changed after you unlocked it?
> 
> We either killed it, or the other caller killed it.
> 
> > 
> > Why is kill_device() required at all?? That's a very rare function to
> > call, and one that only one "bus" calls today because it is very
> > special (i.e. crazy and broken...)
> 
> It's used to avoid double-delete in case of races between peci_controller
> unregister and "manually" removing the device using sysfs (pointed out by Dan in
> v2). We're calling peci_device_destroy() in both callsites.
> Other way to solve it would be to just have a peci-specific lock, but
> kill_device seemed to be well suited for the problem at hand.
> Do you suggest to remove it and just go with the lock?

Yes please, remove it and use the lock.

Also, why are you required to have a sysfs file that can remove the
device?  Who wants that?

thanks,

greg k-h
