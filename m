Return-Path: <linux-aspeed+bounces-2995-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8B5D0E6EC
	for <linux-aspeed@archiver.kernel.org>; Tue, 25 Nov 2025 13:59:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dG47g5PpKz2xPy;
	Wed, 26 Nov 2025 00:59:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::436"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764079183;
	cv=none; b=JLrKn5wmQswlloOiJPcN6L7vnyIc/ZrGkKcE40sGv3TvM9+K8/ROaW7/3jdN+NPe0e1eOsUNNYM3YQA2uItXpQH1Q5oGNE0pnLBQAjAO+hKA6uF2z28BQD80gSxlMKEEPkcQYJ8xVCDC6a5GBHkdRK/mmQzYFmBHLGx6mEqu4o3figCO/dLd6mvDeE0kuhr2xpBNaphLt0egMppBTcSNU5oXJBKqdXLnhv6OeaV3IJot/PmDSkVkSKvSDyFB1sBIS+cQAQ2qL9XyH9P+ISXnqsr9XEMac95Whd4VmpaWY0cQt9LeEU0LbeRZk3RtbsmnFrDTjas6svAo7h3yeJB5kg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764079183; c=relaxed/relaxed;
	bh=dVFssVMsppemE9LOnYuL76lIRte65ETPod7a5rRBKjc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0GyZt5jypu/ANti8vABtRp4zX8gy+B24x8IF93ww1zr2btsl6rf9yx7W7YmBXN0tLHnlHpicWtk6eHF4hSgBHe9wHjpbLALe337KnIewYq6poqKTHJYVQ5CaE2rzEir1znld3xcmtNE5glJTxrHN+89L+J5l8HxIB9XdU2IeBMSZ59pYmt6xgR/9kYvDINTOK7IeDkZ7KBgbqAria5T4eOSQEOH0Y9l47i2/0AadLcPAzY+yifDt3QH96DDzng1kykYUf9GqpvVXW+6H6u+ZEEiP/r8KeTiRLxavwmb2dD6sKVx+nV7n46W9Iz/CJ17C4g/wKF4MRk1jV2ct7XcKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=DqzOWjnR; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=DqzOWjnR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dG47g0jhKz2xqf
	for <linux-aspeed@lists.ozlabs.org>; Wed, 26 Nov 2025 00:59:43 +1100 (AEDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-7a9cdf62d31so6738408b3a.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 25 Nov 2025 05:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764079181; x=1764683981; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dVFssVMsppemE9LOnYuL76lIRte65ETPod7a5rRBKjc=;
        b=DqzOWjnRNaG/acF+nGJShebJkyHIzsFW80pLjHhJ70zNBdZ8Hp0QTI1+/x7Sqb6+XB
         h8bomrIohnFGoK4DywxTeK4wiViRpOKw5EYlRwllnCoicCLMfTVrXGRy9Xx8O8Emv3iQ
         k0FUZ1708Utx0mjGsQNqf5+mCUPinoy/f++rA+QgeRdr8KEePstZkUhom+b6xmMKBJ4Q
         zt8vG+YpuFNRYT91iE17qYTyc+lZjdcd155+Msk3xRJhxhCx0N+hiRpFDkhkMrnuy2OD
         W6+wGl3rt/23mlFs8R78MoYQcQmXs5rAXSNcxFNJTOGlQMYjfZt0R/OfUQJvBdJRK0JW
         USKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764079181; x=1764683981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dVFssVMsppemE9LOnYuL76lIRte65ETPod7a5rRBKjc=;
        b=ofi50uYV8XSY86D7DYnOmHtjaGH+q+nOKN64WoFrF0ChFwCbhdcBdvypCBffI/rYzl
         PY6zoJ0WNnAQMKDnDKFWU2EblY+b8XGJ92xFWLpm0U5o4pwoPA9KvH6ywvXy4ODE/ULH
         +D3pYxc1O0q6SJrW3Gd7AohQCuYcbQjUd6gZGYaoSoKqDk3JdT2OkZQjGvbnp6PZUVqf
         1p1o/+cRdq6reCcGHilu2HaGZimvSVMnntOCjleKuV3ZthCG5lmlS+jnBD7VCnL9rGVl
         ZLvgjPPG1e2nMeSx0+Jo93IQwqNDcXwDB61le4GL5v5H9Byd5Y+hOZ7RVQmB8bRxsh3U
         sp8g==
X-Forwarded-Encrypted: i=1; AJvYcCWdV96ftIe69VjC0PTDXLo2tOQnPyGDIJutAVS6q23vAcgNYZk5udTtvWdbwGiCqS3j8akIhxdWPVZkjE8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxt5AJYwIDan6p1XmeS3T/V6VanTHNfo0mRZW72lF6cryvDWAvs
	mvloYr6R0dT/1dahiZJkInENllKGZzhQbivFk2RVBda5qgjwPl4UZw0b
X-Gm-Gg: ASbGncvM1IEl5cEPjwhkbHvuK/3FZoeBPfVTVS+GIMhKyI+Udd4Jd86bH7KOqvqYvxP
	9iKT+OV+GPFYZX8dn+4oDcYfI4wYSDcRHZlMHcx0IU+pf65CPVaIFAZ2mWwk0FoChQshkXBFq8w
	iIPnXCoc11tfQaiCaiM+qHCdcN2KKtDOSDMqvt2FD4s+Li3lFlScDiRdHINlpA+KM12zgaFqQxn
	/hrzEdDJ3RtFa9bHwCJYiTtQiRxw2aIxPYmIiXYq/VgDtFyPLE5Eo8AT6tSKP1/tK+63EU/ksn0
	mcFcLnrMp+FTPL+g1SFYm0NdeKcqXdK6xeJ9qBO9jAZ3zflR51MOYU6xRGu2SdEjb6G5WhXaW6k
	rt0igr1R9pFfIZPw9GhnfGL3u9xsjxdRs4Uq3nABCZI+uHLI4NwOBtiAQAs76B+hRGpIBxP0i9L
	0RnRygggl1Ety4EN0THS89KSAf+TZGx5vDlLJGWMwOvM9eGRqlEZrRKHuNnHBYKJz9y6jrquKPt
	SA=
X-Google-Smtp-Source: AGHT+IEoiD8kKI6Top0lfEQal/JV1zBoB+qPW4yD9aP3atTXvknCMZhsSOAa24TqvLJc3MCbiSy7yg==
X-Received: by 2002:a05:6a00:9508:b0:7aa:9ca5:da9c with SMTP id d2e1a72fcca58-7c58e50cc8dmr15953870b3a.22.1764079181213;
        Tue, 25 Nov 2025 05:59:41 -0800 (PST)
Received: from fred-System-Product-Name.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f0b63dbcsm18216028b3a.50.2025.11.25.05.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 05:59:40 -0800 (PST)
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
Subject: [PATCH v1 1/2] ARM: dts: aspeed: santabarbara: Add swb IO expander and gpio line names
Date: Tue, 25 Nov 2025 21:59:30 +0800
Message-ID: <20251125135934.3138781-2-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251125135934.3138781-1-fredchen.openbmc@gmail.com>
References: <20251125135934.3138781-1-fredchen.openbmc@gmail.com>
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

Add IO expander emulated by the switch board CPLD to handle UART and SPI
mux control signals. Also add SGPIO labels with FM_MODULE_PWR_EN_N_*
signals, which control power to each ASIC module individually.

Signed-off-by: Fred Chen <fredchen.openbmc@gmail.com>
---
 .../aspeed-bmc-facebook-santabarbara.dts      | 22 +++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
index f74f463cc878..4312ead311df 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
@@ -1328,6 +1328,20 @@ eeprom@50 {
 &i2c12 {
 	status = "okay";
 
+	gpio@27 {
+		compatible = "nxp,pca9555";
+		reg = <0x27>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names =
+			"PEX0_MODE_SEL1_R","PEX0_MODE_SEL2_R",
+			"PEX0_MODE_SEL3_R","PEX0_MODE_SEL4_R",
+			"","","","",
+			"UART_MUX_SEL","RST_SMB_NIC_R_N",
+			"RST_SMB_N","RST_CP2102N_N",
+			"SPI_MUX_SEL","","","";
+	};
+
 	// SWB FRU
 	eeprom@52 {
 		compatible = "atmel,24c64";
@@ -1758,11 +1772,11 @@ &sgpiom0 {
 	"","BIOS_DEBUG_MODE",
 	/*H0-H3 line 112-119*/
 	"FM_IOEXP_U538_INT_N","",
-	"FM_IOEXP_U539_INT_N","",
-	"FM_IOEXP_U540_INT_N","",
-	"FM_IOEXP_U541_INT_N","",
+	"FM_IOEXP_U539_INT_N","FM_MODULE_PWR_EN_N_1B",
+	"FM_IOEXP_U540_INT_N","FM_MODULE_PWR_EN_N_2B",
+	"FM_IOEXP_U541_INT_N","FM_MODULE_PWR_EN_N_3B",
 	/*H4-H7 line 120-127*/
-	"FM_IOEXP_PDB2_U1003_INT_N","",
+	"FM_IOEXP_PDB2_U1003_INT_N","FM_MODULE_PWR_EN_N_4B",
 	"","",
 	"","",
 	"FM_MAIN_PWREN_RMC_EN_ISO_R","",
-- 
2.49.0


