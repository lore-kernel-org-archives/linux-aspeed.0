Return-Path: <linux-aspeed+bounces-4326-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A5EAC43602
	for <linux-aspeed@archiver.kernel.org>; Wed,  1 Jul 2026 06:58:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqrTW2cbmz2xPb;
	Wed, 01 Jul 2026 16:58:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782889135;
	cv=none; b=Eh9reOLn73WKnMnOgRqFDG3ON/0DGewGFnJjZfRF8cG15RIzC8r+9JRgR4OAcz6pvVGX6Hbo2Y88mxYBojDqLlmeZ7E5K+La7ZGLu0aH9+cbuED3U4omKyitNvez5B40uzQGsntnFSf+vKQXRwH63CZsfDC5DTE4+WNJ/M8YLdipmpXMZp5MWlSQYpnGS0CF3QiqkHByVCM7AY0cQgdMJLPEmZ9h4WwH7J8pDAl0fA/Tqnt5EG0A+JiTtkToCN3pTBgOxE1HakXDvreKiESxpkbJ7ECQQs64+ZhGWzZ/4ndoiBrltfP32oP0ZUN+JPDhpo8iTBgxnbIddOQ1bq0A5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782889135; c=relaxed/relaxed;
	bh=jYKf9cTsfWn+jkBzHovubXGtnpat1HeW9+J4+4meF24=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=CtVNwvWytA3ylVkbnf9XGia0iBmQpyo3MS68/qc8jnGv7NUAGzIo3GVw21W4liO0GuF0oN1mBGRHpAr1Bd6JsSJAA5k1SbnvUUsu4g7+zZ+MY999EIhHqXSzFG73FloyL1LlUh7I7pQ1Uyp/+z/9t8KKquajnePbnTfqA32XTZv+fLgmhsoAUwYqp8gAZ3bWfT0SoB5rekcXP6KE78dUFfs1YmQ507hO3QwZtCGAgJa29+q8wDIyB9bTPp67rs2+OECWuyFVS6jmDqG4wxD8CAmBmB4PR6mM3UySXdIQfx5uMvOEECT3KN+6YGfxC2J9xqnVumlPERgKFRL1KZKiuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqrTV0y5rz2xF8
	for <linux-aspeed@lists.ozlabs.org>; Wed, 01 Jul 2026 16:58:53 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 1 Jul
 2026 14:58:18 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 1 Jul 2026 14:58:18 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Subject: [PATCH v3 0/3] Add AST2700 USB3.2 PHY driver
Date: Wed, 1 Jul 2026 14:58:16 +0800
Message-ID: <20260701-upstream_usb3phy-v3-0-00e12315b6f9@aspeedtech.com>
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
X-B4-Tracking: v=1; b=H4sIAIm6RGoC/23N0QqDIBTG8VcJr+dQK1272nuMMVKP04tKtGQRv
 fssGAza5f+D8zsLihAcRHQtFhQgueiGPkd5KpCybf8C7HRuxAjjhFKGJx/HAG33nKIsvZ2xoJS
 bizYgRIPymQ9g3Hsn74/c1sVxCPP+IdFt/WLVEUsUE8ygbuqGSGBa3NroAfQIyp7V0KFNTOxX4
 X8UlhUiiWpMCZKb6qCs6/oBBGE8IvsAAAA=
X-Change-ID: 20260112-upstream_usb3phy-7116f8dfe779
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Philipp Zabel
	<p.zabel@pengutronix.de>
CC: <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782889098; l=1671;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=bn8u6iZT/heeYMxwS3gT13QMzWcArkH0V90un5xFeD4=;
 b=awUCfrqi0MGSFD1GjYf0evv5DlrS0hIHqJjRtUdPjmOksHD0SJTQiXAe/gKUsCtwN/oCLfBEz
 Y0iyYwtPBPLCJ8u+r+25FkG5Y/F5eOuRgXc/iYmI+HSjUqRooQkTHEy
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Add AST2700 USB3.2 PHY support.
 - Supports Super Speed Plus Gen2x1 (10 Gbps), Super Speed (5 Gbps),
   High Speed (480 Mbps), Full Speed (12Mbps), and Low Speed (1.5 Mbps).

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
Changes in v3:
- Wire drivers/phy/aspeed/ into drivers/phy/Kconfig and
  drivers/phy/Makefile so the driver is actually built.
- Fix the Makefile config symbol to CONFIG_PHY_ASPEED_USB3 to match
  the Kconfig symbol.
- Expand the Kconfig help text.
- Link to v2: https://lore.kernel.org/r/20260116-upstream_usb3phy-v2-0-0b0c9f3eb6f4@aspeedtech.com

Changes in v2:
- aspeed,ast2700-usb3-phy.yaml
 - Drop clocks, resets descripton.
- Kconfig
 - add COMPILE_TEST, remove default n
- Link to v1: https://lore.kernel.org/r/20260114-upstream_usb3phy-v1-0-2e59590be2d7@aspeedtech.com

---
Ryan Chen (3):
      dt-bindings: phy: aspeed: Document AST2700 USB3.2 PHY
      phy: aspeed: Add AST2700 USB3.2 PHY driver
      MAINTAINERS: Add ASPEED USB3 PHY driver

 .../bindings/phy/aspeed,ast2700-usb3-phy.yaml      |  48 +++++
 MAINTAINERS                                        |   8 +
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/aspeed/Kconfig                         |  15 ++
 drivers/phy/aspeed/Makefile                        |   2 +
 drivers/phy/aspeed/phy-aspeed-usb3.c               | 236 +++++++++++++++++++++
 7 files changed, 311 insertions(+)
---
base-commit: 948efecf22e49aa4bf55bb73ec79a0ddcfd38571
change-id: 20260112-upstream_usb3phy-7116f8dfe779

Best regards,
-- 
Ryan Chen <ryan_chen@aspeedtech.com>


