Return-Path: <linux-aspeed+bounces-5153-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A9DCA600E
	for <linux-aspeed@archiver.kernel.org>; Thu,  8 Oct 2026 11:28:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0nnD1Kdnz2xnn;
	Thu, 08 Oct 2026 22:28:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791458928;
	cv=none; b=liGRKxJoXdjRLh2nD2XnGXGHqSM6xD6UwdeQP6JTxQiIn/G1pZy+z3kF8/FDxD1qA1zg4rtR2aBtPAtXAQec2L/ZM49ggb32jFpcXVcoFzXVVSL5RhRsyPxC0Ag7u30nd7y3F0WLQcDAP4aotdrjoDz6neVuEdJMJd1xwI97+aT+oeUU09YacNc7Ipq5tMN70Y9pfaYGmHmGcMRSVfEfx7ISPZCXi7TgNeoatV39ZxKx00hCwr7sgZ3Xyjhld9vwFYr+bXG1Xg9Z/cxl81DzqUp8TR+H6mfCukVldfYGkBNWGBzYfyna3lECRXjhUTf1c1kZKRTbdHLW0z1glSdFvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791458928; c=relaxed/relaxed;
	bh=J0lKCE3RmRvCGQ3yXVZPn/3i5EvH6SPYE4vOGbYePsM=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=OxQJxdFVBeGPs/zaF3vyJJLC1Y5S0XuacxNnNsPBs4qURTWSUV8wHpG2fCYVhW5wS/hKH4a65uSg7WGUTZ1QD1Vb+lGicJ6pwPsA8sNNhB/QKKCxgRCruopnKa5blqUxeKmYVR/WxC8bhwujIfy3PKhKAiLKD5XANQMTD02cPTwEGK4zW9wKYlId+0gegMVthOZ4l4zPwTBbtRkvk7vzi8m3TQfhmYxmRqwJtEXhqFfCRG+Hn1dOXf5tN0hFylx9TnxXpOYko+jTRrk/eqmo6d8wkQTN1uyKQYBcJiE8KhM4Pcmy/jAy1JsewnzHDBsm85OoOaM2BKs7HhuHFhsWww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0nnB4s7fz2xdX
	for <linux-aspeed@lists.ozlabs.org>; Thu, 08 Oct 2026 22:28:46 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 8 Oct
 2026 19:28:28 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 8 Oct 2026 19:28:28 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Subject: [PATCH 0/3] phy: aspeed: Add ASPEED PCIe PHY support
Date: Thu, 8 Oct 2026 19:28:18 +0800
Message-ID: <20261008-aspeed_pcie_phy-v1-0-96764937aef0@aspeedtech.com>
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
X-B4-Tracking: v=1; b=H4sIAFJ+x2oC/x3MSwqAIBRG4a3EHSf4CIm2EiGmf3UnJQpRRHtPG
 n6Dcx4qyIxCQ/NQxsmFj71CtQ2Fze8rBMdq0lJbaY0UviQguhQYLm23MJ2yapamtwZUq5Sx8PU
 fx+l9P07DBk1hAAAA
X-Change-ID: 20260630-aspeed_pcie_phy-34161b03863e
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Manivannan Sadhasivam
	<mani@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai
	<billy_tsai@aspeedtech.com>
CC: <linux-aspeed@lists.ozlabs.org>, <linux-phy@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Jacky Chou <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791458908; l=1483;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=iu4Zl2XLhk1c2sygQvsZ6Yp6z//xHF44lf3a3D+enh0=;
 b=WEva4gZIureOwV8wbKrsmtAfd2JtufHc6mn7kCstj8/nqIh8PqvVumxtDKzG2pskx3VXMDz6L
 iHViDNsxYxrADPJ3jP7f1HmbExdLIosqCQl8al7SFuRz5mUjoDKKNM/
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

Add the ASPEED PCIe PHY binding and driver for AST2600 and AST2700
SoCs. The PHY provides the physical layer used by the PCIe controller
when it is configured to run in root complex mode.

The driver registers an ASPEED PCIe PHY provider through the generic PHY
framework and programs the SoC-specific PEHR registers from set_mode().
For AST2600 this selects the root complex port type. For AST2700 this
also configures the posted/completion credit values, local scaling,
device type, internal reset selection, and downstream port setting
needed by the controller.

This series also adds the devicetree binding for the PHY provider and a
MAINTAINERS entry for the ASPEED PCIe PHY driver.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
Jacky Chou (3):
      dt-bindings: phy: aspeed: Add ASPEED PCIe PHY
      phy: aspeed: Add ASPEED PCIe PHY driver
      MAINTAINERS: Add ASPEED PCIe PHY driver

 .../bindings/phy/aspeed,ast2600-pcie-phy.yaml      |  49 +++++
 MAINTAINERS                                        |   8 +
 drivers/phy/aspeed/Kconfig                         |  12 +-
 drivers/phy/aspeed/Makefile                        |   1 +
 drivers/phy/aspeed/phy-aspeed-pcie.c               | 237 +++++++++++++++++++++
 5 files changed, 306 insertions(+), 1 deletion(-)
---
base-commit: ea01f446f0682a5e7bd7a275889a890b7e0c6e02
change-id: 20260630-aspeed_pcie_phy-34161b03863e

Best regards,
-- 
Jacky Chou <jacky_chou@aspeedtech.com>


