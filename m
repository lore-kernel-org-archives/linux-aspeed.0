Return-Path: <linux-aspeed+bounces-1329-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BC5C5AD49
	for <linux-aspeed@archiver.kernel.org>; Sat,  7 Jun 2025 02:06:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bDhPH5rjdz3069;
	Sat,  7 Jun 2025 12:06:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749178507;
	cv=none; b=FD8ioU+5bHeLzhN4TZ5ZPZacU5LgDavUzZ88f0M0HR3/mQqhu63E0KnN+YVB7DCcDSn3y90Ev+sC5OSv5lFO9a+N7Dx6w04rVqLxWJq2GdqC81PLNhQLyb5DC9qiP0FDIkJzVzdVbUL618rVhuMLYv1CDzfrgLWkDH2TzqcbNUuDLewaiTfA9tCy5pMNMFTw7ILMXw3LjOyfP8Bfp7h4S0Af3EW1LRBP6ODCrFm2nvO4N3zizi4BR4AhxGbG8QzpHhmU9/yYvLVVV5RiL0wzjvoHot/nDc+VXIUL3uCyUeQgkKcmJo9JMVKkUxqMO2PnrEKzrd3o7AKt/2TtS2kBHA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749178507; c=relaxed/relaxed;
	bh=VcPYXlqUwGtYWC7gObxdrCELcx0WWyaHPv/mohqNC1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jYNtlyg1ECJMmbpm9Lnan9NaKoKgQfVT3DhSbSJUMFpcludb/7HO8+s9NmTVkYIm4jhLO7S0lPrzgogo01rfOHPEKEXZOh85Mf8HwnNp5zMibIMIeY+7yaK84DGUsNlU1SCzH5xagJaw0NFdK2Rxqqq58Prg7tZUYx2+ziOQg29mnpWJIyBhfubEGi7iKe+bHAz7lt6os1ZfO+RHh5ANRByd06hrCcdJUXcRGaPcuNFQRHYD+WhB2QfnYdXuM210nyYP7wvuSWAT2Fs+ptsQfxly44eY4ysLZtPTnllDyYKJMDqLTfOEXJcY5hm3Y3jrb6NPV2t0LhEanbVm6E3tQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=VDjvNlJh; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=jasonhell19@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=VDjvNlJh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=jasonhell19@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bD5XC1C0Wz2xYl
	for <linux-aspeed@lists.ozlabs.org>; Fri,  6 Jun 2025 12:55:07 +1000 (AEST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-afc857702d1so1372961a12.3
        for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Jun 2025 19:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749178505; x=1749783305; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VcPYXlqUwGtYWC7gObxdrCELcx0WWyaHPv/mohqNC1Y=;
        b=VDjvNlJhYpTGjMNbXAwfXgKQpOd9BOGBGv86HsoifFtBnzS/rtl8Vz8NXdOEzkqVL9
         fPM+uNtXPmo8HPpwmg+7AQYwcpEI2EBm6uuhTB3JiRw0I5BZFO20QaP4JaaOtNbJQ8XV
         i7FKROkwGaDFPEfBMjdOGANIglTSfGxo4/kriapJCC8LA7j8NG6Z1XctcyLNyjZw67UM
         bZLJCi5j8uRQQeHuhCkwal0OfwSFnFeCl5u+LxamZzMsFVnaXEp918Zfx7T6Xs6qfQ0p
         AlncV80p7ejuogkQzX5+vchp0t8e3KRtMpnzXEmqAcgya4PwpOYcQy9m6AY+iC3MST3x
         H6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749178505; x=1749783305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VcPYXlqUwGtYWC7gObxdrCELcx0WWyaHPv/mohqNC1Y=;
        b=LHUmKZqeg2+yV/mI5uphuaoOeSeXPDU6D+IUFJcNCmlzljUi9dgZwJjMCX8u0sS04W
         /p08W4eY8kjHhAXKQiIbYF7BNpdr8Hdtx4iG+xv3tRIVbUTbv1mGowq4FFQdbPUjrCWR
         DNqN8fvCpvwzrTDle7g6KDUmma4IIMTJuiNwQqC73j6FUOddLuj1J0hIFSmEaOC2nGWK
         xntu4C/SgVzBFw8yuzz5kfjVBsT3w/fRecSNz5DZo4UsfeYbYNJslFH1HbHETcKbYN2U
         xdKzQZPKwegSPK+xXQdvW0MpZroyxCzjKULG8LksRsD6tZxXwzL8Lm0KHCESY0yJLnFw
         xamg==
X-Forwarded-Encrypted: i=1; AJvYcCW0Gr51Gq2ryWHuuRrgIOit6WtcEUTRTO2MDNmouijwV5/4tGr8v6XlaYba4R+i47STkVr2fPFKpnOvIno=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwzVsDXhRq9nYPQmfrl4byVjxUgM8UBgz+j1YAErlyXKa5+FNpy
	hvjVoI/1o49dBlDp9uDxKnxaehR5XhMDtigYZ9T8PBLgwEU0o9el89pd
X-Gm-Gg: ASbGncsm10LDh1TjZmCLz5i2qL+g0a7c2le4LZKqrIld4+/z/mapsxbrADoT4y6Apns
	qHqi+yncgDEYkcly84QxS8GcPU+txNFS2taI2/mX9XwqlB9HxtZhcBLCLxLfLGQ5bPaY6IyYBwY
	q0VL0UNkOWATl+TV9+xr34oiHvKYu/h6+GYWB8UIVOYJfbfufbuMlehCw+bWOIiKsNiSfnL4H/V
	/jOXK8uz/eZmDpc/7s3UDKCupddbNuX3JaBuClnVLy2n3W8zdpliaXTExjNdKqHe87fJXinREz8
	qOb/ipI2IBjqYmBZW+OVoFCAdB0DOnEaSrNieCM7u8Bcr58V36Who4Oz4zZZVatx7epptufWXVX
	nUQJY7JvllVUTmr0ckF0FTz1+B1ROQO2Pc5v+2HEnrN6kzyYpui8z0u8quxMN1wtsZsH8JW8Enj
	g=
X-Google-Smtp-Source: AGHT+IE6tkKM5tzQQa92Y/8CBU+6+g1CrxllNqlHv1TLlVy7w57uqLtmBftjT1nfnG3gOSb2IzldOw==
X-Received: by 2002:a17:902:fc86:b0:235:e9fe:83c0 with SMTP id d9443c01a7336-23601d18723mr24725515ad.27.1749178505588;
        Thu, 05 Jun 2025 19:55:05 -0700 (PDT)
Received: from jason-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603077eb7sm2942185ad.39.2025.06.05.19.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 19:55:05 -0700 (PDT)
From: Jason Hsu <jasonhell19@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	patrick@stwcx.xyz,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: yang.chen@quantatw.com,
	jerry.lin@quantatw.com,
	Jason Hsu <jasonhell19@gmail.com>
Subject: [PATCH v7 1/2] ARM: dts: aspeed: ventura: add Meta Ventura BMC
Date: Fri,  6 Jun 2025 10:52:50 +0800
Message-Id: <20250606025251.887953-2-jasonhell19@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250606025251.887953-1-jasonhell19@gmail.com>
References: <20250606025251.887953-1-jasonhell19@gmail.com>
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

Add Linux device tree related to Meta(Facebook) Ventura specific
devices connected to BMC(AST2600) SoC.Add subject prefix for the patch.

Signed-off-by: Jason Hsu <jasonhell19@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 01333ac111fb..a86b411df9a5 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -87,6 +87,7 @@ properties:
               - facebook,greatlakes-bmc
               - facebook,harma-bmc
               - facebook,minerva-cmc
+              - facebook,ventura-rmc
               - facebook,yosemite4-bmc
               - ibm,blueridge-bmc
               - ibm,everest-bmc
--
2.34.1


