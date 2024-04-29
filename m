From: Jeremy Kerr <jk@ozlabs.org>
Date: Mon, 29 Apr 2024 15:25:48 +0800
Subject: [PATCH 0/4] fsi: Convert to platform remove callback returning
 void
In-Reply-To: <c62jfobjeuvjopxt4mdcgpp2eawesp6il2iz3izc3azvutzfxl@ztzhkw6eyd4o>
References: <cover.1709673414.git.u.kleine-koenig@pengutronix.de>
	 <pd2qn2zqhdd4hv2vn6g3p6kzcer343f6xm75tcj2xi5qgk7h5l@uv6uaa7zj7mu>
	 <c62jfobjeuvjopxt4mdcgpp2eawesp6il2iz3izc3azvutzfxl@ztzhkw6eyd4o>
Message-ID: <d516da3ccaff1c6653a1978d714941542eb4af73.camel@ozlabs.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Uwe,

> I intend to change platform_driver::remove soon after the next merge
> window to let it cook in next for a while. If this patch set doesn't
> make it in before, I'll send it together with the patch changing
> platform_driver::remove to Greg.


Joel is somewhat-off at present, and the FSI changes typically go
through Greg anyway, so this all sounds fine to me.

In case it helps:

Acked-by: Jeremy Kerr <jk@ozlabs.org>

Cheers,


Jeremy
