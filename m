Return-Path: <linux-aspeed+bounces-3310-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0EED31A1A
	for <linux-aspeed@archiver.kernel.org>; Wed, 14 Jan 2026 07:13:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4drclt6pfWz2xlP;
	Wed, 14 Jan 2026 18:13:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768374810;
	cv=none; b=Ow3H+oeXWXMs5C00KgE0txltMu5HO9vlefPVLiz5u472OuH5QLx1CrD62DlRRefVncAbWY5WYCqavcrH/H7XK9Fd1dSPtDMIzCKP85bS/Y9etCbUc+LbOySIyIV/PCWf10VvoNnx1vWjungseUuRxptXnyeNo8pdcERl1C6vSelnb8JtXlOb0y/cVc5dtNwcyctU0XwGmPRQxOOAr9qDA4H7YwPor6UNY8nyO6CbJKFC2W1pUE1VGaXHE5GVVaEDM5RUtOV+Z2HayiznK0gh1DJaS6Xy1moneOEq9PW19LM105ph1FQTsEvQ9pTIvMkEzE19rZV/bj2sd9vwU9yYbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768374810; c=relaxed/relaxed;
	bh=qHAYOi45ZPVstJeJIyr7EDMfTMCOs4UGm3gFy9d9sKA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=QIVcNtx9kg0QoQdEkZlohpjrfWBnQQq8nDJ8/cnkAa9hbaCgEzQOvY/NvxtDXmigkfoqq00JAUDCQeBB2GzJL4H5vwbXMVJaBMTkHv3G/Lb8kxU78f+o0qRE6nrTcysOnX2NuR4iARk0KP+2Iw1OCI6tA/A71JTlfgtdzqQ7OUXrJ0WtYXseIGjn9/XAKq1eYt/9axeFwAG5pDrmatpRZx1FUIcZsuztKy1DTKnkD8/ZBFXNjwKJO8dEO3SYRV7XJa/+fVJs2fTqXxPJuI4DLK3pIHL9ZvBthcHf2nLp/9j1+nMCojkFL0m8U2wJL9xEiLoOXBBgtTE+5Yk6+gNtYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4drcls73Y4z2xHW
	for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Jan 2026 18:13:28 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 14 Jan
 2026 15:13:11 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 14 Jan 2026 15:13:11 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Subject: [PATCH 0/3] Add AST2700 USB3.2 PHY driver
Date: Wed, 14 Jan 2026 15:13:09 +0800
Message-ID: <20260114-upstream_usb3phy-v1-0-2e59590be2d7@aspeedtech.com>
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
X-B4-Tracking: v=1; b=H4sIAAVCZ2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQ0Mj3dKC4pKi1MTc+NLiJOOCjEpdc0NDszSLlLRUc3NLJaC2gqLUtMw
 KsJHRsbW1AKsxE7ViAAAA
X-Change-ID: 20260112-upstream_usb3phy-7116f8dfe779
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Philipp Zabel
	<p.zabel@pengutronix.de>
CC: <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768374791; l=943;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=9UWvYzBx32LAyAt3jySR0UVGJFylhu6VIM7tiOpCLDs=;
 b=eQ2rKFJ1FRU0O3R7mFvEWDDNBL6LnibYzov4c3GiIJLNE7Bc/CJEp4FDuHKPKffv2YzFhoect
 rZ8MuHvEhbvCTCZeNTNkTAzOawW6M2kA51RmNrG4X5VkSXsYt03yD0e
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Add AST2700 USB3.2 PHY support.
 - Supports Super Speed Plus Gen2x1 (10 Gbps), Super Speed (5 Gbps),
   High Speed (480 Mbps), Full Speed (12Mbps), and Low Speed (1.5 Mbps).

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
Ryan Chen (3):
      dt-bindings: phy: aspeed: Document AST2700 USB3.0 PHY
      phy: add AST2700 usb3.2 phy driver
      MAINTAINERS: Add ASPEED USB3 PHY driver

 .../bindings/phy/aspeed,ast2700-usb3-phy.yaml      |  50 +++++
 MAINTAINERS                                        |   8 +
 drivers/phy/aspeed/Kconfig                         |  13 ++
 drivers/phy/aspeed/Makefile                        |   2 +
 drivers/phy/aspeed/phy-aspeed-usb3.c               | 236 +++++++++++++++++++++
 5 files changed, 309 insertions(+)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20260112-upstream_usb3phy-7116f8dfe779

Best regards,
-- 
Ryan Chen <ryan_chen@aspeedtech.com>


