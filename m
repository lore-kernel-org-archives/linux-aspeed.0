From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 19 Jun 2023 11:45:37 +0200
Subject: patches dropped from drm-misc-next [Was: Re: [PATCH 00/53] drm:
 Convert to platform remove callback returning] void
In-Reply-To: <20230618162950.6th2yo66baqay5mv@pengutronix.de>
References: <20230507162616.1368908-1-u.kleine-koenig@pengutronix.de>
 <20230601154002.uv2wfatpb7b45duz@pengutronix.de>
 <CAD=FV=WvP--wJwBQtnSoW_xb57R1Wf9dH0XzWxe+NorczXfeAw@mail.gmail.com>
 <20230617161222.wy55pbomnrrlfy5u@pengutronix.de>
 <CAD=FV=U5gbMUNteyyFcTvHVBDWzfthM0aDirJC+yXGovDwMOBA@mail.gmail.com>
 <20230618123915.hmy66z7e532jhwgk@pengutronix.de>
 <jlq2xayh4dxfigfsh2fms2kt4hlrqcwxblffmqq7czbhqhhvz7@hsvol72f5i3y>
 <20230618162950.6th2yo66baqay5mv@pengutronix.de>
Message-ID: <vxjp5c4wojcvbnp3ghsspwkgrc4mjmskzl56jkuxlgfhcji7kx@m3hg525p7y6a>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Jun 18, 2023 at 06:29:50PM +0200, Uwe Kleine-K?nig wrote:
> Hello Maxime,
> 
> On Sun, Jun 18, 2023 at 04:32:55PM +0200, Maxime Ripard wrote:
> > On Sun, Jun 18, 2023 at 02:39:15PM +0200, Uwe Kleine-K?nig wrote:
> > > On Sat, Jun 17, 2023 at 10:57:23AM -0700, Doug Anderson wrote:
> > > > On Sat, Jun 17, 2023 at 9:15?AM Uwe Kleine-K?nig
> > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > > Together with the patches that were applied later the topmost commit
> > > > > from this series is c2807ecb5290 ("drm/omap: Convert to platform remove
> > > > > callback returning void"). This commit was part for the following next
> > > > > tags:
> > > > >
> > > > >         $ git tag -l --contains c2807ecb5290
> > > > >         next-20230609
> > > > >         next-20230613
> > > > >         next-20230614
> > > > >         next-20230615
> > > > >
> > > > > However in next-20230616 they are missing. In next-20230616
> > > > > drm-misc/for-linux-next was cf683e8870bd4be0fd6b98639286700a35088660.
> > > > > Compared to c2807ecb5290 this adds 1149 patches but drops 37 (that are
> > > > > also not included with a different commit id). The 37 patches dropped
> > > > > are 13cdd12a9f934158f4ec817cf048fcb4384aa9dc..c2807ecb5290:
> > > > >
> > > > >         $ git shortlog -s 13cdd12a9f934158f4ec817cf048fcb4384aa9dc..c2807ecb5290
> > > > >              1  Christophe JAILLET
> > > > >              2  Jessica Zhang
> > > > >              5  Karol Wachowski
> > > > >              1  Laura Nao
> > > > >             27  Uwe Kleine-K?nig
> > > > >              1  Wang Jianzheng
> > > > >
> > > > >
> > > > > I guess this was done by mistake because nobody told me about dropping
> > > > > my/these patches? Can c2807ecb5290 please be merged into drm-misc-next
> > > > > again?
> > > > 
> > > > Actually, it was probably a mistake that these patches got merged to
> > > > linuxnext during the 4 days that you noticed. However, your patches
> > > > aren't dropped and are still present in drm-misc-next.
> > > > 
> > > > drm-misc has a bit of a unique model and it's documented fairly well here:
> > > > 
> > > > https://drm.pages.freedesktop.org/maintainer-tools/drm-misc.html
> > > 
> > > Is there a flaw then in this unique model (or its implementation) when
> > > drm-misc/for-linux-next moves in a non-fast-forward manner? This isn't
> > > expected, is it?
> > 
> > There's no expectation afaik. Any tree merged in linux-next can be
> > rebased, drop a patch, amend one, etc. without any concern.
> 
> I agree that there are no rules broken for a tree that is included in
> next and a maintainer is free to rewrite their tree independant of the
> tree being included in next.
> 
> Still I think that shouldn't be used as an excuse.

As an excuse for what?

> For me, if a maintainer puts some patch into next that's a statement
> saying (approximately) "I think this patch is fine and I intend to
> send it to Linus during the next merge window.".

I mean, that's what we're saying and doing?

> So my expectation is that if a patch is dropped again from next, there
> was a problem and it would be fair if the maintainer tells the
> author/submitter about this problem and that the patch was dropped.

But it wasn't dropped, it's still very much to be sent to Linus during
the next merge window.

> So my concern is not about rule breaking, but about the strange signal
> that is sent to contributors by including their work in next for some
> time and then dropping it again without comment.
> 
> > It's also why linux-next is rebuilt entirely every day.
> > 
> > > > The key is that committers can commit to drm-misc-next _at any time_
> > > > regardless of the merge window. The drm-misc merge strategy makes this
> > > > OK. Specifically, when it's late in the linux cycle then drm-misc-next
> > > > is supposed to stop merging to linuxnext. Then, shortly after the
> > > > merge window closes, patches will start flowing again.
> > > > 
> > > > So basically your patches are landed and should even keep the same git
> > > > hashes when they eventually make it to Linux. They just won't land for
> > > > another release cycle of Linux.
> > > 
> > > OK, c2807ecb5290 is still included in drm-misc-next. So while I don't
> > > understand the whole model, the patches at least seem to be scheduled to
> > > go in during the next merge window.
> > 
> > It's not that complicated.
> > 
> > drm-misc-next is always open, and we start targeting release X + 2 when
> > X-rc6 is released.
> > 
> > This is due to Linus wanting all the commits sent as part of the PR in
> > linux-next for two weeks.
> > 
> > In order to converge towards (X + 1)-rc1 in linux-next, as soon as X-rc6
> > is released, we remove drm-misc-next from the linux-next branch. All the
> > patches in drm-misc-next that were targetting X + 1 are in drm/next by
> > then, so it's not a concern.
> 
> So if I were a maintainer of drm-misc, I'd want that no commit from
> drm-misc-next migrates to next after -rc6.
> 
> Also note that the branch head in question (i.e. c2807ecb5290) was
> included in next-20230609, while v6.4-rc6 was tagged on Jun 11. So
> according to the rules you described c2807ecb5290 could have been
> qualified to go into v6.5-rc1?!

Yes, could have, but barely missed the last drm-misc-next PR we sent to
Dave that usually occurs on Thursday (8/6) so Dave can merge it on
Friday (9/6), the last working day before -rc6 was released.

Maxime
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230619/63dca5ea/attachment-0001.sig>
