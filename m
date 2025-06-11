Return-Path: <linux-aspeed+bounces-1383-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8826C61CE7
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Jun 2025 08:05:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bHJB92vppz3089;
	Wed, 11 Jun 2025 18:05:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749629137;
	cv=none; b=il3l5KhnHHQdKADj0NMgAW9RORJZuEmQFEwPCfPhG6D2dL1IBSWgsw7C7HWVnHZuhoLKCEBXY1kAGiu6476FIdml07GZt0kYQehH6IWkGVlTBxEXqPV1xR2N94RZbtRh+pVzt8bBDiisF8f/lxY6hX3jUEDnO3+9/V7A+6qPuXzy/EyX+c7Q7VOi1jN6mgLOHiA02zuIi+H+TA94lKtI5iRIo3MJK+B1U5c5J8OO5iMblK0n1yRxdEEiVYQc+USRZx8nRTGx8vsUfIS2FXBf0lCa0SO3Bim7q8Hski7sf8z8UwweozQPeXL4UbRhnHKNrUbro8b6nnz0psJ5X42zdw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749629137; c=relaxed/relaxed;
	bh=/yiAY4Q83bBJo2+drko8BS93Fxqshr7ucprcwVtMnHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bThCGkCK/zqSfscG3gIN9v8g9dkcyHpoV6fgkAwjkdHYlHfJJ19BmDHHBJ/7fHXdUUcHyPBMf2hesFAwB/pI2tylArl1a+/ziybr9QVya9FSSjzxU2IzrawoBJZHl2wxlstSkdDosbzZsNKJYModAth2vfQrgVez7OeaUTcnLj6whU1XCfjY//SuoFR0D+ekNFSHqZ1Tf/LzwfvRhoZsPfH81Jv8kL1/pYH82voSWIOgR7zM+3FJbvJM8N3/GZLYzzlFwfOR9m3hOHHW2WhyvIcjOteCbek/yBUT6VjNAQvqVPCnXG7crdsRQBEEhsOxwbESQORQHRNnirf+nXZ4iQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=SaLwqhzE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=SaLwqhzE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bHJB85xHcz2yMt
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Jun 2025 18:05:36 +1000 (AEST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-23602481460so43894665ad.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Jun 2025 01:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749629135; x=1750233935; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/yiAY4Q83bBJo2+drko8BS93Fxqshr7ucprcwVtMnHY=;
        b=SaLwqhzEWFMlKR2KNZDJ61cllKt/zg0vTABMqI5BTwbdJiWxXngkhYLpa5ETTywixs
         K8rDluGW6SN4A+aT+JvWHhW03bZu4qBSF8ITMdrLprRqjDmfpG3oQ+9E6jo0KOFNUE+m
         /77nj17mz2lyJyxlCDsXQy/Zvis3IYyRSorkx+lgvEGFTYJ88yC/RuEiHLZR/5/ewaHl
         YAZNNQa3u8Z5CbE0VrEIKuJID3YHjFJq9gqeT5NDCsJcIGlS9s7FXSaa7F28QlIK3Mzl
         OUqiGOWr/RpwU0ohVSO47VcTH1w0X3IqY56VFmPKZrF35gyP5jrVXdjz2Gvk2GwNfriC
         JLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749629135; x=1750233935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/yiAY4Q83bBJo2+drko8BS93Fxqshr7ucprcwVtMnHY=;
        b=UCHPlbEDkQ8JitAdZtBgz7j6hnh7QlL3i3hPJKGLyCZVcxDbCT15vJW6yS2/446K+b
         1Ck1p27GgQO/Sg29KcDpQMO7oPIlYLaHpAXoRam7lwBA7EgiwMDWm0O+lSQkBHaIk02g
         374QEdFaaj0WjL9pXeMmCk+DjjYq1bJRhGXcGjUj3t2E2NGZ7oEeHa+yynUgQQcnwIFm
         HNup4TFiAXJb+apXZYhtFMgEdGKSSTRduwFvL9qAaCYozmWsbV0cUOWlGkLsHw0FB9oS
         Ez/xlPuG9Nm5xUNDlQzDEk7Ws09XxHO87wCWpViG37KYaRbZFm9Az0/Qe3D6Og0H5/67
         h/fw==
X-Forwarded-Encrypted: i=1; AJvYcCUZ40JPQybAP9HUZVaYKyKtQ5FVoB/B3diU7VGlX7C83ah3ELQQ/wcBPBVfmhCNYFCGNVV5DzJ5NADpT/Y=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YygGzDRmsIpxitfzhdOEJy7dlYE4G3SmEZhcYfVFlQmILMelIRi
	LEMXoInZMHBRTCrwp3p+HO18GkvUwVztntTt1TAEfKD0KTiDDlFwNmaa
X-Gm-Gg: ASbGncsGjZ/dq3h7Qk05haYI0J0e6wgzVaEX6whEo3NXvRXEcM8NwhmP8ZEfJ2DV1H0
	BNjzP2O6kz4cU8lDv5gjCgwmDS++W/xCvAXckGGPdxFmUPucu8Ukr085bDcCT5yvD7h8v+Pk8/V
	s6qoam/rwocYdea/esDZRoV0OcQHsqNmCDnSh0WjlAQ9wDblpmFjKJVzMLrorzgmOcFf/1OtzTv
	/XMvAdVxcI8sDiaWgC932LuMjr+eCtZDPvlKIW2HVJv1hBO8i0XYTzzipzggFB6AseiGwMuakCk
	h81AOyR5jePR4TQxbQ6CRJFgmEw18bHWKNfd1j9wfeOVVCGvZkuGod2wuCczdJDiJlPPeA+gC0I
	Z2JcyavH4uAY8L4taKEcfdqQ0XGMrRnppKSjoeMguMlA4PehdDK4lqyOauxxhbEATO56B5ZEc1S
	BfJzPR9A==
X-Google-Smtp-Source: AGHT+IEzwF+A+5L5D4Y4qNQiMWPC4Srdbngbqeik56tXJV3s90XynVUFJWSxoFJi+YjtiMgfTeH52w==
X-Received: by 2002:a17:902:d60d:b0:223:4537:65b1 with SMTP id d9443c01a7336-23641b28de4mr37862505ad.36.1749629134891;
        Wed, 11 Jun 2025 01:05:34 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e357-b8a8-7759-271d-6134-9aa3.emome-ip6.hinet.net. [2001:b400:e357:b8a8:7759:271d:6134:9aa3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2363ad90982sm21283835ad.220.2025.06.11.01.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 01:05:34 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: peteryin.openbmc@gmail.com
Subject: [PATCH v2 5/5] ARM: dts: aspeed: harma: add mmc health
Date: Wed, 11 Jun 2025 16:05:14 +0800
Message-Id: <20250611080514.3123335-6-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250611080514.3123335-1-peteryin.openbmc@gmail.com>
References: <20250611080514.3123335-1-peteryin.openbmc@gmail.com>
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

Add a GPIO expander node at address 0x13 on i2c11 bus
to monitor MMC health status via a dedicated GPIO line.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index fb026c8fb0ee..b9a93f23bd0a 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -454,6 +454,25 @@ eeprom@52 {
 &i2c11 {
 	status = "okay";
 
+	gpio@13 {
+		compatible = "nxp,pca9555";
+		reg = <0x13>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&sgpiom0>;
+		interrupts = <222 IRQ_TYPE_LEVEL_LOW>;
+
+		gpio-line-names =
+		"","",
+		"","",
+		"","",
+		"","health-mmc",
+		"","",
+		"","",
+		"","",
+		"","";
+	};
+
 	gpio@30 {
 		compatible = "nxp,pca9555";
 		reg = <0x30>;
-- 
2.25.1


