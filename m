Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D57160A2615
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Nov 2026 03:16:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPTG00Qhhz2yKn;
	Wed, 11 Nov 2026 14:16:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794367016;
	cv=none; b=R3qrOQDk2tuRkOX8fdwRdK2CG5/IECEEEXs/BzsVR7T/93ylPb9kxRyudPB6jegXtxdlcDmFp3Jbff4xy+P4NaKnf56YzmLLdGH5EpEwimE0BBo6zsNra+HvkArXxdLy8h4a7uuB0mwNsU6opwPJ7wOqryeWTPij7Artin+qnIVF+hAdUNCEoSdvLfmk4d5o4oKZRJYLUbI6l6zxhjupJExB52RgYlzcYlXKXJNzpozsZi14gR3+kZpw/Lx2uGj8YaFmTxtNcnfeGIuryNsHoQLrnlAPMKUZux1Q84eB3pZ0q4n7CWQ29eTw4epu0rWtRurYCZCyJXMrKrNv6Y5lDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794367016; c=relaxed/relaxed;
	bh=QFpGYDFuAve0mJDexc+jDpWWXx/HSO8P2PL6X/pDSEI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ecgz0bOhIwfxbKSVerEEFqz4AhCZmxTpMhrRYJdfKooXjyMxFkoC5P6RViArOrFw5bC+k+Y1HIkfiVyO68Cm/G7Idnf2UvJADu6EZggUyPgj51I/MfIrwZ+srhbWg1Y0nSmHrGG8nWcKkK78IELohx28MP3EJj/tM5YvFJYAwJJ1ipHXum10BRx+BNjOuVWj2D9yRHDsppCzMsWi5lD4b/5SctQ6QaRc61BhK7kkKtDZUwJ256p1xYvUhutv6WSeVYbb7NzhJWUk5SdgiP9kMyEHaDHpkNsIDwzvCx1RkipZ7pw+ayeGF+zQF5pSyJTNpGzL34T86cHPyD6dzLeCGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPTFz1dsfz2xMQ
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Nov 2026 14:16:55 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Wed, 11 Nov
 2026 11:16:32 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Wed, 11 Nov 2026 11:16:32 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Wed, 11 Nov 2026 11:16:32 +0800
Subject: [PATCH v2 4/9] i3c: mipi-i3c-hci: Add a quirk for 64-bit DMA
 addressing
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
Message-ID: <20261111-b4-i3c-hci-ast2700-v2-4-4d8fff5c5196@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794366991; l=2366;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=7ZpEhZCLKG0PKVq19jZjqW8c3T+nRcKqcvBoQPjHL+E=;
 b=7P761tJtEbJGJL1WEdKOYKsqMISd8ViZWMPlkRmnEpwu/lbtUOQXzPpLB55keyjd4IxymYKJY
 hsKbMEQeUtDDhp5VW4Zluve7FO7+RUBjH3q4Yr1nR/hMIBdjcxmxtUP
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The HCI ring base registers are 64 bits wide by specification, but not
every implementation wires the upper half, so the driver leaves the
platform device at the default 32-bit DMA mask unless told otherwise.
ASPEED platforms place all of DRAM above the 32-bit boundary
(0x4_00000000), so under the default mask every dma_alloc_coherent()
call for the DMA rings fails.

Add HCI_QUIRK_DMA_64BIT for controllers whose DMA engine drives the
full address width, and declare a 64-bit streaming and coherent DMA
mask for them before the rings are allocated.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/i3c/master/mipi-i3c-hci/core.c | 4 ++++
 drivers/i3c/master/mipi-i3c-hci/hci.h  | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index b8f8254ed19c..25d0aba6b300 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -10,6 +10,7 @@
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/device.h>
+#include <linux/dma-mapping.h>
 #include <linux/errno.h>
 #include <linux/i3c/master.h>
 #include <linux/interrupt.h>
@@ -1231,6 +1232,9 @@ static int i3c_hci_probe(struct platform_device *pdev)
 	if (!hci->quirks && platform_get_device_id(pdev))
 		hci->quirks = platform_get_device_id(pdev)->driver_data;
 
+	if (hci->quirks & HCI_QUIRK_DMA_64BIT)
+		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+
 	ret = devm_clk_bulk_get_all_enabled(&pdev->dev, &clks);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret,
diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
index 2e610373600e..18a28360c728 100644
--- a/drivers/i3c/master/mipi-i3c-hci/hci.h
+++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
@@ -179,6 +179,7 @@ struct i3c_hci_dev_data {
 #define HCI_QUIRK_DMA_ABORT_REQUIRES_PIO_RESET	BIT(8)  /* Do PIO queue SW resets after DMA abort */
 #define HCI_QUIRK_DMA_REQUIRES_HC_ABORT		BIT(9)  /* Use HC_CONTROL ABORT to abort DMA */
 #define HCI_QUIRK_DAT_INDEX_IS_ADDR	BIT(10)  /* DAT entries are indexed by device address */
+#define HCI_QUIRK_DMA_64BIT		BIT(11)  /* Controller DMA supports 64-bit addressing */
 
 /* global functions */
 void mipi_i3c_hci_resume(struct i3c_hci *hci);

-- 
2.34.1


