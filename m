From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 19 Jun 2023 16:02:43 +0200
Subject: patches dropped from drm-misc-next [Was: Re: [PATCH 00/53] drm:
 Convert to platform remove callback returning] void
In-Reply-To: <CAMuHMdWERLXOa4bQvsb7=gx+Q=Hn8v=XJZxahV0j3Vw1xKUYiQ@mail.gmail.com>
References: <CAD=FV=WvP--wJwBQtnSoW_xb57R1Wf9dH0XzWxe+NorczXfeAw@mail.gmail.com>
 <20230617161222.wy55pbomnrrlfy5u@pengutronix.de>
 <CAD=FV=U5gbMUNteyyFcTvHVBDWzfthM0aDirJC+yXGovDwMOBA@mail.gmail.com>
 <20230618123915.hmy66z7e532jhwgk@pengutronix.de>
 <jlq2xayh4dxfigfsh2fms2kt4hlrqcwxblffmqq7czbhqhhvz7@hsvol72f5i3y>
 <20230618162950.6th2yo66baqay5mv@pengutronix.de>
 <vxjp5c4wojcvbnp3ghsspwkgrc4mjmskzl56jkuxlgfhcji7kx@m3hg525p7y6a>
 <20230619105342.ugf5gz26gcalcsi6@pengutronix.de>
 <a6ex232lwyovzzazfh6jfvlwszppr2624czgcc5sa4nthkgecf@asauiw3rf4vi>
 <CAMuHMdWERLXOa4bQvsb7=gx+Q=Hn8v=XJZxahV0j3Vw1xKUYiQ@mail.gmail.com>
