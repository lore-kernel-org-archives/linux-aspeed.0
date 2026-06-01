Return-Path: <linux-aspeed+bounces-4154-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94733CD5BD1
	for <linux-aspeed@archiver.kernel.org>; Mon,  1 Jun 2026 23:51:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gTrMw0nMCz2ydQ;
	Tue, 02 Jun 2026 09:51:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780318348;
	cv=none; b=PIViIHdncDXGxsPDF31Keg5NRSHVECeFJQA3UpQQOnY5HjSr4xrpdDCxQOYxqdbGAwYxGebZkaytDYe90xsT2CyQcNKGYuhIK/iemnDryAg98xp2rkaqPKqavQtvslM95Ls2n2ovtxN3LbaFPB7rxuJ9BQUqot1fXgwMe80Vmxn8OmlBkxdNP3TRQMWPtPVIis2mFu12uBHqoQ1doLALMwV6fg+IuIW9YHcD7RB4HAjGwg5tONLDd6S4nY8VC3WAFUHfJHMlWLca4u9JmwmiAG3VqGSHpOpKyatfI4gtLCJB0iqMssWbQo4gPWgB8sGcuPqLLmvL9Kl/dkxnkBM50A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780318348; c=relaxed/relaxed;
	bh=JpFJ2vgllIWj4FqG6DXjRM527rlfnB9NVugM5813YTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PgW5MRJ5P9Ic8XZ3NHCqfWqAUAVv8njCNtn5lxO7r9LE8Rqe1yoq9mDJbCjlXwEe++lqkVZt+AM/Z0HVAnddIm5hBrRSW2s3vLC3CIk+pQvQtAO/cBkpoutWPVGiN0BgKTtYRL5g6FDmOCqcbBwpHqLPY4wWhsY7q1r4rrpkINr6e5LnoHL1EhoHl/hGPYidfVYxA155IaAZdQbuEolhtsrCnPNDQogPOu/4o7a8BYNraxzB8tefyGdDt4f1IZMb/ieu8WmDUT2B9l0a85sbAR+X4wxFnmkJ2tHPpASXDA3vNj+A2cP6GZUgFXASe25H0ctWC9DG0t0MUYF9Z3i9ZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rF0IR+lr; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=karthiproffesional@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rF0IR+lr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=karthiproffesional@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gTYlH1k6Pz2xdh
	for <linux-aspeed@lists.ozlabs.org>; Mon, 01 Jun 2026 22:52:26 +1000 (AEST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2c0b944f6edso15148855ad.2
        for <linux-aspeed@lists.ozlabs.org>; Mon, 01 Jun 2026 05:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780318343; x=1780923143; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JpFJ2vgllIWj4FqG6DXjRM527rlfnB9NVugM5813YTM=;
        b=rF0IR+lr4UMhb92Km+BQWc5g22OLOrbSKN0HA7Zre7jf+2hpLNp/RzuPyS7nkopaC1
         VOTryWoP0uJyqRnVGbpx5GPAcNxe7jp43c8406F1Am/Tm0nyvNq8F9gg4ztdntYXABAT
         p11as59znymPAOZKZNQEicoCP2C5g/9LOlFWzh4RiccxnQK6m8PQFngwxELAUKx3VtyU
         khMtzrexPdbrNTskVOKHecOMov1OsWoM7C3NktEy7WuE2AA9nN6nOp4Z+UrBB2sgjkh3
         +DzyNV7hPcYTdRS1Ka5DltXWamruu/cUUVJ5S2b2ikzei43UWuk7cflyGe8gSwKRYjIC
         BbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780318343; x=1780923143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JpFJ2vgllIWj4FqG6DXjRM527rlfnB9NVugM5813YTM=;
        b=Y0WsuEbjJBOcT88AJMUECufDBfu70uPfFC++SCzJ18WqsgDA0mlrvd4aXQxAeRYmkd
         /wFW2/rDIqaCmMfSy0aAUgOghkcae+yEYFXiGFXPvp5Ghd3RiC+ZrV24OXO9RpwTx3r9
         8kCVe3iKyT7jfO4fvBZfEL7fBh6qNywMYIXKnTjXTcnbIGhIctURr4wR2jxrxW61zuz2
         oOdI7canS10elZdOd0BcLbiNqZ4HUy3H+oQRI1rBVRXYMmNUqGL7RsazofTfbJcMSGd9
         InfoOsHT/11jBmuzPB7L+Soa93fI1DkGUS1N6qoFhu5mcf6mB5kDu3D43VguQ9218tl6
         wZrg==
X-Forwarded-Encrypted: i=1; AFNElJ8+FCL7yYyEJn3gE1hHYDrkyDh/pj4t+2OGfr7/aodWADfl8o7xoY5vCp0gSmrvwzdV+UTUxzLzeX+0zWk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwFuT2mDVSoB5PBP1oTu0mzdijZGUOQ62e8h763VNTNVRayC+bP
	ufPRkWmvcaTLHHZXyzCGuU6FEtcOYf38qW3U+LRvEvVMtLtOUATiF9gz
X-Gm-Gg: Acq92OGd5FM/Z8z9sFZukCro76ioM7bhCCrQAZrO5PgSCYL+KnCSlKZR3+pe4dKMcp2
	Ctp1Wn+2cGCnUwONsB7B8KWMa2YpmDnYgAxXd/4g0bkOQBZszygyWib4Q6jbWkt3Gh6s3Va+jA/
	zdybmHkMLGQGC8as+h/iVxwjyAFC+NFG0u4IjuoMlNGK0VSsD1dKGA+bbP1SbOw3HH6WkaSth74
	PCuf7BTS3A2/f8teQtTEPXn/p6PmMLEMJn+T2Y/SYPwHiM/oEwC3wfe20jIHXccgylS/Uip8P6z
	jaMd6kPuBNInKBO+WaaK+oXYAGUAumjSYxirwBLNsVxLce9NS0X3eUMjPqu3u1Tkj54ixz3xNhJ
	uvryISm1x5EkgLY6oGPEzTUc5ZFcJHuu+T+t3pslnUgHTJ5BafAowCGXtnoSXS3LWxVWq3eH737
	4R+Tdg+q8DiZgxMDpOKSztfPNyTpPr988n3go+QRPzw3cXe3y++IL+KTZje9hJ3CRdwbY=
X-Received: by 2002:a17:903:1905:b0:2bf:281f:19ec with SMTP id d9443c01a7336-2bf36803dccmr130037915ad.24.1780318342942;
        Mon, 01 Jun 2026 05:52:22 -0700 (PDT)
Received: from LAPTOP-97G9G880.domain.name ([106.222.200.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf7b6609f5sm85932415ad.60.2026.06.01.05.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 05:52:22 -0700 (PDT)
From: Karthikeyan KS <karthiproffesional@gmail.com>
To: andrew@codeconstruct.com.au
Cc: joel@jms.id.au,
	andrew@aj.id.au,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Karthikeyan KS <karthiproffesional@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4] soc: aspeed: lpc-snoop: Fix usercopy overflow in snoop_file_read
Date: Mon,  1 Jun 2026 12:52:13 +0000
Message-ID: <20260601125214.2071019-1-karthiproffesional@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1e2b77c7916259e3e269d19f637c29427c175350.camel@codeconstruct.com.au>
References: <1e2b77c7916259e3e269d19f637c29427c175350.camel@codeconstruct.com.au>
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

put_fifo_with_discard() acts as both producer and consumer on the kfifo:
it calls kfifo_skip() (advances out) and kfifo_put() (advances in) from
the IRQ handler without synchronizing with snoop_file_read(), which also
consumes via kfifo_to_user(). On SMP systems this concurrent access can
leave (in - out) larger than the ring buffer, so __kfifo_to_user()'s clamp
to (in - out) is ineffective and kfifo_copy_to_user() can attempt a
copy_to_user() past the kmalloc-2k backing store:

  usercopy: Kernel memory exposure attempt detected from SLUB object
  'kmalloc-2k' (offset 0, size 2049)!
  kernel BUG at mm/usercopy.c!
  Call trace:
   usercopy_abort
   __check_heap_object
   __check_object_size
   kfifo_copy_to_user
   __kfifo_to_user
   snoop_file_read
   vfs_read


Serialize kfifo access with a per-channel spinlock. copy_to_user()
runs after dropping the lock, since it may sleep on a page fault.

Fixes: 3772e5da4454 ("drivers/misc: Aspeed LPC snoop output using misc chardev")
Cc: stable@vger.kernel.org
Signed-off-by: Karthikeyan KS <karthiproffesional@gmail.com>
---
Andrew,

Thanks for the review.

> This seems inappropriate and I expect is flagged if you compile with
> CONFIG_PROVE_LOCKING=y or CONFIG_DEBUG_ATOMIC_SLEEP=y

v4 drains the kfifo into a kernel buffer via kfifo_out() under
the lock, then performs copy_to_user() after dropping it.
(cf. drivers/gpio/gpiolib-cdev.c, which drains under its event lock
and copies outside it.)

> ensure you develop, build and test on recent releases

Tested on both v7.1-rc5 and v7.1-rc6 with PROVE_LOCKING,
DEBUG_ATOMIC_SLEEP and HARDENED_USERCOPY enabled: read path
round-trips correctly, no lockdep splats, no atomic-sleep
warnings, no usercopy aborts.

Changes since v3:
- Replaced kfifo_to_user() with kfifo_out() + copy_to_user()
  to avoid sleeping under spinlock
- Rebased onto v7.1-rc6

 drivers/soc/aspeed/aspeed-lpc-snoop.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index b03310c0830d..0fe463020e25 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -74,6 +74,7 @@ struct aspeed_lpc_snoop_channel_cfg {
 struct aspeed_lpc_snoop_channel {
 	const struct aspeed_lpc_snoop_channel_cfg *cfg;
 	bool enabled;
+	spinlock_t		lock;
 	struct kfifo		fifo;
 	wait_queue_head_t	wq;
 	struct miscdevice	miscdev;
@@ -115,6 +116,7 @@ static ssize_t snoop_file_read(struct file *file, char __user *buffer,
 {
 	struct aspeed_lpc_snoop_channel *chan = snoop_file_to_chan(file);
 	unsigned int copied;
+	u8 *buf;
 	int ret = 0;
 
 	if (kfifo_is_empty(&chan->fifo)) {
@@ -125,11 +127,22 @@ static ssize_t snoop_file_read(struct file *file, char __user *buffer,
 		if (ret == -ERESTARTSYS)
 			return -EINTR;
 	}
-	ret = kfifo_to_user(&chan->fifo, buffer, count, &copied);
-	if (ret)
-		return ret;
 
-	return copied;
+	buf = kmalloc(SNOOP_FIFO_SIZE, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	spin_lock_irq(&chan->lock);
+	copied = kfifo_out(&chan->fifo, buf,
+			   min_t(size_t, count, SNOOP_FIFO_SIZE));
+	spin_unlock_irq(&chan->lock);
+
+	ret = copied;
+	if (copied && copy_to_user(buffer, buf, copied))
+		ret = -EFAULT;
+
+	kfree(buf);
+	return ret;
 }
 
 static __poll_t snoop_file_poll(struct file *file,
@@ -153,9 +166,11 @@ static void put_fifo_with_discard(struct aspeed_lpc_snoop_channel *chan, u8 val)
 {
 	if (!kfifo_initialized(&chan->fifo))
 		return;
+	spin_lock(&chan->lock);
 	if (kfifo_is_full(&chan->fifo))
 		kfifo_skip(&chan->fifo);
 	kfifo_put(&chan->fifo, val);
+	spin_unlock(&chan->lock);
 	wake_up_interruptible(&chan->wq);
 }
 
@@ -228,6 +243,7 @@ static int aspeed_lpc_enable_snoop(struct device *dev,
 		return -EBUSY;
 
 	init_waitqueue_head(&channel->wq);
+	spin_lock_init(&channel->lock);
 
 	channel->cfg = cfg;
 	channel->miscdev.minor = MISC_DYNAMIC_MINOR;
-- 
2.43.0


