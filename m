Return-Path: <linux-aspeed+bounces-947-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 558A6C282EC
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Mar 2025 23:36:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z6sWk3Kr0z30CF;
	Wed,  5 Mar 2025 10:36:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741107941;
	cv=none; b=nWNekLhNs2QDvrWdEMCMzWcTRNvJk3esv2C+qkRBqx06fMuEy0cU+sNGHfrxB9klYUKRizFeKxQ2aPu5QQ2NlrNQezQPLKmofKYiepNpIFSj7P65nzR74drWElpg1o9d2gni6+Qneoiq2m3s5VklB1qGgqH3Dfn4wEHWgPpA9gJto64JqaxIQsu7BDGMaXD3dBVERYlpuBwt0+ZBs54Yh+RTmy0OpZ9ISEqEmfM1/PWXWnCAnrytdZQjT7tC5DUBMnJ1eoMsmTTEKRwicYgGzGX+NZ55AEzlNcESnTluzFQQsBU7G97o5HlZNJq42fEygX5yq/oDi3W2B9O1HZAaVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741107941; c=relaxed/relaxed;
	bh=NvWUKPp3Qf/mJMvtGf6kleKwT9jTpA0O53gNmEgl49A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TOVUSD/Ka/3Yu1jidKsVInE99mdnF6y+1j1npQpv6+zpjv4PMSvIoiuFWuRayuPgA1/phgvqypaBT2yigk5ifLeRpi/xTLALNGkZ56Ios1bw5cFQDzbgqBWenMKL46VDiYdTe/Yd05VDJlOuaSAg8eh60inrOHasCZTWtJMbSngp+23Eldjb/lQm/VU2N3yxfZOgMaHsELMMET1majnRV4DpHsm3OTe9QP9Wxd8Zg7BF0Zp71eOP+q3fjLNIH++muPY+SfV8LxqrptsfwvYl+1gpgpmrLppa193n+7ahnWV+P9pwrLVOgxAh1BRIosrNytUXmuFd32t29eJojsuX/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=m5svEyna; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=m5svEyna;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z6hs06nZ1z3bqC
	for <linux-aspeed@lists.ozlabs.org>; Wed,  5 Mar 2025 04:05:40 +1100 (AEDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-43bbb440520so28438895e9.2
        for <linux-aspeed@lists.ozlabs.org>; Tue, 04 Mar 2025 09:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741107937; x=1741712737; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NvWUKPp3Qf/mJMvtGf6kleKwT9jTpA0O53gNmEgl49A=;
        b=m5svEynaYOqqEtKvC+RmsSPMoEOB9dVurPnuGJcNmTBkf6oTf/voyq3igRqAWvNaez
         mm8W+UL/xmXPPXsV/jE7AnNuXiO8fsEIvBfQP6G9BbhgajQDzvZAZCDhKbvT0bIQ38GP
         7lttVmwnfWu3VptO/JwzbV5iupgz59d7/stH8OK5SH1hpJP983vnN3G6y9tEvXD/B+ob
         g1fv+xE3bbLS26UG9to0BDwGmO2ixYcbUiPJJ1NP345rfgzJiUP7UGOWh2wKI4UV3k+f
         kHOQEGbLyCKfbeBfNDqJJ1qSwRFVfvrCQBAb76rHJ2+Q3WqqROb/kvNuCTOe1tw87YWs
         1qiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741107937; x=1741712737;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NvWUKPp3Qf/mJMvtGf6kleKwT9jTpA0O53gNmEgl49A=;
        b=P+kcmYtv/iTQ3Ali9IaJpsy1vxzYEBh1/QkY4tC275Ah8/8KWrUOKR73g0J14f8UBX
         UktN+fKWUfC4XoYxNFON+uGKcu9x01fWAk4ZguKH/k6Mq9ycNgUkhVjVKd8/8gzy2NAr
         qSQ4HR1B1gS6ukxLmgUq92eBtl3n1Xv1EcCzWXRY/CyehTlDic/eQhvXGmXNoDTl/juV
         JFTUzJHXGBNJClfttBf1AoZBn0BKDAO5s3NjHF/0x+iDrbN3x6XZm+Vb9H0gs36a/HT8
         RBV3LqW05Q6A7RHr6cte4k5uF2CCHvcVo/N3Wd8JKsW7UgyvNYZ/ifMsdcq+BNSvtTaG
         5Tvg==
X-Forwarded-Encrypted: i=1; AJvYcCUjuSY8MHpYEJ69l0zfmiB9Dud8HRYPyo/ujZMlGQ+NbQy0k+QCQKTIrcdl0SzojV187jig8wdWSHc93Ck=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YylkYlqfmnpQx/3BVLrVVK8jlYVlzYrUm6OQ6BnyIiF0Vz4Mtnl
	4tQygWXE5IIWn898VseKCvq1OjPyxxZr/EmC6UcJ3EcjUCyTDJZH4DUJKGjH3fk=
X-Gm-Gg: ASbGncvTi3UcV0+sD/1YRe4Sv2gZ/fdPRsxKlGLZjPtLbmQICI0pZli9L8uPW6Cxh6e
	qjsdYyDJ+0wHg4nkBlUpeprLp5pYdFKDBfOU86wd0336wAaQWwcVKPkRXlfmi+fDtLWtVq60RUc
	eXxjVsk5fCW2m7PC3ilTk1yYfTAXbkoJhfaR/prQJkXTilepRTmNZ11HrM6zHt8Cq1sltYYu3Ow
	f8RC7bVfJmKmuu1pVRo5XSbe2NkP0OsVUCJwVagBagF57uSYMrfngPDMphfqS7sixX91/y8Z9qC
	3TZF/2wWtwjXSpT/S55/77b9+Mek5ukou073KjIdRysWbGfUmxcyXrxS6FyALk89bwp9Vy9yjVH
	sxdaG15xysn0qpPNTWli7+7jc52qW
X-Google-Smtp-Source: AGHT+IHZdsv7jYfFsjyY3TIB4euke/dHgzMkeAeSorD4HntlJXvk76kkhxE/lHiggYkJdsJqp3nEfg==
X-Received: by 2002:a05:6000:10c1:b0:38d:df29:e14f with SMTP id ffacd0b85a97d-390eca069a5mr17165829f8f.43.1741107937298;
        Tue, 04 Mar 2025 09:05:37 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf795ba15esm367589066b.131.2025.03.04.09.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 09:05:36 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 04 Mar 2025 17:05:37 +0000
Subject: [PATCH v2 09/16] rtc: meson-vrtc: drop needless struct
 meson_vrtc_data::rtc member
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
Message-Id: <20250304-rtc-cleanups-v2-9-d4689a71668c@linaro.org>
References: <20250304-rtc-cleanups-v2-0-d4689a71668c@linaro.org>
In-Reply-To: <20250304-rtc-cleanups-v2-0-d4689a71668c@linaro.org>
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
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

The memory pointed to by the ::rtc member is managed via devres, and
no code in this driver uses it past _probe().

We can drop it from the structure and just use a local temporary
variable, reducing runtime memory consumption by a few bytes.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/rtc/rtc-meson-vrtc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-meson-vrtc.c b/drivers/rtc/rtc-meson-vrtc.c
index 5849729f7d01d7ec7868ff3bbdc5ed599aaa8238..7d38258cbe376e5a1b2af6250cb6d04c313175fb 100644
--- a/drivers/rtc/rtc-meson-vrtc.c
+++ b/drivers/rtc/rtc-meson-vrtc.c
@@ -13,7 +13,6 @@
 
 struct meson_vrtc_data {
 	void __iomem *io_alarm;
-	struct rtc_device *rtc;
 	unsigned long alarm_time;
 	bool enabled;
 };
@@ -65,6 +64,7 @@ static const struct rtc_class_ops meson_vrtc_ops = {
 static int meson_vrtc_probe(struct platform_device *pdev)
 {
 	struct meson_vrtc_data *vrtc;
+	struct rtc_device *rtc;
 
 	vrtc = devm_kzalloc(&pdev->dev, sizeof(*vrtc), GFP_KERNEL);
 	if (!vrtc)
@@ -78,12 +78,12 @@ static int meson_vrtc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, vrtc);
 
-	vrtc->rtc = devm_rtc_allocate_device(&pdev->dev);
-	if (IS_ERR(vrtc->rtc))
-		return PTR_ERR(vrtc->rtc);
+	rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtc))
+		return PTR_ERR(rtc);
 
-	vrtc->rtc->ops = &meson_vrtc_ops;
-	return devm_rtc_register_device(vrtc->rtc);
+	rtc->ops = &meson_vrtc_ops;
+	return devm_rtc_register_device(rtc);
 }
 
 static int __maybe_unused meson_vrtc_suspend(struct device *dev)

-- 
2.48.1.711.g2feabab25a-goog


