Return-Path: <linux-aspeed+bounces-4316-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 679FAC43458
	for <linux-aspeed@archiver.kernel.org>; Mon, 29 Jun 2026 23:56:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gq38671Tkz2ySD;
	Tue, 30 Jun 2026 09:56:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782715777;
	cv=none; b=jJLL3IN0esATDpGMvcqFTETCyZYU/2Pm82djE4G8COBub28UkJygCjXcVd+pqIgOzHqrROAfMlBAiK4Ev0tOwdtbxtx9N+dmgha1v7YEBww5LdGO8cJr/1PdH2Ajg8gu7IZRKD3ceCGilG2s5Zokm6S7iZG0EYyIeik6W8tIFo/qG0aaeV/E2OL8Mny1WMoPG5N2qFAvWv9vZqwN6NwQZ4FOvPzJDUR/9EQNrBPJ10Vtpyh+njaYMh+4i18BGh29aFs/L0qk3wehSEd5OLo2h91rSdZoJCLYB2vISFB/8foYHr93Vjcm8TlZFcCOEhtGi+coXM7xMM8rq6+ZHZAmzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782715777; c=relaxed/relaxed;
	bh=Brem5F6jsxIN6etVsDIuamNk9v7c1ikSU0zYL3gtl7k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GGfzwIxKs5FQsWITpHubewkl3jFl4gk5Pfz6z8UUSCrqe42ktxBY9a1mi7+HbEi58sqQ8Z4QfZXRfPA9fkuSKIkpsMC6Pooaz3V9mI6d4PMJlmrFFN14cXbDHUEMZwA227/2fb/jKq+N1f4tI+bXpYy3IRanjthI6ATvZoINS72FF139L+JtvJdUtKnMSaGxbTIBMRl3469iwfQBpiPI1Yg6i3ILmub7SloOj6Y1q+co7s5J3++EyBJhDnboEi5RxZkv20NUxQWPFI6fP6vu74iPsuEJbfPyTQuQ6nc4GcO6dCKMx5i3ZjatRiOrSHAhSl9Xmv3AA9rSNwjOeM+HFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qAJxWiPV; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+yc_hsieh.aspeedtech.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qAJxWiPV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+yc_hsieh.aspeedtech.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpcMh1cLLz2yb9
	for <linux-aspeed@lists.ozlabs.org>; Mon, 29 Jun 2026 16:49:36 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1A84F43D71;
	Mon, 29 Jun 2026 06:49:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E60A0C2BCF4;
	Mon, 29 Jun 2026 06:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782715774;
	bh=FDwiNnQBBCZ/QNpWwqyHzdSkJIqsF5fGdO+P3uhJhds=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qAJxWiPVg6528Lhg4/0l0Av5OZ8Gz+nivKx5XllbrCQ8K3951ahAjQKIrxZ2w9+US
	 9KEMeSuKAenLBKu6fD+biwpbGu1Y/yNNIUAe82HYmpVnSCeoApmJ8soBTa5Vh9FXem
	 maezA0zXrkmlJe/AsUXsT0ahXmv1XyunYhe1azV/6ad4TRjpakhJ5HxIpaTmuXdxtJ
	 ktsBMxHYjM3ZeWd8v0OnF59BtCrlYrBx9RO5RNEtiqFvXUwectd/Ul7hXr/QTqOWd7
	 dyjt8rqACywE5z5NgwtIe040NB1R5SGRHs7dlaFp1Nv3hFWOoXxJdjFx2JBsGvFA1b
	 pRnCuF+2do9nA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDDCC43638;
	Mon, 29 Jun 2026 06:49:33 +0000 (UTC)
