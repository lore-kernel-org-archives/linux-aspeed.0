Return-Path: <linux-aspeed+bounces-98-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CA5D4335D
	for <linux-aspeed@archiver.kernel.org>; Thu,  7 Nov 2024 12:42:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XkhYJ26GZz2xYs;
	Thu,  7 Nov 2024 23:42:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730983348;
	cv=none; b=d3hXjkv8hzBCdiBsLPoBAJb738Mfe9uNtjoRr6l3VVo0gHoNcmDxvEykj5r2YH733hnkZKwfavCP2KyPu9GNS7vWy7kcJwsPoa27YhklKzC/jrRnSCCAFnrmujyHV4a5JkzqHPOnrA0miuFJbs5h0954yfqiJkLod4mpSw+BcKoO5NSzXiFeQi+mx9D64GlFcfbQjduwV9Z87KfuD/WCVeX6zxleL0dk9knFJ4AZ6vhkcZXdFiJiYFaWXZVOBdXUQIqMZX+nn4lSLAhED4fkZTZywXNTZ+PU4Gbx7sO+zm3o3LD5VRsp3v7qHMu+EUpJM6KUnf3o6+4rRmp3BCMzDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730983348; c=relaxed/relaxed;
	bh=1lFEM2XRj+4jfdUpSmt8rXreEAc43KfUaW7x9In1LlQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kBHAxnXlVgwzRl2/oyQcH5eVHM24uqAioAdDdMQWPovK8Y9nJTOd2xLRxlA8BJM8TvazC1y6g7HS2WeUOEEKmjrYd2weeIDmR5aVr8dU7mm3tdDEcZVkBiL24otjRxKLicZQX6ucAdX0U1yjXk7I5IlU5uLe3/CXDMSZ6quO438CFixFgpVMCY4LilSTQZXVSD9C/UlFBmoxIGfj9xLNYgyh1iMhcJaHNf3+gvolCZnN1Bl8oL/UeLzribLJ/bV2JxwAVQkgQEDKCIdCGOYwN2NqFoCrtPW7p4Rz7h5A9YyRVvp+FCVp1k9FBKLmjmmcejiJx3p+ZLun0O6yNi+cMg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bvKgF+jT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bvKgF+jT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XkhYH4FYVz2xYg
	for <linux-aspeed@lists.ozlabs.org>; Thu,  7 Nov 2024 23:42:27 +1100 (AEDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-207115e3056so9212515ad.2
        for <linux-aspeed@lists.ozlabs.org>; Thu, 07 Nov 2024 04:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730983346; x=1731588146; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1lFEM2XRj+4jfdUpSmt8rXreEAc43KfUaW7x9In1LlQ=;
        b=bvKgF+jTnwmv+sN0oZ0XZiIyfP6XMJezeSiYqsIMu37tAXi9/4wN1CDfdGUS8+Uc2M
         Ngs9N2xOe41ZIiXT5NGApzRlJI8APuA7LR2cWSZfCdkbXFki+e8fXEqrnzUhqNfQM97z
         hEKdgJpsShMEX4NKBV1LvnPDqcfEG4EBd2+KczB07qdMqn0hvDByP0mcw4Q4fAVepSfj
         HuzxFHmrDDEGqmZ09qS9JD2WP3OSkZABKAzDPddpmvwRzj0S9RHwToAC6ljuwdXuJod6
         4uJNa3zsd4R7CXkGqtL/KkIAQCPzP1kS3dVvJUBekk9vH9sfcxdZOY/lhoIHDUZKwlxb
         FPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730983346; x=1731588146;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lFEM2XRj+4jfdUpSmt8rXreEAc43KfUaW7x9In1LlQ=;
        b=SS1cB43Z/58NOoSe2pQrW4XrhynQxxW9xaeJzT4DVxlvLcVm+isHhQ0o3T785KnWn6
         o5IJ276sKKWTHu73bP80leA5kzWXg2xc26oIcwKhyTXmnHYHGnhHwvVeRmk5uKIdIofj
         vMj2ZDJ0h4AmnrXAicj2cNkXYCBuzVVjHXeMrxQwOjQOUX+bl++47QpT/v6aSN+kU9B/
         dg7zJ7I19tPW7xVuUkUtw3cuhuHNiotGbqFQS5n5n1sjwfNKdj7nUIeSRno3XMcMMCnV
         thv4To45p/tmUbe0cdPEXV+UeRn6BQW0/qUZgVwYIWGy1JW1UGrR7brEPZQwU7wV61/0
         zEUg==
X-Forwarded-Encrypted: i=1; AJvYcCUqtPHV/qMUB4cGCP04Taugxhi4WxdLn6J9jk0REBitFnMZnqgqQK/0k0oP1v4rd/eIorZnx6ghbY3XKkM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzIgPFCYB3SB5J0LICSYZhpAt2eLAwl9nl2KCG9HL6lfL/hJOkU
	e6gMIBEeKfssqKyfEvgfTjUSje3DOH5BwKDqeeS+wrPlnpHqL7iy
X-Google-Smtp-Source: AGHT+IFuD+Xx2XTx19q908xHLwUL9xed5Q6pQGCkFR2QHhE8PIBdNyA98Icm/09ejWxglfMpDVTuYw==
X-Received: by 2002:a17:902:db0f:b0:20c:cf39:fe3c with SMTP id d9443c01a7336-210c6c34824mr585270765ad.41.1730983345945;
        Thu, 07 Nov 2024 04:42:25 -0800 (PST)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e412d8sm11101975ad.113.2024.11.07.04.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 04:42:25 -0800 (PST)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 07 Nov 2024 20:39:58 +0800
Subject: [PATCH v2 2/2] ARM: dts: aspeed: catalina: add hdd board cpld
 ioexp
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-catalina-cpld-ioexp-update-v2-2-d7742eabc0e6@gmail.com>
References: <20241107-catalina-cpld-ioexp-update-v2-0-d7742eabc0e6@gmail.com>
In-Reply-To: <20241107-catalina-cpld-ioexp-update-v2-0-d7742eabc0e6@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Potin Lai <potin.lai@quantatw.com>, Cosmo Chou <cosmo.chou@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730983338; l=2806;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=YtgoH8nC8HzrEXlSjsTGbSqJDdm7lP26pU2kbrrMZgg=;
 b=fgk9z23oAMZdgTzX2DJ9eMhOC0Bh5c6Lmv07tC0TXF+/bgCq4twQdVIo5L2vKAQYhk41GZd76
 caMnNjnvwhLCoIWH3dRlsHRdQwMCRoERqqdvKvGDzODn4JHY73fjrKk
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add HDD board CPLD IO expender based on latest DVT HDD board CPLD
firmware implementation.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 65 ++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 10a9fca1b803..102d71234932 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -632,6 +632,36 @@ eeprom@51 {
 
 &i2c3 {
 	status = "okay";
+
+	// HDD CPLD IOEXP 0x10
+	io_expander13: gpio@10 {
+		compatible = "nxp,pca9555";
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(I, 6) IRQ_TYPE_LEVEL_LOW>;
+		reg = <0x10>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	// HDD CPLD IOEXP 0x11
+	io_expander14: gpio@11 {
+		compatible = "nxp,pca9555";
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(I, 6) IRQ_TYPE_LEVEL_LOW>;
+		reg = <0x11>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	// HDD CPLD IOEXP 0x12
+	io_expander15: gpio@12 {
+		compatible = "nxp,pca9555";
+		interrupt-parent = <&gpio0>;
+		interrupts = <ASPEED_GPIO(I, 6) IRQ_TYPE_LEVEL_LOW>;
+		reg = <0x12>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
 };
 
 &i2c4 {
@@ -1067,3 +1097,38 @@ &io_expander12 {
 		"PRSNT_CHASSIS1_LEAK_CABLE_R_N","PRSNT_CHASSIS0_LEAK_CABLE_R_N";
 };
 
+&io_expander13 {
+	gpio-line-names =
+		"wP3V3_RUNTIME_FLT_HDD0","wP12V_RUNTIME_FLT_HDD0",
+		"wP3V3_AUX_RUNTIME_FLT_HDD0","",
+		"Host_PERST_SEQPWR_FLT_HDD0","wP3V3_SEQPWR_FLT_HDD0",
+		"wP12V_SEQPWR_FLT_HDD0","wP3V3_AUX_SEQPWR_FLT_HDD0",
+		"wP3V3_RUNTIME_FLT_HDD1","wP12V_RUNTIME_FLT_HDD1",
+		"wP3V3_AUX_RUNTIME_FLT_HDD1","",
+		"Host_PERST_SEQPWR_FLT_HDD1","wP3V3_SEQPWR_FLT_HDD1",
+		"wP12V_SEQPWR_FLT_HDD1","wP3V3_AUX_SEQPWR_FLT_HDD1";
+};
+
+&io_expander14 {
+	gpio-line-names =
+		"wP3V3_RUNTIME_FLT_HDD2","wP12V_RUNTIME_FLT_HDD2",
+		"wP3V3_AUX_RUNTIME_FLT_HDD2","",
+		"Host_PERST_SEQPWR_FLT_HDD2","wP3V3_SEQPWR_FLT_HDD2",
+		"wP12V_SEQPWR_FLT_HDD2","wP3V3_AUX_SEQPWR_FLT_HDD2",
+		"wP3V3_RUNTIME_FLT_HDD3","wP12V_RUNTIME_FLT_HDD3",
+		"wP3V3_AUX_RUNTIME_FLT_HDD3","",
+		"Host_PERST_SEQPWR_FLT_HDD3","wP3V3_SEQPWR_FLT_HDD3",
+		"wP12V_SEQPWR_FLT_HDD3","wP3V3_AUX_SEQPWR_FLT_HDD3";
+};
+
+&io_expander15 {
+	gpio-line-names =
+		"P3V3_HDD3_FAULT_R","P3V3_HDD2_FAULT_R",
+		"P3V3_HDD1_FAULT_R","P3V3_HDD0_FAULT_R",
+		"P12V_HDD3_FLT_L","P12V_HDD2_FLT_L",
+		"P12V_HDD1_FLT_L","P12V_HDD0_FLT_L",
+		"HDD_23_PWRBRK_N_R","HDD_01_PWRBRK_N_R",
+		"","",
+		"HDD3_PRSNT_N_R","HDD2_PRSNT_N_R",
+		"HDD1_PRSNT_N_R","HDD0_PRSNT_N_R";
+};

-- 
2.31.1


