From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Tue, 18 Oct 2022 16:07:46 +0300
Subject: [PATCH v2 36/36] pinctrl: Clean up headers
In-Reply-To: <CAMuHMdVU-cTBMzgBrbzA9+ZYybVS8kdYaA9spU9oDfqrLMvCuA@mail.gmail.com>
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
 <20221010201453.77401-37-andriy.shevchenko@linux.intel.com>
 <d63088d7-202b-a550-01e5-345a22de5f7d@amd.com>
 <CAMuHMdUfdQnisexfs4yLjeKs-LUPY1HjChrgeNjNL1qSErir9Q@mail.gmail.com>
 <Y0UyOWALxSFai2w6@smile.fi.intel.com>
 <CAMuHMdVU-cTBMzgBrbzA9+ZYybVS8kdYaA9spU9oDfqrLMvCuA@mail.gmail.com>
Message-ID: <Y06lIq+2+MPRL45W@smile.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Oct 18, 2022 at 03:04:44PM +0200, Geert Uytterhoeven wrote:
> On Tue, Oct 11, 2022 at 11:07 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Oct 11, 2022 at 10:46:30AM +0200, Geert Uytterhoeven wrote:
> > > On Tue, Oct 11, 2022 at 9:31 AM Basavaraj Natikar <bnatikar@amd.com> wrote:

...

> > > I can confirm adding
> > >
> > >     #include <linux/pinctrl/pinconf.h>
> > >
> > > to drivers/pinctrl/renesas/pinctrl-rzn1.c and drivers/pinctrl/pinctrl-single.c
> > > fixes the issues I was seeing with shmobile_defconfig and (out-of-tree)
> > > renesas_defconfig.
> >
> > I will add this, thank you for reporting.
> 
> Same for drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c.

Thanks!

Not only. I have updated all of them (but missed zynq (it is in today's Linux
Next).

-- 
With Best Regards,
Andy Shevchenko


