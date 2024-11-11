Return-Path: <linux-aspeed+bounces-114-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDFB8D2E9CC
	for <linux-aspeed@archiver.kernel.org>; Mon, 11 Nov 2024 09:46:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xn4S038z8z2yYy;
	Mon, 11 Nov 2024 20:46:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731318368;
	cv=none; b=SLj74DbjW+G7psreqmeunytIVI4Zb9QlsZlyG+WMmSlXtC1a+cYYHbeQkb4G4ewuQo0uAfiBSpSZm3e8JiriZoWyScYSPq4Q6dSd7vR6vzCLG2nhMNT5NQeeMRxFEuro3+bBWEQwo4JEWp8h8ZyJUBc0b9OsCYJUaFlFF9giqRQ+eolw0NintvHAn7uLquD/TB9hrASh7owrWm8J6qKg77sELj5Zr3lo4TYQOkRTeLKGq/3t4xbHXiA/1ySUXIYudOLsPuntp5gOChxghwEQrR2Lp+KGFg7CoPpvqxiG1dFEUkShrnhgXkDEHwuC/2Vs1VUEsyRnOAiEj9JrUlsByQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731318368; c=relaxed/relaxed;
	bh=eNks32tb/xOghmG+mNYQSKO0C3AuMd7n2d+nPZVJVl4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oJPiLy1L1vap6gfDF0lsFMovuKkFn2METZkebk/G+00lGfbfBxj1fhssYRLVMK0LmL89mzPsi0kJDw5ead4RfzgCnXH0K14WlZlURA/vrH6XGEPlP8WtAhinMNCcE2bjAxT+Sl5HarraBLSPDU9hNXwkZTM4ihF8EpBC+DR/r4E489acLqA0kagHR2M2TO8bnIDi7YfvPF2d1+Ho/1XJZ719Yowk0y0qo94/kGa7td8ImEkV5vx7huCyaFG2DAxr4Zq657p9nf+WHv2JrhzC+axvR/kknJYR9zeGKI8qcaABxa2uiHt+mxiskTSwmoPH2LMsAGHCNy2eSwV06ZHlyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=U6G/vd5b; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=U6G/vd5b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xn4Rz4lFRz2yG9
	for <linux-aspeed@lists.ozlabs.org>; Mon, 11 Nov 2024 20:46:07 +1100 (AEDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-20cb47387ceso44133485ad.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 11 Nov 2024 01:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731318365; x=1731923165; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eNks32tb/xOghmG+mNYQSKO0C3AuMd7n2d+nPZVJVl4=;
        b=U6G/vd5b7wyIG6Kb54epd26Mqpwpt7kSZVLHmbv6+vA4nGWrgT4/eo3woUGvz7KyWM
         ZsVHCZCS/TxymCrBPcHxdjgw4JwiSR9t+l8363fcT5y+IuDgmd2Mnnf+b9epYLmvFieg
         DeihIMAeGaBM5repx1ffHcXWDDb021+O2D0xBPxT1FDFKBJ+UdvFfKiGKzkBy+LazJ5g
         cPy7in3QUpXcV/RiFaFywMTskmNqUeR+3mcYzxlN6zC2jZKFSaRSpqIt3mAmz5KNba2E
         eNMlvjUhwAImeJA2qtRdb8nbs6JYsCi7ngkHpgIbJwudkvirhZ9R9RdwQacYlJLckNXs
         yvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731318365; x=1731923165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eNks32tb/xOghmG+mNYQSKO0C3AuMd7n2d+nPZVJVl4=;
        b=XhUNCm54PmvOUEKUV6bzFc6fupZOuZ3SzmXF3r8uTlga1wwRtT2yK/spwrEhDFw+GJ
         lsQ7HZBrbwg2Ei6gtkfU+ZF4s0eRzSZOfUdRNSyDVpx9CxETDa/2CJPsvqBTZY3jvu4t
         qsiklDHdcfdNoAEnljwB5vbhrUb02gJ0JTZiQ8FZTrPCT5dwQPKbWcMuLh0tnH9FOCCH
         t0g6u8/yK3IFZqG9VsOVvivzDOOu19FQIfIaSVAPrmndjkvrmkuvMYmfpdFdGFfTOdNX
         6I1q2hcAclJIC2eEOuEGQVGZF661L7U+xzhLB/RQKOXz0Dn6ZhBqeD6IvafzhqY4nHXS
         TakQ==
X-Forwarded-Encrypted: i=1; AJvYcCUenbryuB/iW68mVjLfdVmjLhpyrBPMWNNAaoBOMOFBUmmuwmewUBQ0wvM2mznHlKwr1gTarPoUdaBgqEE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxYYXx3YRyrybLeLB5/Ek0KdW93iexyFlhNEGuJRUgBeBAy03Vc
	B5744ssl0fq73++yvTf5HdTPj2oW9DO2jhBEWvhCsNHiAEQZBEa3
X-Google-Smtp-Source: AGHT+IE1c5elCHCi3OEQodIARSHjGMgZMZMY65tQlUc5wZSO5OedFsdVLtGbaV9F3x5W+AiCReKDzg==
X-Received: by 2002:a17:903:2b08:b0:20c:f292:3a21 with SMTP id d9443c01a7336-21183507b88mr163069235ad.15.1731318365569;
        Mon, 11 Nov 2024 01:46:05 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc826fsm72248725ad.11.2024.11.11.01.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 01:46:05 -0800 (PST)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/5] ARM: dts: aspeed: Harma: fan board io-expander
Date: Mon, 11 Nov 2024 17:43:49 +0800
Message-Id: <20241111094349.2894060-6-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241111094349.2894060-1-peteryin.openbmc@gmail.com>
References: <20241111094349.2894060-1-peteryin.openbmc@gmail.com>
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

Add fan board gpio io-expander to check fan board status.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 9d7e7208562b..58eba5fb6262 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -218,6 +218,25 @@ temperature-sensor@4b {
 		compatible = "ti,tmp75";
 		reg = <0x4b>;
 	};
+
+	gpio@12 {
+		compatible = "nxp,pca9555";
+		reg = <0x12>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&sgpiom0>;
+		interrupts = <116 IRQ_TYPE_LEVEL_LOW>;
+
+		gpio-line-names =
+		"","",
+		"","",
+		"","",
+		"","",
+		"","",
+		"","",
+		"","fcb1-activate",
+		"","";
+	};
 };
 
 &i2c1 {
@@ -273,6 +292,25 @@ temperature-sensor@4b {
 		compatible = "ti,tmp75";
 		reg = <0x4b>;
 	};
+
+	gpio@12 {
+		compatible = "nxp,pca9555";
+		reg = <0x12>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&sgpiom0>;
+		interrupts = <114 IRQ_TYPE_LEVEL_LOW>;
+
+		gpio-line-names =
+		"","",
+		"","",
+		"","",
+		"","",
+		"","",
+		"","",
+		"","fcb0-activate",
+		"","";
+	};
 };
 
 &i2c3 {
-- 
2.25.1


