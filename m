Return-Path: <linux-aspeed+bounces-4752-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9863C5DF7D
	for <linux-aspeed@archiver.kernel.org>; Tue, 18 Aug 2026 10:32:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPQx71xKRz2yHT;
	Tue, 18 Aug 2026 20:31:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787049115;
	cv=none; b=Y0mv8WjNJbL8gfMl4Ji8CfA5I2rJhEWGTMVGWhFIoqMFEELYOiT6fxwkK/W3hmy+Tp/GXLK0amcJTPuTBkBExPA/b9zNs8Z4dtsYESEsO/PMQPHm7AinN9TnCC61BcgkTvXswXzMN5EP4bG13OVXa7N5HO8I+WIUsDd6zx67Bs9YnX/oRtZo15tQYU6y3zMw4u9sDAnDyp03sx7cui2xq3IAx8jiOZupxFxf53SXrPy3PJSHfs31niT/wkVLzeuPzEpr0gKvEkGOHMMw68/OYo2PooV5/YCyhVXNJn44FgcLXpNeZY0irTowWS3G8xsmOkBcKZNo1mP79tb55ueqLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787049115; c=relaxed/relaxed;
	bh=0US0ozN7L3SAjOKyepRf84tawF861oB4+zMdDmmleEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NaeSkGOcwvQRlMthREByAO8aS1tc/ImMdR+bc4GgFBmpAf1vq3bIiu9RKY/+mVE/cXF9x9i0T98zqZgVBLAaU55r4o4Y0tCydu7sZLhf7B/QVYMewAVc7JroTqmIu9Ht5evGRM3B8If/7OSsZIxy2ELmk9ug/Mj3gqe2ngKojRxrFo5DqxWsvObtTKEe8Lq5cAw378CwrT9/EDiilFw0OYkE2i7MwONHM+spRq+AxnI7T5zoxkYquAPLiJT0s5rGI8AayNV11nwdRoWN/9oGySn/SgNIySqNWEDUBWNE7ynmaQs8TIhRXNUYR7F9CALTRk4Yy6+jHz7AIDFATdnstw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=U3bdGFpK; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=U3bdGFpK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hPQx62VlYz2yFW
	for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Aug 2026 20:31:54 +1000 (AEST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-499a4d1d7f1so3752665e9.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Aug 2026 03:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1787049111; x=1787653911; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0US0ozN7L3SAjOKyepRf84tawF861oB4+zMdDmmleEw=;
        b=U3bdGFpKPDBO2zd5XvAAGupARXL6oq9f1Irct41XBg/VyKUMgOx8ZdSoV3ESZ8wUA/
         o8Df1nw5NFiXtv5RiepuWz8DGcSxEzZGCUwOPuVok5SThSNdL0KpW/3S1PrPcphepNVC
         Ds1ppS3z6l8GGGh/wvrbYjrrtOqCk1wcUy8pXWEyPnj4ZtVZBt0ohfTl3hfc4C451Uuk
         LRv6zc9F4aKTe3P+27ankztxkMTpQEqeHovIkcd4wSK45M8gILakvAPsWPtzv7zr6DVj
         cZxydG9feJpEsTD/cVAaMZ5MOktI2pVCbZeVoyfr2CPsvF4sOb18riJkFxR7qlhr+os0
         6bZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787049111; x=1787653911;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0US0ozN7L3SAjOKyepRf84tawF861oB4+zMdDmmleEw=;
        b=f0tXft8PX7sVpcdzM2h2GsVK3XAnqii7sVXWEDsjLV9jxjnZDIprd8gnM5fsef0I0J
         9lY3UOKcdlVdEdQNuhIQ6Vc8ZWAGt3klNNXZxC6gOfCjUKGZ/GwfQUnIYJ8u1bAxK8Tg
         EX8C/+Kze6ic1ycZ2i/gE+SWVwDP048CY4b2bT0f5bKymLnZyf5xBh6X9gNvJUR2sUUP
         EAQO8zeUOBodGl+f++iHJ0BTk+ukVVkpU7VF1CeKvio6MHQb+TfS6JaeZZnCSBx8BitD
         j5mFl1PBoXbhE0X7PU9dooDhkYEk0cHy4W/H2Im5EXUNKRaFP61H15R+MchsMeXWQ+fi
         dwyw==
X-Forwarded-Encrypted: i=1; AHgh+RrpXWG8VmCpWbQJy5wW0fzUHzCFR7VJw3rP2S4Z/Dz36ZKYf1k1GXqJmMqD4SK0nWTJVjG7zodZ59Jnd0s=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YygMC6R0TjMkWP/jIzBqKnWaqCaqC7KFohZaXeXy/sYA2k8CGE9
	AbuTqbmd2cF1orPCgMOCTbedVgQKXhaNvfFaNg3x7qmX8FCjvxq57XSx09BRPLg3S5Y=
X-Gm-Gg: AR+sD10/kHTUXI0BJxkJZubm67U+QhHFbPzt5x3ftSlRIZFC460j1blWKu1Ef4i5xWq
	1XjBMI04GOIyfAklwdz4xqMoqtr3JXhv71mxaWdXQPDasNsCrX189uRy0vMsP0m/OtR+BhfvK/U
	Y9xlbFlhET2vC232HLSl5zIthkPqJOlQSs7pPcL+iStvvC82betYnJKMi2YLY4VK/lGSZyqeTIR
	K+et6K56gMWz8rpY4qjRmEQ5vkZhTO9CcYigjiKmxYWt/zQVVrk3pxInyKHeH1Lepdih/X/eWuZ
	h5dbqwf9e49Ga7VdFSs8C0JxPNJ8FZ42Ydl2PhzgQbIKPI81QfNHWHSgMa9HyzjywzHYU7w9u3r
	encmfM57BZCAPi4XbFSB2/AwsL+1jbcqsQKYOsBp3YI11SC6vKKSKl2W6gSI2SpJ3dfqdLfWQAu
	5CGEHqCtaVcr41HkWz57DjwW39dRFsLnfOuwANAFNslm6hPzwLcsWKbrr2eA9voK3rNjZuKV0oA
	lKdzlbQ+p+vOhOmC8XX5/qxgX+KWLROVGBXrvxcK77Umyoyz7GK9qL8ZI7u
X-Received: by 2002:a05:600c:1d27:b0:493:e451:a9e1 with SMTP id 5b1f17b1804b1-4999fae4e89mr107830385e9.2.1787049110979;
        Tue, 18 Aug 2026 03:31:50 -0700 (PDT)
Received: from [127.0.0.2] ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499960988c6sm246025575e9.0.2026.08.18.03.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 03:31:50 -0700 (PDT)
From: =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Tue, 18 Aug 2026 10:29:18 +0000
Subject: [PATCH v6 5/6] ARM: dts: aspeed: g6: Change vuart compatible
 string for ast2600
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
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-aspeed-driver-v6-v6-5-fd7cc0b338ea@9elements.com>
References: <20260818-aspeed-driver-v6-v6-0-fd7cc0b338ea@9elements.com>
In-Reply-To: <20260818-aspeed-driver-v6-v6-0-fd7cc0b338ea@9elements.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, 
 devicetree@vger.kernel.org, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Gr=C3=A9goire_Layet?= <git@gregoirelayet.com>, 
 Tan Siewert <tan.siewert@9elements.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 mfd@lists.linux.dev, andrew@lunn.ch, jacky_chou@aspeedtech.com, 
 yh_chung@aspeedtech.com, ninad@linux.ibm.com, anirudhsriniv@gmail.com, 
 =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
X-Mailer: b4 0.15.2

Use the ast2600 compatible string.
Make it more precise and enable specific ast2600 properties.
Still use the ast2500 compatible string as a fallback.

Reviewed-by: Tan Siewert <tan.siewert@9elements.com>
Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index edf4b74f5aba..c952e2075b4c 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -707,7 +707,7 @@ emmc: sdhci@1e750100 {
 			};
 
 			vuart1: serial@1e787000 {
-				compatible = "aspeed,ast2500-vuart";
+				compatible = "aspeed,ast2600-vuart", "aspeed,ast2500-vuart";
 				reg = <0x1e787000 0x40>;
 				reg-shift = <2>;
 				interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
@@ -717,7 +717,7 @@ vuart1: serial@1e787000 {
 			};
 
 			vuart3: serial@1e787800 {
-				compatible = "aspeed,ast2500-vuart";
+				compatible = "aspeed,ast2600-vuart", "aspeed,ast2500-vuart";
 				reg = <0x1e787800 0x40>;
 				reg-shift = <2>;
 				interrupts = <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
@@ -727,7 +727,7 @@ vuart3: serial@1e787800 {
 			};
 
 			vuart2: serial@1e788000 {
-				compatible = "aspeed,ast2500-vuart";
+				compatible = "aspeed,ast2600-vuart", "aspeed,ast2500-vuart";
 				reg = <0x1e788000 0x40>;
 				reg-shift = <2>;
 				interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
@@ -737,7 +737,7 @@ vuart2: serial@1e788000 {
 			};
 
 			vuart4: serial@1e788800 {
-				compatible = "aspeed,ast2500-vuart";
+				compatible = "aspeed,ast2600-vuart", "aspeed,ast2500-vuart";
 				reg = <0x1e788800 0x40>;
 				reg-shift = <2>;
 				interrupts = <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>;

-- 
2.54.0


