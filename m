From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Mon, 17 Apr 2023 10:54:03 +0200
Subject: [PATCH 000/117] media: Convert to platform remove callback
 returning void
In-Reply-To: <OS0PR01MB59221153A63F64BBAD3ED20D869C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230326143224.572654-1-u.kleine-koenig@pengutronix.de>
 <20230417060203.le3izz56wt73si6k@pengutronix.de>
 <20230417061928.GD28551@pendragon.ideasonboard.com>
 <20230417073049.2b5b35hpjrjcrlge@pengutronix.de>
 <OS0PR01MB59221153A63F64BBAD3ED20D869C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Message-ID: <20230417085403.sbk3k4qlpljbfqld@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Apr 17, 2023 at 07:57:57AM +0000, Biju Das wrote:
> Hi Uwe,
> > > I think the series got applied to the master branch of
> > > git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git.
> > > It should thus appear in v6.4.
> > 
> > I guess that linux-stable.git is a copy&paste failure (and it's not there).
> > I don't see the series in the master branch of
> > git://linuxtv.org/media_tree.git either.
> > 
> > .. a bit later ...
> > 
> > ah, it's in git://linuxtv.org/mchehab/media-next.git
> > 
> > I guess I was just to quick and probably the series will be included in
> > today's next.
> 
> I believe patchwork <patchwork@linuxtv.org> will send notification to
> author and along with people who applied tags for that patch.

Indeed, I got such a notification on Apr 11. But even if I had that on
my radar when asking and considered such notifications reliable in
general, I would have asked, as the patches didn't apprear in next up to
now.

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
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230417/caaedbc3/attachment-0001.sig>