Message-ID: <vegkiv4puxederjvonyyqsg4j5swpi2h7ttg7ng6gq2tibk4gy@afa5vexshp7q>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jun 19, 2023 at 03:25:28PM +0200, Geert Uytterhoeven wrote:
> Hi Maxime,
> 
> CC sfr
> 
> On Mon, Jun 19, 2023 at 2:51?PM Maxime Ripard <mripard@kernel.org> wrote:
> > On Mon, Jun 19, 2023 at 12:53:42PM +0200, Uwe Kleine-K?nig wrote:
> > > On Mon, Jun 19, 2023 at 11:45:37AM +0200, Maxime Ripard wrote:
> > > > On Sun, Jun 18, 2023 at 06:29:50PM +0200, Uwe Kleine-K?nig wrote:
> > > > > On Sun, Jun 18, 2023 at 04:32:55PM +0200, Maxime Ripard wrote:
> > > > > > On Sun, Jun 18, 2023 at 02:39:15PM +0200, Uwe Kleine-K?nig wrote:
> > > > > > > On Sat, Jun 17, 2023 at 10:57:23AM -0700, Doug Anderson wrote:
> > > > > > > > On Sat, Jun 17, 2023 at 9:15?AM Uwe Kleine-K?nig
> > > > > > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > > > > > > Together with the patches that were applied later the topmost commit
> > > > > > > > > from this series is c2807ecb5290 ("drm/omap: Convert to platform remove
> > > > > > > > > callback returning void"). This commit was part for the following next
> > > > > > > > > tags:
> > > > > > > > >
> > > > > > > > >         $ git tag -l --contains c2807ecb5290
> > > > > > > > >         next-20230609
> > > > > > > > >         next-20230613
> > > > > > > > >         next-20230614
> > > > > > > > >         next-20230615
> > > > > > > > >
> > > > > > > > > However in next-20230616 they are missing. In next-20230616
> > > > > > > > > drm-misc/for-linux-next was cf683e8870bd4be0fd6b98639286700a35088660.
> > > > > > > > > Compared to c2807ecb5290 this adds 1149 patches but drops 37 (that are
> > > > > > > > > also not included with a different commit id). The 37 patches dropped
> > > > > > > > > are 13cdd12a9f934158f4ec817cf048fcb4384aa9dc..c2807ecb5290:
> > > > > > > > >
> > > > > > > > >         $ git shortlog -s 13cdd12a9f934158f4ec817cf048fcb4384aa9dc..c2807ecb5290
> > > > > > > > >              1  Christophe JAILLET
> > > > > > > > >              2  Jessica Zhang
> > > > > > > > >              5  Karol Wachowski
> > > > > > > > >              1  Laura Nao
> > > > > > > > >             27  Uwe Kleine-K?nig
> > > > > > > > >              1  Wang Jianzheng
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > I guess this was done by mistake because nobody told me about dropping
> > > > > > > > > my/these patches? Can c2807ecb5290 please be merged into drm-misc-next
> > > > > > > > > again?
> > > > > > > >
> > > > > > > > Actually, it was probably a mistake that these patches got merged to
> > > > > > > > linuxnext during the 4 days that you noticed. However, your patches
> > > > > > > > aren't dropped and are still present in drm-misc-next.
> > > > > > > >
> > > > > > > > drm-misc has a bit of a unique model and it's documented fairly well here:
> > > > > > > >
> > > > > > > > https://drm.pages.freedesktop.org/maintainer-tools/drm-misc.html
> > > > > > >
> > > > > > > Is there a flaw then in this unique model (or its implementation) when
> > > > > > > drm-misc/for-linux-next moves in a non-fast-forward manner? This isn't
> > > > > > > expected, is it?
> > > > > >
> > > > > > There's no expectation afaik. Any tree merged in linux-next can be
> > > > > > rebased, drop a patch, amend one, etc. without any concern.
> > > > >
> > > > > I agree that there are no rules broken for a tree that is included in
> > > > > next and a maintainer is free to rewrite their tree independant of the
> > > > > tree being included in next.
> > > > >
> > > > > Still I think that shouldn't be used as an excuse.
> > > >
> > > > As an excuse for what?
> > >
> > > Just because the rules for trees in next allow the merged branch to be
> > > rewritten, shouldn't be used to justify rewriting the branch.
> > >
> > > IMHO you still should ensure that only commits make it into any next
> > > snapshot via your tree before X-rc1 for some X (e.g. v6.5) that you
> > > intend to be included in X-rc1.
> >
> > That's never been a next rule either. Rust support has been in next for
> > almost a year without being sent as a PR for example.
> 
> https://elixir.bootlin.com/linux/latest/source/Documentation/process/2.Process.rst#L297
> 
>    "The linux-next tree is, by design, a snapshot of what the mainline
>     is expected to look like after the next merge window closes."
> 
> The general rule for linux-next is that its contents are intended to end
> up in the next kernel release, and that it should not contain commits
> that are intended for the next-next release, cfr. what Stephen sends
> out to new trees:
> 
>    "You will need to ensure that the patches/commits in your tree/series have
>     been:
>             [...]
>          * destined for the current or next Linux merge window."
> 
> and what he requests regularly in his announces, e.g.:
> 
>    "Please do not add any v6.4 related commits to your linux-next included
>     branches until after v6.3-rc1 has been released."

Which is why those patches aren't in next anymore.

> AFAIU, the exception to the rule is new, self-contained, and sometimes
> controversial development, which may have to cook for a few more cycles,
> if it ends up in a PR at all.
> 
> > > > > For me, if a maintainer puts some patch into next that's a statement
> > > > > saying (approximately) "I think this patch is fine and I intend to
> > > > > send it to Linus during the next merge window.".
> > > >
> > > > I mean, that's what we're saying and doing?
> > >
> > > No, on 2023-06-09 I assumed that my patches will go into v6.5-rc1 (as it
> > > was part of next-20230609). A few days later however the patches were
> > > dropped.
> > >
> > > The two options that would have made the experience smoother for me are:
> > >
> > >  a) keep c2807ecb5290 in next and send it for v6.5-rc1; or
> >
> > That's not an option. You were simply too late for v6.5-rc1, unless you
> > expect us to get rid of timezones and work on week-ends. But surely you
> > don't.
> 
> I don't think anyone expects you to do that...
> 
> > >  b) keep c2807ecb5290 in a branch that doesn't result it entering next
> > >     before v6.5-rc1.
> >
> > All the drm-misc committers use dim. If that's a concern for you, feel
> > free to send a patch addressing this to dim.
> 
> So you say this is an issue with the tooling? ;-)
> If the tooling breaks the rules, perhaps the tooling should be fixed?

We've been using dim for more than 5 years. It doesn't seem to work too bad?

And it does feel like the goalposts are moving there: the discussion
started by "you shouldn't rebase a tree" and is now at "patches should
never be in a next branch if they can't reach the next merge window,
even though it's not apparent yet"

But yeah, I now that complaining about how much drm-misc sucks is fun
and all, but it's still not clear to me what a potential solution to
this would be?

Knowing that we can't rebase or close drm-misc-next, and that it should
be automated in dim somehow, what would that fix be?

> > So yeah, sorry if it was confusing. At the end of the day, it's a
> > compromise, and I can't find a better one for everyone involved
> > (maintainers, contributors and committers alike) off the top of my head.
> 
> As I understand, the main issue Uwe is objecting to, is that his
> patches ended up in linux-next first, only to be dropped again from
> linux-next later, and that there was no communication about the
> latter.
> 
> If you're not constantly working on a subsystem, it can be very hard
> to keep track of the status of your own drive-by patches. When patches
> get applied, appear in linux-next, and disappear from linux-next again
> later, it's worse...

Sure, I've worked with enough of these series to understand how it can
be annoying.

Maxime
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230619/eccf050c/attachment-0001.sig>
