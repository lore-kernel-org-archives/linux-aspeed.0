From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 22 Nov 2021 16:54:00 +0100
Subject: [PATCH/RFC 07/17] iio: st_sensors: Use bitfield helpers
In-Reply-To: <cover.1637592133.git.geert+renesas@glider.be>
References: <cover.1637592133.git.geert+renesas@glider.be>
Message-ID: <afb895b597037a635acc4a1dc44b88598268a19b.1637592133.git.geert+renesas@glider.be>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Use the field_prep() helper, instead of open-coding the same operation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.
Marked RFC, as this depends on [PATCH 01/17], but follows a different
path to upstream.
---
 drivers/iio/common/st_sensors/st_sensors_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 1de395bda03eb6d3..b11c3f474d299b96 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -7,6 +7,7 @@
  * Denis Ciocca <denis.ciocca@st.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -26,8 +27,8 @@ int st_sensors_write_data_with_mask(struct iio_dev *indio_dev,
 {
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 
-	return regmap_update_bits(sdata->regmap,
-				  reg_addr, mask, data << __ffs(mask));
+	return regmap_update_bits(sdata->regmap, reg_addr, mask,
+				  field_prep(mask, data));
 }
 
 int st_sensors_debugfs_reg_access(struct iio_dev *indio_dev,
-- 
2.25.1

