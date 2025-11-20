Return-Path: <linux-aspeed+bounces-2970-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E4CCFA44F
	for <linux-aspeed@archiver.kernel.org>; Thu, 20 Nov 2025 22:55:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dCDGR355Gz2yxl;
	Fri, 21 Nov 2025 09:55:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763616370;
	cv=none; b=Qd6L7BBkW4SY4hyUc4v7/+xm+fMOrlCoSOBirnHU70e/mt87f+fR4DtH4B/2qxCOFspmzsTZGCz7unOMvbsKDHB6x1Ut7P+TBoANi3QoNUH+u/WAVKkS8T76d0bUJTmBC0OezyznkFkv3c05Zs0Qmwge/LGrwzOh19felezk/swq2NkQWOFSTJomKihyDV1wAxUMX1JL6lSUgs5g7a36UVEprYX6keoR03wtciEPywCTyHCsoxZuj1b8ZiWRBKLAnUK1qrMeODHLfxmOJ2DqZUdm9JlOr5qJWRkwrhA6HnRmoKHnVIf8KOp8VBbsVsLWJIBBG0x7oxbxryiwYEJfuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763616370; c=relaxed/relaxed;
	bh=jrmpJ7r5olEuuHW8bES57a8T6LK6exu5hSOQkrAzRxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AzgntTVyYM1bZqTpnzIXd0SzQb0UxN0rGFxzX3+26LImrG9Jv1DZfERROtYWxcdUupngrMyP5pEKPTfRYZnLik6wPBP2PDCvYY3hgwSv3RS0BhszixZE7jaAvERauUxdPkB3Ytwgay981W1L/O/GEZ8BNaVRLx4T+SCwEuX1RK+ErR972dmMjrlJUxNHEmw3zpMyKocEL2Haq+xh+a64P5wGysdTAvKHCC4EO8KQ+DTChmbOCnk2mSq1q0+aolcvCyaltsiG0X2uskspJyZe/gn9eh092IEmjg0eRZL5OzPqaOrqeg7galJ8Ce3dBiPMZabP+WpfmqnNxlKh/hAA1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=PmV7lEZl; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=PmV7lEZl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dBmzN6mLrz2yG1
	for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Nov 2025 16:26:08 +1100 (AEDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-297e264528aso5541515ad.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Nov 2025 21:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763616367; x=1764221167; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jrmpJ7r5olEuuHW8bES57a8T6LK6exu5hSOQkrAzRxY=;
        b=PmV7lEZlauci2HH3nt0aEyFmxj0prc8j0osVj1TUEWz0wy9x1iJfi46Ci6nFu/Dr5b
         ZK0PyiWUvsQfBgI8LwQHPuW5X2Qc1zSSNEQjQGiN5pWSyS0xuxMYFbu8yZSH2R5YAEFV
         OLYUIH+9RX6ewz36p1t/G2/pbQMsHe/Jc2uqqNlf8uCPaF3AWwyI2otCWUaT4VqNfh58
         1AdBJQgH7iXY1yNgg6aGMjE2+vvzSysJAzD2I3t5VQv/XZ9XWw3GGeor3/oqoCThrIZQ
         N7p1XNc8tP0K0ihEqzlGOYGi4pc9wqBnDGguvulJmZ9K4eKPMJxQSqFjR7NBkvQpwLPg
         oY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763616367; x=1764221167;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jrmpJ7r5olEuuHW8bES57a8T6LK6exu5hSOQkrAzRxY=;
        b=m9TvzzQ5KjNywIgiHC6+5+Bm8DQauo1OVTRgdHSzgfrjxkcgDWOpsfhG48ruGW9ARA
         iZRR2gpiL0vtbwlTuE91/GC173O2aYEB1Y6nYENPeALQir/9b7taX0QSNnqs+nNFpep7
         OECMOJHRLlMAmrEzOJlOaP21IaiqZf5omPheHaKxEzH9P+fBEA84/YGa4XQsquYTNh/8
         ZmQxK1HAuz1eAbGzqFNdvQ8RjR49v75Fh0B9utK2yD4pePO4hVC2Y9wd9dFs+hrMhDtC
         yweG5blGUfsVTniDF7wrguJQzdzvJ8Fbxm9Znt5TQBHkVEY7JW13LFlxLWYoGH1Na6hE
         VymQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdfKekIwckIDOQsKgDod65DVRphdS9MbKLvKw2dyGXfk5F6d047HQPNfsNUdiqly7NmXZXYaBHz3oUmFM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyI9dGCF00UJ19Ec/7xbAuYfacLacmyQ+J43Hdf/xO/UZxEAhde
	IN2VDFAZnrglDeGkbxLpzqqHakRnhl7Mzbz5lyyWqI+FD36HKJeu4DYw
X-Gm-Gg: ASbGncvNktfNtyQgb6LBY6CD0DadFcvSLIWGX+wlWKQO4aOYd2rx+nez6sUud7iqkTt
	8MDAfyvimKvmSewomFtVVZLdhaIG2QatViuwCwEpBl3mncVn8xbhY6bma6x9LRYGKoTOHDeUfWW
	Be4UrTpEU3AaMzdVIm2RmmjI7SaA113Kuj8x4AMHFlfveC94jkaqx01LuggLeGiWAYl5DaXZRGL
	PXncJ7SfcjGYyBG8P67JzycRcdE1xXLyfMk+NqXfdAysRfcwdQKsPcsKwrEs14dhOVgiBQPElD3
	TbSauJXKTdsounN1/1cALIr9i/2fOXsNBSRXOPHYn9PUFEZrZCFNbK1y9K60LVnmwl6KPv4Jkyh
	YmBUqUFYN0YF/zROa2ncIDsuV+p9kSvCE3+E13G6oOJlCRbtzibPixmH2E7dXBbhQrpQ7aAN8or
	KFnUhzGj0kAhZrn7wqSPgrXjFvxv5LDF5GA9QQl844UcOsCCJ8NVlFLQP7LYbxeD593/iRGjiKX
	c0HJ6VDgHvvh6M0/DjxSgsEUNUPI2phK6cHlvwly/M46WjsICILzHUETPjJqKGVcnbse/ReLTg4
	AICKZjNIA24=
X-Google-Smtp-Source: AGHT+IE0C4Gi/8UKiKUiQ7+Veji85cevN0GQcvp62+0plkZpI6JLPQDYbGS70t9JxUT+e0asq9HnEg==
X-Received: by 2002:a17:903:2a84:b0:294:fb47:b623 with SMTP id d9443c01a7336-29b5b02e987mr23648385ad.11.1763616366824;
        Wed, 19 Nov 2025 21:26:06 -0800 (PST)
Received: from 2001-b400-e301-38bf-be0d-b72c-6bec-2812.emome-ip6.hinet.net (2001-b400-e301-38bf-be0d-b72c-6bec-2812.emome-ip6.hinet.net. [2001:b400:e301:38bf:be0d:b72c:6bec:2812])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3472692e5d3sm1221342a91.9.2025.11.19.21.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 21:26:06 -0800 (PST)
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Thu, 20 Nov 2025 13:25:58 +0800
Subject: [PATCH v2 1/4] ARM: dts: aspeed: yosemite5: Increase i2c4/i2c12
 bus speed to 400 kHz
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
Message-Id: <20251120-yv5_revise_dts-v2-1-4d7de701c5be@gmail.com>
References: <20251120-yv5_revise_dts-v2-0-4d7de701c5be@gmail.com>
In-Reply-To: <20251120-yv5_revise_dts-v2-0-4d7de701c5be@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Amithash Prasasd <amithash@meta.com>, Kevin Tung <Kevin.Tung@quantatw.com>, 
 Ken Chen <Ken.Chen@quantatw.com>, Leo Yang <Leo-Yang@quantatw.com>, 
 Kevin Tung <kevin.tung.openbmc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763616361; l=1020;
 i=kevin.tung.openbmc@gmail.com; s=20250924; h=from:subject:message-id;
 bh=V8hyqVc8AxjSIpi8Rf3ei8SCie7TL3OVm+o7PWaDSjI=;
 b=0bsl4Rx14cAtCjmaDk5pc8Kupx+kOZS/805VJ8qDzXtiYCPgERiNuvmWmSRspeQkoS+bmAwIv
 ia6LJNmRmjxAyG6ryOy5JCxImsZ4z3ABZNrKDM2pwquLgjAYog+BKoX
X-Developer-Key: i=kevin.tung.openbmc@gmail.com; a=ed25519;
 pk=PjAss0agA0hiuLfIBlA9j/qBmJaPCDP+jmQIUB6SE7g=

Configure i2c4 and i2c12 to operate at 400 kHz instead of 100 kHz.
This update aligns the bus settings with the hardware capabilities
and improves MCTP communication performance.

Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
index 2486981f3d6bd36f3fe780b21e834b85242f8aa9..7991e9360847532cff9aad4ad4ed57d4c30668a0 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
@@ -231,6 +231,7 @@ sbtsi@4c {
 &i2c4 {
 	multi-master;
 	mctp-controller;
+	clock-frequency = <400000>;
 	status = "okay";
 
 	mctp@10 {
@@ -782,6 +783,7 @@ adc@4b {
 &i2c12 {
 	multi-master;
 	mctp-controller;
+	clock-frequency = <400000>;
 	status = "okay";
 
 	mctp@10 {

-- 
2.51.2


