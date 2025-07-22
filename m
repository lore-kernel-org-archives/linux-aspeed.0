Return-Path: <linux-aspeed+bounces-1773-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE4B4C83F25
	for <linux-aspeed@archiver.kernel.org>; Tue, 22 Jul 2025 09:52:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bmXcN3V1tz2yb9;
	Tue, 22 Jul 2025 19:52:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753177940;
	cv=none; b=LsmkjVi+rMAZO7e0hJWdIOVO6Y6Qe7WQYythYCgwxiyegcZJZnP6J6Rcw2Hlb2mXrykLRxzrfWUVmvl4hO1GZLq3smeUZEI9TLh7it5TGc5mfGe0Dk5mQl3oMsibokCO4pJIXFxgcCyVA4eouLFhi9xT749bEJrqxhjb5qNKnWNbrOs1e8UKQQzuwS7RwyaPopOwEXZM25r5fJXNhHkaBQOX1w0eYxqVYLSH6NZwwCxxeiopDCnmtJ5MhrRRJy3tuw1RLhiOBXBIwz/ffAMFf7RyWS13KvL3xW14iXz89A4DOMEsnA8uMgT4hhZdFfetqllDxtZu+/yxOdHC/Ni+zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753177940; c=relaxed/relaxed;
	bh=sm1KGX98kxBfN6necJmLRumQ56/uPS0vRTAlrvMNNnU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VegKdKxYQFWOIrs1ojmwueTddyXkcD21wDcZU0dIDdWHBx7aMSuGGfqNu4M3KjfSWMbYEbV+PO9JJkpyf+UTfcrbdJrqMfMawHLHHJQu4EIj1djI77mfkBBE9sAgy7T1E+SQavqmkaDRHBlP2R1nzYSpP6waxkVMngouWamgJ+6oXtADb4dwgPwYoXcZr4ihBhLxdmKpQGL/8k1ca8DTQ6ITFOko4LnYnuy2pGVy/z/NbAAiNvpJH87QVwRhaqkvcIOuqgiW7v5ioU5ys7LW3Q6JLv08RviDF4P0ikeLGeW12f7eWcuwCuE9CrQo8uXWYWHnpFuzqz262STBaz4YUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bmXcM3vXyz2yF0
	for <linux-aspeed@lists.ozlabs.org>; Tue, 22 Jul 2025 19:52:16 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 22 Jul
 2025 17:51:56 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 22 Jul 2025 17:51:56 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Thomas Gleixner
	<tglx@linutronix.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Kevin Chen
	<kevin_chen@aspeedtech.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>
Subject: [PATCH v3 0/2] irqchip: aspeed: Add AST2700 INTC debugfs support and yaml update
Date: Tue, 22 Jul 2025 17:51:54 +0800
Message-ID: <20250722095156.1672873-1-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

This patch series adds device tree bindings and driver support for the
AST2700 SoC¡¦s two interrupt controllers (INTC0 and INTC1), along with
debugfs entries for runtime inspection of routing and register protection
status, and bindings example refine.

v3:
- aspeed,ast2700-intc.yaml
  - improve commit message description.
- irq-aspeed-intc.c
  - add platform driver for "aspeed,ast2700-intc0/1" compatible nodes.

v2:
- fix dt bindingcheck

Ryan Chen (2):
  dt-bindings: interrupt-controller: aspeed: Add parent node compatibles
    and refine documentation
  irqchip: aspeed: add debugfs support and AST2700 INTC0/INTC1
    routing/protection display

 .../aspeed,ast2700-intc.yaml                  | 158 ++++++++----
 drivers/irqchip/irq-aspeed-intc.c             | 238 ++++++++++++++++++
 2 files changed, 353 insertions(+), 43 deletions(-)

-- 
2.34.1


