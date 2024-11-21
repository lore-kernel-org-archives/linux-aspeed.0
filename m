Return-Path: <linux-aspeed+bounces-159-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3450D75BA2
	for <linux-aspeed@archiver.kernel.org>; Thu, 21 Nov 2024 02:53:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xv2qc2F8Dz2ynn;
	Thu, 21 Nov 2024 13:53:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::b2b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732157628;
	cv=none; b=FKztTS68YU2FX6Z1wwgMILubhCOx9UfqxmGLlNvxtOkFnDpC75u6oyV2v3qc8Bp2ZdbO/Dg7UlHtoi/tQw+dDDVbn8hIVkUDywlfEKmUqXHHFwMpzdOjvBl0/dacjdw41VK+5s1ZrT/+8ov7gsb5g8CjMaO2TtxNtGUgEpToUV7x/gLsI8ofWjEcATvi4kfINKLLudR3bMxhDbwLUuC1zr5WkAYesyTZJASRlvU47x/7cf/2JJvs9EjnAIvGsMGiakAWdKhhXytg1dfFsSfQfDtwjf21v6SN1kCCmci7ur/aIzCZxkNfMLK6a3mW8abcMCnRywbMC3YkbZoWwS6Fjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732157628; c=relaxed/relaxed;
	bh=eNks32tb/xOghmG+mNYQSKO0C3AuMd7n2d+nPZVJVl4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WtD/dI1ewaySh/uhEOc817TUgTcde+VBoaZgpoFy0HtumTlusSQTBR9a9SN4XW96E3xJsSL75sdiNc7wMKkUnKYGFkg1jWr+RqLb8DpRsjNSlQug5JLxoaZmgUSQqAkl0Z5YDuwcU8sAsm9Rdeqdpn4pDvUxMrP+NTU66Up5st3S3rja07RbvmX9fu5bu7veGbidKlQGU3HfMZKQoo7oMTsISxqFjgdRS8cO4qkeJ5q9QZ3XWKvKvNw5dQnI9RGaPJ6Zc41xIseyzxSot57aAZnGo6sc/6qZdPHZE+nJ4i8NkspVJPzOj+T93CMhrn+10gidcuPxa3mXYte3ohaI7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=UvRHHbbU; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b2b; helo=mail-yb1-xb2b.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=UvRHHbbU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b2b; helo=mail-yb1-xb2b.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xv2qb1thqz2yD6
	for <linux-aspeed@lists.ozlabs.org>; Thu, 21 Nov 2024 13:53:47 +1100 (AEDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-e333af0f528so360305276.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 20 Nov 2024 18:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732157624; x=1732762424; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eNks32tb/xOghmG+mNYQSKO0C3AuMd7n2d+nPZVJVl4=;
        b=UvRHHbbUDyu0zdr0zFEFeGGJnO/ZWGlUGVl/M+b3OwplG0RomdehtF2g3OpxVt1zrR
         EdibeBjqwRzFoq+d7Mr2+y0I8Kc8aiB2g6T0nNsmGCRdYUAktOATRCYqQliIKK26FzHl
         kj0xltVzR4ryH8O4y3qGw1CHxKEz5g2EGb0tA3fGefyvsvsUgVr983zl3Ofzs4sCFbPB
         7iAmviO9Xd1J25DPslj9P6mfoefCS13apc3v2llxKNtPmV0IKe5FZZIWDxwviSG40W/V
         WeAgyxYe7Qesq1cwaNAw5L7QHNv+WkgFlDDA7GIR3uWDTHTinyR9eFOGNpMysHsW9C6w
         Wd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732157624; x=1732762424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eNks32tb/xOghmG+mNYQSKO0C3AuMd7n2d+nPZVJVl4=;
        b=m9isFlqurMj4bzgOMeV1gtbk0/C8Oa23w5SI3D7plMPy0tik1GGx/8CjnBHt/KWSB2
         d1G8WGAwazbZLbPs6yZCECW1tFwbQPddkd++ltmm2ngRn32bI3F/oKttOSxJU93m4WDa
         z0+oBxhog0nQdHGm0oAJlvbQTdFafJNfH2QChsygzjkxC4LZmOOQSOBMiQVN2e0ujxIC
         Rx1aZhhp3ZYUczN3JkffdNQFPD36jN8OR83XT3Dpf3gPoHpWCMsf55TcZZV8th8ZBY/8
         9cL7JNWj2KgA+B3jnzq/z+3ohPOD3VXNh2vVU4jUldPdFD9Pzu3xTZT+U9NmGwFsraXt
         1/fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXja7iy114/SExIdcuSdnR11PiSfL0RWMsu8b6fb7P/+WfRJQQ64vJPIKWcNdm6QBkSHqYry50YmMEyxTs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxEVHe6d3oMXGACx8uufFQf9689WTF/woI7NMVCao3DKsT5nDC5
	2xQ8yp0rmXXOB/d781q0FjJS8IYrZ4Qxx+/n4QB8yZeCyDqKSNKv
X-Google-Smtp-Source: AGHT+IFMgccuI6rNZuzdmJfzJU0QMp14kZJiCMh2XqmUc3OoqgAkCbJZmDufzaxQBAaiW1nvsjTGRw==
X-Received: by 2002:a05:6902:2487:b0:e38:7d0d:d7df with SMTP id 3f1490d57ef6-e38cb7173ebmr4643665276.50.1732157623896;
        Wed, 20 Nov 2024 18:53:43 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e309-7a4e-e779-1177-8427-3602.emome-ip6.hinet.net. [2001:b400:e309:7a4e:e779:1177:8427:3602])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbb64f5514sm285513a12.34.2024.11.20.18.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 18:53:43 -0800 (PST)
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
Subject: [PATCH v2 5/6] ARM: dts: aspeed: Harma: fan board io-expander
Date: Thu, 21 Nov 2024 10:53:22 +0800
Message-Id: <20241121025323.1403409-6-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241121025323.1403409-1-peteryin.openbmc@gmail.com>
References: <20241121025323.1403409-1-peteryin.openbmc@gmail.com>
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


