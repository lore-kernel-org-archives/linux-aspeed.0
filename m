Return-Path: <linux-aspeed+bounces-2168-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF71CA1017
	for <linux-aspeed@archiver.kernel.org>; Mon,  8 Sep 2025 01:18:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cKpxN391sz2yvv;
	Mon,  8 Sep 2025 11:18:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757294312;
	cv=none; b=RiOhaD6/v0LNHcri470zlGE7hybq8nC9gswz4N7KLYQ1mQsraHckTECi7uc741/yVJYC4ITVctKtXh4vrvKEb+uC5F8iuyUUfSJEYTY43d4TJBGD9/7VSX5keSyCJE/7tBI/Xjh0OqEB4lk5McYPb1np6zXzwserBDuLzeo1AxgRwg1s8cHVfu01sP5JWGhJ1/lgIIN1CpQn61DcSTtN/NNnYD1ZwRuI+RHuy8Gh9srIDVNgpVaorSAfRmxRXMKggb6hK2M3zDR8TExxViCtLck7EaSj0CkVdlfyoZ7nZI16i6JbkAS7p7uUGLFlfMMJns+ErrnXfmLT+nqh5BsoTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757294312; c=relaxed/relaxed;
	bh=a9z27UVsU1jEb4XL5ZPmznsWnoATR9aoTY0tW7aWwAE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FTI9jPYF006du1LW1kIiH2/70RAHLqn7heQXwMnSUB4qZQsk1X6eTrFtDsufzklmRQv0vGvWcJaqp51JBAemGeyf1NDCoGMosSENQyJ59O02h0S3Aj1HBWRKdsZD4uHTty7cv6XNZQmryzTqjJeoq8euvCLRFJX6LBvS2x0pwyUYgLWH807oWj+2fM3oAo1Zn9/p1jEPMV5zWB8wncUWD6vN48sAGanrUWYhHRNRDFAMsxMnk6JRVfCp0I8ezV/5ANcsyiSQV0ML5CIAdgofO6kTiusdT8rX/Mpp6POoRkobT0sDSTexiLyYFkJUHhCHRG0RkAlfjY3gblq9FMUcEQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cKpxL5bBDz2ytg
	for <linux-aspeed@lists.ozlabs.org>; Mon,  8 Sep 2025 11:18:29 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 8 Sep
 2025 09:18:12 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 8 Sep 2025 09:18:12 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Eddie James <eajames@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Lee Jones <lee@kernel.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 0/4] irqchip: Add support for Aspeed AST2700 SCU interrupt controller
Date: Mon, 8 Sep 2025 09:18:08 +0800
Message-ID: <20250908011812.1033858-1-ryan_chen@aspeedtech.com>
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This series adds support for the SCU (System Control Unit) interrupt
controllers on the Aspeed AST2700 SoC.

AST2700 follows the same multi-instance SCU interrupt controller design
as AST2600, with four independent interrupt domains (scu-ic0 to 3).
However, unlike previous SoCs that use a single register for both enable
and status bits, AST2700 splits them into separate IER (Interrupt Enable)
and ISR (Interrupt Status) registers.

To support this, the driver is refactored to use a variant-based init
structure, selected by compatible string. Register access is also
converted from regmap to MMIO (via `of_iomap()`), and a per-variant
IRQ handler is used depending on register layout.

v4:
- irq-aspeed-scu-ic.c
 - fixed missing inital mask = scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT;

v3:
- irq-aspeed-scu-ic.c
 - update for bracket-rules.
 - update TAB not spaces to align.
 - remove stray TAB.
 - update end up aligned.
 - add missing _ier, _isr in SCU_VARIANT.
 - add two different mask/unmask/ functions for split and combined.

v2:
- Refactor SCU IC driver to support variant-based initialization
- Add AST2700 compatible strings to YAML and header files
- Extend DT bindings in mfd and irqchip for AST2700
- Add IRQ handler logic for separate IER/ISR layout

Ryan Chen (4):
  irqchip/aspeed-scu-ic: Refactor driver to support variant-based
    initialization
  dt-bindings: mfd: aspeed: Add AST2700 SCU compatibles
  dt-bindings: interrupt-controller: aspeed: Add AST2700 SCU IC
    compatibles
  irqchip/aspeed-scu-ic: Add support AST2700 SCU interrupt controllers

 .../aspeed,ast2500-scu-ic.yaml                |   6 +-
 .../bindings/mfd/aspeed,ast2x00-scu.yaml      |   4 +
 drivers/irqchip/irq-aspeed-scu-ic.c           | 243 +++++++++++-------
 .../interrupt-controller/aspeed-scu-ic.h      |  14 +
 4 files changed, 174 insertions(+), 93 deletions(-)

-- 
2.34.1


