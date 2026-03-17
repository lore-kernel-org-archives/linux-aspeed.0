Return-Path: <linux-aspeed+bounces-3700-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A680BF506CF
	for <linux-aspeed@archiver.kernel.org>; Tue, 17 Mar 2026 05:57:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZh725QDDz2yh4;
	Tue, 17 Mar 2026 16:57:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773727022;
	cv=none; b=Y3QuIdVpA//Azcr0mrJIPjO/mRfLXI1HZeApX0N/zRDKjTUkg9XPk3WNe3W7z5QK0H+mwEYk07fNZhzQ1OHqx2Uny7xkEy7oAAGCnduf7lu8nEaPstOMKqTMgdObUUMqtjr++P3vV58ieoFsmEJGJYuTXY2vFsW5PgaFqTHdLFyKyfcE0Iss8LpM+oDhwBOiOLmFmDBOP8E3vfhnfrHY/i3nKMqCbURlTGfqwhPuL0bcsLExb75q7mFnVY7gS99YoQHauZIJ001hFv2hjTmBmgkdgoQ2pdQhBAQU9YHUej1dd9JAWNKwWFQL5EDB/u931EBEmUH5MONHAD5KUPBvzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773727022; c=relaxed/relaxed;
	bh=R1RI46GisJzD2VUiMTiqbEdP7Evcl39FEICsImo+ZLY=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=APtf2VX4+w8VruQJ9DPAi9kXCWJlXkZ5YvGsT437lcBZBuK/vyuPqhGBOlCQB/lGQgY8JGFggq2/12fe03IqU4DxtznaOucs/uFS5iPeCNW+0BYX919cf29Hla7oVZHQrptGK2q44/pHcg0gzyKcmEGqhZAmtPd7AllePQkObOCQO+P6VqUlrDeZAY3YV3O9LHJK+GByG7//5gsT/x2dWG8U1/BZovCc4L/OhxiWoiYJHzaxYGqOWBuiQRPbkeJtg9A23Lnl2/IsG+fKSYm+eSc5NOGfO2Oqtt9TGWeInsZUxu4eYr8iqS8EQoXoxrq2svgMlfi0A8rfzVBy6SS3oQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZh711MT6z2xVT;
	Tue, 17 Mar 2026 16:56:59 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 17 Mar
 2026 13:56:42 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 17 Mar 2026 13:56:42 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Subject: [PATCH v2 0/2] Add AST2700 support for aspeed sdhci
Date: Tue, 17 Mar 2026 13:56:41 +0800
Message-ID: <20260317-sdhci-v2-0-39b1f063061b@aspeedtech.com>
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
X-B4-Tracking: v=1; b=H4sIABntuGkC/13MQQ7CIBCF4as0sxbDQILiyns0XSBMZRaWBhqia
 bi72KXL/+Xl26FQZipwG3bIVLlwWnqo0wA+uuVJgkNvUFIZqVGLEqJnoYwNGu0cHoGgf9dMM78
 PZ5x6Ry5byp+Drfhb/4WKQgqLnhxaf3XmcndlJQob+Xj26QVTa+0LGSLq2Z8AAAA=
X-Change-ID: 20260313-sdhci-269d319fdbde
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Ulf Hansson
	<ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Ryan Chen <ryanchen.aspeed@gmail.com>, Adrian Hunter
	<adrian.hunter@intel.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC: Andrew Jeffery <andrew@aj.id.au>, <linux-aspeed@lists.ozlabs.org>,
	<openbmc@lists.ozlabs.org>, <linux-mmc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773727002; l=966;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=gW4uZHnAnJisSYc/KOIrw22KZpU+AhjS9RzlefavDzA=;
 b=uTbjtNoFDdzN6vBYxAPYMvALUaSypnwqYJgAOXy6A8x794z0nSIeXfXu6o6UqSOHWggQfzIPj
 ti0B9NzhzSvAZkNgX+guDCa1DZrwSmssLeZJ6ok/0tX822ESfO/HJCQ
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

This series add aspeed sdhci support for AST2700. The AST2700 sdhci
requires an reset. This series updates the binding and driver to
support reset requirements.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
Changes in v2:
- 1/2 use items for ast2700 compatible.
- 2/2 use devm_reset_control_get_optional_exclusive_deasserted for
  reset.
- Link to v1: https://lore.kernel.org/r/20260313-sdhci-v1-0-91cea19c8a67@aspeedtech.com

---
Ryan Chen (2):
      mmc: dt-bindings: sdhci-of-aspeed: Add AST2700 fallback compatibles
      mmc: sdhci-of-aspeed: Handle optional controller reset

 .../devicetree/bindings/mmc/aspeed,sdhci.yaml      | 39 +++++++++++++++++-----
 drivers/mmc/host/sdhci-of-aspeed.c                 |  6 ++++
 2 files changed, 37 insertions(+), 8 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260313-sdhci-269d319fdbde

Best regards,
-- 
Ryan Chen <ryan_chen@aspeedtech.com>


