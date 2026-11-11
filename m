Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1555860A2616
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Nov 2026 03:17:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPTG54Qrvz2ySc;
	Wed, 11 Nov 2026 14:17:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794367021;
	cv=none; b=AqIocCg+mCLN4yYfm/1D56JW+splJEuAKZ28beIiUc2zkjK2EROyEFN8r6WDQWQSGVkOwYg8GkKIeh4gciQ7ANSTAXzARomGb/cWhg4gsWFJdh9i44qh4JUbemEreTOLtQD5ct+NDIIk1p6xeGVHgLe29MzjSo8NoeyGS3Nn/alwC1RMocyNq30CTzYaR6EwsZ5KTpuOryO1Aw08yFmVPnCfsqs4wk5Lq3TMNXmO7W+1FgqzqOxixl6XljQ5f9c9resW/kbe9IYyQj7R/4/hrfO/7KUuQXskUw0FCbtzx2ZMGjvkuEHR1JiOuJ9s51d9JkgQukFexfy09xyvPd0HyA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794367021; c=relaxed/relaxed;
	bh=vMR8H+3uCA7GO/uhsPfaheOQptrCQxLJzVvOfIVQ0WM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=RjhiLtV4NTV0IE2H4aDiibZJx+keVtDggXEzCoGbCkAklsQHyDOMt4e0yS/Mt5BvmWZH5UFKiPfJW8s4Ld2hy4qvEgUsNQatPp57MNi4mcDTOjDbQQBOp5y48JyY9474nR+Er53AImxzVPU0dYjsGq//WVtbb9iw5yW33MDK/TC2wWJKOeeez1G1yshgIK+xiN543IsbZUJpyqM2NfP/3BoBjJll+utH2Fl/rP84j9tuPk0Xjgt4L6/WDIZJzmpZNShwYBkNPRRChz3mFiivmv8gXBgtjl1c8TSsOY8PqsnkJwDP+KjK3s2pvsDVAxL7bgFWYX01i2isTRuhHK1cMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPTG4583Tz2xMQ
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Nov 2026 14:17:00 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Wed, 11 Nov
 2026 11:16:32 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Wed, 11 Nov 2026 11:16:32 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Wed, 11 Nov 2026 11:16:36 +0800
Subject: [PATCH v2 8/9] i3c: mipi-i3c-hci: Improve AST2700 PIO TX queue
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261111-b4-i3c-hci-ast2700-v2-8-4d8fff5c5196@aspeedtech.com>
References: <20261111-b4-i3c-hci-ast2700-v2-0-4d8fff5c5196@aspeedtech.com>
In-Reply-To: <20261111-b4-i3c-hci-ast2700-v2-0-4d8fff5c5196@aspeedtech.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Frank Li
	<Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Philipp Zabel
	<p.zabel@pengutronix.de>, Miquel Raynal <miquel.raynal@bootlin.com>, "Ryan
 Chen" <ryan_chen@aspeedtech.com>
CC: <tbevis@amazon.com>, <linux-i3c@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Billy Tsai
	<billy_tsai@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794366991; l=5992;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=PnUI0aMUfWomkFnXNrj/l47pexR/eLZ4/01b0YThnl0=;
 b=IC2QMoBS4HhTkUdyZfh73t5mJWN2P2/C2HES5gXTsxZFnXkH93e/0NnxY7hm5jp2FjM5z82BO
 CNEEfODeEb4D0D3LTAFcyCyAgQPjGVOAP0xSAyHVzRnwb7ULgJanuEI
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The PIO TX path only pushes data once STAT_TX_THLD reports that
tx_thresh_size words are free, with the threshold set to half the TX
FIFO. The FIFO is therefore never filled beyond half from a single
wait, which under-utilizes the queue, and sending buffers larger than
the threshold makes software race against the hardware draining the
FIFO, resulting in an unstable flow.

The AST2700 vendor block exposes the TX FIFO read and write pointers,
which give the exact number of free entries. When HCI_QUIRK_VENDOR_TX_AVAIL
is set, size each burst from those pointers, using CIRC_SPACE() to
derive the free-entry count, so the FIFO can be used up to its full
depth. Other controllers keep the existing threshold-based flow.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/i3c/master/mipi-i3c-hci/aspeed.c | 11 +++++++++++
 drivers/i3c/master/mipi-i3c-hci/aspeed.h |  6 ++++++
 drivers/i3c/master/mipi-i3c-hci/core.c   |  3 ++-
 drivers/i3c/master/mipi-i3c-hci/pio.c    | 25 +++++++++++++++++++++----
 4 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/aspeed.c b/drivers/i3c/master/mipi-i3c-hci/aspeed.c
