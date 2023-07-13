From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Thu, 13 Jul 2023 17:39:36 +0200
Subject: [Freedreno] [PATCH RFC v1 00/52] drm/crtc: Rename struct
 drm_crtc::dev to drm_dev
In-Reply-To: <CAOw6vbKtjyUm+OqO7LSV1hDOMQATwkEWP4GzBbbXib0i5EviUQ@mail.gmail.com>
References: <20230712094702.1770121-1-u.kleine-koenig@pengutronix.de>
 <87fs5tgpvv.fsf@intel.com>
 <CAOw6vbLO_UaXDbTCtAQJgthXOUMPqEV+c2MQhP-1DuK44OhGxw@mail.gmail.com>
 <20230713130337.fd2l67r23g2irifx@pengutronix.de>
 <CAOw6vbKtjyUm+OqO7LSV1hDOMQATwkEWP4GzBbbXib0i5EviUQ@mail.gmail.com>
Message-ID: <20230713153936.k2m6aj34vptj5vf7@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jul 13, 2023 at 10:41:45AM -0400, Sean Paul wrote:
> On Thu, Jul 13, 2023 at 9:04?AM Uwe Kleine-K?nig
> > But even with the one-patch-per-rename approach I'd consider the
> > renaming a net win, because ease of understanding code has a big value.
> > It's value is not so easy measurable as "conflicts when backporting",
> > but it also matters in say two years from now, while backporting
> > shouldn't be an issue then any more.
> 
> You've rightly identified the conjecture in your statement. I've been
> on both sides of the argument, having written/maintained drm code
> upstream and cherry-picked changes to a downstream kernel. Perhaps
> it's because drm's definition of dev is ingrained in my muscle memory,
> or maybe it's because I don't do a lot of upstream development these
> days, but I just have a hard time seeing the benefit here.

I see that my change doesn't immediately benefit those who are already
at home in drivers/gpu/drm. So it's quite understandable that someone in
a senior role (long time contributor or maintainer) doesn't see a big
upside.

In contrast I think my change (with its indisputable cost) lowers the
bar for new contributors to drm. IMHO that's something a maintainer has
to have on their radar, too, and that's easily undervalued in my
experience.

Of course in the end it's about weighting the ups and downs. 

Thanks
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
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230713/e537c498/attachment-0001.sig>
