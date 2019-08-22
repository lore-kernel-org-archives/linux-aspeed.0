From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 22 Aug 2019 06:55:28 -0700
Subject: [PATCH 3/3] watchdog/aspeed: add support for dual boot
In-Reply-To: <a022c0590f0fbf22cc8476b5ef3f1c22746429ac.camel@yadro.com>
References: <1f2cd155057e5ab0cdb20a9a11614bbb09bb49ad.camel@yadro.com>
 <20190821163220.GA11547@roeck-us.net>
 <a022c0590f0fbf22cc8476b5ef3f1c22746429ac.camel@yadro.com>
Message-ID: <20190822135528.GB8144@roeck-us.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Aug 22, 2019 at 12:15:20PM +0300, Ivan Mikhaylov wrote:
> On Wed, 2019-08-21 at 09:32 -0700, Guenter Roeck wrote:
> > 
> > > +	writel(WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION,
> > > +			wdt->base + WDT_CLEAR_TIMEOUT_STATUS);
> > > +	wdt->wdd.bootstatus |= WDIOF_EXTERN1;
> > 
> > The variable reflects the _boot status_. It should not change after booting.
> 
> Okay, then perhaps may we set 'status' handler for watchdog device and check 
> 'status' file? Right now 'bootstatus' and 'status' are same because there is no
> handler for 'status'.
> 

You would still have to redefine one of the status bits to mean something
driver specific. You would also still have two different flags to read
and control cs0 - to read the status, you would read an ioctl (or the
status sysfs attribute), to write it you would write into access_cs0.

I guess I must be missing something. What is the problem with using
access_cs0 for both ?

Guenter

> > > +
> > > +	return size;
> > > +}
> > > +static DEVICE_ATTR_WO(access_cs0);
> > > +
> > > +static struct attribute *bswitch_attrs[] = {
> > > +	&dev_attr_access_cs0.attr,
> > > +	NULL
> > > +};
> > > +ATTRIBUTE_GROUPS(bswitch);
> > > +
> > >  static const struct watchdog_ops aspeed_wdt_ops = {
> > >  	.start		= aspeed_wdt_start,
> > >  	.stop		= aspeed_wdt_stop,
> > > @@ -223,6 +248,9 @@ static int aspeed_wdt_probe(struct platform_device
> > > *pdev)
> > >  
> > >  	wdt->ctrl = WDT_CTRL_1MHZ_CLK;
> > >  
> > > +	if (of_property_read_bool(np, "aspeed,alt-boot"))
> > > +		wdt->wdd.groups = bswitch_groups;
> > > +
> > Why does this have to be separate to the existing evaluation of
> > aspeed,alt-boot, and why does the existing code not work ?
> > 
> > Also, is it guaranteed that this does not interfer with existing
> > support for alt-boot ?
> 
> It doesn't, it just provides for ast2400 switch to cs0 at side 1(cs1). Problem
> is that only one flash chip(side 1/cs1) is accessible on alternate boot, there
> is citation from the documentation in commit body. So if by some reason side 0
> is corrupted, need to switch into alternate boot to cs1, do the load from it,
> drop that bit to make side 0 accessible and do the flash of first side. On
> ast2500/2600 this problem is solved already, in alternate boot there both flash
> chips are present. It's additional requirement for alternate boot on ast2400, to
> make the possibility to access at all side 0 flash chip after we boot to the
> alternate side.
> 
