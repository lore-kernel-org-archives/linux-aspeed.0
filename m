From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Tue, 11 Oct 2022 12:04:33 +0300
Subject: [PATCH v2 36/36] pinctrl: Clean up headers
In-Reply-To: <d63088d7-202b-a550-01e5-345a22de5f7d@amd.com>
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
 <20221010201453.77401-37-andriy.shevchenko@linux.intel.com>
 <d63088d7-202b-a550-01e5-345a22de5f7d@amd.com>
Message-ID: <Y0UxoV+zn5MadWbm@smile.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Oct 11, 2022 at 01:00:11PM +0530, Basavaraj Natikar wrote:
> On 10/11/2022 1:44 AM, Andy Shevchenko wrote:

...

> > --- a/drivers/pinctrl/core.h
> > +++ b/drivers/pinctrl/core.h

> > -#include <linux/pinctrl/pinconf.h>
> 
> Removing pinconf.h from the core.h may cause build failure in other files
> because where-ever core.h is included to use ?struct pinconf_ops?, there
> is a need to include pinconf.h.

Yes, I compiled only few drivers with the core changes. Still I got a few
reports by LKP. Thank you for spotting this!

> With that fixed,
> 
> Reviewed-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

Thank you!

-- 
With Best Regards,
Andy Shevchenko


