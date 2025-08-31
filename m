Return-Path: <linux-aspeed+bounces-2080-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6321CA0EFF
	for <linux-aspeed@archiver.kernel.org>; Sun, 31 Aug 2025 02:14:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cDwZ96fPwz2yyx;
	Sun, 31 Aug 2025 12:14:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756606497;
	cv=none; b=ba5QHVp94vWqaz5L0g+y+gqjVAc6ECm0pZIP+03X3EsTFhMzbgIL22mVftx8eKXJdbblU4qPoqJRKIFBpK5JBzHyaLOuLoI0lRaItXbBP1qHoqHykwEnpAQ7gI1bVurXQQF0TdYODaBNVhCTvvG5mxsIF8BVnde88m9zHtK7gLJx+vAwLioVe6hy8mS2czjmigbnB2J3Gmfrvh2A+XBYAltu3kzApz3ZZMD6kwoNjobm751N1KQDJ8s7SCp0qzftemz/G4snchZehQEVusWRZRlxpj3M9nJj2wKJ101cfVaq1DXGZFlG0SOvqjEhWdMVD7NdiZzVBDkMiBrGfwL0mA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756606497; c=relaxed/relaxed;
	bh=/X5ICgCO9mFK1dcI03FeXGC11uS9PqgDvHYa8gHPgNM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZXuVrQG/0ynAL5ltRVEb2I+Qk0GGEInLMN0jHrHwcPurfoSmrNx+axcxwognGdStQNILx7b11Mn6YLznj+KYrqy34PuSAO+wcBtMzSiOw4DqlUXMYbLoCfLyaEl9vUrrZiYRi8B+n8m5oQGitH2AD6al1cQajZ9RrIm0beIj1/AcpkKYy1KsCQd2+rMwjzgPiGMQ57tXsGtupnlV1C160mxyPmCd6yNctemqnl7DDIptnn1uPdpRk+ij3iumDvLo1WpPXQmbNCxD8TCp7voT1B0hr1u74tWwX7wk5wwItTSAA+Ikj9t56xrESgPFR9cUMvB3JSNDR7nmrSZrXe43nw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cDwZ90W2Pz2yyJ
	for <linux-aspeed@lists.ozlabs.org>; Sun, 31 Aug 2025 12:14:55 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Sun, 31 Aug
 2025 10:14:38 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Sun, 31 Aug 2025 10:14:38 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Eddie James <eajames@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Lee Jones <lee@kernel.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 0/4] irqchip: Add support for Aspeed AST2700 SCU interrupt controller
Date: Sun, 31 Aug 2025 10:14:34 +0800
Message-ID: <20250831021438.976893-1-ryan_chen@aspeedtech.com>
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
 drivers/irqchip/irq-aspeed-scu-ic.c           | 238 ++++++++++--------
 .../interrupt-controller/aspeed-scu-ic.h      |  14 ++
 4 files changed, 163 insertions(+), 99 deletions(-)

-- 
2.34.1


