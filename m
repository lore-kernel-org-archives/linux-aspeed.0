Return-Path: <linux-aspeed+bounces-5143-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3A6CA600B
	for <linux-aspeed@archiver.kernel.org>; Wed,  7 Oct 2026 06:13:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j02r52KrSz30HB;
	Wed, 07 Oct 2026 17:13:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791353621;
	cv=none; b=HHp6pf9hIc3iM56yaorcIfaybH3LU6RbjkavS6YJof1WMzdkV8evPkrnNUzcBN6p2x9/2zeRgvixDrNUq+5ZyliCLiE57w0QEhgWNglXzRVlAthhYnb6gNIs1LaDqk49qLcWHKIGrRs6g5GzTF0HZ63j6TdB0eXpVoNZ8i9GCbJ9hdxxGjEemudk13jkIj888338Qqv6QWKHbHy5HvP1o+A8ZNMCFScKPo99q8DQ6xZuMxKMO+z499k/n3RReW2eQ/9B3blFxYZbydwhWruHxoXUemSu4DBH6p3XJmZGCEScmSSacuIusmXC/NAV4xxlTrJ3VV1y6Z5vbFpzuOr/Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791353621; c=relaxed/relaxed;
	bh=2wfWb6pR/Jd7nyknzw8Bq27GUa+yqLx4jC5oPYHK8jo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=eCgch+7eeFXX1EnZ0BEgjCqd2w/FPgGzpKuqy3Cp8sHoW8Eu+nLsWWHBj128n3CrbOFQuYlLYPfyYDYNYi+jE1xtDKbU7YPIJ3Zm6kZcmknfI7oi1dFuSceYmK+9MV9kwb5FfE3601WIO+SARu1FJkLsT2kYsuBDSX1dZkxiiOkmSedgX9gy3FKc9dvS0oHBU6LQpVBkD/lRJXtZH9+soFABgvIfFVq55JUbHlrNxo0BWlUzHBv3BMEASNkj4eagZSWuM1qaB4vHcdvMIFNBtawJc34LbY0KTUs48x7MCH88uU9MNlO5Nm5xDrz16FBp9EQkPhkZ1GBAXdbJSZSuew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j02r44P58z2y8f
	for <linux-aspeed@lists.ozlabs.org>; Wed, 07 Oct 2026 17:13:40 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 7 Oct
 2026 14:13:19 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 7 Oct 2026 14:13:19 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 7 Oct 2026 14:13:19 +0800
Subject: [PATCH v5 2/9] EDAC/aspeed: Free the interrupt before the
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
Message-ID: <20261007-edac-v5-2-5c31fc5df4cf@aspeedtech.com>
References: <20261007-edac-v5-0-5c31fc5df4cf@aspeedtech.com>
In-Reply-To: <20261007-edac-v5-0-5c31fc5df4cf@aspeedtech.com>
To: Stefan Schaeckeler <sschaeck@cisco.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, Borislav Petkov <bp@suse.de>, Ryan Chen
	<ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791353599; l=2176;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=HAabpmX2c//xzySbY96a1LqNR0wWgYBnoW1KUfWu6LE=;
 b=1NyCPAkhY78g1xuIJge7tW+Ruluz5gE63m7zzEcYSHL3a5vdv8o6xe757IGZlvwD70KD3K9kP
 FA9zfC30FxqB/pfflP6akobu/coHbbTw3sNsaf7qkcuWpY6wpp160vf
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

The ECC interrupt is devm-managed, so it is only released after .remove()
has returned, and masking the controller does not wait for a handler
already running on another CPU. edac_mc_free() can therefore free the
mem_ctl_info the handler uses as its context while it is still running.

Register the handler with request_irq() and free it before the memory
it uses. aspeed_probe() returns as soon as config_irq() succeeds, so
devres has no error path left to unwind.

Fixes: 9b7e6242ee4e ("EDAC, aspeed: Add an Aspeed AST2500 EDAC driver")
Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

---
Changes in v5:
- Use request_irq()/free_irq() rather than devm_request_irq() followed
  by an explicit free, and keep the interrupt number in a file-scope
  variable so aspeed_remove() does not have to call platform_get_irq()
  a second time.

Changes in v4:
- Drop the Cc: stable tag.

Changes in v2:
- New patch.
---
 drivers/edac/aspeed_edac.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
index 83d60414f89a..cb233a33d29a 100644
--- a/drivers/edac/aspeed_edac.c
+++ b/drivers/edac/aspeed_edac.c
@@ -36,6 +36,7 @@
 
 
 static struct regmap *aspeed_regmap;
+static int aspeed_irq;
 
 
 static int regmap_reg_write(void *context, unsigned int reg, unsigned int val)
@@ -212,11 +213,12 @@ static int config_irq(void *ctx, struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	rc = devm_request_irq(&pdev->dev, irq, mcr_isr, IRQF_TRIGGER_HIGH,
-			      DRV_NAME, ctx);
+	rc = request_irq(irq, mcr_isr, IRQF_TRIGGER_HIGH, DRV_NAME, ctx);
 	if (rc)
 		return rc;
 
+	aspeed_irq = irq;
+
 	/* enable interrupts */
 	regmap_update_bits(aspeed_regmap, ASPEED_MCR_INTR_CTRL,
 			   ASPEED_MCR_INTR_CTRL_ENABLE,
@@ -364,6 +366,8 @@ static void aspeed_remove(struct platform_device *pdev)
 	regmap_update_bits(aspeed_regmap, ASPEED_MCR_INTR_CTRL,
 			   ASPEED_MCR_INTR_CTRL_ENABLE, 0);
 
+	free_irq(aspeed_irq, platform_get_drvdata(pdev));
+
 	/* free resources */
 	mci = edac_mc_del_mc(&pdev->dev);
 	if (mci)

-- 
2.34.1


