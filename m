From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 12 Jul 2023 14:52:38 +0200
Subject: [PATCH RFC v1 00/52] drm/crtc: Rename struct drm_crtc::dev to
 drm_dev
In-Reply-To: <20230712110253.paoyrmcbvlhpfxbf@pengutronix.de>
References: <20230712094702.1770121-1-u.kleine-koenig@pengutronix.de>
 <94eb6e4d-9384-152f-351b-ebb217411da9@amd.com>
 <20230712110253.paoyrmcbvlhpfxbf@pengutronix.de>
Message-ID: <o3dc4q27ap6rajsvpfwfvs3z3afekkwbhnclvswkaietciy2kc@unjf67gz5tur>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jul 12, 2023 at 01:02:53PM +0200, Uwe Kleine-K?nig wrote:
> > Background is that this makes merge conflicts easier to handle and detect.
> 
> Really?

FWIW, I agree with Christian here.

> Each file (apart from include/drm/drm_crtc.h) is only touched once. So
> unless I'm missing something you don't get less or easier conflicts by
> doing it all in a single patch. But you gain the freedom to drop a
> patch for one driver without having to drop the rest with it.

Not really, because the last patch removed the union anyway. So you have
to revert both the last patch, plus that driver one. And then you need
to add a TODO to remove that union eventually.

> So I still like the split version better, but I'm open to a more
> verbose reasoning from your side.

You're doing only one thing here, really: you change the name of a
structure field. If it was shared between multiple maintainers, then
sure, splitting that up is easier for everyone, but this will go through
drm-misc, so I can't see the benefit it brings.

Maxime
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230712/98d5296f/attachment-0001.sig>
