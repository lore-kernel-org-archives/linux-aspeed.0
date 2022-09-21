From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Wed, 21 Sep 2022 10:51:12 +0800
Subject: [PATCH v9 4/4] media: aspeed: Extend debug message
In-Reply-To: <20220921025112.13150-1-jammy_huang@aspeedtech.com>
References: <20220921025112.13150-1-jammy_huang@aspeedtech.com>
Message-ID: <20220921025112.13150-5-jammy_huang@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

updated as below:

Capture:
  Mode                : Direct fetch
  VGA bpp mode        : 32
  Signal              : lock
  Width               : 1920
  Height              : 1080
  FRC                 : 0

Compression:
  Format              : JPEG
  Subsampling         : 444
  Quality             : 4

Performance:
  Frame#              : 4
  Frame Duration(ms)  :
    Now               : 22
    Min               : 21
    Max               : 22
  FPS                 : 45

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
 drivers/media/platform/aspeed/aspeed-video.c | 38 +++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/aspeed/aspeed-video.c b/drivers/media/platform/aspeed/aspeed-video.c
index 739288026418..dc61dfa4228b 100644
--- a/drivers/media/platform/aspeed/aspeed-video.c
+++ b/drivers/media/platform/aspeed/aspeed-video.c
@@ -1907,9 +1907,29 @@ static const struct vb2_ops aspeed_video_vb2_ops = {
 static int aspeed_video_debugfs_show(struct seq_file *s, void *data)
 {
 	struct aspeed_video *v = s->private;
+	u32 val08;
 
 	seq_puts(s, "\n");
 
+	seq_puts(s, "Capture:\n");
+	val08 = aspeed_video_read(v, VE_CTRL);
+	if (FIELD_GET(VE_CTRL_DIRECT_FETCH, val08)) {
+		seq_printf(s, "  %-20s:\tDirect fetch\n", "Mode");
+		seq_printf(s, "  %-20s:\t%s\n", "VGA bpp mode",
+			   FIELD_GET(VE_CTRL_INT_DE, val08) ? "16" : "32");
+	} else {
+		seq_printf(s, "  %-20s:\tSync\n", "Mode");
+		seq_printf(s, "  %-20s:\t%s\n", "Video source",
+			   FIELD_GET(VE_CTRL_SOURCE, val08) ?
+			   "external" : "internal");
+		seq_printf(s, "  %-20s:\t%s\n", "DE source",
+			   FIELD_GET(VE_CTRL_INT_DE, val08) ?
+			   "internal" : "external");
+		seq_printf(s, "  %-20s:\t%s\n", "Cursor overlay",
+			   FIELD_GET(VE_CTRL_AUTO_OR_CURSOR, val08) ?
+			   "Without" : "With");
+	}
+
 	seq_printf(s, "  %-20s:\t%s\n", "Signal",
 		   v->v4l2_input_status ? "Unlock" : "Lock");
 	seq_printf(s, "  %-20s:\t%d\n", "Width", v->pix_fmt.width);
@@ -1918,13 +1938,29 @@ static int aspeed_video_debugfs_show(struct seq_file *s, void *data)
 
 	seq_puts(s, "\n");
 
+	seq_puts(s, "Compression:\n");
+	seq_printf(s, "  %-20s:\t%s\n", "Format", format_str[v->format]);
+	seq_printf(s, "  %-20s:\t%s\n", "Subsampling",
+		   v->yuv420 ? "420" : "444");
+	seq_printf(s, "  %-20s:\t%d\n", "Quality", v->jpeg_quality);
+	if (v->format == VIDEO_FMT_ASPEED) {
+		seq_printf(s, "  %-20s:\t%s\n", "HQ Mode",
+			   v->hq_mode ? "on" : "off");
+		seq_printf(s, "  %-20s:\t%d\n", "HQ Quality",
+			   v->hq_mode ? v->jpeg_hq_quality : 0);
+	}
+
+	seq_puts(s, "\n");
+
 	seq_puts(s, "Performance:\n");
 	seq_printf(s, "  %-20s:\t%d\n", "Frame#", v->sequence);
 	seq_printf(s, "  %-20s:\n", "Frame Duration(ms)");
 	seq_printf(s, "    %-18s:\t%d\n", "Now", v->perf.duration);
 	seq_printf(s, "    %-18s:\t%d\n", "Min", v->perf.duration_min);
 	seq_printf(s, "    %-18s:\t%d\n", "Max", v->perf.duration_max);
-	seq_printf(s, "  %-20s:\t%d\n", "FPS", 1000 / (v->perf.totaltime / v->sequence));
+	seq_printf(s, "  %-20s:\t%d\n", "FPS",
+		   (v->perf.totaltime && v->sequence) ?
+		   1000/(v->perf.totaltime/v->sequence) : 0);
 
 	return 0;
 }
-- 
2.25.1

