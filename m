From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Date: Wed, 22 Sep 2021 18:31:10 +0800
Subject: [PATCH 04/10] mmc: Add invert flag for clock phase signedness
In-Reply-To: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
References: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
Message-ID: <20210922103116.30652-5-chin-ting_kuo@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The clock phase degree may be between -360 to 360.
If the data signal is leading to the clock, the signedness
of clock phase is postive, otherwise, the signedness
is negative.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 drivers/mmc/core/host.c  | 10 ++++++----
 include/linux/mmc/host.h |  2 ++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index d4683b1d263f..c2de7cbc7838 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -214,14 +214,16 @@ static void mmc_retune_timer(struct timer_list *t)
 static void mmc_of_parse_timing_phase(struct device *dev, const char *prop,
 				      struct mmc_clk_phase *phase)
 {
-	int degrees[2] = {0};
+	int degrees[4] = {0};
 	int rc;
 
-	rc = device_property_read_u32_array(dev, prop, degrees, 2);
+	rc = device_property_read_u32_array(dev, prop, degrees, 4);
 	phase->valid = !rc;
 	if (phase->valid) {
-		phase->in_deg = degrees[0];
-		phase->out_deg = degrees[1];
+		phase->inv_in_deg = degrees[0] ? true : false;
+		phase->in_deg = degrees[1];
+		phase->inv_out_deg = degrees[2] ? true : false;
+		phase->out_deg = degrees[3];
 	}
 }
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 0c0c9a0fdf57..3c13010683e0 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -82,7 +82,9 @@ struct mmc_ios {
 
 struct mmc_clk_phase {
 	bool valid;
+	bool inv_in_deg;
 	u16 in_deg;
+	bool inv_out_deg;
 	u16 out_deg;
 };
 
-- 
2.17.1

