Return-Path: <linux-aspeed+bounces-2563-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50DEECCD1BE
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Oct 2025 07:06:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cs0Z32SGlz30Ff;
	Wed, 22 Oct 2025 18:06:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761116763;
	cv=none; b=DL9wpxGCpF+iHu1+7tox3UkA6p6mhKBfaazYr29lMZAoNNcEbiPi3DaI58OutC80F77Bpdw/UV6nLPf/qGHeoe+daWWrB4OSgyWNwH67EY9yr1xUzl4XbMUXsI/Sce2Jxc8gjNzWCml4SusP6lb+kD8Z62AeHiSTF+Bb0V43pgh+xur7RWissigtKKn6ng+Hgd6wexalaT7H+a7IN63xqk1xBgEcxjrhxrwsqWINj4ZGL6tJ5GsVQg5AzKZ+UepRTLgjnakEUyQ63FGHVLjsWKAFfBCgBKSsvuZr5PhuHM0HTetN5GRT36WSfI9JRZuZRtFOvyJqp/njcBWoXXU08A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761116763; c=relaxed/relaxed;
	bh=th4WLVzRvVshFtEiKC/8iRUACCMrkbrbynPpBB2ukuI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LzVRC97/nJzkL/Fnwh718vdNxHVNC4yzo3ZwKXjI2HstYUOAU7pgwvbucOFBBNClr0jJMKWRMoiFpfL58o/pNkvg2zbRvLzBUgcxHRsDwyQ7iumL4qdkBqQUV2JxYSauoOceetWoTwnTUryjTm7TKoWTG89wDMwM2KCXncFFlCNl8kWTA+Q0CJvG1mK13anEEDO7cvfJVoe9RdKLFlE6ZlxzyZ25eBlEUGfh0jhhNaQCxR3lLV2gerM+TfYubRQTvcpAAk7GEZ+utYOsvUScrBeZOxWyH7lhvJfY7UipCCJI0jBLTO1ezlDgcl/WjY3kB5wAcVOf3dO0OB2Rli8izA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cs0Z268Lcz2yjs
	for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Oct 2025 18:06:02 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 22 Oct
 2025 15:05:44 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 22 Oct 2025 15:05:44 +0800
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
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 6/6] arm64: configs: Update defconfig for AST2700 platform support
Date: Wed, 22 Oct 2025 15:05:43 +0800
Message-ID: <20251022070543.1169173-7-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251022070543.1169173-1-ryan_chen@aspeedtech.com>
References: <20251022070543.1169173-1-ryan_chen@aspeedtech.com>
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

Enable options for ASPEED AST2700 SoC.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e3a2d37bd104..ca2978dd1ccc 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -39,6 +39,7 @@ CONFIG_ARCH_SUNXI=y
 CONFIG_ARCH_ALPINE=y
 CONFIG_ARCH_APPLE=y
 CONFIG_ARCH_ARTPEC=y
+CONFIG_ARCH_ASPEED=y
 CONFIG_ARCH_AXIADO=y
 CONFIG_ARCH_BCM=y
 CONFIG_ARCH_BCM2835=y
-- 
2.34.1


