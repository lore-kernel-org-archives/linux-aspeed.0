From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Oct 2022 15:04:44 +0200
Subject: [PATCH v2 36/36] pinctrl: Clean up headers
In-Reply-To: <Y0UyOWALxSFai2w6@smile.fi.intel.com>
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
 <20221010201453.77401-37-andriy.shevchenko@linux.intel.com>
 <d63088d7-202b-a550-01e5-345a22de5f7d@amd.com> <CAMuHMdUfdQnisexfs4yLjeKs-LUPY1HjChrgeNjNL1qSErir9Q@mail.gmail.com>
 <Y0UyOWALxSFai2w6@smile.fi.intel.com>
Message-ID: <CAMuHMdVU-cTBMzgBrbzA9+ZYybVS8kdYaA9spU9oDfqrLMvCuA@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Andy,

On Tue, Oct 11, 2022 at 11:07 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Tue, Oct 11, 2022 at 10:46:30AM +0200, Geert Uytterhoeven wrote:
> > On Tue, Oct 11, 2022 at 9:31 AM Basavaraj Natikar <bnatikar@amd.com> wrote:
> > > On 10/11/2022 1:44 AM, Andy Shevchenko wrote:
>
> > > > +++ b/drivers/pinctrl/core.h
>
> > > > -#include <linux/pinctrl/pinconf.h>
> > >
> > > Removing pinconf.h from the core.h may cause build failure in other files
> > > because where-ever core.h is included to use ?struct pinconf_ops?, there
> > > is a need to include pinconf.h.
> >
> > I can confirm adding
> >
> >     #include <linux/pinctrl/pinconf.h>
> >
> > to drivers/pinctrl/renesas/pinctrl-rzn1.c and drivers/pinctrl/pinctrl-single.c
> > fixes the issues I was seeing with shmobile_defconfig and (out-of-tree)
> > renesas_defconfig.
>
> I will add this, thank you for reporting.

Same for drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
