Return-Path: <linux-aspeed+bounces-1742-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 417CEC83F38
	for <linux-aspeed@archiver.kernel.org>; Thu, 17 Jul 2025 23:46:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bjqLV4hLzz3bmJ;
	Fri, 18 Jul 2025 09:45:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752764368;
	cv=none; b=hXfz+WgVua8QwY7tEtKuy4vdANWrGReSm7yxJRZSAWPWf/s1IKACYnq6DB+JVFZfx28VG28vO5f2uB6DrZU6RrlWc4U4mf2Uj37rsg++O0AC9iqhN49YryqlCDp5AmZa6Ts2FBc+hiiR+yp3QevAT0BKv9ZYGwImnVt9/LOXtuUPBWagfdey2xcbU1o10601TQElFmenru7ISqa/9tPVtCitU2tLkT5WeGszitykeugZOVJwXlUv6/NcHWPCtMEqwWdH6mpciklep0g8agVvIciSkWSBfB42/6k8ahl1BVGXu9yOq9JPyhjGwjPbDFyH7/rNhgCiF2SLI50uoBh87w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752764368; c=relaxed/relaxed;
	bh=vnmPbk+SzjnQUab3zLiOuEdr6xig/TglCXCOUdlG6xw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Nj/XFxqp43q8VFaZu2cz1I0EdNMeAnRTq+z/BCGeBMVZ929tIF8i+paW83mWKovgMDaoE36L6AY11GCrCEbgeQlEwtA1p+3aqVyhbQo6Jy7vcvM6kc7C9+OndJ0qbfktQ+UOl8SsdevKA7MKIR08pD+QUxDf08KAaRxq9Bcgds3dWNB4iYAb9Iul2aZpDxReFrp3PGiq0oIggsqu5Q5QgFSGIepokJ158+BZYM+/BcADlNVZqnux74tVFgaRy7IX7bvpo5/wkldHSxePUY33lCABKs1rMZ/UPpg1nnKTqOF8wkFVrPxC4S3+kOetJrV+E8XNJfjumO+LUMA6RctzHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MExYRIV7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MExYRIV7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bjbg30Y8Wz3bvW
	for <linux-aspeed@lists.ozlabs.org>; Fri, 18 Jul 2025 00:59:26 +1000 (AEST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-23e210ebd5dso16100655ad.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 17 Jul 2025 07:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752764363; x=1753369163; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vnmPbk+SzjnQUab3zLiOuEdr6xig/TglCXCOUdlG6xw=;
        b=MExYRIV7fPGASrcEyV93df6QjuYar32juDHRD2sJbvCtJLxtQp6wbHZ+VepRwCcBbW
         JkNP/JYOnxrmHg0s16OeQKmKl38fmiA71Hs7cV6FBUYdRBuI2ZEv3YN2Gzm8bAy3dOCp
         v2aw/JcCeNC6AUC71S0xJrLrAIW5O7yBjkm12OcxaWHh0t5Y8W21kO9ooO3G+tRCDTgC
         IaSZMlv++0UBHZOBKwNbvIVo3lqSvNsi48pS5/bSZrkuQKK3H3ajhPXGgt0sRhr2TEDB
         HHlThKjDdDKDADLOPglC6ldGMFSLWj1DLwJsGZwUXnWWo61kKMDa9Ts3ee55YJ6Lw9Pv
         wXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752764363; x=1753369163;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vnmPbk+SzjnQUab3zLiOuEdr6xig/TglCXCOUdlG6xw=;
        b=idIa3MlIIuEYtw/Emoay6lQkhKUMz4Gd1hqicUoFBo37Df/upRdrgYhBd/Ym21+dU7
         RzWCraRkgn0njOAbM1uc3LCm1gx+plnHJeEjXQ7V75HObkh+QT7l6y6zASH0W+pRXWnB
         KpNYplVMY2Oe6jCcceZC5ywB0NrG7KE9UhoP5KLik1PE3aI1x1v4Dm4L+n91HMxj3VTd
         KOoVwMXrpgTeAZb4Qa+UiBWfxnMBYo5PDJhbVYpFzcO2+PD/1W4WMwZNiz83BZn1T2ev
         jE/4vWecBlEEmoaB8gk1C9mzTcQWugYUSozbaqyMYxjQyaK5EqOsj3WU6NsumLM74LDF
         7uJw==
X-Forwarded-Encrypted: i=1; AJvYcCXVuM6vrY2i1MMCCGQtYm/YZ6jZ625XXeWuOc0DGTFMv1hysV3iqGl90qAs0JVrTG8U4BwOgGo4KEcmWXI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzUr9UXKiR2FUWiWD3DQyl5LtPAB2sgrSFqKuoVdQ0Jhwhv2cXF
	xMh2rrTbwswKx8WttRN+zxDAScoDSUtQrd/VYmo+9pfxSHMRXHzO2/kC
X-Gm-Gg: ASbGncsaAa9At/Gadq+wcByim6HdFDh+jC9Q3DPTU66s2QA6Ia1AQ6orzAC+8+/Sd/N
	d0819Mg1bdAw7Va9qxA1Rc9GCDF4yBF+muNSFhRqWK3lO7vCCFIXxHw5kq/LIQFTJ/SfadNTgpZ
	qpdKqpu1zBUh3RgR3OIEM4J+dtw1V7aLb3e0exnb2Zw1R+bXIZBLd7J7vu9yB3GesKdaHVefcWV
	TgRfogR6djDYh5Fm8+0C/Sp7ult+BCABxdgSongVJfOEoXDQhpH/xsPqiTAvEYevY3iEnmlPEIf
	UHQ3TK2XwiEmHU0g6lenXaUk75fIbQBWtN9LmhqDgxbx1DEDgxBoN3B5CJ/75ylH8jT1X6O2E9h
	J8yzLq+mDTJ6rWH7Z8G3kCMBjXlyke0CYa9Z1Y1fb/RkONkLrbtOzSVPeHHpv9av5aG4=
X-Google-Smtp-Source: AGHT+IHgkzEOYEeBylkMIDMLWlCKIz9EjBVWlMOVczHADMYS0NEj3G6AuhDKx5MYpE25LRvaHDKgNg==
X-Received: by 2002:a17:902:d4c1:b0:234:595d:a58e with SMTP id d9443c01a7336-23e38fb11efmr1511875ad.25.1752764363108;
        Thu, 17 Jul 2025 07:59:23 -0700 (PDT)
Received: from [172.17.0.2] (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42aea81sm144603915ad.82.2025.07.17.07.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:59:22 -0700 (PDT)
From: Leo Wang <leo.jt.wang@gmail.com>
X-Google-Original-From: Leo Wang <leo.jt.wang@fii-foxconn.com>
Subject: [PATCH v8 0/2] ARM: dts: Add support for Meta Clemente BMC
Date: Thu, 17 Jul 2025 22:58:58 +0800
Message-Id: <20250717-add-support-for-meta-clemente-bmc-v8-0-2ff6afb36b0e@fii-foxconn.com>
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
X-B4-Tracking: v=1; b=H4sIALIPeWgC/5XRTWrDMBAF4KsErauif0Vd9R6lC2k0agS1ZWTXp
 ATfvXI2NdQFZ/mG4XsDcyMj1owjeTndSMU5j7n0LZyfTgQuvv9AmmPLRDChmeFn6mOk49cwlDr
 RVCrtcPIUPrHDfkIaOqBOca+MC6CFJM0ZKqZ8vXe8vbd8yeNU6ve9cubr9BF95pRR1OCNcYjKh
 teUc9u9Qun7ZygdWTtmsXEFP+KK5hrQmJh2XDnYd+XWlUdc2VwQQqYESRlI+67auvaIq1YXbUp
 CKsNA7bv6YVc3l8kzRpM4BPfPvebXtezQ30xzbZKobYhMSrPv2o3LzRHXNjfqEKzSDrT3f91lW
 X4A8/ldSugCAAA=
X-Change-ID: 20250618-add-support-for-meta-clemente-bmc-941a469bc523
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 leo.jt.wang@fii-foxconn.com, george.kw.lee@fii-foxconn.com, 
 bruce.jy.hung@fii-foxconn.com, Leo Wang <leo.jt.wang@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752764359; l=2456;
 i=leo.jt.wang@fii-foxconn.com; s=20250618; h=from:subject:message-id;
 bh=JMX/QgUhmqLWxuEkWEUiV/WuMSD4F4bRfw4zHmMzWUw=;
 b=O7FZv7SmN+3mZNqZcFF0E6+kINF6Do9tG1Je+dkH5V0XJWXbF2wApr0D+XWg6pkWRwXAS+RhJ
 tgITsqyOYw1AMNw2JUBAAELEhjLPkzXTNYi7iabDimDhxy6AIb8bJbp
X-Developer-Key: i=leo.jt.wang@fii-foxconn.com; a=ed25519;
 pk=x+DKjAtU/ZbbMkkAVdwfZzKpvNUVgiV1sLJbidVIwSQ=

This series adds initial support for the Meta Clemente BMC based on the
ASPEED AST2600 SoC.

Patch 1 documents the compatible string.
Patch 2 adds the device tree for the board.

Signed-off-by: Leo Wang <leo.jt.wang@gmail.com>
---
Changes in v8:
- Relocate IOBx_NICx_TEMP TMP421 sensors
- Enable byte mode for i2c11
- Link to v7: https://lore.kernel.org/r/20250716-add-support-for-meta-clemente-bmc-v7-0-d5bb7459c5aa@fii-foxconn.com

Changes in v7:
- Relocate CBC FRU EEPROMs from i2c13 to i2c12.
- Link to v6: https://lore.kernel.org/r/20250708-add-support-for-meta-clemente-bmc-v6-0-7f3e57bd0336@fii-foxconn.com

Changes in v6:
- Correct Author email to match Signed-off-by email address.
- Link to v5: https://lore.kernel.org/r/20250627-add-support-for-meta-clemente-bmc-v5-0-038ed6f1cb9f@fii-foxconn.com

Changes in v5:
- Remove accidentally pasted texts.
- Link to v4: https://lore.kernel.org/r/20250627-add-support-for-meta-clemente-bmc-v4-0-ce7ff23460c4@fii-foxconn.com

Changes in v4:
- Move properties of nodes defined in the same file from label ref back to where they belong.
- Move pinctrl default configs for ncsi3 and ncsi4 to aspeed-g6-pinctrl.dtsi.
- Add properties to i2c10 and i2c15 to enable MCTP.
- Link to v3: https://lore.kernel.org/r/20250623-add-support-for-meta-clemente-bmc-v3-0-c223ffcf46cf@fii-foxconn.com

Changes in v3:
- Modify leakage sensor to reflect current design.
- Link to v2: https://lore.kernel.org/r/20250621-add-support-for-meta-clemente-bmc-v2-0-6c5ef059149c@fii-foxconn.com

Changes in v2:
- Fix patch 1/2 subject line to match dt-bindings convention.
- Reorder device tree nodes in patch 2/2 to follow upstream DTS style.
- Link to v1: https://lore.kernel.org/r/20250618-add-support-for-meta-clemente-bmc-v1-0-e5ca669ee47b@fii-foxconn.com

---
Leo Wang (2):
      dt-bindings: arm: aspeed: add Meta Clemente board
      ARM: dts: aspeed: clemente: add Meta Clemente BMC

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    1 +
 arch/arm/boot/dts/aspeed/Makefile                  |    1 +
 .../dts/aspeed/aspeed-bmc-facebook-clemente.dts    | 1295 ++++++++++++++++++++
 arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi    |   11 +
 4 files changed, 1308 insertions(+)
---
base-commit: 52da431bf03b5506203bca27fe14a97895c80faf
change-id: 20250618-add-support-for-meta-clemente-bmc-941a469bc523

Best regards,
-- 
Leo Wang <leo.jt.wang@fii-foxconn.com>


