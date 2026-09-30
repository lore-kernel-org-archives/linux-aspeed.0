Return-Path: <linux-aspeed+bounces-5065-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D58CCA5FBF
	for <linux-aspeed@archiver.kernel.org>; Wed, 30 Sep 2026 05:15:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvjt76YlHz30C0;
	Wed, 30 Sep 2026 15:15:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790745327;
	cv=none; b=fQ3OfteuVUFHSbmIPrXxTFx6KmVI9tQU2ZECy8dlystjOaSdWmPgo0aHUBE6nNa8GegKYFHDHVMuquF5gt5UTiP3BstjGOVLLRqOaywPFSSqhGqluCD/v/1AHZTsKkPZIxt03kBy3nmDAhvFX9F4l6ZSulYNDdLWyKG+OF72LudOl2jCj8YcNmtCrwFnEZbqRHvwkF7U+xuZf9CI7GbzZVal/a5rdgqwgzY/6wZuv62N4jRiBnQAb+0zbOGOfmRnADJWg4CSVEBkxUD0kdfo3NPBelWQXm4QykWN+jnEex3EUAFYhU5/6mPDtg6awDdtxEs0mtUahcakWgc2S8oPVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790745327; c=relaxed/relaxed;
	bh=WzfGEJLpHwH50IZOK4KkDMKN3sG+LbnJq7S0viXLif8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=FWbBY5lZiKv80k17pt0CEqqDmO+HietXB93ohN/1SJwNrRMAohJsXoz5wwTt1oxhB2wF4l0c0e3tiF9WUdr+0zVJe4U81WVuxdGt17R19AX3At064nfo+zOjSpK+tuXtwbnyyv9bYIOU9ihZzqAd8+BxSwU5CRmO5FRI7Ex4aNvuGU06LnUYNrLXA2e0cseZnqgmRd8++Ja4xet9k+9lB2vDJjeS4pt6I+Vb4IDA36WzRmQUhcqqTi+OpJlQBogLwOOwIotew3BMDdSpmgz+Od0SkZhq+ndcRg7/X1zCsGYdC2TlmfcYyJQOxycXH8OlpLWB6o80irfywhTDqBnvWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvjt71bldz2xnQ
	for <linux-aspeed@lists.ozlabs.org>; Wed, 30 Sep 2026 15:15:27 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 30 Sep
 2026 13:15:00 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 30 Sep 2026 13:15:00 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 30 Sep 2026 13:15:02 +0800
Subject: [PATCH v4 4/9] EDAC/aspeed: Free the mem_ctl_info unconditionally
 on remove
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
Message-ID: <20260930-edac-v4-4-c2e526f3ed79@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790745299; l=1565;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=7kVBSW+iJq7iG0C/gaN+W7UHNDDfaeN9Q8zh7Gh7SjI=;
 b=H9Byb9NgdLg6aM+qdKUhskY0XKNa9wuQwv/hYGV/IVIx4+FzRHam+Uz3t55eaUDaRKrtRnhCy
 qdDLVAR5fFgBFRt9FCt3bjZCcOCH6GYL53CQoZE0ZvBMxugVM7OmnRY
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

aspeed_remove() is a driver .remove callback, so it only runs for a device
that has already probed successfully and registered its mem_ctl_info. In
that case edac_mc_del_mc() always returns the same, valid pointer, and the
NULL check on its return value can never be false.

Fetch the mem_ctl_info from the platform device's driver data instead and
free it unconditionally, dropping the redundant check. This also decouples
the teardown from the return value of edac_mc_del_mc().

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 drivers/edac/aspeed_edac.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
index cd2a6fcca355..352910e1defc 100644
--- a/drivers/edac/aspeed_edac.c
+++ b/drivers/edac/aspeed_edac.c
@@ -343,7 +343,7 @@ static int aspeed_probe(struct platform_device *pdev)
 
 static void aspeed_remove(struct platform_device *pdev)
 {
-	struct mem_ctl_info *mci;
+	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
 	int irq;
 
 	/* disable interrupts */
@@ -352,12 +352,11 @@ static void aspeed_remove(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	WARN_ON(irq < 0);
-	devm_free_irq(&pdev->dev, irq, platform_get_drvdata(pdev));
+	devm_free_irq(&pdev->dev, irq, mci);
 
 	/* free resources */
-	mci = edac_mc_del_mc(&pdev->dev);
-	if (mci)
-		edac_mc_free(mci);
+	edac_mc_del_mc(&pdev->dev);
+	edac_mc_free(mci);
 }
 
 static const struct of_device_id aspeed_of_match[] = {

-- 
2.34.1


