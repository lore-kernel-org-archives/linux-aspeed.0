From: Ivan Mikhaylov <i.mikhaylov@yadro.com>
Date: Thu, 22 Aug 2019 17:24:27 +0300
Subject: [PATCH 3/3] watchdog/aspeed: add support for dual boot
In-Reply-To: <20190822135528.GB8144@roeck-us.net>
References: <1f2cd155057e5ab0cdb20a9a11614bbb09bb49ad.camel@yadro.com>
 <20190821163220.GA11547@roeck-us.net>
 <a022c0590f0fbf22cc8476b5ef3f1c22746429ac.camel@yadro.com>
 <20190822135528.GB8144@roeck-us.net>
Message-ID: <550d98a41f8c36effb8147201d6c5fdc762994ea.camel@yadro.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2019-08-22 at 06:55 -0700, Guenter Roeck wrote:
> On Thu, Aug 22, 2019 at 12:15:20PM +0300, Ivan Mikhaylov wrote:
> > On Wed, 2019-08-21 at 09:32 -0700, Guenter Roeck wrote:
> > > > +	writel(WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION,
> > > > +			wdt->base + WDT_CLEAR_TIMEOUT_STATUS);
> > > > +	wdt->wdd.bootstatus |= WDIOF_EXTERN1;
> > > 
> > > The variable reflects the _boot status_. It should not change after
> > > booting.
> > 
> > Okay, then perhaps may we set 'status' handler for watchdog device and
> > check 
> > 'status' file? Right now 'bootstatus' and 'status' are same because there is
> > no
> > handler for 'status'.
> > 
> 
> You would still have to redefine one of the status bits to mean something
> driver specific. You would also still have two different flags to read
> and control cs0 - to read the status, you would read an ioctl (or the
> status sysfs attribute), to write it you would write into access_cs0.
> 
> I guess I must be missing something. What is the problem with using
> access_cs0 for both ?
> 
> Guenter
> 

There is no problem, I'll do that way, thanks!

