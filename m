Return-Path: <linux-aspeed+bounces-3130-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6FFD6406D
	for <linux-aspeed@archiver.kernel.org>; Wed, 17 Dec 2025 02:43:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dWJ5H3yS4z2yT0;
	Wed, 17 Dec 2025 13:43:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765939411;
	cv=none; b=nge+w/k4gpPE21tx5UtYHX8mttcmIydy830Vde71STBkrML+TAr/eKqndsoefimgpr76fQiYEUmJUxjxisDvJqmVAHUOD4R9TyMvm1uK+mjMYLFRdYF/E31ep1/gd2PNhYx5BQ+bJLsC5bO8P7WgOqh5bo1LOkgNSsTXvit4Z0hKkWFsqjJWQaIE5fHM7WM//8GfGg6nsG8WGk2F3r3tAPhzNNiF9IViavet+9Knhg8jn4kpaeB/ZzWfUdBNnd4+6eZAlriHDbP7HeCfLbMQJSzC0rL53bzweqy2Lxho/sBo+FWrmbeuncFvxqtGtpiF2ujzraNbc31vEYVzmjpKQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765939411; c=relaxed/relaxed;
	bh=tLv708T5nZKuD3uty/GoySjLydeaEBRlk4mAyPiG0Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGU0xC5gVxFmmQn/MApwZuQoMrY39Wjnz3xQDou4TrN2ksODDCA6JTWHbyI0vDh08Y9knLX84w7Ue7/NWNHFUuPcPEULhwXuOPIrPo0K0Xc4pRmeAiJ8r41h18OFujlCzgPSXA/OiPJJuCO1SOoPmufJcPrKhlUdB3TEQUs8fO1vo7XeOLKki+QhStIUCtO2lhI3mdF/jVxS7Ke4oR7AdV9e9R8GedClk/GPPMHeACu57JyT0DE0Lst4ymlRMNDi+KiGctizSPF1VhByadtN1QajcjKzVw/fbSOO59PQphigatMLYv1lgfv9iAei4Nb8LXnydvaRxjYYczWQrAk/gQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Y/pl8MHq; dkim-atps=neutral; spf=pass (client-ip=209.85.210.178; helo=mail-pf1-f178.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Y/pl8MHq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.210.178; helo=mail-pf1-f178.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dWJ5G6cl3z2ySj
	for <linux-aspeed@lists.ozlabs.org>; Wed, 17 Dec 2025 13:43:30 +1100 (AEDT)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7f1243792f2so3568190b3a.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 16 Dec 2025 18:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765939349; x=1766544149; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLv708T5nZKuD3uty/GoySjLydeaEBRlk4mAyPiG0Cc=;
        b=Y/pl8MHqJy3esZIqaTQyghNlJDlzGjM3I8tQRtLbE2v9Y5GBtL4AlaJEAK2/74qqWR
         BbJuozePM7tz/Sp7GIuO7KgylVzBWw4s0LlVrAVs1jNxNCFRrKVRDiHB6lFd+pC10iym
         PsYxwyINUoCo87S8g5utDjLDGls3YZHmu/NrTkjCUVLqqxrTAixiPXKoezlY/xYH08NP
         fCSgP9lrDlrDlLkWujWvJfTJkXY7/UduSK6FXet+02SW7PIjS6U32N5e21qRfna400lY
         kb+xxCvY3NP1uAYEnkhvHkg2P9atlnqt+6kpVm8OoTP6TG2CSy4KR5prbZWuLX3p5BVj
         LTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765939349; x=1766544149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tLv708T5nZKuD3uty/GoySjLydeaEBRlk4mAyPiG0Cc=;
        b=rnefvU7yFUtp0LRPAVCmlMbNI66d69dH2eQb+7vvwUpedn+pYRGU9S4ePZCoLH00he
         azztva6zvrvkL+kDdgiUf9zFjhrdAGqbdh7DbL3uJtKby52UyfPACCAAOLfSEbS7tIWw
         j5UmXTcTkATWP9jknZwgCpj9kT0lZfmyaBI653AJUSlbVlyeECZQz28Kl+FX49hlFAtY
         bptee+nqbrH0lPx3hPMBh+6cdsJPvv4Q3Qt8Fsn9UqnUPVJSQruFvaxkwhozWSr+Vq5h
         zdtMIWzJtf+yyfnebbvto/BCl5lc7bUR9p7g/IlT6i0zaZIZ/mNVkwTVdhfc9ce4RGAF
         O6EA==
X-Forwarded-Encrypted: i=1; AJvYcCU3lPDy/rbHcBbg6ek8p/QTbsaLXY9R9bpGG5YV2Fw/VQqt87gihw/O11bRgbVemEMjuUP3td/gBJfxGSo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzf3ApZIYYgT/EaXnQmWXSZAHVmlHS4GBZ+hcLpYQth5Yw3z8s2
	/0U8NV/Vc4KJfnwr8RHCzCKfvfWZxU5WA4A6D1/5aJqUlSBoKjcgPXR6
X-Gm-Gg: AY/fxX5NR+Z1KwzucXi0ow8plVaAb5zQjFmAbd1pRbR+G3M4+KYg9tgPW4Kce3iQUuz
	PRO1gPRTaNShgk92EfOYatHJi1V8HRKcSQOLFZIShjp7s5RSm+lxLwIC22NvGfzOYB3uwA7uw6J
	DSQGb0/v4aoLhMslQ80yrZf3H0+fUzXrTFfQ6wgB6fnmD5rvRVF8oVwcMMhQQyp8q3fVOHSXwXs
	BrU5dXjMhAfT1UTmlzb3MroNaSDkWsTbBIXscszAYbtqWd8YwQ0eHdIjtVCZWaOqfgecVjgIxMf
	HFqv4y2KCUnp+6H3zyMUSeQzvU2vEYlBBjPlkrVpHRMU8BL5nzY+evs5ujP3RkMDlkBUs214izv
	RNf2gGATMo8+9hcfqO0LrEthCu1Vw4UTTxJ+XnxM0JE/OGaCwN0+d/tLKmT8D3Gk289Vvr/etx5
	y4jYekU6zZbQlBiLaA8/qG/r7/JbxO5JmmBo6xCgUtCG8oAnqyQp/7JA58N0jxKeWpTsbtyvifx
	KZS+C/UdaDKz2PUki68vuPYOg==
X-Google-Smtp-Source: AGHT+IF8EmsK24fsPEtUrS3MeJEwiNSX9jxwUKItV8WqJ74LAe6nBQy+G+21B3SBe4yksRo/wu40Kg==
X-Received: by 2002:a05:6a00:4c97:b0:7a4:f552:b522 with SMTP id d2e1a72fcca58-7f667a2ba18mr15648248b3a.27.1765939349129;
        Tue, 16 Dec 2025 18:42:29 -0800 (PST)
Received: from cosmo-ubuntu-2404.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fcb8c29738sm941342b3a.17.2025.12.16.18.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 18:42:28 -0800 (PST)
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
Subject: [PATCH v2 5/5] ARM: dts: aspeed: bletchley: Fix ADC vref property names
Date: Wed, 17 Dec 2025 10:39:38 +0800
Message-ID: <20251217023938.445721-6-chou.cosmo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217023938.445721-1-chou.cosmo@gmail.com>
References: <20251217023938.445721-1-chou.cosmo@gmail.com>
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

Replace non-functional 'vref' with 'aspeed,int-vref-microvolt'
using the default 2.5V that the driver was already applying.

Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
index 123e2d1891f6..7c27bf6bb51d 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
@@ -1032,7 +1032,7 @@ &gpio0 {
 };
 
 &adc0 {
-	vref = <1800>;
+	aspeed,int-vref-microvolt = <2500000>;
 	status = "okay";
 
 	pinctrl-names = "default";
@@ -1043,7 +1043,7 @@ &pinctrl_adc4_default &pinctrl_adc5_default
 };
 
 &adc1 {
-	vref = <2500>;
+	aspeed,int-vref-microvolt = <2500000>;
 	status = "okay";
 
 	pinctrl-names = "default";
-- 
2.43.0


