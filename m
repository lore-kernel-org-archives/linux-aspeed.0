From: Kent Gibson <warthog618@gmail.com>
Date: Wed, 12 Oct 2022 21:54:39 +0800
Subject: [PATCH v2 02/36] gpiolib: cdev: Add missed header(s)
In-Reply-To: <Y0bBXSHyxpdTGxoU@smile.fi.intel.com>
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
 <20221010201453.77401-3-andriy.shevchenko@linux.intel.com>
 <Y0SyVwjDl7NGfTPn@sol>
 <Y0bBXSHyxpdTGxoU@smile.fi.intel.com>
Message-ID: <Y0bHH06cbngWk4mH@sol>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Oct 12, 2022 at 04:30:05PM +0300, Andy Shevchenko wrote:
> On Tue, Oct 11, 2022 at 08:01:27AM +0800, Kent Gibson wrote:
> > On Mon, Oct 10, 2022 at 11:14:18PM +0300, Andy Shevchenko wrote:
> 
> ...
> 
> > > -#include <linux/gpio.h>
> > >  #include <linux/gpio/driver.h>
> > > +#include <linux/gpio.h>
> 
> > But moving the gpio subsystem header after the gpio/driver is not
> > alphabetical ('.' precedes '/') and it read better and made more sense
> > to me the way it was.
> 
> Okay, I will move it back.
> 
> ...
> 
> > > +#include <linux/seq_file.h>
> > 
> > I wasn't aware that we use anything from seq_file.
> > What am I missing?
> 
> 
> Eventually I can answer to your question: the commit 0ae3109a8391
> ("gpiolib: cdev: add fdinfo output for line request file descriptors")
> is what you are missing.
> 
> That said, we need this patch.
> 

Ah, yes - totally forgot that one is in flight.
That makes sense then.

With the gpio headers retaining their original order:

Rewiewed-by: Kent Gibson <warthog618@gmail.com>

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
