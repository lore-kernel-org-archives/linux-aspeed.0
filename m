From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 22 Nov 2021 16:54:03 +0100
Subject: [PATCH/RFC 10/17] media: ti-vpe: cal: Use bitfield helpers
In-Reply-To: <cover.1637592133.git.geert+renesas@glider.be>
References: <cover.1637592133.git.geert+renesas@glider.be>
Message-ID: <d0ec5ecf5681cc36e0b86f8b35dde5d4a79dd5e8.1637592133.git.geert+renesas@glider.be>
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
 drivers/media/platform/ti-vpe/cal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/ti-vpe/cal.h b/drivers/media/platform/ti-vpe/cal.h
index 527e22d022f300b7..5fcf1b55ff2879ac 100644
--- a/drivers/media/platform/ti-vpe/cal.h
+++ b/drivers/media/platform/ti-vpe/cal.h
@@ -303,7 +303,7 @@ static inline void cal_write_field(struct cal_dev *cal, u32 offset, u32 value,
 	u32 val = cal_read(cal, offset);
 
 	val &= ~mask;
-	val |= (value << __ffs(mask)) & mask;
+	val |= field_prep(mask, value);
 	cal_write(cal, offset, val);
 }
 
@@ -312,7 +312,7 @@ static inline void cal_set_field(u32 *valp, u32 field, u32 mask)
 	u32 val = *valp;
 
 	val &= ~mask;
-	val |= (field << __ffs(mask)) & mask;
+	val |= field_prep(mask, field);
 	*valp = val;
 }
 
-- 
2.25.1

