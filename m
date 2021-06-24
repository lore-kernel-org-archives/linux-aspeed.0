From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Thu, 24 Jun 2021 11:58:21 +0800
Subject: [PATCH] hwmon: (aspeed-pwm-tacho) Using falling edge.
Message-ID: <20210624035821.25375-1-billy_tsai@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The tach shouldn't use both edges to measure. When the tach input
duty cycle isn't 50% the return value will inaccurate.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/hwmon/aspeed-pwm-tacho.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/aspeed-pwm-tacho.c b/drivers/hwmon/aspeed-pwm-tacho.c
index 3d8239fd66ed..0a70a0e22acf 100644
--- a/drivers/hwmon/aspeed-pwm-tacho.c
+++ b/drivers/hwmon/aspeed-pwm-tacho.c
@@ -158,7 +158,7 @@
  * 10: both
  * 11: reserved.
  */
-#define M_TACH_MODE 0x02 /* 10b */
+#define M_TACH_MODE 0x00 /* 10b */
 #define M_TACH_UNIT 0x0210
 #define INIT_FAN_CTRL 0xFF
 
-- 
2.25.1

