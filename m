Return-Path: <linux-aspeed+bounces-4897-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3AFC61DD3
	for <linux-aspeed@archiver.kernel.org>; Tue,  1 Sep 2026 11:36:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZ3hl4VtNz2y2B;
	Tue, 01 Sep 2026 21:36:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788262567;
	cv=none; b=I7lmdu3LkmGpDcpeIlxI36xF0ZHDZiYbVWuwvw1E1MdPOSnPk9JAaa1pEFuXnB4My04KiBPG4oZtzgTV2BLQ76Uf6u5Te5g9BNAxt4NM1InqFWOmoR0DKpyJYlR621CI9fAcH9p7XCFuaGefOMWpyrrWKIMMYbZJTEnHpmDRKQ96DiN7M2S6xt3j9L0gI1RkMGOxBZcIJHycftExh17LNWaqlptwtCH8z30J1SOJKIIpSDnt/gq31AzuFjWK1cgXKosh5vT8MQpqGmSB7LMKxlFunj9iilh1ZrLOGuzLkGUiK73d6qk5oSTRzZtDNRzkhvDWtUG8XT6oQsCTiOp5VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788262567; c=relaxed/relaxed;
	bh=EBlzdFY4NKUxnAP9piof8UgZXXWTUwVL1IgsfK24VTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=j6x76iBAWMukcT0b3Z97fjpXg+AeXi9bcJb22mKm3T/Fni86l1ZedcxlVipA4L+dfycgb9FCaO7xyVIEvsB8EbHg3jWpBGqlh5fGYP2ox2I5GH7tyB0ftMkRzGroSs+iGizTxdJh1fI7jkNpDadPM1WkjVrnmsAO3H/dclxpBSgZCyqYmNdUbJqEJwVkXI/rkMoysU8095NAd9UaKrosH+nbd/54GFtA8t/5wwyh6z0vWMPOjDGjcNGGblFWVjvIByM5ZklyoFaWBfL5Fs2iJQpQioZ8Xl9hhcQNBo6yVPiGFBtmPBS1inylq9QXgqvNr80ds4p1ozsNEta60/YcSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZ3hj55rvz2xBK
	for <linux-aspeed@lists.ozlabs.org>; Tue, 01 Sep 2026 21:36:05 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 1 Sep
 2026 19:35:39 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 1 Sep 2026 19:35:39 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Tue, 1 Sep 2026 19:35:31 +0800
Subject: [PATCH 4/8] i3c: mipi-i3c-hci: Add a quirk to clear the TX start
 threshold
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
Message-ID: <20260901-b4-i3c-hci-ast2700-v1-4-19909e7cbd7e@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788262538; l=11122;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=n6vO/Fi5jhecmVwxetC4Wj6M9A4SBSKPZgOHLJNm8ng=;
 b=HHfIRufKO0rvzVE5evGWDeOxDqIGK5LwC4DFCfClX9QJhRprAHy2Zx7GO/2FHHZR7t0GHsEpU
 zZFLkzvr9C7CxAPfWOiwrs+ICl6gQuAse4SxQHa4bHJWvlYaTMZn3mf
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

The DATA_TX_START_THLD field of the PIO data buffer threshold register
holds off the start of a TX transfer until the FIFO holds a set amount
of data, which in PIO mode cuts down on the number of software writes.
The field resets to 0x1, requiring at least (2 ^ 2) DWORDs (16 bytes)
in the FIFO before transmission starts.

HCI controllers that support both PIO and DMA can expose the two as
separate register blocks; nothing in the specification says selecting
DMA mode disables the PIO block's own gating logic. On ASPEED
platforms it doesn't: DATA_TX_START_THLD still holds up transfer
start regardless of which mode feeds the FIFO, and in DMA mode that
threshold is never satisfied for some transfer sizes:

 - 1-4 bytes: uses the Immediate Data Transfer Command.
 - 13+ bytes: since the hardware fetches data in 4-byte chunks, a
   13-byte transfer fetches 16 bytes into the FIFO and reaches the
   threshold.
 - 5-12 bytes: the threshold is never reached and the transfer stalls.

