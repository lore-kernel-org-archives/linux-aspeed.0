From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:04:01 +0000
Subject: [PATCH 06/45] media: em28xx: Use string_choices helpers
In-Reply-To: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
References: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
Message-ID: <20240930-cocci-opportunity-v1-6-81e137456ce0@chromium.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The following cocci warnings are fixed:
drivers/media/usb/em28xx/em28xx-i2c.c:579:3-29: opportunity for str_read_write(( msgs [ i ] . flags & I2C_M_RD ))
drivers/media/usb/em28xx/em28xx-i2c.c:590:2-28: opportunity for str_read_write(( msgs [ i ] . flags & I2C_M_RD ))
drivers/media/usb/em28xx/em28xx-video.c:941:4-9: opportunity for str_enabled_disabled(flags)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/em28xx/em28xx-i2c.c   | 4 ++--
 drivers/media/usb/em28xx/em28xx-video.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/em28xx/em28xx-i2c.c b/drivers/media/usb/em28xx/em28xx-i2c.c
index a7eb11f7fb34..62fe49876a32 100644
--- a/drivers/media/usb/em28xx/em28xx-i2c.c
+++ b/drivers/media/usb/em28xx/em28xx-i2c.c
@@ -576,7 +576,7 @@ static int em28xx_i2c_xfer(struct i2c_adapter *i2c_adap,
 			goto error;
 
 		dprintk(2, "%s %s addr=%02x len=%d: %*ph\n",
-			(msgs[i].flags & I2C_M_RD) ? "read" : "write",
+			str_read_write(msgs[i].flags & I2C_M_RD),
 			i == num - 1 ? "stop" : "nonstop",
 			addr, msgs[i].len,
 			msgs[i].len, msgs[i].buf);
@@ -587,7 +587,7 @@ static int em28xx_i2c_xfer(struct i2c_adapter *i2c_adap,
 
 error:
 	dprintk(2, "%s %s addr=%02x len=%d: %sERROR: %i\n",
-		(msgs[i].flags & I2C_M_RD) ? "read" : "write",
+		str_read_write(msgs[i].flags & I2C_M_RD),
 		i == num - 1 ? "stop" : "nonstop",
 		addr, msgs[i].len,
 		(rc == -ENODEV) ? "no device " : "",
diff --git a/drivers/media/usb/em28xx/em28xx-video.c b/drivers/media/usb/em28xx/em28xx-video.c
index 4aef584e21da..ff017c187aff 100644
--- a/drivers/media/usb/em28xx/em28xx-video.c
+++ b/drivers/media/usb/em28xx/em28xx-video.c
@@ -938,7 +938,7 @@ static int em28xx_enable_analog_tuner(struct em28xx *dev)
 			dev_err(&dev->intf->dev,
 				"Couldn't change link %s->%s to %s. Error %d\n",
 				source->name, sink->name,
-				flags ? "enabled" : "disabled",
+				str_enabled_disabled(flags),
 				ret);
 			return ret;
 		}

-- 
2.46.1.824.gd892dcdcdd-goog

