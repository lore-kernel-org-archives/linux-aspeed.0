From: krishnar4 <krishnar@ami.com>
Date: Thu, 27 Jan 2022 11:34:59 +0530
Subject: [PATCH linux dev-5.15] hwmon: (pmbus) modify PSU fan_target convert
 value to false
In-Reply-To: <git-send-email-krishnar@ami.com>
References: <git-send-email-krishnar@ami.com>
Message-ID: <20220127060459.17310-1-krishnar@ami.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Description: PSU can't use sysfs fan_target to control PSU fan duty.

Signed-off-by: krishnar4 <krishnar@ami.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 776ee2237be2..a56c2e1c4079 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -1889,7 +1889,7 @@ static int pmbus_add_fan_ctrl(struct i2c_client *client,
 
 	sensor = pmbus_add_sensor(data, "fan", "target", index, page,
 				  0xff, PMBUS_VIRT_FAN_TARGET_1 + id, PSC_FAN,
-				  false, false, true);
+				  false, false, false);
 
 	if (!sensor)
 		return -ENOMEM;
-- 
2.17.1

