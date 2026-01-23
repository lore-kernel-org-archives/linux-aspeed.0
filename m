Return-Path: <linux-aspeed+bounces-3421-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D15D72364
	for <linux-aspeed@archiver.kernel.org>; Fri, 23 Jan 2026 09:26:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dyCHV3Pt9z2yFK;
	Fri, 23 Jan 2026 20:26:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769160406;
	cv=none; b=g2RZUuy1w0lQM9Hgvuk6ooJe2InhIcfoxVwlnjm6yJsJAQ2gwGUEQFnvP3Wpyi1YKAxqhR8HgfEo1sp80c6yRQN9mB8nMptYtdrv8UmfwoNWswFIcPYOsY7kCTb3tGvrO56jSfcAIcYTwtK2QiW8DYodj9IGBo5K5hBi/yUILjb7gLAMTZTsvmbaALopLZsx4w+GHB6uWNaj1Slu78CPmytHiVajjwNAfYK4bWL4aylCOviCakvAICV1yU2v4UJY1auLgq/ilCrCxvvH6ozzStjEkzamAYC8ga6RDBBONlsIrdARx/POgxW7W8gL73JsTlM+cPBqQPBhN3FYQrVUxg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769160406; c=relaxed/relaxed;
	bh=LXDjO0Zits+baQGNf4iaD7rt+XiqyDuXVlNSdn+765A=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=DcTqq36qkOSEsxU6XksEf3Ch7kNo8eB1lpZzB6TIaLW8WyoPCL/poZmWRcdqVja8G5pCVAlGYQQXKirsPUEpvfXnCFyX4B1SuGDz/AKbWPtINDor7pSpuZoHI7Wf7nxyCswqeaGVD8ViowqfpQr5mwEtBfpH8+wiHGzBJeOTR9lTjbOHS0QlXfutEJBXSp1gD8ZgxYJalWcGYs8datV92FiY8gnNmGTrP6YM/bBzSqj5N42EQdPSLjMcVZ6o1fEsyZZ0D2KxAyh2TLf+yHg2pvGvI5nESXM+pRMJ46ezJ3PjQYQaz2CQ+yNB8UTGZ7mf4idkqy5jEFHvSpYoltdW1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dyCHT2v3Zz2xKh
	for <linux-aspeed@lists.ozlabs.org>; Fri, 23 Jan 2026 20:26:44 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 23 Jan
 2026 17:26:26 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 23 Jan 2026 17:26:26 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Subject: [PATCH v2 0/6] Add Aspeed G7 sgpio support
Date: Fri, 23 Jan 2026 17:26:25 +0800
Message-ID: <20260123-upstream_sgpio-v2-0-69cfd1631400@aspeedtech.com>
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
X-B4-Tracking: v=1; b=H4sIAME+c2kC/13Myw6CMBCF4Vchs7amU+SiK9/DEFPLFGYBbVokG
 tJ3t7B0+Z/kfBtECkwRbsUGgVaO7OYc6lSAGfU8kOA+NyipKlSqFG8fl0B6esbBsxON7FusTH3
 ReIV88oEsfw7w0eUeOS4ufA9/xX3dqVoiNv/UikKKtpJkS2tfdSvvOnqifiEzno2boEsp/QB37
 HVnsQAAAA==
X-Change-ID: 20251223-upstream_sgpio-70d815c64a19
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
CC: <linux-gpio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, "Andrew
 Jeffery" <andrew@aj.id.au>, <devicetree@vger.kernel.org>,
	<bmc-sw@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769160386; l=1733;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=GhxpaNbciIaCWw72u2Iibpyx+V9XGyJ6u4X/43gCPWI=;
 b=ha0IbVquhucHyhVDOj7Ik/OXkimaaMGrNIIgmEHWVcXtkMlFT8YWsrZpZun6A/6r2OrwYLp2p
 +c/MUBgaX6/DJhz3EpuHv5ijNQ47OZCitYyPv5W1+HSOefr3kae3Oh6
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

The Aspeed 7th generation SoC features two SGPIO master controllers: both
with 256 serial inputs and outputs. The main difference from the previous
generation is that the control logic has been updated to support
per-pin control, allowing each pin to have its own 32-bit register for
configuring value, interrupt type, and more.
This patch serial also add low-level operations (llops) to abstract the
register access for SGPIO registers making it easier to extend the driver
to support different hardware register layouts.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
Changes in v2:
- Split the IRQ-related llops conversion into a separate patch to keep changes logically scoped.
- Minimized unrelated changes (such as variable renaming) to reduce diff noise and ease review.
- Clarified the llops design intent and semantics.
- Link to v1: https://lore.kernel.org/r/20260117-upstream_sgpio-v1-0-850ef3ffb680@aspeedtech.com

---
Billy Tsai (6):
      gpio: aspeed-sgpio: Change the macro to support deferred probe
      gpio: aspeed-sgpio: Remove unused bank name field
      gpio: aspeed-sgpio: Create llops to handle hardware access
      gpio: aspeed-sgpio: Convert IRQ functions to use llops callbacks
      dt-bindings: gpio: aspeed,sgpio: Support ast2700
      gpio: aspeed-sgpio: Support G7 Aspeed sgpiom controller

 .../devicetree/bindings/gpio/aspeed,sgpio.yaml     |   4 +-
 drivers/gpio/gpio-aspeed-sgpio.c                   | 362 +++++++++++++--------
 2 files changed, 227 insertions(+), 139 deletions(-)
---
base-commit: 39d3389331abd712461f50249722f7ed9d815068
change-id: 20251223-upstream_sgpio-70d815c64a19

Best regards,
-- 
Billy Tsai <billy_tsai@aspeedtech.com>


