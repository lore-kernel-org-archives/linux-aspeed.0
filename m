Return-Path: <linux-aspeed+bounces-3470-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E99E8306B
	for <linux-aspeed@archiver.kernel.org>; Tue,  3 Feb 2026 09:50:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f4zJ445b2z30Lv;
	Tue, 03 Feb 2026 20:50:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770112244;
	cv=none; b=gxNkvqj0yyXTVsuePTFvSoVV3X+2y3ULYubrKoc6gCN46NEzL6HN0Pnlv07kXwa322rvBs44TtjLiSHas5LN6iQL5JWe4jpF2j5i4RFZePnSrwFsRMiPZMlq8wN6j2VpGORgqFe9y63rqIddg1/E0nbkM4bhL6Av2a7aV2Bim2WQEC47cc+vYynfB0Qh4AHaGc8GySf+tHA1jBfdpysJZucnMC5xSQ1Ilx8XOr4Iqc8yIWCBU5TT+xfo1fFiTWkpzfp24YtyyHJGh7Fpw/7kRrHfhsASSbWMSWLYt3et0VQa9CvLSklLOTvGirjVrD3i184WOg+hm8WzsHhmVZGwqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770112244; c=relaxed/relaxed;
	bh=RL8/ntmLbz7GfoTyFS9PYa6ILY9/8FH2UwySorYf6Js=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZsQnvm+1zpSJnsmamZd/qqsgim5d8wiT4it1celfIZOyByo3AfL+QMmN0NtahM5Qx0Y3lTXAL5mxGB8RfpnFRfGk2tJWlhMYFnM0EkH+8UyEN5bYhcq5UerrxlYZURUqWeY0BtjGE713YOICq/HbPUkloOe+dhQQIsxjfXgojrRuio7mcrLkCLbizHVRec3d70wRkWqhjdlNFJj2/0CrJpk5no/bvsrjR1P822FGcho5omB5QKZAprrlHg9XFp4MZ5F7p37L7OKJq/ghXTgNRJxbvWiq0hxXjVbdRv+36325MsBBzaGTBa23oZR/qb58qCZ2dnPnp++4GCtWDE/Ehw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=GxdhAoLT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=GxdhAoLT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f4zJ31rCzz30GV
	for <linux-aspeed@lists.ozlabs.org>; Tue, 03 Feb 2026 20:50:42 +1100 (AEDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-81f4ba336b4so4528391b3a.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 03 Feb 2026 01:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770112240; x=1770717040; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RL8/ntmLbz7GfoTyFS9PYa6ILY9/8FH2UwySorYf6Js=;
        b=GxdhAoLT5ST7AVQd/nYNAXy/cm6OZaK+ZrHAPQkxUrW1zeprcjshRhyI394Jc2WG8r
         9zQlTf+5wPUIcRAYg98Xo0TzXKmglrt1Cpyd/bMpqYgGpoWnxqzsAtVCsKBngZpAzV80
         Tgce2zBF/EKWgNjFbtCI/IEO81hK0d5PGksne0RDIzwUk49B10mHwNjbEPm0VMaVElLi
         YHvPHJ0TSOV/WQnn4WS0yGY57CChJJcNnfF6gMrUmv5un6ykxpgI5bbv5RRjZSBzEoyO
         AjWiK9eqUUseGIjDm37d3j98IAwb8ISZ11iQR/MD8zU7TaijX4fowS9vlLR0g3ARKNf2
         7VMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770112240; x=1770717040;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RL8/ntmLbz7GfoTyFS9PYa6ILY9/8FH2UwySorYf6Js=;
        b=eXxlwPcjUyA+52qFBAc6CrZfxdPITCEPik92KQrY+ftxFDOrjJMCrBSWw+FHiySOYo
         DDKdG4gNLptlNQEzjOkt8RR0BfsANUzrD9yjV+8vmFMsGJMsmhxULklZb9AQjG2J18tM
         zLD65svMH2qZ0SgYWcpHZ67CMGmfDVa1DGeJNDL6b3455c6WAoAhChCVREanwLO0lBLj
         HuYk3jF5phzyqr8jJMLfr2yGJaa7uyc/3YsV3KycGoktzqGJ/882Gan4IJ5J03hAbtOf
         oaV7uzbXEfvp9mq+wu5+rfnhbI5KQWtLctfio7S5rj9zOb1vdR+ZYFs4cGZ1UNBWE+TO
         2Gsg==
X-Forwarded-Encrypted: i=1; AJvYcCXZ21IamoNwKcg3DIsAlMc7Uc6cSz1I1CJ9wiValELgnZ2dgM1ZLn+fQ8IBUTyif9GnpTslZeXBQHiwjxA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz7pgYg5PdNRqv8OO9F81kuw80/4f1g9KUUc9WjZSsrzSdnmAJY
	eeKcLsi1oUgTedLgYuxX/0Lp1NI+nGA/O9xrAtF5rUQT+rXFE3TeVPzw
X-Gm-Gg: AZuq6aLaX3BJLm0AQU1LSRnTk34V8mRL4bQiMevM0SMOgyulDFFwjhBDwU8Rnxlo84k
	IudLLGl8CLpcGRN5eKcl+q3rhgKiUWWGoIYy29BpEuCG1VulH4/K1vh8oj4SF6E3K2tAnGARWhd
	k0Wn9w3UgO+HcUcZu0I8IeH0pRHrCmaKlH28hm0WcTK2JByXPk48jdJe0LLi3uBwomecDxkt7Gw
	FYjrI6vdo11t6Um1q25NMUhDe+s+G44mYOdemb9GohRTfqPAlQKSTthruEWxJqLiqO2VFfbNeLL
	yIITOZwinGApMIvaZc1hFeWlFPu27PVyO9wkZcPwE1BeOBxrFBC8qcvOq1p0eswMIV6YqvrtTuD
	RRTm6BJXqFV14dzVtBs2v2wV66IN2ghWWtIPPeVYMTZCnG4+8yMTudeJizmFXCfw/Xmt7kTwiYM
	+wilw3Ddrf12JvUOD/vNFwhqup0acQlmk4ZUk1+xQJwnfFZUAXu8vW8R7KDAmzceI=
X-Received: by 2002:a05:6a21:790:b0:364:1339:97c2 with SMTP id adf61e73a8af0-392dffffe23mr14554241637.14.1770112240073;
        Tue, 03 Feb 2026 01:50:40 -0800 (PST)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a336a1csm17535332a12.19.2026.02.03.01.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 01:50:39 -0800 (PST)
From: Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH v2 0/2] Add Meta (Facebook) SanMiguel BMC (AST2620)
Date: Tue, 03 Feb 2026 17:48:13 +0800
Message-Id: <20260203-sanmiguel_init_dts-v2-0-6a5682c32b38@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAF3EgWkC/32NQQ7CIBREr9L8tRigVq0r72GaBuFLf9KCASSah
 ruLPYCbSd4k82aFiIEwwqVZIWCmSN5VkLsG9KScRUamMkguj7wGi8otZF84j+QojSZFduq1ube
 t7rjpoA6fAR/03qS3ofJEMfnw2T6y+LV/dVkwzjTnslV4EOe+v9pF0bzXfoGhlPIFOhJrqLQAA
 AA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Mike Hsieh <Mike_Hsieh@quantatw.com>, 
 Potin Lai <potin.lai@quantatw.com>, Roger Kan <Roger.Kan@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770112237; l=903;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=u0zWzVB/IbD5oQY4O26nV5N+KWOpDsoPDXV4B5J0j6k=;
 b=bjYFW176Y/+F1LIHvROPz0o13EZ5avX9lVW0ZmD/Tox+xxQ9TytzDUNlUSeAowYi4jCsnzI8C
 2CPIP0/fYiVALW2Sj/kads1HKs1Q3uxEeHj1TneJL4J/lnM8IeErl6e
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add Linux device tree entries for Meta (Facebook) SanMiguel specific
devices connected to the AST2620 BMC SoC.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
Changes in v2:
- change mac0 phy-mode to rgmii-id
- remove max-speed attribute from mac0
- Link to v1: https://lore.kernel.org/r/20260202-sanmiguel_init_dts-v1-0-c0023ae41899@gmail.com

---
Potin Lai (2):
      dt-bindings: arm: aspeed: add Meta SanMiguel BMC
      ARM: dts: aspeed: add Meta SanMiguel BMC

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    1 +
 arch/arm/boot/dts/aspeed/Makefile                  |    1 +
 .../dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts   | 1161 ++++++++++++++++++++
 3 files changed, 1163 insertions(+)
---
base-commit: 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7
change-id: 20260202-sanmiguel_init_dts-79cdb33c50d5

Best regards,
-- 
Potin Lai <potin.lai.pt@gmail.com>


