Return-Path: <linux-aspeed+bounces-5034-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44AB7C982FA
	for <linux-aspeed@archiver.kernel.org>; Tue, 22 Sep 2026 12:37:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hq03n3GKLz2yQJ;
	Tue, 22 Sep 2026 22:37:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790080645;
	cv=none; b=izD8rorsc/mrfcSOcWw8Ag8rZ5kfAQJ/uGKioQJJE6crE9SYvXobTLYX8KRJcqRKnl+KJbicy/UlvA1yeLBa2FoeXwJwuIiojXhFw89t8KjZapf+t6ss+7jOS42wDQk+LcVzqv4L8Z0/wZ18ip8MMgEmNqM928vBebUldC83NoXqCn4WRvuWZo1s0MQj5fqKw4bb+E9mHmA+kllH86jlKchgax9n6gPs4fdJIC+i0VDrN/KEyWuMMRCdQMecUam1Iqx56b6Gh0LAZL6EkURCbj3sWL3nOwgVqjmvZjxHcDc81Sh2fxJ8DDqybKjtk/JlguC7HM7lMUB+4+C+uGDJtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790080645; c=relaxed/relaxed;
	bh=sSFIDyEBXWq4SCc8zo/QNh6HqGLSDKyG+17t+RiabUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nr8fD9w95jahv7gfVgLt0CTZWH6mvWyhg2SlD9tiHgSeGwafphqEM8wRi4JW7PsffThprMZeRMp3dd9EG7PwOE60OBJ7T9Q2IXGdJwYCn6813dNv7pu/rx/fp/+fW+G99rNcjJwTWFck6fuLrkMMyqndLv3YArxrPkDi0Eqbz9KNTxMM7gOfPxiGGvx5jpcRrGdqaqYVfsaJ0Jnb3O+A8xALNy1bBugc0DyYE8kePy9qX8C0om4srmqqdIBjlUNMWqSaz8jZMAu5P2aYXFu+peDX47kAcJe7KaQbBiiQRQwRd7jQZVKolB2+JYZv7CEJFZu7TcO1OI26S9SEh6rL4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MBC6YpSY; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MBC6YpSY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hq03l5ygmz2yHT
	for <linux-aspeed@lists.ozlabs.org>; Tue, 22 Sep 2026 22:37:22 +1000 (AEST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-cc147d86bebso862457a12.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 22 Sep 2026 05:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790080639; x=1790685439; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sSFIDyEBXWq4SCc8zo/QNh6HqGLSDKyG+17t+RiabUE=;
        b=MBC6YpSY6+eUg8/nqDfp3ArM1Su3O4GwC2/XJGaJgd40bje5K4061jKqcCvsWm3VZI
         ONOs5UiuKfGwezSMxQHCMKqizrPqltw6dg7jaOP1E4nv0Bznp8gI06F38wnMppuB/fxz
         tDndHdWZO4DDVnx9/G/pJZ02+en5wESR1pOWzMYsv/Nuai+msvWfb6SZBHsedeca+jAf
         SJfs9Sq8cgNrJI6ctxhIKkwUWQ/0GgEyJzxz8lpije3/XFnIL9DqRdyBmQwb25wT2++e
         rKG2XKXuWB778xSmmB24Zs4+miVewxCS6EEwBBXvQB3+7yAWJr+i3xwFQVWZ25xe+eaw
         eXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790080639; x=1790685439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sSFIDyEBXWq4SCc8zo/QNh6HqGLSDKyG+17t+RiabUE=;
        b=KZsCy77ntoKTAubsIu77/tl3yvMsN7wbOrKDZTI+EQMxA7YMYNlKEmJFvHn4GTp4JZ
         rZWo42wvwhBmRwCc4dVf/2zxiOJu28fqsXn4A9WjsMbS/EkCcTKzRrbCMRyJ/vXjdqZ2
         InIRyr/A5+xola5PhhRTaIvmZ7oQpudjTQaXppNmOM8ADGyuT/wauLD1TuEni7Dj7+l5
         Vwa7GDlr+Drbj9rChY1c6mLoXQHWrgzFFboaLqGuoGQknuNbqt9QtTI0VaUXXAIg0nAF
         zn7tGo5ZgVxxIQX4TgrhdCRs7WuUKWZNfD7gfKOevM7Y/rCMYVhWtt9CFZdTgR8QOJra
         yCLQ==
X-Forwarded-Encrypted: i=1; AKwUvBxkvHrcQG2Uzn/uSNB/UgqoR+SVjjMAqz+6UKJFq6kWtfrn9VKfqCYYtlqKoOieop2a1ZaUQu/j6wicJSg=@lists.ozlabs.org
X-Gm-Message-State: AFuF++koyvkdrRo7yquI2EibC1f95mi7VzR4lAF91hudVDGTYDZ10EyT
	zLiqEAFP1NfzwOX1gTJViti9shv5wR1F5+QR6TJetFIb6zgsJMaISbjt
X-Gm-Gg: AYBFou3wK8Oq5f2RhXlO3go/OVTK3Fudo56iNXKT4M676VoACzdyGa6FI4f2gpX2w+i
	a7NzRyi3RCAlj6lwM0dnMsL1X/WEpfurhPzSZLdo8nsQZgnpCkS7bDSuMGOB112+AN1mmwjKokR
	y6O7Y8f+m5L2oHkrfPsfVG1jEU2x8PJWFi0ri/8Vln+eGghrcLqAKAU/9yYfHIB1uFJ5dsr2R6Y
	GmVNq7yQsazB65ZHQXTkpO/0XA5QOFBJxEdVWxflitvRf083n0ckY3ZGGjQULY7u3c7eNQ9KPU3
	63vH5ELsIjBsT9wk05mp9d0zhlNlMcPotoaZRnqqKaNvyniEDz55S2hjFsc+IEAavIbXr96b5+3
	7F+glYhVYjxJTyYavcZxSElRfaGvGObZzny9yYDYj4Dwwzmu4csvp2NXWw0fV4lUQR56cddE1kz
	qBc6p5GJk1ZVTL3atkGGdXwCGdiqWhVPGt5iYcql3QzZAUBmAQDUNOS/1xgVIt1LAuZapISAPbn
	mBkh/NAQSvoiqUqWh4AvvTkuEQ=
X-Received: by 2002:a05:6a21:7e01:b0:3db:280:b0f with SMTP id adf61e73a8af0-3ddec65f674mr701021637.14.1790080639455;
        Tue, 22 Sep 2026 05:37:19 -0700 (PDT)
Received: from debian.prasanth ([103.183.205.140])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e612ccd46sm6453922eec.18.2026.09.22.05.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 05:37:18 -0700 (PDT)
From: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
To: joel@jms.id.au
Cc: andrew@codeconstruct.com.au,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ryan_chen@aspeedtech.com,
	billy_tsai@aspeedtech.com,
	andrew@lunn.ch,
	tan.siewert@9elements.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Subject: [PATCH v7 0/2] ARM: dts: aspeed: Add ASRock Rack B650D4U BMC support
Date: Tue, 22 Sep 2026 18:04:58 +0530
Message-ID: <cover.1790079398.git.prasanth.padarthi10@gmail.com>
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

Add support for the ASRock Rack B650D4U BMC, based on the ASPEED AST2600 SoC.

The series adds the board compatible string and describes the BMC memory, SPI NOR flash layout, UART console, GPIO line names, graphics reserved memory, I2C EEPROM, and MAC0 connected to an RTL8211F Ethernet PHY.

MAC0 obtains its MAC address from the EEPROM on I2C7 and uses RGMII-ID mode.

Changes in v7:

* Correct the GPIOP bank line names for the reset, power and NMI button/control signals according to the confirmed board mapping.
* Remove the obsolete GPIOF5 reset-button line name.
* Leave the binding patch unchanged.

The B650D4U DTB builds successfully using aspeed_g5_defconfig.

Prasanth Kumar Padarthi (2):
  dt-bindings: arm: aspeed: Add ASRock Rack B650D4U
  ARM: dts: aspeed: Add ASRock Rack B650D4U BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../dts/aspeed/aspeed-bmc-asrock-b650d4u.dts  | 135 ++++++++++++++++++
 3 files changed, 137 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts

-- 
2.47.3


