Return-Path: <linux-aspeed+bounces-3357-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B7CD4A5ED
	for <linux-aspeed@archiver.kernel.org>; Fri, 16 Jan 2026 02:53:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dskvB4sYWz2xpl;
	Fri, 16 Jan 2026 13:53:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768532022;
	cv=none; b=VsPCBWaEG/Ct26T56GnkXDm217KewPo81EF9iXZfFkUTTcvWldLuPBFblZNYLpyf/JK4Xv0523BF6drV31fRxqRHoElU8iNCILVaEVIEQjcJRT7arlg4LQju9OnIZCxty0Mn6EMTLziMzt0mN2GmJ0FqZogM5ZCp9D/q24uFmj3XbFfo+Emp+ZrCsk25hG5EedTymBjV5XtoFJDmM+S53bu/TU63xS/aUthcfm1NXROLu/Qa3m1A+1j6BJbTJwKeqqp4eZPP8uNmwo0fv1fUo0QLkjoMbG3UAO7/csZ1BaBlD3FETecl6o2U/i3I9xcW01iANpIcFuYk3EF5OcKSqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768532022; c=relaxed/relaxed;
	bh=q9AOzF2eotwZDBK8StpdkPFWxhtfoMznNPy43aPpEqQ=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=dWS02RWxgpTjtJMzgt0D2iwnIKfBLFJn4YdjoVphNuuxcdgPedfWb3XlCf8xBKn6MRsGd3dByPuTf5+wIBsRTJny39ii1PRk+s5+xQGEDykwhFxhBWMha0J7zQe88qwEBx0JtravD4OCUnAEsUgscdD45hfGGqvEOQ3hmBJo2cDHOwJJ+jObY5Y8rO9H7hJu5pKk1URqU99GXs6tajcaEHbcgLGIk706FR6E3yTL9EEDAaUKsjodIDyd2bbeK+Rj3QYtG1gvmx7IYmdJsrfkeIbJ9SCchoLbvQ1+2gh/QpPWy3ZfdyoN4aaPKQU0FcDgMsPQfTtUmyXHI48NanBSsw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dskv96k3bz2xPL
	for <linux-aspeed@lists.ozlabs.org>; Fri, 16 Jan 2026 13:53:41 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 16 Jan
 2026 10:53:26 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 16 Jan 2026 10:53:25 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Subject: [PATCH v2 0/3] Add AST2700 USB3.2 PHY driver
Date: Fri, 16 Jan 2026 10:53:23 +0800
Message-ID: <20260116-upstream_usb3phy-v2-0-0b0c9f3eb6f4@aspeedtech.com>
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
X-B4-Tracking: v=1; b=H4sIACOoaWkC/2WNwQ6CMBAFf4Xs2Zq2ChVO/ochBuhie4A2XWgkp
 P9uJfHkcSZ583YgDBYJmmKHgNGSdXMGeSpgMN38QmZ1ZpBcVlwIyVZPS8Bueq7UX7zZmBKiGm9
 6RKVqyDMfcLTvI/loMxtLiwvb8RDF1/5i1/9YFIwziWVd1rxHqdW9I4+oFxzMeXATtCmlD4Yzd
 Ea1AAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768532005; l=1184;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=skzeJJpNld7RftFrKl/uW1Nm9mq66q5prekuES1h6y0=;
 b=ZzNEGJC7S2ExCx1ucmhgJ/IaHbV9SFe7rxJCCD51oPhRXQLVkf+lUDG03WfXhwcplV/XRpzF6
 Y9nEy1qscYmAZjW4izS0qaAz9Dum99NrQm3UmW7MONiJiVKZKmpS40O
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Add AST2700 USB3.2 PHY support.
 - Supports Super Speed Plus Gen2x1 (10 Gbps), Super Speed (5 Gbps),
   High Speed (480 Mbps), Full Speed (12Mbps), and Low Speed (1.5 Mbps).

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
Changes in v2:
- aspeed,ast2700-usb3-phy.yaml
 - Drop clocks, resets descripton.
- Kconfig
 - add COMPILE_TEST, remove default n
- Link to v1: https://lore.kernel.org/r/20260114-upstream_usb3phy-v1-0-2e59590be2d7@aspeedtech.com

---
Ryan Chen (3):
      dt-bindings: phy: aspeed: Document AST2700 USB3.0 PHY
      phy: add AST2700 usb3.2 phy driver
      MAINTAINERS: Add ASPEED USB3 PHY driver

 .../bindings/phy/aspeed,ast2700-usb3-phy.yaml      |  48 +++++
 MAINTAINERS                                        |   8 +
 drivers/phy/aspeed/Kconfig                         |  12 ++
 drivers/phy/aspeed/Makefile                        |   2 +
 drivers/phy/aspeed/phy-aspeed-usb3.c               | 236 +++++++++++++++++++++
 5 files changed, 306 insertions(+)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20260112-upstream_usb3phy-7116f8dfe779

Best regards,
-- 
Ryan Chen <ryan_chen@aspeedtech.com>


