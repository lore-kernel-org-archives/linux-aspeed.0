Return-Path: <linux-aspeed+bounces-4873-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC94C61DD9
	for <linux-aspeed@archiver.kernel.org>; Sun, 30 Aug 2026 23:44:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hY7xd2Gg4z2y2g;
	Mon, 31 Aug 2026 09:44:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788114053;
	cv=none; b=Q2SwUXOKZScxy783tW9+291yaqnIA6DpQVrz/GQqjjZruskaRvv3/G/deR464tvOdgQMgIN0yxJc7guhvlg2trl/91OlrHV+ekRYTaCe3GvafJkvvYJR23fXhCdIpgivJaG+j3Lm/5msTgWTPsh5zR4BxzVqTmatld9VScgUZqtJJwXZ1xN6rrVAKiRFq8ArpokPrYVgOwxWzicTSHA22A1GuqtNDcb00tJW++MY2G68oGJEC/46tSUQjzHIh3Usqw0R8ukfwQWcn60dz+1lYOa4ynr87wXOKcCRX6lXVVJ5ZaFQO2KujzM8ArI+QBvtodZW3k4aKlpcTru6D5jKbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788114053; c=relaxed/relaxed;
	bh=4Z/BxeJ8T4MCVt5zsyL/JPI0APYo+zl6RdZeA6DakAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=axHJp/1NBke/f2M31vZwm5XLrJ15ynPY4PZDd1n301KPJCCvKHaRoQel9DMFTnkJO+dqqDXWXqE5F8h1QEiFmXNvW/wRg7su4PX5W7YBLY5KTTPrwxKy8VgQZODDDgGVRLKTMm8tyR4uWxoC6lUrRxOoSwcN9TEUvyLba3uc2+f84RnoyENuFCN/rwgXcMqdMxgmFkMrBTzyXGOsqSvohKcVKAqOUTr3AvOKonS7yE1TCahftUZZcqTZMPPj5LKqC5TwDVgFkX45rZs2DbYhT+xp1NyjgPw/+DoKIYbU3QGt8b0ifNDtCpeFJpBDUIqX2UNx+mHYuK5Pe8icxVvNcg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OmsuvuVb; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OmsuvuVb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hY0mg4xb2z2xT6
	for <linux-aspeed@lists.ozlabs.org>; Mon, 31 Aug 2026 04:20:50 +1000 (AEST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-cbedbaba5fdso1864731a12.0
        for <linux-aspeed@lists.ozlabs.org>; Sun, 30 Aug 2026 11:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788114047; x=1788718847; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4Z/BxeJ8T4MCVt5zsyL/JPI0APYo+zl6RdZeA6DakAU=;
        b=OmsuvuVbdTHIqQevjOEUBsovDzygUrNMoay5Q2KRT0HQxYeqWBixKroboa30HTsJhu
         UFiUjMcAsJciBUWiAdflXFhrGGZZUCwDQaAiIgVZQP+PBYbgpkohriZ0YVN60XLXkOaV
         TtH4Bd5Gnx/CQTm+aFsWP31WYckHMblb/N2X0TFHnM79Od7RAk+s4Z2qmcmYZgkHKclZ
         D4ThH4AKk+CyRojzPEalqBiqK4oorgz7jfBTWjHomiUPZsxb3Ff2C9RTsiMH5GH51eGh
         9uQVc4II0ZevLoZG6/EzV2MQGFLyxiPIKano7KQtVmibISqHEyybHjJHYTScHLXrDoE1
         JB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788114047; x=1788718847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4Z/BxeJ8T4MCVt5zsyL/JPI0APYo+zl6RdZeA6DakAU=;
        b=m93wU8sracTZLrCPjxAx4iGJNKgAXhzue8EhJMzSpjgEp6dvj/7R4fbWOPEhgGxhCG
         +ffO8oIa3+JvBTlcOd3ATAuPGYiGs/nOMtAlSnv+HJdwU0irq1YCgHbAcAGnowX6Jxmm
         Hxjz1ZcVWdby2UnKv0lB3er9m3r7SvBUohIpI9ysCgwx7uSFfwkZ0x3DsRYgFoCpgkcK
         6CJc7sIOPCf45FpAPT3vDIvf9IFSphF0ZSjC0+sf7kgfUtQk6wm82qQbEgjU7zWccG9J
         qQheOocFnZsMEJ5QfbP9fxB6HefwujBlsFm8varJNun4gwchIJ6fsT94Fy9HzaUu/Gzu
         lnDA==
X-Forwarded-Encrypted: i=1; AHgh+RoK3dbxvFXCv/8xASJGu6S65S3tYQLy6cMl+NPE8+LGnvUhldQk7uXJmpkNsFHhA6h3145C+z5qfiGc5u4=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mWjCYBDujf3YFD/yEBnU6Ils2AVnpJyaYVGGHRjrejvTwMndAH
	3If5B9YdxjwwccIeO9hOgA7RZIEBeHeih0VofP0yWJmXwQ37jYf3hB/S
X-Gm-Gg: AR+sD13xE4rbK5wLsQlJFdL+D8cYdQrttNMv8tMlwdvAXZsHnC4g3fpuYqTTqfS1igV
	lpF8jJBI4PR5Xq2mIgyrFIXj7sLx11hXjcxKr8YVI8f3NWqnEXeCNXXIHL0dlAUXLa5dHaaGiEC
	olgB1Hc46wVyKcayB9JdbbH8pX+18fqCR6Eg31St2ms2o1JNe8cYOMuKsRNnPzDdhxBTbptTSy4
	ngTiAe9gWxDuDjJQj1+Ub55aeQS1mUiZpklZCgQGYYcy+5LgNWXS+VUM9Au4gZCupwtaE0xFRoi
	oHz1nnquHFljnC8UPjJXuHy1V9NwdyFzBoYlmvz7H7Ii7epj7stb1RiPFdOqpvh47BmhoV0Ywws
	vR6rhbFxGigEoBnHY+sIXgtw/xzwFDM5LdwudyAOrD7ZOBYsdV+B4XTIZB4E+gZWdMFVXAD0ZQk
	VcPx0E0Khzry1AFrmdoV53q4AXcycJQP768wejNssSqHGUiXSxnv/iTq4Hna8QrLne6/jW8Y7LF
	QUb5g==
X-Received: by 2002:a05:6a21:4d07:b0:3d3:af44:ee12 with SMTP id adf61e73a8af0-3d3af44f160mr20178531637.27.1788114047417;
        Sun, 30 Aug 2026 11:20:47 -0700 (PDT)
Received: from debian.prasanth ([103.177.82.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f95a847sm21619480eec.17.2026.08.30.11.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 11:20:46 -0700 (PDT)
From: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
To: Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Subject: [PATCH v4 0/2] ARM: dts: aspeed: Add ASRock Rack B650D4U BMC
Date: Sun, 30 Aug 2026 23:50:34 +0530
Message-ID: <20260830182036.284736-1-prasanth.padarthi10@gmail.com>
X-Mailer: git-send-email 2.47.3
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

Add device tree support for the ASRock Rack B650D4U BMC, which is
based on the ASPEED AST2600 SoC.

The series adds the board compatible and describes the BMC memory,
SPI NOR flash layout, UART console, and MAC0 connected to an
RTL8211F Ethernet PHY.

The MAC0 RGMII timing configuration was validated on B650D4U
hardware. With plain "rgmii", the PHY negotiated 1000baseT/Full but
received no valid packets and accumulated RX CRC errors. With
"rgmii-rxid", a 5000-packet test completed with 0% packet loss and
no RX CRC errors. "rgmii-id" was also tested successfully, but the
additional TX delay is not required, so "rgmii-rxid" is retained.

Changes in v4:
- Validate the MAC0 RGMII timing configuration on B650D4U hardware.
- Keep phy-mode = "rgmii-rxid" based on hardware A/B testing.
- Add the SPI NOR fixed partition layout validated on B650D4U
  hardware.
- Correct the BMC memory size to 512 MiB.
- Order peripheral nodes alphabetically by label.

Prasanth Kumar Padarthi (2):
  dt-bindings: arm: aspeed: Add ASRock Rack B650D4U
  ARM: dts: aspeed: Add ASRock Rack B650D4U BMC

 .../bindings/arm/aspeed/aspeed.yaml           |  1 +
 arch/arm/boot/dts/aspeed/Makefile             |  1 +
 .../dts/aspeed/aspeed-bmc-asrock-b650d4u.dts  | 95 +++++++++++++++++++
 3 files changed, 97 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts

-- 
2.47.3


