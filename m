From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Fri, 23 Feb 2024 16:59:24 +0200
Subject: [PATCH v1 02/14] serial: core: Add UPIO_UNSET constant for unset
 port type
In-Reply-To: <fa46f220-a1c4-43f4-91e1-5929ff335be0@kernel.org>
References: <20240221183442.4124354-1-andriy.shevchenko@linux.intel.com>
 <20240221183442.4124354-3-andriy.shevchenko@linux.intel.com>
 <5aeee02f-45a6-48e5-a6f4-e55b76d4b959@kernel.org>
 <ZddKaaB7HO0CyldD@smile.fi.intel.com>
 <fa46f220-a1c4-43f4-91e1-5929ff335be0@kernel.org>
Message-ID: <ZdiyzKMZPlkN462G@smile.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Feb 23, 2024 at 06:42:15AM +0100, Jiri Slaby wrote:
> On 22. 02. 24, 14:21, Andy Shevchenko wrote:
> > On Thu, Feb 22, 2024 at 07:58:32AM +0100, Jiri Slaby wrote:
> > > On 21. 02. 24, 19:31, Andy Shevchenko wrote:

...

> > > >    	unsigned char		iotype;			/* io access style */
> > > > +#define UPIO_UNSET		((unsigned char)~0U)	/* UCHAR_MAX */
> > > 
> > > Perhaps making the var u8 and this U8_MAX then? It would make more sense to
> > > me.
> > 
> > WFM, should it be a separate change?
> 
> Likely.

Then I need a commit message, because I'm unable to justify this change myself.

> > Btw, how can I justify it?
> 
> Hmm, thinking about it, why is it not an enum?

Maybe, but it is a replica of UAPI definitions, do we want to see it as a enum?
To me it will be a bit ugly looking.

> But it could be also an u8 because you want it be exactly 8 bits as you want
> to be sure values up to 255 fit.

Depends on what we assume UAPI does with those flags. It maybe even less than
8 bits, or great than, currently 8 bits is enough...

TL;DR: I would rather take a patch from you and incorporate into the series
than trying hard to invent a justification and proper type.

-- 
With Best Regards,
Andy Shevchenko


