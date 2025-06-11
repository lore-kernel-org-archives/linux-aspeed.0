Return-Path: <linux-aspeed+bounces-1380-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A6AC61CE7
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Jun 2025 08:05:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bHJB00X9Fz307V;
	Wed, 11 Jun 2025 18:05:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749629128;
	cv=none; b=lYtMwUIX/3SDHJYPpcfcg8C2IWHrg0+q/tuQm06Hljg8v3EgaClX2zoeoxamenSgwxQyWKj/L7xgAhxGvMEDdYxyjnQM19I+0img2fDC1ZKfvkiT+/Qcv9MlJ0Ols2+6h6LJt7wo9VjP02FUNHMy9kXEc5/mL622FKzKcr/3nqOaaSkSWpbkdkxUkVHgkePbFdzNR6iGW6hD4btrrJdlUHit/3GbPtYdkQHWdoCqL61ip+FssYr+6opwYJn1vI04eYBs7d80+kLmJVV71MHmmFFuUBPbzCPNSQ9DTqyZKFdIYu4Vy1T7soyUAwpf9HQ7bo4UH9ojSuhNHAcd58EFSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749629128; c=relaxed/relaxed;
	bh=hNzuAa/Uazdw3p5L2VOhfCBO9w/r53QUlAR5HnqCwzk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M51XwsjRZtjyitQpnHX/zlmPI1AJ7vqFckQPBKq0n/P+jRKveR8GMTmQMIB2Fo4EThKJ91lnAAktrBZNftyK92tCgnvnzlVykwdIgHJPcBuAtoLpKryhc89DmivRR69iXyZmRosEiGtF1t4scjKLLM83AmMgRv4Ek7EGZwpKN6+0o/e+0HsezeM3DFWxlCmIPxt8wMg9T7pppfBh8yRVbftz6yISvaHJYYLhBkmDDNriA9EucCSD+DW31Ff7qdzuhh/PDMlbNUcRi+qW0Cnb5kg7MALPLE9HlAJzIYN4w1aixaFr8fBO5fXBl1Q8mpOvbnpy6EqIQ5kyuhqZAI5x2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Gtp3VRBp; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Gtp3VRBp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bHJ9z35CWz2yMt
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Jun 2025 18:05:27 +1000 (AEST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-234d3261631so44706165ad.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Jun 2025 01:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749629125; x=1750233925; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNzuAa/Uazdw3p5L2VOhfCBO9w/r53QUlAR5HnqCwzk=;
        b=Gtp3VRBpqHP4qGeWClFYCShla/bGiUyeW81FsqJCr/lLbu38/FOaV0RIQW6t1JWBU4
         TkTc1D9fMdsEJoZIRsfq23k2yACbateg/nqUMk5+iFkfBDwMj04KY331kUfqabybOUQu
         ibxyrQ2//fFgcDqPINBynR7bQ4TSeOdqtLzs1aPIwGPnpaZWPbpHOkOCiHL7RqvhlX9P
         Tc2nyacZk1nNvhNaDsNERCAPzZ7gPQWQbn4y443O9EOpMNWOeTmUQugtO2Bwhyg5St39
         ezM5+jR2UQnOl05fgYjf1E4qgeGNbuZj0mxyqEzuKCO6jnnxE2i7uSrzjsASZ/vzp7tl
         mqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749629125; x=1750233925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hNzuAa/Uazdw3p5L2VOhfCBO9w/r53QUlAR5HnqCwzk=;
        b=Rz3Sha1reQDbMkAEm6Th5/5q4xfhOvm+oUY4VBps7yGgzSM8aJ/wxjgYri9WzVXBMP
         yi6G7DXudfnplROcgv9lwrRMK/GLhn1Vpcde/aFZqpLtjMUyRF/TOO8IyvRajk60dg0l
         zEjuyHibX6iRhyPW3zouSH2Ne3hEtX7w0PLQM1dYPyMqJLP3gyUOZaE5xOm3MfJLDuoO
         RyWt5hj1JtdEYfIjVJK1bBld0wh7Ipz+3vJHMby9J51whHT+jSbAOx1Tyv14PThQ6tOm
         glovgFlUzCpdZGfcemiiilEdJi8V9chE30bZA6/4KUICGyorf5JTUjcSLUCi4Zr9fea7
         yk8A==
X-Forwarded-Encrypted: i=1; AJvYcCXVVejXwSmzQPf//tI8wR9XkW40quIwuaEJ/NEtTJD4J26n4UFYRuXQd2ry6mwFJZpDXWo9+at45vqOs3c=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxzVuyY+aHu6X7DchEjzBoZp42GuTW8uRzuclElYosNPUM5ouBi
	EdCeWXXGZIoI23MPrko+sSrnfI1cER+Pz3Nn7iboTWhqP5UTcKCZAqsA
X-Gm-Gg: ASbGncs4ocbtNlXFiqBOTq52R/I95Gl0eDVkTQI6Snw+A0nq8BuNaOdL+qXZk41PhSt
	OcQ5KW6gGTWAflBMljHnhlITFgzPCK9iN40gI+5OgktEFlWuCiN8IEUkzVc+X/8NDzQ79Uc7XwP
	Rk5DTQQZ7piAL2O9F79VMWwZHjKl0DHpspvGQmkRxwG02mOIuFXdYuUYuvSupNKDdRbBKnJGnql
	dH/9B1DyG/RAqnSdpUihjaAifr41o/olcQSKjl1x2f72iM6xfNj7NABa19jpNtyqOGDnhJJxmFH
	l/uMWD3rlybFvJTdNc4KvekyCunOfaiLGurHMqOzpzOe4KDmflkzR0E8YAvL+74Cw9xnHuRoWa2
	SXXt6NBLDD1LqTVm/7mOFNh2+0+mSgz1IOQebDilrW3cQIJ5yHDJqeum9gRgV1fljl+1kkpbHpA
	PNvpDqdw==
X-Google-Smtp-Source: AGHT+IHoyKh/sH8/DfqDm6/YTmj58rUQ/xaund/2a2KvsOZBw+ZZaPMZVA4RQVLdez8ySceA+Rd2qw==
X-Received: by 2002:a17:902:ce0f:b0:234:8c64:7878 with SMTP id d9443c01a7336-2364260d248mr28868105ad.11.1749629125239;
        Wed, 11 Jun 2025 01:05:25 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e357-b8a8-7759-271d-6134-9aa3.emome-ip6.hinet.net. [2001:b400:e357:b8a8:7759:271d:6134:9aa3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2363ad90982sm21283835ad.220.2025.06.11.01.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 01:05:24 -0700 (PDT)
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
Subject: [PATCH v2 2/5] ARM: dts: aspeed: harma: add fan board I/O expander
Date: Wed, 11 Jun 2025 16:05:11 +0800
Message-Id: <20250611080514.3123335-3-peteryin.openbmc@gmail.com>
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

Add GPIO I/O expander node for the fan board to detect and monitor
fan board status.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 3a215bb1e220..344e20394665 100644
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


