Return-Path: <linux-aspeed+bounces-1711-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60EFFC83F27
	for <linux-aspeed@archiver.kernel.org>; Tue, 15 Jul 2025 23:57:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bhbgN6GTNz3bpx;
	Wed, 16 Jul 2025 09:56:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752551024;
	cv=none; b=aGqFzTv0w4F1ytsOPFo6jfO/SFk3ABRTNuwzyfGDfpkcvSYhtI+pjCJaPQGu6BrWY/mYr0N5QwRSgfSbMAQclbU60t+VA142WD51BqqkU0S5ChRp/FjWmzyFF23u7POg+e5X8DLagzaLecWZ3S5gnQHmqTJ6FWpKO7tORdBAv83thK1jlXxVhiRz/PMkyvlFT23v4KjPbbqMUahy0tHEqy1ScekB++DF3XCKJ2DCBJ2oxkPaLcnvXEFtohxlUSJYe4MQgNa6r5mCtTlPeJcEo9luTcgMtL6DcRNi5aGwB3UP6EG/DS4Ywd76uQVpTId2Htaew9hxFhDf61pMp2+yRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752551024; c=relaxed/relaxed;
	bh=eL28uI7lKCJ8Rfi9gSrcEWAhhPIZq5+PvERJopPLclo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b5TUEye4dmoPnVtCwoLbeXzmDeH/aLlmfr+c2NNNDLzeCEAqybZ6eGjWtbsNzPU5bJFwBK/p6SX/hyyru247Xa1gZwyrgqz+UlxEM9rEgGmokujUY6js58GOAAIfXPRlU1PKSHm8x1jZYX9VIp8/VzkPfHdzY8S5+nuhrZ6XX9Ktl/2TcssRTBw6aE1a+61gBe10/RLMRPGSy/HGrw//zNOc7rDRz4zW5CkoupK5Iv/uS1NI5U+jdmlN9sQHjev3+0BT83YNl9M8ViUwYB9/tBUOwA15cbhfhqztFX7V7DxN0rmTgBua+kUyz1Y8YRUtMYPRCfycjDIIdhow0f9ywg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bh4mH4SbRz3c78;
	Tue, 15 Jul 2025 13:43:43 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 15 Jul
 2025 11:43:21 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 15 Jul 2025 11:43:21 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
	<mani@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<linux-aspeed@lists.ozlabs.org>, <linux-pci@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <openbmc@lists.ozlabs.org>, <linux-gpio@vger.kernel.org>,
	<linus.walleij@linaro.org>, <p.zabel@pengutronix.de>, <BMC-SW@aspeedtech.com>
Subject: [PATCH v2 04/10] dt-bindings: pinctrl: aspeed,ast2600-pinctrl: Add PCIe RC PERST# group
Date: Tue, 15 Jul 2025 11:43:14 +0800
Message-ID: <20250715034320.2553837-5-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715034320.2553837-1-jacky_chou@aspeedtech.com>
References: <20250715034320.2553837-1-jacky_chou@aspeedtech.com>
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

Add PCIe PERST# group to support for PCIe RC.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 .../devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml     | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
index 80974c46f3ef..5d7fbb1c72b7 100644
--- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
@@ -254,6 +254,7 @@ additionalProperties:
         - WDTRST2
         - WDTRST3
         - WDTRST4
+        - PCIERC1
 
     groups:
       enum:
@@ -497,6 +498,7 @@ additionalProperties:
         - WDTRST2
         - WDTRST3
         - WDTRST4
+        - PCIERC1
 
     pins: true
     bias-disable: true
-- 
2.43.0


