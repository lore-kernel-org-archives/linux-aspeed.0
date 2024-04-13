From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Sat, 13 Apr 2024 10:33:53 +0200
Subject: [PATCH 0/2] hwmon: (aspeed-g6-pwm-tacho): Prepare for further
 pwm core changes
In-Reply-To: <cover.1710777536.git.u.kleine-koenig@pengutronix.de>
References: <cover.1710777536.git.u.kleine-koenig@pengutronix.de>
Message-ID: <f43gbxbyjik76dzlwmjkcvfwdijzotctyngoidh7zb3xgog3ox@krm3avhdolhf>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

On Mon, Mar 18, 2024 at 05:09:48PM +0100, Uwe Kleine-K?nig wrote:
> there is a pending rework for the pwm framework[1] that requires a
> preparatory change for all pwm drivers. When creating them I wasn't
> aware of the aspeed-g6-pwm-tacho driver, just found this now while doing
> build tests with my series.
> 
> To not delay application of my series, I'd like to take the two patches
> from this series via my pwm tree.
> 
> To state the (maybe) obvious: This series depends on the following commits:
> 
> 	7e1449cd15d1 "hwmon: (aspeed-g6-pwm-tacho): Support for ASPEED g6 PWM/Fan tach"
> 	024913dbf99f pwm: Provide pwmchip_alloc() function and a devm variant of it
> 	4e59267c7a20 pwm: Provide an inline function to get the parent device of a given chip
> 
> The earliest commit containing all those is:
> 
> 	15223fdbdf4f "Merge tag 'hwmon-for-v6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging"

I applied this series with Guenter's ack to my branch at
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-next
. (Honestly I already did that a while ago, only noticed now that I
didn't explicitly tell about that.)

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
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240413/382e61e4/attachment.sig>
