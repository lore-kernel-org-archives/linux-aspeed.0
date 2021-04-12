From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Mon, 12 Apr 2021 13:14:00 +0200
Subject: [PATCH 4/4] pwm: Add support for aspeed pwm controller
In-Reply-To: <20210412095457.15095-5-billy_tsai@aspeedtech.com>
References: <20210412095457.15095-1-billy_tsai@aspeedtech.com>
 <20210412095457.15095-5-billy_tsai@aspeedtech.com>
Message-ID: <20210412111400.w4yafy2r2lcy3qqv@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

On Mon, Apr 12, 2021 at 05:54:57PM +0800, Billy Tsai wrote:
> Add support for the pwm controller which can be found at aspeed ast2600
> soc. This driver is part function of multi-funciton of device "pwm-tach
> controller".

please squash this into patch 3.

> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  drivers/pwm/Kconfig  | 6 ++++++
>  drivers/pwm/Makefile | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 63be5362fd3a..947ed642debe 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -42,6 +42,12 @@ config PWM_DEBUG
>  	  It is expected to introduce some runtime overhead and diagnostic
>  	  output to the kernel log, so only enable while working on a driver.
>  
> +config PWM_ASPEED_G6
> +	tristate "ASPEEDG6 PWM support"

No depends?

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
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20210412/d115461b/attachment.sig>
