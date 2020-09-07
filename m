From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 7 Sep 2020 12:25:31 +0200
Subject: [PATCH 0/6] mmc: Set PROBE_PREFER_ASYNCHRONOUS for all host
 drivers
In-Reply-To: <CAGb2v67dPaV9tP4piV9MHe9QeJAq0RyvOO3ypJ3ZBW1-ffpjKA@mail.gmail.com>
References: <20200903232441.2694866-1-dianders@chromium.org>
 <CAFBinCBcbEpHX7eUbznuDo6oKO_9JrOK2w+Bx1=e-bwuS609bw@mail.gmail.com>
 <CANAwSgTv2ZAvPKG2aChs8NwZL32TF+MtcaFbehQWWSf_TFXF6A@mail.gmail.com>
 <CAGb2v67dPaV9tP4piV9MHe9QeJAq0RyvOO3ypJ3ZBW1-ffpjKA@mail.gmail.com>
Message-ID: <CAPDyKFoNFEa4ssv3TXbj4KM0UGjJgcp3dtypwicxJ-bExBL28A@mail.gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 7 Sep 2020 at 06:08, Chen-Yu Tsai <wens@kernel.org> wrote:
>
> (Resent from kernel.org)
>
> On Mon, Sep 7, 2020 at 11:57 AM Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > Hi Martin.
> >
> > On Sat, 5 Sep 2020 at 03:24, Martin Blumenstingl
> > <martin.blumenstingl@googlemail.com> wrote:
> > >
> > > Hi Douglas,
> > >
> > > On Fri, Sep 4, 2020 at 1:25 AM Douglas Anderson <dianders@chromium.org> wrote:
> > > >
> > > > As per discussion [1], it seems like it should be quite safe to turn
> > > > on PROBE_PREFER_ASYNCHRONOUS for all sd/mmc host controllers.  Let's
> > > > give it a shot.  For some discussion about this flag, see the commit
> > > > message for commit 3d3451124f3d ("mmc: sdhci-msm: Prefer asynchronous
> > > > probe").
> > > can this somehow change the order in which the MMC drivers end up loading?
> > > on Amlogic SoCs we have up to three MMC controllers, some SoCs even
> > > use two different MMC controller IPs (and therefore two different
> > > drivers).
> > > so far the MMC controller naming (/dev/mmcblk* etc.) was consistent -
> > > can that change with this patch?
> > >

Consistency has never been guaranteed. Just imagine one of the mmc
host drivers ending up lacking some of its resources during ->probe()
and returning -EPROBE_DEFER.

UUID/PARTID has been the only way.

> >
> > We could resolve this by setting up aliases for mmc nodes in the dts.

Yes, this is now possible due to the recently [1] applied patches for
supporting mmc aliases.

>
> Right now, only the dw_mmc driver family supports aliases for mmc nodes.

That's "mshc" specific (related to the old multiple slot support I
think), but not affecting the mmc aliases, which the mmc core now is
supporting.

So the mmc aliases are common for all mmc hosts. Please have a look at
the new OF parsing in mmc_alloc_host().

[...]

Kind regards
Uffe

[1]
https://patchwork.kernel.org/patch/11747669/
https://patchwork.kernel.org/patch/11747671/
