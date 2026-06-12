Return-Path: <linux-aspeed+bounces-4253-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3A0CD8CA8
	for <linux-aspeed@archiver.kernel.org>; Sat, 13 Jun 2026 07:56:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcpcc4HbQz2xqn;
	Sat, 13 Jun 2026 17:56:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781291282;
	cv=none; b=blrZWawQF4RQxKnRu3kDlt161517dHl59ZjFxQcV7Xo/JoHxMqSde2wUt/Bhhuhv7JSXzMotiPLwa8W/qnkvne362j+IzyoiV0qiujafa9Rd2pJfpTCDUHIp94+x8nnfMiN6bLawb9oK1Cv+sIRTrVYB6mzKsiCqA0cIEl+IRJHWbHalwEt5PEIeo/vwX44RZMnEQuwsOSRVeuwsxLxYQYw8M4ZKAk12r14MJILBMIMOLMYiwWYByxQzoB/IlDGCizqgkwYLCta2y8RIB1G1LBjMtZvD5Y+VXCgreC9fh5oqP4AR3JirPvSKQgvwbEFordv/bdZ+QJum5Cm6eznKnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781291282; c=relaxed/relaxed;
	bh=UwTEg4XBjlq2gqrpSaNYbmX8jrkzkowNm264wvHp61I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KqLc/+zWSRedTf4CsgJcUlv3PLVylPwEXJ1lJdzEBhhtMcTbJ+2/AtXv40cD+oA1r3uXhWaOg9F91+RZzPlSFY6Eel8/tsTKRpK/2TVUFqNBcAR7jmK5C7lC02i0XXQ1o8YSQEHHfRyqcxlcnHSMkW3LytVpvlxfETtYaz12Ww+JnNLg7LsrQ61diA2JRUSlC7G16151eZwU/2Vq5GHzySFuJi7d7UtqFIKG5jlFiHUC/AQ6HrfdSP+KEY25zoqXc6MLJ9vqrwh5bLZJrfddqcpLMN39rIO+Ijl9XzX228PsIfm5L5Ofx4mhfIvDDCdXMxcxjuIwVSQnkQesXay4Yw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JS1Z+rRL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=karthiproffesional@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JS1Z+rRL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=karthiproffesional@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcTYY2gV5z2ykX
	for <linux-aspeed@lists.ozlabs.org>; Sat, 13 Jun 2026 05:08:00 +1000 (AEST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-36b8d414666so900740a91.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 12 Jun 2026 12:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781291278; x=1781896078; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwTEg4XBjlq2gqrpSaNYbmX8jrkzkowNm264wvHp61I=;
        b=JS1Z+rRLXFfFxhPoPTdlyhONk5sU92obU8n3aI+TF036yO5ZCzkiYFu/fnGbZuvw2M
         +svNtqlM83w9Jsmt6I5oGSThBAs+3RFfablb2EXZJ/rMEgN7DuD4j7Du1iU7P/i7hLpd
         cvB72mj/jx0X5+4S+FSRaXqlDWyBmQUgf5VJLrtMZW+simRxmyO/iqFMOhrjfBzzJ/zq
         KSYPulq87fXflnQ9TzbZqnF+5mQRLZlHrPbcP43TJFKtvxluuWaBbvXnLvBb7SjbMzYL
         OkfdVvmXyPFHGSXyF3ELEFSm86gZ2v+K93Eao/3VKxcTToqzDBjPU1nrBezI6l6F23mw
         l8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781291278; x=1781896078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UwTEg4XBjlq2gqrpSaNYbmX8jrkzkowNm264wvHp61I=;
        b=FYaJhnZVdH1joE9lyvY7gCwSXcs2PNNJ5Tyl7gYNO1gZJYhlfNeZdOhpwMIBgzWe/P
         mL+N66HvePmSJNx6kUObSp+FyWkrWzqfH4FmFS5NBx8aGYGss3Leeaz0u/C1qaxyUpZg
         KYck7/GJZnTKz0PnV/jzptckZ7BiusmWYtKATsmymBWipn4qv5oA9IXny/9OlbNBBLFU
         7AeEMSZwDBfzx/HZ5GEaGEi296zG26XUBEsTiRjxiE4AVUqpBYNLTCKjuJcZVwSHSmfv
         y1hdCqTtikDc4jo83yKcvOEHxpDTmygfJf0YWuMDy8ErbLOmAZ4JGze3BV316uOVX7Ab
         mGJA==
X-Forwarded-Encrypted: i=1; AFNElJ9obqeFct2EOsEnzBSg5Iakouitzl0Fpqrx4GM/9jDHo9BJi0oH/6sfIk9d4/GEWbZ3N1h6gVVBYOIo+wY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwJJ4aKvEbJr5xLI9qWVH0rcSLKbbsyt8VldAixMCa8zm800c0o
	1/Br7NNvBy6e2xkSSGJ49WbnnoBkLGuVmLEY/TOfrwJoQVYTh2s2HyTs
X-Gm-Gg: Acq92OFxv7jU2PvTxCQukKDtE1XVSMnFhX9D3ZsRlxAY2E4xdpSwIdKkCR1WLrDZZVi
	Oyp9Q+wAm/lhbQbCGUxr5HigkHjOz46pAl00x3KUN/z7WDExNvMSJ+Lhkdhkd6ZSAx7YqkwCfT6
	6yP0WurHEXaTIPritKO6EesUQwppA6Wxd6VX9g/2tIq7YAixh7wGrvsId72rpSQVtmAibIxgqLn
	/oz9/RHeWGfUR3ktnm9tZ77bK8fino6rOCiNxhiZRbvcUKeaFkhzgAFEp9UDm1KZ7GJDY4wIapP
	7Wd+BGf8HaoiD9MMS0dZ4TLncJSwuT4ObCkDPteQpHjsxLL0WDDP78OTqEHh0LVYtUohlgCt448
	coWZWmNqOr3FrFVzCbV73oFgF+P0UxwEYgpDezM06GwH88UcDey3KhJcGPILEQOSsWQV7QwTOpg
	H6AE6yk6eGZ67+nAIhPVhZK8PWva4k4fRxyM4MU1d3NqWXxDb75cCrVQ==
X-Received: by 2002:a17:90b:28cd:b0:36a:95c:7613 with SMTP id 98e67ed59e1d1-37a0202ece8mr4596847a91.10.1781291277427;
        Fri, 12 Jun 2026 12:07:57 -0700 (PDT)
Received: from LAPTOP-97G9G880.localdomain ([106.206.15.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a1eba8e9asm2748485a91.2.2026.06.12.12.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 12:07:56 -0700 (PDT)
From: Karthikeyan KS <karthiproffesional@gmail.com>
To: andrew@codeconstruct.com.au
Cc: joel@jms.id.au,
	andrew@aj.id.au,
	Kees Cook <kees@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Karthikeyan KS <karthiproffesional@gmail.com>
Subject: [PATCH v6] soc: aspeed: lpc-snoop: Fix usercopy overflow in snoop_file_read
Date: Fri, 12 Jun 2026 19:07:43 +0000
Message-ID: <20260612190744.172638-1-karthiproffesional@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <033f2657ae6a94ad13d22f717a2900afb75d892d.camel@codeconstruct.com.au>
References: <033f2657ae6a94ad13d22f717a2900afb75d892d.camel@codeconstruct.com.au>
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
  kernel BUG at mm/usercopy.c!
  Call trace:
   usercopy_abort
   __check_heap_object
   __check_object_size
   kfifo_copy_to_user
   __kfifo_to_user
   snoop_file_read
   vfs_read

Serialize kfifo access with a per-channel spinlock shared between the
IRQ handler (producer) and the file reader (consumer).  Annotate @fifo
with __guarded_by(&lock) and opt the driver into context analysis so the
compiler enforces that all fifo access holds the lock.

Fixes: 3772e5da4454 ("drivers/misc: Aspeed LPC snoop output using misc chardev")
Signed-off-by: Karthikeyan KS <karthiproffesional@gmail.com>
---
 drivers/soc/aspeed/Makefile           |  1 +
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 38 ++++++++++++++++++---------
 2 files changed, 27 insertions(+), 12 deletions(-)

Andrew,

Thanks for the review.

Changes since v5:
- Annotate @fifo with __guarded_by(&lock) instead of a comment
- Move kfifo_initialized() check inside scoped_guard(spinlock, &chan->lock)
  in put_fifo_with_discard()
- Replace spin_lock_init() with scoped_guard(spinlock_init, &channel->lock)
  around kfifo_alloc() in aspeed_lpc_enable_snoop()
- Enable CONTEXT_ANALYSIS for this driver in drivers/soc/aspeed/Makefile

Dropped Cc: stable — the fix uses cleanup.h/context-analysis idioms absent
from LTS; I'll send adapted backports to stable@ once this is in mainline.

Tested on ast2600-evb (QEMU): clang-22 with CONFIG_WARN_CONTEXT_ANALYSIS=y
shows no context-analysis warnings; PROVE_LOCKING, DEBUG_ATOMIC_SLEEP and
HARDENED_USERCOPY show no splats. Overflow reproduced via a fault-injection
module forcing the post-race (in - out) state (QEMU doesn't model the ARM
ordering that triggers it in the field): unpatched panics, patched returns
cleanly.

Thanks,
Karthikeyan

diff --git a/drivers/soc/aspeed/Makefile b/drivers/soc/aspeed/Makefile
index b35d74592964..b5188dcde37a 100644
--- a/drivers/soc/aspeed/Makefile
+++ b/drivers/soc/aspeed/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_ASPEED_LPC_SNOOP)		+= aspeed-lpc-snoop.o
 obj-$(CONFIG_ASPEED_UART_ROUTING)	+= aspeed-uart-routing.o
 obj-$(CONFIG_ASPEED_P2A_CTRL)		+= aspeed-p2a-ctrl.o
 obj-$(CONFIG_ASPEED_SOCINFO)		+= aspeed-socinfo.o
+CONTEXT_ANALYSIS_aspeed-lpc-snoop.o	:= y
diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index b03310c0830d..7fa1a345acac 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/dev_printk.h>
 #include <linux/interrupt.h>
@@ -74,7 +75,8 @@ struct aspeed_lpc_snoop_channel_cfg {
 struct aspeed_lpc_snoop_channel {
 	const struct aspeed_lpc_snoop_channel_cfg *cfg;
 	bool enabled;
-	struct kfifo		fifo;
+	spinlock_t		lock;
+	struct kfifo		fifo __guarded_by(&lock);
 	wait_queue_head_t	wq;
 	struct miscdevice	miscdev;
 };
@@ -114,6 +116,7 @@ static ssize_t snoop_file_read(struct file *file, char __user *buffer,
 				size_t count, loff_t *ppos)
 {
 	struct aspeed_lpc_snoop_channel *chan = snoop_file_to_chan(file);
+	u8 *buf __free(kfree) = NULL;
 	unsigned int copied;
 	int ret = 0;
 
@@ -125,9 +128,16 @@ static ssize_t snoop_file_read(struct file *file, char __user *buffer,
 		if (ret == -ERESTARTSYS)
 			return -EINTR;
 	}
-	ret = kfifo_to_user(&chan->fifo, buffer, count, &copied);
-	if (ret)
-		return ret;
+
+	count = min_t(size_t, count, SNOOP_FIFO_SIZE);
+
+	buf = kmalloc(count, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	copied = kfifo_out_spinlocked(&chan->fifo, buf, count, &chan->lock);
+	if (copied && copy_to_user(buffer, buf, copied))
+		return -EFAULT;
 
 	return copied;
 }
@@ -151,11 +161,13 @@ static const struct file_operations snoop_fops = {
 /* Save a byte to a FIFO and discard the oldest byte if FIFO is full */
 static void put_fifo_with_discard(struct aspeed_lpc_snoop_channel *chan, u8 val)
 {
-	if (!kfifo_initialized(&chan->fifo))
-		return;
-	if (kfifo_is_full(&chan->fifo))
-		kfifo_skip(&chan->fifo);
-	kfifo_put(&chan->fifo, val);
+	scoped_guard(spinlock, &chan->lock) {
+		if (!kfifo_initialized(&chan->fifo))
+			return;
+		if (kfifo_is_full(&chan->fifo))
+			kfifo_skip(&chan->fifo);
+		kfifo_put(&chan->fifo, val);
+	}
 	wake_up_interruptible(&chan->wq);
 }
 
@@ -239,9 +251,11 @@ static int aspeed_lpc_enable_snoop(struct device *dev,
 	if (!channel->miscdev.name)
 		return -ENOMEM;
 
-	rc = kfifo_alloc(&channel->fifo, SNOOP_FIFO_SIZE, GFP_KERNEL);
-	if (rc)
-		return rc;
+	scoped_guard(spinlock_init, &channel->lock) {
+		rc = kfifo_alloc(&channel->fifo, SNOOP_FIFO_SIZE, GFP_KERNEL);
+		if (rc)
+			return rc;
+	}
 
 	rc = misc_register(&channel->miscdev);
 	if (rc)
--
2.43.0


