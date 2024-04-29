From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Mon, 29 Apr 2024 09:21:39 +0200
Subject: [PATCH 0/4] fsi: Convert to platform remove callback returning
 void
In-Reply-To: <pd2qn2zqhdd4hv2vn6g3p6kzcer343f6xm75tcj2xi5qgk7h5l@uv6uaa7zj7mu>
References: <cover.1709673414.git.u.kleine-koenig@pengutronix.de>
 <pd2qn2zqhdd4hv2vn6g3p6kzcer343f6xm75tcj2xi5qgk7h5l@uv6uaa7zj7mu>
Message-ID: <c62jfobjeuvjopxt4mdcgpp2eawesp6il2iz3izc3azvutzfxl@ztzhkw6eyd4o>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

On Thu, Apr 11, 2024 at 09:13:38AM +0200, Uwe Kleine-K?nig wrote:
> On Tue, Mar 05, 2024 at 10:20:56PM +0100, Uwe Kleine-K?nig wrote:
> > this series converts all drivers below drivers/fsi to struct
> > platform_driver::remove_new(). See commit 5c5a7680e67b ("platform:
> > Provide a remove callback that returns no value") for an extended
> > explanation and the eventual goal.
> > 
> > All conversations are trivial, because their .remove() callbacks
> > returned zero unconditionally.
> > 
> > There are no interdependencies between these patches, so they could be
> > picked up individually. But I'd hope that they get picked up all
> > together.
> 
> I didn't get any feedback on this patch set. As the conversion of
> platform_driver::remove depends on these, it would be great if they made
> it in during the next merge window.

I intend to change platform_driver::remove soon after the next merge
window to let it cook in next for a while. If this patch set doesn't
make it in before, I'll send it together with the patch changing
platform_driver::remove to Greg.

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
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240429/7055de82/attachment.sig>
