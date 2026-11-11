Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64B260A2602
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Nov 2026 03:16:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPTG10t9Vz2yLY;
	Wed, 11 Nov 2026 14:16:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794367017;
	cv=none; b=H/j+lrmywALt3RC7JG3rgEpFi3h920Tr6A2KWQOlI7gUgG2K2Mhe9zIyIy93DzNVT71DhrtOkwHE8lfRIc/PcVU4urqBy4ZF6L1MOs2/ni+k11KiFBgazYhJZ2Ws51gBiXQuEtGNrwZjfQf52DspOXY34RP0Mrz9BrW844nARZJghr6aVeVYwNSS8jHNpYlHzSY3NyIyBXCkia4h3Zu8FP0LOFOJSjWYuE6AqwxB6ScjragDVnczv9Lk64r+4rNC+Vxl2JZHYfxNkukpx3as0SB1ryb+nAKQPpuhY07fXghpv9GBMzCTaId/bxN1zGCwpnkp1o5nJBGzRbz/d+u8iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794367017; c=relaxed/relaxed;
	bh=YsJez8/6/UAAho31rhpZBuRlFrlIaf+pv4nkj8vhW7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=YWUmFyFIkXMi144L7pXsY4BuVYcUb23g2PkDDjY2AM34wM5sJKcH8CD4jDlRIRxJApIK2k/YTIkPTeYCqL86hEqokQgg9XEmVZzQ6e7q4ccdDFuL3Q7Zy/FeFgy/eXHMiEnc/vgrgDR0HD4TEgKTe4+EDFG82XpCc7uN+KFFuCYMSPOIlDBPSbWUWgHmDgvoLCuqvq72H0ndDgEb5gA0v3UPqQ3GQ+HmhMGdGdOAQlppFTZQHQw2JK+9eHZgFTkb9fbeH6i1F/NRXFYNUHTapG+3UrnnltDUGCqw1FOkckfnB6ZucQynxk0JNNQvr4RkG/nhxKDY0gK+dVYD3voUGw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPTG020dMz2xMQ
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Nov 2026 14:16:56 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Wed, 11 Nov
 2026 11:16:32 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Wed, 11 Nov 2026 11:16:32 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Wed, 11 Nov 2026 11:16:33 +0800
Subject: [PATCH v2 5/9] i3c: mipi-i3c-hci: Add a quirk to clear the TX
 start threshold
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
Message-ID: <20261111-b4-i3c-hci-ast2700-v2-5-4d8fff5c5196@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794366991; l=3959;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=TT6DVgROupJj3o1NofDpSO7UhBTyX4AHTZoi/iJQSlA=;
 b=Ai9LkrYBBUliNFI6XRcHiqNjuuOuxzu0ReD+CeYTqZcZPRadOkfpPA5WVlazABTdEQH5uCIOe
 95HgtWJm3REBMstuKUB5zKwf2uRcfR46y43Sggk/6MS3afRxcrd3rRu
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
a controller soft reset.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/i3c/master/mipi-i3c-hci/core.c | 8 ++++++++
 drivers/i3c/master/mipi-i3c-hci/hci.h  | 2 ++
 drivers/i3c/master/mipi-i3c-hci/pio.c  | 7 +++++++
 3 files changed, 17 insertions(+)

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index 25d0aba6b300..da77384e985c 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -884,6 +884,14 @@ static int i3c_hci_set_io_mode(struct i3c_hci *hci, bool dma)
 	else
 		reg_set(HC_CONTROL, HC_CONTROL_PIO_MODE);
 
+	/*
+	 * On the ASPEED AST2700 the TX start threshold gates transfer start
+	 * even in DMA mode. Clear it so DMA transfers are not held back
+	 * waiting for a PIO FIFO level that will never be reached.
+	 */
+	if (dma && (hci->quirks & HCI_QUIRK_TX_START_THLD) && hci->PIO_regs)
+		mipi_i3c_hci_pio_clr_tx_start_thld(hci);
+
 	if (!is_version_1_1_or_newer(hci))
 		return 0;
 
diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
index 18a28360c728..3f28f821bf0d 100644
--- a/drivers/i3c/master/mipi-i3c-hci/hci.h
+++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
@@ -180,12 +180,14 @@ struct i3c_hci_dev_data {
 #define HCI_QUIRK_DMA_REQUIRES_HC_ABORT		BIT(9)  /* Use HC_CONTROL ABORT to abort DMA */
 #define HCI_QUIRK_DAT_INDEX_IS_ADDR	BIT(10)  /* DAT entries are indexed by device address */
 #define HCI_QUIRK_DMA_64BIT		BIT(11)  /* Controller DMA supports 64-bit addressing */
+#define HCI_QUIRK_TX_START_THLD		BIT(12)  /* Clear TX start threshold in DMA mode */
 
 /* global functions */
 void mipi_i3c_hci_resume(struct i3c_hci *hci);
 void mipi_i3c_hci_abort(struct i3c_hci *hci);
 void mipi_i3c_hci_pio_reset(struct i3c_hci *hci);
 void mipi_i3c_hci_pio_reset_all_queues(struct i3c_hci *hci);
+void mipi_i3c_hci_pio_clr_tx_start_thld(struct i3c_hci *hci);
 void mipi_i3c_hci_dct_index_reset(struct i3c_hci *hci);
 void amd_set_od_pp_timing(struct i3c_hci *hci);
 void amd_set_resp_buf_thld(struct i3c_hci *hci);
diff --git a/drivers/i3c/master/mipi-i3c-hci/pio.c b/drivers/i3c/master/mipi-i3c-hci/pio.c
index 439578a6eb54..a95ef7fc351c 100644
--- a/drivers/i3c/master/mipi-i3c-hci/pio.c
+++ b/drivers/i3c/master/mipi-i3c-hci/pio.c
@@ -118,6 +118,13 @@
 					 STAT_LATENCY_ERRORS | \
 					 STAT_PROG_ERRORS)
 
+void mipi_i3c_hci_pio_clr_tx_start_thld(struct i3c_hci *hci)
+{
+	u32 val = pio_reg_read(DATA_BUFFER_THLD_CTRL);
+
+	pio_reg_write(DATA_BUFFER_THLD_CTRL, val & ~DATA_TX_START_THLD);
+}
+
 struct hci_pio_dev_ibi_data {
 	struct i3c_generic_ibi_pool *pool;
 	unsigned int max_len;

-- 
2.34.1


