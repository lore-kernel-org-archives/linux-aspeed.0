From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Thu, 13 Jul 2023 15:03:37 +0200
Subject: [Freedreno] [PATCH RFC v1 00/52] drm/crtc: Rename struct
 drm_crtc::dev to drm_dev
In-Reply-To: <CAOw6vbLO_UaXDbTCtAQJgthXOUMPqEV+c2MQhP-1DuK44OhGxw@mail.gmail.com>
References: <20230712094702.1770121-1-u.kleine-koenig@pengutronix.de>
 <87fs5tgpvv.fsf@intel.com>
 <CAOw6vbLO_UaXDbTCtAQJgthXOUMPqEV+c2MQhP-1DuK44OhGxw@mail.gmail.com>
Message-ID: <20230713130337.fd2l67r23g2irifx@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

hello Sean,

On Wed, Jul 12, 2023 at 02:31:02PM -0400, Sean Paul wrote:
> I'd really prefer this patch (series or single) is not accepted. This
> will cause problems for everyone cherry-picking patches to a
> downstream kernel (LTS or distro tree). I usually wouldn't expect
> sympathy here, but the questionable benefit does not outweigh the cost
> IM[biased]O.

I agree that for backports this isn't so nice. However with the split
approach (that was argumented against here) it's not soo bad. Patch #1
(and similar changes for the other affected structures) could be
trivially backported and with that it doesn't matter if you write dev or
drm (or whatever name is chosen in the end); both work in the same way.

But even with the one-patch-per-rename approach I'd consider the
renaming a net win, because ease of understanding code has a big value.
It's value is not so easy measurable as "conflicts when backporting",
but it also matters in say two years from now, while backporting
shouldn't be an issue then any more.

Thanks for your input, best regards
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
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230713/c890c45b/attachment-0001.sig>
