Return-Path: <linux-aspeed+bounces-4031-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A55CD4F25
	for <linux-aspeed@archiver.kernel.org>; Thu, 14 May 2026 23:44:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gGn3y0wN2z2yCL;
	Fri, 15 May 2026 09:44:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778728598;
	cv=none; b=K42hj8owZduFZLv4rN4vnx5jlebE4EPKrif0Q1L7DAwwfYOE8TIbPahPBC3Ti+2g9PWfPp/6cS5/4NsB//QqNNRprfTw93z0sc5X1uSq5o/FWy39MMQ2boN0Q4vI9deO2DpJTwSJUJbAFmwsOkpJkmxfhImoz4ioLMJhQPM6q0ke9W7IqcnO58SykFyL5ccJmD3hhzYC1TFqKtBhVdIEpp7t04GaCq3i/0hEforOY9QWiActGBGw6XgQ+CaMxHQiDXPqI/zSDTCU9pthU+UltknOSLJPAv9hwxTzP+cVgCIr1Z/oej0g9K71Af0BAUFvBMINa3Wa3v4vqfNUETdGfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778728598; c=relaxed/relaxed;
	bh=Ac2bCkNoG8C1zHidrf71kjJ2gMAt5aTUT2C3bhGfMTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZzOasJFGqAWxPTTywwOP7X9FXdreVH8phqKgNlCex6/qcjpVfsDUlsdei+Wjb/wYFeRq5UzSw9OA/ZtdAfWGp9GdM8DjEZc0MwIMiMNVqQo0gL5Qbe3a+wNb/vkN5Q5jlS5VPMFna56bJw25exBdz048EyKdMLViLGUqUum78R+OSaGzaJOs1uWsi6OTevrBjf5izUESXhfocuRoKzUP5xeYsZVPquqv722lbK9d7csa5hcwYFg7Whs+5dyHg53HQLBIbEdxvDyPJMHpSGjgkifEt0p14SEGwrYXKLTFnroos0pbXu2qgedPmJ7bFlNuqX3b/s7aXmA+AGNBOFTETw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sdbLzDSx; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sdbLzDSx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gGFq91rmVz2xdL
	for <linux-aspeed@lists.ozlabs.org>; Thu, 14 May 2026 13:16:36 +1000 (AEST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-367d88b9940so3811885a91.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 13 May 2026 20:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778728593; x=1779333393; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ac2bCkNoG8C1zHidrf71kjJ2gMAt5aTUT2C3bhGfMTI=;
        b=sdbLzDSxGI3VCQ7XuLa3XcsYa4KT3ek6ylPRKY13yB2LfG2fnQgCZpJATfhXMQYzIs
         HC7HYMceRrl+Lfw7l8Kh8se3DF0KRe59kYPC1iy4gZrydTLY3a/+ZvSGggi6dg476atQ
         2U6ckIoJK2bqHYOtj1XQVbmvoZ4lg5MWD54W5p7WmWqbWfZIm2g5rOWJhwVx4Y5pB35g
         WWMOiqNtOHwh8wrdM7Yq14bUGRKseDgYwGacqZydT1JVYlMpYHoeKzBpfujXvoBvKqcB
         qPO8LnNHIvrh15WyV9s8365R0CKlDqSDWTfKxAmKCTPd57BBJtPTgrzqp6oaxPN43v8i
         EhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778728593; x=1779333393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ac2bCkNoG8C1zHidrf71kjJ2gMAt5aTUT2C3bhGfMTI=;
        b=syF+5wZKWkysm8P1u7mwF/LkLYNzDHklWDHzkIIYAZtzwIFvtFaH+zYi2+HtWMOoNy
         Uudl9I3H0P03j5y0TeLlGhEhqPYiNDY0zuwcZZ7Mxza3DRBgilD0rhXs2kc9eKmFP2vb
         GWzYs0B9FTFL3JDeF+VSGOmxDiUwRbiSAAicYOipyruVIxENa3iCIGmMHdSSFMzkwpyW
         PdDw1962Skmm3xetBwgdXs42Wf5WoGW9vmU9tbCYIlxmoNyMaXrlrvooD12lmUmHfy+B
         Qk/Qv7Q/nfMFs75Sv68hAi5Aa4SSF4RLH4919IukPpMeYwlqZeOZhM/tztVZa8zxPYc4
         Qopw==
X-Forwarded-Encrypted: i=1; AFNElJ9FW2Zdrqbfy1TQrPTW1fJX5BG2T/V7pMJBtYLX8nJWTTkuMHzsfLpryzowM1tqQHFZFi1XHIDneRGa9JU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxn8gJMO51JQ/no6JaUR3/UvW1My0Q9ZfnNyoj+ml33w4CmziD+
	jj+qf9CJcVNZ0cJZvj1N3vXd2yQemztrATJAE6qoXDsFU8WNoaUtOCGC
X-Gm-Gg: Acq92OE8yLnBzfMurmZWWcytTcedvKQaXxFJhe5oZK6VfTUNsBW1a22mea9mCoRjAyI
	wrCCXB5jjj9+PjrbVRdNmJ0LYMy9wj2ruFwh7Nh/6PdtbSIqP8mmeATyVsMi3c3sj+dGmZ0Bh+P
	U8kZo+U83Pd1khX8SlKbg4nnrybLAw9cK1Mls+MS3PjJqUljy9M+31ot6CukeZWO5NYqhe+BpKL
	wvpHI5JBIUlJwE+S21TbuIv5EVICQszYnj0j0KKSgjgF4WWmVD8meTafnQaoMZkTSNmxhP4Xpse
	Of5Gu3B/s9kPy8NeKtmyqMySBZeSoWvmHd3zlIo7V6IIQEhspfxXtd82drOBhPBbSQu1YTtX6ZG
	iTzeJjk5hSuYicsmBGvGQiKbcTJDRvJTrs7+Shw3ph0krSJpuchG38YCvIIbuaP73MhLgLckGl6
	UjrgRtMiKw6dNXUIKeIJ2U5iAGqtWQl6qwsXAoLvsw
X-Received: by 2002:a17:90b:4ecd:b0:366:479e:63a5 with SMTP id 98e67ed59e1d1-368f3ad4d10mr7021996a91.2.1778728593250;
        Wed, 13 May 2026 20:16:33 -0700 (PDT)
Received: from debian.prasanth ([103.177.82.138])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3692a94205asm320047a91.7.2026.05.13.20.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 20:16:32 -0700 (PDT)
From: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Subject: [PATCH v2 0/2] ARM: dts: aspeed: Add ASRock Rack B650D4U support
Date: Thu, 14 May 2026 08:46:20 +0530
Message-ID: <20260514031622.1416922-1-prasanth.padarthi10@gmail.com>
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

This series adds initial device tree support for the ASRock Rack
B650D4U BMC, which is based on the ASPEED AST2600 SoC.

The B650D4U is a server motherboard for AMD Ryzen processors. The initial
DTS describes the BMC console, FMC flash, dedicated management Ethernet,
FRU EEPROM, and watchdog.

The dedicated management port is described as MAC0 connected to an external
Clause 22 PHY on MDIO0 at address 0. The MAC uses RGMII with RX internal
delay, matching the vendor DTB description.

Tested:
- Built aspeed-bmc-asrock-b650d4u.dtb
- Ran dtbs_check for the board/aspeed binding
- QEMU boot smoke-tested with ast2600-evb

Changes in v2:
- Added MDIO0 PHY node for the dedicated management port.
- Set mac0 phy-mode to rgmii-rxid and added phy-handle.
- Removed unused GPIO include from the DTS.


Prasanth Kumar Padarthi (2):
  dt-bindings: arm: aspeed: Add ASRock Rack B650D4U
  ARM: dts: aspeed: Add ASRock Rack B650D4U BMC

 .../bindings/arm/aspeed/aspeed.yaml           |  1 +
 arch/arm/boot/dts/aspeed/Makefile             |  1 +
 .../dts/aspeed/aspeed-bmc-asrock-b650d4u.dts  | 71 +++++++++++++++++++
 3 files changed, 73 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts

-- 
2.47.3

