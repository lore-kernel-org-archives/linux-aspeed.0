From: Ivan Mikhaylov <i.mikhaylov@yadro.com>
Date: Fri, 23 Aug 2019 17:58:32 +0300
Subject: [PATCH v1 3/3] watchdog/aspeed: add support for dual boot
In-Reply-To: <20190823141930.GA11610@roeck-us.net>
References: <fafd757238e204b2566f216f1d6a4bef4b4906c5.camel@yadro.com>
 <20190823141930.GA11610@roeck-us.net>
Message-ID: <8690cbb3e7759f3d8ab2a93db53186bf02fd525a.camel@yadro.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2019-08-23 at 07:19 -0700, Guenter Roeck wrote:
> >  
> > +/* access_cs0 shows if cs0 is accessible, hence the reverted bit */
> > +static ssize_t access_cs0_show(struct device *dev,
> > +		struct device_attribute *attr, char *buf)
> > +{
> > +	struct aspeed_wdt *wdt = dev_get_drvdata(dev);
> > +
> 
> Unnecessary empty line.
> 

Ok, will cut.

> > +static ssize_t access_cs0_store(struct device *dev,
> > +			      struct device_attribute *attr,
> > +			      const char *buf, size_t size)
> > +{
> > +	struct aspeed_wdt *wdt = dev_get_drvdata(dev);
> > +	unsigned long val = 0;
> 
> Unnecessary initialization.

So, you're saying 'unsigned long val;' is enough? Will do then.

> 
> So the attribute would only exist if the boot was from the secondary
> flash, and it would exist even if it wasn't needed (ie on ast2500 /
> ast2600)?
Yes, only at secondary flash it will be available.
Also, found out that is for 2600 aspeed completely changed the process of
switch. For 2500 it just swaps chipselects back to make it accordingly as at
first side, on idea it may be helpful.

May be some approach like this will suffice?
if ((of_device_is_compatible(np, "aspeed,ast2400-wdt") or
(of_device_is_compatible(np, "aspeed,ast2500-wdt"))
	wdt->wdd.groups = bswitch_groups;


>  Well, if that is what you want, who am I to argue, but
> you'll have to document it accordingly. When you do so, please also
> document what happens on ast2500 / ast2600 when the attribute exists
> and is written.
> 

Ok, I'll put it in Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
for next patch set.

