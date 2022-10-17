From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 17 Oct 2022 15:15:51 +0300
Subject: [PATCH v2 01/36] gpiolib: tegra186: Add missed header(s)
In-Reply-To: <CAMRc=MexjuQw+hUDDfCVxiBEJ573jNb3Ko9SyOU-xJ03wOe8cQ@mail.gmail.com>
References: <20221010201453.77401-1-andriy.shevchenko@linux.intel.com>
 <20221010201453.77401-2-andriy.shevchenko@linux.intel.com>
 <CACRpkdbdzFR-a_xh8EjLMAshTeesOYhD3-_Bkc=vi7iK72ZKtA@mail.gmail.com> <CAMRc=MexjuQw+hUDDfCVxiBEJ573jNb3Ko9SyOU-xJ03wOe8cQ@mail.gmail.com>
Message-ID: <CAHp75VftkwPB-+jhCrhCdPRN0hLm5DLADMyAO45eBTRFfxiNuQ@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Oct 17, 2022 at 12:35 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> On Mon, Oct 17, 2022 at 10:52 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>>?On Mon, Oct 10, 2022 at 10:15 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> >
> > > Do not imply that some of the generic headers may be always included.
> > > Instead, include explicitly what we are direct user of.
> > >
> > > While at it, sort headers alphabetically.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> Andy: are you going to send it together with the corresponding pinctrl
> changes in a separate PR?

Yes, this is the plan, but I want first to push it to Linux Next (via
my tree) for a couple of days, so we will be sure there are no
compilation issues.

-- 
With Best Regards,
Andy Shevchenko
