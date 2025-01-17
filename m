Return-Path: <linux-aspeed+bounces-522-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E80CC02185
	for <linux-aspeed@archiver.kernel.org>; Fri, 17 Jan 2025 09:52:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YZFQg00YSz3cj7;
	Fri, 17 Jan 2025 20:52:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737107562;
	cv=none; b=K0JJ1m5gs0LDmHbt2W2PjuCNMb2VMOtl1M/FFrH78fqo3Qwdv8rq13GyOjO6YBnJFGGi8sEXW97Iw0+M+/lXmwMecdgw3mt06o9oNl7Cqm4rcRiUKF4z9myInylEDVsSOZjukp6DGAWqwR/EhPEpkQEC+Iuh0TlyDmCqD7qL1RbdzZxDMTjRdn5MNzpjBBjJRN/G9NFayCPr2U9GlkrZOnPibzDSwGSwPUqS25ocx+o36lH35CppHfIU1/R2aQp4ilLtLHZIPfBaOb0VFK+LvXy4pMgm8zIohw6bqZoOlaSPv77M295atexVAKodrxY5CLnbwRUc3gFbWDGs5x/MuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737107562; c=relaxed/relaxed;
	bh=QcaKv08Qy4UZ66/QiM5RwvtF+D/OXc8+LxCESKR92cw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ea3im/Dbpl8zzWqYc2BeRg6LWysLZZrAVmJaDpi4LqxJwPBBe//Y1z3qVFzWygptuao+fLmE3EI5UKwrMDmqLJnH3Ffsa7LdsfStkpTWN9G0i4Hxvy2WDi2QbYvsaokadl8+P0+f7LbY+RYUKrpaQfBg/r+miAPwSb/6MKQ1LGDrGPggTQJavcwB+DcsQUK8FsFtX7b/ji3wMUSOJgeI9KE+vKz2tMU5sa2lpbcjLfiD196OPsdUXJW0Jq4Cmnz1BPnUuVEKjzYBrL1BzdgVWqlEJ7iYylI6E16c4hoAKEt4XRCh9J+Z4XCS5vIMUbNHQNX9myC1rXn0refAgL1Abg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YZFQf3ZLYz2yD5
	for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Jan 2025 20:52:42 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 17 Jan
 2025 17:52:20 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 17 Jan 2025 17:52:20 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <elbadrym@google.com>
CC: Kevin Chen <kevin_chen@aspeedtech.com>
Subject: [PATCH v0 2/3] ARM: dts: aspeed-g6: Add AST2600 LPC PCC support
Date: Fri, 17 Jan 2025 17:52:16 +0800
Message-ID: <20250117095217.661070-3-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250117095217.661070-1-kevin_chen@aspeedtech.com>
References: <20250117095217.661070-1-kevin_chen@aspeedtech.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The AST2600 has PCC controller in LPC, placed in LPC node.

Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 8ed715bd53aa..87dcacb78692 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -626,6 +626,13 @@ lpc_snoop: lpc-snoop@80 {
 					status = "disabled";
 				};
 
+				lpc_pcc: lpc-pcc@0 {
+					compatible = "aspeed,ast2600-lpc-pcc";
+					reg = <0x0 0x140>;
+					interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+					status = "disabled";
+				};
+
 				lhc: lhc@a0 {
 					compatible = "aspeed,ast2600-lhc";
 					reg = <0xa0 0x24 0xc8 0x8>;
-- 
2.34.1


