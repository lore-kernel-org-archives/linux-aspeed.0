Return-Path: <linux-aspeed+bounces-4471-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9247C44508
	for <linux-aspeed@archiver.kernel.org>; Tue, 14 Jul 2026 12:08:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzykh1kH7z2yMn;
	Tue, 14 Jul 2026 22:08:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::630"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784030908;
	cv=none; b=JHwsEaLC+WVugo82MjBQLDHtVva3rL9o5IkcqOqAbU2qrLzlU22n+a6HSjJ2dQWRwIt6HBiBXU5O/esQPQU/G0E1g3Y7nDzWTujyqmzRdVFYE2+4nCXi4YDQmOTbV2YELv+gtcGZorKL1Yj0MYM164HQqW4cubut9h9uKgb0gVh8PIk82LjT//Si9k66A6kzPjsxj3/GucsI4utLt9err6rVlPQrReRg0mxCJlmsVjXq3yeOW7x31g+NgthPU9bqdJMHwsGQMVadf5HwYnXm0dWNdxPBnhBLJj06xEqXfc8aztjrGQy0iGfzsQakXg4bgKRSwnKY6A0V13CnOTyOAg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784030908; c=relaxed/relaxed;
	bh=7746hlY1VAGyI9teBFqCgeCZQpUtScgAKDRj8HL1cDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RF5r20F+56q7o2VOWiELJ8ikeoUExhqpSE2KW3MOXkl+wSUwPEGEaG1oR1ClAv52BMUDSVvYfvM3FeJ7tkR8fz6wu648PBSs8VQYGg0Lmt/qz7mZvpS2ZhtXvWlgbtCZPG9Y+/GXj2/OXHVk4xAwMOzJ34jRHPDua/nTfnGfPBEe7JzcmihM40eskoyDpkR2G0HOwU2Fv/18bnLDmY9ubSEua3rjaaTGMcj8A0RtvMRx/sGam2LKGUZ105vViyyV7RCCzxX6XEdX3VLE51ardeI2BMB4ZFv3HsoRH5evyiz/9WW7BlE0HFpdoVcuW8PVKgFuX/PbS+FsvZnZAc5zFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MQfF5rSY; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MQfF5rSY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzykg3dczz2xqn
	for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Jul 2026 22:08:27 +1000 (AEST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2ceab75934dso33301135ad.2
        for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Jul 2026 05:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784030905; x=1784635705; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7746hlY1VAGyI9teBFqCgeCZQpUtScgAKDRj8HL1cDA=;
        b=MQfF5rSY/xKQhVFOPbqHb5C7PNbZA0LC2Wii3oijaanTWILSwWR1VUXsu/psGqr82w
         5m3QCalsTOkDX7q8igQnm94H4olY8Tv3IpPxq8CaNcA4geC5Z32sz7wPffkCrj02oWZu
         sY0toeKQJ+4zV1NyGXsn2I3wN1K5fCOAgdy6wiKNf/HkVjmaryKBiAl1moIV1oJrwsMW
         tSsHcI/sgL4kEoxp9IwFmNkVoswChsY/HfWTXTlfr/ienjjt6JHJ6shH5V/LCJB5Aq7h
         276vGge5yxJFhLHxO1OiKrZzSUdMq2NhBDG8H1r1KdYpOscFGKUwM6KBnwA15nlxuIuC
         vpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784030905; x=1784635705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7746hlY1VAGyI9teBFqCgeCZQpUtScgAKDRj8HL1cDA=;
        b=gVxeU+/JumnMN3/JlyskZ7fRH4BfkL1HBOoFjzse5nAq4NUOVctZFHaNy08jwGoAst
         jcBBg4t+DT7OvdwP6s8CXOmsKRVDCA0rrWI6p6whkbp1jCTTCsa5gFEajiCEvG6Wn+cd
         YxTR/BnN1TtYU2rbHozcp8fPOxY+qDMpQcQIojXae/eHJwGckaMywYRkCU5VkqdedBWJ
         QGqYpZdLSYXNVe5ewDGDVim+j5SBtBT/9vR2hCj/mkjwWkFgff7BWEPPUyhrYlI/aN5m
         yTJcNjPZl4N+C1O8m7AuNL/maRki8eNxv8aEeFvtKZwUMpBrx1TTKtG9c6nF61oCJz2H
         UAzg==
X-Forwarded-Encrypted: i=1; AHgh+RqXveVsOywV8a3Elg/QJ3laxVKesEbhaYL6Qw8TskRrJ27a70gpr9QR829qsk+hsvOmOMcu3a9vEFX9jSc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzwtoI6Rd8WgrRUbec9wUcQGaHxJH3OS5m9qqCxByJLf4KCZC3F
	CKuwtnp8vGq6x9/9XCIIOQ8AIVpRh3pPS73mNXQypcmO35+NYLbUQl0t
X-Gm-Gg: AfdE7ckOw6qIgO2Gyqpsl18KVxCIic+MY9WUDaUB+U7N1Gj5rf+Cpi5RZN5c/v5EFFJ
	Ih5PgkmUJsmab0DtaYepfCCjmd2ppVo819YRWXRd9kulj805hERYiW3MFHaXkGAPWDVuVcVwN6Q
	vRabumOQ2hB6HItR/Jit6ilNtvXLWMtTbDTuR3x8EwGxQo/fRGh+5t7NLAFRhttiTDj15iVuAb6
	SyyeYsRVQgtwoZrnTT+BBakoQ1JFfZ3iLQ83aPNn3RdPmivj3UzgvaGpZT7EvSmp3A+jHtDiQ0Q
	yPdbzhHFYtUF+bBZVk8/jrkhkRYF/qjumbwwtNQ0RKCt9V62qAH7/wUvmOaVrgIInUaXexGVv/T
	bCxqz22+bMyugYI/jASSlJl1Hirm7/xvBWuY+hYhmP+0S07nDbKIceecDEKaydMHplhDsbzWiX3
	U3hgfoBeVTvG3GGD1QTknOvzeK+hZ8WG7NEhwfSLBfIT6/E92d2KE0AByfqeo=
X-Received: by 2002:a17:90b:1f8e:b0:38d:eb10:6f01 with SMTP id 98e67ed59e1d1-38deb106f50mr8733002a91.4.1784030904950;
        Tue, 14 Jul 2026 05:08:24 -0700 (PDT)
Received: from cosmo-ubuntu-2404.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e172dc530sm1384425a91.8.2026.07.14.05.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 05:08:24 -0700 (PDT)
From: Cosmo Chou <chou.cosmo@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	cosmo.chou@quantatw.com,
	Cosmo Chou <chou.cosmo@gmail.com>
Subject: [PATCH 1/2] ARM: dts: aspeed: bletchley: Add second source ISL1208 RTC
Date: Tue, 14 Jul 2026 20:08:15 +0800
Message-ID: <20260714120816.1504058-2-chou.cosmo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714120816.1504058-1-chou.cosmo@gmail.com>
References: <20260714120816.1504058-1-chou.cosmo@gmail.com>
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

Add alternative ISL1208 RTC at address 0x6f to support boards populated
with the ISL1208 instead of the primary PCF85263 at 0x51.

Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
index d1a04b63d..a966be69f 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
@@ -865,6 +865,11 @@ eeprom@56 {
 		reg = <0x56>;
 	};
 
+	rtc@6f {
+		compatible = "isil,isl1208";
+		reg = <0x6f>;
+	};
+
 	rtc@51 {
 		/* in-chip rtc disabled, use external rtc (battery-backed) */
 		compatible = "nxp,pcf85263";
-- 
2.53.0


