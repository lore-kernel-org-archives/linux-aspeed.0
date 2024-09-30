From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:04:13 +0000
Subject: [PATCH 18/45] media: xilinx: Use string_choices helpers
In-Reply-To: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
References: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
Message-ID: <20240930-cocci-opportunity-v1-18-81e137456ce0@chromium.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The following cocci warnings are fixed:
drivers/media/platform/xilinx/xilinx-csi2rxss.c:415:3-27: opportunity for str_true_false(data & XCSI_CLKINFR_STOP)
drivers/media/platform/xilinx/xilinx-csi2rxss.c:409:3-24: opportunity for str_true_false(data & XCSI_CSR_RIPCD)
drivers/media/platform/xilinx/xilinx-csi2rxss.c:407:3-23: opportunity for str_true_false(data & XCSI_CSR_SLBF)
drivers/media/platform/xilinx/xilinx-csi2rxss.c:403:3-29: opportunity for str_true_false(data & XCSI_CSR_SPFIFOFULL)
drivers/media/platform/xilinx/xilinx-csi2rxss.c:405:3-27: opportunity for str_true_false(data & XCSI_CSR_SPFIFONE)
drivers/media/platform/xilinx/xilinx-csi2rxss.c:424:4-30: opportunity for str_true_false(data & XCSI_DLXINFR_SOTERR)
drivers/media/platform/xilinx/xilinx-csi2rxss.c:425:4-34: opportunity for str_true_false(data & XCSI_DLXINFR_SOTSYNCERR)
drivers/media/platform/xilinx/xilinx-csi2rxss.c:426:4-28: opportunity for str_true_false(data & XCSI_DLXINFR_STOP)
drivers/media/platform/xilinx/xilinx-csi2rxss.c:892:2-19: opportunity for str_enabled_disabled(xcsi2rxss -> en_vcx)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/xilinx/xilinx-csi2rxss.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/xilinx/xilinx-csi2rxss.c b/drivers/media/platform/xilinx/xilinx-csi2rxss.c
index f953d5474ae0..7ddd9b265162 100644
--- a/drivers/media/platform/xilinx/xilinx-csi2rxss.c
+++ b/drivers/media/platform/xilinx/xilinx-csi2rxss.c
@@ -400,19 +400,19 @@ static int xcsi2rxss_log_status(struct v4l2_subdev *sd)
 	dev_info(dev, "***** Core Status *****\n");
 	data = xcsi2rxss_read(xcsi2rxss, XCSI_CSR_OFFSET);
 	dev_info(dev, "Short Packet FIFO Full = %s\n",
-		 data & XCSI_CSR_SPFIFOFULL ? "true" : "false");
+		 str_true_false(data & XCSI_CSR_SPFIFOFULL));
 	dev_info(dev, "Short Packet FIFO Not Empty = %s\n",
-		 data & XCSI_CSR_SPFIFONE ? "true" : "false");
+		 str_true_false(data & XCSI_CSR_SPFIFONE));
 	dev_info(dev, "Stream line buffer full = %s\n",
-		 data & XCSI_CSR_SLBF ? "true" : "false");
+		 str_true_false(data & XCSI_CSR_SLBF));
 	dev_info(dev, "Soft reset/Core disable in progress = %s\n",
-		 data & XCSI_CSR_RIPCD ? "true" : "false");
+		 str_true_false(data & XCSI_CSR_RIPCD));
 
 	/* Clk & Lane Info  */
 	dev_info(dev, "******** Clock Lane Info *********\n");
 	data = xcsi2rxss_read(xcsi2rxss, XCSI_CLKINFR_OFFSET);
 	dev_info(dev, "Clock Lane in Stop State = %s\n",
-		 data & XCSI_CLKINFR_STOP ? "true" : "false");
+		 str_true_false(data & XCSI_CLKINFR_STOP));
 
 	dev_info(dev, "******** Data Lane Info *********\n");
 	dev_info(dev, "Lane\tSoT Error\tSoT Sync Error\tStop State\n");
@@ -421,9 +421,9 @@ static int xcsi2rxss_log_status(struct v4l2_subdev *sd)
 		data = xcsi2rxss_read(xcsi2rxss, reg);
 
 		dev_info(dev, "%d\t%s\t\t%s\t\t%s\n", i,
-			 data & XCSI_DLXINFR_SOTERR ? "true" : "false",
-			 data & XCSI_DLXINFR_SOTSYNCERR ? "true" : "false",
-			 data & XCSI_DLXINFR_STOP ? "true" : "false");
+			 str_true_false(data & XCSI_DLXINFR_SOTERR),
+			 str_true_false(data & XCSI_DLXINFR_SOTSYNCERR),
+			 str_true_false(data & XCSI_DLXINFR_STOP));
 
 		reg += XCSI_NEXTREG_OFFSET;
 	}
@@ -889,7 +889,7 @@ static int xcsi2rxss_parse_of(struct xcsi2rxss_state *xcsi2rxss)
 	fwnode_handle_put(ep);
 
 	dev_dbg(dev, "vcx %s, %u data lanes (%s), data type 0x%02x\n",
-		xcsi2rxss->en_vcx ? "enabled" : "disabled",
+		str_enabled_disabled(xcsi2rxss->en_vcx),
 		xcsi2rxss->max_num_lanes,
 		xcsi2rxss->enable_active_lanes ? "dynamic" : "static",
 		xcsi2rxss->datatype);

-- 
2.46.1.824.gd892dcdcdd-goog

