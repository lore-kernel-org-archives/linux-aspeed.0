Return-Path: <linux-aspeed+bounces-156-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E0ED75BA3
	for <linux-aspeed@archiver.kernel.org>; Thu, 21 Nov 2024 02:53:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xv2qR30GYz2ykC;
	Thu, 21 Nov 2024 13:53:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::32e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732157619;
	cv=none; b=dQyuYnZGtcXv2l/ZYR1fgqKSYW+dtfeho58QM3OIiUh/B3MudBvyA8wtVeN2ODyQNdkH7RAqNqJrsnEi1hTlBWyx5tU/hJSDNsgTopTfiNAkq9amaTulSibEzvJ0ff2y75iLQTiYncXfKaRi9DhqFrjx3PzFKQnVs88SwUJ5lFavySsl7S0LbyEw4JZEVYWzsZcwZbI/MleCUlG5mfKh2//6wdU00ZF7QFeGxf05n+IfI3JyK3hjZTvYDX3AH6h58fYQ1aoQvUv67Wo5qubtbGZNVQL6hRlRthHnqn++WwT9PuLoKThRIRuQrHT7qqH4dBYCqSi6uh/aifgs8OWGmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732157619; c=relaxed/relaxed;
	bh=qh0sbGLe3R9T6iLNooRlLszG+yIe2rtAwnz37rl7QI0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YGYs6Vc7XUqAHKSEf4TlesHz9dI3cmIbFCSJ4UV2iiy+EALHVySA0Q2XkOPotNQK/XGgnXYuu7zCnNAVtHRftv0jPFtmleDBF0FLargSNTQ//UJcaSS/JiT68J3rdke0mDNvUT3PrMnSLXl0h4z5ozMGq3b7sGF+7oa7TbbVZ5QcOet2A82QxDb+K8zeeLpsj/c05P45SB9yig2cwrEoJ4N+VfYRir1Rw47j1tjG16nJXqUT+3L7nUq4hsH/vAzUoECtQAd9RuoVtUm6Aie2KOK8NL6GqdcIiJjClGy8+k06TNHa2SJnG/1aq2p7S/yaY93Cx/FDDmYKclP6Z1Mr5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=QvBMfMCw; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=QvBMfMCw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xv2qQ2h52z2yD6
	for <linux-aspeed@lists.ozlabs.org>; Thu, 21 Nov 2024 13:53:38 +1100 (AEDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-7180d9d0dcbso157145a34.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 20 Nov 2024 18:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732157615; x=1732762415; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qh0sbGLe3R9T6iLNooRlLszG+yIe2rtAwnz37rl7QI0=;
        b=QvBMfMCwCjV9kh5R/GX94ENv6r4AM3hlXidTfYF01T54mXOtfIh8N8c8BF4N4/oQIR
         ck/stgcjS7ZAHCPogiswSwLGwrvgUiwWsGJQLYklsYc8uqA7R2X1M3QUbBuT/Ramzrf4
         dfgeSzlL1FZRDY7LB09FE5bJk6nktIRJmCJf7YneWbdOfUhH8xxiqjJ823BJVeT2NESz
         m+bKhsBW0XOyhpFvHi5pqOyY3LXfK2lQ+9H9wpFzEu19CnJiG0IFfKCD1/mzNLeZyUP7
         5uWwrJZFuKJDuxlDxZkuwGCxbmeMG2J8jlAsEnTDHQD3HFVcYr3+URqDtbeG9cNVPDRt
         jcxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732157615; x=1732762415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qh0sbGLe3R9T6iLNooRlLszG+yIe2rtAwnz37rl7QI0=;
        b=Qoz3DFUVCQOZvbEiVS1HHHZPb2zNzFzG4l//Cr+zRGf59oNk4DLlchcfsdLi+bgbeB
         IDCYdEr0oBLk96pXGovnyKfJUZjYUHxKGM9KSoSrN2lfrc0TH0fA41mmCDKa1KnILIz9
         MKjkE3YnnJ01Hh6e4howd7EWg5DxdNLu0FAy6xoJBv1e+W8mfTPArgoCeoII4dd8DQ07
         22E6VNgNXwwr1QZRBTJBlI6DjugZhhnnKvn2i0ZlKqnnvtdFtM43etBEdP71cPIiKQ0G
         FaK1z5s9pd9be96CTEV92zCi3MnDH966y+ig359gDXDIyJfByJr3BbXd+L2LUpvMLWLN
         HlEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXperq6CWEGLtxHH8Ddd6ntQ9U2QeIkbMK1jI/TqCAS4X4reWwhmpdZqTidBKfDGQpbC6j9OvLHNoLEWs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy6D1MJAGbsV5DJwDz7MwAnSto56SZZ9NmMafVlVWitcThEmmdS
	TgaZkQQBVTF7rXfw9zme4W1iCW4zgK68kyiS/keDNjsfWoq2JGsQzq6ZcQ==
X-Google-Smtp-Source: AGHT+IFA5UwjT3Bz4C/L6hFLi+1S8wr3VskYBXFhSYkypjXSN3g0a4vpxOgETQNmIQ+Tu9bYoG+89g==
X-Received: by 2002:a05:6830:441f:b0:718:6da0:72b with SMTP id 46e09a7af769-71ab3131e00mr5128365a34.7.1732157614993;
        Wed, 20 Nov 2024 18:53:34 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e309-7a4e-e779-1177-8427-3602.emome-ip6.hinet.net. [2001:b400:e309:7a4e:e779:1177:8427:3602])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbb64f5514sm285513a12.34.2024.11.20.18.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 18:53:34 -0800 (PST)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] ARM: dts: aspeed: Harma: Add retimer device
Date: Thu, 21 Nov 2024 10:53:19 +0800
Message-Id: <20241121025323.1403409-3-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241121025323.1403409-1-peteryin.openbmc@gmail.com>
References: <20241121025323.1403409-1-peteryin.openbmc@gmail.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add pt5161l device in i2c bus12 and bus21.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index ccb45ca840cd..fd85d5e34a55 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -299,6 +299,10 @@ imux21: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
+			retimer@24 {
+				compatible = "asteralabs,pt5161l";
+				reg = <0x24>;
+			};
 		};
 	};
 };
@@ -429,6 +433,10 @@ eeprom@52 {
 
 &i2c12 {
 	status = "okay";
+	retimer@24 {
+		compatible = "asteralabs,pt5161l";
+		reg = <0x24>;
+	};
 };
 
 &i2c13 {
-- 
2.25.1


