Return-Path: <linux-aspeed+bounces-5060-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A83CA5FA7
	for <linux-aspeed@archiver.kernel.org>; Tue, 29 Sep 2026 22:31:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvXvs5tvBz2yqq;
	Wed, 30 Sep 2026 08:31:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790668281;
	cv=none; b=RAViEAGNno1UcwNwhX5QiP6auf4r27/Tl2sx9P4oVsy/kMiDNStMejatk5b3F4+GA+Lm8grSbM7yX54srbPrQqVCGyuBqBM1dvHQMQba9V1T7WddA21sLiIccQxvGWC+AjjhkjbQ8tvj5DEpFbRtKI5+aTP23YWhASZKMEtfISlfKY0mjAPVpBcb1frNZcplc8C+1rYk807lz1hS9TlyYwdU0yVVgfbwZ6FgQvB/rZPLLfGMQvrv34kHbqrNfiX7l9WrzuwcJroYQCx9LrKu2v2NiZJzxxGFPG+azItAYoZSguArg+OnbtHxvTwZ53c+MQryFCyT30yd3qvYlPuoUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790668281; c=relaxed/relaxed;
	bh=rzcdTpogRZ+AxGuwL3IEbWBoohYfCz3D35l9Eoy+zTU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h+swdKVE4F2kzSyq8CVF09Zoh2zuvDem+bupdN96DeZAtguEOr8A1PjCaXHYZmxBGAhqcPDYAz2hSY9Qis2rYJ8qhuckphLcXeGBB72RbDJGkhpoGZqXxYy0OMMY0kuTz7KwjZNbtsdaxWIIf1m9fnV04oNMgCitptPw5g0HFSpNb2FEa+SsabLLDA3yU5eXnUAKLyXUawdTIB29QhcBTKMRekXzOsCKFgjPwSWtyjmaXg9IjnNMeY0ZgxErKyS4HHkPNazDAw1WD0euswcOoTrViDagy9WPqLy0C+GbrxBzu/ZvmkbHMSgcbatPbHLGj7rawQgvgG6mCdtH6hLWGw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GGdgApaw; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::b; helo=mail-pj2-x0b.google.com; envelope-from=suwangquanta@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GGdgApaw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::b; helo=mail-pj2-x0b.google.com; envelope-from=suwangquanta@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x0b.google.com (mail-pj2-x0b.google.com [IPv6:2607:f8b0:4864:39::b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hv9NS1ZnMz2yDD
	for <linux-aspeed@lists.ozlabs.org>; Tue, 29 Sep 2026 17:51:18 +1000 (AEST)
Received: by mail-pj2-x0b.google.com with SMTP id 98e67ed59e1d1-39569e136f9so1459733a91.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 29 Sep 2026 00:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790668276; x=1791273076; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rzcdTpogRZ+AxGuwL3IEbWBoohYfCz3D35l9Eoy+zTU=;
        b=GGdgApawy/QX05w8mRzGLNMPpBUzWf3AhCVtS1HjwUAlikch4XidWkm12wXWAPBhEj
         U6ifDjKhIkUQG3tFqhwXy6L7JpIbHGimmJB9JNPybfEKkLtmA0aAGeAqQVGNE+AdcUOh
         /sO4oNwsnxNUInQp/TjLmKeeoJ1V6qEIkuwEJYOJ+ThxUur9UwY3ebvfgk/BqxCFIhDu
         1ouYKSZSOXWJ5gzYtS5smaQHBcpw9MeL4gj/Cg2hxqYoKwaukErSDm+mSNlb1MNnlc7/
         eqM3+lzZatnAhMJbiVlm6cpwE/oQ5K0Sll3OIlkuSMGK5qHicdh17ATJveBvSvVgc5am
         fCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790668276; x=1791273076;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rzcdTpogRZ+AxGuwL3IEbWBoohYfCz3D35l9Eoy+zTU=;
        b=zr0YOalgFJ3Dk9uwnVgyEv73lXXsQ91jyOf8jIxdQj9euj00uwneZmwbfr4hNqMrrt
         ipzBMUaEg8PpZK2qwKPoPE3YTzrOW5Et79FLyQWxDGtshSEBKMhZPbMheY8f5wvdHiMQ
         hHBpdELy7BX5xjG3TmVU9+RgTz5CVZ8BKODYtkguPeQHnJmGNLZVaq5Lyi98KbhTOqr9
         zn5PLkjSYrzKrPtx3S0j3cQttE/zC0100m2XF2yL1kN/HMpKl8u/KA+KWGxUATTlbOWK
         I826eui4HzsztGTzB8KG9JpeeeSxs73XcotVomlyFmjjxHZp0Io+XxTAnoJTud8ARLEY
         1pYw==
X-Forwarded-Encrypted: i=1; AKwUvBwyKKQZnkivA+Ycn/3VBd9E+tyukAcOldWmJkscBq+5FX6FiAGBcJEcN7kAw8k4NCSAqm5UHBMpBGoe5OQ=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYI2o+ap26l8bVTfTm/PYnDPYn5imGFegEGth+TDHz4lt3NzidS7
	r4Lb/GsxHoPWz6val6eZiLvjAJoGkq53pcvw96aH2/MrN8TPoVqyv+TK
X-Gm-Gg: AYBFou0KiIM9AOqw+Gu752ZgkFUsaitdBDH9t3PHytP5ExowiMAWayOScdlUBEU7jTo
	hdtnXEEGw6OVzfCxMhugTFd05cPESM+ghLMQsPdaTLJPkrUhSS1Bai+jGQxu/Dl0H1NeoGwd3vv
	JtW1HZ9uUyCE4JMr1dtdCIethZlpz0Dv6/kUeTOf0ZmvYbqnOdPpZULGdb5njG9ZnKKnAkBWHK6
	VNywswNOPeWU3vxY11aTGKEMVxXUDLZhG1NBAX0gi+6RqITHbUGItJpm5THgNoyH6Zy382Tx+/B
	mOeYl3u8tdu+yoAR9Cpj9c3o6AFZBZcXm8lAH/8HdigNNK0yEKDWvIxRC3tg5o3bbcjqugNxH9r
	8+EDs4MA/IwaNv45hXLQXe1xJ1OTlHkWqEQ+FbDyJWkOp0X7EBVi4YfxZnRm+T4E6+3y/Af4+cF
	1WunAhF4bx9wUMVwrDp/bzbFiYrsCIU5uPezzQwtrJuUj4O76IEIKi+lcBWomye8CJACieQweaP
	INDLLUGJjM+Kk5OSsguDWQ3s1+Y8J5dT+e5K7xGxIKz7tYcVZMSpxF35hh5DuootpU=
X-Received: by 2002:a17:90b:4c4f:b0:3a0:bf0a:c9da with SMTP id 98e67ed59e1d1-3a0bf0ad1cbmr11593880a91.47.1790668276375;
        Tue, 29 Sep 2026 00:51:16 -0700 (PDT)
Received: from suewang-PC.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a497ebc998sm4049236a91.2.2026.09.29.00.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 00:51:15 -0700 (PDT)
From: Sue Wang <suwangquanta@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	ryan_chen@aspeedtech.com,
	billy_tsai@aspeedtech.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	patrick@stwcx.xyz
Cc: Steward.Shih@quantatw.com,
	Martin.Peng@quantatw.com,
	Fred.Zhang@quantatw.com,
	p.k.lee@quantatw.com
Subject: [PATCH v14 0/2] Add Meta (Facebook) Ventura BMC (AST2600)
Date: Tue, 29 Sep 2026 15:51:04 +0800
Message-Id: <20260929075106.74731-1-suwangquanta@gmail.com>
X-Mailer: git-send-email 2.34.1
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
devices connected to the BMC (AST2600) SoC. The purpose of Ventura
is to detect liquid leakage from all compute trays, switch trays
and rack sensors within the rack, log the events, and take necessary
actions accordingly.

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
---
v14:
    1. Modify "Facebook ventura RMC" to "Facebook Ventura RMC"
    2. Add a description for each bus alias.
    3. Revise commenting style.
    4. Enable mac0
    5. Remove two GPIO expanders (0x16 and 0x17) to i2c10 and two SGPIO
       pins as IRQs.
    6. Move the RPU_READY_SPARE_PLD_R and RPU_2_READY_PLD_R pins from
       the GPIO expander (0x10) to SGPIO.

Sue Wang (2):
  dt-bindings: arm: aspeed: add Meta Ventura board
  arm: dts: aspeed: ventura: add Meta Ventura BMC

 .../bindings/arm/aspeed/aspeed.yaml           |    1 +
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../aspeed/aspeed-bmc-facebook-ventura.dts    | 1607 +++++++++++++++++
 3 files changed, 1609 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dts

base-commit: c0538446e769fab620225578d378a0627b883bd5
branch: dev-6.18
-- 
2.34.1


