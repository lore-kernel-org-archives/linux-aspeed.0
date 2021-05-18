From: David Gow <davidgow@google.com>
Date: Tue, 18 May 2021 12:29:22 +0800
Subject: [PATCH v2 06/10] mmc: sdhci-of-aspeed: Remove some unnecessary
 casts from KUnit tests
In-Reply-To: <CAPDyKFoEeRUjHLZ3iSvPT4_0X107G3Xw+ujxJ9zsDk06dTxo7w@mail.gmail.com>
References: <20210513193204.816681-1-davidgow@google.com>
 <20210513193204.816681-6-davidgow@google.com>
 <CAPDyKFoEeRUjHLZ3iSvPT4_0X107G3Xw+ujxJ9zsDk06dTxo7w@mail.gmail.com>
Message-ID: <CABVgOSmv6axdgXLPAwb=q0_RRL44Kbd73SLf=UogEM-k7WMNLw@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, May 17, 2021 at 5:23 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 13 May 2021 at 21:36, David Gow <davidgow@google.com> wrote:
> >
> > With KUnit's EXPECT macros no longer typechecking arguments as strictly,
> > get rid of a number of now unnecessary casts.
> >
> > Signed-off-by: David Gow <davidgow@google.com>
>
> I guess you will funnel this via another tree than the mmc?
>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Kind regards
> Uffe
>

Yeah: the plan is to have this whole series go through the
kselftest/kunit tree so we don't have to worry about potentially
temporarily introducing a bunch of compiler warnings.

Cheers,
-- David

> > ---
> > This should be a no-op functionality wise, and while it depends on the
> > first couple of patches in this series, it's otherwise independent from
> > the others. I think this makes the test more readable, but if you
> > particularly dislike it, I'm happy to drop it.
> >
> >  drivers/mmc/host/sdhci-of-aspeed-test.c | 34 ++++++++++++-------------
> >  1 file changed, 17 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-of-aspeed-test.c b/drivers/mmc/host/sdhci-of-aspeed-test.c
> > index bb67d159b7d8..1ed4f86291f2 100644
> > --- a/drivers/mmc/host/sdhci-of-aspeed-test.c
> > +++ b/drivers/mmc/host/sdhci-of-aspeed-test.c
> > @@ -26,23 +26,23 @@ static void aspeed_sdhci_phase_ddr52(struct kunit *test)
> >         KUNIT_EXPECT_EQ(test, 15,
> >                         aspeed_sdhci_phase_to_tap(NULL, rate, 25));
> >
> > -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 0,
> > +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 0,
> >                         aspeed_sdhci_phase_to_tap(NULL, rate, 180));
> > -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 0,
> > +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 0,
> >                         aspeed_sdhci_phase_to_tap(NULL, rate, 181));
> > -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
> > +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
> >                         aspeed_sdhci_phase_to_tap(NULL, rate, 182));
> > -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
> > +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
> >                         aspeed_sdhci_phase_to_tap(NULL, rate, 183));
> > -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 2,
> > +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 2,
> >                         aspeed_sdhci_phase_to_tap(NULL, rate, 184));
> > -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 3,
> > +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 3,
> >                         aspeed_sdhci_phase_to_tap(NULL, rate, 185));
> > -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 14,
> > +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 14,
> >                         aspeed_sdhci_phase_to_tap(NULL, rate, 203));
> > -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
> > +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
> >                         aspeed_sdhci_phase_to_tap(NULL, rate, 204));
> > -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
> > +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
> >                         aspeed_sdhci_phase_to_tap(NULL, rate, 205));
> >  }
> >
> > @@ -67,21 +67,21 @@ static void aspeed_sdhci_phase_hs200(struct kunit *test)
> >         KUNIT_EXPECT_EQ(test, 15,
> >                         aspeed_sdhci_phase_to_tap(NULL, rate, 96));
> >
> > -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK,
> > +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK,
> >                         aspeed_sdhci_phase_to_tap(NULL, rate, 180));
> > -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK,
> > +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK,
> >                         aspeed_sdhci_phase_to_tap(NULL, rate, 185));
> > -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
> > +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
> >                         aspeed_sdhci_phase_to_tap(NULL, rate, 186));
> > -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
> > +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 1,
> >                         aspeed_sdhci_phase_to_tap(NULL, rate, 187));
> > -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 14,
> > +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 14,
> >                         aspeed_sdhci_phase_to_tap(NULL, rate, 269));
> > -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
> > +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
> >                         aspeed_sdhci_phase_to_tap(NULL, rate, 270));
> > -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
> > +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
> >                         aspeed_sdhci_phase_to_tap(NULL, rate, 271));
> > -       KUNIT_EXPECT_EQ(test, (int)ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
> > +       KUNIT_EXPECT_EQ(test, ASPEED_SDHCI_TAP_PARAM_INVERT_CLK | 15,
> >                         aspeed_sdhci_phase_to_tap(NULL, rate, 276));
> >  }
> >
> > --
> > 2.31.1.751.gd2f1c929bd-goog
> >
