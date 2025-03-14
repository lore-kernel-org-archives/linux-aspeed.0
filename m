Return-Path: <linux-aspeed+bounces-990-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 756D2C35FF6
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Mar 2025 11:21:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZDhlL0c2vz3048;
	Fri, 14 Mar 2025 22:21:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741951294;
	cv=none; b=bkro4nwVEHd7hp9Rz+IEPSrkKqOjtu670wNJCeBvrINLFzVgTJQ8hBVE/EsVsGc8+D7j2YwgyUvCkB02XpK+uUX/1dTaoWNnql+TiJtpU8QxpumyIFFwwqOCh2HR1B6prDRWAkc7VGHS6sFS2/A4CXMxCWF5se5Zq+pJGFKstm8W6vzuvIv+y9ejnI+d7HAHSbiblRtPqIfc5Vibaz6FmVNzix8i4moVhC5lTR6mPHIWY5NoXACar6jy5/DJ7wchr4sohH+Z/R86giQopkoMOliU4zc+bS/hV0tybt43K3OXJL2ori7E3Iows5krOH5RcE+98fZuWiJIFbVcwRUhvA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741951294; c=relaxed/relaxed;
	bh=LHMDjkYUPXEKIkCrKqC2rKaoaf79SORNIgycS++zpHY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ACVqawExnAPRnZ04BAcpaGWDLnAtCxW6iw1DDw83J0BPBc2XqQtluVzD2UG5W6S0tl9gYssfN+81utjvqI60rovN5uSEy3XJi7lF5lqXMtLK98gxj6s1MO/w5ULVTKpN2/v1BpFYxo2d6z76bXN9WMLRzixHXvad37G2xDGlrEXQDRTGb0DebJf+e2MANcGjbxYfs1srvfouCIs2qtizWw4LJAtL0pB7EB4ro1l4LBAiJ9ZaV4Zq6Ni+ng+U9icubm9TuHIqOv0ygZw3qjU+cZkJ1p3W18+j9rczdcBahWliUj3gaCz8yKmPYI55ZjuDGvxfsh303QosIsPB7gtvrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=kevin_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZDhlK3bBmz2xmk
	for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Mar 2025 22:21:33 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 14 Mar
 2025 19:21:14 +0800
Received: from aspeed-fw03.aspeedtech.com (192.168.10.13) by
 TWMBX01.aspeed.com (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12
 via Frontend Transport; Fri, 14 Mar 2025 19:21:14 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<derek.kiernan@amd.com>, <dragan.cvetic@amd.com>, <arnd@arndb.de>,
	<gregkh@linuxfoundation.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
CC: Kevin Chen <kevin_chen@aspeedtech.com>
Subject: [PATCH v4 2/3] ARM: dts: aspeed-g6: Add AST2600 LPC PCC support
Date: Fri, 14 Mar 2025 19:21:12 +0800
Message-ID: <20250314112113.953238-3-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250314112113.953238-1-kevin_chen@aspeedtech.com>
References: <20250314112113.953238-1-kevin_chen@aspeedtech.com>
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
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 8ed715bd53aa..f238337e02da 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -626,6 +626,14 @@ lpc_snoop: lpc-snoop@80 {
 					status = "disabled";
 				};
 
+				lpc_pcc: lpc-pcc@0 {
+					compatible = "aspeed,ast2600-lpc-pcc";
+					reg = <0x0 0x140>;
+					interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+					pcc-ports = <0x80>;
+					status = "disabled";
+				};
+
 				lhc: lhc@a0 {
 					compatible = "aspeed,ast2600-lhc";
 					reg = <0xa0 0x24 0xc8 0x8>;
-- 
2.34.1


