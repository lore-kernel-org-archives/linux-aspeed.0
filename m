From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 22 Nov 2021 16:54:01 +0100
Subject: [PATCH/RFC 08/17] iio: humidity: hts221: Use bitfield helpers
In-Reply-To: <cover.1637592133.git.geert+renesas@glider.be>
References: <cover.1637592133.git.geert+renesas@glider.be>
Message-ID: <c906f7449c0210cefba53eab2c2d87105d5c8599.1637592133.git.geert+renesas@glider.be>
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
 drivers/iio/humidity/hts221_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
index 6a39615b696114cd..749aedc469ede5c1 100644
--- a/drivers/iio/humidity/hts221_core.c
+++ b/drivers/iio/humidity/hts221_core.c
@@ -7,6 +7,7 @@
  * Lorenzo Bianconi <lorenzo.bianconi@st.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/device.h>
@@ -171,7 +172,7 @@ static int hts221_update_avg(struct hts221_hw *hw,
 			     u16 val)
 {
 	const struct hts221_avg *avg = &hts221_avg_list[type];
-	int i, err, data;
+	int i, err;
 
 	for (i = 0; i < HTS221_AVG_DEPTH; i++)
 		if (avg->avg_avl[i] == val)
@@ -180,9 +181,8 @@ static int hts221_update_avg(struct hts221_hw *hw,
 	if (i == HTS221_AVG_DEPTH)
 		return -EINVAL;
 
-	data = ((i << __ffs(avg->mask)) & avg->mask);
-	err = regmap_update_bits(hw->regmap, avg->addr,
-				 avg->mask, data);
+	err = regmap_update_bits(hw->regmap, avg->addr, avg->mask,
+				 field_prep(avg->mask, i));
 	if (err < 0)
 		return err;
 
-- 
2.25.1

