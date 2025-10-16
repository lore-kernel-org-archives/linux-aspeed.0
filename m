Return-Path: <linux-aspeed+bounces-2470-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC8BBCCD194
	for <linux-aspeed@archiver.kernel.org>; Thu, 16 Oct 2025 05:29:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cnGjn2BB0z306d;
	Thu, 16 Oct 2025 16:29:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::536"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760592589;
	cv=none; b=TgAYjVjEBKnp404elZrvmnqXxj6G8OXlTQZK5Rm1kVRuh9kovE3P2KiJQolxdpiLuBM6tDlV611FAwnyxzjMvLsLByUh6K52lOS4sWotvgAbzwFE+psoZvXZlNAAsmZWHpOha/p4rhEdN859I+jJ95WoUCCFvOaC3ldUdlXZzKCXozDHaa6fq+QnZJYRlS11aCK+1jK84lmSxNOZxSJyKozN6t+0S09eOiXWimLlDsCVZTPWB+WjkqRhIWhpmkBEc+E5CdIxHPkxqmi++V84kTTPBe2A8d496uH9CJIDQ2SsD7vIS00TQbY/2noGj0G7VEt+lcR9XznmZ+HPxN4ehg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760592589; c=relaxed/relaxed;
	bh=cZU/PvsO/Y2NbI/2LYXn5EnCITnm++nCSaU9RCrcRDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L3jksZEujCRnILa0ohK+knLiApiDu4pcigw+gVADt/CCOmwgBJXhK7R5uuRaYsT0QktAG1tmylsmsI3YMk0znhuKb/xZImfiTkJKYGddUbN0GGY3kjKBbxwfGCl+AcUmPJAqwYdTzzWoAvch5TvbvzJUpGvQ2+nlchJ2Iz5cVE7q1lvInNOUOcV+SyF1MXPX5W5lRO3iCS2DM0cnm3y4FA1gCfMPgJKD/XJK2SdAVlSnUmKUyqApqQjTIGH51ZvcPuw3RXDw3MU+279X4znSkTGZZKCKw7B6f8ya5osL253NGUa/ueEefigbxrJWPAkkJiufgn+7jTAGZoa7axh4RQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=FX3vtdqc; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=FX3vtdqc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cnGjl6JYgz2ywC
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Oct 2025 16:29:46 +1100 (AEDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-b5f2c1a7e48so196392a12.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Oct 2025 22:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760592585; x=1761197385; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cZU/PvsO/Y2NbI/2LYXn5EnCITnm++nCSaU9RCrcRDk=;
        b=FX3vtdqcxN2GA1U88HtkupwtJ+59gUMuouScBTHExx8W2qfwgFbJbPxNKuCNj78trh
         gOQeqq7wtRR7GRd3Oq9uhkqbnf6x8ycwG3xD+duqWldmYDrm7CCkxWOW4L2bIEYI3xss
         tUZOPBPu3YvpmmORqv/i1RoHR/gzlHf9ewrMr8bWuJcpJOhBprDj72FvtdZ2cSjmH3OM
         6xfxm+adRkj/lWmQJwRI+BGevkSaBX385ewUAKOoV+PLadeajTpSB1CI26EkAkmhMORZ
         UPdWxpomjI1N/b2xiWXzlSzrTE4CX91H3DX9mOBOGsBvIvIyogZXt7M0ef1JEa7ZsIh6
         DSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760592585; x=1761197385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZU/PvsO/Y2NbI/2LYXn5EnCITnm++nCSaU9RCrcRDk=;
        b=b0uKzUGiLYaLBfJ1TBnGyOJ2hPSQJpzsQEuKZ3+G5VQnV5xvYmAD3SMeeA3F7OMxl0
         ifLNiRI9jFkIlOzol3+6UlaTh5JdSe4Bo2Ra/whoIk+v16qkuduS1+M5o90FTnLBLZhl
         +EZ9MGVqaH3qoSvHs8ieyDnlWD1Ri7eB9DYgP/4mvuWe8TkmS90p0PBMBDeMsC3XQNxG
         ShP6hI2n8wdt707lCqYZ+cimllnOcn4z0wfCx24BMmSWIusJBTPHVUU8sPnGGe7m1R+j
         02Wr15LA4pmLOGHyElSiZxWq/BtCX7pnaXpeulRAkwLzq239aqE8oD7/ImqKF3gemXiO
         A74A==
X-Forwarded-Encrypted: i=1; AJvYcCXT6yogRW39OsqJjDbePJl7abzpqQ4e7poUQrjVHy9rYiDYommFQnG10luI5sHwciDonGZ9NzJGBAfiTS0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwDX9hMJMSkIRKqsKyHb3GOHgGmDeaIvU+32AVZu6L/8nHeiLQL
	6hKOAfUPbHdDPqzH7Fe3xtf6CWPgaYEGtk9KYQYmkh6avuNW5eGI4iKx
X-Gm-Gg: ASbGncsb//pUzNBJB7TTGgMutpmxbbN2oV/Pjq9lt/8mGQ5Myfivz8a9Nt39rg1nmzy
	ULusGOAX7mSwVFiyBKJ6KJiHc1FRfVY61/sdZV5KMU9u6BdYbXUQovVDOV8oiAJqf98r15tVxuK
	Uqog1RZoEEDV2Z4tKINV0s7ifeVNMrYNI1VGHq5KsW+ay/aTmIV/zwwqNvr2G04luU6RsgBW+FM
	8JLrFtd0JjIU+xp9eBndmKtMAZLJX4k7Pc+rWXS/0496OnyNtxyVG5u8FXPT+bHxrAUuQWkGSY/
	YtVCL483jWiJCvLlwIqA3AsYJ+MUFFHlUsDj5XKNl5aK7C/Lluvs4ztmPX9CGlswUAbb0KgQFRo
	+ODlSIPjGWGTOY0n1OBeDi3nLro5GN8JenPUnMW5lkFHnhL6KxUIG/mxZjd74+WGAmaip6qGN8D
	ow48jVho33uIwcNLqe0rKj9edWVF4qahGfeYsG6vHJp0o+mcSV+u1A6pF8qEGAq8QAPyq8SrO0m
	AynAVkPsb+q5FA=
X-Google-Smtp-Source: AGHT+IG6DkPdWX9xJzohk/tu0oSUnnb6SXO1oOB1ejn2LyoFqbU+fIA4QwSqj9cRtFoRS3F/p7/w/w==
X-Received: by 2002:a17:902:f785:b0:27d:69cc:9a6 with SMTP id d9443c01a7336-290273959b8mr383548325ad.53.1760592584688;
        Wed, 15 Oct 2025 22:29:44 -0700 (PDT)
Received: from cosmo-ubuntu-2404.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099343093sm15742015ad.28.2025.10.15.22.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 22:29:44 -0700 (PDT)
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
Subject: [PATCH] ARM: dts: aspeed: bletchley: remove WDTRST1 assertion from wdt1
Date: Thu, 16 Oct 2025 13:27:27 +0800
Message-ID: <20251016052727.881576-1-chou.cosmo@gmail.com>
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


