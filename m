Return-Path: <linux-aspeed+bounces-5210-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1878CC6B2D
	for <linux-aspeed@archiver.kernel.org>; Fri, 16 Oct 2026 04:34:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5XBP25H4z3bZm;
	Fri, 16 Oct 2026 15:33:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::f2c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791748621;
	cv=none; b=kJfMRn50CasBnkUk2snHYisoAepBoZAe6e81pOBECasqyk9XH8+5jGFZMaaP+n8FQLbn+8HhlhZVQNSPviwE/ENz82azEUFKplLOVdv6NXWK2NoSqlAkEozAZI6iBEY0Se/ZI/LW5spSr0zQyPHKwP9mvYI3SxAeMvv8CqQcC/JG5fRXkpKzAHuYYsj1NNX4flkXfmbjTNsh+rPVAne0SVpnjZSfygGIxLwcUCPQN6NqYndNn8joDgmsRIZ8oYl4WU7hFXO2BFqmJ1i08xsGoFf4f745GeIdck4vUmwyGaJGZCiiIQo/Iirxi29qMtkIwe+KJd2NwU1lUR28DIlY5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791748621; c=relaxed/relaxed;
	bh=iHHZH59qV3EnqbOQ3vYmK0JHZ+tuhXSFnyosgBQqvFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DHTe5bUN7gAZModSwe7c/sQt+zCrwnrM951+UY15UkM/wiy0IuX5kyTMB3fqDxyePbLT1jGWs1i+jww4gwvu+JWhdMeyvUdx26YQ8L3SkbEPSArnpGQILjfLKyUG883Wd4QaDiHWSH/Kl17Gia9KJ5kU0s4sZvGXZeqXaV/5o6fGGlKq2aEi+WxMVVGVztz4z9ZLrN+qVkn0l5ynMok22iQzsKAJgOAsrLovmoErMp4fRrnbOm3rG93tIZMlclGXEww2ikEHKCK084YkoRzfPISqaJOCZ/vEqSItniDKIQEBsqlAl0pw5R0+wCmko7DvET+jocpnQyEIO7OXRL+Zhw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UIH5yb5n; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f2c; helo=mail-qv1-xf2c.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UIH5yb5n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f2c; helo=mail-qv1-xf2c.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j2rwC3Fy4z2yQl
	for <linux-aspeed@lists.ozlabs.org>; Mon, 12 Oct 2026 06:56:58 +1100 (AEDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-919abb3335fso18420786d6.0
        for <linux-aspeed@lists.ozlabs.org>; Sun, 11 Oct 2026 12:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791748610; x=1792353410; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iHHZH59qV3EnqbOQ3vYmK0JHZ+tuhXSFnyosgBQqvFQ=;
        b=UIH5yb5nzikOnODzqtM80ZscxebxWypya5gCRwLedR1UQCT+ThVykU6+fE80sGU/uO
         O0gzoVEx/amK7mYfxLhl9NlCJTKre7Jdnob4ZP1t65oMYs1URlhvYQRAJCsBc0h8a0uP
         34/hFvqx4ncJd8gwvsfhmvp7G+oagHWi5Tum9WPkuW7q25udp5Ow9dvAxqiuGwfFzeyp
         r8FFFKHHDdVZ7HeNe3FuXLp2D5z20+IqmmZssQxx95ccUACMy7mhzvWbrBxHI2MsH9bv
         N3G89+TA8ChAK8yiyBQDHUT8Iy28wPRTy+UUxeDo0tzs+Z3//PVDU0Bm+5M1cpC4YPH4
         Hamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791748610; x=1792353410;
        h=content-transfer-encoding:mime-version:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iHHZH59qV3EnqbOQ3vYmK0JHZ+tuhXSFnyosgBQqvFQ=;
        b=s6+yg6IK0I/IZ961Fdk5c8mgNGjc45jAH6mgRGE+NKC2ZrDKYt0H8T4AK+Qvzvu9p2
         1SD2Q1NTUqqsZm3bfdDUi28b8ArpKfahJkyX6xdUHZ9t8Wzk/uXExaBs5hWXr1KuH3fD
         c3nkXXh/FvL/iR9j//VFFO3PdhdI4y2o/nxmbNgcHTFit74BXMDsKw0k8sOkqGs1qc4y
         xKV/2lY0OsKoHwvtsX71OlM89GaUDYcZUViMvf8IYFsxz/EPDt6tbaVEKf6c6v+D3qOf
         0gVttdnEVtpnVaBma1qN0rqCv8n+6OkMEnLzzgoLPGig4Z86j3s6jhEcHfPMrZdA9aLP
         ssAw==
X-Forwarded-Encrypted: i=1; AKwUvByI2TMESuljPbDr5Mp0U4BBACcRfDa2ffaOcKmYKEIueKRuU+HAyS864VnMYIvbdzreBmyjbsb4BKd0r6U=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLmsWFqnB0zx1NqNoP1cxzREA6ba4FMCwx4vbe/YLhXjOCjSlFZ
	Q0E5b7Nzfbx69VDbdsQB8fnmuOOSBwAip3KbLYVeWaAOzljec3wAyNA=
X-Gm-Gg: AYBFou2xufgLmQs+EflMlKZaCyw70e2slPykDTTlBpJaW85LwtdBQQ66xEP7rbykhRn
	8clkGWXAAr+GMa208xM1EImJJXDXIc+i0uJ/JPNWJfC8BwWwSY+f/c6BnhQLO3X8HIje68oV27T
	mhggTP1vQkgujFnZzr4vvxgT9YPpKRm+bo2T2P2sLKw786ZR81kYIiYhA61uSteq4lBU4w9kkuZ
	OebUP41b7j4ervNZ4fwAl9h8yQAzAM3uL6J8EhNl6NulbCVx3MUbM1xjpUPfHZicnBM4DSGUFw7
	vm2iOan1P3rzqdOHvYlWflsSuUiBgJOsCfd2HxAkecYrvZBopv2uFYBlG9IakQ1qAe9DahIz6oq
	gJdmgRV7zZiVWcGpXN73EQ+YeElHQKOJO18wsfrYzwEiFHeRpZo2dTFi0qUL4RYC8FcMoZIgpbp
	RYZmIkIzb0W5TAOkOg6fN45Y4rty+7qVUteg6Kl2ZQ+zn8M0kxmvRemOY/ZItN4U/fWGjZbA2D5
	onpbQnsQTbBSa7PZvk1dL+vWPFWlLpXDva6bzI6dlU6dWOKmYZAs70k+R+HbHDXD0m0tO7Eninj
	tf7XUGZ8wCcm+QusjDOvDwbQ+tZK0DbU8oXlFr0=
X-Received: by 2002:a05:6214:498e:b0:91b:5d3b:4acc with SMTP id 6a1803df08f44-91b5d3b4e26mr149047996d6.53.1791748610213;
        Sun, 11 Oct 2026 12:56:50 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b550dfb6csm77651326d6.45.2026.10.11.12.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 12:56:49 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Eddie James <eajames@linux.ibm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	linux-media@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] media: aspeed: disable resolution work before removing the device
