From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 13 Jul 2023 17:30:56 +0200
Subject: [Freedreno] [PATCH RFC v1 00/52] drm/crtc: Rename struct
 drm_crtc::dev to drm_dev
In-Reply-To: <d6160aeb-6344-b272-775a-cb665dca46ac@linux.intel.com>
References: <20230712094702.1770121-1-u.kleine-koenig@pengutronix.de>
 <87fs5tgpvv.fsf@intel.com>
 <CAOw6vbLO_UaXDbTCtAQJgthXOUMPqEV+c2MQhP-1DuK44OhGxw@mail.gmail.com>
 <20230713130337.fd2l67r23g2irifx@pengutronix.de>
 <CAOw6vbKtjyUm+OqO7LSV1hDOMQATwkEWP4GzBbbXib0i5EviUQ@mail.gmail.com>
 <78be52b8-5ffb-601a-84b2-ead2894973a6@suse.de>
 <d6160aeb-6344-b272-775a-cb665dca46ac@linux.intel.com>
Message-ID: <hoaz447ghc2vypjo7peknac35vzkgsaikp7ctehk3yhgopnweh@gzwzthsp2fnr>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jul 13, 2023 at 04:14:55PM +0100, Tvrtko Ursulin wrote:
> 
> On 13/07/2023 16:09, Thomas Zimmermann wrote:
> > Hi
> > 
> > Am 13.07.23 um 16:41 schrieb Sean Paul:
> > > On Thu, Jul 13, 2023 at 9:04?AM Uwe Kleine-K?nig
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > 
> > > > hello Sean,
> > > > 
> > > > On Wed, Jul 12, 2023 at 02:31:02PM -0400, Sean Paul wrote:
> > > > > I'd really prefer this patch (series or single) is not accepted. This
> > > > > will cause problems for everyone cherry-picking patches to a
> > > > > downstream kernel (LTS or distro tree). I usually wouldn't expect
> > > > > sympathy here, but the questionable benefit does not outweigh the cost
> > > > > IM[biased]O.
> > > > 
> > > > I agree that for backports this isn't so nice. However with the split
> > > > approach (that was argumented against here) it's not soo bad. Patch #1
> > > > (and similar changes for the other affected structures) could be
> > > > trivially backported and with that it doesn't matter if you write dev or
> > > > drm (or whatever name is chosen in the end); both work in the same way.
> > > 
> > > Patch #1 avoids the need to backport the entire set, however every
> > > change occuring after the rename patches will cause conflicts on
> > > future cherry-picks. Downstream kernels will have to backport the
> > > whole set. Backporting the entire set will create an epoch in
> > > downstream kernels where cherry-picking patches preceding this set
> > > will need to undergo conflict resolution as well. As mentioned in my
> > > previous email, I don't expect sympathy here, it's part of maintaining
> > > a downstream kernel, but there is a real cost to kernel consumers.
> > > 
> > > > 
> > > > But even with the one-patch-per-rename approach I'd consider the
> > > > renaming a net win, because ease of understanding code has a big value.
> > > > It's value is not so easy measurable as "conflicts when backporting",
> > > > but it also matters in say two years from now, while backporting
> > > > shouldn't be an issue then any more.
> > > 
> > > You've rightly identified the conjecture in your statement. I've been
> > > on both sides of the argument, having written/maintained drm code
> > > upstream and cherry-picked changes to a downstream kernel. Perhaps
> > > it's because drm's definition of dev is ingrained in my muscle memory,
> > > or maybe it's because I don't do a lot of upstream development these
> > > days, but I just have a hard time seeing the benefit here.
> > 
> > I can only second what Sean writes. I've done quite a bit of backporting
> > of DRM code. It's hard already. And this kind of change is going to to
> > affect almost every backported DRM patch in the coming years. Not just
> > for distribution kernels, but also for upstream's stable series. It's
> > really only possible to do this change over many releases while keeping
> > compatible with the old name. So the more I think about it, the less I
> > like this change.
> 
> I've done my share of backporting, and still am doing it, so I can say I
> dislike it as much as anyone, however.. Is this an argument which the kernel
> as a wider entity typically accepts? If not could it be a slippery slope to
> start a precedent?
> 
> It is a honest question - I am not familiar if there were or were not any
> similar discussions in the past.

Eventually, it's a trade-off. There's always pros and cons to merging
every patch, and "backporting pains" is indeed not a very strong con.

But it's definitely the kind of patch where everyone and their mother
will have their opinion, without every reaching a clear consensus, and
there's no clear benefit either (but I might be biaised on that one).

So imo, while that downside is fairly weak, the pros are certainly
weaker.

> My gut feeling is that *if* there is a consensus that something _improves_
> the code base significantly, backporting pains should probably not be
> weighted very heavily as a contra argument.

100% agreed here, but I'm afraid we're far from that point.

Maxime
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230713/0911229b/attachment-0001.sig>
