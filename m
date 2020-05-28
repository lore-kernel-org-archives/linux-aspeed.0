From: Manikandan Elumalai <manikandan.hcl.ers.epl@gmail.com>
Date: Thu, 28 May 2020 19:45:23 +0530
Subject: [PATCH] hwmon:(adm1275) Enable adm1278 ADM1278_TEMP1_EN
Message-ID: <20200528141523.GA8810@cnn>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


The adm1278 temperature sysfs attribute need it for one of the our openbmc platform . 
This functionality is not enabled by default, so PMON_CONFIG needs to be modified in order to enable it.

---
 drivers/hwmon/pmbus/adm1275.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
index 5caa37fb..47b293d 100644
--- a/drivers/hwmon/pmbus/adm1275.c
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -681,6 +681,21 @@ static int adm1275_probe(struct i2c_client *client,
 			}
 		}
 
+		config = i2c_smbus_read_byte_data(client, ADM1275_PMON_CONFIG);
+		if (config < 0)
+			return config;
+
+		/* Enable TEMP1 by defult */
+		config |= ADM1278_TEMP1_EN;
+		ret = i2c_smbus_write_byte_data(client,
+					ADM1275_PMON_CONFIG,
+					config);
+		if (ret < 0) {
+		dev_err(&client->dev,
+			"Failed to enable temperature config\n");
+		return -ENODEV;
+		}
+
 		if (config & ADM1278_TEMP1_EN)
 			info->func[0] |=
 				PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
-- 
2.7.4

