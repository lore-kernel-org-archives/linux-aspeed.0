Return-Path: <linux-aspeed+bounces-487-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C75FC02183
	for <linux-aspeed@archiver.kernel.org>; Wed, 15 Jan 2025 10:39:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YY2Z53mbTz30N8;
	Wed, 15 Jan 2025 21:39:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736937597;
	cv=none; b=EL4bAxK1i93zVs6n7uBAjVZ2KuBkyaO+rDkQQ2ujXp8uWGp7YRu+jRRJL0OVMWM+NUicsLcqXmhr4K0Copc1bgzdsQh2CF/ZweLnEMvjWHBwzGVroaeVFG//McgiysINIfuMWNYdcasoCkPeDARs24NciQFGmZG52W0pGpw6beoKu2r0uRwX76txag9o7JpmfL0n2nqOsWsOCWZigPA5iCupyfEJ5w73LW8HO/PEzb9fH1U4fvqoCoiNVAlvXvWzGxDw/VSUiUvf+gtfWmDXE4897Pxu1u5NPSAOtAhSTY13EB3ZbGGO5qb7Dfa4OLYrQDqQAaQmllvzRBclNKe8cg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736937597; c=relaxed/relaxed;
	bh=OX/Tra+iC1Y8QVUgMsncLLlp+FGKhTu9wrEl8cIWaXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OTl7Ypi9eh+XL+W3oOpH6x6Pc1d771VcOhd4Jxjym7J5mCLjqNZUZKFzoqsoK4f9h+SrmyicPgE0hNzc428u5ODH49kXPNI5qQSzE8kgf+C4nGx9T/k/cHjE33ZHteYmj9G2n6JQDRuVwp1LGS8isZoUACor6V1hYx11u6iqTV+Ql6ETxVjHz+ZNiKn2inKGKA617P89wdUKhUVPgpRejSsW0UM9H2wvoRhjdM1JdAfu/xqSJwJacbAMiYpWdlr8LlliE/aZlJMTkZjqyAsuRSN8mFJjueOErqR6LsZhKm9EvgiKgxXi3IOXMzCivhq62p+ov6iN+OAM76i8z2lQFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=C0cWsZNv; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=joel.stan@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=C0cWsZNv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=joel.stan@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YY2Z372bnz30HP
	for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Jan 2025 21:39:55 +1100 (AEDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2ee50ffcf14so1094990a91.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Jan 2025 02:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736937593; x=1737542393; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=OX/Tra+iC1Y8QVUgMsncLLlp+FGKhTu9wrEl8cIWaXc=;
        b=C0cWsZNvm0lzlGIOzRtZ8ZV9MZ+W861Zz0qRDpoR1T2ON5AyQh/7i8KI4nI3GMDVKa
         P9dqB6zZZe9AyRROUmyGpbJ2Svtp2E/eVlLip0CihmJOsZIHynVAf0/N/x65LqEASavJ
         n9sN7onn5R8NrQ0/bXmI/fTWSgu2NfpqJlAatCADeuRMYuyuozMra3hPqyN/78TwqENX
         jsJMNuj9OpEcr+CBo5zJk6lKTFgZrqpaYDTzE/elGeCdCjzmHCa4J+Qj4oLiBmqA7T6O
         8M2DhS0iUTEp7NAU/TIxFjbn4eZDsW7CE229Ca8TJbyBFIWOdmc1ahGOGIYgh9f2tHCo
         PIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736937593; x=1737542393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OX/Tra+iC1Y8QVUgMsncLLlp+FGKhTu9wrEl8cIWaXc=;
        b=J9ikl3OggeImqVfttM0SSVHX3PY4ISRwbOHJLylNI0/lStN7O9Z5SStts9qWGtRAsG
         jEDUkOO9lUpd+/Jb+3qhbKKutRq6U+jrnh6CAx8xZr8vVKGfsxH7m10zsIe2TlJJvsOi
         1cIvXsRekbUZGB8tbNw+U98XhXsO1Fcp9duYGWThX1rsCuQDaaR7v8PWE9K7ZOm3kqRD
         b6y3mg3uXzTWtES1EwEP1h5MAzTpCACppRdu/jmNDFuwqnEJY48kYW/yjCiRTFlekB2W
         9c3ClBw5m3cB3LjAzOlZlQRjmTHHunlzo6EM6OsOWcHUJeXwISP/rfVXN/0y/6AWCc4P
         L91w==
X-Forwarded-Encrypted: i=1; AJvYcCVaivXF6437ZXFFpQp920mMTYVu6qDH5Dpksky6p5/zYp3TyDodtqExD97yHMaCaWwRk0FMsCzxSNwLbQA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzR0xiOtUt865+f31Zsiuiv0iZ6HLkIVDcKTRlyZysHUdLW2m3I
	4h831OjHAbDMK0/Y5rcEsgjTlTpx0qm66lT87rbWD/8p/G06Hdsn
X-Gm-Gg: ASbGncvwb7KKC+K1CjYbw1LZG+bJDuBtUplQNpLM+aMRhjIPdUQs44w4Bapm6OaRDXs
	DglmRq/jnEOCcqtmHPxzZXLTfeNHT7OJmuHpSzVWd4LQfayw3UO7gpwfYLeRYRqWs7WnadVn+Qy
	ovMqWVoTk7PwJMZp//nTKNYYI060rMYaOYprjh/GdKj54nOslJdia2p2ttqF1M5uGpgf+eHXdLh
	5EslvUjq028haMbJWqmp/TFJUhnOvTPbkCIYFa8t5kkYkoYg6C2
X-Google-Smtp-Source: AGHT+IEKVN7WGT9GPcFhfkZNlMUXgmym0EXxg2Shkuwydza/uh70p46Sq7eJrL7kL3M/TYHp1jIa+g==
X-Received: by 2002:a17:90b:534c:b0:2ee:c30f:33c9 with SMTP id 98e67ed59e1d1-2f728e1cedemr3692871a91.14.1736937593001;
        Wed, 15 Jan 2025 02:39:53 -0800 (PST)
Received: from prometheus.lan ([45.124.203.18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c20a9bdsm1168040a91.31.2025.01.15.02.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 02:39:52 -0800 (PST)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org
Subject: [PATCH] ARM: aspeed: Don't select SRAM
Date: Wed, 15 Jan 2025 21:09:40 +1030
Message-ID: <20250115103942.421429-1-joel@jms.id.au>
X-Mailer: git-send-email 2.45.2
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

The ASPEED devices have SRAM, but don't require it for basic function
(or any function; there's no known users of the driver).

Fixes: 8c2ed9bcfbeb ("arm: Add Aspeed machine")
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/mach-aspeed/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-aspeed/Kconfig b/arch/arm/mach-aspeed/Kconfig
index 080019aa6fcd..fcf287edd0e5 100644
--- a/arch/arm/mach-aspeed/Kconfig
+++ b/arch/arm/mach-aspeed/Kconfig
@@ -2,7 +2,6 @@
 menuconfig ARCH_ASPEED
 	bool "Aspeed BMC architectures"
 	depends on (CPU_LITTLE_ENDIAN && ARCH_MULTI_V5) || ARCH_MULTI_V6 || ARCH_MULTI_V7
-	select SRAM
 	select WATCHDOG
 	select ASPEED_WATCHDOG
 	select MFD_SYSCON
-- 
2.45.2


