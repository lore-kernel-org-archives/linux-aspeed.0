Return-Path: <linux-aspeed+bounces-755-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4BFC021AB
	for <linux-aspeed@archiver.kernel.org>; Mon, 17 Feb 2025 11:48:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YxLXR6Y88z30Ns;
	Mon, 17 Feb 2025 22:48:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739792935;
	cv=none; b=RnnzIEaJmgHQgmwJwBWO+owt2HekszigWxlLG/d6m/kpR6Xa11PBK2QLl0FUGyfDjjOJ6wbusCqUm54vQzUm46XbhlVYetBhCC92W6FuVH8Ukc0dvsR94Mrupwu5vQHVm7hiA734YPN78ixDZgWYtWrrH0SdvuJQtolkcbArjz0mJJGMpBEgEvGsIvkNyJIlaxTo9KY5cYdFabtVhwvoq0ZKfzcslzk8UZ5qnAs5Szgoij7atYHqSxMePcxau6SlfjF+yjB7WznZacN5U3qyhpPhcO1JO8O9gpXiGk7cLu5KKmvyylq36PjHo6XcGnMucyAULJxjn5Llr3zJeQmsfw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739792935; c=relaxed/relaxed;
	bh=QcaKv08Qy4UZ66/QiM5RwvtF+D/OXc8+LxCESKR92cw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vg9iOfCjtDNLT/kwKEjWO/4loeZamvJ9eFVRVvWP6pKHNAWVklNzQHClpM9LYYLe7sQ/6wLUC7gPch7SD3APmvopeJJJ2QJ3/fiA6CcxF9KmvdOr9SLQz0qJHGTcXUeJFivv6ooFBoEc5exzkjvnZ8mnNZIfbS1cPJ+V26ov45uPt9+VcE37YdfZVskgEN9qiwacmhGFWCQLxe9Gn1YESz41ynONMM/FV8Aiuoc4+hzzqv3ZVlvSp8NNvOdMxy3LvK8glNdqG7snCV0/h5wy5aNFqAbIoO2FOtuP3aDNiwpvFsspUjjT+uEKbaTYYQDIdiJ5www4kbDLC49QMetSxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YxLXR2q5hz3093
	for <linux-aspeed@lists.ozlabs.org>; Mon, 17 Feb 2025 22:48:55 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 17 Feb
 2025 19:48:33 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 17 Feb 2025 19:48:33 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<chiawei_wang@aspeedtech.com>, <linux-aspeed@lists.ozlabs.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Kevin Chen <kevin_chen@aspeedtech.com>
Subject: [PATCH v1 2/3] ARM: dts: aspeed-g6: Add AST2600 LPC PCC support
Date: Mon, 17 Feb 2025 19:48:30 +0800
Message-ID: <20250217114831.3225970-3-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250217114831.3225970-1-kevin_chen@aspeedtech.com>
References: <20250217114831.3225970-1-kevin_chen@aspeedtech.com>
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


