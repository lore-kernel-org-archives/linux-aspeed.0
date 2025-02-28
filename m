Return-Path: <linux-aspeed+bounces-876-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B2AC282C6
	for <linux-aspeed@archiver.kernel.org>; Sat,  1 Mar 2025 11:01:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z4hvx4pwLz3c3n;
	Sat,  1 Mar 2025 22:01:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::52f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740751649;
	cv=none; b=IvnDOBWwenemRbvaM21TWe71wWMGoSFc9+7HymKKINd+oz6Gc0Bxk3RycYGm4pK3e8tWz7CAiJq7VdF+HoKTYmllZvT7upDS7Qc75kQyHm8yPKbxB7PiXPPHnCgTRtuP5S27fRBESSY+0Qv1lm9g4GL9/OPNLeTUWJ3Nq4jJb+tC4X5uHXJAThEkYWLb0nbYrlmpSQgg3wOEED9k79/m7KoL/+AB0lsxIlWifyKrfKcT255uqnt9+3eOQPjdInkQalv5d52RmMspSyIr2UDSP90pp+hbxIdyrPLjYcgfRyFPTE5589eHbaJhx9/BUEtHHRL+xkc8WWeOSuuFBFjazA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740751649; c=relaxed/relaxed;
	bh=xhLZqgcaujiFhw9G1dCH5p0FiLmGyvslkaMt4uwl9Do=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GyY1fh4HipEnd8Hd8XDO95zoRpFhmAX8Dgy0Hq3LwyF9fNX6gaWPFY0uaQImzC+wHpyJrnRJdhzzFV7tOBM7sn0iHDxVrtnRnfFQLdmXD2WZ2xL78oFVjjP0oSjJfKapB3X+FDj3rNJW/HzF6FAsAJxhHFEG4XFWHGJb57PhDlKGhIgj73ncPB165tOrs6zNAlv40XXd9Z5MXjaNAezSVCU9KCKtnP1UgBzajhz7VSmkIgxwl56tjXPIbjXWAHcpFqWe4Ne7/V9WfxFN4jbgGP7W9nVEqczgjcRn5zp6GI0y0I/W2CTHTCU5+XtszQ0I3zSNcVWpZCaKIUBr2FVGZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zdbk9aXD; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zdbk9aXD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z495C64Ggz3bsQ
	for <linux-aspeed@lists.ozlabs.org>; Sat,  1 Mar 2025 01:07:26 +1100 (AEDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5e4d3f92250so2082236a12.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 28 Feb 2025 06:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740751642; x=1741356442; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xhLZqgcaujiFhw9G1dCH5p0FiLmGyvslkaMt4uwl9Do=;
        b=zdbk9aXDzFwOmaP2CRcVmQFa6D1C18odHBGfaaYpSb83YHnMqsCvHHGd9uPUqwTWfQ
         h/QjN8qgqIdi9Yh26sCEHIV8kjq2Udr2UTKKifaE3mwSEyc2wrnbjlNacc3VVu5FtK+K
         g9I39bOXvIE9Ypp46YsqXNUSIe+HlSPDbxoWPePmP8WLQCHLX+yJ88Kv3N/HMwEZoKRP
         5TJQnR3TutPpjnTUUNV6m6QUYqW0KxQb7kyNB+SqJpKpPi1wWp9wdYku8rKkCOWL9hMa
         9e+H8DZ4Nd+soa8FOqQPMgYdBoF7D8rZZ02ltO+Z9tJq/EdfAsbxuqJqb8YM8Qqb8hEV
         N9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740751642; x=1741356442;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xhLZqgcaujiFhw9G1dCH5p0FiLmGyvslkaMt4uwl9Do=;
        b=QG3pzmVcxMan3jF+gueL6YZuWtMWUR6jU2woocs4TJ39I0XR3hC1DGdXXSGBSQ4u5M
         jWEHHgEoLv4yf64JvKkDTSUbd5sYKsKP9oWEcMSYBWr/omFsM1vvXTZz3XWQjRsWNAFA
         CXaMUdOzmReM7TdiAMQqe+XsAxWyGjqofssqMNIA2cT6UbSqSYg6JhKb5WE+QER3Zeq0
         SRVrGsvlF2H57tJyTD/JdlKRGXlqeHivr0634p6xfSuakGDoF9E5+HJk8ykL/IK/UDRR
         sitXZT4VrW2qqC/EYE/dvhv6fbnm2DxenhLoN2ZUIT+miFWjZZXX9iFh8CPPrxKumC7n
         a+bw==
X-Forwarded-Encrypted: i=1; AJvYcCWowzd4yMjtlLplPhlJn5PwgEgoR+o8A/NHKNFIPSfh4ftviXQZaitk22+tMRVsbId2oydBFipnji1m2NE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw8Kp2EOx4FO8IbttAry2+mul/5vQWDsR8PB2gb35X1tNFYmuZD
	TYPybx3dcwTa+fh4uTutVL8O1wHORrb3uXryZWynFiUadFDJts1KDCcDkAkw5Jc=
X-Gm-Gg: ASbGnctTQES5h65LeKMELjLqM0SmHczVnZubX7uR/SuWGN51FV7ioQi4UTogJxYl2ed
	Af1jS8nNIg3P1G3Cita97Rb7Y0xnCL7V6nkL8rfsWFk3ujK2CG3MP/JQF26mjgYJwjrS+Rj2VRX
	d4xYLbPZdgen6uTIW0cSAx0NmFfNk0sNcRH+rXtmq/Bth4d8AY+EyAlbSdd4s/tqvUzPIe5PVbb
	7yknmued+P6+vy3zeIFdlccNk2RCUbX82I1I8PM+4TkQSziFgpPRGUahsdxCuKq+zGekez4Mfur
	nrzI2d44zLlMwOs3oHvyFrGza3zOJk3lvRV+TXLnChoBhHUVwQ3FXY5weaZteTALcwMIleP7uOL
	ms2th1aNNqQ==
X-Google-Smtp-Source: AGHT+IHP7pUAJMVQB1Guj47dyI47K7YXQj82SFh5z5QQxgHATc6r4NQ1/TjLpJM/Ncf+/B2eBWDZ7w==
X-Received: by 2002:a05:6402:5242:b0:5e4:cfb0:f667 with SMTP id 4fb4d7f45d1cf-5e4d6b691d6mr2481074a12.21.1740751641613;
        Fri, 28 Feb 2025 06:07:21 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb51f9sm2550839a12.55.2025.02.28.06.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:07:21 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH 00/18] a few rtc driver cleanups
Date: Fri, 28 Feb 2025 14:07:13 +0000
Message-Id: <20250228-rtc-cleanups-v1-0-b44cec078481@linaro.org>
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
X-B4-Tracking: v=1; b=H4sIABHDwWcC/x3MQQqAIBBA0avIrBN0SoiuEi3MphoIE60IxLsnL
 d/i/wyJIlOCQWSI9HDi01foRoDbrd9I8lINqNAoxF7Gy0l3kPV3SFKjU7PR2JLtoCYh0srvvxu
 nUj6cRcJTXgAAAA==
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
 Dianlong Li <long17.cool@163.com>
Cc: linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-amlogic@lists.infradead.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
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

All of this was compile-tested only.

Cheers,
Andre'

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
André Draszik (18):
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
      rtc: rx8581: drop needless struct rx8581::rtc member
      rtc: s35390a: drop needless struct s35390a::rtc member
      rtc: sd2405al: drop needless struct sd2405al::rtc member
      rtc: sd3078: drop needless struct sd3078::rtc member
      rtc: rx8581: drop needless struct rx8581
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


