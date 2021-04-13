From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Tue, 13 Apr 2021 02:11:30 +0000
Subject: [PATCH 4/4] pwm: Add support for aspeed pwm controller
In-Reply-To: <20210412111400.w4yafy2r2lcy3qqv@pengutronix.de>
References: <20210412095457.15095-1-billy_tsai@aspeedtech.com>
 <20210412095457.15095-5-billy_tsai@aspeedtech.com>
 <20210412111400.w4yafy2r2lcy3qqv@pengutronix.de>
Message-ID: <BAD0AD58-BE95-4EF2-BC3F-EFAA19A91965@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Thanks for your review

Best Regards,
Billy Tsai

On 2021/4/12, 7:14 PM,Uwe Kleine-K?nigwrote:

    >Hello,

    >On Mon, Apr 12, 2021 at 05:54:57PM +0800, Billy Tsai wrote:
    >> Add support for the pwm controller which can be found at aspeed ast2600
    >> soc. This driver is part function of multi-funciton of device "pwm-tach
    >> controller".

    >please squash this into patch 3.

OK, I will squash it when sending v2.

    >> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
    >> ---
    >>  drivers/pwm/Kconfig  | 6 ++++++
    >>  drivers/pwm/Makefile | 1 +
    >>  2 files changed, 7 insertions(+)
    >> 
    >> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
    >> index 63be5362fd3a..947ed642debe 100644
    >> --- a/drivers/pwm/Kconfig
    >> +++ b/drivers/pwm/Kconfig
    >> @@ -42,6 +42,12 @@ config PWM_DEBUG
    >>  	  It is expected to introduce some runtime overhead and diagnostic
    >>  	  output to the kernel log, so only enable while working on a driver.
    >>  
    >> +config PWM_ASPEED_G6
    >> +	tristate "ASPEEDG6 PWM support"

    >No depends?

I will add "depends on (ARCH_ASPEED || COMPILE_TEST)" for this configure.

    >Best regards
    >Uwe

    >-- 
    >Pengutronix e.K.                           | Uwe Kleine-K?nig            |
    >Industrial Linux Solutions                 | https://www.pengutronix.de/ |

