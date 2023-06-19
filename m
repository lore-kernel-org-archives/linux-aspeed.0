From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 19 Jun 2023 14:47:09 +0200
Subject: patches dropped from drm-misc-next [Was: Re: [PATCH 00/53] drm:
 Convert to platform remove callback returning] void
In-Reply-To: <20230619105342.ugf5gz26gcalcsi6@pengutronix.de>
References: <20230507162616.1368908-1-u.kleine-koenig@pengutronix.de>
 <20230601154002.uv2wfatpb7b45duz@pengutronix.de>
 <CAD=FV=WvP--wJwBQtnSoW_xb57R1Wf9dH0XzWxe+NorczXfeAw@mail.gmail.com>
 <20230617161222.wy55pbomnrrlfy5u@pengutronix.de>
 <CAD=FV=U5gbMUNteyyFcTvHVBDWzfthM0aDirJC+yXGovDwMOBA@mail.gmail.com>
 <20230618123915.hmy66z7e532jhwgk@pengutronix.de>
 <jlq2xayh4dxfigfsh2fms2kt4hlrqcwxblffmqq7czbhqhhvz7@hsvol72f5i3y>
 <20230618162950.6th2yo66baqay5mv@pengutronix.de>
 <vxjp5c4wojcvbnp3ghsspwkgrc4mjmskzl56jkuxlgfhcji7kx@m3hg525p7y6a>
 <20230619105342.ugf5gz26gcalcsi6@pengutronix.de>
Message-ID: <a6ex232lwyovzzazfh6jfvlwszppr2624czgcc5sa4nthkgecf@asauiw3rf4vi>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jun 19, 2023 at 12:53:42PM +0200, Uwe Kleine-K?nig wrote:
> On Mon, Jun 19, 2023 at 11:45:37AM +0200, Maxime Ripard wrote:
> > On Sun, Jun 18, 2023 at 06:29:50PM +0200, Uwe Kleine-K?nig wrote:
> > > Hello Maxime,
> > > 
> > > On Sun, Jun 18, 2023 at 04:32:55PM +0200, Maxime Ripard wrote:
> > > > On Sun, Jun 18, 2023 at 02:39:15PM +0200, Uwe Kleine-K?nig wrote:
> > > > > On Sat, Jun 17, 2023 at 10:57:23AM -0700, Doug Anderson wrote:
> > > > > > On Sat, Jun 17, 2023 at 9:15?AM Uwe Kleine-K?nig
> > > > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > > > > Together with the patches that were applied later the topmost commit
> > > > > > > from this series is c2807ecb5290 ("drm/omap: Convert to platform remove
> > > > > > > callback returning void"). This commit was part for the following next
> > > > > > > tags:
> > > > > > >
> > > > > > >         $ git tag -l --contains c2807ecb5290
> > > > > > >         next-20230609
> > > > > > >         next-20230613
> > > > > > >         next-20230614
> > > > > > >         next-20230615
> > > > > > >
> > > > > > > However in next-20230616 they are missing. In next-20230616
> > > > > > > drm-misc/for-linux-next was cf683e8870bd4be0fd6b98639286700a35088660.
> > > > > > > Compared to c2807ecb5290 this adds 1149 patches but drops 37 (that are
> > > > > > > also not included with a different commit id). The 37 patches dropped
> > > > > > > are 13cdd12a9f934158f4ec817cf048fcb4384aa9dc..c2807ecb5290:
> > > > > > >
> > > > > > >         $ git shortlog -s 13cdd12a9f934158f4ec817cf048fcb4384aa9dc..c2807ecb5290
> > > > > > >              1  Christophe JAILLET
> > > > > > >              2  Jessica Zhang
> > > > > > >              5  Karol Wachowski
> > > > > > >              1  Laura Nao
> > > > > > >             27  Uwe Kleine-K?nig
> > > > > > >              1  Wang Jianzheng
> > > > > > >
> > > > > > >
> > > > > > > I guess this was done by mistake because nobody told me about dropping
> > > > > > > my/these patches? Can c2807ecb5290 please be merged into drm-misc-next
> > > > > > > again?
> > > > > > 
> > > > > > Actually, it was probably a mistake that these patches got merged to
> > > > > > linuxnext during the 4 days that you noticed. However, your patches
> > > > > > aren't dropped and are still present in drm-misc-next.
> > > > > > 
> > > > > > drm-misc has a bit of a unique model and it's documented fairly well here:
> > > > > > 
> > > > > > https://drm.pages.freedesktop.org/maintainer-tools/drm-misc.html
> > > > > 
> > > > > Is there a flaw then in this unique model (or its implementation) when
> > > > > drm-misc/for-linux-next moves in a non-fast-forward manner? This isn't
> > > > > expected, is it?
> > > > 
> > > > There's no expectation afaik. Any tree merged in linux-next can be
> > > > rebased, drop a patch, amend one, etc. without any concern.
> > > 
> > > I agree that there are no rules broken for a tree that is included in
> > > next and a maintainer is free to rewrite their tree independant of the
> > > tree being included in next.
> > > 
> > > Still I think that shouldn't be used as an excuse.
> > 
> > As an excuse for what?
> 
> Just because the rules for trees in next allow the merged branch to be
> rewritten, shouldn't be used to justify rewriting the branch.
> 
> IMHO you still should ensure that only commits make it into any next
> snapshot via your tree before X-rc1 for some X (e.g. v6.5) that you
> intend to be included in X-rc1.

That's never been a next rule either. Rust support has been in next for
almost a year without being sent as a PR for example.

> > > For me, if a maintainer puts some patch into next that's a statement
> > > saying (approximately) "I think this patch is fine and I intend to
> > > send it to Linus during the next merge window.".
> > 
> > I mean, that's what we're saying and doing?
> 
> No, on 2023-06-09 I assumed that my patches will go into v6.5-rc1 (as it
> was part of next-20230609). A few days later however the patches were
> dropped.
>
> The two options that would have made the experience smoother for me are:
> 
>  a) keep c2807ecb5290 in next and send it for v6.5-rc1; or

