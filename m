From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Thu, 22 Feb 2024 15:21:45 +0200
Subject: [PATCH v1 02/14] serial: core: Add UPIO_UNSET constant for unset
 port type
In-Reply-To: <5aeee02f-45a6-48e5-a6f4-e55b76d4b959@kernel.org>
References: <20240221183442.4124354-1-andriy.shevchenko@linux.intel.com>
 <20240221183442.4124354-3-andriy.shevchenko@linux.intel.com>
 <5aeee02f-45a6-48e5-a6f4-e55b76d4b959@kernel.org>
Message-ID: <ZddKaaB7HO0CyldD@smile.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Feb 22, 2024 at 07:58:32AM +0100, Jiri Slaby wrote:
> On 21. 02. 24, 19:31, Andy Shevchenko wrote:

...

> >   	unsigned char		iotype;			/* io access style */
> > +#define UPIO_UNSET		((unsigned char)~0U)	/* UCHAR_MAX */
> 
> Perhaps making the var u8 and this U8_MAX then? It would make more sense to
> me.

WFM, should it be a separate change? Btw, how can I justify it?

-- 
With Best Regards,
Andy Shevchenko


