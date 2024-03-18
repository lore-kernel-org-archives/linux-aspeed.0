From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Mon, 18 Mar 2024 17:09:48 +0100
Subject: [PATCH 0/2] hwmon: (aspeed-g6-pwm-tacho): Prepare for further pwm core changes
Message-ID: <cover.1710777536.git.u.kleine-koenig@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

there is a pending rework for the pwm framework[1] that requires a
preparatory change for all pwm drivers. When creating them I wasn't
aware of the aspeed-g6-pwm-tacho driver, just found this now while doing
build tests with my series.

To not delay application of my series, I'd like to take the two patches
from this series via my pwm tree.

To state the (maybe) obvious: This series depends on the following commits:

	7e1449cd15d1 "hwmon: (aspeed-g6-pwm-tacho): Support for ASPEED g6 PWM/Fan tach"
	024913dbf99f pwm: Provide pwmchip_alloc() function and a devm variant of it
	4e59267c7a20 pwm: Provide an inline function to get the parent device of a given chip

The earliest commit containing all those is:

	15223fdbdf4f "Merge tag 'hwmon-for-v6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging"

Best regards
Uwe

[1] https://lore.kernel.org/linux-pwm/cover.1710670958.git.u.kleine-koenig at pengutronix.de

Uwe Kleine-K?nig (2):
  hwmon: (aspeed-g6-pwm-tacho): Make use of pwmchip_parent() accessor
  hwmon: (aspeed-g6-pwm-tacho): Make use of devm_pwmchip_alloc()
    function

 drivers/hwmon/aspeed-g6-pwm-tach.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

base-commit: f6cef5f8c37f58a3bc95b3754c3ae98e086631ca
-- 
2.43.0

