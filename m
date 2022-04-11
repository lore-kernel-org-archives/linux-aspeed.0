From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Mon, 11 Apr 2022 13:22:58 +0300
Subject: [PATCH] usb: gadget: udc: clean up comments
In-Reply-To: <20220410150828.1891123-1-trix@redhat.com>
References: <20220410150828.1891123-1-trix@redhat.com>
Message-ID: <YlQBgnjpkSurf9PZ@smile.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Apr 10, 2022 at 11:08:28AM -0400, Tom Rix wrote:
> SPDX
> *.h use /* */ style comments
> 
> For double words, remove
> with, also
> 
> Spelling replacements
> wayt to way
> wakup to wakeup
> Contrl to Control
> cheks to checks
> initiaization to initialization
> dyanmic to dynamic

Something really wrong with indentation above.

...

>  drivers/usb/gadget/udc/amd5536udc.h       | 2 +-
>  drivers/usb/gadget/udc/aspeed-vhub/core.c | 2 +-
>  drivers/usb/gadget/udc/aspeed-vhub/ep0.c  | 2 +-
>  drivers/usb/gadget/udc/aspeed-vhub/hub.c  | 2 +-
>  drivers/usb/gadget/udc/aspeed-vhub/vhub.h | 4 ++--
>  drivers/usb/gadget/udc/at91_udc.c         | 2 +-
>  drivers/usb/gadget/udc/bdc/bdc_core.c     | 4 ++--
>  drivers/usb/gadget/udc/core.c             | 4 ++--
>  drivers/usb/gadget/udc/trace.h            | 2 +-

I believe that Greg's bot asks to split on per-driver basis.
OTOH I don't see anything that can be problematic if in one
change. So, it's up to maintainers then.

...

> --- a/drivers/usb/gadget/udc/amd5536udc.h
> +++ b/drivers/usb/gadget/udc/amd5536udc.h

>   * amd5536.h -- header for AMD 5536 UDC high/full speed USB device controller

At the same time you may drop the filename(s) from the file(s) as this very
one shows why it's good not to have a filename inside file.

-- 
With Best Regards,
Andy Shevchenko


