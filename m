Return-Path: <linux-aspeed+bounces-2971-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6408CFA450
	for <linux-aspeed@archiver.kernel.org>; Thu, 20 Nov 2025 22:55:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dCDGY4JbFz2yvk;
	Fri, 21 Nov 2025 09:55:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763616370;
	cv=none; b=hFIdMsZhlQpQRMl+xXCGm5oeKtPZSAtfAB4du6Arusg9JhZAigMnR8QJlWRbKe6qT1YNxVQEupGXlOZqAUBOyAmCBTBNGiPjs8e2CrSgwT3ELJ153suBbi/3VFp4Lj9sYdfpu3UzLHWfl1O6UvH0gsaShRPudL9jlo1m/syI3WY0i4URy3qkQcqy3rhENDSjFk0ffK2jXgM6nREXGCy07VhDBH4FmKPPk7VoPPpVm4dF0pm5urotlxKL/S3G/S/SW0m2O4LvD1MwjjD1WX+xpM2xpHnTeBKoLYYHiYc59ge5LtDcm+71sKpSQ9OSIfdM7bg+TxEIOxnuSZdKE6Vk4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763616370; c=relaxed/relaxed;
	bh=XK8FGpJd/gRCbg6Rh2iKRhUNOEC1c+hhwCoLg8DxBR0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KOlvxDy9gOAt3DNt4M6KEThsTp/5oL4YO8EleXoi09WfdKMhGc+/hO5jR/nP7ED0hCws7EQXMes0BQ00f12M/FYy4Vc6wLVbeEDldJEFoGUPIk+coAUhJlr7BCr9osEJZrTmDA9suuYpG+vUatmS2koh/7IUWk+vVaIozHfSIX6PUxklq7f0bopHKT88N6n9qAroqLRko5YKtrKpjZ3anTdKWK2bJXEYiG9CIYtohEbuZbQEZaL9NUBJfy5cQbVecTScJfGyoTCTHqoZke0gF8BI3XB2oR5xX11GJrP7mU611rD1DJnho+bJqShcVzIrGUpZM7RQ7gcVcQuqwq59AA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=mZ1rOtiG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=mZ1rOtiG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dBmzN3jvgz2yFq
	for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Nov 2025 16:26:07 +1100 (AEDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-343f52d15efso382119a91.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Nov 2025 21:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763616364; x=1764221164; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XK8FGpJd/gRCbg6Rh2iKRhUNOEC1c+hhwCoLg8DxBR0=;
        b=mZ1rOtiGKMMqOBeU90QHiJPixLOrhaZOvlYmpAEkqzMNCTGZoxwGTSrpcYpVfid9WI
         o8ijLj/jOQZuk9avJrdYoIFtXhSYWwpHk+iQBUDRFDacP4sZfy2Fw6zyVIv/QxJfgHPH
         pOGpFxzrgnCyNVLFyoX+/sw+nfOtT91G/hUoslNTY9HvlzFCLH0w/HikAUWhHeQN6i8M
         rHn3Sow0F/h8KAXld3ZGcOhvvAPkQhU8iG0i/1kMGVXudpxmH5Cmw7gLLJ66OOPV26A7
         MFs+RWg81XTAV0ki0YNhXKi43iBsFI4nHvyD6cg4IlN5qC6KxNDrlPsHBX0az932qX+9
         3XwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763616364; x=1764221164;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XK8FGpJd/gRCbg6Rh2iKRhUNOEC1c+hhwCoLg8DxBR0=;
        b=maTFpP/h83uhH+ZSKk9hz6A8vw+5qbugN0oFQu28vqfI5dcJ/kEKov9uajMaXiQpsu
         grfqKcCSeOa+Cy19sfHrCGE7z5eJinCpkfhBNfM/kXafmjYGLLboZxTN9ACKk77XIc37
         CwUNb09DRtYo3T/lhmRtV+yLpuVaUg2hf8myoS6wLO2lIb28TFBwASSf1gD5RD8iTtYD
         rYcznaKtDAqR2R/KKloksLlpybnMEKS9oXRlduIScdW3RKbNKkRzOayaENOaWDsOL8Xf
         cy2HZmpeWe9Pe0imNDnK3rwux4OyTCDlV8g77+4Pe6UqJ4iPGcBFsSyfjkpp5l6sY5pi
         rEog==
X-Forwarded-Encrypted: i=1; AJvYcCUuUuh9m5i/T3v4zlgtqGSZ17RyU0YZWb2zSttRcc1ELX9A9UFmz95/FgUrO3LyUNj4rxRHCsFd8QoXf4A=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwamkpbhOizcE4y0yVhMPvXvjmu2Zr/V56xT0EwYS/GXNVddsWF
	Don64itjYRalBH84wtkxztE8mp8USKwsIhfGYgf41G7w2g8hiR2BhYNz
X-Gm-Gg: ASbGncuqn495y+bIF9W2fK7k84JfWJ6SdlUWopgKbayS9TaHRsHN4AmrEEPybUsD+6q
	E4JKQkYwNPMA2giMGm7TTHKlHP3fyPFD8iqfaEI9heHiZG4QtVkSenWNkmjWCNWl+8UJFHel+Sc
	9grdMZwEwS/jWVOY7SKXGQOxwKNOaGiE/Nfu0VJsTDtdq16UI9PygeU7GkrHnFR8onmGR2GI1jJ
	J3qawvbNYHX7KK5b008J4dmSqomBnvRQrqH9lF6uWtv3zOPqAjq9QGNZCWv3mBC6yjgG6sdkC8v
	9rTJV5NvmUwyc9ii4YhOxC4dsmSGL1sVlENhPbXvamb1Q14DanfAcWxL+NpeXnrMN9v1SM6I9yJ
	v5T5MCHSz6+TohR+1xk0qmvdCj9QtBcnt/PztXhPMXv9o4SOr7PL70tC9MZ2cvwYtZY+2wMBovl
	Ldl1M/zIVmfwFkuex+J28iwOwIC6ZeCGi/yWAIG9QNOn8A93t8KixQLRMCwCywvk45+mu214tJM
	luMUvxDE3dFxdewgNUAr0I++4z0C1WsIPmrF2weFswocO3I1TIHX5F/gtznYXitamc9EcV6RqBO
	Yd40cz1eK47oHHAKpl/YyQ==
X-Google-Smtp-Source: AGHT+IGRKwLmW5TfFmdLBz3341tnXeMORxmdp+rmYdWoNAuomZUITEEz1HkqEwACgq+mI0ayc0njuw==
X-Received: by 2002:a17:90b:2cc7:b0:340:b572:3b7f with SMTP id 98e67ed59e1d1-34727d56695mr2083615a91.20.1763616363754;
        Wed, 19 Nov 2025 21:26:03 -0800 (PST)
Received: from 2001-b400-e301-38bf-be0d-b72c-6bec-2812.emome-ip6.hinet.net (2001-b400-e301-38bf-be0d-b72c-6bec-2812.emome-ip6.hinet.net. [2001:b400:e301:38bf:be0d:b72c:6bec:2812])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3472692e5d3sm1221342a91.9.2025.11.19.21.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 21:26:03 -0800 (PST)
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Subject: [PATCH v2 0/4] Revise Meta Yosemite5 devicetree
Date: Thu, 20 Nov 2025 13:25:57 +0800
Message-Id: <20251120-yv5_revise_dts-v2-0-4d7de701c5be@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAGWmHmkC/3WMwQqDMBBEf0X23JRsMLb21P8oIjZZdaGakkioS
 P69ae6Fubxh5h0QyDMFuFUHeIoc2K0Z1KkCMw/rRIJtZlBSaUS8ij3qvgypt1sQqAglWdtq20A
 +vT2N/CnCR5d55rA5vxd/xF/7VxVRSDEa2zzrOqe93Kdl4NfZuAW6lNIX93AXBawAAAA=
X-Change-ID: 20251118-yv5_revise_dts-12e10edd95d6
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Amithash Prasasd <amithash@meta.com>, Kevin Tung <Kevin.Tung@quantatw.com>, 
 Ken Chen <Ken.Chen@quantatw.com>, Leo Yang <Leo-Yang@quantatw.com>, 
 Kevin Tung <kevin.tung.openbmc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763616361; l=1026;
 i=kevin.tung.openbmc@gmail.com; s=20250924; h=from:subject:message-id;
 bh=lg2jHrJxqbgoMaTKC4ITbkxnQHARHKleNAEPRdJp6v8=;
 b=rT/dVjbKgo2z9etA2QhmDgpnEgtLGOvLpItmQ1ufeR+WHVaWVtYQ8Nhh4/3EdyX0Cnixja2eV
 Q8efbvA4UxrBtX8ICLtcXY24k4Wq4dmaXAAKyzBKi7nCsPs2xXp7q5c
X-Developer-Key: i=kevin.tung.openbmc@gmail.com; a=ed25519;
 pk=PjAss0agA0hiuLfIBlA9j/qBmJaPCDP+jmQIUB6SE7g=

Summary:
Revise linux device tree entry related to Meta (Facebook) Yosemite5.

Changes in v2:
- Add ipmb node for OCP debug card
- Link to v1: https://lore.kernel.org/r/20251118-yv5_revise_dts-v1-0-fcd6b44b4497@gmail.com

Changes in v1:
- Increase i2c4/i2c12 bus speed to 400 kHz
- Update sensor configuration
- Rename sgpio P0_I3C_APML_ALERT_L

Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
---
Kevin Tung (4):
      ARM: dts: aspeed: yosemite5: Increase i2c4/i2c12 bus speed to 400 kHz
      ARM: dts: aspeed: yosemite5: Update sensor configuration
      ARM: dts: aspeed: yosemite5: Rename sgpio P0_I3C_APML_ALERT_L
      ARM: dts: aspeed: yosemite5: Add ipmb node for OCP debug card

 .../dts/aspeed/aspeed-bmc-facebook-yosemite5.dts   | 25 +++++++++-------------
 1 file changed, 10 insertions(+), 15 deletions(-)
---
base-commit: 111e542d267576de402d0836603e1def2b60316b
change-id: 20251118-yv5_revise_dts-12e10edd95d6

Best regards,
-- 
Kevin Tung <kevin.tung.openbmc@gmail.com>


