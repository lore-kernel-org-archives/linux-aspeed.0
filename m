Return-Path: <linux-aspeed+bounces-948-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4045C282D3
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Mar 2025 23:36:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z6sWl22yCz3bwX;
	Wed,  5 Mar 2025 10:36:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741107940;
	cv=none; b=ZXAIiw22TcjL7X7lvLD1OJRkiInY79B2jBGLKTkDKFpio7PNVfBjVLN0g6Q0samdwsercWTXsevYWlWL4AmZGQM6aXFKjWNRJvEZNlPGzfCWqgGcu5s5JHMOOFRiK7LSHMi5/qV5iBNp+sX02eaNuYFFuN2fTJXwQdl8x92t8WKt9H+4LEbNwAmVAHTQ5yS2KbDCAPQCJ+EcNFELdwYHCWQmrWcvD7UL2skAKfcjiPmktvOYSU4mehTnVtCRFb8VBen+vcC/xJ1tkCq0EcVTynBUqGEO6Ek8w38EZ9lXt+4F4BNM/OGQlvyZXZ1khTTTuGTqXSwNAmymVgW3dNCxjg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741107940; c=relaxed/relaxed;
	bh=VwGP1hOkgqyt7cuslt+mBb5Pi8swKaj/YmncchBevCs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T9vMi1obamL/G1o2NiFOY9yINmILjFUWBCamoZQdLh1qbCKfPboM98cqvaRrgz4LUqiltT8kkMe8PwOojpnqGL9C/PIYGuPJG4+e094wC/8kPCIuB4PFLDUq09u7CwsKNKr0jB390ZH1ngZ4TPz2xiTKaQCm7HGbERNu8ykFRCT0F7R6Mzzh+DLrMJDpasP2m7JKp20o57aMfjai0pKuTxFZhnBmmaahiQL6ls6zNelB7Sgh8/UIDV1ymJKlSIiPO99PD3JiKaTwVzIVEwTQwnXzFQOL3hUwIY5sSUa7yLgREOKIFC9RjQNw4PnfnLBovPwHsWjj3N9gnMXrrwLnrA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BllZ2ppY; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BllZ2ppY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z6hrx17SPz3bpM
	for <linux-aspeed@lists.ozlabs.org>; Wed,  5 Mar 2025 04:05:36 +1100 (AEDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-ab744d5e567so997995766b.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 04 Mar 2025 09:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741107931; x=1741712731; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VwGP1hOkgqyt7cuslt+mBb5Pi8swKaj/YmncchBevCs=;
        b=BllZ2ppYvxRtc9rGZqyqMuPG3jwOyY4PD5cGn1USmKHszMnd2oHscRdaIMMGVFa3VS
         QZnYT56XZQymNyKa2XKfLNI7+vAkYOzwASDehhE/39N5emYx4GLmd2XO1N135HD8yObE
         oGtRoeZcZmhnd0GhVNU0G9ZiQN44oerJluqiVeetY341kTdlBXgAgQIf5J7lTjSIRwMT
         O5ilRxtAR0Q5Dpj/YqO5um1NyE/oL3q1hWWipT/hHZtBOOxQNwlUTRqynVlybh941l8q
         /5VwSDuJ9eG2v31DaWocoY3m9DBkAAW0jHDlu2JQflUvQvUQbBAOuxZi0Tz21rzbp+4v
         BNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741107931; x=1741712731;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VwGP1hOkgqyt7cuslt+mBb5Pi8swKaj/YmncchBevCs=;
        b=vTMInUFPlO7FVbBMFzaQDKMrCzow9efcD/glRFDfthQh2wTzCKEX4EykHUiaXxEOUT
         oaF0QeDXaFFJ52lVjDGFwj6IOM4vSurkX9mC9nV6csklD3CgbNtvKUs+AE9QYWmgoCXK
         gNH1KgQbOU4G5gFtERxRS3ENCtL6+UdJBQaip/qgOYfMo4wGFTeEb+LqX0jw3k+3BIYc
         OBHfn4fNXLn7I55q8En6h+szJdp87ZNJ8D6gcEzmdnarJmf7knTM/v0qhI7EWKyfK5WD
         0ItCuR/g1EIlHKtUSB+GSL9qSk5WJ4kWkb10PN4NcOX+TEIHagOntvUiE+kTyLbFg91D
         jXmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTEiMdZihg2HwvAmcPoGUATCtLabevKC89z2xBC2HhNfGNTDlQx1ZTyGnh/FEvUdQ3O7WdZlkyb5EHhDE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxx3onp9nOR55044WiI3tt0hkobFfYlA8YrEElHRdZ6rl07Kpn5
	NBJQFItqE8cYTgZ/KrFV52THmzfx3JrkIDm4XgnoZorvMXIBFkL/IytttDn5wCs=
X-Gm-Gg: ASbGncuPLdA/FpHTfw+yuHd9HjvzYWkyChgWv42Rwo6c+kIo1/gm0o9Gcdk6YvsS2Zd
	zMgQ8Fnj17DXKj1WSuLN91yU0kg/kj3vqIYBbK2A4FVFERhgRBA8K3cyF3ouJeWJn2INVIU7mf5
	cCCZq1guOaD0VJkvaA4MAehV8F7Oq8nB4Pb0/BPcDFJIIHciWn6ZpK/R7WwFWvQBLf+V0mEtBOt
	+dG3WictrAiog81SrNYqRpksFjXHcaBHFL0+EzRhUSCratVx5YytJuwBFoII0ftr8pAMdVbfhkW
	PtVHVsLIO6fTJq9Hjds1MEPr4e0bha0T5H1XhUq2qQKz9vfVBbGIjqdjohhHgJHHU6TUDU2VmrA
	JZIJrJ0kYhRpPyUdWhMVQ/dzhYkLV
X-Google-Smtp-Source: AGHT+IG1qDKc0hst2zevKKhfPXC0MrEb14O70/5mMsp5hFfaUprLxoI4xNFXRR1d5hlR/z34qhDcpw==
X-Received: by 2002:a17:907:da0:b0:abf:23a7:fc6 with SMTP id a640c23a62f3a-ac1f1185263mr365511466b.16.1741107931351;
        Tue, 04 Mar 2025 09:05:31 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf795ba15esm367589066b.131.2025.03.04.09.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 09:05:30 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v2 00/16] a few rtc driver cleanups
