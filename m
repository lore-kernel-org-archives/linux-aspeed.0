Return-Path: <linux-aspeed+bounces-1343-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E1CC677C4
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Jun 2025 02:59:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bH9Nh39SDz307q;
	Wed, 11 Jun 2025 12:59:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749518670;
	cv=none; b=Hf58zzFboPdhLlFhWWmVWBFwG06x7oO1Xrxr2z6S2qVlFgd/GTtOvrr2oepll/AJM6fN6u2t7B3+j11DcvaPAcUjtsmXeAuwbShGWzgUbjk9jL/9sC7eSn1tWL1pxDVZiokkQ+e0qiJN77tUnpz+pxeong8wQjzgZ67sLEUi2HeceMFDln1sZqC03aPxam7qA88Q46BZrKhfiqsIPwy9qK+AASi9SOn2BRcmUWgKCJqRpnCG5U6LKXFLZX5qnBLMRKoPL9jStM9ajVRKQv1zKd0nQuNNlF37qvFBP9Lk2kY+hsRzHPzCmrYVPWzVwyQdag7msgTjLAB0vQa958Lw3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749518670; c=relaxed/relaxed;
	bh=Do6nXEIrEVQ5hI5n6RHHCRp4hwAI954TkH6/vDkvCmU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KdZaviUrS6I7HrxT13RE785E9h+czDOfD3eDGVuofYdcW+c2f+6OLx7o9fGL1f+wO1BsN691rPKQqQmyBCFkugUzJO6U5dxIt0h8rDicJaENeLN/HZDdGtl4WT/X/RwW0Ys3WilDs6CTZh0RmF0BxyoH6f6sZH6t282JJ2vbo8BNawp0ypI3GQU9HHHML3QEjIF+013jeC/UofgDkqj9Cn1sOMeS3mMwMs2NyXBP2BWLyo72hacD0/PZVXNAzafFJrLebOMJDoGEr1oGVopuBC0IK+nUEGDgTvXf/Y0xjmn2E4X+vzXjqXhNFIcSWcal71LxALjcHOce75eky1qC1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=jacky_chou@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bGWKp3BXJz2yGM
	for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Jun 2025 11:24:30 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 10 Jun
 2025 09:24:07 +0800
Received: from mail.aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 10 Jun 2025 09:24:07 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<p.zabel@pengutronix.de>, <BMC-SW@aspeedtech.com>, Conor Dooley
	<conor.dooley@microchip.com>
Subject: [net-next v2 2/4] dt-bindings: clock: ast2600: Add reset definitions for MAC1 and MAC2
Date: Tue, 10 Jun 2025 09:24:04 +0800
Message-ID: <20250610012406.3703769-3-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610012406.3703769-1-jacky_chou@aspeedtech.com>
References: <20250610012406.3703769-1-jacky_chou@aspeedtech.com>
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
Acked-by: Conor Dooley <conor.dooley@microchip.com>
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


