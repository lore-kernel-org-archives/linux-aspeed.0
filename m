From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Sun, 26 May 2024 12:24:58 +0200
Subject: [PATCH 0/6] ipmi: Convert to platform remove callback returning
 void
In-Reply-To: <ZlH4KFZ3MYzelzZK@mail.minyard.net>
References: <cover.1709655755.git.u.kleine-koenig@pengutronix.de>
 <3uhfeeahn2u23mxyumyxcyx4kmcxzczipkan7eqh4aslsmhxyz@zgsmwj2jvb2v>
 <Zhf9mQx/KgXOzPTs@mail.minyard.net>
 <sjgseqireuaswtbuwl3rvcszpsjzph4opq52x2kbudczxutz7o@2tua2oueufdd>
 <ZlH4KFZ3MYzelzZK@mail.minyard.net>
Message-ID: <nkhpr2ddrc4i7ai6gwamxrednx327atigoaxmamwq763bgpi46@fghhdinrqda7>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Corey,

On Sat, May 25, 2024 at 09:39:36AM -0500, Corey Minyard wrote:
> On Sat, May 25, 2024 at 12:10:38PM +0200, Uwe Kleine-K?nig wrote:
> > These changes are in next since a while but didn't land in Linus tree
> > for v6.10-rc1. I intend to send a PR to Greg early next week changing
> > platform_driver::remove to match remove_new. If these commits don't make
> > it in in time, I'll be so bold and just include the commits from your
> > for-next branch in my PR.
> 
> I sent them to Linus right after 6.9 dropped, let me resend...

That worked, they landed now in Linus' tree. Thanks, that makes it a bit
less ugly for me.

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
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240526/4b5c41b1/attachment.sig>
