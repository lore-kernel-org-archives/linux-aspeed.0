Return-Path: <linux-aspeed+bounces-4755-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799DEC5DF81
	for <linux-aspeed@archiver.kernel.org>; Wed, 19 Aug 2026 01:09:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPpQ52Ft8z2yFd;
	Wed, 19 Aug 2026 11:09:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787101789;
	cv=none; b=J/JIuUjOllIF6nQQ/Vb6nXHqoDH2As91QmE2xqxDknRFNG5RbfL6lZvMi4dptq6M+J+w5IgRc9/wq8vat15xp3ria79Kx1QOSPce7pyTweSGp29mfQjHXKgQlk9A0ZHrjlTVo1+R7XO039jdDB0AdfFsWXyUBo4o9/jOi0VzA6HsHg+40dKF2tZzRvM6a95RBUeYi/sRAezyI8EIQrHUZ02Rxf8OUcUoTfEnidun6tprqGRdFJ7S7MGP+rz5yufDA98oa/J1XIXXVNDynfk/xkjwNwW6FLVcb46KdAWsLa52yvd4Ak8siCL1vFTaYe10y6OKZ7FaPprzmk5PTQZnIg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787101789; c=relaxed/relaxed;
	bh=GKJPQ1K7MzyYuRxbvHGWlf/wDgLHSxbc0lEn8Y0Ezdk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=c2CKGeVokx2hp2UV23ZOQH+QFNP5A51cEw7vELFJajt91nm30LzzN4VMetk4adIPwyjJZmTxCITgWSlM6NSFr1F5IYcU5HrHMxToM2rLMjmAU7N++y/HVSRGIvR/t4NRmk4NqaRU9RhqUOzYQW88NMVY+jfxFczz5QWugLd9X/TpO+6/4ljaBvfNauG7PML4jYgUYGYIAIwm5jdMwMV9uq6z/grA4HDA2QM+cPIrbEhLriBLbZd6do9bzdZxEwSsETIOiDigKZrZCaNGW/eZT6IYSSknpTb4bfBEXrupiGVlYCbSPNI4MrQUBRKc3ItNG13Ii3bwBotc0TSt5atKvg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hPpQ40klnz2yFP
	for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Aug 2026 11:09:47 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 19 Aug
 2026 09:09:29 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 19 Aug 2026 09:09:29 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 19 Aug 2026 09:09:19 +0800
Subject: [PATCH] irqchip/ast2700-intc: Avoid allocating in the irq_domain
 activate callback
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
Message-ID: <20260819-fix-ast2700-intc-atomic-alloc-v1-1-d92a02e2a239@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIAD4ChWoC/x2M0QrCMAwAf2Xk2UAaxa3+ivgQatwCWyttEWHs3
 w0+Hfdwt0PTatrgNuxQ9WPNSnYJpwHSInlWtKc7MPGVphDxZV+U1nkkQss9ofSymWNdS8J45ss
 kHCUkAn+8q3rw/98fx/EDtmZR2m8AAAA=
X-Change-ID: 20260819-fix-ast2700-intc-atomic-alloc-93248a29a1c0
To: Thomas Gleixner <tglx@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Paul Walmsley <pjw@kernel.org>,
	"Palmer Dabbelt" <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	"Alexandre Ghiti" <alex@ghiti.fr>
CC: Radu Rendec <radu@rendec.net>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, Ryan Chen <ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787101769; l=3189;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=ZRBbxvpAQxQ9WSWrReHJgmHc7WwhW/QkN01mfSF5T+A=;
 b=y1Ml1E/xkjDXkFmU+iV4p/nM5dpGUJaEb88IKzFFXQ5J4lWuwqKhEp/CQFMZOJ9+32v9B/0yF
 5nN0wH0Wn49BXicFlAqMoXXI50tdDMwxm2iC2qh6n8B5Wh9l0n/EUvQ
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

The IRQ core calls the irq_domain .activate callback from __setup_irq()
with desc->lock held and interrupts disabled. Both
aspeed_intc1_irq_domain_activate() and the aspeed_intc0_resolve_route()
it invokes test a compatible string with fwnode_device_is_compatible(),
which wraps fwnode_property_match_string() and allocates with GFP_KERNEL.

Besides sleeping in atomic context, that makes the irq_desc lock depend
on fs_reclaim, which lockdep reports as an inversion because
irq_desc_lock_class is also taken in hardirq context:

  WARNING: possible irq lock inversion dependency detected
  swapper/0/0 just changed the state of lock:
  (&irq_desc_lock_class){-...}-{2:2}, at: handle_level_irq+0x28/0x168
  but this lock took another, HARDIRQ-unsafe lock in the past:
   (fs_reclaim){+.+.}-{0:0}
  ...
    fs_reclaim_acquire
    __kmalloc_noprof
    fwnode_property_match_string
    aspeed_intc0_resolve_route
    aspeed_intc1_irq_domain_activate

Both call sites are only ever handed OF nodes, so use
of_device_is_compatible() instead: it walks the property in place and
does not allocate.

Fixes: 07825e41519a ("irqchip/ast2700-intc: Add AST2700-A2 support")
Reported-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
Tested on an AST2700 EVB with CONFIG_PROVE_LOCKING=y: the irq lock
inversion splat quoted in the patch is gone, and the ast2700-intc0 KUnit
suite still passes 9/9.
---
 drivers/irqchip/irq-ast2700-intc0.c | 2 +-
 drivers/irqchip/irq-ast2700-intc1.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-ast2700-intc0.c b/drivers/irqchip/irq-ast2700-intc0.c
index 14b8b88f1179..c85b98a19bd4 100644
--- a/drivers/irqchip/irq-ast2700-intc0.c
+++ b/drivers/irqchip/irq-ast2700-intc0.c
@@ -312,7 +312,7 @@ int aspeed_intc0_resolve_route(const struct irq_domain *c0domain, size_t nc1outs
 		return -ENOENT;
 
 	if (!IS_ENABLED(CONFIG_ASPEED_AST2700_INTC_TEST) &&
-	    !fwnode_device_is_compatible(c0domain->fwnode, "aspeed,ast2700-intc0"))
+	    !of_device_is_compatible(to_of_node(c0domain->fwnode), "aspeed,ast2700-intc0"))
 		return -ENODEV;
 
 	intc0 = c0domain->host_data;
diff --git a/drivers/irqchip/irq-ast2700-intc1.c b/drivers/irqchip/irq-ast2700-intc1.c
index 59e8f0d5ddcd..df6acbafce2d 100644
--- a/drivers/irqchip/irq-ast2700-intc1.c
+++ b/drivers/irqchip/irq-ast2700-intc1.c
@@ -157,7 +157,8 @@ static int aspeed_intc1_irq_domain_activate(struct irq_domain *domain,
 					intc1->ranges.nranges,
 					intc1->ranges.ranges, &resolved);
 	if (rc < 0) {
-		if (!fwnode_device_is_compatible(intc1->upstream->fwnode, "riscv,aplic")) {
+		if (!of_device_is_compatible(to_of_node(intc1->upstream->fwnode),
+					     "riscv,aplic")) {
 			dev_warn(intc1->dev,
 				 "Failed to resolve interrupt route for hwirq %lu in domain %s\n",
 				 data->hwirq, domain->name);

---
base-commit: 4477a78374a57c3809b172ad30cceabda48c47c6
change-id: 20260819-fix-ast2700-intc-atomic-alloc-93248a29a1c0

Best regards,
-- 
Ryan Chen <ryan_chen@aspeedtech.com>


