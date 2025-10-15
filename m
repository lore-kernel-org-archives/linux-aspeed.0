Return-Path: <linux-aspeed+bounces-2458-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C20CCD193
	for <linux-aspeed@archiver.kernel.org>; Wed, 15 Oct 2025 20:48:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cn38j37wQz2xdg;
	Thu, 16 Oct 2025 07:48:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760561333;
	cv=none; b=GdZvAzXdi4HHDNVddZ5GlIxVR8cjeC+0tFOwPm9Xgd9WBVAAToCgvA6HiR0WKEOj/1IYlWskOZFSLHawfJycXqs+gllvpB/4au4+K6V6/r8/5Xf4i5Vkw2lwKN2tEhLAjhjEX0HdQt1t8V/CiAYe3TIRus0sbLARIsZEr9XZjwswVAwPoIIhFQFYdZ8nmuHFjw1lmvD6kAVJ2GXvILAR+N9MjoKA2UumzpAxtLVFUcUCJurcFCYqUawg0hP4Jpth9VxEH/QbINhvK9d94PFrWyR3mLjMXIbywkeqbw3zJ8OhAnd877V0/ql8evl7IFHoiEUCEbto6VrM++tm9DW3+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760561333; c=relaxed/relaxed;
	bh=ECq6v5kjS4I+m9N3qtX70S6BCp1pZjjE4JAhJFsm0ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vy7VEj6XjvEvLGvk1SRPOoSH9rlA+hDNIcliXpAQYKSAKdFfviZjbpoTrmKbGYgYwgj0zvBeD8xCAlEUwlhbm8+3UfEk89anAK278codtBixd8dnQMrCvcdrSl2uihMhEWI1/Pn9TFk8UBMPJakb5OyNwKURe/BFLdOIRBBs/NBO7DY0nRqF1sx8iqRyK5Kb7T7C36MsjuYVLOySQLr8+DwJdqkdv/z1WVBDWW73HT8QrnD/J7NO+aZYDL3QiUALfQud9uqwYNbxJ5LSZQ5oVwJDLe+RM5QuW23RnqgEFtS73HDLfQvqlzpYiKvCCuhjD96J1KPXVo9wUmk1aIBkOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=jKJ8oXE+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=jKJ8oXE+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cn38h2nnPz2xC3
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Oct 2025 07:48:51 +1100 (AEDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-32eb45ab7a0so60495a91.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Oct 2025 13:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760561328; x=1761166128; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ECq6v5kjS4I+m9N3qtX70S6BCp1pZjjE4JAhJFsm0ZM=;
        b=jKJ8oXE+JRmncwJErsUYyibdNCxgZjEiLYh0z5H3HpX9q7g629oM3Cz+o2jZYHGm/q
         4OlI7b7OggkEJ3Uh0netgzz9sX0UCtiwOeGHcm9UiU9NOPJDvng1H5upMEGCbvWThcdC
         Tm7pB4tES+SZAbggp2e2AU3TMu+3kOYMjsZ2KhoZml/Z4991HFbTZ1oVoIkB9aCN7M+M
         5iIGYWIg2E7TUxpHzdYAVmBuQHe8+RTnT5tbtGWm7Y6d9KvQWOCcPvU7cf0GqY8ou7ax
         PpSbbS8xj/blidJUhuAeP3bflvbcGIO1BLkt9NMpOSVaMPXATzybJloFSNYSaCGBQv2f
         ULwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760561328; x=1761166128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ECq6v5kjS4I+m9N3qtX70S6BCp1pZjjE4JAhJFsm0ZM=;
        b=l62wV54T49wl0fHWbZElKwVvOZmuqE/LCehgKazldJtX7YBUzZgSodIfea+//t8ogj
         uack0W8n51n4h8Rqfnlu6vsI5XbzALJR/fazIVU54ZD8fFD2qBt9KmTvvB2mcA/YITCs
         Z6a7FU43phis1VeJtRjKQNs72Vg/lzgMz8oU6mGGsoJYuWOjHsyNblY9OP6L3b/KQDH9
         F4PQ+rBI7BsWsVZqzJstjKmefNdP2ZJ/nEOzm2kiahCw1Qst+VIBhC6NBYuosWOJKUGI
         P4xC73Jb4sIH0z0JzUQ+e2U2t3xo6C1ShfDi9LAjGYKNZZa9Y+pOUu2HP6s6IuT9tdRx
         HvGA==
X-Forwarded-Encrypted: i=1; AJvYcCXdraNwyRSrhYKi3FnCyoK/tUc7X1fEURX+PE2cGExIyVBMGCdQZsYP/7aleBkrLCflAc1GIVqrAVjH1Pk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxKC/h6JbEdL2/gkwNHZFu9a82TZcL78et3eHysuDoRAyXGO1Fk
	HhOR9NDNMn7tofJ0wjqCiAx8d/SwVpXqOXt3gy8fR8MR6NnXGhHczAYh
X-Gm-Gg: ASbGnctMbfvuMVdvufG/2AQ9v2Ik1KV6d3Djm4a8no3Yy751ZZWU7b2bdzDPYTKvHoc
	2ZQ/a8fMrAvquzvVyfeAng+Vs0dA4YMQuk1a9NKIecBykeKlc0VZqaeTr+hDuTT/+9OuTHR1UMx
	q69ygYaxbgehMnpkFQYxbg91OG7RDun0kPh6S6efahY02yqhg8jNsGLH4FtwsUF755q5t9wdEeZ
	C4lmTP+Rb3DZKkXPUNkHeKqdMfOIW0SlphY5MvFyAG22i9XMZBgVxJZAh00tz4b4jZeai6+4sx5
	AoxMjWr7/Z8O43vGajidKyANN/QvCh9gpAZ/ho1bJT2xLCZgMUWPi05yGmE8Mx3CSJ9bFwwG3U0
	UCLcINxCb0BM892b7Kyzai+2IIVcpA3htvY3WlW+zce7X2p8=
X-Google-Smtp-Source: AGHT+IGN+lN9vicyM0JMq1Ocm6RG8YfGzytjeBBr/s+6dWoWkU/VmH7/8zJwDfHCWTW90MulWcmRHw==
X-Received: by 2002:a17:90b:17ca:b0:32b:a332:7a0a with SMTP id 98e67ed59e1d1-33b5114b648mr39129699a91.1.1760561328178;
        Wed, 15 Oct 2025 13:48:48 -0700 (PDT)
Received: from localhost.localdomain.com ([2620:10d:c090:600::1:d6f0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a2288bd55sm523896a12.9.2025.10.15.13.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 13:48:47 -0700 (PDT)
From: rentao.bupt@gmail.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Guenter Roeck <linux@roeck-us.net>,
	Tao Ren <taoren@meta.com>
Cc: Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH] ARM: dts: aspeed: fuji-data64: Enable mac3 controller
Date: Wed, 15 Oct 2025 13:48:37 -0700
Message-ID: <20251015204840.80070-1-rentao.bupt@gmail.com>
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

From: Tao Ren <rentao.bupt@gmail.com>

"mac3" controller was removed from the initial version of fuji-data64
dts because the rgmii setting is incorrect, but dropping mac3 leads to
regression in the existing fuji platform, because fuji.dts simply
includes fuji-data64.dts.

This patch adds mac3 back to fuji-data64.dts to fix the fuji regression,
and rgmii settings need to be fixed later.

Fixes: b0f294fdfc3e ("ARM: dts: aspeed: facebook-fuji: Include facebook-fuji-data64.dts")
Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-fuji-data64.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dts
index aa9576d8ab56..48ca25f57ef6 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dts
@@ -1254,3 +1254,17 @@ &emmc {
 	max-frequency = <25000000>;
 	bus-width = <4>;
 };
+
+/*
+ * FIXME: rgmii delay is introduced by MAC (configured in u-boot now)
+ * instead of PCB on fuji board, so the "phy-mode" should be updated to
+ * "rgmii-[tx|rx]id" when the aspeed-mac driver can handle the delay
+ * properly.
+ */
+&mac3 {
+	status = "okay";
+	phy-mode = "rgmii";
+	phy-handle = <&ethphy3>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii4_default>;
+};
-- 
2.47.3


