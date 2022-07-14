From: Paul Fertser <fercerpav@gmail.com>
Date: Thu, 14 Jul 2022 17:23:44 +0300
Subject: [PATCH] hwmon: (aspeed-pwm-tacho) increase fan tach period (again)
Message-ID: <20220714142344.27071-1-fercerpav@gmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The old value allows measuring fan speeds down to about 970 RPM and
gives timeout for anything less than that. It is problematic because it
can also be used as an indicator for fan failure or absence.

Despite having read the relevant section of "ASPEED AST2500/AST2520 A2
Datasheet ? V1.7" multiple times I wasn't able to figure out what
exactly "fan tach period" and "fan tach falling point of period" mean
(both are set by the driver from the constant this patch is amending).

Experimentation with a Tioga Pass OCP board (AST2500 BMC) showed that
value of 0x0108 gives time outs for speeds below 1500 RPM and the value
offered by the patch is good for at least 750 RPM (the fans can't spin
any slower so the lower bound is unknown). Measuring with the fans
spinning takes about 30 ms, sometimes down to 18 ms, so about the same
as with the previous value.

This constant was last changed in
762b1e88801357770889d013c5d20fe110d1f456.

Signed-off-by: Paul Fertser <fercerpav@gmail.com>
---
 drivers/hwmon/aspeed-pwm-tacho.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/aspeed-pwm-tacho.c b/drivers/hwmon/aspeed-pwm-tacho.c
index 3cb88d6fbec0..d11f674e3dc3 100644
--- a/drivers/hwmon/aspeed-pwm-tacho.c
+++ b/drivers/hwmon/aspeed-pwm-tacho.c
@@ -159,7 +159,7 @@
  * 11: reserved.
  */
 #define M_TACH_MODE 0x02 /* 10b */
-#define M_TACH_UNIT 0x0210
+#define M_TACH_UNIT 0x0420
 #define INIT_FAN_CTRL 0xFF
 
 /* How long we sleep in us while waiting for an RPM result. */
-- 
2.32.0

