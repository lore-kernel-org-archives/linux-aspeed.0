Return-Path: <linux-aspeed+bounces-1811-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A727CC83F1A
	for <linux-aspeed@archiver.kernel.org>; Wed, 23 Jul 2025 23:47:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bnW562xKdz30T8;
	Thu, 24 Jul 2025 09:47:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753242189;
	cv=none; b=EwyfyFk6eF+mgGrVrdBzhbOEfGqJYxjZvoCC2osGlT5S/glF1uHioNTu1XL7t+TBy6gXW4LuTxy3+8Qx0fCRdSZPWlQyFw2paZcNZWKwWQFHmLubL/hp8G0hwXh6BuLU6Wg8kz7bhs2F7pQ7a8TAYz9GOVMVXJ+IsMznjVI3+/oAOBw6w/TE801CGxo2UnQ1GDlQkG1Nnhs3oMp8q9/gwD/Q+Mra57yioPnhb79wF1KWGmBNmFwBR7X3PbcgkKbmKHGHpP9x/2XH1cbbCcq+HurkIVKKYgcoL2tGNpcxbz0Iwq8CnhGBtS3o4qYysIp1o974fWcenVa0cAvkscgdwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753242189; c=relaxed/relaxed;
	bh=w/eos1Iv+JJoIEFFCBL+Da2J2v0o9eRaLw9+DKJIo1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SnR38hAvDaB0vptQ43vcrKh3ahw3rvcKP4Fv3GwxK6FrQwx2EedliywMwW+UEq1d1Lyckg9FBpSAoHZo2S2RaK6Lkf/NH46YCPxNm7Wy80ND+dtXZ0MVE0cuGQFjyL2M7mlv+F5N2M2GXmfJSmyE4cF6nogjZ9UWy1sYf+hYChAOQQQmIldXunkUYOdoHQnUjLgztP6AZMLsglFqlzK4JL5mE0rMd6q7R0ZRMgVueAbu13DzuBeNkH9shuJVvBmuocRWkESfuIuDvxcU7w70dHlC4EQoxSk60QdeMvzGPrdjiPwKVSThStS9NTRVVETdtzR3hYxEaTY0gKkI08Mf2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=eapXKPIQ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=eapXKPIQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bn0Mw3rsmz2yF0
	for <linux-aspeed@lists.ozlabs.org>; Wed, 23 Jul 2025 13:43:08 +1000 (AEST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-23f8df98e41so10973635ad.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 22 Jul 2025 20:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753242187; x=1753846987; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w/eos1Iv+JJoIEFFCBL+Da2J2v0o9eRaLw9+DKJIo1Q=;
        b=eapXKPIQyM3zmyWonKtByh7i3r7A1EEYoPob2qsXshnmc6OXUk9Dbma1ryvMIyBCsM
         imQnCNHmg5k8slVcCFxiugsqhPjUFHFRoffuuH819jMqUI9+9RX5hNdt4ZlVIAfU0xGA
         e4ZdjekyOZJoK2EoA2K4Giz4wC96dpLJCSvwMEeTwpe86U5j2vsu4u5rD20yJxrQeIfY
         ZKUgfyhk+jWAiqU06REZSqf47WtDEbHXbiYrBccDbBD8/n4eSKxf9SwFsp+ZaXXdmz/Y
         UcCKYN4IvEYM2Qx61zSzoW+OaXC+UynFKyDZuhLMNsra9fB2rV/7fgQ4x0M1sY2hyGWJ
         XJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753242187; x=1753846987;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/eos1Iv+JJoIEFFCBL+Da2J2v0o9eRaLw9+DKJIo1Q=;
        b=FKt2p87Fcf8uLjR2hmrnFC8WxXp8vnBdBZQ7GnfmCzjNyNLY7biKwsncCffU3c1oSb
         s8NwcpKRrtYSUAHD35iTxBEu8ggt7zdjwu4uf/lOEbS3FxQV2Sd6l8HeIADGFgFYshrD
         XD4Xyyd0e2OSIlffWHsYSe/4FfUE+ANsMPj/Nv8b8FIy+PKshJJvSIPZE+ZezzgG+aP2
         fG6Z9E2QZuupEq9wxzzJ+S/UwKdR3hMZqFqU1WOxNkv9TupCGfLCJp8lunCIAkkToJo7
         Dlc1FiHSYMSYbETJR2210M+2x+pPHBU9Sb6k6Q3K4ad5ChF4N0pjgv899BN3ycOV0J7B
         ir4g==
X-Forwarded-Encrypted: i=1; AJvYcCUaLJRTxCuZmd51eLncillzaDfdMjiU1nnoKdddniw8i8zAgMAB2gA0JDplf4j7BL+XiOBbSwZeoNx8auk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxqa9Vg2TsAHBZ0F6aYk04P7+GhCWO1D5Y8DfhMwHh37Q9ab6vC
	+koMQzoShGqAZCQPBpTlxWz6iAEspLyu+pEQXweC2LkKIVREbZN69ChFLkt/og==
X-Gm-Gg: ASbGncuNgZz7A2cwZRbOUgVjPcF/JemYH8GgdpVbuX63sbBqOkxmj240io/xAry8XxE
	PKc5Bgqj8BKsYHnh3xDseo+rCUc76FrsQfglJW7YRdaZB8AoV4Rwu4by2gIMvaD0+/hTN0JbAvw
	sTqie3c0X62myATJbF1ayidggFwq/N3rAR6rMkoAjfmz3t1tfcOzTgt0rzxuQkW2cZUrYbgeltl
	jyyJp45x/axs8w5iBwva2oMDgquXe6GnHTgxsSyLmTSbBOeEm19EmHUHRDWUmLb04KOh//N9Wa8
	X4Sg/sTsLuF+dtDBaBM2hJGMgq5XGQVooOmUGv0wScmVsIFmjnUZ7abixziScC0QAWufhu6Asfu
	G/ULT5nC59lHpZfeL/Z5lPfz5MvbBZLR+9yyO/dVSNGWAGp70N7HHgitDBJRfP6F2hNU=
X-Google-Smtp-Source: AGHT+IFUs+bNPR/ApG847/dcTAVEW96jKv4IioRlAvKP8jVS3JRjCWVIBr79jzQ0RqfNHkVXPiEhNw==
X-Received: by 2002:a17:903:946:b0:235:27b6:a891 with SMTP id d9443c01a7336-23f981a83c9mr17116365ad.28.1753242186685;
        Tue, 22 Jul 2025 20:43:06 -0700 (PDT)
Received: from [172.17.0.2] (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b4d47sm86197605ad.99.2025.07.22.20.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 20:43:06 -0700 (PDT)
From: Leo Wang <leo.jt.wang@gmail.com>
X-Google-Original-From: Leo Wang <leo.jt.wang@fii-foxconn.com>
Date: Wed, 23 Jul 2025 11:42:42 +0800
Subject: [PATCH v9 3/3] ARM: dts: aspeed: clemente: add NCSI3 and NCSI4
 pinctrl nodes
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
Message-Id: <20250723-add-support-for-meta-clemente-bmc-v9-3-b76e7de4d6c8@fii-foxconn.com>
References: <20250723-add-support-for-meta-clemente-bmc-v9-0-b76e7de4d6c8@fii-foxconn.com>
In-Reply-To: <20250723-add-support-for-meta-clemente-bmc-v9-0-b76e7de4d6c8@fii-foxconn.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 leo.jt.wang@fii-foxconn.com, george.kw.lee@fii-foxconn.com, 
 bruce.jy.hung@fii-foxconn.com, Leo Wang <leo.jt.wang@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753242171; l=998;
 i=leo.jt.wang@fii-foxconn.com; s=20250618; h=from:subject:message-id;
 bh=hi/PAdJ6bxER/R9rOhwjyW/uXI7cI32IlUrsv9ex63I=;
 b=kihku6zIwBO0LFNgqF1bX/J2ndiQu/2V21i0gTYkTS71k8iN52bF0HnmmT0NL6p8te3NQezO7
 BoSboi3lRPaC1P0FHR6xTZ2l5RtNyQzpo80y8WTx2j+I5p6SpBr0JhM
X-Developer-Key: i=leo.jt.wang@fii-foxconn.com; a=ed25519;
 pk=x+DKjAtU/ZbbMkkAVdwfZzKpvNUVgiV1sLJbidVIwSQ=

Add pinctrl nodes for NCSI3 and NCSI4 to the AST2600 pinctrl
description, enabling support for RMII3 and RMII4 interfaces.

Signed-off-by: Leo Wang <leo.jt.wang@fii-foxconn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi
index 289668f051eb4271ac48ae3ce9b82587911548ee..e87c4b58994add33938792f732420ade7ea5c23f 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi
@@ -412,6 +412,16 @@ pinctrl_mdio4_default: mdio4_default {
 		groups = "MDIO4";
 	};
 
+	pinctrl_ncsi3_default: ncsi3_default {
+		function = "RMII3";
+		groups = "NCSI3";
+	};
+
+	pinctrl_ncsi4_default: ncsi4_default {
+		function = "RMII4";
+		groups = "NCSI4";
+	};
+
 	pinctrl_ncts1_default: ncts1_default {
 		function = "NCTS1";
 		groups = "NCTS1";

-- 
2.43.0


