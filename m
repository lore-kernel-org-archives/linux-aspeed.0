Return-Path: <linux-aspeed+bounces-1847-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB145C87FCE
	for <linux-aspeed@archiver.kernel.org>; Mon, 28 Jul 2025 05:56:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4br75Y3cYKz30WS;
	Mon, 28 Jul 2025 15:56:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::536"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753682193;
	cv=none; b=QYR2RVuem3Z2QqDw2Nd5kU7+rZcnccP2oZ25AFYi4LyHr0/vC8bjcdsxXiba0WUp4HKHG+8LBNyCMqvKWZeQ8AM5ekpvGmbVfNgm8DbYCQLQYDfh0qRBUHbKA4GMYCkNwkt+ZXZ6wh2Y8L9n83iTFmoia83nScn4Ks4rWbt1I5E/A/LZdpHgIWCNxdvDAz7OWcI6y3G902X36AxTkym8QnADrQXxcbAZimVZvM2VMMpM1UaWjDMib9pB4qcFUea3vihabLxciQVCKvDyTP+c3uPHlzaBJL5Ze49xHt68u0vYiz0xUeEZp0W6vPRK2WIoN1nrakwpppQbH2RajkiZ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753682193; c=relaxed/relaxed;
	bh=7rbQVOsnj8MtiW9Jyx4x7uRijCuPdjPgMW3Or5zSI/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QyTFIu2qAElnTc/iieuQ1mtp8cwgiYkKUB99PiME6EwddJhUZGkLPaap5zu3E971xNc6LTpIbUWcOrUAfOjYYK00awpOzU45H2/lv/lpHYchjQ77jKAD7oXbalScORaYOvxQUBHR2DDcGuNl2MuTg4V6iTGOw4J7FWNxatqHgzxYo2MKX1AcsfOIsYGytvhqJXAnbup/n5BIAKLT1p0FOe3pdRdDJ/1+ZEGFmOICvc2+h0V4CB80Yd1QWH1jfe+peOa38khheS9hWui3/8amcA4i7EVfTlidpgmB8FXum4sXrangOMT//kKZ1E+IVSoCiVQ8TP/ejOejrcfANmKL1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=lZw8eJHJ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=lZw8eJHJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4br75X6kl2z307K
	for <linux-aspeed@lists.ozlabs.org>; Mon, 28 Jul 2025 15:56:32 +1000 (AEST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-b321bd36a41so3367845a12.2
        for <linux-aspeed@lists.ozlabs.org>; Sun, 27 Jul 2025 22:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753682191; x=1754286991; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rbQVOsnj8MtiW9Jyx4x7uRijCuPdjPgMW3Or5zSI/4=;
        b=lZw8eJHJrzcOwCv4+MqfsR9UoCZ0AIP3vd+XR3QZi9g/9IWAL9eSsDH0PhedNuPJsK
         smna69+gBMOK7Fvg24jvSFcqssi0enCfOxeL2o7YqgN8BxCfNRF54gIgLwLZadM6lo6R
         6vMeqnJWrjQ1scs6w0r5Q1V+AaYciut5lO7tfb+yC3f7Bz7asyQIhGiRa1AsQQ0tdRKx
         TflNAT2ZZUJ+4gh+PomJOdni3w/S2+BPCxbsdHkeIC/vqutRsisSN09J/0Q0rOAu7jrK
         3gl8BsjGFOIHJVBhqAMNnokgSRpd/0kAwXIZsC0/2Dwx2g21gboVlVxvwPY+9IWtYoHd
         NYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753682191; x=1754286991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7rbQVOsnj8MtiW9Jyx4x7uRijCuPdjPgMW3Or5zSI/4=;
        b=fWGKJmfjwYARjUeYpiqk1hF3ZDjAExmZ8bx0i0u8bUcCMfrDeS+8gmNBCT3XhkvElG
         ggh23JIvrF+6JmxFod63d7VaS2wrYaJi0zVOWXwdtczNJj0e/C2bdJ/9RFGo4DfuGA/o
         fc6pWo8OzmjNfiDXprcQ4B1v5vvCaRxNpTkkwyGnhTjsLPgOdToEBFqsx+uvS8kEpV/f
         jlKHUB7gC3SmAdvDWlajAs3G+HrVAPCox44K9l6iki0U0v0VkreeHSZVasgD6QY4wBLa
         ls0MpMPqDFWrixWQoN50RzmEbcL3Bd5EJNwx72/gUSu8Rdwr0+DqzZGh7nuGJro/+mTp
         7pvQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7J9jkB9+FTYyh52FbSI3zVawcsVVdcvTFbrqZQZt26Ift9jFlczr8NNhh3aTqeckZlMUM8zJ6i/7ZaII=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YybSH6xCRlzlC/lPHVItoL0oJX6jpuwLgq0AEw6X0it+Bd3eAqP
	j17bNf4YGieX7NULSbqWJ6Gq3yQ6kFEAjVrE7PZ7FTZJa+mj7EloGrX1
X-Gm-Gg: ASbGncvTeWhJPWdZmJGW362m9ZRRC9vwBpD+6jjidcaKmRG7Xmpyoku+2TI5pEXnv1/
	DsVtf4jTVMkMUM8wb2ET2O4XzdXredmRTXNV26fF8MsqBbz78Nnxg1QXM8QdAIdlBpwRgkIPTMe
	jKNJT+U/SMbLPCWdjKqqCog8hBWQcnM1oq5N19NERF8U8cNVj/OGZ5lHmqA6RRlA3ASMerTLV7i
	kn1mSEa2hYMMqs3ceJdXMEAFXPWWVHeeqfDA4OuTl1gJ0/O6ExT3rpYgwq5PkWXfEvW+rA9AJuH
	pexcauKXK7O8kEC3xrcgFEuLiPeyBFDAXe6JkzvenIq7KTBq/wWadQCtkJRBRSdJM9+238Y0zi9
	xejmcSWaATwMAgsZgoFivWpev8okHpQeJCUIWZFDCpKvlJAG/NOvOWKmW2BROAUk81Ya+8dzjeM
	o=
X-Google-Smtp-Source: AGHT+IEsZ+Ve7h/dSpvrm5oVG5f63/zmNJSGPRE5zLBLKub43uiQvcH1rH25UaQZkyLxvP17RPIH6g==
X-Received: by 2002:a17:902:f70d:b0:240:3ed3:13f6 with SMTP id d9443c01a7336-2403ed3167cmr11337685ad.18.1753682190828;
        Sun, 27 Jul 2025 22:56:30 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe514b59sm45091795ad.128.2025.07.27.22.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 22:56:30 -0700 (PDT)
From: rentao.bupt@gmail.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Tao Ren <taoren@meta.com>
Cc: Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v4 05/13] ARM: dts: aspeed: Add facebook-bmc-flash-layout-128-data64.dtsi
Date: Sun, 27 Jul 2025 22:56:07 -0700
Message-ID: <20250728055618.61616-6-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250728055618.61616-1-rentao.bupt@gmail.com>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
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

