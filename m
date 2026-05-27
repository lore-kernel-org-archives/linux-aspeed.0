Return-Path: <linux-aspeed+bounces-4139-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443B3CD4F54
	for <linux-aspeed@archiver.kernel.org>; Wed, 27 May 2026 03:53:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQG1T6FDLz2yTQ;
	Wed, 27 May 2026 13:53:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779853997;
	cv=none; b=nfDGPvy+J1nDs4nsqd6YClG2AWxvliAQT+Nr9+iHfb7n729td97Kgd/ANekO+eAunk3zEBG3IhwGdoBMH9EDMiGJw/dauMySnwDpk5LwWbvqfq6FbyF5+t8ZDrD829SIXnbNsbdHghUUqIbGTxS1bKV+zfmR1NkTcen0Bve/bkUreD+0cDvMntQeHldKOfm+sP0h1uRP0wJ+J1jYgIWuCS100xePoJ3Ch1KURXH9YbTCdALxLvnH4bt/QIx2fjiMkUXxDEODpGWVpUqBeYwrlWKyX4E6i7YuubYHu8ky7UIoalTRl+nTVra530XFsu4fVZJfMqmeWKrr543y3miJxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779853997; c=relaxed/relaxed;
	bh=tw+GqJxcX23U8Jk0k3T1c9GwbcYKat3sccKmolp9ut8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D8sYJ6WNNjV5oSHxmnaxh0lTJtteAxYlxL18mx9ZNO77dBTUrXRqiPGWP8sejtbC93BeengZQStrg65clqTlPuV4uroeHGlgQjlFeVOOMeNcHWCPbmgSjg/gIZ16l5n2w1iJ4t7qd6/Z+lpkZr2lN4FncJc4iaFPCdIi6twBkznEg89QsVBhIB89xJDJYE5DhA3EVnvyfxOhWtJG/GgYQ2meDydcjG8qKsnOa0Aj5ONtalJWD8eO9pJHSnBTFAJYVxOB81E81mKBHQT85aqqzjjHeBM3P2djsCERbBql8QHNsYXPVsoqhnQsBl9hAtAZMLdgXV5U/S7E7szVMkCiRw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Lxmf1Pt/; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Lxmf1Pt/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQG1T2btkz2yTH
	for <linux-aspeed@lists.ozlabs.org>; Wed, 27 May 2026 13:53:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1779853996;
	bh=tw+GqJxcX23U8Jk0k3T1c9GwbcYKat3sccKmolp9ut8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Lxmf1Pt/wMKSjI0PjUqcSZ6hWFFpSeZ7Pgr3XCEq85P0exUCy/dW3E3J4Hsb753Z2
	 0P9fsHeB1K9coPxQ3g00uTxglqngsMCH/gDudbMm1qN1zEckLcxXCYm84p1sxvvC5Y
	 H4qn8f07eLPcvqXqVHFmgCdDJZ71OM0oHL2HwhfHmunqEld/gLtrvnhr0L1K/vpjmj
	 9QyyO3sb8w3pQFeY7oPp4MbagAox/GEKNy3HCn5QisdR258adl1D4Bvr9KjE3KhdF7
	 AGU3deEEgbm0+lz5KgmM8DiuUTeKqe8lx4Z797WeMCcfMhlkm+Xc8UpvOAHY/ZZcsh
	 upX7PfkN3PKEg==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 84F2360088;
	Wed, 27 May 2026 11:53:15 +0800 (AWST)
Message-ID: <53952f011f2c57ad28d6f864317054a2a34922e5.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2] soc: aspeed: lpc-snoop: Fix usercopy overflow in
 snoop_file_read
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Karthikeyan KS <karthiproffesional@gmail.com>, joel@jms.id.au, 
	andrew@aj.id.au
Cc: jdelvare@suse.de, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Wed, 27 May 2026 13:23:15 +0930
In-Reply-To: <20260523173528.427889-1-karthiproffesional@gmail.com>
References: 
	<c3d474a1ec807e686c0b7ac70cc75f86898aee99.camel@codeconstruct.com.au>
	 <20260523173528.427889-1-karthiproffesional@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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

