Return-Path: <linux-aspeed+bounces-1858-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC49FC87FCA
	for <linux-aspeed@archiver.kernel.org>; Tue, 29 Jul 2025 23:18:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bsB9T0t40z30Wg;
	Wed, 30 Jul 2025 09:18:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753780445;
	cv=none; b=GOYEByTsLd0124R3kD4mHqQNgOH4Ai73Phglm92VBxxtqCNM4tTlYHDm8Vm4Qcgtk/p2woPJB/NZZmXIkXUmSfWuSNYRJm6VxEXXwE1Nuf47Q2TZHsAYAVZ1zHQQriqUWPF55u4ea0PGRlAIrqCXa8oyhMZuajMjyIiEbLNBdwuMOfMe0VZQNM3eXO2tfHP6P7pA5P5oO4Lj9YqY9zH4lMHsOP1xG4Kv1blROeDlYbEcasMTBnDjs/lFj4BZKwuocr1W7qfjXXvr05S8x9Cb5BEb2b3mSE5pJofSBpqWUT0lL7LvCkG5QAGgWCHmOpKqcOczLeW8uG+RVrrsL2LG8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753780445; c=relaxed/relaxed;
	bh=c7EPaE2bHAD0ecNNc0XMu907yYWecMKnydM+hyTx2ZA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vxksr4zXkExv4Z7+0jlzu8Aicnmi7viQ2pR5Ip+RwmzRi3Z8oIA9xlS7sLEADmC4jEixpgQUvrHz9dmHFqFgnid5V24Eowt1JHsUArs57Gt9C7xKHquBIk35UxJEdtLpW/BBYEhw5VeJ7AH+n97Z5GOCrfypR4BEM+todAbJ0KHkjnHX1yIiizxNlS/cM0o+0RTjQetfkWHm+RW+BvCtSQY2SysPenJ5LDMxGGnv+xcJhbv777D3dsRK18hYAUX+b5cM9DwWjaqIMMFhfPsiVeGu7oArfVbsh+d7YATi6MY9yL7ajdWliwgEwrNuMb0RZWiJAUEpkma906prSVLdvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Op2qews4; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Op2qews4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4brqR06WV0z2xRq
	for <linux-aspeed@lists.ozlabs.org>; Tue, 29 Jul 2025 19:14:04 +1000 (AEST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-7426c44e014so4539591b3a.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 29 Jul 2025 02:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753780443; x=1754385243; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c7EPaE2bHAD0ecNNc0XMu907yYWecMKnydM+hyTx2ZA=;
        b=Op2qews4AQTnkofym23c306GvOjjFNUCFaGZu49hnieD+kY3Sr7WL2e+jJTfBgdSYA
         Iniwh+VRTgoS/VzjIj9cCYb5VjItsVcmXTLZTfIrsimyZgMVxZKhCOh7lmmEbq/p4zqC
         4lY11Cgj+qzd3B/D4ddlLBdT5VzySMQFZ5I4n1YwHMMv8e9IFGSncce7kgOTjRxGIcVY
         FQ7e8YJ4nmitSymXJfPqZ6iVGDRiZ+5oq6E//hdtA/3HGhm2JyIiSdxOSWVJHA9JfNj4
         93DGlG0AmEmf8Y0lEQb++2Dvo5q5OK0RRQQNHbGjphcaR1v7uZSyd/lSAUKVjwWXRjRF
         sk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753780443; x=1754385243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7EPaE2bHAD0ecNNc0XMu907yYWecMKnydM+hyTx2ZA=;
        b=mPQsw9ZR3rNC/GJuyMHg/esqkmMXh0fSDP/pv/HjITYe60HQZj8U9CX/6LHAY0LDrO
         +1xp4kRcPdmBNC2c6O3PucFGrjoV9Vj51J/dXRwqEXnilWXhkXXcBCn8qS/zp6rnR4Ia
         /MogPv9RGPsVVY+JRwWEwt8ZaHCDiUh1vjIL9kRRzLz6H+Pqvg0eXL0s9TV/hAaQ1wpb
         cF3zr3aK/cA5XNPwDS39qP/eRaSj10f22v8An5RKj9deFGPoymYWTC9LekT9gEQL7WjQ
         2lV+UsPeKFAcz+s5Y9t+i/w8uj/WDihmnJJvGCmhpjMWioRvuS4U9v6HS1hrbdIF9ROc
         KSSg==
X-Forwarded-Encrypted: i=1; AJvYcCUAmJtF1OcaFAEmMu9lKSjSavb0BGhAe5mnQdXhhR/kHikfk+mab+QAGrN/STCgwz6fpyfT1oNOElmRdWE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwpvkrZL3IvF0T+IhKpNmFffvDDGDoOpchNr6F8A3okTxhjni3Y
	QSdMbCZ5Q/VrlKmAbhfDEBKXIgYF3JzmjQN23rIXJdWkHhtM7TIjv2DB
X-Gm-Gg: ASbGncsNjegwIGAQXMTW22RqUbDkAU3Th2u5AJqYrsX0v4suYX4+kBdtxV68uhHaqSu
	FlLJhd7MafmgCwRmP1Fouz3YL1OLpaaloVAco7dwN+EKQcgmCwv1tD3ULBAFZ8IIq94t7IIg6+N
	02BH5t4NFvv38leQDryzHUDbSm9poeMIywSyeTWWNhbj512yc3XHFiTt5qf/K3j+As7xv6m+tKw
	4gL6kUnM/X1JeXUpGSIP40Fc75/TjEMKIt/0FTW0UxFdO6rDc06QiOFzQnbV2zHsBT9mghqEhON
	rm3K5P7j0iH0NRG/tY6MckwDgPO4nA3uYie7j4+KqJ242W6rmreZEAajZmteWT71AraWEvXZ4Rp
	2v6HppvAFgAtJn3hkRX1yIdS6SiSC4AdST3Q79eHm5rQmo8o/I7FPkrAshPqiiyekyLuj7NxxdN
	21E8ribY3M5zZsZt5dDOTqkMwO1w5yMfTL+2C9EppsdnTDnLE=
X-Google-Smtp-Source: AGHT+IE5de0i6/0ajEO85aIFRHzPN7aXOAjUa8N7MjCYc6cFnhkPCLV7DX4sN98WfDkKcoDvsFP22w==
X-Received: by 2002:a05:6a00:a85:b0:740:b394:3ebd with SMTP id d2e1a72fcca58-7633276c2b6mr21066948b3a.7.1753780442892;
        Tue, 29 Jul 2025 02:14:02 -0700 (PDT)
Received: from fred-System-Product-Name.. (2001-b400-e38d-c586-0429-5c72-053d-8858.emome-ip6.hinet.net. [2001:b400:e38d:c586:429:5c72:53d:8858])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640b8b06ddsm7528612b3a.121.2025.07.29.02.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 02:14:02 -0700 (PDT)
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
Subject: [PATCH v1 2/3] ARM: dts: aspeed: santabarbara: Enable MCTP for frontend NIC
Date: Tue, 29 Jul 2025 17:13:44 +0800
Message-ID: <20250729091351.3964939-3-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250729091351.3964939-1-fredchen.openbmc@gmail.com>
References: <20250729091351.3964939-1-fredchen.openbmc@gmail.com>
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

Add the mctp-controller property and MCTP node to enable frontend NIC
management via PLDM over MCTP.

Signed-off-by: Fred Chen <fredchen.openbmc@gmail.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts  | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
index 2f5712e9ba9f..ed30f3bf61a4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
@@ -1248,8 +1248,16 @@ temperature-sensor@49 {
 };
 
 &i2c11 {
+	multi-master;
+	mctp-controller;
 	status = "okay";
 
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		label = "mb_nic0_mctp";
+	};
+
 	// OCP NIC TEMP
 	temperature-sensor@1f {
 		compatible = "ti,tmp421";
-- 
2.49.0


