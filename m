Return-Path: <linux-aspeed+bounces-2350-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8FA1CAC5B8
	for <linux-aspeed@archiver.kernel.org>; Sat, 27 Sep 2025 00:41:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cYTCY669hz304l;
	Sat, 27 Sep 2025 10:41:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758879468;
	cv=none; b=gk2LPUWRiN0kAWyyuGNEsyvVlSTJ/tXbwotcpM+oY8Prif4mGKCFNeLwjOJYBxzsZSPHZIrI+6e+c+M8/IH7dXl8tczC941T9isjKDcoNbWGq1qnCKvkYsx/dS9CQWEeGL8EiwKct7oNriJ18CyJq4SrNnt65bvidPZV5YsnbIiLYjqqIDCK9g+7dFxjF7Dv345oyKTlasx5T6Hjs5cqLm9zEaqEZC3AoWU8It3S8I+IfDbG+qksgOi+N/CXod6jzDcvw+uVWkk1O/CZNt+pYqEcrLuvsoTbD5QeSi7ZVnb6fMvKHgLr9Nh6VYelvKZJ+53QwzclctqlP4CDphwzPA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758879468; c=relaxed/relaxed;
	bh=UoStl/6O0pPwy/s/NQABzja2ZbIsUSjfUYP6v+Jyo+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=F6O7bs2KPDrxBzHuXKFWNVJNM9yvYVBWXKgPFqodhh5R5j9kvOvEv9D7lsmxqyFaoBD/1VTfqPbd5HXMPTXaS0PHAx/JlPGKaOvZJPixLXtwHPz9F5/puiCF6d1h0JFQbsjJBcGJOp180vuylyoi/Ifz7s/biZaLaiejygDcUiI76d0GPWbSIoROl6wrc+sADGqBu+QkXiqABM4GkhtU4sem7S3RlfttRWIQ7uLO58GN1btMDOq/H2sxEh3+kgXpDfpvJYcq+VP7e6Nm/OJXOP+o6iK9zKEHq3d7cftdKF9KSC1ZOKJgPFT2wOtXVGiKKqz9LRGnYxAFkD9wMyrkCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=TQH1bYbL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=TQH1bYbL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cY5973NgJz2xHY
	for <linux-aspeed@lists.ozlabs.org>; Fri, 26 Sep 2025 19:37:46 +1000 (AEST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-33082c95fd0so1996769a91.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 26 Sep 2025 02:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758879463; x=1759484263; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UoStl/6O0pPwy/s/NQABzja2ZbIsUSjfUYP6v+Jyo+o=;
        b=TQH1bYbL3VG0wADfIeqGVWcRm8/9OBbaS6I3xKQzs+Gbq5g+RslzDtrmcX05SmRvSO
         MUv6QjreKaQ4z52naM5+q54ej/rxvywq5G2yxkGuaFoaC++6qHPWVaXQy1NNwHNUQYCq
         +9rBRBEl8x9QuFpNELzTRADpeShjUuvfg/QwBKqp/xH6PM2cdx+OYoaMyuWlL/SkL020
         0AlSJGB9rbEl9nvJnGRw3iE78svj8xDnxm2w8vIscshmOAu1eV50/f/6yWzmYCqhFENi
         Q4s/WmvDzKrYstxqnK8IkR6Vt8q5kTTqftN3momZ2yZe210l+Y/eRvExk5FJHuQPzwsN
         fnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758879463; x=1759484263;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UoStl/6O0pPwy/s/NQABzja2ZbIsUSjfUYP6v+Jyo+o=;
        b=n7iXNxhyDD5kX+wL9x70Y1/4RyRO+pBskUOm5EvXPu/qT81UwR9QyCIlSYdkTJ9/DA
         r/Sf+vdYsnGp6KRy8QzQlr8vNSUsFQcTDmXD5SVGb0Ylpbxb9GxYhTcu5kHQl9bgIGjG
         0/rkpd6KKS37ACwZq4yVzOzvBq19z0CsYLNuvZ7ndeGszxCvnxVTUVvLChu0p0cVYbFH
         pgs6PeQq61rh6vB++7ocCfciceYkJIUTRuDcgcjkNmW0OaNMG3LTUh3ywkwIouCsa1Cr
         tMeOB42RjoKXB0AfOCzgvZdx9cdRvzD5vuwMOL42n2gOwNsn97PSWpOcBmjnWyCbsw22
         eoaA==
X-Forwarded-Encrypted: i=1; AJvYcCXVCKwox6dqLj5Od5JXt/uSvSGvjIovTNfFt19li+UGwvKDBUFwVj+Hk8I8sixE+11pl/NzvicaY/j+pGs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyegLAiY6vs3UdIefnC8eHK66+x6MPT+QM2A1lp+3rkxVBihDeA
	63g8ENQJjJjjXyKDJAR2CATNXA30BZVXpEKt3NDn+MqN3RO2T9FCAz+Gbf/paw==
X-Gm-Gg: ASbGncvt4zRmLVCkiMtUC7F51ozf4Dylq9JHuAnyPVY3WdsdUMxPxQ1xra5Xwq8Jove
	glIqlkppZY/OtEFO3wpdLlTB632CwGv5/kmYLkx9BDy6J2gVOJxAxh5eg+VcwpB+ExO+h80zG0B
	ALtJ9d/5TfM2U/4QA0pm0oNftpnL8EysKAdpy0HoLflNfk1/K5od23tYnEUAT73sFH//sRdJChq
	NSYvRje2LwjYS+a9UlZyROGVpm0M4NRTminB0SvBg1Oizx2kirkOjkGDJ1TyktcIALNeQxiUNXw
	vlJF/ph/6ET583h5DNBMZ9rcye831QC4LoDl49EyA6EPNAqwC2kIXWN/kBp4y2X6P0jcDd1YxZ9
	CEPWxeQzxPi4YxjWeOXTycuXVFYxTDaKxdUY+gx2/ksYIgVL4h/HaxVrGtEM=
X-Google-Smtp-Source: AGHT+IH2wN/vTNpoB41B7wJ4UIGDQlG1DOtuFCeTQt8xZvPtyijptE31fGlsQRHND0LCJie+ahas4g==
X-Received: by 2002:a17:90b:33c4:b0:330:8c87:8668 with SMTP id 98e67ed59e1d1-3342a259df0mr7079061a91.14.1758879463298;
        Fri, 26 Sep 2025 02:37:43 -0700 (PDT)
Received: from [172.17.0.3] (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c55bd160sm4211056a12.47.2025.09.26.02.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 02:37:42 -0700 (PDT)
From: Leo Wang <leo.jt.wang@gmail.com>
Date: Fri, 26 Sep 2025 17:37:29 +0800
Subject: [PATCH] ARM: dts: aspeed: clemente: Add HDD LED GPIO
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-leo-dts-add-shunt-resistor-v1-1-c871a68792f0@gmail.com>
X-B4-Tracking: v=1; b=H4sIANhe1mgC/x3MSwqDMBAA0KvIrDsQ06rYqxQX+Yw6IEmZiSKId
 2/o8m3eBUrCpPBuLhA6WDmnivbRQFhdWgg5VoM1tjOj7XGjjLEouhhR1z0VFFLWkgVN8O71nIf
 OB4IafIVmPv/5Z7rvHwEMnJFsAAAA
X-Change-ID: 20250926-leo-dts-add-shunt-resistor-0cba43f75bce
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 george.kw.lee@fii-foxconn.com, bruce.jy.hung@fii-foxconn.com, 
 leo.jt.wang@fii-foxconn.com, Leo Wang <leo.jt.wang@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758879460; l=1436;
 i=leo.jt.wang@gmail.com; s=20250618; h=from:subject:message-id;
 bh=thNDQviaGyibFyGAqfP3goBA/6Fj0do4LHltc3WJriE=;
 b=T71P6S/+uzqAe2pm19qHzYoz2nhygnZpGVvbKLhyWQcQWVsDSelLeccTY+VnuA6uzE1BPL8L4
 Lvp20VxcTRFDYgHucePFNrm13q3hBU7efTHRYQ5iBAKOa87ktB1nm+E
X-Developer-Key: i=leo.jt.wang@gmail.com; a=ed25519;
 pk=x+DKjAtU/ZbbMkkAVdwfZzKpvNUVgiV1sLJbidVIwSQ=

Define a GPIO expander pin for the HDD LED and expose it via the
LED subsystem. This allows the BMC to control the front panel
HDD activity LED.

Changes include:
 - Add `led-hdd` node under the LED definitions
 - Name the expander pin "HDD_LED_N" in io_expander13

Signed-off-by: Leo Wang <leo.jt.wang@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
index a614f947dafc9a6628c3f3d45b62ff3ca9d2b618..450446913e36b1418fab901cde44280468990c7a 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
@@ -95,6 +95,11 @@ led-3 {
 			label = "bmc_ready_cpld_noled";
 			gpios = <&gpio0 ASPEED_GPIO(P, 5) (GPIO_ACTIVE_HIGH|GPIO_TRANSITORY)>;
 		};
+
+		led-hdd {
+			label = "hdd_led";
+			gpios = <&io_expander13 1 GPIO_ACTIVE_LOW>;
+		};
 	};
 
 	memory@80000000 {
@@ -1199,7 +1204,7 @@ io_expander13: gpio@14 {
 		#gpio-cells = <2>;
 		gpio-line-names =
 			"rmc_en_dc_pwr_on",
-			"",
+			"HDD_LED_N",
 			"",
 			"",
 			"",

---
base-commit: c65261717599d419e9c683d85f515d3ca2261549
change-id: 20250926-leo-dts-add-shunt-resistor-0cba43f75bce

Best regards,
-- 
Leo Wang <leo.jt.wang@gmail.com>


