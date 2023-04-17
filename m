From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Mon, 17 Apr 2023 09:30:49 +0200
Subject: [PATCH 000/117] media: Convert to platform remove callback
 returning void
In-Reply-To: <20230417061928.GD28551@pendragon.ideasonboard.com>
References: <20230326143224.572654-1-u.kleine-koenig@pengutronix.de>
 <20230417060203.le3izz56wt73si6k@pengutronix.de>
 <20230417061928.GD28551@pendragon.ideasonboard.com>
Message-ID: <20230417073049.2b5b35hpjrjcrlge@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Laurent,

On Mon, Apr 17, 2023 at 09:19:28AM +0300, Laurent Pinchart wrote:
> On Mon, Apr 17, 2023 at 08:02:03AM +0200, Uwe Kleine-K?nig wrote:
> > On Sun, Mar 26, 2023 at 04:30:25PM +0200, Uwe Kleine-K?nig wrote:
> > > Hello,
> > > 
> > > this series adapts the platform drivers below drivers/pci to use the
> > 
> > copy&paste failure here: s/pci/media/ of course.
> > 
> > > .remove_new() callback. Compared to the traditional .remove() callback
> > > .remove_new() returns no value. This is a good thing because the driver core
> > > doesn't (and cannot) cope for errors during remove. The only effect of a
> > > non-zero return value in .remove() is that the driver core emits a warning. The
> > > device is removed anyhow and an early return from .remove() usually yields a
> > > resource leak.
> > > 
> > > By changing the remove callback to return void driver authors cannot
> > > reasonably assume any more that there is some kind of cleanup later.
> > > 
> > > Only three drivers needed some preparation first to make sure they
> > > return 0 unconditionally in their remove callback. Then all drivers
> > > could be trivially converted without side effects to .remove_new().
> > > 
> > > The changes to the individual drivers are all orthogonal. If I need to
> > > resend some patches because of some review feedback, I'd like to only
> > > send the patches that actually needed changes, so please pick up the
> > > remaining patches that don't need changing to reduce the amount of mail.
> > 
> > I didn't hear anything back about application of this series. Is there a
> > blocker somewhere?
> 
> I think the series got applied to the master branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git.
> It should thus appear in v6.4.

I guess that linux-stable.git is a copy&paste failure (and it's not
there). I don't see the series in the master branch of
git://linuxtv.org/media_tree.git either.

.. a bit later ...

ah, it's in git://linuxtv.org/mchehab/media-next.git

I guess I was just to quick and probably the series will be included in
today's next.

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
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230417/03041a44/attachment-0001.sig>
