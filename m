From: Greg KH <gregkh@linuxfoundation.org>
Date: Mon, 11 Apr 2022 14:24:48 +0200
Subject: [PATCH] usb: gadget: udc: clean up comments
In-Reply-To: <ecd8609b-2c52-5fb8-7820-191559d76011@redhat.com>
References: <20220410150828.1891123-1-trix@redhat.com>
 <YlQBgnjpkSurf9PZ@smile.fi.intel.com>
 <ecd8609b-2c52-5fb8-7820-191559d76011@redhat.com>
Message-ID: <YlQeEC41m3UeOeiE@kroah.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Apr 11, 2022 at 04:49:00AM -0700, Tom Rix wrote:
> 
> On 4/11/22 3:22 AM, Andy Shevchenko wrote:
> > On Sun, Apr 10, 2022 at 11:08:28AM -0400, Tom Rix wrote:
> > > SPDX
> > > *.h use /* */ style comments
> > > 
> > > For double words, remove
> > > with, also
> > > 
> > > Spelling replacements
> > > wayt to way
> > > wakup to wakeup
> > > Contrl to Control
> > > cheks to checks
> > > initiaization to initialization
> > > dyanmic to dynamic
> > Something really wrong with indentation above.
> > 
> > ...
> > 
> > >   drivers/usb/gadget/udc/amd5536udc.h       | 2 +-
> > >   drivers/usb/gadget/udc/aspeed-vhub/core.c | 2 +-
> > >   drivers/usb/gadget/udc/aspeed-vhub/ep0.c  | 2 +-
> > >   drivers/usb/gadget/udc/aspeed-vhub/hub.c  | 2 +-
> > >   drivers/usb/gadget/udc/aspeed-vhub/vhub.h | 4 ++--
> > >   drivers/usb/gadget/udc/at91_udc.c         | 2 +-
> > >   drivers/usb/gadget/udc/bdc/bdc_core.c     | 4 ++--
> > >   drivers/usb/gadget/udc/core.c             | 4 ++--
> > >   drivers/usb/gadget/udc/trace.h            | 2 +-
> > I believe that Greg's bot asks to split on per-driver basis.
> > OTOH I don't see anything that can be problematic if in one
> > change. So, it's up to maintainers then.
> 
> Yes, whatever folks want. I can split these.
> 
> I have been cleaning up the comments in other areas and am trying to strike
> a balance between too big of a patch vs peppering with many single changes.

Patch series are much easier to review and is just as simple to apply as
a single patch, so that makes it overall better for you to do.

thanks,

greg k-h
