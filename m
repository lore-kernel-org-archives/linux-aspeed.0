From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Mon, 18 Mar 2024 17:09:49 +0100
Subject: [PATCH 1/2] hwmon: (aspeed-g6-pwm-tacho): Make use of pwmchip_parent() accessor
In-Reply-To: <cover.1710777536.git.u.kleine-koenig@pengutronix.de>
References: <cover.1710777536.git.u.kleine-koenig@pengutronix.de>
Message-ID: <5c6a11dd10cd29e0f7bfaa1fdef145523347cb58.1710777536.git.u.kleine-koenig@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, use the accessor
function provided for exactly this purpose.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/hwmon/aspeed-g6-pwm-tach.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/aspeed-g6-pwm-tach.c b/drivers/hwmon/aspeed-g6-pwm-tach.c
index 597b3b019d49..64def5e4cdf6 100644
--- a/drivers/hwmon/aspeed-g6-pwm-tach.c
+++ b/drivers/hwmon/aspeed-g6-pwm-tach.c
@@ -195,7 +195,7 @@ static int aspeed_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	expect_period = div64_u64(ULLONG_MAX, (u64)priv->clk_rate);
 	expect_period = min(expect_period, state->period);
-	dev_dbg(chip->dev, "expect period: %lldns, duty_cycle: %lldns",
+	dev_dbg(pwmchip_parent(chip), "expect period: %lldns, duty_cycle: %lldns",
 		expect_period, state->duty_cycle);
 	/*
 	 * Pick the smallest value for div_h so that div_l can be the biggest
@@ -218,12 +218,12 @@ static int aspeed_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (div_l > 255)
 		div_l = 255;
 
-	dev_dbg(chip->dev, "clk source: %ld div_h %lld, div_l : %lld\n",
+	dev_dbg(pwmchip_parent(chip), "clk source: %ld div_h %lld, div_l : %lld\n",
 		priv->clk_rate, div_h, div_l);
 	/* duty_pt = duty_cycle * (PERIOD + 1) / period */
 	duty_pt = div64_u64(state->duty_cycle * priv->clk_rate,
 			    (u64)NSEC_PER_SEC * (div_l + 1) << div_h);
-	dev_dbg(chip->dev, "duty_cycle = %lld, duty_pt = %d\n",
+	dev_dbg(pwmchip_parent(chip), "duty_cycle = %lld, duty_pt = %d\n",
 		state->duty_cycle, duty_pt);
 
 	/*
-- 
2.43.0