From: Yu-Che Hsieh via B4 Relay <devnull+yc_hsieh.aspeedtech.com@kernel.org>
Date: Mon, 29 Jun 2026 14:48:58 +0800
Subject: [PATCH 1/4] ipmi: bt-bmc: Use bitfield helpers for register
 definitions
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
Message-Id: <20260629-aspeed-bt-bmc-multichannel-v1-1-fc23ee337f7a@aspeedtech.com>
References: <20260629-aspeed-bt-bmc-multichannel-v1-0-fc23ee337f7a@aspeedtech.com>
In-Reply-To: <20260629-aspeed-bt-bmc-multichannel-v1-0-fc23ee337f7a@aspeedtech.com>
To: Corey Minyard <corey@minyard.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, Yu-Che Hsieh <yc_hsieh@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782715772; l=3925;
 i=yc_hsieh@aspeedtech.com; s=20260629; h=from:subject:message-id;
 bh=HQw8rGJUsM6loLGP55U5cgMUUCPUOKcrGTqHI8TGeyw=;
 b=Mg57Y/Vn2ocHuNlZAZqksIQ0vRHfMU0JKXY0uL/knqv7c4ICD8NzGXdCdiFClN9xhS/Yheusc
 B5G083PbCmYD71NYrV8XV1FsDJV8yyawcP2dzWurZPGlGsjI8mi6jI7
X-Developer-Key: i=yc_hsieh@aspeedtech.com; a=ed25519;
 pk=kLxUeF7g6teciq79it9N3tYNgp3yCspZ+AHlYSnZ0gs=
X-Endpoint-Received: by B4 Relay for yc_hsieh@aspeedtech.com/20260629 with
 auth_id=844
X-Original-From: Yu-Che Hsieh <yc_hsieh@aspeedtech.com>
Reply-To: yc_hsieh@aspeedtech.com

From: Yu-Che Hsieh <yc_hsieh@aspeedtech.com>

Use BIT(), GENMASK(), and FIELD_PREP() for the BT register definitions

and register field programming.

This makes the register layout easier to read and prepares the driver

for later changes that need to program the BT_CR0 fields from device

configuration.

Signed-off-by: Yu-Che Hsieh <yc_hsieh@aspeedtech.com>
---
 drivers/char/ipmi/bt-bmc.c | 72 ++++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 35 deletions(-)

diff --git a/drivers/char/ipmi/bt-bmc.c b/drivers/char/ipmi/bt-bmc.c
index a179d4797011..f3c67272502f 100644
--- a/drivers/char/ipmi/bt-bmc.c
+++ b/drivers/char/ipmi/bt-bmc.c
@@ -15,6 +15,7 @@
 #include <linux/poll.h>
 #include <linux/sched.h>
 #include <linux/timer.h>
