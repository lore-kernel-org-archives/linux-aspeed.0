From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Tue, 5 Nov 2019 14:20:42 +0200
Subject: [PATCH 00/62] Add definition for GPIO direction
In-Reply-To: <cover.1572875541.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1572875541.git.matti.vaittinen@fi.rohmeurope.com>
Message-ID: <20191105122042.GO32742@smile.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Nov 05, 2019 at 12:09:10PM +0200, Matti Vaittinen wrote:
> The patch series adds definitions for GPIO line directions.
> 
> For occasional GPIO contributor like me it is always a pain to remember
> whether 1 or 0 was used for GPIO direction INPUT/OUTPUT. Judging the
> fact that I removed few comments like:
> 
> /* Return 0 if output, 1 if input */
> /* This means "out" */
> return 1; /* input */
> return 0; /* output */
> 
> it seems at least some others may find it hard to remember too. Adding
> defines for these values helps us who really have good - but short
> duration - memory :]
> 
> Please also see the last patch. It adds warning prints to be emitted
> from gpiolib if other than defined values are used. This patch can be
> dropped out if there is a reason for that to still be allowed.
> 
> This idea comes from RFC series for ROHM BD71828 PMIC and was initially
> discussed with Linus Walleij here:
> https://lore.kernel.org/lkml/c06725c3dd34118a324907137758d8b85b3d4043.camel at fi.rohmeurope.com/
> but as this has no dependencies to BD71828 work (which probably takes a
> while) I decided to make it independent series.
> 
> Patches are compile-tested only. I have no HW to really test them. Thus I'd
> appreciate carefull review. This work is mainly about converting zeros
> and ones to the new defines but it wouldn't be first time I get it wrong
> in one of the patches :)

For all patches I have been Cc'ed to, NAK.

I don't see the advantages now since all known hardware uses the single bit to
describe direction (even for Intel where we have separate gating for in and out
buffers the direction we basically rely on the bit that enables out buffer).

So, that said the direction is always 1 bit and basically 0/1 value. Which one
is in and which one is out just a matter of an agreement we did.

I would also like to see bloat-o-meter statistics before and after your patch.
My guts tell me that the result will be not in the favour of yours solution.

-- 
With Best Regards,
Andy Shevchenko


