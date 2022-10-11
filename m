From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Tue, 11 Oct 2022 18:19:13 +0300
Subject: [PATCH v2 02/36] gpiolib: cdev: Add missed header(s)
In-Reply-To: <CAMuHMdUhSKuJ3N5zf_+ad_dFu6kSmVTqRpgFUWtd54S9ryw=ew@mail.gmail.com>
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
 <20221010201453.77401-3-andriy.shevchenko@linux.intel.com>
 <Y0SyVwjDl7NGfTPn@sol>
 <CAHp75Vf4oS8g0zxgismtLrzsJ7AE-bdMEq+GAzx2=Mwnhuk3UA@mail.gmail.com>
 <Y0V0IXF3sASTGdMU@smile.fi.intel.com>
 <Y0V57gI75ik4ki3A@sol>
 <Y0V9eJX7a0fe6EfX@smile.fi.intel.com>
 <CAMuHMdUhSKuJ3N5zf_+ad_dFu6kSmVTqRpgFUWtd54S9ryw=ew@mail.gmail.com>
Message-ID: <Y0WJcXzkkK4oGbrR@smile.fi.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Oct 11, 2022 at 04:39:46PM +0200, Geert Uytterhoeven wrote:
> On Tue, Oct 11, 2022 at 4:31 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Oct 11, 2022 at 10:13:02PM +0800, Kent Gibson wrote:
> > > On Tue, Oct 11, 2022 at 04:48:17PM +0300, Andy Shevchenko wrote:
> > > > On Tue, Oct 11, 2022 at 11:05:42AM +0300, Andy Shevchenko wrote:
> > > > > On Tue, Oct 11, 2022 at 3:02 AM Kent Gibson <warthog618@gmail.com> wrote:
> > > > > > On Mon, Oct 10, 2022 at 11:14:18PM +0300, Andy Shevchenko wrote:

...

> > > > > > > -#include <linux/gpio.h>
> > > > > > >  #include <linux/gpio/driver.h>
> > > > > > > +#include <linux/gpio.h>
> > > > > > > +#include <linux/hte.h>
> > > > > >
> > > > > > Ok with the hte re-order.
> > > > > >
> > > > > > But moving the gpio subsystem header after the gpio/driver is not
> > > > > > alphabetical ('.' precedes '/') and it read better and made more sense
> > > > > > to me the way it was.
> > > > >
> > > > > I see, I guess this is vim sort vs shell sort. Strange, they should
> > > > > follow the locale settings...
> > > >
> > > > I have checked, the shell and vim sort gave the same result as in this patch.
> > > >
> > >
> > > The original order (sans hte.h) was done by VSCode Sort Lines Ascending,
> > > and that still returns the same result.  That matches what I would
> > > expect to see given the content of the text.
> > >
> > > And for me vim also gives the original order.
> > >
> > > Just to confirm - is '.' 0x2e and '/' 0x2f in your universe?
> >
> > $ LC_COLLATE=C sort test1.txt
> > #include <linux/gpio.h>
> > #include <linux/gpio/driver.h>
> >
> > $ LC_COLLATE= sort test1.txt
> > #include <linux/gpio/driver.h>
> > #include <linux/gpio.h>
> >
> > I guess this explains the difference. Currently I have en_US.UTF-8.
> 
> Throwing my can of paint into the mix...
> 
> I think it is more logical to first include the general <linux/gpio.h>,
> followed by whatever <linux/gpio-foo.h> and <linux/gpio/bar.h>,
> irrespective of (language-specific or phonebook) sort order.
> 
> Yeah, it sucks that this requires some manual work after running sort...

It seems that kind of issue is in this patch only.

-- 
With Best Regards,
Andy Shevchenko


