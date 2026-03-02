Return-Path: <linux-aspeed+bounces-3582-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B87EB3640
	for <linux-aspeed@archiver.kernel.org>; Mon,  2 Mar 2026 23:23:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPw3R6xFBz3blr;
	Tue, 03 Mar 2026 10:23:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772425226;
	cv=none; b=E5+JyRKESsHZG1YJM9z/54riEMk0DuguP/I94Oc2/taAiC9LDghEXZJiajMNbFMTcNbdbuyfHTUpjRO0+8YeyKecXUEcjqGI9SZ8k+jnVfoWJh2wq8QpWhcX7pEl1ufAoG51i45ypjmFXzhrcPNZ8s3lBdEZw7M7PJgaX122kT2iyF87ZwcbeZmQR9/o8d50ZEwAY14f5Ly7f7tuFXtnLlwTsTrVK+ZYmU86afMOMzT2cQ8XHS0cfd7CuI3WnRYAl71aR4PDR8w1z24x9h5LTOYph1+Jqg6Fqe+U31KGEacT8nFy6QoUnRaaldnVhDig2AzDiAB3F/zg/Np7Rq4kiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772425226; c=relaxed/relaxed;
	bh=g9G7fxfmzVlIi5Fr50mSQN2bdN4kcLFoj1561/FSzpQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=R/hYZfJBTaLwc37cAQdAwib8g6uuhSzoR4s4I8WCwZQTfv6+HgQB4m/Xo7BiYoCgH3HJunz0WhyUOr1jUKY1jylrQ2bDcPaQqeCJnrzko5TA1srQHa7qb+e8Sfkmq4qvO/GF3m9RnfeUxc/t3BKkDamq/rpqj6S5W2hBRLxjzcc+C5VIoWZaFCo2pTr8yTQhfGQI3qEdaBx98OLieUAtxHPAPqxOuaonNbcbiY6vzk3a8fEHR/OpIf4VI0S9/D8hB1zrMN6wMG6IwCyjvgmSDpUX9+70CpEsqW9IYTMMBqtnfn6rj72qZ7dEs65fQyMwerEqRWtY9/xTnyiyfN3XHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=fF4JGFIa; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=fF4JGFIa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPQhT3rmtz2xNC
	for <linux-aspeed@lists.ozlabs.org>; Mon, 02 Mar 2026 15:20:24 +1100 (AEDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so2099823a91.0
        for <linux-aspeed@lists.ozlabs.org>; Sun, 01 Mar 2026 20:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772425222; x=1773030022; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g9G7fxfmzVlIi5Fr50mSQN2bdN4kcLFoj1561/FSzpQ=;
        b=fF4JGFIaT+TQjdD6DyWRz6MJw03nCDBHsxinsJpp75Qko2qK0rkIVUDRXGS3Sd2b1+
         ukL1FCnSdhP0ejpLN5iHowUeo3HgOQityokIl/3GVWwcEEr8CH9NoAczVssuJrATRMcV
         PaDxL9e5ZfF9km598X8SCjDJvacmAXxrkEO9PNpY8JduB11arqa3d9bx4Q9yVPIz3za9
         PoJxl7fOdg5bLgVrwvAYFooL41blz6kLqskhdC7MCTvV5hUpNVvJypyWStzp1wVbmvlt
         kWoIjABqQDlI8R636jN2tlLZkdfbfkqbN1AOLX8pn+OaH7LU8vKHk2yRLrFtjDiyyiXn
         PcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772425222; x=1773030022;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9G7fxfmzVlIi5Fr50mSQN2bdN4kcLFoj1561/FSzpQ=;
        b=LuHTtbwqWhUDwsh06mlhrShMwCFbTxovaOdAq1PJfMCRIXYvwRLxB2XCkVgYnrosvy
         6uoZCeSIFZEcu4Q91f6rhsrCXityqnqHnQHdx+xEU7LRT8CyMdOWmbcxoLr4N4GYj2hZ
         GfC70XpBEKMeX0K32oJ0FcxRTp8iSag+EPhlUk5LLcUj3Lt401AqHFg6TPik9G73PkK7
         shQnYivhAxAIWjxDq9QRdhGihWzm4z3jBbZ2iXB05ciisdRoCaAp+e7ZKxG8liXfZSVc
         Qg/KL00mkXfzzddSDHDvCdp+mipNQ9eOASCkmSJRFUZ39HIeElMn28wow78vKipW7xJN
         K/Rg==
X-Forwarded-Encrypted: i=1; AJvYcCWUOJaAYVIcPnlHOTygculQbMv5mkKYZloBiT30NqbIA20WI2Fq76wd/baAW9yi6WxaOTFM1rotzGVLQkU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxgFXUnINCjaJXtxilf32GdTUBrvZPRytHAthXpOT4k7/VuxxyA
	g6paG9I3d3qRH2tEtM1VIoYqRY9/+Aov9RiSuLhymoKUNZfRTXhpkVAL
X-Gm-Gg: ATEYQzxP1rMqUjsG4wW7AM08OuVBDtUyTU49D8Vfraqr8dxEBhlNQgqFy7j6T/uGwMN
	WhHN6/bouvg8lL4xuRbdvTCMKVQncorHlprJG5eENuis1C0mFCFNcLqNQA7TobCkHiRb8Uxi0FS
	yF7t8QTh1ZKJYfo/cdG40J7URRL0dGjSVePeH2NPqIR2LwXv2/iGWx8vGgchMsj1PJNy+mong10
	r20NT5kdyhCw+88qshE8KmSzu/RG4URytXIgMsKwX+b2zGQFm6Znoj0LvkgI9++9Dh4c/tZCAu5
	UeW7++f40+IfdDLNezrH3LU9Mgy6qEAlY77/v1e4RVAX+Ai4/tmP4/SNT1oFlrQH72MyHjkTA/g
	gVd9qb+lOjHwDz/mMWk8G3Au8LkCS1nveI5QGLyJcFmgo2kEn6PjB9aoERIdwMT/BeKIszrot/+
	AnESo06Xe+03pPolUsYTRjJ7CqN4TG6g==
X-Received: by 2002:a17:90b:3d10:b0:359:9083:3661 with SMTP id 98e67ed59e1d1-3599083392fmr961910a91.15.1772425221617;
        Sun, 01 Mar 2026 20:20:21 -0800 (PST)
Received: from [127.0.1.1] ([218.32.81.133])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3593ddd737fsm16355794a91.13.2026.03.01.20.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 20:20:21 -0800 (PST)
From: Colin Huang <u8813345@gmail.com>
Date: Mon, 02 Mar 2026 12:20:01 +0800
Subject: [PATCH] ARM: dts: aspeed: anacapa: Add eeprom device node
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
Message-Id: <20260302-add-new-eeprom-node-v1-1-2bcf87bc22e4@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPEPpWkC/x3MOwqAMBBF0a3I1A7EKP62IhbBPHUKE0lABcneD
 ZanuPeliCCINBYvBVwSxbuMqixo2Y3bwGKzSSvdqlppNtayw83AGfzBzltw1xutTLc0/VBTLs+
 AVZ7/Os0pfVqL4pZlAAAA
X-Change-ID: 20260302-add-new-eeprom-node-78a20a7c4893
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 colin.huang2@amd.com, Colin Huang <u8813345@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772425219; l=1109;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=5gILMaGdI1v5nQ4lLFzK5CdL3aZ4jAwq3TDemRpn7yM=;
 b=Lu2BNkUYsAir1qaAPj6PiWZAitwbLnlXMKIMJchEYxY5pYd47YiouzudhsnMoLL/B+oVJfW5Q
 D+kdN8Sb79fDEG51sYs3sXbU8apew5tWFmTKD+DKi5JRdpkhfM5znsa
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=

eeprom address changed (0x50 to 0x51) in DCSCM rev D
To support previous rev (B/C) and rev D,
add eeprom device node for DCSCM rev D.

Signed-off-by: Colin Huang <u8813345@gmail.com>
---
DCSCM rev D changed the eeprom address from 0x50 t0 0x51
To support previous rev(B/C) and rev D.
add new eeprom node for devscm rev d.
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
index 2cb7bd128d24..680108b00664 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
@@ -586,6 +586,11 @@ eeprom@50 {
 		reg = <0x50>;
 	};
 
+	eeprom@51 {
+		compatible = "atmel,24c128";
+		reg = <0x51>;
+	};
+
 	// BSM FRU
 	eeprom@56 {
 		compatible = "atmel,24c64";

---
base-commit: 710dbb13377c80a6e39ef049a517665841e3221e
change-id: 20260302-add-new-eeprom-node-78a20a7c4893

Best regards,
-- 
Colin Huang <u8813345@gmail.com>


