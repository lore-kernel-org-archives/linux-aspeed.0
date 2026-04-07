Return-Path: <linux-aspeed+bounces-3859-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ECFA105D98E
	for <linux-aspeed@archiver.kernel.org>; Tue,  7 Apr 2026 23:21:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fr2J76B0jz2ydq;
	Wed, 08 Apr 2026 09:21:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775549879;
	cv=none; b=CgOo6Z57Ns5z654tB/pbp3YdRcjByt1pA6ZTK72wgTvTKr4X1FY/m7QRXazUeNU5ARApvA5Xb+YHaHw1D26+JkpiwZfpY0j8AshZNhN3RGAunYJlSLTYxj5sVkHVCAm3XWZGoWJ+nF8/lCxuyj/vvK0RHR7WPGWJvZsniNfPbVP2oPBJ5CkBVsu4E14SpKDIG1euYdLZJew571JhhKgZIxrZGcaPsyNyt9+6LoxneEGlWC3nrR6NxTJyQEbkHNecGy9IWrYhi8CVW2IbwrlF69Q/TvFU8p+6wE6rqfsERCSkUMOHPaxi96eV3XAlYeGXdGD5Rn6PHSV1Gia80SBYqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775549879; c=relaxed/relaxed;
	bh=gpY4U27Y71SwDzYx6NrKHrnXl79ZOYWYmPRAEotSW3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DGP7tOeA2hpwYuYo/17EcM9pImT4Nua6VQ6Fn3Y4eFGuEVpJ0EovtR4A8v7v6HqBqQvKn7x6naMWZWD/TNSbdwmE5uLX2Xha+oUNFKUSRFVnMmftYOt+PJZt1FNQYEflZ5QAtAMGg7IxIO1QA2OHuc80+xNSdESHT1EIL5+q1jNxCY+sDfwfSKiAwc1YmGMCXDZytSHcb4ffmRnZ/SBKCl5jsAE44d0ggDhPhSNecC79kMmCJQ5XCzYX1cQfwAc6FSbylROeMwxGLqH0Hg3WFsWcHc3g50NYv/l9mfG9q3HSiG49J9Drez7Dbkq9UQd15OhkBdWfytx5Ke6PABgFJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=roFlvvLe; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=pkleequanta@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=roFlvvLe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=pkleequanta@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqfFy0L9Mz2yh4
	for <linux-aspeed@lists.ozlabs.org>; Tue, 07 Apr 2026 18:17:57 +1000 (AEST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-35c124d2613so2730740a91.2
        for <linux-aspeed@lists.ozlabs.org>; Tue, 07 Apr 2026 01:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775549874; x=1776154674; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gpY4U27Y71SwDzYx6NrKHrnXl79ZOYWYmPRAEotSW3Y=;
        b=roFlvvLe3LuBZmYs/D+K6Z0/M9ubP1+sAQolGJGO8bOeDSGOL9KLklG3qXcPke4Xje
         GDQBhUYT6Ftk7tQexdqZTZEpUC/mK1O1OCQbSPafiL+B3xJTh0WF3Xd7sX3ed177RBBZ
         vrrzzJx94zSeDc5dPjOmIbI+OiauINQDN93u11u/BTNWjZOSHcnmFz9mBCAGw4BL62lY
         he+emZxR4ZewdkuAx+zLxWPBC18HMKf+BD5yiO1E6PrEYCqiUz2/nEq2Z/CfzFpyyNHh
         cH/W+O9wSlVJDQwn3sSr3eXk/gLl4I5CuMILBYhjc8CNEePoXst4WbzSD7+AQ7uAo7Ev
         emTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775549874; x=1776154674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpY4U27Y71SwDzYx6NrKHrnXl79ZOYWYmPRAEotSW3Y=;
        b=sGpOQk00jkRrOR29L/YcXDatGDHFKiWtRiNk/VfWQGDdbBT+TimDaBHQDHRSkuLLG2
         EKKdViUPBZPZgiZr1isPtIgrWnuxjuHcynjwiWyi2K34SBNR6/YtfMH48loY1fKtnG1e
         Fn/h6nMTIqNA6AlDTVg8eVemFb3uu8SRl9nYwqZVSQesyYUTmfbluD8RQnQKiaWD+qVs
         jbBoIKpO/h7Y/PbJWXkOBg6e4kSRDfdv1Z6zvEflhFUGkyTq9Ru+x7ur43F7Q8yxfq/f
         yesB3mwGnUgI0TbfzC+kXA4KQNjPUbVqHUMscITEokkE7ulOKvR0pOWMO0duTCvZQQIk
         QsWg==
X-Forwarded-Encrypted: i=1; AJvYcCUUKZJNlx/l0w8Uj2Np24+mSZ2t8si5SqkKIiC+IXdLu/eFXTQMq/11KaL0nSXXLqzIwdnnGs+hJsxCRkw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxzs9GBE8AEOhZuLrL4DewTxYCVnp7RPCTqsv6Z2t1jOxyBvR/F
	yYbr8Zl3Q8mvqonFkNopSt+xmQB4ZSQc7iynfR35w8Aaxg7RRnyol6KU
X-Gm-Gg: AeBDievlj6lO/xcTp31zLZWrhFApaZNEZ2s/DDF9hoOqINiQONA4fh0EeSUCB53+ax9
	gVOVOGuAeuFUa5xJca1kCz2cbHse1S3AsH6IpHI6ZagZIwGuS5O+YwAFSkzMDzqvJqnXJ+evCi5
	3qe6VXzCTjRS7ytRl62JqhOxzjq0uzzpPXLPFM/1R1TVBJ1r0bjVo0JsUVXJEi4YpcksIxfa0ws
	9CZHrOr8RJLGk7pBDBNyrDV+PZ6SJ8CncFCZjLJ3PeY2u/+5cxqMzP5VjziuCLYw21L9v28ZnGq
	QukRZ7/4D2oPNSIQwXBw4/SeY6TXQDCjjJ4oFQOlGajqriSOYnqSXZyAVuHZZqF7aQBabSCJfOy
	d0qPpzHYIb+R0/Z+LBOb4Pgq8wu14f1kZYpfngvDHRIjuX/dz09o2CNqVSXa709GM5WouR4PCSm
	+45wWPOHD4PJO9sbnt/0a2T2X4DdhewMLXStheRnFBOscRzczod3PUmpMjWCebc1Jxu0XQVW2p7
	FvzziluwzfO
X-Received: by 2002:a17:90b:2b4b:b0:34c:fe7e:84fe with SMTP id 98e67ed59e1d1-35de69aec1bmr15940483a91.28.1775549874412;
        Tue, 07 Apr 2026 01:17:54 -0700 (PDT)
Received: from pk-pc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de6a2325bsm4592889a91.12.2026.04.07.01.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 01:17:54 -0700 (PDT)
From: "P.K. Lee" <pkleequanta@gmail.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Jason-Hsu@quantatw.com,
	p.k.lee@quantatw.com
Subject: [PATCH v13 0/2] Add Meta (Facebook) Ventura BMC (AST2600)
Date: Tue,  7 Apr 2026 16:16:58 +0800
Message-ID: <20260407081700.2658011-1-pkleequanta@gmail.com>
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

Add Linux device tree entry related to Meta (Facebook) Ventura specific
devices connected to the BMC (AST2600) SoC. The purpose of Ventura is to
detect liquid leakage from all compute trays, switch trays and rack
sensors within the rack, log the events, and take necessary actions
accordingly.

---
v1:
    1. Create ventura dts file.
    2. Add commit msg.
    3. Use format-patch to generate patch.
    4. Add subject prefixes matching the subsystem.
---
v2:
    1. Modify email content.
---
v3:
    1. Add mail list.
---
v4:
    1. Apply git send-email --thread option.
    2. Sort nodes in the dts alphanumerically.
---
v5:
    1. Run scripts/checkpatch.pl and fix reported warnings.
    2. Remove unnecessary 88E6393X CONFIG FRU.
---
v6:
    1. Add a new stage for the DTS change.
    2. Run scripts/checkpatch.pl and fix reported error.
    3. Fix the issue in a separate patch.
---
v7:
    1. Fix broken indentation in the device tree file.
    2. Sort nodes alphabetically, then by address if equal.
    3. Rename fan sensor nodes from 'hwmon' to 'fan-controller'.
---
v8:
    1. This patch series has significant changes compared to
       previous versions, and quite some time has passed since the last
       submission.Therefore, previously received Acked-by/Reviewed-by/Tested-by
       tags are not included in this version.
       If needed, tags can be added again after review of thisnew version.
---
v9:
    1. Reordered the node sequence under i2c5.
    2. Added a description of the platform's intended use to the commit
       messages.
    3. Added 3 GPIO expanders to i2c10 and defined the necessary GPIO
       line names.
---
v10:
    1. Added IRQ support in GPIO expanders under i2c10 to handle edge-triggered
       events.
    2. Reordered the nodes.
---
v11:
    1. Modified the position for i2c3mux0ch6 and i2c3mux0ch7.
---
v12:
    1. Added a GPIO expander at address 0x11 on i2c10, and assign an SGPIO pin
       as the IRQ for it.
    2. Fixed the "failed to match any schema with compatible" issues.
    3. Reorder the nodes in alphabetically.
---
v13:
    1. Add two GPIO expanders (0x16 and 0x17) to i2c10 and assign two SGPIO
       pins as IRQs.
    2. Move the RPU_READY_SPARE_PLD_R and RPU_2_READY_PLD_R pins from
       SGPIO to the GPIO expander (0x10).
    3. Add all tray PWREN pins to the GPIO expanders (0x16, 0x17 and 0x1b).
    4. Add explanatory comments for "unmanaged mode" under &mac3 and
       "intentionally left empty" under &mdio.

P.K. Lee (2):
  dt-bindings: arm: aspeed: add Meta Ventura board
  arm: dts: aspeed: ventura: add Meta Ventura BMC

 .../bindings/arm/aspeed/aspeed.yaml           |    1 +
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../aspeed/aspeed-bmc-facebook-ventura.dts    | 1636 +++++++++++++++++
 3 files changed, 1638 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dts

base-commit: e11fa6b1ff6c27c808d17e479bd7d5582e772062
branch: dev-6.6
-- 
2.43.0


