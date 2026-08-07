Return-Path: <linux-aspeed+bounces-4662-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B617C5AD2C
	for <linux-aspeed@archiver.kernel.org>; Sun,  9 Aug 2026 03:00:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hHjLx4YV5z2yXj;
	Sun, 09 Aug 2026 13:00:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1035"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786090640;
	cv=none; b=JIFvmQhS4dsfkbcXmzjuOvkG+Yp83fNDalULRRIHI6LEOcSxR3ThnnMkRI/eN9Iuoq3WoOODtip4V4nfnnOo3qB/xTLEQChtYjhbmsHcxyVZbj8mO07x6bfqvHjpqlM1rgZE5TCJ7leMswwgKgvbmaLrBe13lBp/kAc7usbOZDZ2X5M2eot5Y3S7DwmviCldsyOhLGqxNtpiMyz6NlsBzlO6uESfiqCYZ5IPz66ueMb2Ld+GywTNB0Ii492EifCelyLfzGi6QTOgxfkDi1ivDAxByVpjx81ezD8k4GHe1JZhxQtX0IhJeZ7YWvdcHsYLj0KkbqMeWqJS5oeYRlQgKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786090640; c=relaxed/relaxed;
	bh=PRtunFUAHa1sE6x3tYfwm8b9CkZHcpqXiGycwufdeh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gmDtQIaa27kpzLgIa8yK1QqHG0vDSpoMeOl+EtofB/XoiqlFqXzQgiHTL6gTefri2DJmj0ZZjEbzymnVIyXYz5PjRTarKGETlFgWznj4Z7hJcElRjSyevbg4rMZHKVNIHIRLcql4nHEcOjvBr31lOKSjDjM0lx3EEQxZqxRWH5G4cOFATNZbA5m9rl39/eLcjEWUBQ3DAti++Gxmusnb+jTqrnl2N/cyha9br0KDWiyDkFgNzCcXZAECFwq+TgNOx3zBeCMN4YWyHRxNjMNHRYLyWwYSJ9x4/G43PXsdyShm6yt/749mEMGJhBG6bFEG1Xt9V9SDJtAmjShFd6fSgw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TRV+0m+b; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TRV+0m+b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGcSv69vsz3bxM
	for <linux-aspeed@lists.ozlabs.org>; Fri, 07 Aug 2026 18:17:19 +1000 (AEST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-3811f512167so3735628a91.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 07 Aug 2026 01:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786090637; x=1786695437; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PRtunFUAHa1sE6x3tYfwm8b9CkZHcpqXiGycwufdeh0=;
        b=TRV+0m+boM3CmEjKkE6wQtWB86bzMjVnbJ1aY5VYJeKDLTdmStmAio2r9Qb6vsVD9Z
         c5HMGLw1XkgzrbWOAYrUmD1dp0YrzQ5dO0gE/PX4Dl+J2JZtq8+5Oyc+kPgJLb1bqIwQ
         OxePI/1hKIzajNDgdsA9XyJctk+F26oFT+YJPVyLsV/70jPoGJlUC+Fpq8ZKdLNSLTXB
         7DkYM/WzsK4dvCuKChmo+CkcLpO47HbYb0zbLn3TQIZDJcmMreAI38TuJM9dPYKLnV5G
         0QQgLj8MyqjuimlWvX7L8ObUwSDuMJLsFvwSSr6f8wgh/PmzPrgVFO1kGy80p7lmAjZb
         E+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786090637; x=1786695437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PRtunFUAHa1sE6x3tYfwm8b9CkZHcpqXiGycwufdeh0=;
        b=srVsBOQTMEXqKoBmvDvct2VFaihi1KiA1OEA3I8Q8/OVfy4KdEg9SBBVIr499pv6vp
         NZ/YgKjzA+CyiK07HLOXQmK5P8gLN1sUFheMaEJIWP1+s/bbxR6uzm/P+uUiIPOOWIxw
         rOv1BDD06Z0nbtC3LCzdkVxfdrJ61ASP3gs/fzA8i0MGyVCez1FlB7rePF6EbFauyXF2
         CCLSPFFb63X2OmkAaTeLgKaqPMyO4WJb5sXuQeIkHu3OnqjRHK5+vvQ6a1oFpSY/HqSI
         fsyfl1Kx+wISSRt4yxDcB+4WOIs7SQYy2LqPE/xFgERGv/ec6vUgd/ILCr7ChxgmRvP1
         RdXg==
X-Forwarded-Encrypted: i=1; AHgh+RpjIwJgC2tPBH4OPUdgy5EeVvF5A5tgcPt43YnpOh68IAR6Y+fRwWq0FPB0PucKQTsx6g8Nz78d5bQBpf0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzMaj/T5i/mGlgPqm2r7a6bHjMhjDnSy/bVCbCuYrmGPM3EVM97
	Cg60R8r5lhCuHwu7RITxXZdOmoD2kcvyDTMKEsB/h7MlK+MH+bC8tTNr
X-Gm-Gg: AR+sD10wcHuNGAJkQoW7necZqC0Q1pcI349WFPf776vG13W5hCS/bHCQOzXB2zbv1H8
	CpFAri9sskxR/5ZxLSL7Il8OdCbjV+/49fDvnZpuklzn4q3RnYBtDp3rmmaA3TY6T0mfyG0S8Lj
	1+DvcY0GtofndHIzSnMFLvjkI31Y97/eu+IHhGjef21UdPYePfMH5ZCo/hloS1oaAWNBbtDYoH6
	gtAfcei6pWAsObk+HNsID7oC2Gw94O+4rfQze3kn4e9Ho8P6cFUFNpFdZZjWyuj7Q/JaNvVKlC/
	+7hlwcBA6eF/AEBuLCHIRPHYlUJUw3DgSA3GeKM0MT9p1QYiN6ZVqhPdcALs7d0EYeJ1QnSR02X
	G9ENT0lgsX06P7xvK5zc5XbrzCdpDmoZPEju2AbRYqNecHQ5IJxKzstoa4l8ECddvVsIafy2ilO
	AACYpGoNUABY07W8RrwN54v5Zc01BExqgerDuOTAIW0q1lFWVxjAMggSdF101reMyccXLZxjswp
	aDnil4dZEUjbIlNEtwPFjiDi4s7kDFXHHaXptor9Hb4A+QymeZLSEIejU18mxD93cJHeWLRlncs
	KmXE
X-Received: by 2002:a17:90b:3a8d:b0:38e:57a3:f218 with SMTP id 98e67ed59e1d1-3903c5b9f70mr18650486a91.13.1786090637616;
        Fri, 07 Aug 2026 01:17:17 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085de8ddcsm3913377a91.6.2026.08.07.01.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:17:17 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 3/4] watchdog: dw_wdt: Propagate errors from optional IRQ lookup
Date: Fri,  7 Aug 2026 15:16:51 +0700
Message-ID: <20260807081652.38692-3-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807081652.38692-1-phucduc.bui@gmail.com>
References: <20260807081652.38692-1-phucduc.bui@gmail.com>
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

From: bui duc phuc <phucduc.bui@gmail.com>

platform_get_irq_optional() returns a positive IRQ number on success or
a negative error code on failure. For an optional IRQ, -ENXIO indicates
that no IRQ is available, while other errors should be propagated.

Instead of only checking for -EPROBE_DEFER, propagate all error codes
returned by platform_get_irq_optional() other than -ENXIO, so that
failures are properly reported to the caller.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/watchdog/dw_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index c3fbb6068c52..39031445d754 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -611,7 +611,7 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 
 		dw_wdt->wdd.info = &dw_wdt_pt_ident;
 	} else {
-		if (ret == -EPROBE_DEFER)
+		if (ret != -ENXIO)
 			return ret;
 
 		dw_wdt->wdd.info = &dw_wdt_ident;
-- 
2.43.0


