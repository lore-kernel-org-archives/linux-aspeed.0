Return-Path: <linux-aspeed+bounces-2818-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1571ECCFA1B
	for <linux-aspeed@archiver.kernel.org>; Fri,  7 Nov 2025 05:56:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d2pGm4QXtz3bt7;
	Fri,  7 Nov 2025 16:56:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762495008;
	cv=none; b=UZ8BsEbSScjJWj9XVTJIpfxgiQS/khg2MkuWYv1Iq9iz7rCsYRUl7AKA1v1EFvM2JCtLkjK0jIhwVPP+mynCWQttVwPJfZeganJAH7ATiU5zlOmvvM+Q/L448JS+9s5sho5mUO0L0cpJL8XeZqzIFW4eMR8lve4igSkQi3h/5C3wNyrALRkVlraNvRjNnY2Tb8ILa3ctVM4xljeik1Dvv/ZLoIjK5P8Y8JzrTynIhdolh5LR0wgSQ0ZXO1QY3RFncBkWnMRHpk+o4RqbLf5KcWEUktb+rr1vLQ3NE96W/BseHwTkZFjtG9YNmzlbBcvh0j14Qn210sNP5f8Aq8LynA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762495008; c=relaxed/relaxed;
	bh=K19L2aHElqRDVFLnCjL4YIGWgK0Aw5CS4Yc/zP5tjrc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g30tvE/nVq13nUzTL0PwGt3Nd9Px24he0xAlN/EXroYLcOSDlyBSUJIhNuEWal7WOxNuwx0yEtVfXLohww5WHGa4Iwe4RigBUIqcf0sT8b3Mm68TsszbHFmgrELL2h1PgGY6H5g1xCWumuliPK5fTHXoOjkycGueBYsedKK9ntl+qNRPaSrxEXOrqmV5nywJSTJLZnPGjuwxLqhKfpKKvL68k+jlqrUNln9gmH5CZq/xgqKR9cCSkBEFe3jMghEX3D7JHjqG8PQcTfbcgaFYVB2w6k0g7zp9BHjJmbNraEJttHAVR7c5CM+LTrPgIsTCc0KUTPsu18hwmyBb255Kjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d2pGm0kQPz3bfN
	for <linux-aspeed@lists.ozlabs.org>; Fri,  7 Nov 2025 16:56:48 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 7 Nov
 2025 13:56:30 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 7 Nov 2025 13:56:30 +0800
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
Subject: [PATCH v7 2/5] arm64: Kconfig: Add Aspeed SoC family (ast27XX) Kconfig support
Date: Fri, 7 Nov 2025 13:56:26 +0800
Message-ID: <20251107055629.4075519-3-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107055629.4075519-1-ryan_chen@aspeedtech.com>
References: <20251107055629.4075519-1-ryan_chen@aspeedtech.com>
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

Support for Aspeed ast27XX 8th generation Aspeed BMCs.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 arch/arm64/Kconfig.platforms | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 13173795c43d..d2746107ceca 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -47,6 +47,12 @@ config ARCH_ARTPEC
 	help
 	   This enables support for the ARMv8 based ARTPEC SoC Family.
 
+config ARCH_ASPEED
+	bool "Aspeed SoC family"
+	help
+	  Say yes if you intend to run on an Aspeed ast27XX 8th generation
+          Aspeed BMCs.
+
 config ARCH_AXIADO
 	bool "Axiado SoC Family"
 	select GPIOLIB
-- 
2.34.1


