Return-Path: <linux-aspeed+bounces-4127-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C42CD4F54
	for <linux-aspeed@archiver.kernel.org>; Mon, 25 May 2026 00:21:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gNxPd5218z2yFP;
	Mon, 25 May 2026 10:21:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779557746;
	cv=none; b=Z7vcACSJOI63JRj7vbBOkGjnMXPixzy4AeqC/Sfj9Q7HdNoLQbGV1CqjZZzXqAoW6h/pyFg1ZTHy2v7vRMUAkRPS0+E9EgDkFG9FmWAP4J9zmja2ExeHGHx8iAO1P+Yjd7BoYq2EkSrMWF6M0ODrRGHOqmkwd+gW7egB812a1FpaYV6yVs5kvz6Zq//MCo0CbJ5nDxZG2EMBQao3LsoJKMiIYyh2SLqTjv11WrDnmzlJECeh6hnaRmzDGsE/7f7laZ4vA1eJFzn97HSBSGe+fs+Voa2S1kZId/R9uLKYM6hz9VN6cEEh7u4KKvqWVbUJbVNFhmVE0Fn5vdHPTcr61A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779557746; c=relaxed/relaxed;
	bh=EUG8MR7r/McYpSjFacnbdSLvEz+8pngd+Q3ZhhzQ5E0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OL4lEwD9xwoccVDwwmDCzykByvdxPJj1D89sSfAa8c9hS/3ibIjb9EbDgFZUIA3mzkYQQALl4RbVv4likLn2k3qAQg7tnUQz1noWZzUw9ynDgK+ThZQAqKXswDsVnRAz82aneC1cl21s2kM+m1fFnK12KRbOWG7ssHsTB+A26XGyJQ/A5b5vkHm/5DejsWhtZxzIpoeG4lgWNAkFkwViLBw144VzrzAzsxPGJM74UJz9Jd545EDTtzqC2hr0aIf9Vv1xtVGemVDeSGoEhF/wsn7W+2W4J8m9eIvG++e/bMxtMeiabM8rgWqJZFpdYePDsjDxw1n2X7BaQTSrUARWkg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J+uyDwrc; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=karthiproffesional@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J+uyDwrc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=karthiproffesional@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gN8SH58RGz2xfR
	for <linux-aspeed@lists.ozlabs.org>; Sun, 24 May 2026 03:35:42 +1000 (AEST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2ba21d32776so61363925ad.2
        for <linux-aspeed@lists.ozlabs.org>; Sat, 23 May 2026 10:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779557739; x=1780162539; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUG8MR7r/McYpSjFacnbdSLvEz+8pngd+Q3ZhhzQ5E0=;
        b=J+uyDwrcpWLfmDyJVMosTFj016YzjyUzkXi6gflLv3/0cMbMLvBEhQitTh/HTcX8C1
         cT7UMoFOS0Hjz1zf7uauHBtgAijzUomH3bhJ71PX8G4Ev8Ko7cvSR5fTZgJPhwCc1FBI
         mHc0VTSMraXb49g3/iapg7VUYBpzUt6SRK9Emkaz57ouRQVsPMEMMoqyTcvlrr5WXJ05
         hIEa8OgTxIDmIsNAPh8uDndGDg1SKyQs6vasZpDXuCZOsar27EyfEzDq/Woh6AUO44Gg
         IQvOIPR73Tb8nQiaSVl+amxU2Lb6kUICdFj5ZxvpqrAghMSo8B9PmfejnNgLXErjkCZS
         iOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779557739; x=1780162539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EUG8MR7r/McYpSjFacnbdSLvEz+8pngd+Q3ZhhzQ5E0=;
        b=CjYiQ1HWN7s1dWN8kcaL9AmjYV91jGRV9i6JjSJjmqP3JHHehKzEUdYoUDKW1xEFER
         gq4HdgE84Q84QXGocCiF5pgkWfAD74zUD4fkAcjc3ASwnz4/bMknNDtmrDgiuCe/T/po
         J52L5rzr6t5/5DiVyuT2AqmFprVY5sJOZkPbytxyTMoP+N0HwOsXQWp3P7+wB4dvYX04
         fu9H4kPVgZLfeWi3cGpw8OTJoB2e1Y+o+eKKZxrkIKJeQKQKx9hbLPQl5fpg2SoqOgIP
         2fkcHgl/Y470jvNbbdWfiSoK/1ya8vt36NpWRnzHaetTZEDyvfeprDOCosyC8TqcaGJi
         Bjsg==
X-Forwarded-Encrypted: i=1; AFNElJ9cwaRXwyFSouLH8MsdaWrYjoKfo9khsTler5sMqF7zg3d0a4k5F445/uy+RlG6gLcDteDYR/ZWlWRj7ag=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy7tkT+uShNvCSbfgCbDm0D5xdq+FlsjdvtxJbLmluqOkd/fCDp
	sVHSPDNE+D1yiZDqVt2/WNvzNTV5SRFn7EnF5hqVgJOdI1PPTYwXCeSU
X-Gm-Gg: Acq92OHLmP36RA2hKYHlzfBcNcFwgxLZMMbIS79NC9ijet9SBr7mzMCQNPQClII/7DJ
	xmjkjo3Cudd9qKqbcIftmxiVXDv6nu8CgpivBY1XXQgIoWXbHpbps6VBggGnmWypHqDTnqp2Gia
	t9Uky0Pr4gI8ZmUvVZjmf791WNURxGavRyRzTgIsvCKGcLVmjjjoVqYInjJ7A6Y54d0cslSlB0A
	dAoouCarhRTdpV9o5dbbEPqeos1xKQwLFIp2bWAce1ItOeqcoSvIdeNBwjbeqJiWqXhEOkbUN7Y
	QF6Wr6NqGxqbx9Oq9xtFdmYh0WpRPeR7djF/V8mty8v/pc9G3ch2XMzhLmoBBtH+Y4GFrZBTyvg
	9xVlEOkKVx30oTF8nVhZzrO0StUmgQ8qtqYOc4Tnud+sm0CEGgZNCcm5yhfQbN5Pz+W4iSN716o
	6tlj81jWGHeQGtktR4EWXtJxE0PaLpsSHtr9SdWPoe3p5731cvAPPm6223DhmMhOD8QvA=
X-Received: by 2002:a17:902:ccca:b0:2bd:a413:6b07 with SMTP id d9443c01a7336-2beb031ad32mr88357095ad.8.1779557738940;
        Sat, 23 May 2026 10:35:38 -0700 (PDT)
Received: from LAPTOP-97G9G880.domain.name ([106.222.202.195])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58dba7bsm48481345ad.66.2026.05.23.10.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 10:35:38 -0700 (PDT)
From: Karthikeyan KS <karthiproffesional@gmail.com>
To: joel@jms.id.au,
	andrew@aj.id.au
Cc: andrew@codeconstruct.com.au,
	jdelvare@suse.de,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Karthikeyan KS <karthiproffesional@gmail.com>
Subject: [PATCH v2] soc: aspeed: lpc-snoop: Fix usercopy overflow in snoop_file_read
Date: Sat, 23 May 2026 17:35:24 +0000
Message-ID: <20260523173528.427889-1-karthiproffesional@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <c3d474a1ec807e686c0b7ac70cc75f86898aee99.camel@codeconstruct.com.au>
References: <c3d474a1ec807e686c0b7ac70cc75f86898aee99.camel@codeconstruct.com.au>
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

put_fifo_with_discard() violates kfifo's single-producer/single-consumer
lock-free contract by calling both kfifo_skip() (consumer op: out++) and
kfifo_put() (producer op: in++) from the IRQ handler context.
kfifo_skip() increments 'out' without a memory barrier, while
kfifo_put() increments 'in' with smp_wmb(). On ARM (weakly ordered), a
concurrent reader on another CPU can observe the new 'in' but a stale
'out', causing (in - out) to exceed the buffer size.

__kfifo_to_user() clamps the copy length to (in - out), but since that
value is already corrupted by the race, the clamp is ineffective. The
subsequent kfifo_copy_to_user() ring-buffer split produces a second
chunk exceeding the 2048-byte kmalloc-2k slab object, triggering:

  Backtrace:
[    2.972611] usercopy: Kernel memory exposure attempt detected from SLUB object 'kmalloc-2k' (offset 0, size 2049)!
[    2.974191] ------------[ cut here ]------------
[    2.974677] kernel BUG at mm/usercopy.c:99!
[    2.975068] Internal error: Oops - BUG: 0 [#1] SMP ARM
[    2.975755] Modules linked in: post_injector(O)
[    2.976668] CPU: 0 PID: 1 Comm: init Tainted: G           O      5.15.178 #4
[    2.977316] Hardware name: Generic DT based system
[    2.977848] PC is at usercopy_abort+0x80/0xa8
[    2.978931] LR is at vprintk_emit+0xf0/0x230
[    2.979296] pc : [<8095c3a0>]    lr : [<8017cb2c>]    psr: 60000153
[    2.979781] sp : 810e3dc8  ip : 810e3d38  fp : 810e3dec
[    2.980192] r10: 00000003  r9 : 811ea801  r8 : 811ea800
[    2.980616] r7 : 00000001  r6 : 00000801  r5 : 00000801  r4 : 00000000
[    2.981104] r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : 00000066
[    2.981712] Flags: nZCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment none
[    2.982363] Control: 00c5387d  Table: 81a64008  DAC: 00000051
[    2.982881] Register r0 information: non-paged memory
[    2.983662] Register r1 information: NULL pointer
[    2.984074] Register r2 information: NULL pointer
[    2.984474] Register r3 information: NULL pointer
[    2.984879] Register r4 information: NULL pointer
[    2.985279] Register r5 information: non-paged memory
[    2.985704] Register r6 information: non-paged memory
[    2.986118] Register r7 information: non-paged memory
[    2.986553] Register r8 information: slab kmalloc-2k start 811ea800 pointer offset 0 size 2048
[    2.987789] Register r9 information: slab kmalloc-2k start 811ea800 pointer offset 1 size 2048
[    2.988541] Register r10 information: non-paged memory
[    2.988971] Register r11 information: non-slab/vmalloc memory
[    2.989511] Register r12 information: non-slab/vmalloc memory
[    2.990064] Process init (pid: 1, stack limit = 0x041252af)
[    2.990631] Stack: (0x810e3dc8 to 0x810e4000)
[    2.991119] 3dc0:                   80c2ceb4 80c29fd4 80c1f6d4 00000000 00000801 811ea801
[    2.992044] 3de0: 810e3e1c 810e3df0 802e3a94 8095c32c 00000801 801168b0 811ea800 811ea800
[    2.992707] 3e00: 00000801 00000001 811eb001 00000001 810e3e44 810e3e20 802e8774 802e3978
[    2.993336] 3e20: 810e3e44 810e3e30 00000801 00001000 7edc2593 811ea800 810e3e6c 810e3e48
[    2.993971] 3e40: 804dedf0 802e8604 811d584c 00001000 810e3e98 7edc1d94 00001000 810e2000
[    2.994734] 3e60: 810e3e94 810e3e70 804def50 804ded54 810e3e98 804d3f28 00000000 811d586c
[    2.995377] 3e80: 810e3e98 00000001 810e3ed4 810e3e98 80579a58 804def0c 810e3f34 810e3ea8
[    2.996024] 3ea0: 80282c74 80282744 00000000 37f2b80b ffffe000 819a2cc0 810e3f68 00000001
[    2.996684] 3ec0: 805799a8 00001000 810e3f64 810e3ed8 802ee040 805799b4 00000003 1cd5b000
[    2.997310] 3ee0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    2.997987] 3f00: 801002c4 37f2b80b 810e2000 810e2000 810e3fb0 00000000 801002c4 80314ce0
[    2.998678] 3f20: 00000000 00000003 014fc580 00001000 7edc1d94 37f2b80b 810e2000 819a2cc0
[    2.999268] 3f40: 819a2cc0 00000000 00000000 801002c4 810e2000 00000003 810e3f94 810e3f68
[    3.000024] 3f60: 802ee740 802edf90 00000000 00000000 00000800 37f2b80b 00000003 014fc580
[    3.000688] 3f80: 00006f2c 00000003 810e3fa4 810e3f98 802ee7e4 802ee6dc 00000000 810e3fa8
[    3.001364] 3fa0: 80100080 802ee7d8 00000003 014fc580 00000003 7edc1d94 00001000 00000000
[    3.002389] 3fc0: 00000003 014fc580 00006f2c 00000003 7edc2f10 00000000 00000001 00000000
[    3.003042] 3fe0: 000000ac 7edc1d18 0002c174 0002c190 60000150 00000003 00000000 00000000
[    3.003773] Backtrace:
[    3.004236] [<8095c320>] (usercopy_abort) from [<802e3a94>] (__check_heap_object+0x128/0x150)
[    3.005187] [<802e396c>] (__check_heap_object) from [<802e8774>] (__check_object_size+0x17c/0x1e0)
[    3.005996]  r8:00000001 r7:811eb001 r6:00000001 r5:00000801 r4:811ea800
[    3.006555] [<802e85f8>] (__check_object_size) from [<804dedf0>] (kfifo_copy_to_user+0xa8/0x1b8)
[    3.007290]  r7:811ea800 r6:7edc2593 r5:00001000 r4:00000801
[    3.007766] [<804ded48>] (kfifo_copy_to_user) from [<804def50>] (__kfifo_to_user+0x50/0x70)
[    3.008418]  r9:810e2000 r8:00001000 r7:7edc1d94 r6:810e3e98 r5:00001000 r4:811d584c
[    3.009031] [<804def00>] (__kfifo_to_user) from [<80579a58>] (snoop_file_read+0xb0/0xf8)
[    3.009683]  r6:00000001 r5:810e3e98 r4:811d586c
[    3.010055] [<805799a8>] (snoop_file_read) from [<802ee040>] (vfs_read+0xbc/0x328)
[    3.010686]  r8:00001000 r7:805799a8 r6:00000001 r5:810e3f68 r4:819a2cc0
[    3.011182] [<802edf84>] (vfs_read) from [<802ee740>] (ksys_read+0x70/0xfc)
[    3.011762]  r10:00000003 r9:810e2000 r8:801002c4 r7:00000000 r6:00000000 r5:819a2cc0
[    3.012451]  r4:819a2cc0
[    3.012677] [<802ee6d0>] (ksys_read) from [<802ee7e4>] (sys_read+0x18/0x1c)
[    3.013261]  r7:00000003 r6:00006f2c r5:014fc580 r4:00000003
[    3.013724] [<802ee7cc>] (sys_read) from [<80100080>] (ret_fast_syscall+0x0/0x48)
[    3.014330] Exception stack(0x810e3fa8 to 0x810e3ff0)
[    3.014767] 3fa0:                   00000003 014fc580 00000003 7edc1d94 00001000 00000000
[    3.015379] 3fc0: 00000003 014fc580 00006f2c 00000003 7edc2f10 00000000 00000001 00000000
[    3.016030] 3fe0: 000000ac 7edc1d18 0002c174 0002c190
[    3.016641] Code: e1cd40fc e58dc000 e59f0024 ebfff741 (e7f001f2)
[    3.017733] ---[ end trace d9f7e472f48076c9 ]---
[    3.018380] Kernel panic - not syncing: Fatal exception
[    3.019190] ---[ end Kernel panic - not syncing: Fatal exception ]---


This is reproducible on AST2500 BMC (dual-core ARM Cortex-A7) when
BIOS floods POST codes while userspace concurrently reads
/dev/aspeed-lpc-snoop0.

Fix by:

1. Clamping 'count' to SNOOP_FIFO_SIZE in snoop_file_read() so that
   copy_to_user() can never exceed the slab object boundary regardless
   of kfifo pointer state.

2. Protecting the kfifo_skip() + kfifo_put() sequence in
   put_fifo_with_discard() and the kfifo_to_user() call in
   snoop_file_read() with a spinlock, ensuring pointer updates are
   atomic with respect to concurrent access and restoring the
   single-writer invariant for each pointer.

   put_fifo_with_discard() is only called from hardirq context where
   interrupts are already disabled, so plain spin_lock/spin_unlock is
   used. snoop_file_read() runs in process context and must use
   spin_lock_irqsave to prevent deadlock with the IRQ handler.

Signed-off-by: Karthikeyan KS <karthiproffesional@gmail.com>
---
Andrew,

You're right — __kfifo_to_user() clamps to (in - out). The issue is
that (in - out) itself is corrupted by a race in put_fifo_with_discard().

The function calls kfifo_skip() (out++) then kfifo_put() (in++) without
synchronization. On SMP ARM, the reader observes fresh 'in' (barrier in
kfifo_put) but stale 'out' (no barrier in kfifo_skip), making (in - out)
exceed the buffer size. The clamp then passes through the corrupted value.

Reproduced on QEMU ast2500-evb by injecting POST codes and simulating
the race outcome. Also observed intermittently on physical dual-core
AST2600 under heavy POST code traffic.

Changes since v1:
- Root cause identified as SMP race, not missing read-side clamp
- Added spinlock to put_fifo_with_discard() and snoop_file_read()
- spin_lock() in IRQ context, spin_lock_irqsave() in process context
- Retained count clamp as defense in depth

 drivers/soc/aspeed/aspeed-lpc-snoop.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index eceeaf8..d084492 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -60,6 +60,7 @@ struct aspeed_lpc_snoop_model_data {
 
 struct aspeed_lpc_snoop_channel {
 	struct kfifo		fifo;
+	spinlock_t		lock;
 	wait_queue_head_t	wq;
 	struct miscdevice	miscdev;
 };
@@ -83,8 +84,11 @@ static ssize_t snoop_file_read(struct file *file, char __user *buffer,
 {
 	struct aspeed_lpc_snoop_channel *chan = snoop_file_to_chan(file);
 	unsigned int copied;
+	unsigned long flags;
 	int ret = 0;
 
+	count = min_t(size_t, count, SNOOP_FIFO_SIZE);
+
 	if (kfifo_is_empty(&chan->fifo)) {
 		if (file->f_flags & O_NONBLOCK)
 			return -EAGAIN;
@@ -93,7 +97,11 @@ static ssize_t snoop_file_read(struct file *file, char __user *buffer,
 		if (ret == -ERESTARTSYS)
 			return -EINTR;
 	}
+
+	spin_lock_irqsave(&chan->lock, flags);
 	ret = kfifo_to_user(&chan->fifo, buffer, count, &copied);
+	spin_unlock_irqrestore(&chan->lock, flags);
+
 	if (ret)
 		return ret;
 
@@ -121,9 +129,11 @@ static void put_fifo_with_discard(struct aspeed_lpc_snoop_channel *chan, u8 val)
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
 
@@ -192,6 +202,7 @@ static int aspeed_lpc_enable_snoop(struct aspeed_lpc_snoop *lpc_snoop,
 		of_device_get_match_data(dev);
 
 	init_waitqueue_head(&lpc_snoop->chan[channel].wq);
+	spin_lock_init(&lpc_snoop->chan[channel].lock);
 	/* Create FIFO datastructure */
 	rc = kfifo_alloc(&lpc_snoop->chan[channel].fifo,
 			 SNOOP_FIFO_SIZE, GFP_KERNEL);

