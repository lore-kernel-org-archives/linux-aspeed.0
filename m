Return-Path: <linux-aspeed+bounces-155-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1644D75BA2
	for <linux-aspeed@archiver.kernel.org>; Thu, 21 Nov 2024 02:53:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xv2qQ1tWkz2yjR;
	Thu, 21 Nov 2024 13:53:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732157618;
	cv=none; b=NcB9MettFReH8sjl4RdJ2aBWFL5lZmwNkQgfrSEpQb+Pn4wHVOCAB9//NmpPA4WhRHqJeiWTyjSbC/6TCfNwGBwoPvinLlofKnwpzkuZ7IOkeN7lNpJc/fJ/BtLL3U8pICYKUsejPL5/gIL03Y3F1UT9DlHtmSdXvULsA+xl5t2og1AhkXuDg8NLuTb6EuhD1z2lShWIxqpgAj3bWq+sIUYU4iqbDVNFk4Ephatz1qIWPo03KQ7yLuIuQhNwOy+whtE+UWKRMILmYtdsyGG2pjSWOXWUFdhe2ZmdQ7fc3VMxehy3WS6Kah/HmvnFBfG6lDMkvYlvkWi2kYI5WVBCDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732157618; c=relaxed/relaxed;
	bh=NToX9+BNUIk/wvm1hddBf7K2+ouHu2IvaZpJI3Ppy8I=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=C+KGY+HC60U+ssStvds3fQYCsBCrYR8s2LGJf4dpkG1iO0sSDKe9dLWsQLhpZ/FZKCVu0mSpy1wdh2SYDtJ1w8sTWuQtKA1kkz4PM3e3Rc5nqnpnEqeJACmPr0Z0i/crDEd9DQTD9UKbFdkwS2esxZnSSAMjC3BcuB2duG+Dg1f9k0Ng6VqtMiPo71mX2hnFr0YU6obrpVU1hBDEL25dYz3SU1/e3stFOHhxBWdFvJwS04rbXiuwcRVjrqEvDka/G26JvTMZzMCIXr2vZBTl45HIz+LfrsCp9SzCgvr2e+Zl9TS59a2bh/7GN4g87ormpWZWsKaaf2t7tLNlGVyA0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=FXGcwHTs; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=FXGcwHTs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xv2qM3nXvz2yD6
	for <linux-aspeed@lists.ozlabs.org>; Thu, 21 Nov 2024 13:53:34 +1100 (AEDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-71a6b13bbceso162475a34.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 20 Nov 2024 18:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732157609; x=1732762409; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NToX9+BNUIk/wvm1hddBf7K2+ouHu2IvaZpJI3Ppy8I=;
        b=FXGcwHTsjW0km2m4Z0CyjtY4hV9T8zaQ+JMjFKSuJ41VHF6clY4+Q0SYF/bNXyAQiG
         NrA42m9V6NrudjI5WJQiD2EXkD1RFsC98FCBuQ+5fiqkyxKHNb9OzSosTd1cejH01sTh
         Nt6Wt43j+np3cnLior2NcT4r4atPiuEM9u2A4ZCvuQQxAWG+gnEzwPT08w+eXcCDla04
         T5SwpclgmUmpbBFd4Xv6SFlo3JWaJ1YcMg7Bojkd7ZO9gXk8ylNB1KKYwHPDfdjo/rgl
         EdxHTlAfzT1dx6iQ4tkd1ftRNzELJdX2n/CrQd3D1vMXysarA25Z9dap0Wnn6uK7AUPY
         U8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732157609; x=1732762409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NToX9+BNUIk/wvm1hddBf7K2+ouHu2IvaZpJI3Ppy8I=;
        b=w0JfSTIYJZnC2OJW/WrWfkCrIIqaD96h1HaWiIo1CCo3XpRuD26YCbpRSEMeqnrRxa
         JZQGy6q+Q5A55G+Sbd619FTzgzm6VC8GFTImEbENOlG7zyVqmteVKsXjRBEDO4pPLuZE
         6DrSV23bYakcSB1yc3ewV2iO4JW7nCeA04ro72sBDE+SJ7He4SgYOMpmNZv22uXAgvrQ
         DPPrl7aWZGBCcUZvbUvjMmSHNw9gCImeVRRx2+0NOZ1vVE+fZgYfy0h3yf00JMDfd9/q
         JPU4b1HM7PUDwByaMbXiUYoXtWDR9uYhjEH3TqXUQTk0T5KC1oxydt/HFFzDKjty0nJJ
         tVbw==
X-Forwarded-Encrypted: i=1; AJvYcCUKc3355tsv2zaj6RrGMWOPTbpBoA0PwDtK9D0DMybSk1cNJgJjvHEUqZR3b4hewvMjLWl2/AhHI61gy9o=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxyyOtea6jmCiOLE66XmKS+KJreDyLUsp0DJtaGkW9FFJQguxQO
	HU4aRbuW2bn10QzETkF2GHZnjLsRjxBz8GJhHzK2mZbGZJB27hI/
X-Google-Smtp-Source: AGHT+IFkbEHHx3XfJszzn97ujfOlcNxcTBfxrOx7+9a00uiuu8u3anBb6MDO613kJHYzHthySL2VsQ==
X-Received: by 2002:a05:6830:1512:b0:718:9b8b:429d with SMTP id 46e09a7af769-71ab30c329bmr5065817a34.4.1732157609031;
        Wed, 20 Nov 2024 18:53:29 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e309-7a4e-e779-1177-8427-3602.emome-ip6.hinet.net. [2001:b400:e309:7a4e:e779:1177:8427:3602])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbb64f5514sm285513a12.34.2024.11.20.18.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 18:53:28 -0800 (PST)
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
Subject: [PATCH v2 0/6] Revise Meta(Facebook) Harma BMC(AST2600)
Date: Thu, 21 Nov 2024 10:53:17 +0800
Message-Id: <20241121025323.1403409-1-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Summary:
Revise linux device tree entry related to Meta(Facebook) Harma
specific devices connected to BMC(AST2600) SoC.

Base on:
https://github.com/openbmc/linux/blob/dev-6.6/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts

Base on:
https://lore.kernel.org/all/14e1a0f581417d4228aea8c2569598d42b4bd334.camel@codeconstruct.com.au/

v1->v2
  - Provide additional details for SGPIO.
  - Add adc128d818 device

v1
  - Patch 0001 - Harma: Revise node name
  - Patch 0002 - Harma: Add retimer device
  - Patch 0003 - Harma: Revise GPIO line name
  - Patch 0004 - Harma: add e1s power monitor
  - Patch 0005 - Harma: fan board io-expande
  - Patch 0006 - Harma: add adc128d818

Peter Yin (6):
  ARM: dts: aspeed: Harma: Revise node name
  ARM: dts: aspeed: Harma: Add retimer device
  ARM: dts: aspeed: Harma: Revise GPIO line name
  ARM: dts: aspeed: Harma: add e1s power monitor
  ARM: dts: aspeed: Harma: fan board io-expander
  ARM: dts: aspeed: Harma: add adc128d818

 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 134 ++++++++++++++----
 1 file changed, 110 insertions(+), 24 deletions(-)

-- 
2.25.1


