Return-Path: <linux-aspeed+bounces-4650-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A153C5AC82
	for <linux-aspeed@archiver.kernel.org>; Fri,  7 Aug 2026 08:32:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGcp41f6bz3c1Q;
	Fri, 07 Aug 2026 18:32:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::433"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786091532;
	cv=none; b=BKQ47TjXKyYx5NM8xWxfmhJqX3yrZIIW6d171Gyz9zKoLR6bfBULzjvtx4cBrw5+EzpLrSzoV+c8p2IXxgACDoxqd9mvygKBHMtYlFUNqNypv+M9F34exXwHJa1+FJd2Yeejqyhs8SLHV2hQmGxSjRlExglltjq38t0BDyo/GPm6XDwXhLo2OrMF+kQkYHkKY/uabxWhoBIrRhKlug15i0vjuGduepX4IiybxI/0sZQOhGDsnvBFC/7Nhg2Zwbdi9q8Z4LgJnIfGqX1gHvMjyKrf5rCUP3hmgZ5p+TlUL+RjuL0sHsk5cgGJ7t67VtJWH726DKQjPNAUczrFbu1c2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786091532; c=relaxed/relaxed;
	bh=3MesJTCCNQlP4+x64Hx4yUyNd9X6ssapmn5zWFOTB7M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KSnWT7/Vov5YeDbWnkTNfsQegasE2ECb2Yuqbx15e7W8mMU3Y9j1qfulSNGxDrxZkVFyTk+rd1A/iUnzFsxnL9iMrzCCNst1hora/uWhqYSnpT9NS8A4UUBVzaesg6TX+kCq76WQQqiT0Jh0sww2A1QKuIHj0s1nkzE3M/5v+KI8BUEulaj/AaXokRFgL6MFoLg0iEeEXDlnS21FT1MfQ0eRSOIdp91F5uTRlr4FCHcZ1wz9pMOJCHSpcJ8sslCBOcu56ua3hbznl8U3QGnHqg3YbAtmLD3PJLN9Z6zYJQE3tFi6XFUp7Vc3k/TxkB90eoHua8u0oe0XHEX/t3Cf1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mPwftwzi; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mPwftwzi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGcp3440gz3c1D
	for <linux-aspeed@lists.ozlabs.org>; Fri, 07 Aug 2026 18:32:11 +1000 (AEST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso3883639b3a.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 07 Aug 2026 01:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786091529; x=1786696329; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3MesJTCCNQlP4+x64Hx4yUyNd9X6ssapmn5zWFOTB7M=;
        b=mPwftwzioNI3RmuBjBbdQYPU0C5nzZCnPDZlmzTaXozohArUvbg+jJhF75ctAxTusC
         2SlQB0R4jRjHQ52COHaqEtztnpcZ6cD9jgnMctexSeilzk5KCRE2mW0Vfy/H0+1cFP8l
         YxjnB02Nrs36B5jzkyo44RQ9v+eaX7OVoE7h6DwsRVJvv3L2ZlOTTeo7dx4QmG0DMnL+
         gILHtacl819XUbYUJ9XlKB5K/M9qfjbfpO232sD3oBmKn0WMDtuVwyan5W7CPkwe6im4
         XOWZQTHKFS1mehuO+3LnD0Xg7wU5Gs7/CCA8+MWisIV69mfA2+5o0hCeptKaeyPRhvX9
         7EXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786091529; x=1786696329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=3MesJTCCNQlP4+x64Hx4yUyNd9X6ssapmn5zWFOTB7M=;
        b=o7UpooFWxSqm7uhuzwQmm9n1Nb29YlpoQ3p4ro0SoVbt06hYGe8A/qw+Z4U3KIGVPB
         ubN2qjoWr+0RBUFenP9KIorfTEhfx9B0RtIgH4lRIY5GxqY8YHYdVeGHBNyFcF8f/5Xk
         PfRWML17xelbSdyEJ8GnREZGo7godh1e6KU7NSCxfZ7vVtt2NYEMIED5oaug3UFVO3Gw
         GQBYK7xciBF/6w/tN61cWhkQWYfpp1sFcrgtDiFHWCRue9tw8vd9V7DjPH0mJahOFg5U
         T1ihXExsYqC4PLpNbzY2t3QgUCF8UZVtKGDBjTP7PqmsHG7EZRxWSJ74ilrelbqWSV5M
         d9OQ==
X-Forwarded-Encrypted: i=1; AHgh+RrXrKFkqeVrqlZRLPoSU19Iqandtk0bOC5AQ1vitcClvyQpadu4IAYY2yrYq36N9gnUGNIdUSEv2A808eA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyvZfk1jFlB3ksHGImNJc4z/WVevTFmsSQet9J3TibmPG/K2A+F
	9ZoH1j8WqVlTJCNgiEtO8yzVJLfGm+EPJTaPEqvyKTYR3JVA5ortqcEp
X-Gm-Gg: AR+sD11z+kL8sVBqx+oC5EfRh3IaJAdGZ6q63jaEVOSfwTaNKJQK/PlMvkjxu6mHLlr
	DEXKxXNqJR23qQGCv34NyFPGe1ju2qYzGMrs3nforaZNXStILBrPTSWq7KFb9AaW0tJ+0SmYklI
	BkIOMkFwD62+sZBYsugmXg/GmToWDcy3jGqNsyCC0+OpAm31Z/keTANLOvajRHLtj3nbsD33ilb
	UMKaI6cwxTsg3nfWZWy2U75Ahvnj6yBuD+NdxKJA/w8I8WoHyPh7hug8GXC9c+8J8h8qLBkReo4
	zU1m/QHpAzXireLIBL4lJtWkdrP4WH1PEXzoyDiYM4bnBi4vCzge+t/tpk7xwhFoGGYNqxuM/sS
	q3syHrnr/1QP4iSBBDcNP3lH/9uO9S09v2iYrgBar52NTTppyvBtIL57e8qfOmG+KJ63u8JSC3L
	lKPC1ER2QysebSQGvajG0oAZBfawh0xEt9JfHzz6r0Vgy2cVq19rdWKdW5L/YJCu5m/CltCxWbN
	d7BtEdkwh6Px0sZopNSdPj/dJPxw+kaFJ9mPHX9D0jk7i1ZVw==
X-Received: by 2002:a05:6a00:3d54:b0:847:8b1d:230d with SMTP id d2e1a72fcca58-84f2e014151mr23029742b3a.3.1786091529420;
        Fri, 07 Aug 2026 01:32:09 -0700 (PDT)
Received: from fred-System-Product-Name (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a553071sm627409b3a.43.2026.08.07.01.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:32:09 -0700 (PDT)
From: Fred Chen <fredchen.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] ARM: dts: aspeed: santabarbara: Add leak cable present IO expander
Date: Fri,  7 Aug 2026 16:34:08 +0800
Message-ID: <20260807083415.672008-6-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260807083415.672008-1-fredchen.openbmc@gmail.com>
References: <20260807083415.672008-1-fredchen.openbmc@gmail.com>
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

Add a pca9555 GPIO expander (0x22) on i2c6/i2c8/i2c10/i2c13, one per
module board, to expose the PRSNT_MODULE[0-3]_LEAK_CABLE_R_N line used
to detect whether the module's leak-detection cable is plugged
in.

Signed-off-by: Fred Chen <fredchen.openbmc@gmail.com>
---
 .../aspeed-bmc-facebook-santabarbara.dts      | 56 ++++++++++++++++++-
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
index 3d35a5a74104..ca5bd805d975 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
@@ -641,6 +641,19 @@ gpio@74 {
 &i2c6 {
 	status = "okay";
 
+	gpio@22 {
+		compatible = "nxp,pca9555";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&sgpiom0>;
+		interrupts = <150 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names =
+			"PRSNT_MODULE0_LEAK_CABLE_R_N","",
+			"","","","","","",
+			"","","","","","","","";
+	};
+
 	// Rainbow0 FRU
 	eeprom@52 {
 		compatible = "atmel,24c256";
@@ -866,6 +879,19 @@ ipmb@10 {
 &i2c8 {
 	status = "okay";
 
+	gpio@22 {
+		compatible = "nxp,pca9555";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&sgpiom0>;
+		interrupts = <154 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names =
+			"PRSNT_MODULE2_LEAK_CABLE_R_N","",
+			"","","","","","",
+			"","","","","","","","";
+	};
+
 	// Rainbow2 FRU
 	eeprom@52 {
 		compatible = "atmel,24c256";
@@ -1106,7 +1132,20 @@ eeprom@56 {
 &i2c10 {
 	status = "okay";
 
-	// Rainbow3 FRU
+	gpio@22 {
+		compatible = "nxp,pca9555";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&sgpiom0>;
+		interrupts = <158 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names =
+			"PRSNT_MODULE1_LEAK_CABLE_R_N","",
+			"","","","","","",
+			"","","","","","","","";
+	};
+
+	// Rainbow1 FRU
 	eeprom@52 {
 		compatible = "atmel,24c256";
 		reg = <0x52>;
@@ -1588,7 +1627,20 @@ i2c12mux0ch7: i2c@7 {
 &i2c13 {
 	status = "okay";
 
-	// Rainbow1 FRU
+	gpio@22 {
+		compatible = "nxp,pca9555";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&sgpiom0>;
+		interrupts = <162 IRQ_TYPE_LEVEL_LOW>;
+		gpio-line-names =
+			"PRSNT_MODULE3_LEAK_CABLE_R_N","",
+			"","","","","","",
+			"","","","","","","","";
+	};
+
+	// Rainbow3 FRU
 	eeprom@52 {
 		compatible = "atmel,24c256";
 		reg = <0x52>;
-- 
2.52.0


