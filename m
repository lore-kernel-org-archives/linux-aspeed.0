Return-Path: <linux-aspeed+bounces-3811-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F38041061B18
	for <linux-aspeed@archiver.kernel.org>; Mon, 30 Mar 2026 22:51:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fl61l1kcsz2yhD;
	Tue, 31 Mar 2026 09:51:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774697020;
	cv=none; b=IZpc7/R9GN/+1asx2ax2+TEgH0sBN141tj5AAvJRIm1rOhkfRBG44OZqpwx2Y0Wce2QOCJa9HGJSpDK2wuph+kNy1M/JtabXEjjIH7xtGvIIZQ3cWCFpq0tumkTXmDLJkGWDYCMVHbFKeUG12NrTmRXPyLtkLxAoAwYvB3/1rz08FU372GMbMjvIWHKCYnFDGhCP7lgyr8bwi+tgdiZVU4K4e1kZZd2ukG6jpSbYkAKLxfpnbGeWGncBrXM+lKenPlugCQArbhiJ7cGjMWqBVNNNIv8a6w0qlpdyJ5OwqX2exFvXzEVfHkwjHhLWxm3acm/dXJSWBuKJ+dCctvsruA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774697020; c=relaxed/relaxed;
	bh=6LWhF3uaArkhQK+8SH0+E8r9jK9foFcw9lUUPANL8Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YFmVMzuaK3DVQXXOt3DSPzYgT91vf8uH2K6VruXm3veHmVSzfJ3Pu4VQksIF4OgiuJ4egFOxmJDESpqQJ2zjXWrNwUOwZURlioEQiiFFftUegWB/waCq/HgDgO5/F5k7Jh3zu2cpR0/xCfdtLCv9MaecdJpnGraAZJ3Rr+9tTixXCxbJcJ0TnFXewtFGLCdjwzf7sCWDwMTyLRGzP4VqfMipBFIwMEWvxuK4tW2Ee7YGoLRqhnUqUEf0zMWff8eSYCuwGUmoURRuG3HHzOfhSs1oi4DQRVyztMXuA+IapCv0hRX5R5ppk25/4n/+Mxe5GiU79sy78/PEJgV+A0A59Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D02qX3qp; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com; envelope-from=devnexen@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D02qX3qp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com; envelope-from=devnexen@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fjZrp61Z0z2yfK
	for <linux-aspeed@lists.ozlabs.org>; Sat, 28 Mar 2026 22:23:37 +1100 (AEDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-486fe36cfabso20129525e9.1
        for <linux-aspeed@lists.ozlabs.org>; Sat, 28 Mar 2026 04:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774697014; x=1775301814; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LWhF3uaArkhQK+8SH0+E8r9jK9foFcw9lUUPANL8Bg=;
        b=D02qX3qpLZgSZR52hSmutggyX4j4QW4OWdL0ncdarUmsF0nsUFuYjZynQ/98VVqvJ0
         7nzpgWycJ2EK3RAUfFp4Z5OFM4An752zzl8jGiXxPqJfZ2CsuCNLhk5JtCfX6tR/3LAo
         ofH3B96cOKFmsZbD6+wge4wtX7GHxvYEz0uVidjjr4i/Sr+d3WJEyKzfQ+TnMrMhBFPU
         KKz0myULL7brxFlfoM7aRFNdAZSY92lZvz+IWTUfdcmcWZsn1/8ul4MJ3l3y4fnBHU+4
         F1h9xMMqM3/acBCZsJ/ffDXDTk63Js3Cy9Hm6aOAyLZ162ebbfqvJ1623ofR6ZxEDGNB
         SfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774697014; x=1775301814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6LWhF3uaArkhQK+8SH0+E8r9jK9foFcw9lUUPANL8Bg=;
        b=AGV22MJDN1ZOYT6DB3ZP9PYYV5cfPPSJWwWP5o3OO0b4rOEnvi2GfVvjoI7A82/ZqS
         nrUWdS+UYUfguo9OPP5YvEAKxd7oz/40uWtscKp2Mns1EcIDVoOsJnJZf6H4gX44KGFr
         ikGv+qQGWk4TB47Lz6+RxiDHIWxzRaH6lkDc9rXAjBBaa6eigbOiwNr6Pr+eeCCrAND+
         QG3rWgpZGUJRrn2jAXXKNPsJd0qQrKXsllp7HjxAjpElxCBfVFIju3LCkDzx/V86BxAZ
         qOcPET6oSS5gt5QTfwDsdVQER0fYNIvtVxazSQQcl0DfSTmyBFPcRF+wTXcgNDHtMa4h
         QN6g==
X-Forwarded-Encrypted: i=1; AJvYcCX2u1FXn3qFcyEfFCc3XLnLtr7CThhj2nEHjlD6bivR4Yv20DDj2aPQF47z/z2TBXRzUIP8hwIEFL9Z96w=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw73bZwj+pZXsFE8JOhkjlIcUjIq8Xkr0y939qQ/f92dMkXxkZ9
	NzU1NsiDM2VniSr4EKocKA83iLq+Kwm+V3b9gDyvzdPsArTUuO5P2L1c
X-Gm-Gg: ATEYQzyFrhrrissDAxTExCVqegKlt4OWoPGlPAsGDYvGZmZw9jkaKrDnsZRGPv4zS2w
	i/3k7K3Wmln7O6dEr4draRCr62ou3Y6g7JvcUD1uCJ19oS+umwFVwaFyNpz92jdpoGXPQC9uhtY
	1DrSugxoLwQlQi5qbEcWJ1Fe/qh6S75yOu5CJJEti8mlXoYIok4IiSAN77kP92IyX6Cal+4/2FG
	G6rMAgUdKPZ44Xcs/l4hcqCabSim8JEZp5JlupBnVdjTDdTAdqvGWuc+wDakQFNxZkqUwm7PB7z
	Mteq6JvJl6zT/d2gBYpZ3tEhuwv4pwaryMqD6UpoHCVhRYpD+nWgwh/wMX7CWOR8X2Oztt3PVOj
	vsz6CKmdKwKKPUI4y4jkJ/sRmQzV3N++DQS3K2BZlSi5rLP0sKB2Ovu0MxG8EgiTPPyjfSib3Dy
	8UCC+KN2mUwyvqffKVKyU2rt2ItnH3lzG4x+Dfe49PHCj6qbhG86Wy8YwPBfKW9LoN1rbhibbWE
	YPVOO33kUmRfoC8Ei5Wt+Y=
X-Received: by 2002:a05:600c:6986:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-48729109c35mr80167305e9.11.1774697013685;
        Sat, 28 Mar 2026 04:23:33 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487305da785sm41491685e9.0.2026.03.28.04.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 04:23:33 -0700 (PDT)
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
Subject: [PATCH v2] media: aspeed: fix missing of_reserved_mem_device_release() on probe failure
Date: Sat, 28 Mar 2026 11:23:30 +0000
Message-ID: <20260328112330.50726-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327220827.266556-1-devnexen@gmail.com>
References: <20260327220827.266556-1-devnexen@gmail.com>
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

Fixes: d2b4387f3bdf ("media: platform: Add Aspeed Video Engine driver")
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


