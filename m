From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Mon, 19 Jun 2023 15:58:49 +0200
Subject: patches dropped from drm-misc-next [Was: Re: [PATCH 00/53] drm:
 Convert to platform remove callback returning] void
In-Reply-To: <a6ex232lwyovzzazfh6jfvlwszppr2624czgcc5sa4nthkgecf@asauiw3rf4vi>
References: <20230601154002.uv2wfatpb7b45duz@pengutronix.de>
 <CAD=FV=WvP--wJwBQtnSoW_xb57R1Wf9dH0XzWxe+NorczXfeAw@mail.gmail.com>
 <20230617161222.wy55pbomnrrlfy5u@pengutronix.de>
 <CAD=FV=U5gbMUNteyyFcTvHVBDWzfthM0aDirJC+yXGovDwMOBA@mail.gmail.com>
 <20230618123915.hmy66z7e532jhwgk@pengutronix.de>
 <jlq2xayh4dxfigfsh2fms2kt4hlrqcwxblffmqq7czbhqhhvz7@hsvol72f5i3y>
 <20230618162950.6th2yo66baqay5mv@pengutronix.de>
 <vxjp5c4wojcvbnp3ghsspwkgrc4mjmskzl56jkuxlgfhcji7kx@m3hg525p7y6a>
 <20230619105342.ugf5gz26gcalcsi6@pengutronix.de>
 <a6ex232lwyovzzazfh6jfvlwszppr2624czgcc5sa4nthkgecf@asauiw3rf4vi>
Message-ID: <20230619135849.crbbeqsytla7upbw@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Maxime,

On Mon, Jun 19, 2023 at 02:47:09PM +0200, Maxime Ripard wrote:
> On Mon, Jun 19, 2023 at 12:53:42PM +0200, Uwe Kleine-K?nig wrote:
> > IMHO you still should ensure that only commits make it into any next
> > snapshot via your tree before X-rc1 for some X (e.g. v6.5) that you
> > intend to be included in X-rc1.
> 
> That's never been a next rule either. Rust support has been in next for
> almost a year without being sent as a PR for example.

It seems not to be rigorously enforced, but it exists. See for example
https://lore.kernel.org/all/20230510092313.16693e4c at canb.auug.org.au/ .

@Stephen: you wrote there

	You will need to ensure that the patches/commits in your
	tree/series have been [...] destined for the current or next
	Linux merge window.

This is a bit ambiguous because (AFAIK) during a merge window no patches
should be added that are supposed to go in during the next one, right?
Maybe adapt your template to read:

	[...] destined to be included in the next -rc1 release.

which is more precise?

Even if others don't adhere to it, IMHO it's still an opportunity to
improve. Also there is a difference between a patch that is included in
next that doesn't make it in during the next merge window and a patch
that disappears from next. The latter (up to now) only happened to me
when there was a problem with the patch and the maintainer who first
thought the patch to be fine changed their opinion.

> > > > For me, if a maintainer puts some patch into next that's a statement
> > > > saying (approximately) "I think this patch is fine and I intend to
> > > > send it to Linus during the next merge window.".
> > > 
> > > I mean, that's what we're saying and doing?
> > 
> > No, on 2023-06-09 I assumed that my patches will go into v6.5-rc1 (as it
> > was part of next-20230609). A few days later however the patches were
> > dropped.
> >
> > The two options that would have made the experience smoother for me are:
> > 
> >  a) keep c2807ecb5290 in next and send it for v6.5-rc1; or
> 
> That's not an option. You were simply too late for v6.5-rc1, unless you
> expect us to get rid of timezones and work on week-ends. But surely you
> don't.

We're mixing two things here. One is: "When will my patches be merged?".
I have no problem being patient here and b) is fine for me. The other is
"The patches first being included in next and then later not anymore
is a thing that just waits to be misinterpreted". This latter is the one
I care about here and that I think should be fixed for the future.

> >  b) keep c2807ecb5290 in a branch that doesn't result it entering next
> >     before v6.5-rc1.
> 
> All the drm-misc committers use dim. If that's a concern for you, feel
> free to send a patch addressing this to dim.

Not sure this is sensible given that I neither use nor know dim. Also I
think it should be the drm-misc maintainers who should care here given
that it's them who create this unfortunate situation again and again.

> > > > So my expectation is that if a patch is dropped again from next, there
> > > > was a problem and it would be fair if the maintainer tells the
> > > > author/submitter about this problem and that the patch was dropped.
> > > 
> > > But it wasn't dropped,
> > 
> > From my POV it was dropped from next as it was part of next between
> > next-20230609 and next-20230615 but not any more since next-20230616.
> > You talk about (not) being dropped from some branch in drm-misc, that's
> > irrelevant for the thing I'm complaining about.
> 
> You were never told that they were merged in linux-next, but in
> drm-misc-next.

That's nitpicking and little helpful here. In your bubble where only or
mostly drm-misc matters it's ok to only look at drm-misc. But for a
contributor who sends patches for dozens of subsystems next is the more
useful place to look and each subsystem that is special is an obstacle.
 
> If they did, it's mostly an unfortunate artifact.

I see some progress in this discussion as you seem to agree this is
unfortunate. Actually that's all I intend to achieve.

> We have a documentation that explains the process and how drm-misc-next
> works. If that's still confusing somehow, feel free to amend it to make
> it clearer.
> 
> > > it's still very much to be sent to Linus during the next merge window.
> > 
> > "next merge window" as in the one leading to 6.5-rc1? Either we mean
> > different things when we say "next merge window", or there is a
> > misunderstanding I don't see yet.
> 
> Linus doesn't want to receive in a PR patches that haven't been in
> linux-next for at least two weeks. In most cases that's rc6, which means
> that by the time we send our last PR before rc6, the
> next-merge-window-while-still-meeting-Linus-requirements is 6.6.
> 
> The rule applies to all trees, and it's why the soc tree also requires
> its submaintainers to submit their PR before -rc6.
> 
> So yeah, sorry if it was confusing. At the end of the day, it's a
> compromise, and I can't find a better one for everyone involved
> (maintainers, contributors and committers alike) off the top of my head.

Not knowing dim I think there is a simple(?) technical solution here: It
only has to make sure that after the pull request from drm-misc to drm
was sent, no new patches are added to the branch that is merged in next.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230619/4a8762bd/attachment-0001.sig>
