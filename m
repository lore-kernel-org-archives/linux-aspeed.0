From: Maxime Ripard <mripard@kernel.org>
Date: Sun, 18 Jun 2023 16:32:55 +0200
Subject: patches dropped from drm-misc-next [Was: Re: [PATCH 00/53] drm:
 Convert to platform remove callback returning] void
In-Reply-To: <20230618123915.hmy66z7e532jhwgk@pengutronix.de>
References: <20230507162616.1368908-1-u.kleine-koenig@pengutronix.de>
 <20230601154002.uv2wfatpb7b45duz@pengutronix.de>
 <CAD=FV=WvP--wJwBQtnSoW_xb57R1Wf9dH0XzWxe+NorczXfeAw@mail.gmail.com>
 <20230617161222.wy55pbomnrrlfy5u@pengutronix.de>
 <CAD=FV=U5gbMUNteyyFcTvHVBDWzfthM0aDirJC+yXGovDwMOBA@mail.gmail.com>
 <20230618123915.hmy66z7e532jhwgk@pengutronix.de>
Message-ID: <jlq2xayh4dxfigfsh2fms2kt4hlrqcwxblffmqq7czbhqhhvz7@hsvol72f5i3y>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Jun 18, 2023 at 02:39:15PM +0200, Uwe Kleine-K?nig wrote:
> Hello Doug,
> 
> On Sat, Jun 17, 2023 at 10:57:23AM -0700, Doug Anderson wrote:
> > On Sat, Jun 17, 2023 at 9:15?AM Uwe Kleine-K?nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > >
> > > [expanding recipents by the other affected persons]
> > >
> > > On Thu, Jun 08, 2023 at 09:08:15AM -0700, Doug Anderson wrote:
> > > > On Thu, Jun 1, 2023 at 8:40?AM Uwe Kleine-K?nig
> > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > On Sun, May 07, 2023 at 06:25:23PM +0200, Uwe Kleine-K?nig wrote:
> > > > > > this patch series adapts the platform drivers below drivers/gpu/drm
> > > > > > to use the .remove_new() callback. Compared to the traditional .remove()
> > > > > > callback .remove_new() returns no value. This is a good thing because
> > > > > > the driver core doesn't (and cannot) cope for errors during remove. The
> > > > > > only effect of a non-zero return value in .remove() is that the driver
> > > > > > core emits a warning. The device is removed anyhow and an early return
> > > > > > from .remove() usually yields a resource leak.
> > > > > >
> > > > > > By changing the remove callback to return void driver authors cannot
> > > > > > reasonably (but wrongly) assume any more that there happens some kind of
> > > > > > cleanup later.
> > > > >
> > > > > I wonder if someone would volunteer to add the whole series to
> > > > > drm-misc-next?!
> > > >
> > > > It looks as if Neil applied quite a few of them already, so I looked
> > > > at what was left...
> > > >
> > > > I'm a little hesitant to just apply the whole kit-and-caboodle to
> > > > drm-misc-next since there are specific DRM trees for a bunch of them
> > > > and it would be better if they landed there. ...so I went through all
> > > > the patches that still applied to drm-misc-next, then used
> > > > 'scripts/get_maintainer.pl --scm' to check if they were maintained
> > > > through drm-misc. That still left quite a few patches. I've applied
> > > > those ones and pushed to drm-misc-next:
> > > >
> > > > 71722685cd17 drm/xlnx/zynqmp_dpsub: Convert to platform remove
> > > > callback returning void
> > > > 1ed54a19f3b3 drm/vc4: Convert to platform remove callback returning void
> > > > b957812839f8 drm/v3d: Convert to platform remove callback returning void
> > > > e2fd3192e267 drm/tve200: Convert to platform remove callback returning void
> > > > 84e6da7ad553 drm/tiny: Convert to platform remove callback returning void
> > > > 34cdd1f691ad drm/tidss: Convert to platform remove callback returning void
> > > > d665e3c9d37a drm/sun4i: Convert to platform remove callback returning void
> > > > 0c259ab19146 drm/stm: Convert to platform remove callback returning void
> > > > 9a865e45884a drm/sti: Convert to platform remove callback returning void
> > > > 3c855610840e drm/rockchip: Convert to platform remove callback returning void
> > > > e41977a83b71 drm/panfrost: Convert to platform remove callback returning void
> > > > cef3776d0b5a drm/panel: Convert to platform remove callback returning void
> > > > bd296a594e87 drm/mxsfb: Convert to platform remove callback returning void
> > > > 38ca2d93d323 drm/meson: Convert to platform remove callback returning void
> > > > fd1457d84bae drm/mcde: Convert to platform remove callback returning void
> > > > 41a56a18615c drm/logicvc: Convert to platform remove callback returning void
> > > > 980ec6444372 drm/lima: Convert to platform remove callback returning void
> > > > 82a2c0cc1a22 drm/hisilicon: Convert to platform remove callback returning void
> > > > c3b28b29ac0a drm/fsl-dcu: Convert to platform remove callback returning void
> > > > a118fc6e71f9 drm/atmel-hlcdc: Convert to platform remove callback returning void
> > > > 9a32dd324c46 drm/aspeed: Convert to platform remove callback returning void
> > > > 2c7d291c498c drm/arm/malidp: Convert to platform remove callback returning void
> > > > a920028df679 drm/arm/hdlcd: Convert to platform remove callback returning void
> > > > 1bf3d76a7d15 drm/komeda: Convert to platform remove callback returning void
> > >
> > > Together with the patches that were applied later the topmost commit
> > > from this series is c2807ecb5290 ("drm/omap: Convert to platform remove
> > > callback returning void"). This commit was part for the following next
> > > tags:
> > >
> > >         $ git tag -l --contains c2807ecb5290
> > >         next-20230609
> > >         next-20230613
> > >         next-20230614
> > >         next-20230615
> > >
> > > However in next-20230616 they are missing. In next-20230616
> > > drm-misc/for-linux-next was cf683e8870bd4be0fd6b98639286700a35088660.
> > > Compared to c2807ecb5290 this adds 1149 patches but drops 37 (that are
> > > also not included with a different commit id). The 37 patches dropped
> > > are 13cdd12a9f934158f4ec817cf048fcb4384aa9dc..c2807ecb5290:
> > >
> > >         $ git shortlog -s 13cdd12a9f934158f4ec817cf048fcb4384aa9dc..c2807ecb5290
> > >              1  Christophe JAILLET
> > >              2  Jessica Zhang
> > >              5  Karol Wachowski
> > >              1  Laura Nao
> > >             27  Uwe Kleine-K?nig
> > >              1  Wang Jianzheng
> > >
> > >
> > > I guess this was done by mistake because nobody told me about dropping
> > > my/these patches? Can c2807ecb5290 please be merged into drm-misc-next
> > > again?
> > 
> > Actually, it was probably a mistake that these patches got merged to
> > linuxnext during the 4 days that you noticed. However, your patches
> > aren't dropped and are still present in drm-misc-next.
> > 
> > drm-misc has a bit of a unique model and it's documented fairly well here:
> > 
> > https://drm.pages.freedesktop.org/maintainer-tools/drm-misc.html
> 
> Is there a flaw then in this unique model (or its implementation) when
> drm-misc/for-linux-next moves in a non-fast-forward manner? This isn't
> expected, is it?

There's no expectation afaik. Any tree merged in linux-next can be
rebased, drop a patch, amend one, etc. without any concern.

It's also why linux-next is rebuilt entirely every day.

> > The key is that committers can commit to drm-misc-next _at any time_
> > regardless of the merge window. The drm-misc merge strategy makes this
> > OK. Specifically, when it's late in the linux cycle then drm-misc-next
> > is supposed to stop merging to linuxnext. Then, shortly after the
> > merge window closes, patches will start flowing again.
> > 
> > So basically your patches are landed and should even keep the same git
> > hashes when they eventually make it to Linux. They just won't land for
> > another release cycle of Linux.
> 
> OK, c2807ecb5290 is still included in drm-misc-next. So while I don't
> understand the whole model, the patches at least seem to be scheduled to
> go in during the next merge window.

It's not that complicated.

drm-misc-next is always open, and we start targeting release X + 2 when
X-rc6 is released.

This is due to Linus wanting all the commits sent as part of the PR in
linux-next for two weeks.

In order to converge towards (X + 1)-rc1 in linux-next, as soon as X-rc6
is released, we remove drm-misc-next from the linux-next branch. All the
patches in drm-misc-next that were targetting X + 1 are in drm/next by
then, so it's not a concern.

Maxime
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230618/0a6b8456/attachment-0001.sig>
