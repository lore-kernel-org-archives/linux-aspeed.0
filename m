From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Sep 2024 12:04:08 +0000
Subject: [PATCH 13/45] media: pci: cx23885: Use string_choices helpers
In-Reply-To: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
References: <20240930-cocci-opportunity-v1-0-81e137456ce0@chromium.org>
Message-ID: <20240930-cocci-opportunity-v1-13-81e137456ce0@chromium.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The following cocci warnings are fixed:
drivers/media/pci/cx23885/altera-ci.c:285:3-9: opportunity for str_read_write(( read ))
drivers/media/pci/cx23885/cimax2.c:227:3-9: opportunity for str_read_write(( read ))
drivers/media/pci/cx23885/cx23888-ir.c:996:4-9: opportunity for str_enabled_disabled(filtr)
drivers/media/pci/cx23885/cx23888-ir.c:935:4-21: opportunity for str_enabled_disabled(cntrl & CNTRL_DMD)
drivers/media/pci/cx23885/cx23888-ir.c:1020:4-21: opportunity for str_enabled_disabled(cntrl & CNTRL_MOD)
drivers/media/pci/cx23885/cx23888-ir.c:937:4-21: opportunity for str_enabled_disabled(cntrl & CNTRL_RFE)
drivers/media/pci/cx23885/cx23888-ir.c:1022:4-21: opportunity for str_enabled_disabled(cntrl & CNTRL_TFE)
drivers/media/pci/cx23885/cx23888-ir.c:1008:4-21: opportunity for str_enabled_disabled(irqen & IRQEN_ROE)
drivers/media/pci/cx23885/cx23888-ir.c:1014:4-21: opportunity for str_enabled_disabled(irqen & IRQEN_RSE)
drivers/media/pci/cx23885/cx23888-ir.c:1004:4-21: opportunity for str_enabled_disabled(irqen & IRQEN_RTE)
drivers/media/pci/cx23885/cx23888-ir.c:1044:4-21: opportunity for str_enabled_disabled(irqen & IRQEN_TSE)
drivers/media/pci/cx23885/cx23888-ir.c:1026:4-21: opportunity for str_yes_no(cntrl & CNTRL_IVO)
drivers/media/pci/cx23885/cx23888-ir.c:933:4-21: opportunity for str_yes_no(cntrl & CNTRL_RXE)
drivers/media/pci/cx23885/cx23888-ir.c:1018:4-21: opportunity for str_yes_no(cntrl & CNTRL_TXE)
drivers/media/pci/cx23885/cx23888-ir.c:1010:4-21: opportunity for str_yes_no(stats & STATS_RBY)
drivers/media/pci/cx23885/cx23888-ir.c:1006:4-21: opportunity for str_yes_no(stats & STATS_ROR)
drivers/media/pci/cx23885/cx23888-ir.c:1012:4-21: opportunity for str_yes_no(stats & STATS_RSR)
drivers/media/pci/cx23885/cx23888-ir.c:1002:4-21: opportunity for str_yes_no(stats & STATS_RTO)
drivers/media/pci/cx23885/cx23888-ir.c:1040:4-21: opportunity for str_yes_no(stats & STATS_TBY)
drivers/media/pci/cx23885/cx23888-ir.c:1042:4-21: opportunity for str_yes_no(stats & STATS_TSR)

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/pci/cx23885/altera-ci.c  |  2 +-
 drivers/media/pci/cx23885/cimax2.c     |  2 +-
 drivers/media/pci/cx23885/cx23888-ir.c | 36 +++++++++++++++++-----------------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/media/pci/cx23885/altera-ci.c b/drivers/media/pci/cx23885/altera-ci.c
