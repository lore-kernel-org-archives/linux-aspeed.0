Return-Path: <linux-aspeed+bounces-924-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE7EC282D0
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Mar 2025 10:45:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z6XPm41ynz3blR;
	Tue,  4 Mar 2025 21:45:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741085100;
	cv=none; b=BzlYt3W8IFbtwpzPKA2+vcegUMzVSLFFKppbEZNAcM2c02akABKLe+bimUTqDFMjkxK/Mp52Lxvom+J5KUskjxABdxSmBe1tjf210snLQ3YY41/8J9nvPEJzbDcSZsnPmjVLRFJJ9AP9GdSuoccKxJupXuu+dm1pYKAU2Adwk7a5A9CIRfl8yE4N1bbCvSGb20vvrbZE+1CDOJ6P/0SlzkQPEii/RGyUbKmVHm9bjWqGCy0LojOasebXB7RocLI5x/mwpat837oLUF9CjPAkb03kSHQa90cqsUgQk1pGDiHXCMzyjDBzSaKTY3+eA6Q4lwVrN/SN+ugH8IzOTMT+gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741085100; c=relaxed/relaxed;
	bh=QcaKv08Qy4UZ66/QiM5RwvtF+D/OXc8+LxCESKR92cw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OEfEtl/a+KJ8kY5BSfULwICJxyaGuAC4GvrCcxrAnppYM8EHXcBh4HCnDAnlmki0reeQEI14hDBcIDw4nP9k+LdLBgDtWhQh461ViF9TSVmwxlKXDiHCa6H66Tfji8TVCtsfo8nPQQy3DDm4w4NqChzZ3nOKmPxNbEHzLeQCDS+syg/o/99VMEdF2P9pf3/yR/6WYr72J5SYhNvLsfMzYHWlNAWFgm/mPbmQuhUZsGpKl7Z2nKd6m/TV9jZQb/HeL5EBkPeIDvnEM+2CC6JEhI7M1cZPfWFAp8W7fA9Ywn3gl3k7ruGKZi85gGfhtbGEQjOfRHedg185AjoSGDyF9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z6XPl74SMz30Vq
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Mar 2025 21:44:59 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 4 Mar
 2025 18:44:39 +0800
Received: from aspeed-fw03.aspeedtech.com (192.168.10.13) by
 TWMBX01.aspeed.com (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12
 via Frontend Transport; Tue, 4 Mar 2025 18:44:39 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<derek.kiernan@amd.com>, <dragan.cvetic@amd.com>, <arnd@arndb.de>,
	<gregkh@linuxfoundation.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
CC: Kevin Chen <kevin_chen@aspeedtech.com>
Subject: [PATCH v2 2/3] ARM: dts: aspeed-g6: Add AST2600 LPC PCC support
Date: Tue, 4 Mar 2025 18:44:33 +0800
Message-ID: <20250304104434.481429-3-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250304104434.481429-1-kevin_chen@aspeedtech.com>
References: <20250304104434.481429-1-kevin_chen@aspeedtech.com>
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


