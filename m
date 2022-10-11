From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 11 Oct 2022 10:46:30 +0200
Subject: [PATCH v2 36/36] pinctrl: Clean up headers
In-Reply-To: <d63088d7-202b-a550-01e5-345a22de5f7d@amd.com>
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
 <20221010201453.77401-37-andriy.shevchenko@linux.intel.com> <d63088d7-202b-a550-01e5-345a22de5f7d@amd.com>
Message-ID: <CAMuHMdUfdQnisexfs4yLjeKs-LUPY1HjChrgeNjNL1qSErir9Q@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Oct 11, 2022 at 9:31 AM Basavaraj Natikar <bnatikar@amd.com> wrote:
> On 10/11/2022 1:44 AM, Andy Shevchenko wrote:
> > There is a few things done:
> > - include only the headers we are direct user of
> > - when pointer is in use, provide a forward declaration
> > - add missed headers
> > - group generic headers and subsystem headers
> > - sort each group alphabetically
> >
> > While at it, fix some awkward indentations.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/pinctrl/core.c                  | 19 ++++++++-------
> >  drivers/pinctrl/core.h                  | 12 +++++++++-
> >  drivers/pinctrl/devicetree.h            |  6 +++++
> >  drivers/pinctrl/pinconf.h               | 10 ++++++++
> >  drivers/pinctrl/pinctrl-utils.h         |  5 ++++
> >  drivers/pinctrl/pinmux.c                | 17 ++++++++------
> >  drivers/pinctrl/pinmux.h                | 11 +++++++++
> >  include/linux/pinctrl/consumer.h        | 31 +++++++++++--------------
> >  include/linux/pinctrl/devinfo.h         |  6 +++--
> >  include/linux/pinctrl/machine.h         |  8 ++++---
> >  include/linux/pinctrl/pinconf-generic.h | 23 ++++++++++--------
> >  include/linux/pinctrl/pinctrl.h         | 18 +++++++-------
> >  include/linux/pinctrl/pinmux.h          |  5 ++--
> >  13 files changed, 110 insertions(+), 61 deletions(-)
> >
> > diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
> > index 9e57f4c62e60..655f9502e73f 100644
> > --- a/drivers/pinctrl/core.c
> > +++ b/drivers/pinctrl/core.c
> > @@ -12,19 +12,21 @@
> >   */
> >  #define pr_fmt(fmt) "pinctrl core: " fmt
> >
> > -#include <linux/kernel.h>
> > -#include <linux/kref.h>
> > -#include <linux/export.h>
> > -#include <linux/init.h>
> > +#include <linux/debugfs.h>
> >  #include <linux/device.h>
> > -#include <linux/slab.h>
> >  #include <linux/err.h>
> > +#include <linux/export.h>
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/kref.h>
> >  #include <linux/list.h>
> > -#include <linux/debugfs.h>
> >  #include <linux/seq_file.h>
> > +#include <linux/slab.h>
> > +
> >  #include <linux/pinctrl/consumer.h>
> > -#include <linux/pinctrl/pinctrl.h>
> > +#include <linux/pinctrl/devinfo.h>
> >  #include <linux/pinctrl/machine.h>
> > +#include <linux/pinctrl/pinctrl.h>
> >
> >  #ifdef CONFIG_GPIOLIB
> >  #include "../gpio/gpiolib.h"
> > @@ -33,9 +35,8 @@
> >
> >  #include "core.h"
> >  #include "devicetree.h"
> > -#include "pinmux.h"
> >  #include "pinconf.h"
> > -
> > +#include "pinmux.h"
> >
> >  static bool pinctrl_dummy_state;
> >
> > diff --git a/drivers/pinctrl/core.h b/drivers/pinctrl/core.h
> > index 840103c40c14..4d0bdb9fb99b 100644
> > --- a/drivers/pinctrl/core.h
> > +++ b/drivers/pinctrl/core.h
> > @@ -9,12 +9,22 @@
> >   */
> >
> >  #include <linux/kref.h>
> > +#include <linux/list.h>
> >  #include <linux/mutex.h>
> >  #include <linux/radix-tree.h>
> > -#include <linux/pinctrl/pinconf.h>
>
> Removing pinconf.h from the core.h may cause build failure in other files
> because where-ever core.h is included to use ?struct pinconf_ops?, there
> is a need to include pinconf.h.

I can confirm adding

    #include <linux/pinctrl/pinconf.h>

to drivers/pinctrl/renesas/pinctrl-rzn1.c and drivers/pinctrl/pinctrl-single.c
fixes the issues I was seeing with shmobile_defconfig and (out-of-tree)
renesas_defconfig.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
