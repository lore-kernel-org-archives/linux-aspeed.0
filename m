Return-Path: <linux-aspeed+bounces-4203-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50B7CD8CAC
	for <linux-aspeed@archiver.kernel.org>; Tue,  9 Jun 2026 02:47:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZCxp0Bglz2yRF;
	Tue, 09 Jun 2026 12:47:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780973261;
	cv=none; b=YVNovshNy4meS7dhp43XC7OOkEVYhbMFA8ANbwrmcB3AP/lacyL/YL5HHMKgpLP2D+ztm68VoQsQvZ8nZdkwi0f5mJdIkBFU3mgj+UL8EZnzKIwI/EFi63qHqWJ34m/DrFeiwg/IludDjzmtc26RzEveY9yYsjlhki8RaDvW3eL27AePRUAFS+8lAcb3BXLCe6WpkPFltPckyMcdrKrFhs5x1N0zoyspKtWTa23LrzYZxU112YoDpGDVVMiIrp4IADvYFwiYAZvXjqWidsUj9cyCKJgIl/dm/z62wThk4hA/mOGNwNP2xjbNRQQqzAniJ0OF10K9yHBI6LXmc1GpDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780973261; c=relaxed/relaxed;
	bh=J8GU/RXpu/KRoYfIGEmKBQ6co1BAyq/YCoDo1E0iwIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=dcK9VSFTMGpaJUMYT4MtO8U08Bc0RPU1Vhk7BDEsC7TnAfsoGrNlFEt+IcAtQbEKsNDUSkSzu6a71G0bAjGF6jrNcq9S2HmwOHQnpp/R5HGqzv2V+ADwYa4VtIrZVt1dNvBnEFLdWTuUh/EvIlraXjASR/ymRiOf4chWShe0mZtBBB0OsPv+c+Fwh2bson8zI2pAps7zeLBEnaepiLHQPZa1ijhsYZsbthfecyhc5opRaMjT/isSB2yYUZcTCObhmPw3kcD9pRj795rQgpFkOFyDFRf2WK+4HNDc50Ww3OogwAglakYdeflIx5+5DdVoDzkd17B+6q3jF2F2ayRpZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZCxn1vj3z2xM7
	for <linux-aspeed@lists.ozlabs.org>; Tue, 09 Jun 2026 12:47:41 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 9 Jun
 2026 10:47:20 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 9 Jun 2026 10:47:20 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Tue, 9 Jun 2026 10:47:19 +0800
Subject: [PATCH v9 2/4] arm64: Kconfig: Add ASPEED SoC family Kconfig
 support
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260609-upstream_ast2700-v9-2-f631752f0cb1@aspeedtech.com>
References: <20260609-upstream_ast2700-v9-0-f631752f0cb1@aspeedtech.com>
In-Reply-To: <20260609-upstream_ast2700-v9-0-f631752f0cb1@aspeedtech.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Arnd Bergmann
	<arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Linus Walleij <linusw@kernel.org>, "Drew
 Fustini" <fustini@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
	<alex@ghiti.fr>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<soc@lists.linux.dev>, <linux-riscv@lists.infradead.org>, Ryan Chen
	<ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780973240; l=790;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=EBITMQDVMIBNjYv1BqeOz0kQOoDsTctmA4eqzlKyya4=;
 b=+ySBhANUhCDR83sBpIy8ULzxKDOd4NgF2sG3COLXTWRK5kgvxZLO61u6rG8I+TjkBHgmPtAfq
 F+fDuIE2J9ABoWRKIidD2MKXV9XwRWKC6/gRbOZDYkL2QLlcSQedXD0
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Add support for ASPEED SoC family like ast27XX 8th
generation ASPEED BMCs.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 arch/arm64/Kconfig.platforms | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index dc995a732117..d2acfac73003 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -48,6 +48,12 @@ config ARCH_ARTPEC
 	help
 	   This enables support for the ARMv8 based ARTPEC SoC Family.
 
+config ARCH_ASPEED
+	bool "Aspeed SoC family"
+	help
+	  This enables support for ASPEED's SoC family, such as the
+	  ast27XX 8th generation Baseboard Management Controller (BMC).
+
 config ARCH_AXIADO
 	bool "Axiado SoC Family"
 	select GPIOLIB

-- 
2.34.1


