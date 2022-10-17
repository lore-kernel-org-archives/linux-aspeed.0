From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 17 Oct 2022 11:58:03 +0200
Subject: [rft, PATCH v2 00/36] pinctrl: Clean up and add missed headers
In-Reply-To: <Y00f5exY2fM6IwZ+@smile.fi.intel.com>
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdZ1M3ckw+jFgvMqG4jvR-t_44GPoZ6ZDXszwZCJr-cDpg@mail.gmail.com> <Y00f5exY2fM6IwZ+@smile.fi.intel.com>
Message-ID: <CACRpkdYmSOGtFz8W_RRkDqMXRRBOSB9jqSn65Sah90bf3Gm59g@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Oct 17, 2022 at 11:27 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, Oct 17, 2022 at 11:02:09AM +0200, Linus Walleij wrote:
> > On Mon, Oct 10, 2022 at 10:15 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> >
> > > Currently the header inclusion inside the pinctrl headers seems more arbitrary
> > > than logical. This series is basically out of two parts:
> > > - add missed headers to the pin control drivers / users
> > > - clean up the headers of pin control subsystem
> > >
> > > The idea is to have this series to be pulled after -rc1 by the GPIO and
> > > pin control subsystems, so all new drivers will utilize cleaned up headers
> > > of the pin control.
> >
> > Aha I see you want to send a pull request so I backed out the applied patches
> > from the series for now.
>
> Can I consider all that you answered to as Rb tag?

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I haven't reviewed in detail but I fully trust you to do the right thing
and fix any fallout so will happily pull this.

Yours,
Linus Walleij