Date: Tue, 04 Mar 2025 17:05:28 +0000
Message-Id: <20250304-rtc-cleanups-v2-0-d4689a71668c@linaro.org>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANgyx2cC/3XMQQrCMBCF4auUWRtJxhSDK+9Rukjj2A6UpExqU
 Urubuze5f/gfTtkEqYMt2YHoY0zp1gDTw2EyceRFD9qA2psNaJTsgYVZvLxtWRlMOihNXghb6F
 eFqEnvw+u62tPnNckn0PfzG/9A21GaTVYGyjoq7PO3GeOXtI5yQh9KeULAj75TakAAAA=
X-Change-ID: 20250228-rtc-cleanups-12c0b5123ea4
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 =?utf-8?q?T=C3=B3th_J=C3=A1nos?= <gomba007@gmail.com>, 
 Dianlong Li <long17.cool@163.com>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-amlogic@lists.infradead.org, 
 llvm@lists.linux.dev, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2

Hi,

While looking at RTC, I noticed that various drivers are keeping
pointers to data that they're not using themselves throughout their
lifetime.

So I took the liberty to drop these pointers and this series is the
result.

The last two patches also convert two drivers to using dev_err_probe(),
as I looked slightly closer into those two. They don't exactly fit the
general subject of removal of unneeded pointers, but I wanted to share
them anyway, since they're ready.

Drivers other than s5m were compile-tested only.

Cheers,
Andre'

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
Changes in v2:
- s5m: fix arguments to devm_i2c_new_dummy_device()
- merge two rx8581 & sd3078 patches into one each (Alexandre)
- Link to v1: https://lore.kernel.org/r/20250228-rtc-cleanups-v1-0-b44cec078481@linaro.org

---
André Draszik (16):
      rtc: max77686: drop needless struct max77686_rtc_info::rtc member
      rtc: s5m: drop needless struct s5m_rtc_info::i2c member
      rtc: aspeed: drop needless struct aspeed_rtc::rtc_dev member
      rtc: ds2404: drop needless struct ds2404::rtc member
      rtc: ep93xx: drop needless struct ep93xx_rtc::rtc member
      rtc: ftrtc010: drop needless struct ftrtc010_rtc::rtc_dev member
      rtc: m48t86: drop needless struct m48t86_rtc_info::rtc member
      rtc: meson: drop needless struct meson_rtc::rtc member
      rtc: meson-vrtc: drop needless struct meson_vrtc_data::rtc member
      rtc: pl030: drop needless struct pl030_rtc::rtc member
      rtc: rx8581: drop needless struct rx8581
      rtc: s35390a: drop needless struct s35390a::rtc member
      rtc: sd2405al: drop needless struct sd2405al::rtc member
      rtc: sd3078: drop needless struct sd3078
      rtc: max77686: use dev_err_probe() where appropriate
      rtc: s5m: convert to dev_err_probe() where appropriate

 drivers/rtc/rtc-aspeed.c     | 16 ++++-----
 drivers/rtc/rtc-ds2404.c     | 14 ++++----
 drivers/rtc/rtc-ep93xx.c     | 16 ++++-----
 drivers/rtc/rtc-ftrtc010.c   | 17 +++++----
 drivers/rtc/rtc-m48t86.c     | 14 ++++----
 drivers/rtc/rtc-max77686.c   | 37 +++++++++----------
 drivers/rtc/rtc-meson-vrtc.c | 12 +++----
 drivers/rtc/rtc-meson.c      | 16 ++++-----
 drivers/rtc/rtc-pl030.c      | 14 ++++----
 drivers/rtc/rtc-rx8581.c     | 85 +++++++++++++++++++-------------------------
 drivers/rtc/rtc-s35390a.c    | 22 ++++++------
 drivers/rtc/rtc-s5m.c        | 58 +++++++++++++-----------------
 drivers/rtc/rtc-sd2405al.c   | 16 ++++-----
 drivers/rtc/rtc-sd3078.c     | 71 +++++++++++++++---------------------
 14 files changed, 183 insertions(+), 225 deletions(-)
---
base-commit: 0226d0ce98a477937ed295fb7df4cc30b46fc304
change-id: 20250228-rtc-cleanups-12c0b5123ea4

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


