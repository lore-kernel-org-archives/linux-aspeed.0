Return-Path: <linux-aspeed+bounces-1645-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A151C83F03
	for <linux-aspeed@archiver.kernel.org>; Sun,  6 Jul 2025 04:24:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bZZ5G2H8Lz30T3;
	Sun,  6 Jul 2025 14:24:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::430"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751775858;
	cv=none; b=RlyDFhKiAyP0nNRMUmDiU5uVO353BE6RtVHhRVWcLx4wGzKL15HfpUUzGwwty+riiInICVRLuicOZ0bLi/EH9CT0rTjjb8Fx/Hlzx+ySfXta7iE8vr6OnuUYhCypLFRt4alYdPrqqRTlNnb8cme4J1qbbKu9fLWTDR5fEhFwXt3ndKaiCU7NyzaLl5vnA4RDqDLtf+KZ2+ibRNk7vm1JNXaKpEuOZD9aBo8/ED5/9REg+M+mEZ4xTqvZVuQOPl9UNgngdg5BXUs4Bmnvsi+zegPT1WyuIvHfimFKR3el9Hr3KpeFbu0sHOwzb6hR1ZBsiTzaHO+c+4DTOD9glHYLDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751775858; c=relaxed/relaxed;
	bh=gTfGXPyjwWbwYggXhGjVsZrke/lrobe8f9NW1l4bYM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/FUf8TjW85bwUL0dkizNglWpBDwdlRKll4eUqGiNHAHlRAaittBKGLRXlgyYugwUB0yzoV34Py4SSNYJyrTOmHBrCRuLARyCUFCCSyolsv+9bj3NK3VvZcClT85hN1OUHxtTQj1ynU8y5IjB4wCeIerTseHqbqTXV0+shiVMC3Cq0R/xyws7dmdw6Nj5Sjwqz7ecSl7/Haywk0VrnXAUimd0oDNjSe9T+2mUVk42rVi5w+LwAGQG+tUTIHuN+wx3OSc7CxAOVENGy97H3ckYm/UHMQCmrzHXZaPnWJ8SnmTSlX1zXnhhqcswmnVfYU+Tt5KQtkt3PTtenssgi1Img==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LEYIDkT1; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LEYIDkT1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bZZ5F57V8z2xHp
	for <linux-aspeed@lists.ozlabs.org>; Sun,  6 Jul 2025 14:24:17 +1000 (AEST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so1577952b3a.1
        for <linux-aspeed@lists.ozlabs.org>; Sat, 05 Jul 2025 21:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751775856; x=1752380656; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTfGXPyjwWbwYggXhGjVsZrke/lrobe8f9NW1l4bYM4=;
        b=LEYIDkT15Enkun3IAnt8+6RBnbWTxFK2tiTJCEw3ppHWvD0ZtV9k/XyCiBQ/P93B1K
         nFXJmT43xmwUVta50EJymtjRauNv4f4+NnQvclxfJynjy3sNKsp6mv2KL27Q9Ue0YW4B
         n7/uCq19vpa07leFLIgVXoPY5dnhvCEdTIIE09B2KBDaTfZDIbY+oTnsYT5lbwVTk4oc
         FuKtmTb8ptk2SZPGJbpYTTHiiFJUBQnxhpATDPoFk8YCwq+dd2878MXGnYClzGMcUEdz
         U5HnkcZ8f5RREQPihdBDObxeI3Y27qyWI+GYYQBWZe+m8eS8dgYfqrSP7SGENpzx9vPv
         sNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751775856; x=1752380656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gTfGXPyjwWbwYggXhGjVsZrke/lrobe8f9NW1l4bYM4=;
        b=OgTwSCCTkwE/h8WqX2J6fGw12wKx2xynzy4DmLYa0IAc2ionYpxP/b/4/ecWfdDxf0
         ICYhhw3Dvqwd2apOE5N9DGRio7WP+QaXxr4KwifTRLXBOI+2z4G5Q1PtQCC8YCOVsMPU
         iO9lbHTlkQmn6/H6gYEGuav669PGrEeLdlRQvpQhG35I2bu0rZv3Wclsw5aOrkDk77RZ
         lUJPaH+o5E0nkRCXXL4Z6Iq65BUbjQyWIkpdg3aMeE9bovLMgKSUiZlQSn5FROTf/Nrg
         bjTuOo3nFSfVTHyenytrm8sB6QRSMwWyuK4lRJPKteg/c0xdIMsoR4tHBFqI6+zTsy3I
         62sA==
X-Forwarded-Encrypted: i=1; AJvYcCVQn48DC3w5uoMzaeV5TS7cTEYmEFExtNkumSfTlbxtcsMvxpSJRQQ3WfXWocOYHuV9GAMHSFBXKHaEZIM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YztgCyeh/6XERLIIWE67vqt8iIbCeWDrtnrtnaeU2YXY1cQinyG
	bOrPoUn2eP9oLOIWpFjonShrU32+l/SphqIuTkaCwCnGf2u9omqs3BJXTIFzIeAS
X-Gm-Gg: ASbGncuVReWaaK4KTqbbizCMs0366AJ2zYtZFtcjSpy0/Q+Qd2XuUPAVYKcHpUlBlW5
	94xp+3LZFRBYp9bW/mfaE6K3U8G16SpNXPmAKu7PRc3jw8rkOaX2jyIyPoxMQMav1yw3ST/WGFt
	c5nIot+zherYpIMwPty+s/+PjD0gmO1GYpLizS0l6PWvFsb8TaLcEdYiXpYHZ/GjJggEbjJQ1he
	SAy45mAS+JzBP9Uru8TlN2s6vyOthLjy1WyepsTIcxEzVQG1deTpWTbKR3wBw9AS8aDLgod2T95
	qq2eUx8kIijaxCkg09vp5N8zpdLPaBFMspkiKvlyjm8/S/REQqxyAscQ8Hljm6CTQRNtIuMFnP0
	VairXZUJ+Lt/fE6g+Y1y+dehTXqZkDpmhYANDNTM=
X-Google-Smtp-Source: AGHT+IF18DUV/d88jcrhrYvIvU1ums7AXMfBmWhfxadJSu8r9gEGoO1K989AmSn7ygBQCoB15CKQnw==
X-Received: by 2002:a05:6a00:4b52:b0:73b:ac3d:9d6b with SMTP id d2e1a72fcca58-74ce5f5fc4cmr10057178b3a.4.1751775855713;
        Sat, 05 Jul 2025 21:24:15 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce417f206sm5287067b3a.76.2025.07.05.21.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 21:24:15 -0700 (PDT)
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
Subject: [PATCH v2 4/9] ARM: dts: aspeed: Add facebook-bmc-flash-layout-128-data64.dtsi
Date: Sat,  5 Jul 2025 21:23:54 -0700
Message-ID: <20250706042404.138128-5-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250706042404.138128-1-rentao.bupt@gmail.com>
References: <20250706042404.138128-1-rentao.bupt@gmail.com>
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
2.47.1


