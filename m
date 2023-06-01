From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Thu, 1 Jun 2023 09:33:22 +0200
Subject: [PATCH 00/89] i2c: Convert to platform remove callback returning
 void
In-Reply-To: <20230508205306.1474415-1-u.kleine-koenig@pengutronix.de>
References: <20230508205306.1474415-1-u.kleine-koenig@pengutronix.de>
Message-ID: <20230601073322.ww25ajaurktqsryr@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

[Dropped Phil Edworthy from recipents as his email address has problems]

Hello,

On Mon, May 08, 2023 at 10:51:37PM +0200, Uwe Kleine-K?nig wrote:
> this series convers the drivers below drivers/i2c to the .remove_new()
> callback of struct platform_driver(). The motivation is to make the
> remove callback less prone for errors and wrong assumptions. See commit
> 5c5a7680e67b ("platform: Provide a remove callback that returns no
> value") for a more detailed rationale.
> 
> All but one driver already returned zero unconditionally in their
> .remove() callback, so converting them to .remove_new() is trivial.
> i2c-davinci has two patches in this series, first the error path is
> improved to not return an error code, then it's converted as the others
> drivers are.
> 
> The two davinci patches are also the only interdependency in this
> series. I was unsure if I should split the series in two, the busses and
> the mux changes; if convenient these can be applied independent of each
> other.

I wonder how this series will go in. My expectation was that Wolfram
picks up the whole series via his tree?!

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
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20230601/72853479/attachment-0001.sig>
