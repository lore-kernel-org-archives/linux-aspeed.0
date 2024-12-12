Return-Path: <linux-aspeed+bounces-192-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDEFE77182
	for <linux-aspeed@archiver.kernel.org>; Thu, 12 Dec 2024 13:34:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8D3M1jDKz30WD;
	Fri, 13 Dec 2024 00:34:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734010479;
	cv=none; b=iGwbizKJIiJf1CaCXwm+XLby9Ij0fO2X8XET7nSWcyLohSLzZFGUiAzWi2LyEHE6xmuWC2ygkt/5DDfwgtVjQvpO3ZGg97bClscc2cXI81K5k/I30343Mgiegz9vQ5wpLjNwkMh85gu0lCRVke1SuQ9SywUwEFp9yXeu0+9fXs6f0s9AMo5ubUxEnfCPQYsncLnZe4Z2CrCRg/qTV24YdBAYhSaT/r7uCvxuKlQ+HoANsoxjAJZwnEQuFFP0mb3HF05T76+huwDW+GdRdy9RYrjDKMhsuJ7aEqAAINF5bYqET+HUg8GML1Dw0aI0bZAzIuXSr+K+JVcvbVyMYAQsmw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734010479; c=relaxed/relaxed;
	bh=AKFRdWgT/v4NOhdFzS4ffyMVT075WEVDQYQZtJx6dJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UjEtWTeLw1Wm/Qr/vSEjkLF78jQFgsaWjWYPOTy3/Z1jjjgXofW+OenEYjURTw6LPA37jC3PmQdlKAC+kG6vpgsPyXBhl6cKoBkiZbH4zQ5m1pqCZeqqG9ekwNPfToBeqIfpHwJZqLAuBXdy+6OVnaYQkANfgpd6kDJdmne6jc/xk8rNfTVg2RIl/T9wM9m15C2Ilx6HvgaEcAOUJ8p8PnmgHDKl15wiz7wz7VtLhycVUhTE61+zRuJqLKBIexMbc5U3Q5hKe9GW0DWwzKc4LoCQJN2NxZwuZnbfo5ic7r3xgrvbBQFud9uQU9zEi/kbkmTjgaEMEXU6KtlbxnbXfg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=EaocTO2e; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=yangchen.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=EaocTO2e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=yangchen.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8D3K1p6Cz30VL
	for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Dec 2024 00:34:35 +1100 (AEDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-216281bc30fso6876615ad.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 12 Dec 2024 05:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734010471; x=1734615271; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AKFRdWgT/v4NOhdFzS4ffyMVT075WEVDQYQZtJx6dJQ=;
        b=EaocTO2eNo3jLGZNQNluRvk3bP5Ruhe5pXpZkV0lS2JnCbl+So+/Jgp2t6F4H//xgj
         f4AT8pfKlW4UKH/e7qrjFtBhsLLBLTYc5/jotUD+r/qGnuQpWurgmCTR7hWB2ty/CzhR
         qA1UAjCzzczP40Kxw9X4vI4zZcfhMr7MkVTlXEFooCSEWachRausUxHqbgQAIA5OI6G5
         C0VCKY2lf83Ho4ADhurYCwlIOzX4WkgRaj8ATMMHayo5hNoBcZrvlfJR8cpz9jI2bQM6
         LqON/hyuFc8blWyepoqsSBNZ1x0jU1mkCwrHigtepXBZ1959IirDUeiW7Irh8uR//y/V
         SZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734010471; x=1734615271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AKFRdWgT/v4NOhdFzS4ffyMVT075WEVDQYQZtJx6dJQ=;
        b=aONuDjALuE4yV8bWqXYdCxE27jmcoaqztK0wvFni5J6ZUkNn7bMMLiLiIW2hvnwLup
         0FHhBXLBBadD9t62lJ7T24z8yOhX+BWZvtn17RVESwuqUtVf0XtkF14BAKWIX5Ml7pxg
         TjzCty1ig5xw6kFpJzVNDWxXNiIfkioyx518YXJn4FTEwU7NHj7rDnjedtkCSg05oe85
         QsvyBPlbkzrJ4R5cwQRMe3KY4305DLXq2VzTk4R+3n4dGb3NmxcY7/uriKUIY7Ec/Gvo
         Yvs1NqcCUz5Ou8j3N8m6EHDve7OZrRYZm82djTQjdxTQdt75LdVqY+8wsWK8+3w6C63W
         VVkQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6CjhrVjb/+QxveauThJxID0uYeqyMdwzXSGnRj1Jsj28yT7NaNTq2iLnbvBefF46nF5DVg7qh6it2INE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwQjS4wc4VyrqLSoPUH7DEk6zDuxCrz+W1bZBxCU6NCrA2JPySk
	7uoOjZC08EYjF8TuL/qrlXdzwcnrXvtTfRasXCn3g6FgE1m0HTWLCVfvZQ==
X-Gm-Gg: ASbGncsNPk85qsWzWy9Q5QQzPQoYbCs5JuV+bX657it2e5axDVHX0WhkcxB8gzCQo3X
	yLLsrzk6/Bftfbjvm8RmiZQCBt1Oc2tzHlVXorRwoLlAZoXDfKLTE8PR+GHAjn2/Cog0klEBi6h
	AFFK7KbBSKi0NNq9k3eZpBH14BKQ687jsgEOE2Cgcau8GEZsDNhfhPN9YZWnRXlcxaoMUXP4j1B
	EbEgZvCSaSOyYxZC7C7ZZ6jIywElSE6834oFro9BwFrnA8FSupMioz2BX2xWafkgXgQGsEC3E3/
	8f/2lUVkwrE0lSn1KarMyA2QsJvwSvF30PPqq97cBObWX/1ZcggeA2XmfvA5cDCH3fJoeV+j/SI
	GFob+
X-Google-Smtp-Source: AGHT+IFir8bmrbK56qwR6cJik9C730y6CMb6VE/C33OoWpwM9X30GYCxB9rlmJ+qw66LkELlDihuyA==
X-Received: by 2002:a17:902:ce92:b0:216:48dd:d15c with SMTP id d9443c01a7336-2177854b4f2mr84668205ad.27.1734010470917;
        Thu, 12 Dec 2024 05:34:30 -0800 (PST)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2163562a838sm83390165ad.29.2024.12.12.05.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 05:34:30 -0800 (PST)
From: Yang Chen <yangchen.openbmc@gmail.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	patrick@stwcx.xyz,
	amithash@meta.com
Cc: Jerry.Lin@quantatw.com,
	yang.chen@quantatw.com
Subject: [PATCH v1 0/4] Revise Meta (Facebook) Minerva BMC
Date: Thu, 12 Dec 2024 21:32:22 +0800
Message-Id: <20241212133226.342937-1-yangchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Revise the linux device tree entry related to Meta (Facebook) Minerva
specific devices connected to BMC (AST2600) SoC.

Base on:
https://lore.kernel.org/all/172722509817.374662.7338401100529556748.b4-ty@codeconstruct.com.au/

Yang Chen (4):
  ARM: dts: aspeed: minerva: add i/o expanders on bus 0
  ARM: dts: aspeed: minerva: add i/o expanders on each FCB
  ARM: dts: aspeed: minerva: add bmc ready led setting
  ARM: dts: aspeed: minerva: add second source RTC

 .../aspeed/aspeed-bmc-facebook-minerva.dts    | 523 ++++++++++++++++++
 1 file changed, 523 insertions(+)

-- 
2.34.1