That's not an option. You were simply too late for v6.5-rc1, unless you
expect us to get rid of timezones and work on week-ends. But surely you
don't.

>  b) keep c2807ecb5290 in a branch that doesn't result it entering next
>     before v6.5-rc1.

All the drm-misc committers use dim. If that's a concern for you, feel
free to send a patch addressing this to dim.

> > > So my expectation is that if a patch is dropped again from next, there
> > > was a problem and it would be fair if the maintainer tells the
> > > author/submitter about this problem and that the patch was dropped.
> > 
> > But it wasn't dropped,
> 
> From my POV it was dropped from next as it was part of next between
> next-20230609 and next-20230615 but not any more since next-20230616.
> You talk about (not) being dropped from some branch in drm-misc, that's
> irrelevant for the thing I'm complaining about.

You were never told that they were merged in linux-next, but in
drm-misc-next. If they did, it's mostly an unfortunate artifact.

We have a documentation that explains the process and how drm-misc-next
works. If that's still confusing somehow, feel free to amend it to make
it clearer.

> > it's still very much to be sent to Linus during the next merge window.
> 
> "next merge window" as in the one leading to 6.5-rc1? Either we mean
> different things when we say "next merge window", or there is a
> misunderstanding I don't see yet.

Linus doesn't want to receive in a PR patches that haven't been in
linux-next for at least two weeks. In most cases that's rc6, which means
that by the time we send our last PR before rc6, the
next-merge-window-while-still-meeting-Linus-requirements is 6.6.

The rule applies to all trees, and it's why the soc tree also requires
its submaintainers to submit their PR before -rc6.

So yeah, sorry if it was confusing. At the end of the day, it's a
compromise, and I can't find a better one for everyone involved
(maintainers, contributors and committers alike) off the top of my head.

Maxime
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230619/db60b3a5/attachment-0001.sig>