index 4a73e0180a10..8f2a00a940f7 100644
--- a/drivers/i3c/master/mipi-i3c-hci/aspeed.c
+++ b/drivers/i3c/master/mipi-i3c-hci/aspeed.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/circ_buf.h>
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/i3c/master.h>
@@ -156,6 +157,16 @@ void aspeed_i3c_ibi_grow_threshold(struct i3c_hci *hci, unsigned int ibi_max_len
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
diff --git a/drivers/i3c/master/mipi-i3c-hci/aspeed.h b/drivers/i3c/master/mipi-i3c-hci/aspeed.h
index 7aecce04bba7..e80a0dff0dc9 100644
--- a/drivers/i3c/master/mipi-i3c-hci/aspeed.h
+++ b/drivers/i3c/master/mipi-i3c-hci/aspeed.h
@@ -38,6 +38,7 @@ u32 aspeed_i3c_read(struct i3c_hci *hci, u32 reg);
 void aspeed_i3c_write(struct i3c_hci *hci, u32 reg, u32 val);
 int aspeed_i3c_phy_init(struct i3c_hci *hci);
 void aspeed_i3c_ibi_grow_threshold(struct i3c_hci *hci, unsigned int ibi_max_len);
+unsigned int aspeed_i3c_avail_tx_entries(struct i3c_hci *hci);
 
 #define ASPEED_I3C_CTRL				0x00
 #define ASPEED_I3C_CTRL_CLOCK_STALL_EN		BIT(14)
@@ -54,6 +55,11 @@ void aspeed_i3c_ibi_grow_threshold(struct i3c_hci *hci, unsigned int ibi_max_len
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
diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index 31fab1fe614c..5e7af7717da7 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -1415,7 +1415,8 @@ static const __maybe_unused struct of_device_id i3c_hci_of_match[] = {
 				  HCI_QUIRK_VENDOR_INTR_SUMMARY |
 				  HCI_QUIRK_VENDOR_RESOURCES |
 				  HCI_QUIRK_VENDOR_DAA_INDEX |
-				  HCI_QUIRK_IBI_PAYLOAD_THLD) },
+				  HCI_QUIRK_IBI_PAYLOAD_THLD |
+				  HCI_QUIRK_VENDOR_TX_AVAIL) },
 	{},
 };
 MODULE_DEVICE_TABLE(of, i3c_hci_of_match);
diff --git a/drivers/i3c/master/mipi-i3c-hci/pio.c b/drivers/i3c/master/mipi-i3c-hci/pio.c
index a95ef7fc351c..b58edff234ea 100644
--- a/drivers/i3c/master/mipi-i3c-hci/pio.c
+++ b/drivers/i3c/master/mipi-i3c-hci/pio.c
@@ -14,6 +14,7 @@
 #include "hci.h"
 #include "cmd.h"
 #include "ibi.h"
+#include "aspeed.h"
 
 /*
  * PIO Access Area
@@ -397,11 +398,23 @@ static bool hci_pio_do_tx(struct i3c_hci *hci, struct hci_pio_data *pio)
 	p += (xfer->data_len - xfer->data_left) / 4;
 
 	while (xfer->data_left >= 4) {
-		/* bail out if FIFO free space is below set threshold */
-		if (!(pio_reg_read(INTR_STATUS) & STAT_TX_THLD))
+		unsigned int avail = pio->tx_thresh_size;
+
+		if (hci->quirks & HCI_QUIRK_VENDOR_TX_AVAIL) {
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
@@ -418,8 +431,12 @@ static bool hci_pio_do_tx(struct i3c_hci *hci, struct hci_pio_data *pio)
 		 * also get some bytes past the actual buffer but no one
 		 * should care as they won't be sent out.
 		 */
-		if (!(pio_reg_read(INTR_STATUS) & STAT_TX_THLD))
+		if (hci->quirks & HCI_QUIRK_VENDOR_TX_AVAIL) {
+			if (!aspeed_i3c_avail_tx_entries(hci))
+				return false;
+		} else if (!(pio_reg_read(INTR_STATUS) & STAT_TX_THLD)) {
 			return false;
+		}
 		dev_dbg(&hci->master.dev, "trailing %d", xfer->data_left);
 		pio_reg_write(XFER_DATA_PORT, *p);
 		xfer->data_left = 0;

-- 
2.34.1