+#include <linux/bitfield.h>
 
 /*
  * This is a BMC device used to communicate to the host
@@ -24,33 +25,34 @@
 #define BT_IO_BASE	0xe4
 #define BT_IRQ		10
 
-#define BT_CR0		0x0
-#define   BT_CR0_IO_BASE		16
-#define   BT_CR0_IRQ			12
-#define   BT_CR0_EN_CLR_SLV_RDP		0x8
-#define   BT_CR0_EN_CLR_SLV_WRP		0x4
-#define   BT_CR0_ENABLE_IBT		0x1
-#define BT_CR1		0x4
-#define   BT_CR1_IRQ_H2B	0x01
-#define   BT_CR1_IRQ_HBUSY	0x40
-#define BT_CR2		0x8
-#define   BT_CR2_IRQ_H2B	0x01
-#define   BT_CR2_IRQ_HBUSY	0x40
-#define BT_CR3		0xc
-#define BT_CTRL		0x10
-#define   BT_CTRL_B_BUSY		0x80
-#define   BT_CTRL_H_BUSY		0x40
-#define   BT_CTRL_OEM0			0x20
-#define   BT_CTRL_SMS_ATN		0x10
-#define   BT_CTRL_B2H_ATN		0x08
-#define   BT_CTRL_H2B_ATN		0x04
-#define   BT_CTRL_CLR_RD_PTR		0x02
-#define   BT_CTRL_CLR_WR_PTR		0x01
-#define BT_BMC2HOST	0x14
-#define BT_INTMASK	0x18
-#define   BT_INTMASK_B2H_IRQEN		0x01
-#define   BT_INTMASK_B2H_IRQ		0x02
-#define   BT_INTMASK_BMC_HWRST		0x80
+#define BT_CR0			0x0
+#define   BT_CR0_IO_BASE	GENMASK(31, 16)
+#define   BT_CR0_SIRQ		GENMASK(15, 12)
+#define   BT_CR0_SIRQ_TYPE	GENMASK(11, 10)
+#define   BT_CR0_EN_CLR_SLV_RDP	BIT(3)
+#define   BT_CR0_EN_CLR_SLV_WRP	BIT(2)
+#define   BT_CR0_ENABLE_IBT	BIT(0)
+#define BT_CR1			0x4
+#define   BT_CR1_IRQ_EN_HBUSY	BIT(6)
+#define   BT_CR1_IRQ_EN_H2B	BIT(0)
+#define BT_CR2			0x8
+#define   BT_CR2_IRQ_STS_HBUSY	BIT(6)
+#define   BT_CR2_IRQ_STS_H2B	BIT(0)
+#define BT_CR3			0xc
+#define BT_CTRL			0x10
+#define   BT_CTRL_B_BUSY	BIT(7)
+#define   BT_CTRL_H_BUSY	BIT(6)
+#define   BT_CTRL_OEM0		BIT(5)
+#define   BT_CTRL_SMS_ATN	BIT(4)
+#define   BT_CTRL_B2H_ATN	BIT(3)
+#define   BT_CTRL_H2B_ATN	BIT(2)
+#define   BT_CTRL_CLR_RD_PTR	BIT(1)
+#define   BT_CTRL_CLR_WR_PTR	BIT(0)
+#define BT_BMC2HOST		0x14
+#define BT_INTMASK		0x18
+#define   BT_INTMASK_BMC_HWRST	BIT(7)
+#define   BT_INTMASK_B2H_IRQ	BIT(1)
+#define   BT_INTMASK_B2H_IRQEN	BIT(0)
 
 #define BT_BMC_BUFFER_SIZE 256
 
@@ -361,7 +363,7 @@ static irqreturn_t bt_bmc_irq(int irq, void *arg)
 
 	reg = readl(bt_bmc->base + BT_CR2);
 
-	reg &= BT_CR2_IRQ_H2B | BT_CR2_IRQ_HBUSY;
+	reg &= BT_CR2_IRQ_STS_H2B | BT_CR2_IRQ_STS_HBUSY;
 	if (!reg)
 		return IRQ_NONE;
 
@@ -398,7 +400,7 @@ static int bt_bmc_config_irq(struct bt_bmc *bt_bmc,
 	 * message to the BT buffer
 	 */
 	reg = readl(bt_bmc->base + BT_CR1);
-	reg |= BT_CR1_IRQ_H2B | BT_CR1_IRQ_HBUSY;
+	reg |= BT_CR1_IRQ_EN_H2B | BT_CR1_IRQ_EN_HBUSY;
 	writel(reg, bt_bmc->base + BT_CR1);
 
 	return 0;
@@ -447,12 +449,12 @@ static int bt_bmc_probe(struct platform_device *pdev)
 		add_timer(&bt_bmc->poll_timer);
 	}
 
-	writel((BT_IO_BASE << BT_CR0_IO_BASE) |
-		     (BT_IRQ << BT_CR0_IRQ) |
-		     BT_CR0_EN_CLR_SLV_RDP |
-		     BT_CR0_EN_CLR_SLV_WRP |
-		     BT_CR0_ENABLE_IBT,
-		bt_bmc->base + BT_CR0);
+	writel(FIELD_PREP(BT_CR0_IO_BASE, BT_IO_BASE) |
+	       FIELD_PREP(BT_CR0_SIRQ, BT_IRQ) |
+	       BT_CR0_EN_CLR_SLV_RDP |
+	       BT_CR0_EN_CLR_SLV_WRP |
+	       BT_CR0_ENABLE_IBT,
+	       bt_bmc->base + BT_CR0);
 
 	clr_b_busy(bt_bmc);
 

-- 
2.34.1



