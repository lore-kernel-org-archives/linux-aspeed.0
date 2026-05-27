Return-Path: <linux-aspeed+bounces-4140-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD13ECD5BD0
	for <linux-aspeed@archiver.kernel.org>; Wed, 27 May 2026 23:55:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQmh35gs9z2xK4;
	Thu, 28 May 2026 09:54:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779904793;
	cv=none; b=CqZfUnFCY+ijUH6M9borest8GCkhg1GAS7nst8OqZJQgGn1DX8RTNZu7zBGePUR0pP+WLcOY9HTYH1l3reRv/mviz2fpU7Zsaw9cGSxccQm+md+G3G22s+LD+O8/Siqp5RnaAYo+uPmjbXn+5k/XpgqcQIx9mTEyvDRBTXGr+Zdr+m/Ylyc5OXXVpEyN7VD4OSxLPgPsenu80NEPvJzSsSAZHiegJyK3LSGr6c1RthzwKoXoMIfYncN+Xl1eApfCNSdfBgPHjBPwsbkFzHPvZrOXps2cVRJSqcP8nCepE+1PdMywXFy6IxRxIeCa8NakfUKbGoIeidoY3cVZMW89VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779904793; c=relaxed/relaxed;
	bh=erbsC0Vg9mtqhwjoL7B+eBOB5DX7r/gCOj4pQxWk2VI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I+IaxVScenN9bEkA9BG3efBcT+bbRIUzNkaSnzlK6/7vQjUmblvTWA1Pd6wqmmKRv81K2hJrud9+F/a/OEOQXx/TAr3ApnDx/BkhYmfubkAFJu1YpBT+vbsBFn6HkSN1oyO2tNvc2QcHO7F7QAmM7lC1/HcxdDRAW0D9CYbHP/oy6bUCLQ4r2e7EaGZdmNGkxeY0P//RSGBJP1/kNtQk4sRMOSjuf42WIwp+9Z3a4490Rs2Q/1U0CRjaBvl+5Zoh1o/IrKsF4VyGBHg3m0JocqguV9EhJcRtjMb+C+QhnB8WmjXVMm8HT7YTeVM7SUPortYGJs6Vgekjqo5HK2WIGw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RJ3/Mv9C; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=karthiproffesional@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RJ3/Mv9C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=karthiproffesional@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQcpH5kZ0z2ySC
	for <linux-aspeed@lists.ozlabs.org>; Thu, 28 May 2026 03:59:51 +1000 (AEST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2b4583f0a1aso87936605ad.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 27 May 2026 10:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779904789; x=1780509589; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erbsC0Vg9mtqhwjoL7B+eBOB5DX7r/gCOj4pQxWk2VI=;
        b=RJ3/Mv9CSxCHv5rVCfQuH/qHFyPPs57S4/IvkVKe17I792/k3buPOjPvnHbjoCIrXZ
         JPQuzgeZW6B/MwfdbbPquhQqjqtcJm75zTXwdEFq/fwLLbr/5Avu9GKwFxBXcHh1vIVi
         DtGfqvt1n7c4Y85CVWrPJEgrwd8Fn40WMWJDd9YhJqC/mL3uLacjyVbf8QsxhnVlK3Dj
         0ye/zCzmWvfls4dNE+wdYPH9ffs+g3w3vo/+zpkcl3Mrh6XRyDrECNJpOcokPazMe6KG
         VwgWCFgQF9kEHJ/ukMetkWbY6NY5BIFtfo7yt60F22lpr7cgxLVvvgeJQHgD1Vj17xQ/
         GbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779904789; x=1780509589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=erbsC0Vg9mtqhwjoL7B+eBOB5DX7r/gCOj4pQxWk2VI=;
        b=kCu91eA86xGvENADbB0pS5DDnGKjxjpokVO3iqCC/ZUHGvzaNa3bN7hk5kBN7IVL/3
         55sq3Av4QIdeoWRaO9eb7XjdQsDXqw0sS1HE811+6Y/oaJ8lpDmjmOeYEtVdCAaoD5rV
         SFUWFXa1ThY+ig6nUi2ud/MzeD0Jko81+mdmyiNd2tqw+J/uYKynRKuRLeCBr4EN17hX
         kWoXzi3Mw7EynYjgQ6YWaWf2HZ3VrZ96gDjmV+CXGGtjId72lCdXQ0Y3zJSDZ6P0zkVz
         wpYIdSoGl2fpeBy9FAZARXcrDTyc4pE85tQcDvP533l2rhT/7jxoXAKHSRfKiyFt4rIr
         1l8g==
X-Forwarded-Encrypted: i=1; AFNElJ+RekFQTdx/8bxeWVwEYfmvM0H4S0VAUzHSpKyr5FaDV5yVSGpBYHG+Gk8SPovNBKtb/YfjMPTabupKHG4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yye4cgTBlZP+raYCa6fEfsQw0JcLY97LMxKClupMJeSouwKl6rc
	NRUwaOh6SKWKpVAzkib704Yq1TpKuJvEkyk+KjcBiSHWMWbTLu2UVk8G
X-Gm-Gg: Acq92OFdhT9Z0oxlgxJ1etWpmG1NuV88VuboV/dMXrQZOmyp+WGIcCzxUqSFfnIJSwC
	W0FZwqnojnExj/ek2UolZEPaHTa+Mhh8SRY28hLxHdS0DhENQ6QJyHx2qp2Wb48M8LPnzThcsKd
	WLQQodJH1jSW702Jaqg4M95cXIMD3+lUH0zKIjJEa790zqtKTgWl90ih0ROr4zUElzIK2P0NzJC
	uvYKniqnwaBRXYthuuxN6koh1VqKP9Anm/TcsCKY4CfQTVQnBtU8xpH0tRV+X32EEVYlApwe9mY
	/lpuojgFe5KdcjSREwe91C0Jt/2+7M9GMexQkYTngftlNz3uOdC386A8p+i/Fmqo3WJRkw1sT6f
	zyiwfhrzlPbqnSlSUY73spWv1LOl/dgftz3oY9HbpBceNNVYDDd+ojs1bIcC3Fxee68JfD56Z3o
	ah9eqF7/69xlzsBoyz5wolL3FP98o8fJBDVdZtMGyBIf9tNdT8QAm9P3Q=
X-Received: by 2002:a17:903:46c8:b0:2be:fe68:a1c with SMTP id d9443c01a7336-2befe680ebamr8852645ad.39.1779904788724;
        Wed, 27 May 2026 10:59:48 -0700 (PDT)
Received: from LAPTOP-97G9G880.domain.name ([106.222.201.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5695f05sm204648005ad.6.2026.05.27.10.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 10:59:48 -0700 (PDT)
From: Karthikeyan KS <karthiproffesional@gmail.com>
To: andrew@codeconstruct.com.au
Cc: joel@jms.id.au,
	andrew@aj.id.au,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Karthikeyan KS <karthiproffesional@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] soc: aspeed: lpc-snoop: Fix usercopy overflow in snoop_file_read
Date: Wed, 27 May 2026 17:59:38 +0000
Message-ID: <20260527175939.2939714-1-karthiproffesional@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <53952f011f2c57ad28d6f864317054a2a34922e5.camel@codeconstruct.com.au>
References: <53952f011f2c57ad28d6f864317054a2a34922e5.camel@codeconstruct.com.au>
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
Content-Type: text/plain; charset=UTF-8
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
  kernel BUG at mm/usercopy.c:99!
  Call trace:
   usercopy_abort
   __check_heap_object
   __check_object_size
   kfifo_copy_to_user
   __kfifo_to_user
   snoop_file_read
   vfs_read

Reproduced on ast2600-evb (dual-core ARM Cortex-A7) when the host floods
POST codes while userspace reads /dev/aspeed-lpc-snoop0.

Serialize kfifo access with a per-channel spinlock: use spin_lock()/
spin_unlock() in put_fifo_with_discard() (hardirq only) and
spin_lock_irq()/spin_unlock_irq() around kfifo_to_user() in
snoop_file_read().

Fixes: 3772e5da4454 ("drivers/misc: Aspeed LPC snoop output using misc chardev")
Cc: stable@vger.kernel.org
Signed-off-by: Karthikeyan KS <karthiproffesional@gmail.com>
---
Andrew,

Thanks for the review.

> The AST2500 has a (single-core) ARM1176JZS

Corrected in v3.

> Don't double-account for the bug

Agreed — the spinlock eliminates the unsynchronized window that
produces the inconsistent pointer state. Clamp removed.

> _irqsave isn't wrong

Changed to spin_lock_irq — fops callbacks always enter with
interrupts enabled.

> Can you provide more details? The 2500 is single-core

The issue was observed on physical AST2600 (dual-core Cortex-A7)
in production under heavy POST code traffic during concurrent
userspace reads. Since the x86 host does not model ARM weak memory
ordering, the race cannot be reproduced naturally in QEMU. The test
module adjusts kfifo pointers to reproduce the post-race state for
deterministic validation.

> AST2600 has a dual-core Cortex-A7, so your bug makes more sense there

Yes, the issue is intermittently observed on production AST2600.

Changes since v2:
- Dropped count clamp
- spin_lock_irqsave -> spin_lock_irq in snoop_file_read
- Fixed platform: AST2600 (dual-core Cortex-A7)
- Trimmed backtrace
- Added Fixes tag

 drivers/soc/aspeed/aspeed-lpc-snoop.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index eceeaf8df..ef6697a42 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -60,6 +60,7 @@ struct aspeed_lpc_snoop_model_data {
 
 struct aspeed_lpc_snoop_channel {
 	struct kfifo		fifo;
+	spinlock_t		lock;
 	wait_queue_head_t	wq;
 	struct miscdevice	miscdev;
 };
@@ -93,7 +94,11 @@ static ssize_t snoop_file_read(struct file *file, char __user *buffer,
 		if (ret == -ERESTARTSYS)
 			return -EINTR;
 	}
+
+	spin_lock_irq(&chan->lock);
 	ret = kfifo_to_user(&chan->fifo, buffer, count, &copied);
+	spin_unlock_irq(&chan->lock);
+
 	if (ret)
 		return ret;
 
@@ -121,9 +126,11 @@ static void put_fifo_with_discard(struct aspeed_lpc_snoop_channel *chan, u8 val)
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
 
@@ -192,6 +199,7 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 		of_device_get_match_data(dev);
 
 	init_waitqueue_head(&lpc_snoop->chan[channel].wq);
+	spin_lock_init(&lpc_snoop->chan[channel].lock);
 	/* Create FIFO datastructure */
 	rc = kfifo_alloc(&lpc_snoop->chan[channel].fifo,
 			 SNOOP_FIFO_SIZE, GFP_KERNEL);
-- 
2.43.0


