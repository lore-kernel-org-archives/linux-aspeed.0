From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Sat, 25 May 2024 12:10:38 +0200
Subject: [PATCH 0/6] ipmi: Convert to platform remove callback returning
 void
In-Reply-To: <Zhf9mQx/KgXOzPTs@mail.minyard.net>
References: <cover.1709655755.git.u.kleine-koenig@pengutronix.de>
 <3uhfeeahn2u23mxyumyxcyx4kmcxzczipkan7eqh4aslsmhxyz@zgsmwj2jvb2v>
 <Zhf9mQx/KgXOzPTs@mail.minyard.net>
Message-ID: <sjgseqireuaswtbuwl3rvcszpsjzph4opq52x2kbudczxutz7o@2tua2oueufdd>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Corey,

On Thu, Apr 11, 2024 at 10:11:21AM -0500, Corey Minyard wrote:
> On Thu, Apr 11, 2024 at 09:15:03AM +0200, Uwe Kleine-K?nig wrote:
> > Hello,
> > 
> > On Tue, Mar 05, 2024 at 05:26:57PM +0100, Uwe Kleine-K?nig wrote:
> > > this series converts all drivers below drivers/char/ipmi to struct
> > > platform_driver::remove_new(). See commit 5c5a7680e67b ("platform: Provide a
> > > remove callback that returns no value") for an extended explanation and the
> > > eventual goal.
> > > 
> > > All conversations are trivial, because their .remove() callbacks
> > > returned zero unconditionally.
> > > 
> > > There are no interdependencies between these patches, so they could be
> > > picked up individually. But I'd hope that they get picked up all
> > > together by Corey.
> 
> Yeah, I was kind of waiting for more reviews, but this is pretty
> straightforward.  I've pulled this into my tree.

These changes are in next since a while but didn't land in Linus tree
for v6.10-rc1. I intend to send a PR to Greg early next week changing
platform_driver::remove to match remove_new. If these commits don't make
it in in time, I'll be so bold and just include the commits from your
for-next branch in my PR.

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
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240525/1ac48773/attachment.sig>
