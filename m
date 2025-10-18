Return-Path: <linux-aspeed+bounces-2515-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD5ACCD193
	for <linux-aspeed@archiver.kernel.org>; Sat, 18 Oct 2025 04:35:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cpTQ53J0dz3cdV;
	Sat, 18 Oct 2025 15:35:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760762125;
	cv=none; b=nDKwnm7IIPSjvlcOZ9JtfBCF0WMDLyJS9J6nJfcsXaTAzib5fB6l2zLNGlhOMevLeOvObsY9j/+/CKfiKG1A8ifremGv4PjcExefrARhxflSvT7vOBx19AAfmI85RSwQTX3iiIW8CFT5nT1N3VyqN9EctBTxc0ETU0pWD0U7PiZzKWgmbVdNgAk5lafs9G2w1n71Rw347G7uikA8ul0WRstaAxujZHk0tSVWiQxOX2dkaazcqO2ZinSjLryxEvIBVtNnwldl+ANcY2koVMNa7WgScOzViMm0Wnph+oj9SEmGnd6dsn8Xwr/pS9srcu7VZZAplYLQSh9xrDuEWAGhEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760762125; c=relaxed/relaxed;
	bh=FwE+FlafPdFDMuivWnU+BJHVFOy/nLZHlq4G67TTc0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C+TytifLTYPbsgAQtuqjNXzEUvjUhXG/AVx2SqXpoRAwbTH8OZqwY4Wxvlp+QeGsHKBrrW/2SI/fBK+X744QgZsev3v8uTeuSmLomkauGkHLNDl9rblVBPS7PxpIYu0TQpABlZ3U42lSHyphutfH165gDhoXiyl3+uXw7otiGFAfr868O569sOyo7IHXOCZjU+9ixJjCtOCUkN1ynWVIOmo6KW0uDH3i0wJqaL5cyy2Pjt8jLQ/E5kdfrFQmJAlfSu5AjKfGzSPxeXidwHhtu9sw5jfwWEGI6m5u5N+UfUuHHC+jXnG91WQ2c5ZApwtQbelVd4Z8o6qXvKl1XHu4wQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=eF52snIX; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=eF52snIX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cpTQ41nrPz3cdG
	for <linux-aspeed@lists.ozlabs.org>; Sat, 18 Oct 2025 15:35:23 +1100 (AEDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-26e68904f0eso26494455ad.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Oct 2025 21:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760762121; x=1761366921; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FwE+FlafPdFDMuivWnU+BJHVFOy/nLZHlq4G67TTc0k=;
        b=eF52snIXb7+7XXpOqjTXbKChtK9/P2D59QbJZs8AnK5USZGH7L14KpOvqQlbnF5Sp3
         4YSyupfpt0a+BdA1bEMaFBDtxAa/wbpRKntVu13+VIMpGmMrlURO2uDZgDRcoSa4bH0h
         ihC9nGvoeQskc9x1bKbozn8dzrhIVpWIKaeIiU94iZhiH/sHopfrckm+p9CEUbFKK9Rx
         UX0+Q0ykp5vPlAgCu+Homp3/KvEBUrTeTn1gN00h8tpgh3fFJgLB+4WzrqgHuJsEIQRw
         q8/c5ubTN1sP5taCYdnI24Om02gq6v3ZR1DHuaJYhf6CMRyKrxLgXC2ateYu8M6vK6L8
         VGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760762121; x=1761366921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FwE+FlafPdFDMuivWnU+BJHVFOy/nLZHlq4G67TTc0k=;
        b=AmoUaQhLZ64ENNAc/xiUfFZ8rYnZMdvqhH1hr02pUTeBjB20bkjecSugOHVK+njv9c
         gHJLRDsQSM8JLDEGObTuge5rRmOa0MMoxIY0DuIjn9aQInby+p99oUTzFWx+wB+sO7no
         C+ARu31cWAxvcvR9wdVAXCIs0h3TcDM3jUS6+a7aFlim5NOCNmaMiUch5hVb4pBUfpac
         bfg0q2Zixh5JZvOgMrpW/7ISsPlAS2vu9rBgzwqpb17dfzt2t2swy1BRNwPnb1rcmVVB
         12b7808jlJ8gtGLbDMZXzJe0pUppoDDr2xgcJIDZ6W6vVZJrWMOeS9EbfXb+n04OI9LO
         CMlA==
X-Forwarded-Encrypted: i=1; AJvYcCWuMXMm8h9VQZfLH/moQIHUdlBRtaal64s+Pb1A/BXapNI/AIkeZ9vJ8VVyAn4kSvyNU0HceFoZG24uYi8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz38OIBierNtAmYnXkGhA0cb1qjgRfPr3p97wNXu9BH6NPIEG0a
	j6edZty2+z6nSk40FFuf7Byj40cv1c1p9G371tH+lQO7FWDue8I67wyH
X-Gm-Gg: ASbGncvnF5SGeSKEO2GY2FX/kJ1l5Dv3ejTq88cfU1CLPYqFH5DTDcYh09NpaEaG/Xg
	4VRSB9lUDjWsbj3ddVYmUrDCvdGmI8MPDH3wbuse5byoWREdt0wgrN3+Kybp4Qm8PnEUYawTqpZ
	k4fcakEbjETaltBpJDaj73f124qCLzX2Dv8bgFfdaMg7gn1OttCg4f6o2Jk6wwib1lpy4awJWfV
	osZ4a4FbUskhh8sB/0UCJXm6IHIhA98UTqSav0ePReY3aFCKQIFbegQK5l+DNkDkKSWRxZNPaYR
	WZnjE44qWDxK2HvAdTLszMTxhzJb3ztFxXsJualzeHHw/VaVfK+dpJhGCcNVCHumf4GXgGyR9wj
	hO1AezNW5ByD4unujRWXMQIcJDfe9pjMuyoE4y5sa+B+ycBgOQiosZcm6h8J9WnFzu6pLd9BkIF
	8XsngyJ5QlbOdNC7fVqbemTH/z7PN9Hi0EZdGPxd0D9NsM7cLwurUrXispK3w1GRUip8kz0A77s
	ID1
X-Google-Smtp-Source: AGHT+IFjj+JR7R/Q2O8WxGOAy+zB1ukpFPQ6elAKB9VmH+ImOjLf6iOrU+WTRyaZ3nV4hWJdz9cmxA==
X-Received: by 2002:a17:903:3bc4:b0:290:b131:31dd with SMTP id d9443c01a7336-290c99aa9a0mr69186125ad.0.1760762120750;
        Fri, 17 Oct 2025 21:35:20 -0700 (PDT)
Received: from cosmo-ubuntu-2404.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29247218eafsm12167715ad.101.2025.10.17.21.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 21:35:20 -0700 (PDT)
From: Cosmo Chou <chou.cosmo@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	cosmo.chou@quantatw.com,
	Cosmo Chou <chou.cosmo@gmail.com>
Subject: [PATCH v2] ARM: dts: aspeed: bletchley: remove WDTRST1 assertion from wdt1
Date: Sat, 18 Oct 2025 12:33:09 +0800
Message-ID: <20251018043310.1056032-1-chou.cosmo@gmail.com>
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

Remove the external signal configuration from wdt1 to prevent the
WDTRST1 pin from being asserted during watchdog resets.

The WDTRST1 pin was originally configured to reset the TPM during
watchdog events. However, the pin is incorrectly routed to SRST#
on the hardware, causing unintended system resets. Since the TPM
is not currently utilized on this platform, remove the external
signal configuration to avoid the incorrect reset behavior.

Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
index 24969c82d05e..abdb1562115a 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
@@ -1080,11 +1080,5 @@ pinctrl_gpiov2_unbiased_default: gpiov2 {
 
 &wdt1 {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_wdtrst1_default>;
 	aspeed,reset-type = "soc";
-	aspeed,external-signal;
-	aspeed,ext-push-pull;
-	aspeed,ext-active-high;
-	aspeed,ext-pulse-duration = <256>;
 };
-- 
2.43.0


