Return-Path: <linux-aspeed+bounces-4900-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A27FC624D3
	for <linux-aspeed@archiver.kernel.org>; Tue,  1 Sep 2026 11:36:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZ3hq50gFz2y2h;
	Tue, 01 Sep 2026 21:36:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788262571;
	cv=none; b=bu/L946aMvyy5rGAynHUDaEStKMt5geoRpMz/Fa4GHs+C8zhlp/+hbwP8hGNwXBKe2Nm6H8iEyqb9ZgriRAPaIPrAMETY8obCo05tOjzzLjK/LUkx7pzfHfjIKfZi083UJHIyB+8IWClvoap3D+j+aOOVDeJwO+ezV6V8EBhkY9Z86Rzsxci5eU0mZ2t0FMm/uWgPsqF4UhB106JI3bviYH7EGRhMUEoPPuWA321VLezryDPhM9h4DxVNx0IXby3aoM9igiL2xE4Oex/09mx9VQmIdaTNr1jfOBFD7PmuB0HkGlb/hVy3i7FQ2UmTaAXGHc6+Xj4N0HEpYG1mckacA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788262571; c=relaxed/relaxed;
	bh=kq4Izzq5XdqMBMVYoLts+aXbOTFck3gOl5zHzsMu+xM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ZXQC3gVFQkSytYw1gTvHENcbPsS8jwvcrW9Rb0MHLYHUZgLdBSkCh2oxwKW7ELkQzysKKOqV0H8f4KkKBYDYXy9b0e26khdIdaD6q2liSRorzr5ULFs3Cn+R4dRJEr3OrjFTvjlmG3bzKPqioqKDbIM96Ch4X2JOLySDb3p60p4ZDwl0y5ZdaG+YoGTr9Ej1Ii2Xq7yW7+DxYDImCx/fR4H0ZIQAvOq72mfSvU0Y380SwsQPmyFQMEGrXvmB2u4uoR+0NEMw1CIN1J4x4K+Nn22eJSympgVlvexPJ3HynKP6IDWtguHEFIq84QCyT7NN4QYABjjwgJtynAQV6y8AhA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZ3hp6CbPz2xBK
	for <linux-aspeed@lists.ozlabs.org>; Tue, 01 Sep 2026 21:36:10 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 1 Sep
 2026 19:35:39 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 1 Sep 2026 19:35:39 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Tue, 1 Sep 2026 19:35:34 +0800
Subject: [PATCH 7/8] i3c: mipi-i3c-hci: Improve AST2700 PIO TX queue
 utilization
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260901-b4-i3c-hci-ast2700-v1-7-19909e7cbd7e@aspeedtech.com>
References: <20260901-b4-i3c-hci-ast2700-v1-0-19909e7cbd7e@aspeedtech.com>
In-Reply-To: <20260901-b4-i3c-hci-ast2700-v1-0-19909e7cbd7e@aspeedtech.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Frank Li
	<Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Philipp Zabel
	<p.zabel@pengutronix.de>
CC: <linux-i3c@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Billy Tsai <billy_tsai@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788262538; l=5389;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=oaf8rylZXdyfnF1JAoViZJfEllE3F20K/vr6f/aHROE=;
 b=RYohPmXVU7MlqRAhyOatovdjRP4ydQzRQ7LkGAAOgee7Mv0uUdh/XLOduNYCIoVJYOpr5oaV6
 WSWWqbdoS/iCxtJEqyf0uGiKli6UpiCiqM3aA+Od6cRFNwFmpZvFpmL
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

The PIO TX path only pushes data once STAT_TX_THLD reports that
tx_thresh_size words are free, with the threshold set to half the TX
FIFO. The FIFO is therefore never filled beyond half from a single
wait, which under-utilizes the queue, and sending buffers larger than
the threshold makes software race against the hardware draining the
FIFO, resulting in an unstable flow.

The AST2700 vendor block exposes the TX FIFO read and write pointers,
which give the exact number of free entries. When is_aspeed() is true,
size each burst from those pointers, using CIRC_SPACE() to derive the
free-entry count, so the FIFO can be used up to its full depth. Other
controllers keep the existing threshold-based flow.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
Assisted-by: Claude:claude-fable-5
---
 drivers/i3c/master/mipi-i3c-hci/pio.c           | 25 +++++++++++++++++++++----
 drivers/i3c/master/mipi-i3c-hci/vendor_aspeed.c | 11 +++++++++++
 drivers/i3c/master/mipi-i3c-hci/vendor_aspeed.h |  6 ++++++
 3 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/pio.c b/drivers/i3c/master/mipi-i3c-hci/pio.c
index 6bd5e43364a1..3d70257dcc1d 100644
--- a/drivers/i3c/master/mipi-i3c-hci/pio.c
+++ b/drivers/i3c/master/mipi-i3c-hci/pio.c
@@ -15,6 +15,7 @@
 #include "cmd.h"
 #include "ibi.h"
 #include "pio.h"
