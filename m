Return-Path: <linux-aspeed+bounces-3792-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4816B10F3DC1
	for <linux-aspeed@archiver.kernel.org>; Sat, 28 Mar 2026 01:31:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fjKjC2N4Sz2yh4;
	Sat, 28 Mar 2026 12:31:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::431"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774649318;
	cv=none; b=LLWihEvB/B1D2w1oQMXJQGfRDpGhTxkRG/68nXshTI2hutqTGTe8vU4gyMRKvruKj87x86AsQxcSgbfMLwT+r7ymS117AK2FTOTMBQbdkEfEiCmLCBTk3xbJGJxgMqoqLuLFieUMmKwBO87XfgEkkpaLZJyhgTMWI0a12OSYiHvmtr5bnixV8pRTrfCdDbLxI8T/VT/SITB3kfY0aNEVNUOhS2bJhrml54mLByi48tqAL1G5Qr4mKfYMSwXqMJ+PHQN3nb0NI2hbLV3pXPgI93MviU5Yn3sHTUCTJKiKicjEe/C/sxK0jMbrb3+cFXfSimRblV2GDY7SpncJnXfa8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774649318; c=relaxed/relaxed;
	bh=F49vcSE/rqoVB2cNUPw8hx4gbICx0wrJC2VwflfBWVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aeRvVz9cwOLmwLLmRIwgO5b3mfkGJgT5Y9jq5MgG5NQ3bvznJVVGJdUaU0H5UPqq5taUUh5x5YVbs6FwU5W98Y7wQ2P46TAZrkUc8p5Pn69itUwTxSirKcnyxKEHQ3dXsmOvZSnVgvw/KlM4QDW5pTBwAEjv7vHGrXy0RnpdZoTbaa9PwrSByKXuIV1EsoZM2nVgYIksHqhPX1NRKm7JnM2GxIklZeV7VfFojKoOF38pikp4bQCrvSn/q65Ob1qQQq33w1ek6mIKm9m+Tti8XBCzvSRrUPawX8p97EDOc+KjwPTBbqn8I+fu5NE247OeRMeA+P/JEIY1ApaMaHcZNw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Lh0lSeBX; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com; envelope-from=devnexen@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Lh0lSeBX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com; envelope-from=devnexen@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fjFCR4Pkxz2xMQ
	for <linux-aspeed@lists.ozlabs.org>; Sat, 28 Mar 2026 09:08:35 +1100 (AEDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-439c56e822eso2749264f8f.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 27 Mar 2026 15:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774649310; x=1775254110; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F49vcSE/rqoVB2cNUPw8hx4gbICx0wrJC2VwflfBWVE=;
        b=Lh0lSeBXRIZvxvWjDR9yGbgqk2O4SeTT//8Y1ivj3IZjR0YOAkIAErAWxB5b/jV1c0
         J/twOeJb3kBmgJUyfGiBjKrkafOznZ5BDfSlqkSokJgtqildtgVFlwhxBvJgLcOh6NAl
         4VxtJLKPaBh2FRRcijbOKlfbn3Q195CaZBa4HkAbFKjlhba3/a51BOkObiVPi+WBgTrE
         TOMEPam0Co6UKPWh3cGy5aPGnFdYb+IpVkNGT4GvHBDbHquwNCTgpXuZqHpNUJQdZo0e
         zbWllG9pwSdobxkfzDQK/vKKKe9g+ycRf58Krv8M6WYI6C4Uu6EczPZTPgtctGgWH9ch
         j3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774649310; x=1775254110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F49vcSE/rqoVB2cNUPw8hx4gbICx0wrJC2VwflfBWVE=;
        b=BSai3aIrpH5VtCz2FH4O3ofHUf4A8VNLKLM1EfD22Me/Y3Op18PBad0sHqgwcHol3h
         Ab1fNzAs36Xw3liIB4kU+1Vwq368vR5f0Cy8IBUansr2S9lbU/Gdx9N8QA5HKr31lO8f
         VwhsfDYGjDzfOUclckN/gW6U84zmCgo7jHkugUd34Irodl/Ms1vnMu4Sqam2X/rTPkB1
         kF7gs93ZQsfg8TGODIpRzWOVvO26rfo7RasifKoYFI3p1xU3Nk6VdRLhSC90cd7MViAk
         N+9p81ukmYRQwgl3U9I9LEuoKAUpVXKVtLcrVXfAOwxG45PWz7tM2jNpv5pXIyftjT4g
         tQ/A==
X-Forwarded-Encrypted: i=1; AJvYcCWhBJmkjb+iL4WEv2acdAl0aAeRn+n6lORoq8xItyvtp5Ka4ydbRFxkuR/ZT91uBYZlw4DHKmTVRpG79ZE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw/U7ByXpCC/DK9BmhTuPBu8diyttjmgrcvrNxRerXaj3vg/5gQ
	yi0WJA8eoZOrJnSZfJHElVuwhN6Lvp8yeXHSJd0JQQ4yrhgYm/ODfNuZ
X-Gm-Gg: ATEYQzydBsAIoyFNPXy7LNZRfqBp1PIDsXBeXreAnWRdqNwirWzxfp89mcVOeEAM06E
	4nADhoMSHPzM2tdIfIDD387ejDfu/DECmiE/Rn/GNIKcXpPBoPO1KTL7P8Dq6J3sk4B2iBRTqDB
	FjWfLJvocjxALCBb/oo9pE2WZk0TfdrfZKyCQZ/oyclAjxVPDRHl1IkPGbdCxDwN3sC41HTzZpA
	+t1Y5eXbsnCKF31OJdTFweENwV3q1hXrbaZNtzcNfK7w+4xXGz36fPTMXvKfDsnLDMdET+fqOpQ
	bJJpT71/FjB6nh/Ae+gfAEAUVPMcgNuAXzudgpNXNJnXfe61HNM0OMoYBVlOyKJO7xzLoYuwSDJ
	EyAfIXDbNOTYh1ky4i5hWzmAsWWGsaTR2B8kIeFcJl6/SlTWdShL3KsKCp85VbgEll11mpK1zRI
	3BpzaYqLKTNCYZzmAggQgcepwO0L2MNLKp7iFpBdJFEn6ZEQNIuik6id8tBrR4kD7s1REZ9Vgvg
	u5lx+s0Y3vz
X-Received: by 2002:adf:f14a:0:b0:43c:f257:c6fc with SMTP id ffacd0b85a97d-43cf257c851mr576318f8f.10.1774649310249;
        Fri, 27 Mar 2026 15:08:30 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf245e4b9sm898900f8f.20.2026.03.27.15.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 15:08:29 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: eajames@linux.ibm.com,
	mchehab@kernel.org
Cc: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	hverkuil@kernel.org,
	linux-media@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH] media: aspeed: fix missing of_reserved_mem_device_release() on probe failure
