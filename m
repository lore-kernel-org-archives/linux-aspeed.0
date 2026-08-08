Return-Path: <linux-aspeed+bounces-4658-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4F7C5AC67
	for <linux-aspeed@archiver.kernel.org>; Sat,  8 Aug 2026 10:58:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hHJ0g6HJwz2y1F;
	Sat, 08 Aug 2026 20:58:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::434"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786186723;
	cv=none; b=CjeJyD6dLVfzwyO2eT4Lj3i6fFcDflqR/TQqCJd0ckfgWb2w2WNZPbXykbRMYMXQKWwmOlOKfJQKaypGZ+JbTR4hc/1nPrr3mmx84jI0GYa+dXCs9sN1odcqbRrKI0GYG3kILhy+k7i7cVQbC+CPZdzjV0mxi9MSTe7cE6gTYeYb63+uH6dDIvHLgs3rhxswArSHSAsnKyvcnzjIU/JdW6/NeZ0iIUf8qsuMYjJjhohJdhNzSwWeo5lQeqUdOGrflqu3YRRC8JmQIf35tMBDm3lhipV4EzA20paI8mU9ndBDi9xXNkpqLCE0wwPVWDN6BOCwMO7TDY1JEXhp66w56A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786186723; c=relaxed/relaxed;
	bh=B0pxYO8gQFiI2HEdK45sM4L+A370G/lMJ/6AjaRsjoY=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=UibGF3ie4HpeZL8umSnWn/mxy596uMyGRzihGtZumsEI9EatAmQVPEERaInWLQdOkNSHW4nTwt+aCkbrInPxehzRqK5a3O4089rHc1ZZltHTLcN2SrnnjhQCeLhK3mwDqm1Jp5WqA6UKoJVuFkwz4Lg0g+KWZZDaU/t5IeHm7W19+Wu3fn9aXRnUBIj1tDkE6b9REMfZJehdelZ/nYIgtsiS82GGT4FHUwpiGM9uE6+yPNYSAq0K1FnPZUuquKhWgjyAhROeMH5+iX6ti1zakXczlkRGe0zNUGc+zSCtDwSRQNZDoUYM33G9v48uqjMeKlYyUNnXsjSRpN9RwyMdHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=QtIiOQAb; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=QtIiOQAb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::434; helo=mail-wr1-x434.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hHJ0c4H74z2xjN
	for <linux-aspeed@lists.ozlabs.org>; Sat, 08 Aug 2026 20:58:38 +1000 (AEST)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-47de0093c42so210420f8f.3
        for <linux-aspeed@lists.ozlabs.org>; Sat, 08 Aug 2026 03:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1786186709; x=1786791509; darn=lists.ozlabs.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=B0pxYO8gQFiI2HEdK45sM4L+A370G/lMJ/6AjaRsjoY=;
        b=QtIiOQAbdyLvcFavxkIRKRDVqVOm2hevrLqtPcHjSA7fiwoG+bhoqjBY0Kp4+gIm7o
         rvLq1B0+agrW2IHpcD1LWFA8dYcaSPxCqTeIiLVgv1nYq5UhImEaUPA+JH9LUapW7RUK
         gNEc5wHYsjiEJG+8NLefht1MI8YHRpRar+rkA+TMYBBrcHueKyA/iA97Rp/Q352ujTzr
         QUo285aJtIw8DqDaA6j5t7MLD9xqf7ETB3dWcOeAZ1knZ7/dq7i3w0M69djXXxQzbAlI
         NpovhGnOdUBlrmMKguY96KFzFtMzVJpyshgccuBvg9wSqMPwJ8Xw5yvygY+7d/zz6tQy
         bPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786186709; x=1786791509;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B0pxYO8gQFiI2HEdK45sM4L+A370G/lMJ/6AjaRsjoY=;
        b=R/6kQ3m4LJR1FgoFB2TCjbFoS9h4QzNgqNFrXGaersFzackl0tbVQG4E5zDJ7yh4CR
         2M26RhKk4yrHpuLiwQ9hzFpCfT8yGDciPnAUnGbejzwd/2ppy1r1z60oPyGIA/WvgLaN
         gFoWJ/J40QfeqAKKpuEzqB2yOq1mnce/T/TG3lHBnjI4M8U4qlwKP8PAkmUH++zS3J+c
         s11iCoPCK85/NlB3FeVJNG4WcMBhQzz+fDPSvi2Ez0P0n/AODeY6I/eTMBWXk2vrX7eO
         cKfZiwngKbMLSncy/qOOu9JTc5WFxKZ2YvNNRoXf75mLl8h/PKXokB9Di474ldb1cnAP
         y2FA==
X-Forwarded-Encrypted: i=1; AHgh+Rrq18A6KlRb7rZgL3Q1zScVK/gx2sDoEvRzeHC1jqG1UvQifvfbvIiUGfjSKdruasWObyqlJR+lMTUv7MM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxLdj/ZwIVCHNqRX0LqbJhyvDa1UI7A+/sGjx1CGUxsay7Hil0d
	i3HLbSyI6lE9KJX+AvxNUJae0v8/8zCQZrwUrKnNkMLo+KO1MNDgt4UXc0rcXUNrQSazIIwutdn
	zirS5lwLxow==
X-Gm-Gg: AR+sD12f1id5dgVDsVCwet8Qj64S9RCvXw6enG74EzngUYSibhvWhR8mzuIciXN9Gfa
	niHCp3w9968fvGbfMxy4oIi36pC5TTBlwSK/3Pzi+ltKgchQXvQhlQ/x79AwegZMbkLLq7ulmQa
	CFfwepV4Y+TqJj2fB4WydGzisM2kCbVDQ+ahgeIXG70wx7uWI88eKqOtN5aQRea0A2Wu9dHDgru
	O4uFNGqR0fxv2IHXEokefI+3rR6TiWQcQx3ZsoKH9Ra3U1cQvNmKzv5XvYz4VBCbE0Kd3dVhV7h
	914AqD8WwceTUfpjrVPDV6wVU02jvbftMmQN4RfLpmGxo6Oq6J4mEytNiKLMAWXh73GPWRXBZ+T
	xqndNq5IDPEevAbgPQniMfkX2ebqrtelUY1BmX07kp3odK55xDeYWozbp1AtvIIjhKlrWq/Zl+r
	n58xDiz6j6AAsn0EP+Q2BT3Z8TKGegTzSNbwbQ1SNWx98A+E/OYeAdK8lOm9vLQ0fLYO6lilURp
	d4=