Hi Karthikeyan,

On Sat, 2026-05-23 at 17:35 +0000, Karthikeyan KS wrote:
> put_fifo_with_discard() violates kfifo's single-producer/single-consumer
> lock-free contract by calling both kfifo_skip() (consumer op: out++) and
> kfifo_put() (producer op: in++) from the IRQ handler context.
> kfifo_skip() increments 'out' without a memory barrier, while
> kfifo_put() increments 'in' with smp_wmb(). On ARM (weakly ordered), a
> concurrent reader on another CPU can observe the new 'in' but a stale
> 'out', causing (in - out) to exceed the buffer size.
>=20
> __kfifo_to_user() clamps the copy length to (in - out), but since that
> value is already corrupted by the race, the clamp is ineffective. The
> subsequent kfifo_copy_to_user() ring-buffer split produces a second
> chunk exceeding the 2048-byte kmalloc-2k slab object, triggering:
>=20
> =C2=A0 Backtrace:
> [=C2=A0=C2=A0=C2=A0 2.972611] usercopy: Kernel memory exposure attempt de=
tected from SLUB object 'kmalloc-2k' (offset 0, size 2049)!
> [=C2=A0=C2=A0=C2=A0 2.974191] ------------[ cut here ]------------
> [=C2=A0=C2=A0=C2=A0 2.974677] kernel BUG at mm/usercopy.c:99!
> [=C2=A0=C2=A0=C2=A0 2.975068] Internal error: Oops - BUG: 0 [#1] SMP ARM
> [=C2=A0=C2=A0=C2=A0 2.975755] Modules linked in: post_injector(O)
> [=C2=A0=C2=A0=C2=A0 2.976668] CPU: 0 PID: 1 Comm: init Tainted: G=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 O=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 5.15.178 #4
> [=C2=A0=C2=A0=C2=A0 2.977316] Hardware name: Generic DT based system
> [=C2=A0=C2=A0=C2=A0 2.977848] PC is at usercopy_abort+0x80/0xa8
> [=C2=A0=C2=A0=C2=A0 2.978931] LR is at vprintk_emit+0xf0/0x230
> [=C2=A0=C2=A0=C2=A0 2.979296] pc : [<8095c3a0>]=C2=A0=C2=A0=C2=A0 lr : [<=
8017cb2c>]=C2=A0=C2=A0=C2=A0 psr: 60000153
> [=C2=A0=C2=A0=C2=A0 2.979781] sp : 810e3dc8=C2=A0 ip : 810e3d38=C2=A0 fp =
: 810e3dec
> [=C2=A0=C2=A0=C2=A0 2.980192] r10: 00000003=C2=A0 r9 : 811ea801=C2=A0 r8 =
: 811ea800
> [=C2=A0=C2=A0=C2=A0 2.980616] r7 : 00000001=C2=A0 r6 : 00000801=C2=A0 r5 =
: 00000801=C2=A0 r4 : 00000000
> [=C2=A0=C2=A0=C2=A0 2.981104] r3 : 00000000=C2=A0 r2 : 00000000=C2=A0 r1 =
: 00000000=C2=A0 r0 : 00000066
> [=C2=A0=C2=A0=C2=A0 2.981712] Flags: nZCv=C2=A0 IRQs on=C2=A0 FIQs off=C2=
=A0 Mode SVC_32=C2=A0 ISA ARM=C2=A0 Segment none
> [=C2=A0=C2=A0=C2=A0 2.982363] Control: 00c5387d=C2=A0 Table: 81a64008=C2=
=A0 DAC: 00000051
> [=C2=A0=C2=A0=C2=A0 2.982881] Register r0 information: non-paged memory
> [=C2=A0=C2=A0=C2=A0 2.983662] Register r1 information: NULL pointer
> [=C2=A0=C2=A0=C2=A0 2.984074] Register r2 information: NULL pointer
> [=C2=A0=C2=A0=C2=A0 2.984474] Register r3 information: NULL pointer
> [=C2=A0=C2=A0=C2=A0 2.984879] Register r4 information: NULL pointer
> [=C2=A0=C2=A0=C2=A0 2.985279] Register r5 information: non-paged memory
> [=C2=A0=C2=A0=C2=A0 2.985704] Register r6 information: non-paged memory
> [=C2=A0=C2=A0=C2=A0 2.986118] Register r7 information: non-paged memory
> [=C2=A0=C2=A0=C2=A0 2.986553] Register r8 information: slab kmalloc-2k st=
art 811ea800 pointer offset 0 size 2048
> [=C2=A0=C2=A0=C2=A0 2.987789] Register r9 information: slab kmalloc-2k st=
art 811ea800 pointer offset 1 size 2048
> [=C2=A0=C2=A0=C2=A0 2.988541] Register r10 information: non-paged memory
> [=C2=A0=C2=A0=C2=A0 2.988971] Register r11 information: non-slab/vmalloc =
memory
> [=C2=A0=C2=A0=C2=A0 2.989511] Register r12 information: non-slab/vmalloc =
memory
> [=C2=A0=C2=A0=C2=A0 2.990064] Process init (pid: 1, stack limit =3D 0x041=
252af)
> [=C2=A0=C2=A0=C2=A0 2.990631] Stack: (0x810e3dc8 to 0x810e4000)
> [=C2=A0=C2=A0=C2=A0 2.991119] 3dc0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 80=
c2ceb4 80c29fd4 80c1f6d4 00000000 00000801 811ea801
> [=C2=A0=C2=A0=C2=A0 2.992044] 3de0: 810e3e1c 810e3df0 802e3a94 8095c32c 0=
0000801 801168b0 811ea800 811ea800
> [=C2=A0=C2=A0=C2=A0 2.992707] 3e00: 00000801 00000001 811eb001 00000001 8=
10e3e44 810e3e20 802e8774 802e3978
> [=C2=A0=C2=A0=C2=A0 2.993336] 3e20: 810e3e44 810e3e30 00000801 00001000 7=
edc2593 811ea800 810e3e6c 810e3e48
> [=C2=A0=C2=A0=C2=A0 2.993971] 3e40: 804dedf0 802e8604 811d584c 00001000 8=
10e3e98 7edc1d94 00001000 810e2000
> [=C2=A0=C2=A0=C2=A0 2.994734] 3e60: 810e3e94 810e3e70 804def50 804ded54 8=
10e3e98 804d3f28 00000000 811d586c
> [=C2=A0=C2=A0=C2=A0 2.995377] 3e80: 810e3e98 00000001 810e3ed4 810e3e98 8=
0579a58 804def0c 810e3f34 810e3ea8
> [=C2=A0=C2=A0=C2=A0 2.996024] 3ea0: 80282c74 80282744 00000000 37f2b80b f=
fffe000 819a2cc0 810e3f68 00000001
> [=C2=A0=C2=A0=C2=A0 2.996684] 3ec0: 805799a8 00001000 810e3f64 810e3ed8 8=
02ee040 805799b4 00000003 1cd5b000
> [=C2=A0=C2=A0=C2=A0 2.997310] 3ee0: 00000000 00000000 00000000 00000000 0=
0000000 00000000 00000000 00000000
> [=C2=A0=C2=A0=C2=A0 2.997987] 3f00: 801002c4 37f2b80b 810e2000 810e2000 8=
10e3fb0 00000000 801002c4 80314ce0
> [=C2=A0=C2=A0=C2=A0 2.998678] 3f20: 00000000 00000003 014fc580 00001000 7=
edc1d94 37f2b80b 810e2000 819a2cc0
> [=C2=A0=C2=A0=C2=A0 2.999268] 3f40: 819a2cc0 00000000 00000000 801002c4 8=
10e2000 00000003 810e3f94 810e3f68
> [=C2=A0=C2=A0=C2=A0 3.000024] 3f60: 802ee740 802edf90 00000000 00000000 0=
0000800 37f2b80b 00000003 014fc580
> [=C2=A0=C2=A0=C2=A0 3.000688] 3f80: 00006f2c 00000003 810e3fa4 810e3f98 8=
02ee7e4 802ee6dc 00000000 810e3fa8
> [=C2=A0=C2=A0=C2=A0 3.001364] 3fa0: 80100080 802ee7d8 00000003 014fc580 0=
0000003 7edc1d94 00001000 00000000
> [=C2=A0=C2=A0=C2=A0 3.002389] 3fc0: 00000003 014fc580 00006f2c 00000003 7=
edc2f10 00000000 00000001 00000000
> [=C2=A0=C2=A0=C2=A0 3.003042] 3fe0: 000000ac 7edc1d18 0002c174 0002c190 6=
0000150 00000003 00000000 00000000
> [=C2=A0=C2=A0=C2=A0 3.003773] Backtrace:
> [=C2=A0=C2=A0=C2=A0 3.004236] [<8095c320>] (usercopy_abort) from [<802e3a=
94>] (__check_heap_object+0x128/0x150)
> [=C2=A0=C2=A0=C2=A0 3.005187] [<802e396c>] (__check_heap_object) from [<8=
02e8774>] (__check_object_size+0x17c/0x1e0)
> [=C2=A0=C2=A0=C2=A0 3.005996]=C2=A0 r8:00000001 r7:811eb001 r6:00000001 r=
5:00000801 r4:811ea800
> [=C2=A0=C2=A0=C2=A0 3.006555] [<802e85f8>] (__check_object_size) from [<8=
04dedf0>] (kfifo_copy_to_user+0xa8/0x1b8)
> [=C2=A0=C2=A0=C2=A0 3.007290]=C2=A0 r7:811ea800 r6:7edc2593 r5:00001000 r=
4:00000801
> [=C2=A0=C2=A0=C2=A0 3.007766] [<804ded48>] (kfifo_copy_to_user) from [<80=
4def50>] (__kfifo_to_user+0x50/0x70)
> [=C2=A0=C2=A0=C2=A0 3.008418]=C2=A0 r9:810e2000 r8:00001000 r7:7edc1d94 r=
6:810e3e98 r5:00001000 r4:811d584c
> [=C2=A0=C2=A0=C2=A0 3.009031] [<804def00>] (__kfifo_to_user) from [<80579=
a58>] (snoop_file_read+0xb0/0xf8)
> [=C2=A0=C2=A0=C2=A0 3.009683]=C2=A0 r6:00000001 r5:810e3e98 r4:811d586c
> [=C2=A0=C2=A0=C2=A0 3.010055] [<805799a8>] (snoop_file_read) from [<802ee=
040>] (vfs_read+0xbc/0x328)
> [=C2=A0=C2=A0=C2=A0 3.010686]=C2=A0 r8:00001000 r7:805799a8 r6:00000001 r=
5:810e3f68 r4:819a2cc0
> [=C2=A0=C2=A0=C2=A0 3.011182] [<802edf84>] (vfs_read) from [<802ee740>] (=
ksys_read+0x70/0xfc)
> [=C2=A0=C2=A0=C2=A0 3.011762]=C2=A0 r10:00000003 r9:810e2000 r8:801002c4 =
r7:00000000 r6:00000000 r5:819a2cc0
> [=C2=A0=C2=A0=C2=A0 3.012451]=C2=A0 r4:819a2cc0
> [=C2=A0=C2=A0=C2=A0 3.012677] [<802ee6d0>] (ksys_read) from [<802ee7e4>] =
(sys_read+0x18/0x1c)
> [=C2=A0=C2=A0=C2=A0 3.013261]=C2=A0 r7:00000003 r6:00006f2c r5:014fc580 r=
4:00000003
> [=C2=A0=C2=A0=C2=A0 3.013724] [<802ee7cc>] (sys_read) from [<80100080>] (=
ret_fast_syscall+0x0/0x48)
> [=C2=A0=C2=A0=C2=A0 3.014330] Exception stack(0x810e3fa8 to 0x810e3ff0)
> [=C2=A0=C2=A0=C2=A0 3.014767] 3fa0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00=
000003 014fc580 00000003 7edc1d94 00001000 00000000
> [=C2=A0=C2=A0=C2=A0 3.015379] 3fc0: 00000003 014fc580 00006f2c 00000003 7=
edc2f10 00000000 00000001 00000000
> [=C2=A0=C2=A0=C2=A0 3.016030] 3fe0: 000000ac 7edc1d18 0002c174 0002c190
> [=C2=A0=C2=A0=C2=A0 3.016641] Code: e1cd40fc e58dc000 e59f0024 ebfff741 (=
e7f001f2)
> [=C2=A0=C2=A0=C2=A0 3.017733] ---[ end trace d9f7e472f48076c9 ]---
> [=C2=A0=C2=A0=C2=A0 3.018380] Kernel panic - not syncing: Fatal exception
> [=C2=A0=C2=A0=C2=A0 3.019190] ---[ end Kernel panic - not syncing: Fatal =
exception ]---

Can you please trim this a bit? See the discussion of backtraces here:

https://docs.kernel.org/process/submitting-patches.html#explanation-body

>=20
>=20
> This is reproducible on AST2500 BMC (dual-core ARM Cortex-A7) when

The AST2500 has a (single-core) ARM1176JZS, not a dual-core Cortex-A7.

> BIOS floods POST codes while userspace concurrently reads
> /dev/aspeed-lpc-snoop0.
>=20
> Fix by:
>=20
> 1. Clamping 'count' to SNOOP_FIFO_SIZE in snoop_file_read() so that
> =C2=A0=C2=A0 copy_to_user() can never exceed the slab object boundary reg=
ardless
> =C2=A0=C2=A0 of kfifo pointer state.

I don't think we shouldn't be double-accounting for the bug. Let's just
get the locking right given the observation that we have multiple
consumers.

>=20
> 2. Protecting the kfifo_skip() + kfifo_put() sequence in
> =C2=A0=C2=A0 put_fifo_with_discard() and the kfifo_to_user() call in
> =C2=A0=C2=A0 snoop_file_read() with a spinlock, ensuring pointer updates =
are
> =C2=A0=C2=A0 atomic with respect to concurrent access and restoring the
> =C2=A0=C2=A0 single-writer invariant for each pointer.

This appears sensible.

>=20
> =C2=A0=C2=A0 put_fifo_with_discard() is only called from hardirq context =
where
> =C2=A0=C2=A0 interrupts are already disabled, so plain spin_lock/spin_unl=
ock is
> =C2=A0=C2=A0 used. snoop_file_read() runs in process context and must use
> =C2=A0=C2=A0 spin_lock_irqsave to prevent deadlock with the IRQ handler.

We only need _irqsave for generic code that runs in either context, but
the fops callbacks are never run in irq context, so we don't have that
ambiguity. You could make other choices here, however _irqsave isn't
wrong.

>=20
> Signed-off-by: Karthikeyan KS <karthiproffesional@gmail.com>

Can you please add a Fixes: tag?

> ---
> Andrew,
>=20
> You're right =E2=80=94 __kfifo_to_user() clamps to (in - out). The issue =
is
> that (in - out) itself is corrupted by a race in put_fifo_with_discard().
>=20
> The function calls kfifo_skip() (out++) then kfifo_put() (in++) without
> synchronization. On SMP ARM, the reader observes fresh 'in' (barrier in
> kfifo_put) but stale 'out' (no barrier in kfifo_skip), making (in - out)
> exceed the buffer size. The clamp then passes through the corrupted value=
.
>=20
> Reproduced on QEMU ast2500-evb by injecting POST codes and simulating
> the race outcome.=C2=A0
>=20

Can you provide more details? The 2500 is single-core, so is either
executing in interrupt context or not, and the values should be
consistent after completing the interrupt.

> Also observed intermittently on physical dual-core
> AST2600 under heavy POST code traffic.

The AST2600 has a dual-core Cortex-A7, so your bug makes more sense to
me there...

Andrew

