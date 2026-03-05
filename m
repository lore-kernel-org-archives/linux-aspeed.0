Return-Path: <linux-aspeed+bounces-3597-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822F2F513E6
	for <linux-aspeed@archiver.kernel.org>; Thu,  5 Mar 2026 22:39:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fRkwt2lNLz3c8x;
	Fri, 06 Mar 2026 09:39:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772700542;
	cv=none; b=j9z6BVTZtryAlVZQp9v19GZXoQnYH3/WydjBzTm+TV/6JVpcHdXYLSifzky9HBi+d28WkdtniptEUqT47Z8Qrj31HGdKRjr81suLjTiYwEGx4MA6rnpiCd1Ievhlp9dlWoMUy8DdzNvw2u+ekdcLG//RSpLPuY3ypViz4FYYoUzarPRuM/OL2uL6edZhdsLjED0zkHkefh97xbq/SH8hfIsDQBhhi+U7jBTMiX2S9hpJU9iKBsopjKIFn2iO9aHKMNJp1pT41INr85Gmt+330/3YqumgfTmC5yT+Zo7hCKnY2ZS3CzQwSUu8NgLR8EPItrVr2EY/mHeTaNs3JSDSvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772700542; c=relaxed/relaxed;
	bh=uLXMGyCvCYaOpNewWGAXwBi4Q3TPN5Jmwds2Ju3CvEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZjyNl5N2gxPwwNXWZsi5cj0PEyIc3nopXqBsgOX2YzYa4r78/wvRcfGCaGBCWwfuYaEwYi1Qj4mIH1+ilBg7SosEY/MYibhVY92YM9UbMCCnftsWIzXFlMnzaHGAApa/WEiuh2pd7GTeZXQsnkZl7mNrjUPxwbCKq/0W+dxsZcRSvShHNw3XBFb51AZLwrCgJwzePFoVadtZLFzVtb3eH/LL5OJqJ/vpIjLJU6YrEpqqmeLc5HLvzJl/GEuXi/2DlUGgmWkCvk5nwuYWE/iDV49vdesYz++H8QLFevLVH7uJ9UliSgbQ6D2805jdGsaa/XAH/BC30xax0QCyAwJMmg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RRlAYW0u; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=d486250@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RRlAYW0u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=d486250@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fRNW11DsHz2yFl
	for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Mar 2026 19:48:59 +1100 (AEDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-c648bc907ebso4852138a12.3
        for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Mar 2026 00:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772700537; x=1773305337; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uLXMGyCvCYaOpNewWGAXwBi4Q3TPN5Jmwds2Ju3CvEs=;
        b=RRlAYW0u8hfAnrZ7lPLLZ5kjQJTsRZRQDfHrH8Uk1qVSuTmnh3k8vlrsSsRwVAv/8E
         DUEAD8Q9V3SjslYvH9SaGPwct8jkf/R1xVDeSjXEdHZ6KdnMDwgvFekhbdVVY5GG7EtO
         1xgN2RrEwNGCNjVGWrXpNdyIZ1PGc/8gdo79rIKcAI6WYRH4IKys3PZZd+jeuJ1cqZby
         bH5M8Yk+QfpuKIaNa35/vopnsZBC0Rx+lpQE+BVNVQIx6wRq9D6xbArpInJ3X32Zj+j6
         4zPVZiy42ajODseLy+vFMW/E6QVHFHTjSdlbeZDFmi1RcSU6AZbwczlNpXUGw+kwkVVj
         G8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772700537; x=1773305337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLXMGyCvCYaOpNewWGAXwBi4Q3TPN5Jmwds2Ju3CvEs=;
        b=XB+XbaaO9tNGNH8DnIWT0uqOTN+9dj1sAJi6JF9MVgcdzAgGCaoLZ04PpENHWDFaMK
         b9YkoengHy2mcWWuDYGwaa7q9Sxdvc9fCRfUzBPDC74kn1BpZdXv6fbfW32uaAHVJYOj
         NB/CRtzgHMzhW0lyJLnDtRrZAMaNEWrPgeJ6IJwU3uy8QNzT/nR5/FmJimYMqCgjRlvk
         CMAc6dL6I65wtgURFQrC7i6SG9Z9IFd0yA2SBGgwnqDj9Gn9fetOf5q/Lnw0aIvyP9IM
         pFO7ry73hJCINvs1V0Td+eduXHXVfF8hiEbfGJ0PnA5BTFQToGcfdAySPBO7AnzQcJXl
         0w7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXIxx2hq3kocJQhzimFdfJ0XLZPooFNtPc5dvc5U1qlPDYnv34ZsYt0NyRrqaD69GHPodXe5iEhvUTpVC4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwPA8R9mwZc93k8TYB/kcWv0xi3QuXbpsrwR+KirJjGUFL55F/6
	DE75xaqJvqrWmFoTDwMR3ucNY7nqpTlfU4JR4fbsq+gYDi7SIh/z0Z7r
X-Gm-Gg: ATEYQzyUHD2X1NbHDowLBhH29oL+AY8xey7SdtgjHwqK3RHGDuTHq33uTwfQwKwK6uH
	dgN+68Cl5bj1etwARI4904t5PNosHdI2IkOI1IwyC7pY1zUfotKYkRm0zSv5VLrVoKpzM7oVWor
	Q8McVbAi2iYrKxGFws2qIrnRQDtjh8e4WYwBfzTWCoeP/DICnMTV6ak3ZNrl3xxPXuQYAdaDLuH
	4OIgykG9zcOHkdcQSOYX552RTcIjCktQdEOp46M34+RoVDvaWZgH08AkjdcmbNqmeJXd+ObhJV9
	jiIvcHyPBTehTUTdvxauNveuEU12vxOpbb6NqBnBNRlGA+v/Dhm8SjlBSxeAaMLomH7QQFaLnKA
	CsV+XW8FfIjtm6NIuYyidQEhwyTY4XzuERM2KOeOk9NMpjkDmYIC/403QC90OKLBDMZSlS+f+4a
	hz82Klx44MdrDYkVLi+8aj3moTlkxdCO65Bw0F9tdtJ4/0X1xV3AFrAsjUiNe0E6BRVlMUK7EXg
	O6KnjbhIr5vYne215txNQ==
X-Received: by 2002:a17:902:d501:b0:2ab:230d:2da9 with SMTP id d9443c01a7336-2ae6ab28e3cmr48197565ad.48.1772700537028;
        Thu, 05 Mar 2026 00:48:57 -0800 (PST)
Received: from bu9-daniel.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69f277sm289309515ad.55.2026.03.05.00.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 00:48:56 -0800 (PST)
From: Daniel Hsu <d486250@gmail.com>
X-Google-Original-From: Daniel Hsu <Daniel-Hsu@quantatw.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Daniel Hsu <Daniel-Hsu@quantatw.com>
Subject: [PATCH] ARM: dts: aspeed: yosemite5: Add MP5998 power monitor
Date: Thu,  5 Mar 2026 16:46:50 +0800
Message-ID: <20260305084650.24511-1-Daniel-Hsu@quantatw.com>
X-Mailer: git-send-email 2.43.0
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

Add the MP5998 power monitor device on I2C bus with address 0x46
for the Yosemite5 platform.

This allows the hwmon driver to probe the device and expose the
power monitoring telemetry to userspace.

Signed-off-by: Daniel Hsu <Daniel-Hsu@quantatw.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
index 2486981f3d6b..6287f80d70d9 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
@@ -422,6 +422,11 @@ power-sensor@45 {
 		shunt-resistor = <1000>;
 	};
 
+	power-monitor@46 {
+		compatible = "mps,mp5998";
+		reg = <0x46>;
+	};
+
 	power-monitor@47 {
 		compatible = "ti,tps25990";
 		reg = <0x47>;
-- 
2.43.0


