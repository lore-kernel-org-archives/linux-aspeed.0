Return-Path: <linux-aspeed+bounces-4259-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CA9CD98DE
	for <linux-aspeed@archiver.kernel.org>; Tue, 16 Jun 2026 00:20:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfSMD4pcWz3btJ;
	Tue, 16 Jun 2026 10:20:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781569256;
	cv=none; b=m4/WePHvT3P7A7u/+BrCVQvnrhpqPYDY6sJvofvPhDbGn8jtpEXpurDCAQT0FWAa6VggiGcRhfafYPMlwsffqK0GsdPCC/9Pd7I6iZ4ecVaVF0TtIxLQc8zYyg2f/x/rMeH921e3hH6tx5pgZ7WuBKFmYPw9MF84ObsurJSozJCjghFq80l45tTvP1j82mkg0Hosd0o/9UQpnV+BDrEggEEdDK8gmlp3anGnwonbVIeZatHj4KdMvi+qvqd8y14RVc7D6VlV3z5ORPt5VMQV2mEHyGrmU4+Trv5khdyesxogiVZHgH1Gj8k2blphzjt28Unf+8/TxCKsVEHoCwZuPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781569256; c=relaxed/relaxed;
	bh=wEKDV+rvEzW/GsX9IMLW4VBOK/SLwUy4xNVC6Yz+6Fs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hZD1vMcnSEAIxOerh4tKGrQnRn5MNX5IlkgWGDbySpnqjMoeLWWjsO0IeHK69D7XUHzxC0X1RtNhxlCfCmV+DjRV0SlcnN23mKh1SBmBiQQ4rs/QBAwhGScGdy0G5vWDxGqz2afE+M84jO15BZey6sWNTVkjndoov/aeNi9dlcuxHdfLOJfFpFCCpp/pryN0T72I9ZJz2KuKAYbAywGoypFATpgC0T7Hk+IrA5WXIKWpvMfzdXDp2eUu9oat4alTG7necHgw3KyEXCzrXFFEG1mebj/+PvQtjnhEukRJwHZ87a/boiS1/Ra/1ISAYhoHWurDaJgqCTwqynslakr/0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=eC2tXB7y; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=eC2tXB7y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfSMD1bdcz2yZZ
	for <linux-aspeed@lists.ozlabs.org>; Tue, 16 Jun 2026 10:20:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1781569255;
	bh=wEKDV+rvEzW/GsX9IMLW4VBOK/SLwUy4xNVC6Yz+6Fs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eC2tXB7ykm3tgVwqx2hDiTZi6AmMv4ab15vLo4MTFUT6qRuH3D8uPUoLMxu6pseDj
	 ayhpOdvK88yIlEtYVIH6w7rHrMKDf3axkUigBbc+HBosT723Ta2A8jGmOgBx7WcjNJ
	 qm2zkRriO1DQtI9AWlnIelZ6QG5Oesv4RjlAR2SV5g5PdY4XUK8oVqaKsBYmpE2sQv
	 FpxD97Z10eii3z0mKAES1A/MMozfIEAd4hzf4srn9TZzrvfRTDPOT1RsCYDDL3Ajqy
	 UGzNo75MQOYg8i0DpsIa88MP5uDiLOizqalxBVm94Ie7S3oqySpD9TTDscn165ThLM
	 J8oqdA0KsRn0A==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id C7BD06001B;
	Tue, 16 Jun 2026 08:20:54 +0800 (AWST)
Message-ID: <133a2533be758b1e95bb0365a90d5907c7b09ddc.camel@codeconstruct.com.au>
Subject: Re: [PATCH v6] soc: aspeed: lpc-snoop: Fix usercopy overflow in
 snoop_file_read
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Karthikeyan KS <karthiproffesional@gmail.com>
Cc: joel@jms.id.au, andrew@aj.id.au, Kees Cook <kees@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date: Tue, 16 Jun 2026 09:50:54 +0930
In-Reply-To: <20260612190744.172638-1-karthiproffesional@gmail.com>
References: 
	<033f2657ae6a94ad13d22f717a2900afb75d892d.camel@codeconstruct.com.au>
	 <20260612190744.172638-1-karthiproffesional@gmail.com>
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

On Fri, 2026-06-12 at 19:07 +0000, Karthikeyan KS wrote:
> put_fifo_with_discard() acts as both producer and consumer on the kfifo:
> it calls kfifo_skip() (advances out) and kfifo_put() (advances in) from
> the IRQ handler without synchronizing with snoop_file_read(), which also
> consumes via kfifo_to_user(). On SMP systems this concurrent access can
> leave (in - out) larger than the ring buffer, so __kfifo_to_user()'s clam=
p
> to (in - out) is ineffective and kfifo_copy_to_user() can attempt a
> copy_to_user() past the kmalloc-2k backing store:
>=20
> =C2=A0 usercopy: Kernel memory exposure attempt detected from SLUB object
> =C2=A0 'kmalloc-2k' (offset 0, size 2049)!
> =C2=A0 kernel BUG at mm/usercopy.c!
> =C2=A0 Call trace:
> =C2=A0=C2=A0 usercopy_abort
> =C2=A0=C2=A0 __check_heap_object
> =C2=A0=C2=A0 __check_object_size
> =C2=A0=C2=A0 kfifo_copy_to_user
> =C2=A0=C2=A0 __kfifo_to_user
> =C2=A0=C2=A0 snoop_file_read
> =C2=A0=C2=A0 vfs_read
>=20
> Serialize kfifo access with a per-channel spinlock shared between the
> IRQ handler (producer) and the file reader (consumer).=C2=A0 Annotate @fi=
fo
> with __guarded_by(&lock) and opt the driver into context analysis so the
> compiler enforces that all fifo access holds the lock.
>=20
> Fixes: 3772e5da4454 ("drivers/misc: Aspeed LPC snoop output using misc ch=
ardev")
> Signed-off-by: Karthikeyan KS <karthiproffesional@gmail.com>
> ---
> =C2=A0drivers/soc/aspeed/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0drivers/soc/aspeed/aspeed-lpc-snoop.c | 38 ++++++++++++++++++------=
---
> =C2=A02 files changed, 27 insertions(+), 12 deletions(-)
>=20
> Andrew,
>=20
> Thanks for the review.
>=20
> Changes since v5:
> - Annotate @fifo with __guarded_by(&lock) instead of a comment
> - Move kfifo_initialized() check inside scoped_guard(spinlock, &chan->loc=
k)
> =C2=A0 in put_fifo_with_discard()
> - Replace spin_lock_init() with scoped_guard(spinlock_init, &channel->loc=
k)
> =C2=A0 around kfifo_alloc() in aspeed_lpc_enable_snoop()
> - Enable CONTEXT_ANALYSIS for this driver in drivers/soc/aspeed/Makefile
>=20
> Dropped Cc: stable =E2=80=94 the fix uses cleanup.h/context-analysis idio=
ms absent
> from LTS; I'll send adapted backports to stable@ once this is in mainline=
.
>=20
> Tested on ast2600-evb (QEMU):=C2=A0
>=20

Can you describe the specific steps you used to test this under qemu?
I'm interested in reproducing your efforts here.

Andrew

