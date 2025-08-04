Return-Path: <linux-aspeed+bounces-1897-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF7CC87FD3
	for <linux-aspeed@archiver.kernel.org>; Mon,  4 Aug 2025 05:35:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bwQHW3fQdz3069;
	Mon,  4 Aug 2025 15:35:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754285703;
	cv=none; b=E22Snfxb2WXoZmYkgUY8hhDsFNMJUiHOh/E9aA8arjIP6gWB0SNPc5uFTmW4RlvDlL9qcoFxSqcq79IUQpOapYnLeiIy+BVR1LTq2SLhOjne91ilrldB0rfhdlJwPb+d7Ygme1McRnmUUwarf8XftdwhdI8FGjdsa8pWDxaZr3gE/lyH87oSPwM9o67JFjxdRo5tsqMbJMBgwTiDtt+EopkhQPwoJy93B5IVw68ihJg1WmkqzjI8Rt/eoTo6yKhxxqdG1C8gf97GCOvDseiQBbMmfddI913r+ugZRaVu7ddVBcFQkBQf+nnvqU6I9eaES3bGsHYTtaZ+GWKZsrVBLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754285703; c=relaxed/relaxed;
	bh=TzTDiKxeOvLrIfMTfJ8zNaahR1uk/vEnIUNhjbiF1DA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l2tZEprcGiNyu+53rizpyUcB1vCyPou0Y4WbcjKq6S5yCpFe8HVrO9BZZ+Dvtf6v/EjlKn7wsVSfGo8eQgaKEQi3v3k0JVXmWJf4WUZpwEk/mtAhNecIGNtCDIyHQCLqHKKbslUh0AbrlZDiwzw2+MRk6YByxblmVA3K6Nff5WY2gC+xhBvl2w3c91Gu1Ob9ESdUFCAdSiTVfmeL7q4Stpu9rqJsdm1IKyE54KcKrePDNmauziRHtulVS1Rnl9Gz+IuFPzuefaz+6Re+csbXmyp4u/jyLv+98s3DFVSZv3T8mUuGMSlMxaXh2PL/DudU2WeGladWiBvpKCqP+pb3Bg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bwQHV3wslz2yPS
	for <linux-aspeed@lists.ozlabs.org>; Mon,  4 Aug 2025 15:35:01 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 4 Aug
 2025 13:34:45 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 4 Aug 2025 13:34:45 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Eddie James <eajames@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/2] irqchip: Add support for Aspeed AST2700 SCU interrupt controller
Date: Mon, 4 Aug 2025 13:34:43 +0800
Message-ID: <20250804053445.1482749-1-ryan_chen@aspeedtech.com>
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

This patch series adds support for the SCU (System Control Unit) interrupt
controllers found in the Aspeed AST2700 SoC.

The AST2700 integrates multiple SCU interrupt groups, architecturally
similar to those in the AST2600, but using split registers for interrupt
enable (IER) and interrupt status (ISR), whereas AST2600 uses combined
registers.

Ryan Chen (2):
  dt-bindings: interrupt-controller: aspeed: add AST2700 SCU IC
    compatibles
  irqchip/aspeed-scu-ic: Add support for AST2700 SCU interrupt
    controllers

 .../aspeed,ast2500-scu-ic.yaml                |   6 +-
 drivers/irqchip/irq-aspeed-scu-ic.c           | 240 ++++++++++++++----
 2 files changed, 200 insertions(+), 46 deletions(-)

-- 
2.34.1


