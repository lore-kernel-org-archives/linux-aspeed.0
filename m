Return-Path: <linux-aspeed+bounces-1224-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09441C3DA6D
	for <linux-aspeed@archiver.kernel.org>; Tue, 20 May 2025 11:06:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b1sDg4lgCz3bmN;
	Tue, 20 May 2025 21:06:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747733768;
	cv=none; b=jSY01onJNyVwVPwynRFj+cJyu8I/bxJmPkFCa1ZBZjR5+KTnrq0iaFSyDxNhiNKpFlgtyLEJMOKoyY1Lh7mOcX/DX1WZe8ayX9CmrTmPwiLCQlZLKHY5q0KCiEfxea41o7MJae6svRRaZ6nFQ7qAfYuYTUr6yVn8xCCmeK2CO7LmRjq7r5JCYEhpf3ztF0eAXgzPJ5bM9ewDBqdRBSzBt9b5VnW2CJlB/uNZs5kIJ6zQXqyal4Ko3Ti33advftNCQju4fDO15c0KEMvDqs2/l+jUWlyBS51QZ/5QW+YSNAxOcr2ZSnWDT+RfRG1A9WXTx0Nc1wcZ1y11h6FGuNI2cg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747733768; c=relaxed/relaxed;
	bh=60ePIMFtFNnTRq6a6scvjalpuWAEeRNc5/hW1qAcUmc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K81M6AzkvqbB1ziyyEfw4iGzhYCVuttAgTwPHpvIxlkhHk694XwS8F/3d7+dRPiMlyop8g+iBGf1wvMpd1fGp2UwTL4skvZez6+LjCeK5ORNcMZTq5cxvkV9gETsmrxK4fd/iavJcmOP/g4J+Wv+FoASF7rIUOkt+TZpGPnnpbuAEsOIVXYn+GoGgEAU079v1RXHQ/7w1QzsMgnbgPZU7ei+DafP3PRyCbddVk79q8PoP3uhqrJRx3S47boAvGzM7HISUbPM3cZFZ0CX7+L/xklvXQAALJaJmi8UWyQXo81WECCS4YIB4dz3mHUqrCR7e6b8EQJ2eKiIXuQSLFQeFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b1qDl28t3z2yrN
	for <linux-aspeed@lists.ozlabs.org>; Tue, 20 May 2025 19:36:07 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 20 May
 2025 17:28:49 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 20 May 2025 17:28:49 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<p.zabel@pengutronix.de>, <BMC-SW@aspeedtech.com>
Subject: [net 2/4] dt-bindings: clock: ast2600: Add reset definitions for MAC1 and MAC2
Date: Tue, 20 May 2025 17:28:46 +0800
Message-ID: <20250520092848.531070-3-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250520092848.531070-1-jacky_chou@aspeedtech.com>
References: <20250520092848.531070-1-jacky_chou@aspeedtech.com>
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

Add ASPEED_RESET_MAC1 and ASPEED_RESET_MAC2 reset definitions to
the ast2600-clock binding header. These are required for proper
reset control of the MAC1 and MAC2 ethernet controllers on the
AST2600 SoC.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 include/dt-bindings/clock/ast2600-clock.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/ast2600-clock.h b/include/dt-bindings/clock/ast2600-clock.h
index 7ae96c7bd72f..f60fff261130 100644
--- a/include/dt-bindings/clock/ast2600-clock.h
+++ b/include/dt-bindings/clock/ast2600-clock.h
@@ -122,6 +122,8 @@
 #define ASPEED_RESET_PCIE_DEV_OEN	20
 #define ASPEED_RESET_PCIE_RC_O		19
 #define ASPEED_RESET_PCIE_RC_OEN	18
+#define ASPEED_RESET_MAC2		12
+#define ASPEED_RESET_MAC1		11
 #define ASPEED_RESET_PCI_DP		5
 #define ASPEED_RESET_HACE		4
 #define ASPEED_RESET_AHB		1
-- 
2.34.1


