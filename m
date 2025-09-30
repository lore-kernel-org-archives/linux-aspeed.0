Return-Path: <linux-aspeed+bounces-2356-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C69FCAC5B8
	for <linux-aspeed@archiver.kernel.org>; Wed,  1 Oct 2025 01:30:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cby6X3Wqpz2yx8;
	Wed,  1 Oct 2025 11:30:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759200580;
	cv=none; b=bKOiGqwA5kQSNW3cGfP0WUOuvPesJ8U1+4FBs7Zm4cuNnIcCiT3QCp5wDEGzs3A4uT8dAj3VyLsW0gZ0yG1d2miIYMY4ejR2qXghzW6LogoN6JrC9/r+lFS1P0x67bjf93u8S9UxogdjVMCnjUmbBVbfd2hTI32Ou8lw0Akk7w8+FgKEd924pNgKFrAiifYue135YNcgfTkQ+pZhIcqxk7EzJa1h7E42M7jKccMy97pU/e1Bmks7hDWvVNXw0YPMbR8yE3okRizfUgJoIe47me41eFg0CUl5jWlb18kfiHbcxuF92RS0mIfTFvTh2sETp4K1VEZZjEzrqxATADqm2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759200580; c=relaxed/relaxed;
	bh=wq8AM5fpXK6eEk4la14RAF7oSZLrkv9gGWRw1LyBjWA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EoQ9oVKQ3eoq1HeHCXAoVUq/OAOADYsmVYiYDG1Y7WzOkYDAis8Rg18GkqilJ8lifT4/PcEOwnWtV+CX6RR4wbXzHsuvXk2GY07FJau3q1vL43acOYnKGWhA6Y0KO+c33M9nNAb8lsMRFKh8p03r6hLKx6b8Ga9aURTS0hw0rBmJ0w2cJuHIwx5QJYd51TDtDZQrjV6EdHywQsjNWEzTvZ68XHZ0u902ERjbaeEPTesyZclZMZJsTcIdGXcAmROmJYqArbgTD7GmrTMJHE4kDMgrhswimJW1x5C20uhpidWYqk2YiduydmMFqhVm5TZSUQvQxbBB2zmlWYXSPaeXHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=nFEZwtm8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=nFEZwtm8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cbMwM5GNYz2ywv
	for <linux-aspeed@lists.ozlabs.org>; Tue, 30 Sep 2025 12:49:38 +1000 (AEST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-782a77b5ec7so1929778b3a.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 29 Sep 2025 19:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759200576; x=1759805376; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wq8AM5fpXK6eEk4la14RAF7oSZLrkv9gGWRw1LyBjWA=;
        b=nFEZwtm8h9vSQf1Aus2Do41e9hxmPI81ifIp+pyrafOODtAI5bfUk0ySLNtn6PBqME
         1XDTHDiuCV96MkD7XSuB7zffv/D5ZkeQBng7v5ZZuwlZGMVbZNT55t2Ykx0Ncs5DyWHA
         8yLlcMNoS2x+b1N9lWnMGasFAHb6heOeAP9p0ZBgD2rgS2O4nIJJT6TZuaU9baY9gDxm
         XAcT2HrjC3KVH2UvjlHbGwUsKW1r7OySL5n70znEimpNI57qu2JlQ39/ANtuD7UATfyv
         vuayZ2qjzkM5Ftrzjcbj1TNfAsN0Fw7Foeu3pHzSNq3ahtPUVmfERp4naHddRQNXHCWk
         qviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759200576; x=1759805376;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wq8AM5fpXK6eEk4la14RAF7oSZLrkv9gGWRw1LyBjWA=;
        b=wP6lOLpc6Xbna+6H0C8a2clVvN9Gy/PiCtVcOseTQsnJIBOmAzEmGrfpUGNZv6Q47+
         7gshkLruMAGhVylJobD+yJLqDDMNFz7Wtc0R0X2HtiSgiWIhnk770Cd/V8dGcDohsouG
         arJDssO9EVpfAroC/IPyOe1LYqX0kJIvvkNLJfObeXpyKVOP1yTVeBGdGITN3mTvnafx
         hCpfKUQMpa/2cRbGoEYDSG9s+CFOIAlV8vmKRO7y9tffznkmYy9SWQiBTvi8bty1+5Uv
         lduSuRLijXzUoTew6pGeEppdMPznHa5r907J2NyIBC/DeWjdhhzxBwL8uHiT9rZuC9YN
         gObA==
X-Forwarded-Encrypted: i=1; AJvYcCVKrbz/I7lnAzZqIUJhmu93uWVynJjZ7PrrojG8KTvte7ellTwTTnfcLJg+Zs68++GwRqPmLYaDVS6zeV0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YymKL+YXXA1vyO4Ubheo11bPTWqIOj6HlnHzurV3ejfj/6+I1Ny
	PecgqAtUm92u2Jajf2dU72odGlJ6qpT5Bn/Lo8ygcWx9kVbIHcLz/ei/
X-Gm-Gg: ASbGncs8jwik1/3CuVe5C6Eo3vicLohacjTpCexPaRU69eVzwurHfnF/eiV5uRBJJMl
	hJb3jv1H2HDMhKhJdi2rkyuLCrUMxJFpqCirkyZ8AQ+lRjWYAmJafa4Pwv5Nk4GeK7kXea8XfhS
	6XZ+LYKuQXGFv6lJy9OKOGTCav+r92KNtw44PyZqpClvDDENg+ej+7/YQxPSAuG8nqnalDfJOsy
	o4Hhaf71mN1ME4WvDkCQl1JjhBVhWgbS0BOuH5/x1h1EQS5D2rPuxeAKVhtUGXRIW9R2IOZmZIm
	krIMmWYGvON/3sih3Sgo4omHsbw0gItSA6P8+ooXDVOTGlWjQWwOHUcqDHFUC1i+qnIvmP5mKaG
	r1scf9x1sjVqyjjxRuFc2LJsSpglgmJVo4uxt940P3UxCnpzfl4hX+mQfGWh39AhcZiFDTPrbsk
	OdYvwhkv9CybiuJcVACw==
X-Google-Smtp-Source: AGHT+IFMe6D44grpGqaN30+IACiK1ag0L1YVwPsQdog/6V2aBU+Upngdj4V9R3NOTeGT0ryw35P7Jw==
X-Received: by 2002:a05:6a21:3293:b0:2df:b68d:f64 with SMTP id adf61e73a8af0-2e7d4dfb6b7mr24100790637.52.1759200575723;
        Mon, 29 Sep 2025 19:49:35 -0700 (PDT)
Received: from [172.17.0.3] (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c53bb255sm12688305a12.5.2025.09.29.19.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 19:49:35 -0700 (PDT)
From: Leo Wang <leo.jt.wang@gmail.com>
Date: Tue, 30 Sep 2025 10:49:23 +0800
Subject: [PATCH v2] ARM: dts: aspeed: clemente: Add HDD LED GPIO
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
Message-Id: <20250930-leo-dts-add-shunt-resistor-v2-1-8712984f04c4@gmail.com>
X-B4-Tracking: v=1; b=H4sIADJF22gC/42NTQ6CMBBGr0Jm7Zi2yp8r72FYlHaASYCaDhIN4
 e5WTuDyvXx53wZCkUnglm0QaWXhMCcwpwzcYOeekH1iMMrkqjYFjhTQL4LWe5ThNS8YSViWEFG
 51l4vXZm3jiAFnpE6fh/xR5N4OGaf42vVP/tXdtWo0VWltkVV1qZT936yPJ5dmKDZ9/0LDIQHv
 sQAAAA=
X-Change-ID: 20250926-leo-dts-add-shunt-resistor-0cba43f75bce
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 george.kw.lee@fii-foxconn.com, bruce.jy.hung@fii-foxconn.com, 
 leo.jt.wang@fii-foxconn.com, Leo Wang <leo.jt.wang@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759200572; l=1492;
 i=leo.jt.wang@gmail.com; s=20250618; h=from:subject:message-id;
 bh=klDRu2KGjM+0nX0HtilCbWli5VflcdgLmjY2aTzwD5E=;
 b=ZPnwa3kHMLZcbssExhvWUM2QAqYAJS1I7iHpxlKd7keXV5gaKRp07f4D4Fa3UWcplSv0Hmsab
 TM+5DwS+2TIDCG9kMJDLaoT9z5ObGavmkF/TWkmp56UEMqOToPr0+XG
X-Developer-Key: i=leo.jt.wang@gmail.com; a=ed25519;
 pk=x+DKjAtU/ZbbMkkAVdwfZzKpvNUVgiV1sLJbidVIwSQ=

Define a GPIO expander pin for the HDD LED and expose it via the
LED subsystem. This allows the BMC to control the front panel
HDD activity LED.

Signed-off-by: Leo Wang <leo.jt.wang@gmail.com>
---
Changes in v2:
- Drop "Changes include" section from commit message
- Link to v1: https://lore.kernel.org/r/20250926-leo-dts-add-shunt-resistor-v1-1-c871a68792f0@gmail.com
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
index a614f947dafc9a6628c3f3d45b62ff3ca9d2b618..450446913e36b1418fab901cde44280468990c7a 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
@@ -95,6 +95,11 @@ led-3 {
 			label = "bmc_ready_cpld_noled";
 			gpios = <&gpio0 ASPEED_GPIO(P, 5) (GPIO_ACTIVE_HIGH|GPIO_TRANSITORY)>;
 		};
+
+		led-hdd {
+			label = "hdd_led";
+			gpios = <&io_expander13 1 GPIO_ACTIVE_LOW>;
+		};
 	};
 
 	memory@80000000 {
@@ -1199,7 +1204,7 @@ io_expander13: gpio@14 {
 		#gpio-cells = <2>;
 		gpio-line-names =
 			"rmc_en_dc_pwr_on",
-			"",
+			"HDD_LED_N",
 			"",
 			"",
 			"",

---
base-commit: c65261717599d419e9c683d85f515d3ca2261549
change-id: 20250926-leo-dts-add-shunt-resistor-0cba43f75bce

Best regards,
-- 
Leo Wang <leo.jt.wang@gmail.com>


