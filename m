From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Date: Thu, 11 Apr 2024 18:01:36 +0200
Subject: [PATCH] hwmon: (aspeed-g6-pwm-tacho): Drop cpp define only used once
Message-ID: <20240411160136.247138-2-u.kleine-koenig@pengutronix.de>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The macro PWM_ASPEED_NR_PWMS is only used once, just use it's value in
this single code line.

Having the number of PWM lines explictly in the call to
devm_pwmchip_alloc() also has the advantage to be easily greppable.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

note this patch depends on commit 2c56fedef8c9 (hwmon: (aspeed-g6-pwm-tacho):
Make use of devm_pwmchip_alloc() function) that currently sits in pwm/for-next.

Best regards
Uwe

 drivers/hwmon/aspeed-g6-pwm-tach.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwmon/aspeed-g6-pwm-tach.c b/drivers/hwmon/aspeed-g6-pwm-tach.c
index 08a2ded95e45..706c344b181b 100644
--- a/drivers/hwmon/aspeed-g6-pwm-tach.c
+++ b/drivers/hwmon/aspeed-g6-pwm-tach.c
@@ -59,8 +59,6 @@
 #include <linux/reset.h>
 #include <linux/sysfs.h>
 
-/* The channel number of Aspeed pwm controller */
-#define PWM_ASPEED_NR_PWMS			16
 /* PWM Control Register */
 #define PWM_ASPEED_CTRL(ch)			((ch) * 0x10 + 0x00)
 #define PWM_ASPEED_CTRL_LOAD_SEL_RISING_AS_WDT	BIT(19)
@@ -487,7 +485,7 @@ static int aspeed_pwm_tach_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	chip = devm_pwmchip_alloc(dev, PWM_ASPEED_NR_PWMS, 0);
+	chip = devm_pwmchip_alloc(dev, 16, 0);
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
 
base-commit: 4118d9533ff3a5d16efb476a0d00afceecd92cf5
-- 
2.43.0