X-Received: by 2002:a5d:4b52:0:b0:47f:ebe3:ca31 with SMTP id ffacd0b85a97d-481310e8ef2mr6693136f8f.28.1786186708859;
        Sat, 08 Aug 2026 03:58:28 -0700 (PDT)
Received: from white-mocha.local ([2a02:168:a773:a:eadb:61e4:c328:9421])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4800214557esm13535902f8f.2.2026.08.08.03.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 03:58:28 -0700 (PDT)
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
Subject: Re: [PATCH v4 02/12] ARM: dts: aspeed: anacapa: Add EVT1
 devicetree and point wrapper to it
From: Tan Siewert <tan.siewert@9elements.com>
To: Colin Huang <u8813345@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, colin.huang2@amd.com
In-Reply-To: <20260805-anacapa-devlop-phase-devicetree-v4-2-5d67e0efa6c5@gmail.com>
References: <20260805-anacapa-devlop-phase-devicetree-v4-0-5d67e0efa6c5@gmail.com>
 <20260805-anacapa-devlop-phase-devicetree-v4-2-5d67e0efa6c5@gmail.com>
Date: Sat, 08 Aug 2026 12:58:12 +0200
Message-Id: <178618669276.50041.10651670181152112668.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786186707; l=34689;
 i=tan.siewert@9elements.com; s=20260527; h=from:subject:message-id;
 bh=Y9TkkKEtfp8Olm61DMuAibQTNjvBLKVv5itWq/4yx9g=;
 b=+4UxNX14JsO2NWISZgY8BRtpiQRFlY+nQBqXQ6xDeNor6sNIR49pgY2RDynXuqF1moKbrsghg
 vFvb4WMcuQIBGF0NHD5hIX0ZXvvcQ87tJCkdEBAhELwwdA701rD/mz1
X-Developer-Key: i=tan.siewert@9elements.com; a=ed25519;
 pk=ORQd/zQf+LsAvJGXP1CjQwVO6t6iEOGq/eGUsmRVTG4=

Hi Colin,

> This change introduces a development-phase devicetree for the
> Facebook Anacapa BMC EVT1 hardware revision and updates the Anacapa
> wrapper DTS to reference it.


> 
> A dedicated EVT1 DTS is added for revision-specific hardware while
> keeping a single, Anacapa entrypoint used by the build and deployment
> flow. The top-level aspeed-bmc-facebook-anacapa.dts
> 
> Signed-off-by: Colin Huang <u8813345@gmail.com>




>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts
> new file mode 100644
> index 000000000000..a095be48a3fe
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts

