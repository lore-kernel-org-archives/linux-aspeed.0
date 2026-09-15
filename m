Return-Path: <linux-aspeed+bounces-4991-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B67C88E72
	for <linux-aspeed@archiver.kernel.org>; Tue, 15 Sep 2026 01:31:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkPcY1Hz4z2y8G;
	Tue, 15 Sep 2026 11:31:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789435885;
	cv=none; b=owMMT4E9MVlj9Qd4CV2Mzdt6k7jX8ZRyXgnagUsq/DN6YvdrT0H+7cO+q9CoS5nlkeYYCrabfn+PhhtL+XPOcePgbiVL9ZVu2oSfW0ITQq/g7Rj9j3RjcO2weRL6st9rehmHz+lNXeGh8j8XaNL6JsTs9dVeE2yx0QfBno2jMu+zmoOI/Eh8mnVmJUvLwuSMaUGeYIN8RQ8ZwPTCa75CAuJzkhs01E7j9MvDJQ0FyEOMYcvRwQ3F8u0Rf7TwP2DXWZLzdn5X2mYemTRiQVSq0MKlf85c1NlpsXJgBUoeYcFaLKuvodnoDlTj/qjsIQPeVl1lbFStphlQVjZnCUYwEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789435885; c=relaxed/relaxed;
	bh=JkjxOhGzqU+8W6VS3//UzMLrdiDuidVOSy9K9CHCyjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nykrS9Y+0dSsholZbRSt6tFHfOpA2/SY93noFm1rsJSJSoTGVKbiLJMWbNYbXTpEUh2RZf5lEgcTqeJvnZM2x+iyT/QD5BLNSjc1YgGrSmWDBtwQCJhtnf+txyh44ucOH1rywN7v6E4dwcZ4/xhg0toZbZohaj1YMV4FtSqGgbzIgnEd8YlqOCdA5gb+RmwCHI1+IFFUne1RTCFKoxh6ud2Q8PqlwwLCtqxvBLYMq0kq69m5hmFSojhugs47brpLVcLOcJsXsePnnZRp7lcybfg+OdayAlH4LyqsGYE55VaaMX+xCxGEzJ0q41VvSSCfP9NOaPnXLyBvnvwJigphKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Bq9oyU/a; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::f; helo=mail-pz2-x0f.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Bq9oyU/a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:3b::f; helo=mail-pz2-x0f.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x0f.google.com (mail-pz2-x0f.google.com [IPv6:2607:f8b0:4864:3b::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkPcW4Ypgz2y7p
	for <linux-aspeed@lists.ozlabs.org>; Tue, 15 Sep 2026 11:31:23 +1000 (AEST)
Received: by mail-pz2-x0f.google.com with SMTP id d2e1a72fcca58-85469e25400so2109538b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 14 Sep 2026 18:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789435881; x=1790040681; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JkjxOhGzqU+8W6VS3//UzMLrdiDuidVOSy9K9CHCyjw=;
        b=Bq9oyU/axCAya0hnmwsdN8eijm0sbbGBZnOBVvPmsU+dyAF4+1kpE//b2TLqAJ6pem
         M+pMqayZzqHK6PVLLvTB6opxJzVE9vkO/4q0RPoMSVADZ2mrQnJ8XEztEuXfUQ4i9p9/
         OlyK2PfJhHyXFvKDWjFzUdbtoCrLpCayYetR7IPiM5GfFD9hfGVUKCQabx6xOPKIrXMn
         0oDCVRzlycXBXaTOke/j+9yPmxKRR2PEZ3UrJTdPuFvM1W64TlfsaqPYYq3Pu1jf2dAq
         FetQq3VtOY7aHcfrflGlo3QsQnvdH0YivQ8ZX9fB8Pzk0Ubm9DiuuCu+kRa9DrZTSz5W
         YnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789435881; x=1790040681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JkjxOhGzqU+8W6VS3//UzMLrdiDuidVOSy9K9CHCyjw=;
        b=a6/kCLUfe7sFZfOTRtQiQ6dmAackSNJHflywjvvGk4SxejRBU+jOL3cXJgHVIWZ9bB
         fdtA4OeQpt2mqK14SCXD6/tccabh27MjMaI7au2pA+jflNBjKFtYLaq09C8RgPZWn6En
         bRj2HRXOHj03v5dUHTINmRsvJXnhNLtA6jPOMYqGVQCT4lhjrFJz/Ol4c8mUgPZDKnCM
         6Kgt9FtbkuBLDIajEWoZxrOAeum3qd2nHGL36BH8dg6sahZhdG4Jc6GlFjHqvf4jnkjm
         eoUIut4N1aHqDgVKXN+OCrVn1n4JTv3CKaqzznDsoAUAQSFTQRpg0CLPVIZQ/HNPTCco
         doPQ==
