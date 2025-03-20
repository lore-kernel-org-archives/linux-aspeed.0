Return-Path: <linux-aspeed+bounces-1085-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46FBC28B30
	for <linux-aspeed@archiver.kernel.org>; Thu, 20 Mar 2025 15:24:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZJTsK4XSvz3055;
	Fri, 21 Mar 2025 02:24:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742484293;
	cv=none; b=OtDU0ccXhf9EIDPCbuGtBh3V9enBGqbcX9hvFIzSWlmXg3s80CyJbnLiOfHevatHuc8Y1aqjMiD31nVWB4kwrOZqfShkJkvcAjFX73CBnD6ZkXrWaZ8KCT9nZlBv/C7YG9TIqhUlu8fyOnc+2nNi+G7pgNYMw9GCWUdInq5OWBvkMDsf2zrOcM4bYuYYyaX1L1CfP+JSc/QnOJn9YyqQzPkS4p4UbDglTs6o8063PChWUFJWzwbS44dHoT/Awq5/PVviuT8SIv0uGwOsk7ahKa3ulggOBZeN6/5z264mTPMzGtjpnWDGIKgasALiKO8F7ZwuIntS2OaIha0NZtpJSw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742484293; c=relaxed/relaxed;
	bh=2C2x2YqAzE+wgdoLnExW9swbh2264Dz3KcOzm8hz2vw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jw9LyLuoTeyL7QTitiIByyHSX2089vs5h04ZyW8aoOKf4PmWdQPSpqaG/GWwPKilMzsaICsgxBjLE2jxS8+TltxDZglZ0/sr1lVOzQhWPhRVDUahIQ7j+tClhy/7B2BJPlVu1EpM6ycirLdIY2T1KpLOEWmcQm63nUXj4glj8yEHeuFn9h0/1mljxK7bVUf6nmIywb2IHf8/0MSL6H4Iqw28Uq6cEObDqyILOf1nuKf57/m4fVet5nWOaD1Ti2GHV8puzGJ2a6iYf249o2LE96RhCjEh57GTdE8ofni32Lo4DMev8fia+p5HF3IwHagBYLYL9T7V90QQKb6xDHxb2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=V+dE3iLy; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=V+dE3iLy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZJTsJ5v0pz2y8p
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Mar 2025 02:24:52 +1100 (AEDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-22580c9ee0aso19771315ad.2
        for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Mar 2025 08:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742484290; x=1743089090; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2C2x2YqAzE+wgdoLnExW9swbh2264Dz3KcOzm8hz2vw=;
        b=V+dE3iLyXeT02r5oj4OG1wWMbylYXMeSXRovknt9ojfKXFjdTp8u4NvMSLPfI6KP/o
         jZ1yZ9mUelgVCWSid9yfuikp6DCPyo4gT5mFey6rRNQIC7TCACcw5qPfdsBr6QlxxKU4
         oY+cryYPoznVkhDIRw9W+a+oZnZe6RZz03fxNWxSv/2oFZLQI/li5HTv4xZ0e5Wr95dj
         2AyWOBk5cCJw4bFJiO4Vcys7xU4CT+AybeEoCayg78SU9XZDQPsipVrnqGcy7Gv0qK+T
         rzNaf+Co1OpqtF2/R8H8dpKnU1kZPFSqM544oYZy5ImV709WykhKJHS/Kb8IJK9YUqd8
         iBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742484290; x=1743089090;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2C2x2YqAzE+wgdoLnExW9swbh2264Dz3KcOzm8hz2vw=;
        b=gjBWWg9zfMO1zPDWzdzk3AFqlnDO2GRPEePkQr6rqnu4ybuTXfJ2Njf9GsXyrUqvyQ
         JnxlVo1khZi5bSKlShoXBSZl+KqWVDkxhDU+fC+YknSzOrcdHubpSG+ebBrwEkHD5sE9
         RICHsoSagGi2vhEjn5JfnvNeucH2vyvYQ6w5q62T1k18KgdJgjUMgAOf01E0O3m124Nn
         lVFjMZe+YPsm6rbxaaxzJNcxoNQC7lt51b16ns3tvWNHKYwpAcPGeQi/bZncwiznR1b8
         jBq3TNPSK9aAc6DXrhTJ+73fMnZkP4scb8R6/LNjv3//HHGKFKLGsrUAK2ZuopoEFMvh
         aelw==
X-Forwarded-Encrypted: i=1; AJvYcCUkZY0KYVIBZivrRG6UMIbcLckTj48NepNEjPdZQ1fjJvD21ecWQqFoqKVu/gA/wLhYYT1fkuVMmdJXwWc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxYeJpao7Lo2jiFkbmiCYGgHSrKpRFdQIQSzgBRf2h7XrAylD/N
	BqYbZ+T4j8RPEeM9xZYTrd8/08U5wicmSLbWSQej7/9abk0mZ2Kn
X-Gm-Gg: ASbGnctCWYuCsQdDrD3b6B1C37N1saFptB+zer5JHmjGeajEviTHEuBlZLLwGs1XrAU
	hP9DMzSh5TQkGC4yhEDRL2E2xXteNUsux08+Wc2YlEnNJsKLXovKcq2phRiaRBtXUaUqrM1Q1ay
	ldwo5iLqI6D0iLHr3BM2VWaXfZAHXy74Puk3RIQyAWopgAlPx5cQhSSDQ+TkqDUSNww+YxiFrvx
	D91ZFQya0oCke50YWqJQtPa51wLf0j68rIfjf9/jDoyogGid3WAieuVdzsmvKBJFFUehJf27L5L
	tKrEa6aScXY+dD8sdiNDdMsfiwzbPI4n2sFSiiB43lJtz/CPqD1mf9Wj+Xe7MY4tMFZiUbOmbX5
	+UVWZF5E2yn3AR78j1cAbrw==
X-Google-Smtp-Source: AGHT+IElDPX6u20sc4jGPjSUZZw3qo1ZEYivqxwtIPDdkwEzTDmmDNvT5Nl4muFEx+julDo++r1G7g==
X-Received: by 2002:a17:902:ce07:b0:223:5e54:c521 with SMTP id d9443c01a7336-2265ea35407mr58249745ad.0.1742484289793;
        Thu, 20 Mar 2025 08:24:49 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4a8fsm136905515ad.234.2025.03.20.08.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 08:24:49 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 20 Mar 2025 23:21:58 +0800
Subject: [PATCH v5 08/10] ARM: dts: aspeed: catalina: Enable multi-master
 on additional I2C buses
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
Message-Id: <20250320-potin-catalina-dts-update-20250102-v5-8-e161be6583a7@gmail.com>
References: <20250320-potin-catalina-dts-update-20250102-v5-0-e161be6583a7@gmail.com>
In-Reply-To: <20250320-potin-catalina-dts-update-20250102-v5-0-e161be6583a7@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742484265; l=1008;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=EUweIVFlYiMF8bhCySW4H9ia8wPetO4bJ+6FKYLTF4U=;
 b=kSwteKt/arVVylSZep8fMc7WzfoOs3oC1D9o+m9HYvsgOQiQth90tnxsRf2VTGYVDfLpsy4mP
 dIl4AtyZ4hDAbZWkIA0376ck9AuceRHGOiZ5GZ3b6BUT8stH+r6v5DK
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Update the device tree to enable `multi-master` mode on I2C buses shared
between the host BMC and the NV module with HMC. This ensures proper bus
arbitration and coordination in multi-master environments, preventing
communication conflicts and improving reliability.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 1e1bcc9ac2f0..abf15d322605 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -815,6 +815,7 @@ ssif-bmc@10 {
 
 &i2c12 {
 	status = "okay";
+	multi-master;
 
 	// Module 1 FRU EEPROM
 	eeprom@50 {
@@ -825,6 +826,7 @@ eeprom@50 {
 
 &i2c13 {
 	status = "okay";
+	multi-master;
 
 	// Module 0 FRU EEPROM
 	eeprom@50 {

-- 
2.31.1


