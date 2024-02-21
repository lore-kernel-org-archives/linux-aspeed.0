From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Wed, 21 Feb 2024 20:53:08 +0200
Subject: [PATCH v1 02/14] serial: core: Add UPIO_UNSET constant for unset
 port type
In-Reply-To: <d18d4488-aa48-4156-8087-a117664cea7b@gmail.com>
References: <20240221183442.4124354-1-andriy.shevchenko@linux.intel.com>
 <20240221183442.4124354-3-andriy.shevchenko@linux.intel.com>
 <d18d4488-aa48-4156-8087-a117664cea7b@gmail.com>
Message-ID: <ZdZGlLoUd_R6JQJc@smile.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 21, 2024 at 10:47:13AM -0800, Florian Fainelli wrote:
> On 2/21/24 10:31, Andy Shevchenko wrote:

...

> >   	unsigned char		iotype;			/* io access style */
> > +#define UPIO_UNSET		((unsigned char)~0U)	/* UCHAR_MAX */
> 
> Nit: I would name this UPIO_UNKNOWN, or UPIO_NOTSET, unset means to me that
> it was previously set and we undid that action, whereas unknown or not set
> means we never did.

Works for me. I will wait for a few days / week to have more reviews and
likely testings to be collected. Would be nice if you be able to test on
(some of) the hardware in the list of modified drivers.

-- 
With Best Regards,
Andy Shevchenko