X-Forwarded-Encrypted: i=1; AKwUvBx0OjjxH3LmJaCASIqtdl/J54Z/wQatE7cWDpkL81kHzCTnBn2v4S5W+OVpfjA25wteYixUIPLT1PBkAIU=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mjq54lbVwW2wxtdjZb6gLEjUmjRLrb6aD0aBKEXrvKHo7ZxJyj
	yJjFKXlVIw43jeQPcKddvLLXiG+kP2gtjeHfHNC276u20XjaTiqdvKgz
X-Gm-Gg: AYBFou0isorMk7siNwJ1F4L8YbSyzaqGFtEQtkAxy5x8/qXphUZBdpWGjW6CJp+D00y
	gGDvV+r29Lm3DfRhGzcF0IVqBkR4USOPcHQLnW0Tf7aJqns4432CQnTfDtrAsR4O279FmXPnQf8
	sWEiIQDP7mwuJQeQEGHM+2xlZ8I3mXZoNwC6M1vvCrx+hoM4BIGS/M7EOiHbSLdErSBxneyFD7t
	6UJ4MG/lI142RZovbx13Y+sSKkYd8ASwm4ffZr1hhoZIAA0Nmh2XLNTI9P1kjHoibL5CJlIWF7Q
	ASTj0hEgtHIsIu85PKwgMt1GElmFdvw+WWlUUp7gF0iatAPM/LApaFapRbIOGMDvn15PKAb/rjf
	V9CMfFdy+0LlxVSyVzvbMHGUSq6WEMwhZ1gPcaQ0k3ppzzuVdtsSEo1Ka3LNjkWHWLpH4C2oDd2
	HJtQSGBRx+//hwawYOWGdEgrbrhYBkOX3XAN9lVnTv778whzkSl5m+GR44bcZS88VVpremc8UsZ
	IubVRLTvmUhp88kBORuKaNrAnw=
X-Received: by 2002:a05:6a20:c901:b0:3cf:a7a5:e310 with SMTP id adf61e73a8af0-3db404aebb2mr12126866637.9.1789435880642;
        Mon, 14 Sep 2026 18:31:20 -0700 (PDT)
Received: from debian.prasanth ([103.183.205.11])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365a59b18sm27111575c88.2.2026.09.14.18.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 18:31:20 -0700 (PDT)
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
Subject: [PATCH v5 0/2] ARM: dts: aspeed: Add ASRock Rack B650D4U BMC
Date: Tue, 15 Sep 2026 07:01:08 +0530
Message-ID: <20260915013110.4780-1-prasanth.padarthi10@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260830182036.284736-1-prasanth.padarthi10@gmail.com>
References: <20260830182036.284736-1-prasanth.padarthi10@gmail.com>
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
SPI NOR flash layout, UART console, GPIO line names, graphics
reserved memory, I2C EEPROM, and MAC0 connected to an RTL8211F
Ethernet PHY.

MAC0 uses the EEPROM on I2C7 as the NVMEM provider for its MAC
address and is configured to use the RTL8211F in RGMII-ID mode.

Changes in v5:
- Use the I2C7 EEPROM as the NVMEM provider for the MAC0 address.
- Configure MAC0 to use the RTL8211F in RGMII-ID mode.
- Use the standard OpenBMC 64 MiB flash layout.
- Add confirmed GPIO line names for the reset button and host power
  control.
- Add the reusable 16 MiB reserved-memory pool used by the graphics
  device.
- Drop the previous RX-delay-specific description.

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

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../dts/aspeed/aspeed-bmc-asrock-b650d4u.dts  | 120 ++++++++++++++++++
 3 files changed, 122 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts


base-commit: fcf94f5431858d83003cf18d60df67bd87b20ad2
-- 
2.47.3