From: Tao Ren <rentao.bupt@gmail.com>

Add facebook-bmc-flash-layout-128-data64.dts (with 64MB datastore) to be
used by Meta Network BMC platforms.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
Changes in v4:
  - None.
Changes in v3:
  - None.
Changes in v2:
  - None (the patch is introduced in v2 per Andrew's suggestion).

 .../facebook-bmc-flash-layout-128-data64.dtsi | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/facebook-bmc-flash-layout-128-data64.dtsi

diff --git a/arch/arm/boot/dts/aspeed/facebook-bmc-flash-layout-128-data64.dtsi b/arch/arm/boot/dts/aspeed/facebook-bmc-flash-layout-128-data64.dtsi
new file mode 100644
index 000000000000..efd92232cda2
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/facebook-bmc-flash-layout-128-data64.dtsi
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2020 Facebook Inc.
+
+partitions {
+	compatible = "fixed-partitions";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	/*
+	 * u-boot partition: 896KB.
+	 */
+	u-boot@0 {
+		reg = <0x0 0xe0000>;
+		label = "u-boot";
+	};
+
+	/*
+	 * u-boot environment variables: 64KB.
+	 */
+	u-boot-env@e0000 {
+		reg = <0xe0000 0x10000>;
+		label = "env";
+	};
+
+	/*
+	 * image metadata partition (64KB), used by Facebook internal
+	 * tools.
+	 */
+	image-meta@f0000 {
+		reg = <0xf0000 0x10000>;
+		label = "meta";
+	};
+
+	/*
+	 * FIT image: 63 MB.
+	 */
+	fit@100000 {
+		reg = <0x100000 0x3f00000>;
+		label = "fit";
+	};
+
+	/*
+	 * "data0" partition (64MB) is used by Facebook BMC platforms as
+	 * persistent data store.
+	 */
+	data0@4000000 {
+		reg = <0x4000000 0x4000000>;
+		label = "data0";
+	};
+
+	/*
+	 * Although the master partition can be created by enabling
+	 * MTD_PARTITIONED_MASTER option, below "flash0" partition is
+	 * explicitly created to avoid breaking legacy applications.
+	 */
+	flash0@0 {
+		reg = <0x0 0x8000000>;
+		label = "flash0";
+	};
+};
-- 
2.47.3


