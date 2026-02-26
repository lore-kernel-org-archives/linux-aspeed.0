Return-Path: <linux-aspeed+bounces-3554-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D01FD9E1F
	for <linux-aspeed@archiver.kernel.org>; Thu, 26 Feb 2026 22:51:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMRXc5bSVz3bjb;
	Fri, 27 Feb 2026 09:51:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772085377;
	cv=none; b=b5tyKQEmnI+WVdKOY5k2pBirsoNLIlGzakuR1S/i4znVwyTl3eOC0rHH5ihYXYL04cUYDTQsfHpchVR5ib7nQMedUGWPjGpIb6bZqyKBaKJQ7nHiKspbWxoFVl+o0xJFOJAmAHmX6qweCliBwMTKAA7N6xzRYMXepZa40jPjJzK7E71Jz55ItkfZ6Cn6yD5GJVvDTTW/KPn3maeUBuBhy9gSOmc43ur0nJ1oAxkPrp0/7mv1hD/uDyQVlAJS4JUpGM0CocCLsr6DEnWttcICGXgWrUXbdSSDtjsCNkzgNCvbWn3Q+t1GpYdEww7vznpYulFcthIY3hn3WH2l6dF0Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772085377; c=relaxed/relaxed;
	bh=zB5OIdRyUZDuHaRXYIxGa9y4I4rBgImD51alFFCj5V0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OoenmGbfKR3+aqEubz0IBCYuEggYZWSeYy4yc+kS85NhJvkygM89oRnVoYh2nPJXTnfjngQfKXvQxr9r3AnQODdVj8tuIV0/HSsPGF4h1CLFLtGf0HIyoWNnIGKkKcov5YVHc5+BoqlLRYaqzy78mQ2qGVMJRZL6d0FhiFBapmPDz3X4lFmMbc7xBZ6c1d7vtNX8+AaLP6SRYY4H0kuxuvRmK7rSz1/mXVbD24HjVeo3oz+0J8VrFGS2/Of7W0db0dqyTZvWakC1Bhar0m9HyfUzHvxz9HD2dZ8TJ/4KtCoWWTObbmSIYarP+wtTg6NIPhOS4/QZSUbtZu1yOdpIJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=JWkQ1t46; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=pkleequanta@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=JWkQ1t46;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=pkleequanta@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fM10v2yJdz2x99
	for <linux-aspeed@lists.ozlabs.org>; Thu, 26 Feb 2026 16:56:14 +1100 (AEDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-8272a56b91cso527290b3a.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 25 Feb 2026 21:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772085372; x=1772690172; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zB5OIdRyUZDuHaRXYIxGa9y4I4rBgImD51alFFCj5V0=;
        b=JWkQ1t4645y2RPMhtTUupwmWKHY/lnD6YjmuSQdmSRfrUm+znk2oNkTdt+cRlCkyhu
         Zku+lBWtopvVFoJtkNa9mEw+89wkBRG9eaiCK295tnzhFg+DpEtqE7IoGVBi1AL4Ec2a
         7jsuEmK4tHimB8B92XrFjcpF8VjxNDHE8WFeMlxafGcZ1Rodcal/UBB2TB7ygkGsUFLP
         PS32Tyxd6TNqx8oG1aL2qRtn2SZvpJuVSSKA4ucHd3MjAY7MgWM/pwtyZfNc3qO8Hswa
         bu09HdzhTbL/mc7wyk2othn2zVS1TwXL7NHDdUyuI9UUgS3WCtQsv2peyTysden4QbOr
         61RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772085372; x=1772690172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zB5OIdRyUZDuHaRXYIxGa9y4I4rBgImD51alFFCj5V0=;
        b=IOU+V0nrfjHV1r46622KSr8KEQlOHyfqBmk3ilzZhEPgguclWJrNdSdZPqcnjpAVV5
         9shiGV2zrniK2Xh8Y51tdxrUunyVGgm9mHLA+aj2MWFXEfmQ7m8z4HcKqAVE75IRt0eq
         /OTaFI/0/tFzmWT5sgN2IbEktKuhW3Ru/a5lxMmnPcgDJqOtru1TLfIC5VxAY5yIIq2r
         xUvDofMOgDglXOrM3/b+zj2bV/itljOsHxFMeirpazfoY9jk+XtI758GMXvBz96cqwzd
         ZYCpbMiEwliokYZ9hN+Xh4tspK5X5KCcfHkhdzxMI0CdYcKjwJ+Wr1rKR9wEPdQp3e/A
         q6rA==
X-Forwarded-Encrypted: i=1; AJvYcCXtn4CVed6IDjNjgHl5R9eHliBFctMa7mpWX6bisIE9fchMQFGbnscWY94dB39ud0KlHUymDRFoLpmfST4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzT19fJ2pECkLmkhKknPBWc7y53CfNXxVkT1fQwtZDxo0vUyiPK
	0yrC0eZ4YPkx+BkKTS4mJ0FnZHAlbDvBJHJdk6NyoBSq5iW9q62gYEWV
X-Gm-Gg: ATEYQzzeUtNi6UmbJIoKKN4yZWFC27r/628ZHMRE63U1nB0bUNRS1Wr3l9piAg1TDJm
	qTu+9TDGKjde/YB36KewHd0TZ1p2b9n6RUup1qDY+KmK4zLx1wzyTCS1LCKRlPM9bjHsiTBTIDP
	EXX+r/hmtuLO5uuoOc3t91jmmHljgUCZF1Kum8FYfqm9cetAr6ivAkHofJGI1jRVexwRiEniNKI
	+aPGZyDHQyMIKeXK4BOydaRs7XCf7XJM8Wedxw8+a0x19RQcWEhi+HrsJBmtxYjJATD0z67QdCB
	aYRwEsCrB+byCa1SX49CxOYEaOFOohLSjQohrYkGu0TzQ5va564I0PsX5MHDN/sdqJXfkNv4q+S
	H9/bk8EKyEeSO4aHjHMdEStG19iOJMaINuKHZt8QeoIR5lKAg1KH7C31eMoV2im0SCQ8nmz69bS
	9IS+Ik+u8XFTxDKEsCf0zYe0Xwo2wFpA1r2HnJOrCyEEqoQeToKT6wXoMJj5N5nxRlcYK+TX8GN
	ECA2dFLvly6
X-Received: by 2002:a05:6a20:ae2f:b0:393:73e5:7404 with SMTP id adf61e73a8af0-395ad20d49bmr2808764637.52.1772085372523;
        Wed, 25 Feb 2026 21:56:12 -0800 (PST)
Received: from pk-pc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa82c284sm767851a12.23.2026.02.25.21.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 21:56:12 -0800 (PST)
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
Subject: [PATCH v12 0/2] Add Meta (Facebook) Ventura BMC (AST2600)
Date: Thu, 26 Feb 2026 13:55:19 +0800
Message-ID: <20260226055521.1655243-1-pkleequanta@gmail.com>
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

P.K. Lee (2):
  dt-bindings: arm: aspeed: add Meta Ventura board
  arm: dts: aspeed: ventura: add Meta Ventura BMC

 .../bindings/arm/aspeed/aspeed.yaml           |    1 +
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../aspeed/aspeed-bmc-facebook-ventura.dts    | 1592 +++++++++++++++++
 3 files changed, 1594 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dts

base-commit: e11fa6b1ff6c27c808d17e479bd7d5582e772062 
branch: dev-6.6
-- 
2.43.0