`scripts/dtc/dt-check-style --mode strict` reports multiple errors:

    aspeed-bmc-facebook-anacapa-evt1.dts:10: [property-order] property 'compatible' out of canonical order (should sort before 'model')
    aspeed-bmc-facebook-anacapa-evt1.dts:18: [property-order] property 'i2c16' out of canonical order (should sort before 'serial4')
    aspeed-bmc-facebook-anacapa-evt1.dts:71: [continuation-alignment] continuation should align to column 31 (under "<" or \")
    aspeed-bmc-facebook-anacapa-evt1.dts:72: [continuation-alignment] continuation should align to column 31 (under "<" or \")
    aspeed-bmc-facebook-anacapa-evt1.dts:80: [property-order] property 'gpios' out of canonical order (should sort before 'label')
    aspeed-bmc-facebook-anacapa-evt1.dts:86: [property-order] property 'default-state' out of canonical order (should sort before 'label')
    aspeed-bmc-facebook-anacapa-evt1.dts:93: [property-order] property 'reg' out of canonical order (should sort before 'device_type')
    aspeed-bmc-facebook-anacapa-evt1.dts:99: [property-order] property 'ranges' out of canonical order (should sort before '#size-cells')
    aspeed-bmc-facebook-anacapa-evt1.dts:103: [property-order] property 'alignment' out of canonical order (should sort before 'size')
    aspeed-bmc-facebook-anacapa-evt1.dts:104: [property-order] property 'compatible' out of canonical order (should sort before 'alignment')
    aspeed-bmc-facebook-anacapa-evt1.dts:108: [child-name-order] child node 'framebuffer' out of name order
    aspeed-bmc-facebook-anacapa-evt1.dts:110: [property-order] property 'alignment' out of canonical order (should sort before 'size')
    aspeed-bmc-facebook-anacapa-evt1.dts:111: [property-order] property 'compatible' out of canonical order (should sort before 'alignment')
    aspeed-bmc-facebook-anacapa-evt1.dts:116: [child-name-order] child node 'regulator-p3v3-bmc-aux' out of name order
    aspeed-bmc-facebook-anacapa-evt1.dts:116: [unused-labels] label 'p3v3_bmc_aux' defined but never &-referenced
    aspeed-bmc-facebook-anacapa-evt1.dts:119: [property-order] property 'regulator-min-microvolt' out of canonical order (should sort before 'regulator-name')
    aspeed-bmc-facebook-anacapa-evt1.dts:120: [property-order] property 'regulator-max-microvolt' out of canonical order (should sort before 'regulator-min-microvolt')
    aspeed-bmc-facebook-anacapa-evt1.dts:121: [property-order] property 'regulator-always-on' out of canonical order (should sort before 'regulator-max-microvolt')
    aspeed-bmc-facebook-anacapa-evt1.dts:124: [unused-labels] label 'spi_gpio' defined but never &-referenced
    aspeed-bmc-facebook-anacapa-evt1.dts:129: [property-order] property 'sck-gpios' out of canonical order (should sort before '#size-cells')
    aspeed-bmc-facebook-anacapa-evt1.dts:130: [property-order] property 'mosi-gpios' out of canonical order (should sort before 'sck-gpios')
    aspeed-bmc-facebook-anacapa-evt1.dts:131: [property-order] property 'miso-gpios' out of canonical order (should sort before 'mosi-gpios')
    aspeed-bmc-facebook-anacapa-evt1.dts:132: [property-order] property 'cs-gpios' out of canonical order (should sort before 'miso-gpios')
    aspeed-bmc-facebook-anacapa-evt1.dts:134: [required-blank-lines] "status" must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:139: [property-order] property 'reg' out of canonical order (should sort before 'spi-max-frequency')
    aspeed-bmc-facebook-anacapa-evt1.dts:146: [property-order] property 'pinctrl-names' out of canonical order (should sort before 'aspeed,int-vref-microvolt')
    aspeed-bmc-facebook-anacapa-evt1.dts:147: [property-order] property 'pinctrl-0' out of canonical order (should sort before 'pinctrl-names')
    aspeed-bmc-facebook-anacapa-evt1.dts:148: [continuation-alignment] continuation should align to column 21 (under "<" or \")
    aspeed-bmc-facebook-anacapa-evt1.dts:149: [continuation-alignment] continuation should align to column 21 (under "<" or \")
    aspeed-bmc-facebook-anacapa-evt1.dts:150: [continuation-alignment] continuation should align to column 21 (under "<" or \")
    aspeed-bmc-facebook-anacapa-evt1.dts:151: [required-blank-lines] "status" must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:156: [property-order] property 'pinctrl-names' out of canonical order (should sort before 'aspeed,int-vref-microvolt')
    aspeed-bmc-facebook-anacapa-evt1.dts:157: [property-order] property 'pinctrl-0' out of canonical order (should sort before 'pinctrl-names')
    aspeed-bmc-facebook-anacapa-evt1.dts:158: [required-blank-lines] "status" must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:170: [property-order] property 'm25p,fast-read' out of canonical order (should sort before 'status')
    aspeed-bmc-facebook-anacapa-evt1.dts:171: [property-order] property 'label' out of canonical order (should sort before 'm25p,fast-read')
    aspeed-bmc-facebook-anacapa-evt1.dts:178: [property-order] property 'm25p,fast-read' out of canonical order (should sort before 'status')
    aspeed-bmc-facebook-anacapa-evt1.dts:179: [property-order] property 'label' out of canonical order (should sort before 'm25p,fast-read')
    aspeed-bmc-facebook-anacapa-evt1.dts:186: [property-order] property 'memory-region' out of canonical order (should sort before 'status')
    aspeed-bmc-facebook-anacapa-evt1.dts:314: [property-order] property 'i2c-mux-idle-disconnect' out of canonical order (should sort before '#size-cells')
    aspeed-bmc-facebook-anacapa-evt1.dts:321: [required-blank-lines] child node must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:326: [required-blank-lines] child node must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:331: [required-blank-lines] child node must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:354: [property-order] property 'i2c-mux-idle-disconnect' out of canonical order (should sort before '#size-cells')
    aspeed-bmc-facebook-anacapa-evt1.dts:361: [required-blank-lines] child node must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:366: [required-blank-lines] child node must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:371: [required-blank-lines] child node must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:388: [property-order] property 'i2c-mux-idle-disconnect' out of canonical order (should sort before '#size-cells')
    aspeed-bmc-facebook-anacapa-evt1.dts:395: [required-blank-lines] child node must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:400: [required-blank-lines] child node must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:405: [required-blank-lines] child node must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:410: [required-blank-lines] child node must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:415: [required-blank-lines] child node must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:420: [required-blank-lines] child node must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:425: [required-blank-lines] child node must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:453: [blank-lines] consecutive blank lines
    aspeed-bmc-facebook-anacapa-evt1.dts:453: [blank-lines] blank line at end of node body
    aspeed-bmc-facebook-anacapa-evt1.dts:465: [property-order] property 'i2c-mux-idle-disconnect' out of canonical order (should sort before '#size-cells')
    aspeed-bmc-facebook-anacapa-evt1.dts:482: [property-order] property '#gpio-cells' out of canonical order (should sort before 'gpio-controller')
    aspeed-bmc-facebook-anacapa-evt1.dts:487: [property-order] property 'gpio-line-names' out of canonical order (should sort before 'interrupts')
    aspeed-bmc-facebook-anacapa-evt1.dts:504: [property-order] property '#gpio-cells' out of canonical order (should sort before 'gpio-controller')
    aspeed-bmc-facebook-anacapa-evt1.dts:509: [property-order] property 'gpio-line-names' out of canonical order (should sort before 'interrupts')
    aspeed-bmc-facebook-anacapa-evt1.dts:527: [required-blank-lines] child node must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:536: [property-order] property '#gpio-cells' out of canonical order (should sort before 'gpio-controller')
    aspeed-bmc-facebook-anacapa-evt1.dts:541: [property-order] property 'gpio-line-names' out of canonical order (should sort before 'interrupts')
    aspeed-bmc-facebook-anacapa-evt1.dts:556: [property-order] property '#gpio-cells' out of canonical order (should sort before 'gpio-controller')
    aspeed-bmc-facebook-anacapa-evt1.dts:561: [property-order] property 'gpio-line-names' out of canonical order (should sort before 'interrupts')
    aspeed-bmc-facebook-anacapa-evt1.dts:578: [required-blank-lines] child node must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:583: [required-blank-lines] child node must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:617: [property-order] property 'i2c-mux-idle-disconnect' out of canonical order (should sort before '#size-cells')
    aspeed-bmc-facebook-anacapa-evt1.dts:624: [required-blank-lines] child node must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:629: [required-blank-lines] child node must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:634: [required-blank-lines] child node must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:639: [required-blank-lines] child node must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:644: [required-blank-lines] child node must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:653: [property-order] property '#gpio-cells' out of canonical order (should sort before 'gpio-controller')
    aspeed-bmc-facebook-anacapa-evt1.dts:672: [required-blank-lines] child node must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:677: [required-blank-lines] child node must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:694: [property-order] property 'i2c-mux-idle-disconnect' out of canonical order (should sort before '#size-cells')
    aspeed-bmc-facebook-anacapa-evt1.dts:701: [required-blank-lines] child node must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:706: [required-blank-lines] child node must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:711: [required-blank-lines] child node must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:716: [required-blank-lines] child node must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:721: [required-blank-lines] child node must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:730: [property-order] property '#gpio-cells' out of canonical order (should sort before 'gpio-controller')
    aspeed-bmc-facebook-anacapa-evt1.dts:749: [required-blank-lines] child node must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:754: [required-blank-lines] child node must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:776: [property-order] property 'i2c-mux-idle-disconnect' out of canonical order (should sort before '#size-cells')
    aspeed-bmc-facebook-anacapa-evt1.dts:783: [required-blank-lines] child node must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:788: [required-blank-lines] child node must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:793: [required-blank-lines] child node must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:804: [required-blank-lines] child node must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:815: [required-blank-lines] child node must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:820: [required-blank-lines] child node must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:825: [required-blank-lines] child node must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:837: [property-order] property 'enable-gpios' out of canonical order (should sort before 'interrupts')
    aspeed-bmc-facebook-anacapa-evt1.dts:854: [required-blank-lines] "status" must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:859: [required-blank-lines] "status" must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:868: [property-order] property 'pinctrl-names' out of canonical order (should sort before 'status')
    aspeed-bmc-facebook-anacapa-evt1.dts:869: [property-order] property 'pinctrl-0' out of canonical order (should sort before 'pinctrl-names')
    aspeed-bmc-facebook-anacapa-evt1.dts:875: [property-order] property 'bus-frequency' out of canonical order (should sort before 'ngpios')
    aspeed-bmc-facebook-anacapa-evt1.dts:1020: [property-order] property 'pinctrl-0' out of canonical order (should sort before 'pinctrl-names')
    aspeed-bmc-facebook-anacapa-evt1.dts:1021: [required-blank-lines] "status" must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:1022: [property-order] property 'reg' out of canonical order (should sort before 'status')
    aspeed-bmc-facebook-anacapa-evt1.dts:1029: [property-order] property 'spi-rx-bus-width' out of canonical order (should sort before 'spi-tx-bus-width')
    aspeed-bmc-facebook-anacapa-evt1.dts:1030: [required-blank-lines] "status" must be preceded by a blank line
    aspeed-bmc-facebook-anacapa-evt1.dts:1062: [property-order] property 'pinctrl-names' out of canonical order (should sort before 'status')
    aspeed-bmc-facebook-anacapa-evt1.dts:1067: [property-order] property 'memory-region' out of canonical order (should sort before 'status')
    aspeed-bmc-facebook-anacapa-evt1.dts:1072: [property-order] property 'pinctrl-0' out of canonical order (should sort before 'pinctrl-names')
    aspeed-bmc-facebook-anacapa-evt1.dts:1074: [property-order] property 'aspeed,external-signal' out of canonical order (should sort before 'aspeed,reset-type')
    aspeed-bmc-facebook-anacapa-evt1.dts:1075: [property-order] property 'aspeed,ext-push-pull' out of canonical order (should sort before 'aspeed,external-signal')
    aspeed-bmc-facebook-anacapa-evt1.dts:1076: [property-order] property 'aspeed,ext-active-high' out of canonical order (should sort before 'aspeed,ext-push-pull')
    aspeed-bmc-facebook-anacapa-evt1.dts:1078: [required-blank-lines] "status" must be preceded by a blank line

> @@ -0,0 +1,1079 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/dts-v1/;
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/i2c/i2c.h>
> +
> +/ {
> +	model = "Facebook Anacapa BMC";
> +	compatible = "facebook,anacapa-bmc-evt1", "aspeed,ast2600";
> +
> +	aliases {
> +		serial0 = &uart1;
> +		serial1 = &uart2;
> +		serial2 = &uart3;
> +		serial3 = &uart4;
> +		serial4 = &uart5;
> +		i2c16 = &i2c0mux0ch0;
> +		i2c17 = &i2c0mux0ch1;
> +		i2c18 = &i2c0mux0ch2;
> +		i2c19 = &i2c0mux0ch3;
> +		i2c20 = &i2c1mux0ch0;
> +		i2c21 = &i2c1mux0ch1;
> +		i2c22 = &i2c1mux0ch2;
> +		i2c23 = &i2c1mux0ch3;
> +		i2c24 = &i2c4mux0ch0;
> +		i2c25 = &i2c4mux0ch1;
> +		i2c26 = &i2c4mux0ch2;
> +		i2c27 = &i2c4mux0ch3;
> +		i2c28 = &i2c4mux0ch4;
> +		i2c29 = &i2c4mux0ch5;
> +		i2c30 = &i2c4mux0ch6;
> +		i2c31 = &i2c4mux0ch7;
> +		i2c32 = &i2c8mux0ch0;
> +		i2c33 = &i2c8mux0ch1;
> +		i2c34 = &i2c8mux0ch2;
> +		i2c35 = &i2c8mux0ch3;
> +		i2c36 = &i2c10mux0ch0;
> +		i2c37 = &i2c10mux0ch1;
> +		i2c38 = &i2c10mux0ch2;
> +		i2c39 = &i2c10mux0ch3;
> +		i2c40 = &i2c10mux0ch4;
> +		i2c41 = &i2c10mux0ch5;
> +		i2c42 = &i2c10mux0ch6;
> +		i2c43 = &i2c10mux0ch7;
> +		i2c44 = &i2c11mux0ch0;
> +		i2c45 = &i2c11mux0ch1;
> +		i2c46 = &i2c11mux0ch2;
> +		i2c47 = &i2c11mux0ch3;
> +		i2c48 = &i2c11mux0ch4;
> +		i2c49 = &i2c11mux0ch5;
> +		i2c50 = &i2c11mux0ch6;
> +		i2c51 = &i2c11mux0ch7;
> +		i2c52 = &i2c13mux0ch0;
> +		i2c53 = &i2c13mux0ch1;
> +		i2c54 = &i2c13mux0ch2;
> +		i2c55 = &i2c13mux0ch3;
> +		i2c56 = &i2c13mux0ch4;
> +		i2c57 = &i2c13mux0ch5;
> +		i2c58 = &i2c13mux0ch6;
> +		i2c59 = &i2c13mux0ch7;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial4:57600n8";
> +	};
> +
> +	iio-hwmon {
> +		compatible = "iio-hwmon";
> +		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
> +				  <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
> +				  <&adc1 2>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led-0 {
> +			label = "bmc_heartbeat_amber";
> +			gpios = <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		led-1 {
> +			label = "fp_id_amber";
> +			default-state = "off";
> +			gpios = <&gpio0 ASPEED_GPIO(B, 5) GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x80000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		video_engine_memory: video {
> +			size = <0x02c00000>;
> +			alignment = <0x00100000>;
> +			compatible = "shared-dma-pool";
> +			reusable;
> +		};
> +
> +		gfx_memory: framebuffer {
> +			size = <0x01000000>;
> +			alignment = <0x01000000>;
> +			compatible = "shared-dma-pool";
> +			reusable;
> +		};
> +	};
> +
> +	p3v3_bmc_aux: regulator-p3v3-bmc-aux {
> +		compatible = "regulator-fixed";
> +		regulator-name = "p3v3_bmc_aux";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +	};
> +
> +	spi_gpio: spi {
> +		compatible = "spi-gpio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		sck-gpios = <&gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
> +		mosi-gpios = <&gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
> +		miso-gpios = <&gpio0 ASPEED_GPIO(Z, 5) GPIO_ACTIVE_HIGH>;
> +		cs-gpios = <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
> +		num-chipselects = <1>;
> +		status = "okay";
> +
> +		tpm@0 {
> +			compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
> +			spi-max-frequency = <33000000>;
> +			reg = <0>;
> +		};
> +	};
> +};

*snip*

> +// AMC
> +&i2c5 {
> +	status = "okay";
> +};
> +
> +// MB
> +&i2c6 {
> +	status = "okay";
> +
> +	// HPM FRU
> +	eeprom@50 {
> +		compatible = "atmel,24c256";
> +		reg = <0x50>;
> +	};
> +};
> +
> +// SCM
> +&i2c7 {
> +	status = "okay";
> +
> +

Unnecessary newlines.

> +};
> +
> +// MB - PDB
> +&i2c8 {
> +	status = "okay";
> +
> +	i2c-mux@72 {
> +		compatible = "nxp,pca9546";
> +		reg = <0x72>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		i2c-mux-idle-disconnect;
> +
> +		i2c8mux0ch0: i2c@0 {
> +			reg = <0>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			adc@1f {
> +				compatible = "ti,adc128d818";
> +				reg = <0x1f>;
> +				ti,mode = /bits/ 8 <1>;
> +			};
> +
> +			gpio@22 {
> +				compatible = "nxp,pca9555";
> +				reg = <0x22>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +
> +				interrupt-parent = <&sgpiom0>;
> +				interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
> +
> +				gpio-line-names =
> +					"RPDB_FAN_FULL_SPEED_R_N", "RPDB_I2C_TEMP75_U8_ALERT_R_N",
> +					"RPDB_I2C_TMP432_U29_ALERT_R_N", "RPDB_GLOBAL_WP",
> +					"RPDB_FAN_CT_FAN_FAIL_R_N", "",
> +					"", "",
> +					"RPDB_ALERT_P50V_HSC2_R_N", "RPDB_ALERT_P50V_HSC3_R_N",
> +					"RPDB_ALERT_P50V_HSC4_R_N", "RPDB_ALERT_P50V_STBY_R_N",
> +					"RPDB_I2C_P12V_MB_VRM_ALERT_R_N",
> +					"RPDB_I2C_P12V_STBY_VRM_ALERT_R_N",
> +					"RPDB_PGD_P3V3_STBY_PWRGD_R",
> +					"RPDB_P12V_STBY_VRM_PWRGD_BUF_R";
> +			};
> +
> +			gpio@24 {
> +				compatible = "nxp,pca9555";
> +				reg = <0x24>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +
> +				interrupt-parent = <&sgpiom0>;
> +				interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
> +
> +				gpio-line-names =
> +					"RPDB_EAM2_PRSNT_MOS_N_R", "RPDB_EAM3_PRSNT_MOS_N_R",
> +					"RPDB_PWRGD_P50V_HSC4_SYS_R",
> +					"RPDB_PWRGD_P50V_STBY_SYS_BUF_R",
> +					"RPDB_P50V_FAN1_R2_PG", "RPDB_P50V_FAN2_R2_PG",
> +					"RPDB_P50V_FAN3_R2_PG", "RPDB_P50V_FAN4_R2_PG",
> +					"", "RPDB_FAN1_PRSNT_N_R",
> +					"", "RPDB_FAN2_PRSNT_N_R",
> +					"RPDB_FAN3_PRSNT_N_R", "RPDB_FAN4_PRSNT_N_R",
> +					"", "";
> +			};
> +
> +			// R-PDB FRU
> +			eeprom@50 {
> +				compatible = "atmel,24c128";
> +				reg = <0x50>;
> +			};
> +		};
> +		i2c8mux0ch1: i2c@1 {
> +			reg = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			gpio@22 {
> +				compatible = "nxp,pca9555";
> +				reg = <0x22>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +
> +				interrupt-parent = <&sgpiom0>;
> +				interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
> +
> +				gpio-line-names =
> +					"LPDB_FAN_FULL_SPEED_R_N","LPDB_I2C_TEMP75_U8_ALERT_R_N",
> +					"LPDB_I2C_TMP432_U29_ALERT_R_N","LPDB_GLOBAL_WP",
> +					"LPDB_FAN_CT_FAN_FAIL_R_N","",
> +					"","",
> +					"LPDB_ALERT_P50V_HSC0_R_N","LPDB_ALERT_P50V_HSC1_R_N",
> +					"LPDB_ALERT_P50V_HSC5_R_N","LPDB_I2C_P12V_SW_VRM_ALERT_R_N",
> +					"LPDB_EAM0_PRSNT_MOS_N_R","LPDB_EAM1_PRSNT_MOS_N_R",
> +					"LPDB_PWRGD_P50V_HSC5_SYS_R","";
> +			};
> +
> +			gpio@24 {
> +				compatible = "nxp,pca9555";
> +				reg = <0x24>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +
> +				interrupt-parent = <&sgpiom0>;
> +				interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
> +
> +				gpio-line-names =
> +					"LPDB_P50V_FAN1_R2_PG","LPDB_P50V_FAN2_R2_PG",
> +					"LPDB_P50V_FAN3_R2_PG","LPDB_P50V_FAN4_R2_PG",
> +					"LPDB_P50V_FAN5_R2_PG","LPDB_FAN1_PRSNT_N_R",
> +					"LPDB_FAN2_PRSNT_N_R","LPDB_FAN3_PRSNT_N_R",
> +					"LPDB_FAN4_PRSNT_N_R","LPDB_FAN5_PRSNT_N_R",
> +					"","",
> +					"","",
> +					"","";
> +			};
> +
> +			// L-PDB FRU
> +			eeprom@50 {
> +				compatible = "atmel,24c128";
> +				reg = <0x50>;
> +			};
> +		};
> +		i2c8mux0ch2: i2c@2 {
> +			reg = <2>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +		i2c8mux0ch3: i2c@3 {
> +			reg = <3>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +	};
> +};
> +
> +// SCM
> +&i2c9 {
> +	status = "okay";
> +
> +	// SCM FRU
> +	eeprom@50 {
> +		compatible = "atmel,24c128";
> +		reg = <0x50>;
> +	};
> +
> +	// BSM FRU
> +	eeprom@56 {
> +		compatible = "atmel,24c64";
> +		reg = <0x56>;
> +	};
> +};
> +
> +// R Bridge Board
> +&i2c10 {
> +	status = "okay";
> +
> +	i2c-mux@71 {
> +		compatible = "nxp,pca9548";
> +		reg = <0x71>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		i2c-mux-idle-disconnect;
> +
> +		i2c10mux0ch0: i2c@0 {
> +			reg = <0>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +		i2c10mux0ch1: i2c@1 {
> +			reg = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +		i2c10mux0ch2: i2c@2 {
> +			reg = <2>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +		i2c10mux0ch3: i2c@3 {
> +			reg = <3>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +		i2c10mux0ch4: i2c@4 {
> +			reg = <4>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +		i2c10mux0ch5: i2c@5 {
> +			reg = <5>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			gpio@22 {
> +				compatible = "nxp,pca9555";
> +				reg = <0x22>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +
> +				gpio-line-names =
> +					"","",
> +					"","RBB_CPLD_REFRESH_IN_PRGRS_R_L",
> +					"RBB_EAM0_NIC_CBL_PRSNT_R_L","RBB_EAM1_NIC_CBL_PRSNT_R_L",
> +					"RBB_AINIC_JTAG_MUX_R2_SEL","RBB_SPI_MUX0_R2_SEL",
> +					"RBB_AINIC_PRSNT_R_L","RBB_AINIC_OE_R_N",
> +					"RBB_AINIC_BOARD_R2_ID","RBB_RST_USB2_HUB_R_N",
> +					"RBB_RST_FT4222_R_N","RBB_RST_MCP2210_R_N",
> +					"","";
> +			};
> +
> +			// R Bridge Board FRU
> +			eeprom@52 {
> +				compatible = "atmel,24c256";
> +				reg = <0x52>;
> +			};
> +		};
> +		i2c10mux0ch6: i2c@6 {
> +			reg = <6>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +		i2c10mux0ch7: i2c@7 {
> +			reg = <7>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +	};
> +};
> +
> +// L Bridge Board
> +&i2c11 {
> +	status = "okay";
> +
> +	i2c-mux@71 {
> +		compatible = "nxp,pca9548";
> +		reg = <0x71>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		i2c-mux-idle-disconnect;
> +
> +		i2c11mux0ch0: i2c@0 {
> +			reg = <0>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +		i2c11mux0ch1: i2c@1 {
> +			reg = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +		i2c11mux0ch2: i2c@2 {
> +			reg = <2>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +		i2c11mux0ch3: i2c@3 {
> +			reg = <3>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +		i2c11mux0ch4: i2c@4 {
> +			reg = <4>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +		i2c11mux0ch5: i2c@5 {
> +			reg = <5>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			gpio@22 {
> +				compatible = "nxp,pca9555";
> +				reg = <0x22>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +
> +				gpio-line-names =
> +					"","",
> +					"","LBB_CPLD_REFRESH_IN_PRGRS_R_L",
> +					"LBB_EAM0_NIC_CBL_PRSNT_R_L","LBB_EAM1_NIC_CBL_PRSNT_R_L",
> +					"LBB_AINIC_JTAG_MUX_R2_SEL","LBB_SPI_MUX0_R2_SEL",
> +					"LBB_AINIC_PRSNT_R_L","LBB_AINIC_OE_R_N",
> +					"LBB_AINIC_BOARD_R2_ID","LBB_RST_USB2_HUB_R_N",
> +					"LBB_RST_FT4222_R_N","LBB_RST_MCP2210_R_N",
> +					"","";
> +			};
> +
> +			// L Bridge Board FRU
> +			eeprom@52 {
> +				compatible = "atmel,24c256";
> +				reg = <0x52>;
> +			};
> +		};
> +		i2c11mux0ch6: i2c@6 {
> +			reg = <6>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +		i2c11mux0ch7: i2c@7 {
> +			reg = <7>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +	};
> +};
> +
> +// Debug Card
> +&i2c12 {
> +	status = "okay";
> +};
> +
> +// MB
> +&i2c13 {
> +	status = "okay";
> +
> +	i2c-mux@70 {
> +		compatible = "nxp,pca9548";
> +		reg = <0x70>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		i2c-mux-idle-disconnect;
> +
> +		i2c13mux0ch0: i2c@0 {
> +			reg = <0>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +		i2c13mux0ch1: i2c@1 {
> +			reg = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +		i2c13mux0ch2: i2c@2 {
> +			reg = <2>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +		i2c13mux0ch3: i2c@3 {
> +			reg = <3>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			adc@1f {
> +				compatible = "ti,adc128d818";
> +				reg = <0x1f>;
> +				ti,mode = /bits/ 8 <1>;
> +			};
> +		};
> +		i2c13mux0ch4: i2c@4 {
> +			reg = <4>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			// HPM BRD ID FRU
> +			eeprom@51 {
> +				compatible = "atmel,24c256";
> +				reg = <0x51>;
> +			};
> +		};
> +		i2c13mux0ch5: i2c@5 {
> +			reg = <5>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +		i2c13mux0ch6: i2c@6 {
> +			reg = <6>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +		i2c13mux0ch7: i2c@7 {
> +			reg = <7>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			nfc@28 {
> +				compatible = "nxp,nxp-nci-i2c";
> +				reg = <0x28>;
> +
> +				interrupt-parent = <&sgpiom0>;
> +				interrupts = <156 IRQ_TYPE_LEVEL_HIGH>;
> +
> +				enable-gpios = <&sgpiom0 241 GPIO_ACTIVE_HIGH>;
> +			};
> +		};
> +	};
> +};
> +
> +// SCM
> +&i2c14 {
> +	status = "okay";
> +};
> +
> +&i2c15 {
> +	status = "okay";
> +};
> +
> +&kcs2 {
> +	aspeed,lpc-io-reg = <0xca8>;
> +	status = "okay";
> +};
> +
> +&kcs3 {
> +	aspeed,lpc-io-reg = <0xca2>;
> +	status = "okay";
> +};
> +
> +&lpc_ctrl {
> +	status = "okay";
> +};
> +
> +&mac2 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ncsi3_default>;
> +	use-ncsi;
> +};
> +
> +&sgpiom0 {
> +	ngpios = <128>;
> +	bus-frequency = <2000000>;
> +	gpio-line-names =
> +	/*in - out - in - out */
> +	/* A0-A7 line 0-15 */
> +	"", "FM_CPU0_SYS_RESET_N", "", "CPU0_KBRST_N",
> +	"", "FM_CPU0_PROCHOT_trigger_N", "", "FM_CLR_CMOS_R_P0",
> +	"", "Force_I3C_SEL", "", "SYSTEM_Force_Run_AC_Cycle",
> +	"", "", "", "",
> +
> +	/* B0-B7 line 16-31 */
> +	"Channel0_leakage_EAM3", "FM_CPU_FPGA_JTAG_MUX_SEL",
> +	"Channel1_leakage_EAM0", "FM_SCM_JTAG_MUX_SEL",
> +	"Channel2_leakage_Manifold1", "FM_BRIDGE_JTAG_MUX_SEL",
> +	"Channel3_leakage", "FM_CPU0_NMI_SYNC_FLOOD_N",
> +	"Channel4_leakage_Manifold2", "",
> +	"Channel5_leakage_EAM1", "",
> +	"Channel6_leakage_CPU_DIMM", "",
> +	"Channel7_leakage_EAM2", "",
> +
> +	/* C0-C7 line 32-47 */
> +	"RSVD_RMC_GPIO3", "", "", "",
> +	"", "", "", "",
> +	"LEAK_DETECT_RMC_N", "JTAG_CPLD_TRST_R_N", "", "",
> +	"", "", "", "",
> +
> +	/* D0-D7 line 48-63 */
> +	"PWRGD_PDB_EAMHSC0_CPLD_PG_R", "",
> +	"PWRGD_PDB_EAMHSC1_CPLD_PG_R", "",
> +	"PWRGD_PDB_EAMHSC2_CPLD_PG_R", "",
> +	"PWRGD_PDB_EAMHSC3_CPLD_PG_R", "",
> +	"AMC_BRD_PRSNT_CPLD_L", "", "", "",
> +	"", "", "", "",
> +
> +	/* E0-E7 line 64-79 */
> +	"AMC_PDB_EAMHSC0_CPLD_EN_R", "",
> +	"AMC_PDB_EAMHSC1_CPLD_EN_R", "",
> +	"AMC_PDB_EAMHSC2_CPLD_EN_R", "",
> +	"AMC_PDB_EAMHSC3_CPLD_EN_R", "",
> +	"", "", "", "",
> +	"", "", "", "",
> +
> +	/* F0-F7 line 80-95 */
> +	"PWRGD_PVDDCR_CPU1_P0", "SGPIO_READY",
> +	"PWRGD_PVDDCR_CPU0_P0", "",
> +	"", "", "", "",
> +	"", "", "", "",
> +
> +	/* G0-G7 line 96-111 */
> +	"L_PRSNT_EDSFF0_N", "",
> +	"L_PRSNT_EDSFF1_N", "",
> +	"R_PRSNT_EDSFF2_N", "",
> +	"R_PRSNT_EDSFF3_N", "",
> +	"HPM_EDSFF_PG", "",
> +	"PWRGD_CHEH_CPU0_FPGA", "",
> +	"PWRGD_CHAD_CPU0_FPGA", "FM_BMC_READY_PLD",
> +	"", "",
> +
> +	/* H0-H7 line 112-127 */
> +	"PWRGD_P3V3", "",
> +	"P12V_DDR_IP_PWRGD_R", "",
> +	"P12V_DDR_AH_PWRGD_R", "",
> +	"PWRGD_P12V_VRM1_CPLD_PG_R", "",
> +	"PWRGD_P12V_VRM0_CPLD_PG_R", "",
> +	"PWRGD_PDB_HSC4_CPLD_PG_R", "",
> +	"PWRGD_PVDD18_S5_P0_PG", "",
> +	"PWRGD_PVDD33_S5_P0_PG", "",
> +
> +	/* I0-I7 line 128-143 */
> +	"EAM0_BRD_PRSNT_R_L", "",
> +	"EAM1_BRD_PRSNT_R_L", "",
> +	"EAM2_BRD_PRSNT_R_L", "",
> +	"EAM3_BRD_PRSNT_R_L", "",
> +	"EAM0_CPU_MOD_PWR_GD_R", "",
> +	"EAM1_CPU_MOD_PWR_GD_R", "",
> +	"PRSNT_EDSFF_BOOT_N", "",
> +	"EAM3_CPU_MOD_PWR_GD_R", "",
> +
> +	/* J0-J7 line 144-159 */
> +	"PRSNT_L_BIRDGE_R", "",
> +	"PRSNT_R_BIRDGE_R", "",
> +	"BRIDGE_L_MAIN_PG_R", "",
> +	"BRIDGE_R_MAIN_PG_R", "",
> +	"BRIDGE_L_STBY_PG_R", "",
> +	"BRIDGE_R_STBY_PG_R", "",
> +	"", "", "", "",
> +
> +	/* K0-K7 line 160-175 */
> +	"ADC_I2C_ALERT_N", "",
> +	"TEMP_I2C_ALERT_R_L", "",
> +	"CPU0_VR_SMB_ALERT_CPLD_N", "",
> +	"COVER_INTRUDER_R_N", "",
> +	"HANDLE_INTRUDER_CPLD_N", "",
> +	"IRQ_MCIO_CPLD_WAKE_R_N", "",
> +	"APML_CPU0_ALERT_R_N", "",
> +	"PDB_ALERT_R_N", "",
> +
> +	/* L0-L7 line 176-191 */
> +	"L_EDSFF0_PG", "", "L_EDSFF1_PG", "",
> +	"R_EDSFF2_PG", "", "R_EDSFF3_PG", "",
> +	"CPU0_CORETYPE0", "", "CPU0_CORETYPE1", "",
> +	"CPU0_CORETYPE2", "", "FM_BIOS_POST_CMPLT_R_N", "",
> +
> +	/* M0-M7 line 192-207 */
> +	"EAM0_SMERR_CPLD_R_L", "",
> +	"EAM1_SMERR_CPLD_R_L", "",
> +	"EAM2_SMERR_CPLD_R_L", "",
> +	"EAM3_SMERR_CPLD_R_L", "",
> +	"CPU0_SMERR_N_R", "",
> +	"CPU0_NV_SAVE_N_R", "",
> +	"PDB_PWR_LOSS_CPLD_N", "",
> +	"IRQ_BMC_SMI_ACTIVE_R_N", "",
> +
> +	/* N0-N7 line 208-223 */
> +	"AMCROT_BMC_S5_RDY_R", "",
> +	"AMC_RDY_R", "",
> +	"AMC_STBY_PGOOD_R", "",
> +	"CPU_AMC_SLP_S5_R_L", "",
> +	"AMC_CPU_EAMPG_R", "",
> +	"", "", "", "",
> +
> +	/* O0-O7 line 224-239 */
> +	"HPM_PWR_FAIL", "Port80_b0",
> +	"FM_DIMM_IP_FAIL", "Port80_b1",
> +	"FM_DIMM_AH_FAIL", "Port80_b2",
> +	"AMC_THERMTRIP_ASSERT", "Port80_b3",
> +	"CPU_THERMTRIP_ASSERT", "Port80_b4",
> +	"PVDDCR_SOC_P0_OCP_L", "Port80_b5",
> +	"CPLD_SGPIO_RDY", "Port80_b6",
> +	"", "Port80_b7",
> +
> +	/* P0-P7 line 240-255 */
> +	"CPU0_SLP_S5_N_R", "NFC_VEN",
> +	"CPU0_SLP_S3_N_R", "",
> +	"FM_CPU0_PWRGD", "",
> +	"PWRGD_RMC", "",
> +	"FM_RST_CPU0_RESET_N", "",
> +	"FM_PWRGD_CPU0_PWROK", "",
> +	"wS5_PWR_Ready", "",
> +	"wS0_ON_N", "PWRGD_P1V0_AUX";
> +	status = "okay";
> +};
> +
> +// BIOS Flash
> +&spi2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_spi2_default>;
> +	status = "okay";
> +	reg = <0x1e631000 0xc4>, <0x50000000 0x8000000>;

Why do you overwrite the SPI2 memory size to 128MB only?
Even if you use the other part for the TPM, you should not overwrite the memory
region...

> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		label = "pnor";
> +		spi-max-frequency = <12000000>;
> +		spi-tx-bus-width = <2>;
> +		spi-rx-bus-width = <2>;
> +		status = "okay";
> +	};
> +};
> +
> +// HOST BIOS Debug
> +&uart1 {
> +	status = "okay";
> +};
> +
> +&uart3 {
> +	status = "okay";
> +};
> +
> +&uart4 {
> +	status = "okay";
> +};
> +
> +// BMC Debug Console
> +&uart5 {
> +	status = "okay";
> +};
> +
> +&uart_routing {
> +	status = "okay";
> +};
> +
> +&uhci {
> +	status = "okay";
> +};
> +
> +&vhub {
> +	status = "okay";
> +	pinctrl-names = "default";

aspeed-g6.dtsi sets pinctrl-names to default already. Unnecessary...

Tan

-- 
Tan Siewert <tan.siewert@9elements.com>

