From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Mon, 18 Mar 2024 17:09:50 +0100
Subject: [PATCH 2/2] hwmon: (aspeed-g6-pwm-tacho): Make use of devm_pwmchip_alloc() function
In-Reply-To: <cover.1710777536.git.u.kleine-koenig@pengutronix.de>
References: <cover.1710777536.git.u.kleine-koenig@pengutronix.de>
Message-ID: <e95e41eea5a138ae206c9116ba3cb1d9e0178284.1710777536.git.u.kleine-koenig@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This prepares the aspeed-g6-pwm-tacho driver to further changes of the
pwm core outlined in the commit introducing devm_pwmchip_alloc(). There
is no intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/hwmon/aspeed-g6-pwm-tach.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/aspeed-g6-pwm-tach.c b/drivers/hwmon/aspeed-g6-pwm-tach.c
index 64def5e4cdf6..332c02216668 100644
--- a/drivers/hwmon/aspeed-g6-pwm-tach.c
+++ b/drivers/hwmon/aspeed-g6-pwm-tach.c
@@ -136,7 +136,6 @@ struct aspeed_pwm_tach_data {
 	struct clk *clk;
 	struct reset_control *reset;
 	unsigned long clk_rate;
-	struct pwm_chip chip;
 	bool tach_present[TACH_ASPEED_NR_TACHS];
 	u32 tach_divisor;
 };
@@ -144,7 +143,7 @@ struct aspeed_pwm_tach_data {
 static inline struct aspeed_pwm_tach_data *
 aspeed_pwm_chip_to_data(struct pwm_chip *chip)
 {
-	return container_of(chip, struct aspeed_pwm_tach_data, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int aspeed_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -459,6 +458,7 @@ static int aspeed_pwm_tach_probe(struct platform_device *pdev)
 	int ret;
 	struct device_node *child;
 	struct aspeed_pwm_tach_data *priv;
+	struct pwm_chip *chip;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -487,11 +487,14 @@ static int aspeed_pwm_tach_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	priv->chip.dev = dev;
-	priv->chip.ops = &aspeed_pwm_ops;
-	priv->chip.npwm = PWM_ASPEED_NR_PWMS;
+	chip = devm_pwmchip_alloc(dev, PWM_ASPEED_NR_PWMS, 0);
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
 
-	ret = devm_pwmchip_add(dev, &priv->chip);
+	pwmchip_set_drvdata(chip, priv);
+	chip->ops = &aspeed_pwm_ops;
+
+	ret = devm_pwmchip_add(dev, chip);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to add PWM chip\n");
 
-- 
2.43.0

