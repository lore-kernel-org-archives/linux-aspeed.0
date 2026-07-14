Return-Path: <linux-aspeed+bounces-4478-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4698DC44508
	for <linux-aspeed@archiver.kernel.org>; Wed, 15 Jul 2026 07:31:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h0SY60rGrz2xWP;
	Wed, 15 Jul 2026 17:31:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=162.62.57.210
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784046816;
	cv=none; b=ebfcQBTL5iZR/Ma/4dXaw+5tHdtg8FEexH6CvtmJtgre9BpOlv3KnDEey/NPsg+5dWK1sPuA0GEPT4L31xszbonK1uV91vmNeBhd1QNo8wG4csRVXOJbsrQr3XsYbm4onuXu5qRweamQNU+yYUrrj3M01mcga1WWQGj6Gc3FgXW7X5d/LycgQ414zXJrsFwP9Q1PmzHaHH1UjFXEfnGntUHGlTwuGkmFqWHI64F2/XTSujDMIb/OfMDqyb+lqxsNpcIC33Ch9e4BNu+7SRL3i5aHIJlkh4GqwrPObwpK0Z2Ibu3EyFAWHlLlUnff91y70qsIB7ceNf0JMF6ZrlBFLw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784046816; c=relaxed/relaxed;
	bh=SbwCLFKbdOzKV5i/+UY6gKXliGQuPyrcEE9A2zGzU44=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=orKyfgj5ZA1DtEqBu+BsqcgfUwU02uu6tHOj5Qlt3CmzYVaz0OP60Lu56Lcue1lgrI93UwSHfPAxUlZH07pBt+oopPHehTWwm36bSKT6UqAVTyHilg4OcxMOlY4PDj9Ri6PCPPJQYBVap2KdnjCuSlhj8L0VkkJXq9Woz5Vde2CCG3GtfC94pvEAu63TUpeza20A4InsKk/QMvzouhcDMukoDzwHLXDquLPnn7rrmZw4xsasam270C5r/Hntmh9LUkRmwY+Kuq/qJa3qrnfcbZGwtqcTlZkfLAdf1sZFojOl5lyQ/e0tYX4TodJmAmxLT86KsMkp1XdM2y5aJCAbRw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=jTg3tL0S; dkim-atps=neutral; spf=pass (client-ip=162.62.57.210; helo=out162-62-57-210.mail.qq.com; envelope-from=920484857@qq.com; receiver=lists.ozlabs.org) smtp.mailfrom=qq.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=jTg3tL0S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=qq.com (client-ip=162.62.57.210; helo=out162-62-57-210.mail.qq.com; envelope-from=920484857@qq.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 11019 seconds by postgrey-1.37 at boromir; Wed, 15 Jul 2026 02:33:30 AEST
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4h04cV2W7Nz2y8p
	for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Jul 2026 02:33:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1784046796; bh=SbwCLFKbdOzKV5i/+UY6gKXliGQuPyrcEE9A2zGzU44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jTg3tL0SDeXkx9IXLXPtREYsdyrvTyPftXH5sBCZW1GOpgBA6/D2/Cunvk9PtDcDc
	 bB3CBOUQGraWDkC+BkJqVu9LBkQ21TW4xFyxkqfYH4lmqadnqkvuee8Ubwv8fMROXk
	 tTpmylr8bmVV0+u1q+SM3ViuMifsW5RSYx2X+MaY=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 70B1EC6E; Tue, 14 Jul 2026 21:28:11 +0800
X-QQ-mid: xmsmtpt1784035692t4weielk1
Message-ID: <tencent_B8B26921190C2CF6D2C906B793EDA107720A@qq.com>
X-QQ-XMAILINFO: NxKoLLhE22aTd/x9fnDR3jp18PMFxxKgbHYDQIOpNvDpEBX+nVa4VyweCRJzxf
	 1fjJObbD3tZsMMrIRl5PTBVqq53QCVi5Wu567Z3V/NX6HG2gDiroCFfFZs8P28FUu+71rBbCdqDX
	 V7ZOc/voIoB61FnfK8VOclBigTkP0Pm/IMqLM5N+rVVchytNR4fvbhz21sUr5QHPYoopjuxykJTD
	 aZTkxLWHeN55Z2MRfnl6gpG6FxfNjPSSfPOWrVqVNXp61NANepUsB9qc9Yc1+lET9sJmdurncwAr
	 kKNwRqBx36r/71dudQFkUM9ABymWJlnCMODAi2x+W9bSZQA53Fpcm+r2YY+cd8ReJw/PZhJe3EIB
	 Oem6t9VNhiQ+cgxXhVZ5OxxoaVCf7dIrAuTPmiG9/Pq0dPMxlOJFZWeFTiENjuq44osnRc8iQyrS
	 yKsYJ2wr51Ii2nsIr9eXMhddexY578jnlllg2vQRhbXmZe+Xaho6w+7XIAJYxa9BY2Zg1sww/diK
	 u+C+r9x4AXyk9qerLGF6UCd/V8VKflV6rUZNDbA5HnPDydFZV3Xcplx/fuXcn2xdkNhVOGsFMw4N
	 zD9bnPhsrZHBx0nh4bOlmiaJQiTK3DnEhy2vyz3GhnAC6+iyaoyqOtavYDfDxFcwlBGYu4MQ82ne
	 P9GZBm65Pg5PJQmtbxduSAVR43i8+JQQxFKRfgYxzfcA7yGdMid3bvjmxIFnND7IFWsbZrLAEMo1
	 T2VYBTGy8KNxrQ+78t8PE6AeO/zaviMoLY8UJMgcO/8pnmZwo5mL3fqlGHZk/lAjlShWl1t14epe
	 5s96cJu1pm8beDBTpxz/I86cWJj8HnyZC9ly5QivJPAstQtT1ikp2GLrGeGzeXDQJxrQDQxBF5lc
	 /CgwNg4RqNE3Q9gynASlFEmL0FK6nKirz/hFU8y9l4BWEpox2lCuLAh7IAG6/uyxBdlLQl5oj7qa
	 YE8onleiEVAfjsRdIvPPLE/gAf3yXwYnFJ1sk2aLvyI1FOyHtK2Y1WOqKymr9EeIzQRx2Zhg3u4F
	 S2/wbGXvWNgDMETcyOuBNRXEkgLYS9oUKSsOJ0QtayJSTHb77BGntP/q7mMGnYCCqNvx3n2Q==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Haofeng Li <920484857@qq.com>
To: tglx@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Haofeng Li <13266079573@163.com>,
	Haofeng Li <lihaofeng@kylinos.cn>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Jason Cooper <jason@lakedaemon.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org
Subject: [PATCH 10/16] irqchip/aspeed-vic: publish handler only after domain creation
Date: Tue, 14 Jul 2026 21:24:46 +0800
X-OQ-MSGID: <20260714132453.3302672-8-920484857@qq.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260714132453.3302672-1-920484857@qq.com>
References: <20260714122351.3274006-1-lihaofeng@kylinos.cn>
 <20260714132453.3302672-1-920484857@qq.com>
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
Content-Transfer-Encoding: 8bit

From: Haofeng Li <lihaofeng@kylinos.cn>

avic_of_init() publishes system_avic and installs the root IRQ
handler before creating the IRQ domain, then returns success even if
irq_domain_create_simple() fails.

Freeing the VIC after the root handler has been installed would leave
avic_handle_irq() pointing at a cleared or freed controller. Create
the domain first, then publish the controller and install the handler.
Also handle set_handle_irq() failure by removing the domain and
releasing all resources before the handler has been changed.

Fixes: 5952884258e5 ("irqchip/aspeed-vic: Add irq controller for Aspeed")

Signed-off-by: Haofeng Li <lihaofeng@kylinos.cn>
---
 drivers/irqchip/irq-aspeed-vic.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-aspeed-vic.c b/drivers/irqchip/irq-aspeed-vic.c
index 6649b893f39c..bb3cceec375f 100644
--- a/drivers/irqchip/irq-aspeed-vic.c
+++ b/drivers/irqchip/irq-aspeed-vic.c
@@ -186,6 +186,7 @@ static int __init avic_of_init(struct device_node *node,
 {
 	void __iomem *regs;
 	struct aspeed_vic *vic;
+	int ret;
 
 	if (WARN(parent, "non-root Aspeed VIC not supported"))
 		return -EINVAL;
@@ -206,15 +207,29 @@ static int __init avic_of_init(struct device_node *node,
 	/* Initialize sources, all masked */
 	vic_init_hw(vic);
 
-	/* Ready to receive interrupts */
-	system_avic = vic;
-	set_handle_irq(avic_handle_irq);
-
 	/* Register our domain */
 	vic->dom = irq_domain_create_simple(of_fwnode_handle(node), NUM_IRQS, 0,
 					    &avic_dom_ops, vic);
+	if (!vic->dom) {
+		ret = -ENOMEM;
+		goto err_free_vic;
+	}
+
+	/* Ready to receive interrupts */
+	system_avic = vic;
+	ret = set_handle_irq(avic_handle_irq);
+	if (ret)
+		goto err_remove_domain;
 
 	return 0;
+
+err_remove_domain:
+	system_avic = NULL;
+	irq_domain_remove(vic->dom);
+err_free_vic:
+	iounmap(regs);
+	kfree(vic);
+	return ret;
 }
 
 IRQCHIP_DECLARE(ast2400_vic, "aspeed,ast2400-vic", avic_of_init);
-- 
2.25.1