+#include "vendor_aspeed.h"
 
 /*
  * PIO Access Area
@@ -295,11 +296,23 @@ static bool hci_pio_do_tx(struct i3c_hci *hci, struct hci_pio_data *pio)
 	p += (xfer->data_len - xfer->data_left) / 4;
 
 	while (xfer->data_left >= 4) {
-		/* bail out if FIFO free space is below set threshold */
-		if (!(pio_reg_read(INTR_STATUS) & STAT_TX_THLD))
+		unsigned int avail = pio->tx_thresh_size;
+
+		if (is_aspeed(hci)) {
+			/*
+			 * The vendor FIFO pointers give the exact free space,
+			 * allowing better TX FIFO utilization than the
+			 * threshold status.
+			 */
+			avail = aspeed_i3c_avail_tx_entries(hci);
+			if (!avail)
+				return false;
+		} else if (!(pio_reg_read(INTR_STATUS) & STAT_TX_THLD)) {
+			/* bail out if FIFO free space is below set threshold */
 			return false;
+		}
 		/* we can fill up to that TX threshold */
-		nr_words = min(xfer->data_left / 4, pio->tx_thresh_size);
+		nr_words = min(xfer->data_left / 4, avail);
 		/* push data into the FIFO */
 		xfer->data_left -= nr_words * 4;
 		dev_dbg(&hci->master.dev, "now %d left %d",
@@ -316,8 +329,12 @@ static bool hci_pio_do_tx(struct i3c_hci *hci, struct hci_pio_data *pio)
 		 * also get some bytes past the actual buffer but no one
 		 * should care as they won't be sent out.
 		 */
-		if (!(pio_reg_read(INTR_STATUS) & STAT_TX_THLD))
+		if (is_aspeed(hci)) {
+			if (!aspeed_i3c_avail_tx_entries(hci))
+				return false;
+		} else if (!(pio_reg_read(INTR_STATUS) & STAT_TX_THLD)) {
 			return false;
+		}
 		dev_dbg(&hci->master.dev, "trailing %d", xfer->data_left);
 		pio_reg_write(XFER_DATA_PORT, *p);
 		xfer->data_left = 0;
diff --git a/drivers/i3c/master/mipi-i3c-hci/vendor_aspeed.c b/drivers/i3c/master/mipi-i3c-hci/vendor_aspeed.c
index e32dea0d5fc3..182111b857c9 100644
--- a/drivers/i3c/master/mipi-i3c-hci/vendor_aspeed.c
+++ b/drivers/i3c/master/mipi-i3c-hci/vendor_aspeed.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/circ_buf.h>
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/i3c/master.h>
@@ -45,6 +46,16 @@ void aspeed_i3c_ibi_grow_threshold(struct i3c_hci *hci, unsigned int ibi_max_len
 			 FIELD_PREP(ASPEED_I3C_IBI_TERMINATE_LEN, ibi_max_len));
 }
 
+/* Free TX FIFO entries derived from the vendor FIFO read/write pointers */
+unsigned int aspeed_i3c_avail_tx_entries(struct i3c_hci *hci)
+{
+	u32 ptr = aspeed_i3c_read(hci, ASPEED_I3C_QUEUE_PTR0);
+	unsigned int w = FIELD_GET(ASPEED_I3C_QUEUE_PTR0_TX_W, ptr);
+	unsigned int r = FIELD_GET(ASPEED_I3C_QUEUE_PTR0_TX_R, ptr);
+
+	return CIRC_SPACE(w, r, ASPEED_I3C_TX_QUEUE_ENTRIES);
+}
+
 static void aspeed_i3c_phy_write(struct i3c_hci *hci, u32 reg, u32 val)
 {
 	writel(val, to_aspeed_vendor_data(hci)->phy_regs + reg);
diff --git a/drivers/i3c/master/mipi-i3c-hci/vendor_aspeed.h b/drivers/i3c/master/mipi-i3c-hci/vendor_aspeed.h
index 84afb2bec956..7147abea830d 100644
--- a/drivers/i3c/master/mipi-i3c-hci/vendor_aspeed.h
+++ b/drivers/i3c/master/mipi-i3c-hci/vendor_aspeed.h
@@ -52,6 +52,7 @@ u32 aspeed_i3c_read(struct i3c_hci *hci, u32 reg);
 void aspeed_i3c_write(struct i3c_hci *hci, u32 reg, u32 val);
 int aspeed_i3c_phy_init(struct i3c_hci *hci);
 void aspeed_i3c_ibi_grow_threshold(struct i3c_hci *hci, unsigned int ibi_max_len);
+unsigned int aspeed_i3c_avail_tx_entries(struct i3c_hci *hci);
 
 #define ASPEED_I3C_CTRL				0x00
 #define ASPEED_I3C_CTRL_CLOCK_STALL_EN		BIT(14)
@@ -68,6 +69,11 @@ void aspeed_i3c_ibi_grow_threshold(struct i3c_hci *hci, unsigned int ibi_max_len
 #define ASPEED_I3C_DAA_INDEX2			0x18
 #define ASPEED_I3C_DAA_INDEX3			0x1c
 
+#define ASPEED_I3C_QUEUE_PTR0			0xd8
+#define   ASPEED_I3C_QUEUE_PTR0_TX_R		GENMASK(24, 20)
+#define   ASPEED_I3C_QUEUE_PTR0_TX_W		GENMASK(16, 12)
+#define ASPEED_I3C_TX_QUEUE_ENTRIES		32
+
 #define ASPEED_I3C_INTR_STATUS			0xe0
 #define ASPEED_I3C_INTR_STATUS_ENABLE		0xe4
 #define ASPEED_I3C_INTR_SIGNAL_ENABLE		0xe8

-- 
2.34.1


