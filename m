Return-Path: <linux-aspeed+bounces-4828-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B01C5DF9D
	for <linux-aspeed@archiver.kernel.org>; Mon, 24 Aug 2026 02:42:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hSwF80kq5z2y2g;
	Mon, 24 Aug 2026 12:42:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787539372;
	cv=none; b=nox2iTDIaH41p19JgWIqaeH/BV3X51rTcI2k99GnX4k4VhEkQBg4beyjwBczi6YOazk2jKTh36y3PCk4vBWLjz03cs1FHWU/T5CgCnIzyuopxcZugZcjIogf53XVYRqzSHmf8zo6Z1Lbvxd81bN1fZCfke6CRxTif1FcaK98l5lnAjwkeFFYkXQWzOkDkeWHIKVzg4ouCAfAzirXxpJDvJYuAEuHisqMiitoGHR0Z5CgtirjiwOJBw8cLnZjOxWQMFGcppNx0oJe1c7vXKQvcWmVL2vcNMWEdyWE/ivxCNHAMhD53Xt05vPo4jR613YrxFtRphA6Alo8nQ4SME+klA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787539372; c=relaxed/relaxed;
	bh=StOLANgoUDdDCghzEyyTo31Qu80FIuZFNWrDA8Xal/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=RHGdE5OzhfKRSZKNOp/gNQAlaZ22O6EBIFIYMZb0Qj8WTTilUn9R9FbjSzDSbCunaE68M4AShkNj5euT2DwZwQExItsEQ3pPwuIpN9LoaCZ5AhTCwyVNsyhfyuaYlBFDrCfJrMDtErCZPMYc6Cp7RRf6c4kta62H/wPCg+g/Gf4xD73cDmIKoNLxalYauOuc6BQjfeSfotOSCZpRmQHENP1YLNK7wVN5J1fUonPn214tu3d1uf/fLMQDObLlsJFCACeHsQ0HZtZsOdUo6WiuQJX1MBE3EM5op6k37Uf1DbF/Gjm8IKd5gMTzyOwAl3s0DReLw8LhLitbecz7fiaRZg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hSwF72Rl0z2xmk
	for <linux-aspeed@lists.ozlabs.org>; Mon, 24 Aug 2026 12:42:51 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 24 Aug
 2026 10:42:29 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 24 Aug 2026 10:42:29 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Mon, 24 Aug 2026 10:42:30 +0800
Subject: [PATCH v2 3/8] EDAC/aspeed: Free the interrupt before the
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
Message-ID: <20260824-edac-v2-3-c8d8bb693586@aspeedtech.com>
References: <20260824-edac-v2-0-c8d8bb693586@aspeedtech.com>
In-Reply-To: <20260824-edac-v2-0-c8d8bb693586@aspeedtech.com>
To: Stefan Schaeckeler <sschaeck@cisco.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>,
	<stable@vger.kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787539349; l=1363;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=RlxiTc6ufbAPp2W9fkd50aRtYznC++m4JM40pI/YrqE=;
 b=gpm27cUcRMtuWzCYAMZDJ+ZRjHayMCjYlYb1GvBw7j/JjEkz5DoJugDkwdsgHS1YKJBXoglg0
 LrgCW0p3PfhD0Ihn/PVxqB2zZL+Dut7Vd3Y6FJ9p6NtwOpzsuoeFiW4
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
Cc: stable@vger.kernel.org

---
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


