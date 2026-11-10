Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB17A606A31C
	for <linux-aspeed@archiver.kernel.org>; Tue, 10 Nov 2026 23:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FShKVU64
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPMb74m33z2yLY;
	Wed, 11 Nov 2026 10:01:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::736"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794286698;
	cv=none; b=IrlIH/7MJak/1aGzSHL2y1Z/KjL3pAzVzUQmYaWZ+ii1yL6gxUJ/6UDzctFVJSIfj3AGAp+S6CMnMBf2fdfNTNjRoOm2MyC903s3I/fMlmSeikMNKylIWfk4WDpGSYXLDM5PoEW3n3O1sfkwAZEXFkN6eAbUtKOFb5gQVQ/l8S7Po/sEwxMrwhV4zC+cdKTUbrpCR6NlQ/IlI8oq2vT1tMzSwzon3QHQ7zybxbCdTldBF0csk7DB3cU0hm8qrqyJdlGryf9fUlzIG7DxD4pFcBCwvcv/yxJYboYShr6xrrMk49I4wPEFnIIdrANIF8wlOdGViNl1I5MK2V4kYzjJog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794286698; c=relaxed/relaxed;
	bh=33/y7FEbAJRMpWgPc6HOmiquLc0W6X+Eem8um5Z3JJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lHxm3tzBe48GuZ20O069vYN8qqTfDselV569bL21vXG3st0GvlknSdcxCbFaO4+PI8IqjSPgI4cnDpvA8C6YWIw5OHw1anRKUJPi1ybT6zZiKFHkbeYEos0eNHa/bUXnH4wbwgjcDi1nR/xTb9+toaRAjmpLhIOjTfTGowvtJwApihbSnqBZafUZioxeBsIrvUADPqNiXgV8T5O8gL728V3MG2eR1YFiGrdVqF2So6DOI8k735SalojvEkcgk6THLmDgGOoKjT7XgDYgZYGiaYZr0mQSKprybzUktHft6smaxgXPC5yzR09dPiaXJIWYsW5u1zuSLOHCimYd+x8zKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FShKVU64; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::736; helo=mail-qk1-x736.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FShKVU64;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::736; helo=mail-qk1-x736.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNvYP43rVz2yR1
	for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Nov 2026 15:58:17 +1100 (AEDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-93f3c8958d5so179761485a.2
        for <linux-aspeed@lists.ozlabs.org>; Mon, 09 Nov 2026 20:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794286695; x=1794891495; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=33/y7FEbAJRMpWgPc6HOmiquLc0W6X+Eem8um5Z3JJ4=;
        b=FShKVU64FW4AEdR4AOMqKLfYRr9dmV+OS84VyKRZ9nI005DL4AXuWkI3YzAzbqNpmN
         iuvrDZaH6t5mDG7cLz7ag8z98wuNkmh8Ei+H0oy2RA1jdN9480fk8NHX2Zb9gDa14Arq
         9QpzRBaptj+QnR1U3WpvKDm9PVzn3nyG+yIXce7DfghlRhBA1rU0q5lOyKK8PT4Tozwq
         CZXfHmntmzLmsvyz5V3FhuvoFtSyvik9Kl1cFC8pxA5N7mWb+zzSDOu+klYm7Us90HpS
         +JEcOFwX8SdLIqrxZz7UsBGRAUjRSkcbm9qda2bZR58Wcsd2e73FjegqBzundVlF5M0+
         5X9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286695; x=1794891495;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=33/y7FEbAJRMpWgPc6HOmiquLc0W6X+Eem8um5Z3JJ4=;
        b=2zvEfs+Az1wjocPW2kFLUM2LKrO4X+L5SREdNu9Vhv/2ubvtJmPwUBjjXosmJk2N03
         6Ez2AlUpCCzpXYI8cSMZ4dWnLeJ6Z6rDV4oj8UEeciyurCpt4o6tE21ZQYB4VW/7Tqh8
         Uq3kRGmUeFnKkRmX5p7hmsHddsK53JwZhyP8AMSi8/Bcqe/iCq7gY8/zeNyurvft0sNQ
         wIw+lSFb7utXyZQ0RXvIKhI04ls4ZV/JFoRQklradJcno9rCLwYb3eVZ+GRO4m+TOgCD
         a03rNSVevDMUObfc/DEfEpL7Yhliky4dEbwdAXBIvSIEziUo+Ymbs65BgbXTprmlOdeY
         H5TQ==
X-Forwarded-Encrypted: i=1; AL+hErFNMOKJIomVZdU2lqwF1RxO8VczyyPN0mfG5b8+cTHQtKv7GMOlG+hjBOhzb5KlfHbvVGrPhKiO6m4oETI=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+3RMTZadpBQWwVDLaFM6npF7mhMFaqfb1Gl+BKKSfDYqvZDhTR
	zfrrQlYIERPFEDL0Jb/WQy54XNCf0jZz+PSd5JwAfrT4VYZ5onugxPI=
X-Gm-Gg: AYBFou1tpmQECAWy2CayjeZU/Lkn2iAVJIcZ6HV/p2ex8NuCJfjjMCIjHlzB+OwjDhU
	HZG6roaEIQfr8dQ6JJcd4LPc3/vxnQ1bBLAHNNj95RnA5Blm3LddhUkskLAAYCZ+6P8evllVRV6
	wOaBKU/vKQSC0l85W2ZM2tcvI0swjMPUYgG43DshjS5SPhOvI5fKvEj+lWIfdHniI/IlL4eBuq6
	nLZ6vt5ndCg5UrNTe7X0qRgBTIgfGhTJ8+gQCDOBjIOWbsS5UiQq7+0mgZarn4Iow+TSiE0cbWv
	zZwcT6PM85tYVsfZ0APubB5XGxUPlYoebq96acEmc97LOEAz9RjmhNFrdgLLbw9s20Jo6WwuN/m
	MuvTb03ZyPanEC0t/oOoYxJQ5D8Q8vaVkK/y2PHplwo46ZW37NC6V2LKNEDXIdVSLhZRV2hI8RJ
	GK5GGJN2yM2pvXFjDUjaHaHsgV8O1kviGSZKEkaw3oMX/4ZvrZcaSufjaUCyachqYQHpB4DGd95
	FxyKVyARJm8Z7c+Jn0u1dAzpKAwiV0V3hDjKOLzuUCe/wjqoEZ9fcX6vLU9Hso6Qz1NwCvTWl9I
	wT62ehv6Pp5d5kphaxEhMf3ru+Y6emlxAaV60ew9pqzdl39goHShzjiKPiuLUOdWlCBgYQHUeCD
	mkWyRWUR+9H5F9NMk5qR+54kDJ4UbI4jtqoil+FyhEJz0Le1GnQF0Wl3JGgxQwrwyu3no/e9IO5
	mlF0fo+3bqUw==
X-Received: by 2002:a05:620a:2614:b0:947:8018:978e with SMTP id af79cd13be357-9479f22d879mr260742685a.6.1794286694660;
        Mon, 09 Nov 2026 20:58:14 -0800 (PST)
Received: from localhost.localdomain ([104.39.152.7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef04f89c1sm12462836d6.23.2026.11.09.20.58.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 20:58:13 -0800 (PST)
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
Subject: [PATCH v2 2/2] media: aspeed: drain IRQ work before stopping the engine
Date: Mon,  9 Nov 2026 23:58:09 -0500
Message-ID: <20261109235731-aspeed-v2-2-mhun512@gmail.com>
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

Last close cancels resolution work while its IRQ producer is still live.
A handler can queue work after cancellation and buffer cleanup. The worker
can then turn clocks back on after stop has cleared VIDEO_STOPPED.

Release the VB2 queue before shutting down the engine, since streamoff
can need capture and mode-detect interrupts. Disable and join the IRQ,
drain work, stop the engine and free its buffers before re-enabling the
IRQ. Check VIDEO_STOPPED before enabling clocks in the worker.

Fixes: d2b4387f3bdf ("media: platform: Add Aspeed Video Engine driver")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
No hardware testing.

Changes in v2:
- Split normal last-close ordering into a separate patch.
- Balance IRQ disable/enable within stop; add no reopen state.

 drivers/media/platform/aspeed/aspeed-video.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/aspeed/aspeed-video.c b/drivers/media/platform/aspeed/aspeed-video.c
--- a/drivers/media/platform/aspeed/aspeed-video.c
+++ b/drivers/media/platform/aspeed/aspeed-video.c
@@ -1423,6 +1423,7 @@
 static void aspeed_video_stop(struct aspeed_video *video)
 {
 	set_bit(VIDEO_STOPPED, &video->flags);
+	disable_irq(video->irq);
 	cancel_delayed_work_sync(&video->res_work);
 
 	aspeed_video_off(video);
@@ -1438,6 +1439,7 @@
 
 	video->v4l2_input_status = V4L2_IN_ST_NO_SIGNAL;
 	video->flags = 0;
+	enable_irq(video->irq);
 }
 
 static int aspeed_video_querycap(struct file *file, void *fh,
@@ -1847,11 +1849,11 @@
 	struct aspeed_video *video = container_of(dwork, struct aspeed_video,
 						  res_work);
 
-	aspeed_video_on(video);
-
 	/* Exit early in case no clients remain */
 	if (test_bit(VIDEO_STOPPED, &video->flags))
 		goto done;
+
+	aspeed_video_on(video);
 
 	aspeed_video_init_regs(video);
 
@@ -1901,15 +1903,17 @@
 
 static int aspeed_video_release(struct file *file)
 {
+	bool last;
 	int rc;
 	struct aspeed_video *video = video_drvdata(file);
 
 	mutex_lock(&video->video_lock);
 
-	if (v4l2_fh_is_singular_file(file))
+	last = v4l2_fh_is_singular_file(file);
+	rc = _vb2_fop_release(file, NULL);
+
+	if (last)
 		aspeed_video_stop(video);
-
-	rc = _vb2_fop_release(file, NULL);
 
 	mutex_unlock(&video->video_lock);
 

