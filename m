From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Mon, 9 Oct 2023 11:45:05 +0200
Subject: [PATCH 08/36] gpio: aspeed: use new pinctrl GPIO helpers
In-Reply-To: <20231003145114.21637-9-brgl@bgdev.pl>
References: <20231003145114.21637-1-brgl@bgdev.pl>
 <20231003145114.21637-9-brgl@bgdev.pl>
Message-ID: <20231009094505.7dqr7bqchsfacob2@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Oct 03, 2023 at 04:50:46PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Replace the pinctrl helpers taking the global GPIO number as argument
> with the improved variants that instead take a pointer to the GPIO chip
> and the controller-relative offset.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

LGTM,

Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

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
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20231009/ec9612e6/attachment.sig>
