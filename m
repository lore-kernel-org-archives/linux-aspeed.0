From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Tue, 11 Oct 2022 12:07:05 +0300
Subject: [PATCH v2 36/36] pinctrl: Clean up headers
In-Reply-To: <CAMuHMdUfdQnisexfs4yLjeKs-LUPY1HjChrgeNjNL1qSErir9Q@mail.gmail.com>
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
 <20221010201453.77401-37-andriy.shevchenko@linux.intel.com>
 <d63088d7-202b-a550-01e5-345a22de5f7d@amd.com>
 <CAMuHMdUfdQnisexfs4yLjeKs-LUPY1HjChrgeNjNL1qSErir9Q@mail.gmail.com>
Message-ID: <Y0UyOWALxSFai2w6@smile.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Oct 11, 2022 at 10:46:30AM +0200, Geert Uytterhoeven wrote:
> On Tue, Oct 11, 2022 at 9:31 AM Basavaraj Natikar <bnatikar@amd.com> wrote:
> > On 10/11/2022 1:44 AM, Andy Shevchenko wrote:

> > > +++ b/drivers/pinctrl/core.h

> > > -#include <linux/pinctrl/pinconf.h>
> >
> > Removing pinconf.h from the core.h may cause build failure in other files
> > because where-ever core.h is included to use ?struct pinconf_ops?, there
> > is a need to include pinconf.h.
> 
> I can confirm adding
> 
>     #include <linux/pinctrl/pinconf.h>
> 
> to drivers/pinctrl/renesas/pinctrl-rzn1.c and drivers/pinctrl/pinctrl-single.c
> fixes the issues I was seeing with shmobile_defconfig and (out-of-tree)
> renesas_defconfig.

I will add this, thank you for reporting.

-- 
With Best Regards,
Andy Shevchenko


