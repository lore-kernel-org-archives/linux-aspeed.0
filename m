Return-Path: <linux-aspeed+bounces-5063-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B6CC9830E
	for <linux-aspeed@archiver.kernel.org>; Wed, 30 Sep 2026 05:15:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvjt575WTz2yqT;
	Wed, 30 Sep 2026 15:15:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790745325;
	cv=none; b=O83Vd9R4HjT4RpGGOY6luo9XhfShFuGMTe477fI7k/osOExqtceaOwb9FwSqGYxuHQPuNIV9vv/xBNqcERcm/eDy8AOn6C6srxeLI7wPHj5LU4MApqswh6wVZRh4lHr2pgA/PvDVH4nyYzu0e5iR3k+7RefMHSXpVBnf95Z9MbleEtS974SkRuCZZxWDaREFKiFpQ1GC3LTPp/g2Ex2rd+sEwb1giw/Wp3c2J9wfz0yPTI4qI8K6MZtInQCzLkFIHjoQJqsi2GNJrsr8ojNOGTOnoZPWDljyORTswZsbeTLUP/qsTLZ/2QnUProKNK+j/Vps0I1d4Igb9/uE8XrqjA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790745325; c=relaxed/relaxed;
	bh=ToaTr9nCw8CRpNfW2tOaDTNTT5eV2ek9/YE3XY/AiNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=N5lKf/LfkNvm3xlh5s49gZU9ff5yLJbALLed4grDCb55A9XCbPhEYiNnz7GtALxcgZLBVWAOWTz6CvvwVDvWClF+f2pMjzDcsgLHMnFqKtLQWDmex/cgWfCzRtUFk96J6jRMHV5qyEQptoCeLE7hBT4FEl7LO8L/wGWYsTV2tIQTJOkTj2nCBTuBGFk29mHObpjCq1AY6AR9zDQbJ12qbzDFLZX+yPM7HR4MZtBGQ7xN3eU/KXBLgPlYXI3OwcXClWmlkwmF/9l+Ru5XL7qtOzrUy1huVZ7bf6p9Jqg4lIYKKRZ4bLiTksd+33iPNj5GPw410hiifLfVazNHsUCuIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvjt51vV5z2xnQ
	for <linux-aspeed@lists.ozlabs.org>; Wed, 30 Sep 2026 15:15:25 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 30 Sep
 2026 13:15:00 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 30 Sep 2026 13:15:00 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 30 Sep 2026 13:15:00 +0800
Subject: [PATCH v4 2/9] EDAC/aspeed: Free the interrupt before the
 mem_ctl_info on remove
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
Message-ID: <20260930-edac-v4-2-c2e526f3ed79@aspeedtech.com>
References: <20260930-edac-v4-0-c2e526f3ed79@aspeedtech.com>
In-Reply-To: <20260930-edac-v4-0-c2e526f3ed79@aspeedtech.com>
To: Stefan Schaeckeler <sschaeck@cisco.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, Borislav Petkov <bp@suse.de>, Ryan Chen
	<ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790745299; l=1381;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=xfnhxHJqIcWx+yqcMApIiBOpfhKo5Hdnp9j5TMIgdEc=;
 b=FdNW3hlvPud1TirgbEu7Fmt84CzEsuZiJGTUUd+Kpe0XIbfaQBlVmetPwC3sIqQn0SmRRX4k0
 MwwHFA0Xe+NDmLX0ePDz4BBHe3LuzNs93TyFtMDgqYTYUixhtN3kfC/
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

The ECC interrupt is devm-managed, so it is only released after .remove()
has returned, and masking the controller does not wait for a handler
already running on another CPU. edac_mc_free() can therefore free the
mem_ctl_info the handler uses as its context while it is still running.

Fix the ordering and synchronise by freeing the interrupt prior to
releasing related memory.

Fixes: 9b7e6242ee4e ("EDAC, aspeed: Add an Aspeed AST2500 EDAC driver")
Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

---
Changes in v4:
- Drop the Cc: stable tag.

Changes in v2:
- New patch.
---
 drivers/edac/aspeed_edac.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
index 83d60414f89a..e05ebed5c2f2 100644
--- a/drivers/edac/aspeed_edac.c
+++ b/drivers/edac/aspeed_edac.c
@@ -359,11 +359,16 @@ static int aspeed_probe(struct platform_device *pdev)
 static void aspeed_remove(struct platform_device *pdev)
 {
 	struct mem_ctl_info *mci;
+	int irq;
 
 	/* disable interrupts */
 	regmap_update_bits(aspeed_regmap, ASPEED_MCR_INTR_CTRL,
 			   ASPEED_MCR_INTR_CTRL_ENABLE, 0);
 
+	irq = platform_get_irq(pdev, 0);
+	WARN_ON(irq < 0);
+	devm_free_irq(&pdev->dev, irq, platform_get_drvdata(pdev));
+
 	/* free resources */
 	mci = edac_mc_del_mc(&pdev->dev);
 	if (mci)

-- 
2.34.1


