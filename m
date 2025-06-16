Return-Path: <linux-aspeed+bounces-1478-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF1CC761AE
	for <linux-aspeed@archiver.kernel.org>; Mon, 16 Jun 2025 13:14:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bLVnm0W6rz30WS;
	Mon, 16 Jun 2025 23:14:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750079644;
	cv=none; b=RK0f3jonOy/FuxTbWmCq5JaJDORjXcjVhabJm8t3KwpsDqOs7bj4DfDYzKQ7XhM9vJp4CuAXegg3vVsrHgDinemkrxS+N+sKzbveWpirRYG+X8/BvYd3sc+k3xjr45XTEPp81uzhKwbwnP5xXKFl627nhGnptojDy/iMtSYgiXyFfKk8YHOVRnsWYDavGWrvv+bTHH2cEFeo57GrQZ+QXuG8PVRNGGpAfiLutLuXrayXKI6hN481XMV+f16GYN8TkqkKg05oFWdjncI9pUV1gEAgJBmAru74ZoTkQBM5/g7nM+okbZLT20zCYphi55Q4X/EmWR7tUG3fG/K+AF3c+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750079644; c=relaxed/relaxed;
	bh=DyK7Zsciqq7Gdc/WmqGLpznYW74mVN+9mTkl64s/CPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f2mlT0QEmMFg7lCmfJeb6mM4g0xQNas7fWDtc/f51fC1Y1uqSokeFDpG4/n2s5ECjX/DWs8NCFlLh6aKRVWhng1FYTLeswHNSYU7AdwUTJy9NkMmmOFWq0O1QmrkQmOvdS8pTO+JILL0nHDXHLTOSfYpVgInu4Yc4snzyZUX/qZ8mr9iAjOs7q5Kg9sCz/C7Tqpx1nRsBf6qylLWtnXIsfi9WrwietJj7nFfObGnyjsS1dkAyyS8miu4i7UJcP2vhGJ5eKOE3GHiiqX6x7CEyDcvjMb3mXPgRBa0vEk7QgwFvU4G3N71pz7b5IW2ZU8heo8UOKPYrPtmhWqbP/glww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=aU0U4ivu; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=aU0U4ivu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bLVnl5Xtjz30Vn
	for <linux-aspeed@lists.ozlabs.org>; Mon, 16 Jun 2025 23:14:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750079643;
	bh=DyK7Zsciqq7Gdc/WmqGLpznYW74mVN+9mTkl64s/CPk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aU0U4ivusVdtrxuWPPlu7XAx0brJ7c/IBctTBCJaQGerqk2Gf0jOWXL0Du8swgdMi
	 eJxyAWsihCFaZVdTzS59JSjvcvxNbsuuWhV7G4uJ1BbkTi0STlAe40YJIeN36sEz2r
	 RIdtkdFBPR351m+I5hkTr9sHg5qg4h/5v+1i3Zb5+VfzrDwcJB2rVcM1i2voLrQRlO
	 b21ScLnzRr+IYzlcPk3m49Bwuf5U5MwWwO0b6h0T53SwCTZ8Oyv0MSPH307JN/GI+l
	 M4xr10bWNXKwA2I6kC+WXoBg+wHTYZSwZb8XyPvUHeprcaQlUDEhn0TnBLaE+g8ToW
	 WYWDVe+n/yfLA==
Received: from [127.0.1.1] (unknown [180.150.112.166])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9E78B6884C;
	Mon, 16 Jun 2025 21:14:02 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 16 Jun 2025 22:43:44 +0930
Subject: [PATCH v2 07/10] soc: aspeed: lpc-snoop: Switch to
 devm_clk_get_enabled()
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
Message-Id: <20250616-aspeed-lpc-snoop-fixes-v2-7-3cdd59c934d3@codeconstruct.com.au>
References: <20250616-aspeed-lpc-snoop-fixes-v2-0-3cdd59c934d3@codeconstruct.com.au>
In-Reply-To: <20250616-aspeed-lpc-snoop-fixes-v2-0-3cdd59c934d3@codeconstruct.com.au>
To: linux-aspeed@lists.ozlabs.org
Cc: Joel Stanley <joel@jms.id.au>, Henry Martin <bsdhenrymartin@gmail.com>, 
 Jean Delvare <jdelvare@suse.de>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Andrew Geissler <geissonator@yahoo.com>, 
 Ninad Palsule <ninad@linux.ibm.com>, Patrick Venture <venture@google.com>, 
 Robert Lippert <roblip@gmail.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Andrew Jeffery <andrew@codeconstruct.com.au>
X-Mailer: b4 0.14.2

Simplify clock handling as done in other drivers.

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index 9992212c789d4224edcc0ee1a3bb9c73f9fc661b..bd4afa7f258eb3c1e64fe87d2b4be5f8422fbaf7 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -329,26 +329,21 @@ static int aspeed_lpc_snoop_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	lpc_snoop->clk = devm_clk_get(dev, NULL);
+	lpc_snoop->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(lpc_snoop->clk)) {
 		rc = PTR_ERR(lpc_snoop->clk);
 		if (rc != -EPROBE_DEFER)
 			dev_err(dev, "couldn't get clock\n");
 		return rc;
 	}
-	rc = clk_prepare_enable(lpc_snoop->clk);
-	if (rc) {
-		dev_err(dev, "couldn't enable clock\n");
-		return rc;
-	}
 
 	rc = aspeed_lpc_snoop_config_irq(lpc_snoop, pdev);
 	if (rc)
-		goto err;
+		return rc;
 
 	rc = aspeed_lpc_enable_snoop(lpc_snoop, dev, ASPEED_LPC_SNOOP_INDEX_0, port);
 	if (rc)
-		goto err;
+		return rc;
 
 	/* Configuration of 2nd snoop channel port is optional */
 	if (of_property_read_u32_index(dev->of_node, "snoop-ports",
@@ -356,16 +351,11 @@ static int aspeed_lpc_snoop_probe(struct platform_device *pdev)
 		rc = aspeed_lpc_enable_snoop(lpc_snoop, dev, ASPEED_LPC_SNOOP_INDEX_1, port);
 		if (rc) {
 			aspeed_lpc_disable_snoop(lpc_snoop, ASPEED_LPC_SNOOP_INDEX_0);
-			goto err;
+			return rc;
 		}
 	}
 
 	return 0;
-
-err:
-	clk_disable_unprepare(lpc_snoop->clk);
-
-	return rc;
 }
 
 static void aspeed_lpc_snoop_remove(struct platform_device *pdev)
@@ -375,8 +365,6 @@ static void aspeed_lpc_snoop_remove(struct platform_device *pdev)
 	/* Disable both snoop channels */
 	aspeed_lpc_disable_snoop(lpc_snoop, ASPEED_LPC_SNOOP_INDEX_0);
 	aspeed_lpc_disable_snoop(lpc_snoop, ASPEED_LPC_SNOOP_INDEX_1);
-
-	clk_disable_unprepare(lpc_snoop->clk);
 }
 
 static const struct aspeed_lpc_snoop_model_data ast2400_model_data = {

-- 
2.39.5


