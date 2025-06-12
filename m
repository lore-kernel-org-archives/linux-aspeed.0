Return-Path: <linux-aspeed+bounces-1402-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB281C61CE8
	for <linux-aspeed@archiver.kernel.org>; Thu, 12 Jun 2025 10:09:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bHyv95Kzlz2yFQ;
	Thu, 12 Jun 2025 20:09:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749722997;
	cv=none; b=NYBaGDuAbiAf4pMwGXOxJjgrCcYpQ+oK1kv+GTiR9kmZ52gz/fEt21I/27jcebD5btd4qbo0Rjm+EF10UJoLYloSwGggL76AS6DHk8t/IF9XC7gLUwIDyFUMwB9dEz1WK6vW9Zc0i6hxqkNUs7El5CGN4XM9nMEJZgSIxF8yEGW4NLLitev47kLpohcX4J5js8+ETIi4ytLxt0xhrKAZd6WD5sB1feMxHl139UNctlqdR1M5O2+EIiHob36eClTaCGQ34UgQbrE5sW+Fx49BSR5wIxK8ynkZukqaRHOAQnpN79IQ73dfoixoEZlqtUKTYtI2uj18h2zwXb3e81SrYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749722997; c=relaxed/relaxed;
	bh=OAwzjOoPOJenUbA+hupVn9J/974uXM3UmFx57fi1psE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hAFoXU1/pEBTwIVJ/t1VU2LS/6LguM5BzFGZxr5VZ9ing+afFOn5nR4t3YCER1svuDkzUIuOIxSdFRcrM3t0QCiFSW1TWRPyVMeq4qjiHgr3dXAI1gzfpTRlTQilK/0X0OoJA3O0qX4krk1U3nIuxKYFsyJoSmmZbmQfX2RVu6kosGrx5j1wlJfHZwZcVEoJ5uYSlgif4XZYI1oII5j6FdpPHwXEbYDS36orMg/gM4GnB5RHNiGZhhtUzqyebc5tYXYNcmgtwNF/DgZUexX9ujDy4m1+GYllUrSEo7Mb51zZXR/WFAzSRNY4/L6fgq8xe41JCYggsYUIQdvlFCcI0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bHyv91MQDz2xPL
	for <linux-aspeed@lists.ozlabs.org>; Thu, 12 Jun 2025 20:09:57 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 12 Jun
 2025 18:09:34 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 12 Jun 2025 18:09:34 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Bjorn Andersson
	<bjorn.andersson@oss.qualcomm.com>, Geert Uytterhoeven
	<geert@linux-m68k.org>, Nishanth Menon <nm@ti.com>,
	<nfraprado@collabora.com>, Taniya Das <quic_tdas@quicinc.com>, Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, Eric Biggers <ebiggers@google.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<soc@lists.linux.dev>, Mo Elbadry <elbadrym@google.com>, Rom Lemarchand
	<romlem@google.com>, William Kennington <wak@google.com>, Yuxiao Zhang
	<yuxiaozhang@google.com>, <wthai@nvidia.com>, <leohu@nvidia.com>,
	<dkodihalli@nvidia.com>, <spuranik@nvidia.com>
Subject: [PATCH v0 5/5] arm64: configs: Update defconfig for AST2700 platform support
Date: Thu, 12 Jun 2025 18:09:33 +0800
Message-ID: <20250612100933.3007673-6-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250612100933.3007673-1-ryan_chen@aspeedtech.com>
References: <20250612100933.3007673-1-ryan_chen@aspeedtech.com>
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

- Enable options for ASPEED AST2700 SoC.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 897fc686e6a9..c9d90aa07e59 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -38,6 +38,7 @@ CONFIG_ARCH_AIROHA=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_ARCH_ALPINE=y
 CONFIG_ARCH_APPLE=y
+CONFIG_ARCH_ASPEED=y
 CONFIG_ARCH_BCM=y
 CONFIG_ARCH_BCM2835=y
 CONFIG_ARCH_BCM_IPROC=y
-- 
2.34.1


