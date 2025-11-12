Return-Path: <linux-aspeed+bounces-2876-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81EBACD13D9
	for <linux-aspeed@archiver.kernel.org>; Wed, 12 Nov 2025 10:12:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d5zjC677mz2yvN;
	Wed, 12 Nov 2025 21:12:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762942335;
	cv=none; b=AuL2KF2U+hP4jCvwEdOcSTNPykQMp86Xu7Rt7q8BDstffEamfQWB0+j2IQ5k1qkSX84WjrwS9TckvuiqWSRv1ead/w4NhWfV4vbbanNJdhd6cILapPzpZ5Fp8qG0kXkcNzUGSvsvZ4I6N86pE1QO0+8hRz5BGBfsPXzlxn5e/MwEnSQqXJXt7kYxw9SeSSe1wlyrraxqpapT9Yc44MXuiWCDTZ/M0lKYp1uRnLXvC3TIfocfkRZUXrzelkas8xpYLvZwIYFE8uxyLMbyQCGhvIbHx71zcK6UgeYtca4tfUjPeK73wWXh/ToUOxgYDvS6jgQBzaB+gJmXvT73PZ2pTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762942335; c=relaxed/relaxed;
	bh=s7g/xbPaTzB7mm67ymlcleh16oK8dSMM8yqeagrPTYA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GIRkjmUS80+oQfcpla0l28m66JxWmCsBKk2ogOIMTBLqvFwoj+cP8QhEaha9mg8v3RfkEPRs1XGgfAntVvMQWpP8p2/WkNge0tGUmhBm2TyuvtWqJ8/ibATKvlbmLRKBpcPYdpLphGOMMGziUJQ8WXKcbOuZdulo5QnPYjKkkp4W1dg7todqj+oGbOaDZ89oAmyavwKGmmv/Mnu7DNOL1A1gYWbbqpUwO2Mg+bqO4MvAyhyu9IbE6IXvDCWFUAjDm0qo2mOOV5IR/nX/2AAokGobuy/PfRHkEU4k2dOxzOkRu331O1ShCYkBjX1gfx6rTTdpoFG5Ty8n9eJKB49NfA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d5zjC2LWwz2yqP
	for <linux-aspeed@lists.ozlabs.org>; Wed, 12 Nov 2025 21:12:15 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 12 Nov
 2025 18:11:57 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 12 Nov 2025 18:11:57 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, <bmc-sw@aspeedtech.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, <jk@codeconstruct.com.au>, Lee Jones
	<lee@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
	<will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Bjorn Andersson
	<bjorn.andersson@oss.qualcomm.com>, Geert Uytterhoeven
	<geert@linux-m68k.org>, Nishanth Menon <nm@ti.com>,
	<nfraprado@collabora.com>, Taniya Das <quic_tdas@quicinc.com>, Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, Eric Biggers <ebiggers@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 2/4] arm64: Kconfig: Add ASPEED SoC family Kconfig support
Date: Wed, 12 Nov 2025 18:11:55 +0800
Message-ID: <20251112101157.2149169-3-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251112101157.2149169-1-ryan_chen@aspeedtech.com>
References: <20251112101157.2149169-1-ryan_chen@aspeedtech.com>
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

Add support for ASPEED SoC family like ast27XX 8th
generation ASPEED BMCs.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 arch/arm64/Kconfig.platforms | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 13173795c43d..ac304048a84e 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -47,6 +47,12 @@ config ARCH_ARTPEC
 	help
 	   This enables support for the ARMv8 based ARTPEC SoC Family.
 
+config ARCH_ASPEED
+	bool "Aspeed SoC family"
+	help
+	  This enables support for ASPEED SoC family like ast27XX 8th
+	  generation Aspeed BMCs.
+
 config ARCH_AXIADO
 	bool "Axiado SoC Family"
 	select GPIOLIB
-- 
2.34.1