Date: Fri, 27 Mar 2026 22:08:27 +0000
Message-ID: <20260327220827.266556-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
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

aspeed_video_init() calls of_reserved_mem_device_init() to associate
reserved memory regions with the device. When aspeed_video_setup_video()
subsequently fails in aspeed_video_probe(), the error path frees the
JPEG buffer and unprepares the clocks but does not release the reserved
memory association, leaking the rmem_assigned_device entry on the global
list.

The normal remove path already calls of_reserved_mem_device_release()
correctly; only the probe error path was missing it.

Add the missing of_reserved_mem_device_release() call to the
aspeed_video_setup_video() failure cleanup.

Fixes: d2b4387f3bdf ("media: aspeed: Add Aspeed Video Engine driver")
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/media/platform/aspeed/aspeed-video.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/aspeed/aspeed-video.c b/drivers/media/platform/aspeed/aspeed-video.c
index 41cb96f60110..a292275f6b7b 100644
--- a/drivers/media/platform/aspeed/aspeed-video.c
+++ b/drivers/media/platform/aspeed/aspeed-video.c
@@ -2343,6 +2343,7 @@ static int aspeed_video_probe(struct platform_device *pdev)
 	rc = aspeed_video_setup_video(video);
 	if (rc) {
 		aspeed_video_free_buf(video, &video->jpeg);
+		of_reserved_mem_device_release(&pdev->dev);
 		clk_unprepare(video->vclk);
 		clk_unprepare(video->eclk);
 		return rc;
-- 
2.53.0


