Return-Path: <linux-aspeed+bounces-4293-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00FBCDE000
	for <linux-aspeed@archiver.kernel.org>; Wed, 24 Jun 2026 05:45:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glW9t0cSzz2yYs;
	Wed, 24 Jun 2026 15:45:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782279922;
	cv=none; b=UkRtEBFuGlhK1zb8nk0N8ySINRsrUwc9j7hjG88D2tWh7uaXC0G9iRqAX+SkU7Tsi3nAu46mPVssqgNF7D7trGCb5kv1JUifqC/C94WsKGEjdFzE5MfMMUB/9JYYHC14Kdz3RepYawtopwrwlfRYPORHHJ0exgirKQyily0DqW8p1ODgdeAfDlq3KD4HXb+Ia/5jsSABHYiQ5Lp5K7jd02CJ8YZJD/cmnHrTM2VnttDOAvbKtG/Rf/glMXmhDv1J9W0zdDj65Inlk51xNmnP2V6uJiiew0njFuqLjyFyVHOmYh8C7RSZyx2dH8SbtBCiJQl8KxZLOzAZDT+mc8uW9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782279922; c=relaxed/relaxed;
	bh=KbHGYQnLXjx8sR3CrEtTcp69CUeSpUTPyZikbR0/6+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=J2DfMVslqupvpQ6YVdUmgav04B9cF2XQpUWRcrpjefP6EMyHRw/sT1XsLKwdZV5/bRiNgbBzvOkMotSIuJTMitQHa2jnUjn082RgzUBna3/xxZ2oNFf6Eiay8CohTjEEu+FC6bKkRvBpBRVeozM+VNGjeevLtHmGo56D3gd2x2wpnvtxWRd4rZ3thPen2BBsu6ISxasYJmHpjUlyUEikgLsCR8hqBRgL5spVNyhcFWSsNtYwGreaNxLzWchpI4uu1Z72AmX/7D2Z6D7U7ULTI+yetOqIdmNLxBrHAWCydzJ4CEnZ11V/giFCevpClsN+r8GD2iVKTr/7RNVVPwEjuA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4glW9s058Vz2yQn
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Jun 2026 15:45:21 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 24 Jun
 2026 13:45:01 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 24 Jun 2026 13:45:01 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Wed, 24 Jun 2026 13:44:59 +0800
Subject: [PATCH 1/2] dt-bindings: clock: ast2700: add PECI clock
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
Message-ID: <20260624-peci_clk-v1-1-ee28b92e22e9@aspeedtech.com>
References: <20260624-peci_clk-v1-0-ee28b92e22e9@aspeedtech.com>
In-Reply-To: <20260624-peci_clk-v1-0-ee28b92e22e9@aspeedtech.com>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782279900; l=765;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=JUf9fissI0o+YbcRxTHYw+J0Bt4Cob8MbJmxrjdeD0o=;
 b=Dbz+dhYxa8ghMWi+O0fu/mH0ly7AEJ5h7PW3fIkqJGrv1rQJOCUwAC0F+h+dYR/bOITZNM/Fx
 zSU6FRa+1Y2C/8wLxdM/ECnDLAveD5mxSyNzqTI6WjtBtRRXyCSfeDO
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Add SCU1_CLK_PECI for the SoC1 PECI controller clock source, and
SCU1_CLK_HPLL_DIV4 which serves as one of the PECI clock mux parents.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 include/dt-bindings/clock/aspeed,ast2700-scu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/aspeed,ast2700-scu.h b/include/dt-bindings/clock/aspeed,ast2700-scu.h
index bacf712e8e04..138f78ce5f07 100644
--- a/include/dt-bindings/clock/aspeed,ast2700-scu.h
+++ b/include/dt-bindings/clock/aspeed,ast2700-scu.h
@@ -163,5 +163,7 @@
 #define SCU1_CLK_GATE_PORTDUSB2CLK	85
 #define SCU1_CLK_GATE_LTPI1TXCLK	86
 #define SCU1_CLK_I3C				87
+#define SCU1_CLK_HPLL_DIV4		88
+#define SCU1_CLK_PECI			89
 
 #endif

-- 
2.34.1


