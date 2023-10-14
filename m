From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Sat, 14 Oct 2023 23:59:18 +0200
Subject: [GIT PULL] Convert drivers/soc to struct
 platform_driver::remove_new()
In-Reply-To: <20230928061449.xxqhyyrg6e357dn2@pengutronix.de>
References: <20230925095532.1984344-1-u.kleine-koenig@pengutronix.de>
 <CACPK8XeROYz_XaB3TvUhdXm7Vm8fjC8yU+mfvA58=_FiDrBy-g@mail.gmail.com>
 <1b2fddf8-c0a6-4afa-8ad0-f280dea1607f@app.fastmail.com>
 <f4hvrslynlgmxu4a2gogc5idvumskhaalxgwildy56yqk2wz7d@lkh4swkv52mi>
 <20230928061449.xxqhyyrg6e357dn2@pengutronix.de>
Message-ID: <20231014215918.prqhkk7kp2vobe3a@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Arnd,

the following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  https://git.pengutronix.de/git/ukl/linux tags/platform-remove-void-soc-for-6.7-rc

for you to fetch changes up to e77e6e3e909d33361c58af848a96e1f7f71ba7e4:

  soc/pxa: ssp: Convert to platform remove callback returning void (2023-10-14 23:27:34 +0200)

----------------------------------------------------------------
Convert drivers/soc to struct platform_driver::remove_new()

This PR contains the patches I sent in the series available at
https://lore.kernel.org/all/20230925095532.1984344-1-u.kleine-koenig at pengutronix.de
that were not yet picked up in next as of next-20231013.

It converts all drivers below drivers/soc to let their remove callback
return void. See commit 5c5a7680e67b ("platform: Provide a remove
callback that returns no value") for the rationale.

----------------------------------------------------------------

On Thu, Sep 28, 2023 at 08:14:49AM +0200, Uwe Kleine-K?nig wrote:
> On Wed, Sep 27, 2023 at 04:01:58PM -0700, Bjorn Andersson wrote:
> > On Wed, Sep 27, 2023 at 10:43:16AM +0200, Arnd Bergmann wrote:
> > > On Wed, Sep 27, 2023, at 04:25, Joel Stanley wrote:
> > > > On Mon, 25 Sept 2023 at 09:55, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:
> > > >>
> > > >> this series converts all platform drivers below drivers/soc to use
> > > >> .remove_new(). The motivation is to get rid of an integer return code
> > > >> that is (mostly) ignored by the platform driver core and error prone on
> > > >> the driver side.
> > > >>
> > > >> See commit 5c5a7680e67b ("platform: Provide a remove callback that
> > > >> returns no value") for an extended explanation and the eventual goal.
> > > >>
> > > >> As there is no single maintainer team for drivers/soc, I suggest the
> > > >> individual maintainers to pick up "their" patches.
> > > >
> > > > I'd be happy if Arnd merged the lot at once. Arnd, what do you think?
> > > >
> > > > If that will be too messy then I understand. I have queued the aspeed
> > > > ones locally and will push that out if we decide that's the best way
> > > > to go.
> > > 
> > > The main downside of merging it all at once through the soc tree
> > > is that there may be patches that conflict with other work going on
> > > in individual drivers.
> > > 
> > > What I'd suggest doing here is:
> > > 
> > > - have platform maintainers pick up patches for their drivers
> > >   if that is their preference for any reason
> > 
> > I'd prefer this for the qcom drivers at least, please let me know if you
> > would like me to proceed.
>
> I can send a pull request as Arnd suggested. So iff you want the qcom
> drivers not be a part of that PR, just make sure they appear in next
> during the next week. :-)
>
> > > - get a pull request from Uwe for the soc tree for anything that has
> > >  not been picked up in one or two weeks from now

Here comes the promised PR. The qcom patches are among the set of
patches dropped here as they are already in next.

To state the obvious: This is merge window material and the idea is that
it's pulled into armsoc and then included in the armsoc v6.7-rc1 PR to
Linus Torvalds. I hope it's not too late for that already.

Best regards and thanks
Uwe

Uwe Kleine-K?nig (12):
      soc/fsl: dpaa2-console: Convert to platform remove callback returning void
      soc/fsl: cpm: qmc: Convert to platform remove callback returning void
      soc/fsl: cpm: tsa: Convert to platform remove callback returning void
      soc/fujitsu: a64fx-diag: Convert to platform remove callback returning void
      soc/hisilicon: kunpeng_hccs: Convert to platform remove callback returning void
      soc/ixp4xx: ixp4xx-npe: Convert to platform remove callback returning void
      soc/ixp4xx: ixp4xx-qmgr: Convert to platform remove callback returning void
      soc/litex: litex_soc_ctrl: Convert to platform remove callback returning void
      soc/loongson: loongson2_guts: Convert to platform remove callback returning void
      soc/mediatek: mtk-devapc: Convert to platform remove callback returning void
      soc/mediatek: mtk-mmsys: Convert to platform remove callback returning void
      soc/pxa: ssp: Convert to platform remove callback returning void

 drivers/soc/fsl/dpaa2-console.c       | 6 ++----
 drivers/soc/fsl/qe/qmc.c              | 6 ++----
 drivers/soc/fsl/qe/tsa.c              | 5 ++---
 drivers/soc/fujitsu/a64fx-diag.c      | 6 ++----
 drivers/soc/hisilicon/kunpeng_hccs.c  | 6 ++----
 drivers/soc/ixp4xx/ixp4xx-npe.c       | 6 ++----
 drivers/soc/ixp4xx/ixp4xx-qmgr.c      | 5 ++---
 drivers/soc/litex/litex_soc_ctrl.c    | 5 ++---
 drivers/soc/loongson/loongson2_guts.c | 6 ++----
 drivers/soc/mediatek/mtk-devapc.c     | 6 ++----
 drivers/soc/mediatek/mtk-mmsys.c      | 6 ++----
 drivers/soc/pxa/ssp.c                 | 6 ++----
 12 files changed, 24 insertions(+), 45 deletions(-)

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20231014/c57fa4cc/attachment.sig>