Add HCI_QUIRK_TX_START_THLD to clear the field whenever DMA mode is
selected. The clear lives in i3c_hci_set_io_mode() rather than in
probe so the reset-and-restore recovery path also reapplies it after
a controller soft reset. Move the PIO Access Area register and
bitfield definitions from pio.c to a new pio.h so this quirk can reuse
PIO_DATA_BUFFER_THLD_CTRL and DATA_TX_START_THLD instead of
redefining them.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
Assisted-by: Claude:claude-fable-5
---
 drivers/i3c/master/mipi-i3c-hci/core.c |  14 +++++
 drivers/i3c/master/mipi-i3c-hci/hci.h  |   1 +
 drivers/i3c/master/mipi-i3c-hci/pio.c  |  97 +----------------------------
 drivers/i3c/master/mipi-i3c-hci/pio.h  | 109 +++++++++++++++++++++++++++++++++
 4 files changed, 125 insertions(+), 96 deletions(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index c03c3a9cbe4f..2290a889701c 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -26,6 +26,7 @@
 #include "cmd.h"
 #include "dat.h"
 #include "ibi.h"
+#include "pio.h"
 
 /*
  * Host Controller Capabilities and Operation Registers
@@ -823,6 +824,19 @@ static int i3c_hci_set_io_mode(struct i3c_hci *hci, bool dma)
 	else
 		reg_set(HC_CONTROL, HC_CONTROL_PIO_MODE);
 
+	/*
+	 * On the ASPEED AST2700 the TX start threshold gates transfer start
+	 * even in DMA mode. Clear it so DMA transfers are not held back
+	 * waiting for a PIO FIFO level that will never be reached.
+	 */
+	if (dma && (hci->quirks & HCI_QUIRK_TX_START_THLD) && hci->PIO_regs) {
+		void __iomem *thld_reg = hci->PIO_regs + PIO_DATA_BUFFER_THLD_CTRL;
+		u32 thld_val = readl(thld_reg);
+
+		thld_val &= ~DATA_TX_START_THLD;
+		writel(thld_val, thld_reg);
+	}
+
 	if (!is_version_1_1_or_newer(hci))
 		return 0;
 
diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
index 2110f806a53c..d9c9e609a879 100644
--- a/drivers/i3c/master/mipi-i3c-hci/hci.h
+++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
@@ -179,6 +179,7 @@ struct i3c_hci_dev_data {
 #define HCI_QUIRK_DMA_REQUIRES_HC_ABORT		BIT(9)  /* Use HC_CONTROL ABORT to abort DMA */
 #define HCI_QUIRK_DAT_INDEX_IS_ADDR	BIT(10)  /* DAT entries are indexed by device address */
 #define HCI_QUIRK_DMA_64BIT		BIT(11)  /* Controller DMA supports 64-bit addressing */
+#define HCI_QUIRK_TX_START_THLD		BIT(12)  /* Clear TX start threshold in DMA mode */
 
 /* global functions */
 void mipi_i3c_hci_resume(struct i3c_hci *hci);
diff --git a/drivers/i3c/master/mipi-i3c-hci/pio.c b/drivers/i3c/master/mipi-i3c-hci/pio.c
index 439578a6eb54..6bd5e43364a1 100644
--- a/drivers/i3c/master/mipi-i3c-hci/pio.c
+++ b/drivers/i3c/master/mipi-i3c-hci/pio.c
@@ -14,6 +14,7 @@
 #include "hci.h"
 #include "cmd.h"
 #include "ibi.h"
+#include "pio.h"
 
 /*
  * PIO Access Area
@@ -22,102 +23,6 @@
 #define pio_reg_read(r)		readl(hci->PIO_regs + (PIO_##r))
 #define pio_reg_write(r, v)	writel(v, hci->PIO_regs + (PIO_##r))
 
-#define PIO_COMMAND_QUEUE_PORT		0x00
-#define PIO_RESPONSE_QUEUE_PORT		0x04
-#define PIO_XFER_DATA_PORT		0x08
-#define PIO_IBI_PORT			0x0c
-
-#define PIO_QUEUE_THLD_CTRL		0x10
-#define QUEUE_IBI_STATUS_THLD		GENMASK(31, 24)
-#define QUEUE_IBI_DATA_THLD		GENMASK(23, 16)
-#define QUEUE_RESP_BUF_THLD		GENMASK(15, 8)
-#define QUEUE_CMD_EMPTY_BUF_THLD	GENMASK(7, 0)
-
-#define PIO_DATA_BUFFER_THLD_CTRL	0x14
-#define DATA_RX_START_THLD		GENMASK(26, 24)
-#define DATA_TX_START_THLD		GENMASK(18, 16)
-#define DATA_RX_BUF_THLD		GENMASK(10, 8)
-#define DATA_TX_BUF_THLD		GENMASK(2, 0)
-
-#define PIO_QUEUE_SIZE			0x18
-#define TX_DATA_BUFFER_SIZE		GENMASK(31, 24)
-#define RX_DATA_BUFFER_SIZE		GENMASK(23, 16)
-#define IBI_STATUS_SIZE			GENMASK(15, 8)
-#define CR_QUEUE_SIZE			GENMASK(7, 0)
-
-#define PIO_ALT_QUEUE_SIZE		0x1C
-#define EXT_IBI_QUEUE_EN		BIT(28)
-#define ALT_RESP_QUEUE_EN		BIT(24)
-#define ALT_RESP_QUEUE_SIZE		GENMASK(7, 0)
-
-#define PIO_INTR_STATUS			0x20
-#define PIO_INTR_STATUS_ENABLE		0x24
-#define PIO_INTR_SIGNAL_ENABLE		0x28
-#define PIO_INTR_FORCE			0x2c
-#define STAT_TRANSFER_BLOCKED		BIT(25)
-#define STAT_PERR_RESP_UFLOW		BIT(24)
-#define STAT_PERR_CMD_OFLOW		BIT(23)
-#define STAT_PERR_IBI_UFLOW		BIT(22)
-#define STAT_PERR_RX_UFLOW		BIT(21)
-#define STAT_PERR_TX_OFLOW		BIT(20)
-#define STAT_ERR_RESP_QUEUE_FULL	BIT(19)
-#define STAT_WARN_RESP_QUEUE_FULL	BIT(18)
-#define STAT_ERR_IBI_QUEUE_FULL		BIT(17)
-#define STAT_WARN_IBI_QUEUE_FULL	BIT(16)
-#define STAT_ERR_RX_DATA_FULL		BIT(15)
-#define STAT_WARN_RX_DATA_FULL		BIT(14)
-#define STAT_ERR_TX_DATA_EMPTY		BIT(13)
-#define STAT_WARN_TX_DATA_EMPTY		BIT(12)
-#define STAT_TRANSFER_ERR		BIT(9)
-#define STAT_WARN_INS_STOP_MODE		BIT(7)
-#define STAT_TRANSFER_ABORT		BIT(5)
-#define STAT_RESP_READY			BIT(4)
-#define STAT_CMD_QUEUE_READY		BIT(3)
-#define STAT_IBI_STATUS_THLD		BIT(2)
-#define STAT_RX_THLD			BIT(1)
-#define STAT_TX_THLD			BIT(0)
-
-#define PIO_CONTROL			0x30
-#define PIO_CONTROL_ABORT		BIT(2)
-#define PIO_CONTROL_RS			BIT(1)
-#define PIO_CONTROL_ENABLE		BIT(0)
-
-#define PIO_QUEUE_CUR_STATUS		0x38
-#define CUR_IBI_Q_LEVEL			GENMASK(28, 20)
-#define CUR_RESP_Q_LEVEL		GENMASK(18, 10)
-#define CUR_CMD_Q_EMPTY_LEVEL		GENMASK(8, 0)
-
-#define PIO_DATA_BUFFER_CUR_STATUS	0x3c
-#define CUR_RX_BUF_LVL			GENMASK(26, 16)
-#define CUR_TX_BUF_LVL			GENMASK(10, 0)
-
-/*
- * Handy status bit combinations
- */
-
-#define STAT_LATENCY_WARNINGS		(STAT_WARN_RESP_QUEUE_FULL | \
-					 STAT_WARN_IBI_QUEUE_FULL | \
-					 STAT_WARN_RX_DATA_FULL | \
-					 STAT_WARN_TX_DATA_EMPTY | \
-					 STAT_WARN_INS_STOP_MODE)
-
-#define STAT_LATENCY_ERRORS		(STAT_ERR_RESP_QUEUE_FULL | \
-					 STAT_ERR_IBI_QUEUE_FULL | \
-					 STAT_ERR_RX_DATA_FULL | \
-					 STAT_ERR_TX_DATA_EMPTY)
-
-#define STAT_PROG_ERRORS		(STAT_TRANSFER_BLOCKED | \
-					 STAT_PERR_RESP_UFLOW | \
-					 STAT_PERR_CMD_OFLOW | \
-					 STAT_PERR_IBI_UFLOW | \
-					 STAT_PERR_RX_UFLOW | \
-					 STAT_PERR_TX_OFLOW)
-
-#define STAT_ALL_ERRORS			(STAT_TRANSFER_ABORT | \
-					 STAT_TRANSFER_ERR | \
-					 STAT_LATENCY_ERRORS | \
-					 STAT_PROG_ERRORS)
-
 struct hci_pio_dev_ibi_data {
 	struct i3c_generic_ibi_pool *pool;
 	unsigned int max_len;
diff --git a/drivers/i3c/master/mipi-i3c-hci/pio.h b/drivers/i3c/master/mipi-i3c-hci/pio.h
new file mode 100644
index 000000000000..72318961e991
--- /dev/null
+++ b/drivers/i3c/master/mipi-i3c-hci/pio.h
@@ -0,0 +1,109 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+/*
+ * Copyright (c) 2020, MIPI Alliance, Inc.
+ *
+ * Author: Nicolas Pitre <npitre@baylibre.com>
+ *
+ * PIO Access Area register and bitfield definitions.
+ */
+
+#ifndef PIO_H
+#define PIO_H
+
+#define PIO_COMMAND_QUEUE_PORT		0x00
+#define PIO_RESPONSE_QUEUE_PORT		0x04
+#define PIO_XFER_DATA_PORT		0x08
+#define PIO_IBI_PORT			0x0c
+
+#define PIO_QUEUE_THLD_CTRL		0x10
+#define QUEUE_IBI_STATUS_THLD		GENMASK(31, 24)
+#define QUEUE_IBI_DATA_THLD		GENMASK(23, 16)
+#define QUEUE_RESP_BUF_THLD		GENMASK(15, 8)
+#define QUEUE_CMD_EMPTY_BUF_THLD	GENMASK(7, 0)
+
+#define PIO_DATA_BUFFER_THLD_CTRL	0x14
+#define DATA_TX_START_THLD		GENMASK(18, 16)
+#define DATA_RX_START_THLD		GENMASK(26, 24)
+#define DATA_RX_BUF_THLD		GENMASK(10, 8)
+#define DATA_TX_BUF_THLD		GENMASK(2, 0)
+
+#define PIO_QUEUE_SIZE			0x18
+#define TX_DATA_BUFFER_SIZE		GENMASK(31, 24)
+#define RX_DATA_BUFFER_SIZE		GENMASK(23, 16)
+#define IBI_STATUS_SIZE			GENMASK(15, 8)
+#define CR_QUEUE_SIZE			GENMASK(7, 0)
+
+#define PIO_ALT_QUEUE_SIZE		0x1C
+#define EXT_IBI_QUEUE_EN		BIT(28)
+#define ALT_RESP_QUEUE_EN		BIT(24)
+#define ALT_RESP_QUEUE_SIZE		GENMASK(7, 0)
+
+#define PIO_INTR_STATUS			0x20
+#define PIO_INTR_STATUS_ENABLE		0x24
+#define PIO_INTR_SIGNAL_ENABLE		0x28
+#define PIO_INTR_FORCE			0x2c
+#define STAT_TRANSFER_BLOCKED		BIT(25)
+#define STAT_PERR_RESP_UFLOW		BIT(24)
+#define STAT_PERR_CMD_OFLOW		BIT(23)
+#define STAT_PERR_IBI_UFLOW		BIT(22)
+#define STAT_PERR_RX_UFLOW		BIT(21)
+#define STAT_PERR_TX_OFLOW		BIT(20)
+#define STAT_ERR_RESP_QUEUE_FULL	BIT(19)
+#define STAT_WARN_RESP_QUEUE_FULL	BIT(18)
+#define STAT_ERR_IBI_QUEUE_FULL		BIT(17)
+#define STAT_WARN_IBI_QUEUE_FULL	BIT(16)
+#define STAT_ERR_RX_DATA_FULL		BIT(15)
+#define STAT_WARN_RX_DATA_FULL		BIT(14)
+#define STAT_ERR_TX_DATA_EMPTY		BIT(13)
+#define STAT_WARN_TX_DATA_EMPTY		BIT(12)
+#define STAT_TRANSFER_ERR		BIT(9)
+#define STAT_WARN_INS_STOP_MODE		BIT(7)
+#define STAT_TRANSFER_ABORT		BIT(5)
+#define STAT_RESP_READY			BIT(4)
+#define STAT_CMD_QUEUE_READY		BIT(3)
+#define STAT_IBI_STATUS_THLD		BIT(2)
+#define STAT_RX_THLD			BIT(1)
+#define STAT_TX_THLD			BIT(0)
+
+#define PIO_CONTROL			0x30
+#define PIO_CONTROL_ABORT		BIT(2)
+#define PIO_CONTROL_RS			BIT(1)
+#define PIO_CONTROL_ENABLE		BIT(0)
+
+#define PIO_QUEUE_CUR_STATUS		0x38
+#define CUR_IBI_Q_LEVEL			GENMASK(28, 20)
+#define CUR_RESP_Q_LEVEL		GENMASK(18, 10)
+#define CUR_CMD_Q_EMPTY_LEVEL		GENMASK(8, 0)
+
+#define PIO_DATA_BUFFER_CUR_STATUS	0x3c
+#define CUR_RX_BUF_LVL			GENMASK(26, 16)
+#define CUR_TX_BUF_LVL			GENMASK(10, 0)
+
+/*
+ * Handy status bit combinations
+ */
+
+#define STAT_LATENCY_WARNINGS		(STAT_WARN_RESP_QUEUE_FULL | \
+					 STAT_WARN_IBI_QUEUE_FULL | \
+					 STAT_WARN_RX_DATA_FULL | \
+					 STAT_WARN_TX_DATA_EMPTY | \
+					 STAT_WARN_INS_STOP_MODE)
+
+#define STAT_LATENCY_ERRORS		(STAT_ERR_RESP_QUEUE_FULL | \
+					 STAT_ERR_IBI_QUEUE_FULL | \
+					 STAT_ERR_RX_DATA_FULL | \
+					 STAT_ERR_TX_DATA_EMPTY)
+
+#define STAT_PROG_ERRORS		(STAT_TRANSFER_BLOCKED | \
+					 STAT_PERR_RESP_UFLOW | \
+					 STAT_PERR_CMD_OFLOW | \
+					 STAT_PERR_IBI_UFLOW | \
+					 STAT_PERR_RX_UFLOW | \
+					 STAT_PERR_TX_OFLOW)
+
+#define STAT_ALL_ERRORS			(STAT_TRANSFER_ABORT | \
+					 STAT_TRANSFER_ERR | \
+					 STAT_LATENCY_ERRORS | \
+					 STAT_PROG_ERRORS)
+
+#endif

-- 
2.34.1