index 0dc348215b72..e154a39d86ef 100644
--- a/drivers/media/pci/cx23885/altera-ci.c
+++ b/drivers/media/pci/cx23885/altera-ci.c
@@ -282,7 +282,7 @@ static int altera_ci_op_cam(struct dvb_ca_en50221 *en50221, int slot,
 	mutex_unlock(&inter->fpga_mutex);
 
 	ci_dbg_print("%s: %s: addr=[0x%02x], %s=%x\n", __func__,
-			(read) ? "read" : "write", addr,
+			str_read_write(read), addr,
 			(flag == NETUP_CI_FLG_CTL) ? "ctl" : "mem",
 			(read) ? mem : val);
 
diff --git a/drivers/media/pci/cx23885/cimax2.c b/drivers/media/pci/cx23885/cimax2.c
index 06e41f92092d..458fa779274a 100644
--- a/drivers/media/pci/cx23885/cimax2.c
+++ b/drivers/media/pci/cx23885/cimax2.c
@@ -224,7 +224,7 @@ static int netup_ci_op_cam(struct dvb_ca_en50221 *en50221, int slot,
 			return -EREMOTEIO;
 
 	ci_dbg_print("%s: %s: chipaddr=[0x%x] addr=[0x%02x], %s=%x\n", __func__,
-			(read) ? "read" : "write", state->ci_i2c_addr, addr,
+			str_read_write(read), state->ci_i2c_addr, addr,
 			(flag == NETUP_CI_CTL) ? "ctl" : "mem",
 			(read) ? mem : data);
 
diff --git a/drivers/media/pci/cx23885/cx23888-ir.c b/drivers/media/pci/cx23885/cx23888-ir.c
index 222d04421468..85ca564fd3ab 100644
--- a/drivers/media/pci/cx23885/cx23888-ir.c
+++ b/drivers/media/pci/cx23885/cx23888-ir.c
@@ -930,11 +930,11 @@ static int cx23888_ir_log_status(struct v4l2_subdev *sd)
 
 	v4l2_info(sd, "IR Receiver:\n");
 	v4l2_info(sd, "\tEnabled:                           %s\n",
-		  cntrl & CNTRL_RXE ? "yes" : "no");
+		  str_yes_no(cntrl & CNTRL_RXE));
 	v4l2_info(sd, "\tDemodulation from a carrier:       %s\n",
-		  cntrl & CNTRL_DMD ? "enabled" : "disabled");
+		  str_enabled_disabled(cntrl & CNTRL_DMD));
 	v4l2_info(sd, "\tFIFO:                              %s\n",
-		  cntrl & CNTRL_RFE ? "enabled" : "disabled");
+		  str_enabled_disabled(cntrl & CNTRL_RFE));
 	switch (cntrl & CNTRL_EDG) {
 	case CNTRL_EDG_NONE:
 		s = "disabled";
@@ -993,37 +993,37 @@ static int cx23888_ir_log_status(struct v4l2_subdev *sd)
 		  pulse_width_count_to_us(FIFO_RXTX, rxclk),
 		  pulse_width_count_to_ns(FIFO_RXTX, rxclk));
 	v4l2_info(sd, "\tLow pass filter:                   %s\n",
-		  filtr ? "enabled" : "disabled");
+		  str_enabled_disabled(filtr));
 	if (filtr)
 		v4l2_info(sd, "\tMin acceptable pulse width (LPF):  %u us, %u ns\n",
 			  lpf_count_to_us(filtr),
 			  lpf_count_to_ns(filtr));
 	v4l2_info(sd, "\tPulse width timer timed-out:       %s\n",
-		  stats & STATS_RTO ? "yes" : "no");
+		  str_yes_no(stats & STATS_RTO));
 	v4l2_info(sd, "\tPulse width timer time-out intr:   %s\n",
-		  irqen & IRQEN_RTE ? "enabled" : "disabled");
+		  str_enabled_disabled(irqen & IRQEN_RTE));
 	v4l2_info(sd, "\tFIFO overrun:                      %s\n",
-		  stats & STATS_ROR ? "yes" : "no");
+		  str_yes_no(stats & STATS_ROR));
 	v4l2_info(sd, "\tFIFO overrun interrupt:            %s\n",
-		  irqen & IRQEN_ROE ? "enabled" : "disabled");
+		  str_enabled_disabled(irqen & IRQEN_ROE));
 	v4l2_info(sd, "\tBusy:                              %s\n",
-		  stats & STATS_RBY ? "yes" : "no");
+		  str_yes_no(stats & STATS_RBY));
 	v4l2_info(sd, "\tFIFO service requested:            %s\n",
-		  stats & STATS_RSR ? "yes" : "no");
+		  str_yes_no(stats & STATS_RSR));
 	v4l2_info(sd, "\tFIFO service request interrupt:    %s\n",
-		  irqen & IRQEN_RSE ? "enabled" : "disabled");
+		  str_enabled_disabled(irqen & IRQEN_RSE));
 
 	v4l2_info(sd, "IR Transmitter:\n");
 	v4l2_info(sd, "\tEnabled:                           %s\n",
-		  cntrl & CNTRL_TXE ? "yes" : "no");
+		  str_yes_no(cntrl & CNTRL_TXE));
 	v4l2_info(sd, "\tModulation onto a carrier:         %s\n",
-		  cntrl & CNTRL_MOD ? "enabled" : "disabled");
+		  str_enabled_disabled(cntrl & CNTRL_MOD));
 	v4l2_info(sd, "\tFIFO:                              %s\n",
-		  cntrl & CNTRL_TFE ? "enabled" : "disabled");
+		  str_enabled_disabled(cntrl & CNTRL_TFE));
 	v4l2_info(sd, "\tFIFO interrupt watermark:          %s\n",
 		  cntrl & CNTRL_TIC ? "not empty" : "half full or less");
 	v4l2_info(sd, "\tOutput pin level inversion         %s\n",
-		  cntrl & CNTRL_IVO ? "yes" : "no");
+		  str_yes_no(cntrl & CNTRL_IVO));
 	v4l2_info(sd, "\tCarrier polarity:                  %s\n",
 		  cntrl & CNTRL_CPL ? "space:burst mark:noburst"
 				    : "space:noburst mark:burst");
@@ -1037,11 +1037,11 @@ static int cx23888_ir_log_status(struct v4l2_subdev *sd)
 		  pulse_width_count_to_us(FIFO_RXTX, txclk),
 		  pulse_width_count_to_ns(FIFO_RXTX, txclk));
 	v4l2_info(sd, "\tBusy:                              %s\n",
-		  stats & STATS_TBY ? "yes" : "no");
+		  str_yes_no(stats & STATS_TBY));
 	v4l2_info(sd, "\tFIFO service requested:            %s\n",
-		  stats & STATS_TSR ? "yes" : "no");
+		  str_yes_no(stats & STATS_TSR));
 	v4l2_info(sd, "\tFIFO service request interrupt:    %s\n",
-		  irqen & IRQEN_TSE ? "enabled" : "disabled");
+		  str_enabled_disabled(irqen & IRQEN_TSE));
 
 	return 0;
 }

-- 
2.46.1.824.gd892dcdcdd-goog

