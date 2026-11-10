Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7375A606A33A
	for <linux-aspeed@archiver.kernel.org>; Tue, 10 Nov 2026 23:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TjDTpviF
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPMbQ2qxZz2yQJ;
	Wed, 11 Nov 2026 10:01:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::f2a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794286696;
	cv=none; b=nwu5WxPut+Q9WhLEOH4CqTL7goX7I9qbtEKoNyM+bHR9iCITlhNlL8C7pFj8mK/VnFn1YaIcEYxMX6Klt2z0JJogGHJ+INBU1CKa5VTsRaCYlXQtHLxCswfGr3KXa/L1QiKUKEJUy6gk1BdZ36Hmfepyij7gW2PymTwAdtGTuMjwmalkzgKkxnca0t8k/rz9wmZgqvBFkReq1JLUfnMt001r5qOdosyJQY2gmLbmBfvE7BSw40FECQMZXH0GJ+ogSCmJYZw0wtnbPnQLOBMvpAppZMH8X3Yi3gUjRRacW0Zyp7zYQglWHbhkRcZNtjsvE14AbwC+zwAEU5rsbkp2mg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794286696; c=relaxed/relaxed;
	bh=BF0zJDysZvAQi5ZREmGCFHRf3kxrNa2ATRxkO/XkHAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hZbbqG/K47AdjiYbxYu+6lKRllqH/nQbG/GiJ8yMbrGz6fKMEWPB2Z9xmkyIVnB4PtX7k5XJUnDyOSIeuJTw2UljoTcHNbeCGfv/anKRFKaMP96quFQBRNzhliH1UlGjvnyukMaXh9/ctMbwxfY8F7kpRZP73ZrVoaV4iH7jrq2rncf0WGEV7eb48p1TB0Ork8s2RE30rQCECe5WTmDT6Q3ZrFmTs1vFFPaO2k2ba8ybQ5SqSf//wZCAKX3I6iBME3IMIYG+H8yJlXBcByVEdRK0MsLilYK2KpviOAn57IjzpclVZA59sMxKQy7cnCGKpoSv6Zo7zBunBwKnxkPXJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TjDTpviF; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f2a; helo=mail-qv1-xf2a.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TjDTpviF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f2a; helo=mail-qv1-xf2a.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNvYM4H0rz2xnS
	for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Nov 2026 15:58:15 +1100 (AEDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-91eb7d147b0so7368676d6.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 09 Nov 2026 20:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794286693; x=1794891493; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BF0zJDysZvAQi5ZREmGCFHRf3kxrNa2ATRxkO/XkHAg=;
        b=TjDTpviFS0cIcvy6Xoc8xpgxLbkOgdRQYP2wmXXwI0rIxoVVITXh1Fsv8290o96ngD
         ukR4g4FsqWWApBlavu3bi6GOCnBLNd3Z624TjFoSjLxKmMFOixiQvSZx9NlNmWZ5yzFs
         p1RCmPqWUC0aU2gUAXXhhc+JNoAfKhGfbYXyXIrjxcGFijRpgc5jemBPLZjTpJF6kPZD
         6L48DnQZTv6HUnAa8ApPXYAN851laTjsQ0E71rMseU/CARGbFykz+oG3vOkibUL5VyGR
         s4bqq0r5qCceTNC+6xwI+9RqlWkzti4vaG71H/Mfymga1Cx+c10ejOqxGPE58Iew8KLS
         gq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286693; x=1794891493;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BF0zJDysZvAQi5ZREmGCFHRf3kxrNa2ATRxkO/XkHAg=;
        b=0bL+9/VXmt+I2dHkpL04vyESRcRcOnYYBEDF+kj3gZ8U39WWDpzfgWKynt4H2tJOVc
         nLj9I7W153t7ESMdPnLSAZ1goRN0A8Xdtd11mNGzAJ+Ij4M17Q+1pnDgxwYYAjyOt7aA
         1eYs8Pg01H2LoCPhIPCzy8Y8YkYmWLB68ptzFWLUumFo1/aiXLV970zb5W9eWKu07cdH
         CF1SFBFsSRuDXuNHYRLjUUGqvVbuaz2TCjqUzy8kcABsSDav7SFKxCM8Fdjne2tp3cuv
         K1aqB3s6+gmra3YMlHvHXdqnEXvX54q7IuqMa0PgDZDycV8FUi6HHoMnu4S+PUCJduvN
         7gOQ==
X-Forwarded-Encrypted: i=1; AL+hErHKBwiroJlfWDPm265/S15nbafCHm7R2Sl25+24aAWFwzhnG+dpkPy8vTcl6fbCWeIe9/tR4bSo3aqLY6U=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8szc2GxGI+aOckLZaLC8YtXzIwmAnj5b38TJqQryk4T2lleXhS
	41a5eyrFEjOP7/pRegNpRBVN1SQiG1ZvlRz3Mhf2mpOW+0VQ2EmVTaxBCCsjwNw=
X-Gm-Gg: AYBFou18LzlZAzlUL9wtyuP/q9w26SSE+Mh1ZH1yZlBBvW9hzqkVpwPp+RJBo30rsTR
	ytmTu05B6wNogftV3qvGJ4y9Rn+ueFVEGHD9sQ82ydtFqhoZ8Yk13GrqtQ9sVHcxjFqtP47QkFV
	rneKcjk3xkzZcy577ytVbfwe/vODaFZ+qd8mRij7V+tSBvWkmp9mxX5Pub9EezvEuzC4KtZTs6+
	/9Lgm7Io/lhMomgNMsmQedZwDTzJppOpWU3cXC1MOpFK7rTKPmjrBNAVbEnV0fLq/Iw2yHXfzIk
	MC5w0tw6uoGg8zp4L14PcjepgdUhduLOjTsSBWOtqs+W8HDWg+GcWbJMdf5BHBUzTHSceC+XopT
	Xb4AH38jggfpLfY2+d9NZdTjYbyuP+MIBtgGlqel0GDe/RBxpVP/qjAfee7Ca0YwWAR2KsBgHK6
	814O6KCkT5OK9joqu/epClimis/0Vc1oSnUooxw/0T+WBfhKM+36oox63r8eT/6xJcciDUDf90P
	Jdgf6UmqX2hYLS2uKhEKQnw9pN+P9bJmnXZUXNon6TDDcqlPDQvXkchbq+231n8N0FMLah+yUFM
	3hw3CTbM1nSnDnEWksr0Cp4CWonMqSC4Y8UhSNzvb+l3FfJ/APQq8vLwpqfifXHGIvWZTlghUSW
	YLqRMptBg7/2id29BVF/Eaeq1JIN/h06KbE0EKOtexNWaYoH89tj6lLr9umhJIMs08YzXimIOdg
	gEccC9W+1+/Q==
X-Received: by 2002:a05:6214:85c7:20b0:91e:9ab9:bf37 with SMTP id 6a1803df08f44-91eef88a091mr21824886d6.14.1794286692755;
        Mon, 09 Nov 2026 20:58:12 -0800 (PST)
Received: from localhost.localdomain ([104.39.152.7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef04f89c1sm12462836d6.23.2026.11.09.20.58.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 20:58:12 -0800 (PST)
From: Myeonghun Pak <mhun512@gmail.com>
To: Eddie James <eajames@linux.ibm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Jammy Huang <jammy_huang@aspeedtech.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	linux-media@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH v2 1/2] media: aspeed: join IRQ and work before probe cleanup
Date: Mon,  9 Nov 2026 23:58:08 -0500
Message-ID: <20261109235731-aspeed-v2-1-mhun512@gmail.com>
In-Reply-To: <20261109235731-aspeed-v2-0-mhun512@gmail.com>
References: <20261109235731-aspeed-v2-0-mhun512@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The setup failure path unprepares the clocks before devres frees the IRQ.
An IRQ handler that has sampled an enabled status can still queue
resolution work. Masking the source does not synchronize that handler.

Save the IRQ number after a successful request, then free the action and
drain resolution work before the manual JPEG and clock cleanup. Turn the
engine off after the work has finished. Request the IRQ after reset,
clock and JPEG initialization so earlier init failures have no live IRQ.

Fixes: 3536169f8531 ("media: aspeed: fix clock handling logic")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
No hardware testing.

With reset-default masking, no probe IRQ failure has been demonstrated;
this part hardens cleanup ordering.

Changes in v2:
- Join the IRQ and resolution work before manual probe-failure cleanup.
- Rebase onto managed reserved-memory initialization.
- Clean up JPEG and clocks if the late IRQ request fails.
- Split normal last-close ordering into patch 2.

 drivers/media/platform/aspeed/aspeed-video.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/aspeed/aspeed-video.c b/drivers/media/platform/aspeed/aspeed-video.c
--- a/drivers/media/platform/aspeed/aspeed-video.c
+++ b/drivers/media/platform/aspeed/aspeed-video.c
@@ -308,6 +308,7 @@
  * perf:		holds the statistics primary for debugfs
  */
 struct aspeed_video {
+	int irq;
 	void __iomem *base;
 	struct clk *eclk;
 	struct clk *vclk;
@@ -2232,14 +2233,6 @@
 		return -ENODEV;
 	}
 
-	rc = devm_request_threaded_irq(dev, irq, NULL, aspeed_video_irq,
-				       IRQF_ONESHOT, DEVICE_NAME, video);
-	if (rc < 0) {
-		dev_err(dev, "Unable to request IRQ %d\n", irq);
-		return rc;
-	}
-	dev_info(video->dev, "irq %d\n", irq);
-
 	video->reset = devm_reset_control_get(dev, NULL);
 	if (IS_ERR(video->reset)) {
 		dev_err(dev, "Unable to get reset\n");
@@ -2286,8 +2279,19 @@
 
 	aspeed_video_init_jpeg_table(video->jpeg.virt, video->yuv420);
 
+	rc = devm_request_threaded_irq(dev, irq, NULL, aspeed_video_irq,
+				       IRQF_ONESHOT, DEVICE_NAME, video);
+	if (rc < 0) {
+		dev_err(dev, "Unable to request IRQ %d\n", irq);
+		goto err_free_jpeg;
+	}
+	video->irq = irq;
+	dev_info(video->dev, "irq %d\n", irq);
+
 	return 0;
 
+err_free_jpeg:
+	aspeed_video_free_buf(video, &video->jpeg);
 err_unprepare_vclk:
 	clk_unprepare(video->vclk);
 err_unprepare_eclk:
@@ -2341,6 +2345,10 @@
 
 	rc = aspeed_video_setup_video(video);
 	if (rc) {
+		set_bit(VIDEO_STOPPED, &video->flags);
+		devm_free_irq(video->dev, video->irq, video);
+		cancel_delayed_work_sync(&video->res_work);
+		aspeed_video_off(video);
 		aspeed_video_free_buf(video, &video->jpeg);
 		clk_unprepare(video->vclk);
 		clk_unprepare(video->eclk);

