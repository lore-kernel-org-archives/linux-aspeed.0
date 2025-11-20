Return-Path: <linux-aspeed+bounces-2969-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE25BCFA450
	for <linux-aspeed@archiver.kernel.org>; Thu, 20 Nov 2025 22:55:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dCDGN1qZ6z2yvk;
	Fri, 21 Nov 2025 09:55:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763616372;
	cv=none; b=YTWbzs1DTnlt+ICvsKpWgiIQBqfzHt6+tyg8Q88G12vkAClym2n4U7zgDaYthDEQ760woYD8TLtDyh2JoZ5sq82v0rWBiiNXIUPphPdI6rryD43zekMsRrS5nBKBb8AgKnAlDYGzL0OO3+HsKF8SXLDuilIW5Y958K4rntPHWA2m0up93SvO+CSq4p2ans5LlzSKTtITwxEo31LJkXb0vnlRjcaoa26vuJeul+4+m0imzUQCbiUtUWv2+RxrMrEPw9IKnHqEBzZpvDahsW6OCiBhOwzRdcOEyLnBeUE74XWiqmCFM6bhZ0xSbAx/8LzfaJsaVWdrEDlflE9AhvAeRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763616372; c=relaxed/relaxed;
	bh=GU/h/mkFSU1P3uYOGjiw2k7fKpuyOTI5NTYh7ZnlqF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FmFhxKGnLMLIsK+UP40VOp5e85O72INcfmCGFH13wqZN8UIsfgm/a9+ly0j6gzdZMT0hdZHqS9OTDHEL0r9xDZPvf3bVZ5JXw2ej6Oq5+J/4Mue/nl3KL2eDVLLpOS0gX/wmSMvjEJvWpqcqUB1dw7DCDpazpUPN8qxDgHGEU5HtmNScjcoce1BU0yxznZa0K+Daw+RgdUYKDgy9K7eNFJsIRpGOfnuZhgDzzBqWUe95s/hgSNgImz24VlPeyuCbWLHNl3Ang4eDviTmJF8AKlsio+79cGY/qQTeBc0fL/Z30PIv+EgjvekRVHd5NzBjX/LDniMbUMAyHWjVYL+2YA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=epV6S4XE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=epV6S4XE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dBmzR6tt5z2yG1
	for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Nov 2025 16:26:11 +1100 (AEDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-34372216275so435350a91.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Nov 2025 21:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763616370; x=1764221170; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GU/h/mkFSU1P3uYOGjiw2k7fKpuyOTI5NTYh7ZnlqF4=;
        b=epV6S4XEu/u7KCzpg1FZVoLx13mmXKtywXI6nsK3JT0Qys5D+lGbK0BSCY1vRfHX15
         dc9qe1hQ/3uMnb3lW3vXgaxPjrvaEfBMXcQjKGsJx6cjht4E8JD/UtV2TtNGPPMnOD2Q
         6X2lLZCL0Jys4AMNZjHJVkSi4UQpl8uo7TFjzhros3Kc1tHMS1d9r0swIMZRtLJHOvhH
         +DF8dG8QYN8lXvvIOxNVODwQEXLPjDNm3ttZqUC4rl3AfbZlP+W+0qg5g9fitx3jLMjI
         CQB7ONwMWCQR3rLGhaDWDJcSh7WDQn2tJCUinASOrq4nXgma+OHA+5SGUGPo4ZX4q1gq
         ikcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763616370; x=1764221170;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GU/h/mkFSU1P3uYOGjiw2k7fKpuyOTI5NTYh7ZnlqF4=;
        b=Ph2J8GwupkJqRQBCPXzjXP1lQPczBdbvnQnZzpeyopDMb3hXerrfIKkUbU5atJ8Lkv
         YxLd/QAUyHCMg/LzbaNh1GRAxhrYXcnrX7datm8YIE7ZgDhEARngJFXkJQyr3nuGZV3y
         MNi+nkMccKiopq3spsHM4g0puhckhK+fSflFH1Rle5OpBE8fgQVp5nLkKwa/S7iHklib
         65KsHx352XCphZBSaacz32soHZwQ4yLkmFVIYLkiZSudlu3oK7xjLAQ043Y17PKFMU0s
         9p+LPxEJhMW26mkd8FXbHQnoma59Io1gprxlq63HtnBPXn0yOnkW9UaJ0aKUqxkbazrv
         p6sg==
X-Forwarded-Encrypted: i=1; AJvYcCV7fvWl33w9A60+o/IlumF6/3IYVZQjaYi5PNriEMsI5kbPqZ6WbP3SSFFA8RIQ9TKzDdb2ysK7QEfnOyA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwWsSuFrfy5vDSB6sjgbJs1mdw1XEgEdGIUM5+XdFBPpdk+lSiN
	WnsgGUB7KN6i9khORT4jA5mp/OpVfAVlVOOfvrRWeawTihlTyI2OqvjM
X-Gm-Gg: ASbGncuDbwd2bFJHuuoxmbCRvLAkJSuD8zENbMVK+0RsY2al9j8fuKAuyWEwoYcUXzW
	u+0Zbf0+nn3XNgMkD8qdRv7VuGpsPp/NBERUMUJI0xXBhXHGuebMiRBKQCANMhwWdmV7S6D8/c2
	XgHlWw/zEGpdUi+dR4hUeJnED284NMy9Vccw58kkmpWRKzs7qkN9t6tp3Q4m8YEchSmqV8TOQDY
	/e2LXcyCRYH0wluau0l59qvO1FR8rIYv+g5gckGJfj0AjCstK7nOzmSp9ju2D27yDl99g7Gp++q
	enRYusNb4h6eOCuAtbtdCCA9U2TmvwIB3wZqTScqWHXNIQ87die5nY5cHAIgpU/xQTJe2bfwGC6
	p9p6PDaBBbQJ20/UYuj9t16GIjYQ1UdD6UpBM3QePwa6A65RlpwISu2HIFhsZeV4sTWU8OW3+Xh
	s0K3ch7cArc6vWLjnv5P+I/fZRnP0Ky7UQ4ac+DQbMtCw7laUpM3N0sAEfzUUHJI96REe6CY+So
	f8JrLq+ySX8BWlmxLOsLVtR10hVPYdfHzhUrRSPyTHh+dck66f3R5hm0sE5K3GpdIcTDxJezXxL
	gtMbeqzN7qe65XmNkJVDDg==
X-Google-Smtp-Source: AGHT+IH1kC4FzZhZJC7qjzvkCN9yK8lkB75RjjTIxK4P6hUplCLnQeTxkuiC3gLGbNI+oIn9tu1MVw==
X-Received: by 2002:a17:90b:56cf:b0:32e:389b:8762 with SMTP id 98e67ed59e1d1-3472a60ffbfmr998453a91.0.1763616369935;
        Wed, 19 Nov 2025 21:26:09 -0800 (PST)
Received: from 2001-b400-e301-38bf-be0d-b72c-6bec-2812.emome-ip6.hinet.net (2001-b400-e301-38bf-be0d-b72c-6bec-2812.emome-ip6.hinet.net. [2001:b400:e301:38bf:be0d:b72c:6bec:2812])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3472692e5d3sm1221342a91.9.2025.11.19.21.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 21:26:09 -0800 (PST)
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Thu, 20 Nov 2025 13:25:59 +0800
Subject: [PATCH v2 2/4] ARM: dts: aspeed: yosemite5: Update sensor
 configuration
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
Message-Id: <20251120-yv5_revise_dts-v2-2-4d7de701c5be@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763616361; l=1118;
 i=kevin.tung.openbmc@gmail.com; s=20250924; h=from:subject:message-id;
 bh=040YJWLGr4Ks08VhoS2kkw/5EcGAtC35AnEYoaywOPs=;
 b=hSIrVRC/ywFomV3U56i0mrilyeENlg6RI8jm5+PWTkra48id9dVtyFQXO0xS8uIlRo9Ww5heq
 ye79i3P0uAhAfyYmcI0pBcQJraUqv9/SKq8pIZWp+zrYY4B/M3rWicy
X-Developer-Key: i=kevin.tung.openbmc@gmail.com; a=ed25519;
 pk=PjAss0agA0hiuLfIBlA9j/qBmJaPCDP+jmQIUB6SE7g=

Remove sensors 10-0040 and 10-0045 to align with the latest
hardware design changes.

Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
index 7991e9360847532cff9aad4ad4ed57d4c30668a0..45b8ac2e8c65a4f672e64571631b7f6944f26213 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
@@ -674,20 +674,6 @@ gpio-expander@22 {
 			"PWRGD_P3V3_AUX","ALERT_TEMP";
 	};
 
-	power-sensor@40 {
-		compatible = "ti,ina233";
-		reg = <0x40>;
-		shunt-resistor = <2000>;
-		ti,maximum-expected-current-microamp = <32768000>;
-	};
-
-	power-sensor@45 {
-		compatible = "ti,ina233";
-		reg = <0x45>;
-		shunt-resistor = <2000>;
-		ti,maximum-expected-current-microamp = <32768000>;
-	};
-
 	adc@48 {
 		compatible = "ti,ads7830";
 		reg = <0x48>;

-- 
2.51.2


