Return-Path: <linux-aspeed+bounces-2348-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 314D4CAC5BB
	for <linux-aspeed@archiver.kernel.org>; Fri, 26 Sep 2025 03:17:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cXwjs3jSHz300F;
	Fri, 26 Sep 2025 13:17:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758855755;
	cv=none; b=kh9x4sZHJwnwZT5P8OsN4u7y6/wquJG7DpEz7nVG1xubEUkIbYvz7Z++wWgZ4NW7KYEFnUQ5WypqfHoE2n/XuSKttPTQRJDrJKYEQW1/5BalFWEjAzMNsb+8tzXEjbuiNzX8kxNdNeXnKnzjP/SPqc1+9qjs5klpQTCIDZvTmxSTPLPIQyBhntATC/gkGTiFmW8uKCu2Fd7alDTZBItZ3zwbFA0Of2Qmy5nKrlw5Tw2bDIvOIPJe2817yGtVfYSU6beJ1fymfpK0HEQdBIca06qldCRSiTyBDcZzeOq8qC7vXPYgBBcK9iiZPvK0LP/xpGT6SSDcG0VqBI0k0+KWVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758855755; c=relaxed/relaxed;
	bh=oAJYYsubH767ZAAG6Ssy/u0Z9S4icmj/JgueQ+Oc+lI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SzbQYISjLxDAf9BHWvnaNL4Taupc3AqGdXRO+IdsZazvd+XvqcZp8B4M9CJoE0Ha8hOmBjX10uMUqvbCLJF2uu/KkAVSsldhFiABzkQd7xbDe89amrr62FacJ2YooLtuaDCdpcLo6/4XP0O1H1RGEfd3UlHzagV65uMt2zcwNWeZ0vgtlWilYEOf6dQkUurnRtSq1hO5VH1PIOE4WT6zCp51qh8JaMevxQSatNPwLdmKxcviIvwRWZI9o2FIP6Qazic8X9HKqmhfTrprTYpQF+eHXIGGba2qqxVZBT7BZbgdHRn61H3hZnkGA2hUDV6SACKSD2suJK3uNsax0sjwTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Ymo1BrjZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=d486250@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Ymo1BrjZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=d486250@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cXwP56Qylz2yrP
	for <linux-aspeed@lists.ozlabs.org>; Fri, 26 Sep 2025 13:02:32 +1000 (AEST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-7811a02316bso24242b3a.3
        for <linux-aspeed@lists.ozlabs.org>; Thu, 25 Sep 2025 20:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758855749; x=1759460549; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oAJYYsubH767ZAAG6Ssy/u0Z9S4icmj/JgueQ+Oc+lI=;
        b=Ymo1BrjZk4ymfCznTHfwjapEWoxZr6+RfcLs5/Gw52DCP9ISLG5BlnIlI6TIdADQWt
         5sU8dAAHO/CI8DiXAVu/6r+fVZtGIAu7Q3Om5T8mU3KmYMHn9c+pnDCZ38+iiaAvdAhd
         Ku2g8rPbECzsTNEBtHtcjWG3bQlMCpCN2D4gI2iEfZBOgfDQuBM/SvtOs2BtNY4TFMmA
         uOWo3bCdx+LKbAN/QvnoFwH9U0zbEeG6IHzu+rMQHp5dwz0sUT4zVyQ9B+GIn4Ss+uVy
         2X1yzDcYEIyiORQ+XzaQQ5IAhNooxC7kfctTBRmBfMt/x7u9ftMFmcgelbb/U5Hchd/2
         2Qtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758855749; x=1759460549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oAJYYsubH767ZAAG6Ssy/u0Z9S4icmj/JgueQ+Oc+lI=;
        b=q95mnKQZSRdPORn0jp6u2sjwHgCUn4FEwGqS0IstbEp2WqqQjikA3b+BGK02X/8KFD
         FKJHwbCOkPfDVFxTWjvBBrPpDFp5XxvdBfiwaY2F2Q7zgEpG3JTGigqmGB9CL4vUE5v6
         EE21AH56gtgUTJitTnxXkFCla9d6U1zZXKK4DvJPuB0BcPUVVOnmf7acJBvWARjCdTeo
         PbTR8FUnfHx4VL/S9l26K1/96tV8BAExzwT8mmLwJtuMN5lIpkOZnEzAxPHCS+VKHher
         D7O6p/HL2O2l2Kj7J+XhPPnInxpMrOfso5ciVWth7t2s4UHO5pPLuWYCMpBNBvWBGHa+
         hSpg==
X-Forwarded-Encrypted: i=1; AJvYcCU46VLfie1BXgPU0IDtabs0l0nrYw+qQdU7GPvTkDdzivC4ujSM0GiSkL7YFvtLm+d4INP8PEfZrJjTcF0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywi5WiGGXZoOXcIa5a1M7Q8GJ3jpJszHV3Um2SO2uLB7h+LacBW
	eMFCiirfKM8VYQSwOlJt4JDxQAaOnKUj+16SiWuQY5koclv6BEiuCYsQ
X-Gm-Gg: ASbGnctRPt/W/hUT/xsVcwXeZ6LbLFwP4cQKYOHflMJnAG4TFuaKLPjpK1mPJGHMbUA
	gln9gfQSiJ3M71yRLB5eufN8jnKhMxxDyuSaSwEkwg9x0cBOaMHGJgJfjX/d4+2BhM61tCzEznS
	QVAPNdilYzobnBoxVXhXK9rc8MwG8a1pWniqRTGiFH+P9yQ2OU3j+8KZq39070/jxbQk+U2p/tD
	O/dHNKUEY0WkPnpKA8iLG7o9JCktHc8TcsTY+E+bY8XyWvcMkGCZBXyJV7FHPPMkHCeQo81t/22
	2fqViGqmM2W9U23IDkx6miKKIxLgZzzpL5dNwV05btScCCCUv7L0Ht5xBtuGTUf2E7fT7BjDtcN
	hY55BMwQcxcnwXo/H5x8htmEecdlaBDsUQCzZmI2SkMy7VZ8627dbuHIcCVbavf4O23ocD3X5II
	c1GULbFOYtoHmBY4ToEg==
X-Google-Smtp-Source: AGHT+IGVVE0b3+ap6KgQf8MQgQkYuBpIvq9eSH0KSUWAfnMr6DmONE0rdbX167dWHQYcpP6jeWd61w==
X-Received: by 2002:a05:6a00:1ac6:b0:781:15d0:8848 with SMTP id d2e1a72fcca58-78115d09690mr1084933b3a.13.1758855749399;
        Thu, 25 Sep 2025 20:02:29 -0700 (PDT)
Received: from bu9-daniel.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238c1e8sm3225384b3a.12.2025.09.25.20.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 20:02:28 -0700 (PDT)
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
Subject: [PATCH v1] ARM: dts: aspeed: harma: Add MCTP I2C controller node
Date: Fri, 26 Sep 2025 10:59:52 +0800
Message-ID: <20250926025952.3098933-1-Daniel-Hsu@quantatw.com>
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

The Facebook Harma BMC uses I2C1 as an MCTP (Management Component
Transport Protocol) bus. This patch enables the controller by
adding the `mctp-i2c-controller` node under I2C1, with multi-master
support.

Signed-off-by: Daniel Hsu <Daniel-Hsu@quantatw.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index b9a93f23bd0a..2b7019c55eb6 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -242,6 +242,14 @@ gpio@12 {
 &i2c1 {
 	status = "okay";
 
+	mctp-controller;
+	multi-master;
+
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
+
 	temperature-sensor@4b {
 		compatible = "ti,tmp75";
 		reg = <0x4b>;
-- 
2.43.0