Date: Sun, 11 Oct 2026 15:56:45 -0400
Message-ID: <179174852932.3.2170255507797724902.G64@gmail.com>
X-Mailer: git-send-email 2.53.0
Content-Type: text/plain; charset="utf-8"
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

A resolution-change interrupt schedules res_work. The worker enables the
video engine clocks, initializes registers and detects the resolution.
It can also queue a V4L2 event or restart frame capture. The remove path
shuts down the engine and releases resources without cancelling or
waiting for this work, so the worker can undo the shutdown or access
resources after they have been released.

Disable and drain res_work before turning the engine off. This cancels
pending work, waits for a running worker and prevents the IRQ handler
from queuing the work again. Keep the clocks and IRQ handler available
during the wait because resolution detection can wait for an IRQ.

This issue was found by static analysis.

Fixes: d2b4387f3bdf ("media: platform: Add Aspeed Video Engine driver")
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Compile-tested with GCC, W=1 (arm64). No runtime testing.

 drivers/media/platform/aspeed/aspeed-video.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/aspeed/aspeed-video.c b/drivers/media/platform/aspeed/aspeed-video.c
index a292275..4274b90 100644
--- a/drivers/media/platform/aspeed/aspeed-video.c
+++ b/drivers/media/platform/aspeed/aspeed-video.c
@@ -2360,6 +2360,7 @@ static void aspeed_video_remove(struct platform_device *pdev)
 	struct v4l2_device *v4l2_dev = dev_get_drvdata(dev);
 	struct aspeed_video *video = to_aspeed_video(v4l2_dev);
 
+	disable_delayed_work_sync(&video->res_work);
 	aspeed_video_off(video);
 
 	aspeed_video_debugfs_remove(video);

