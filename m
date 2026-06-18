Return-Path: <linux-aspeed+bounces-4270-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC6BCD98E4
	for <linux-aspeed@archiver.kernel.org>; Thu, 18 Jun 2026 00:45:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gghp313pSz2xSb;
	Thu, 18 Jun 2026 10:44:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781743499;
	cv=none; b=fG8kzfUGk0Oh6sjbE9sFvbsfHd6onoM3OZAr8YZXCFjXyLCtRA/37l3Y7zLI7rI+GCJuCggdf1GthgwsvWHuJXq/13d50VoEsE9aF9b2NefYIsfZw92xpZu5NBcBsd4SYVbVQ3Vy600tIw2uxLS56FbLiUqfTJyZmzSzWDQsyt1F/fedIaQThSZw/yX3n8oVVtwZXWrFQchuzs4QDMYiLSyErfHFAaIFp/tkN3QUhmuVRtygCISWr2TpviVrC8H0HfWc8dpsa2f7TKTCch0GjwrrAksOxHjXP92d6tesy8rzp12sudp2iVBs5aRf+tlv97oVcorOBkTPnUgQwt7Xag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781743499; c=relaxed/relaxed;
	bh=5t5FMbUYJIDiySOu7zf/8rQwx2qflh/CaAEYYcLPs/o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i0j1a6Ln6eUUj7BWlUmmj61kLV9uhv3ZnsKINvjbT7piX9t2A5furDW35k0E8/kVz5Ehq2CHVX264P8vRoYDa5OM22ThASgx8RtoUQNQVBw2FhnKT1+FfIftyM93Lgsc2FzeoLB3PdTbnW6Ir/letaPsT9s6609ZamuWbOTYsg0T04Yc2JuWc9b+8sbhjj1mJvsTHno+21FXV7VDwzhFvVmqcpAQd0rWFb3cja9bkFP53ZuKrBtW5QlmJGS0RRuW4Yz7wu8pLt3j6IwRX0Yh83DwDQSmCRTy31EN7cEICIKv1PxAQ65z0rXD45kteslxoMfU4v9IDBvm/UCF8vHhFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=FRpQmA/Q; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=FRpQmA/Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gghp22JGBz2xLm
	for <linux-aspeed@lists.ozlabs.org>; Thu, 18 Jun 2026 10:44:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1781743496;
	bh=5t5FMbUYJIDiySOu7zf/8rQwx2qflh/CaAEYYcLPs/o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FRpQmA/QQnrRUAzfk5ZLkhb0CGT2jrsnPpajrhMmvLbSXcjAJoHy5ncQEt8bZWB1Q
	 PyTO1BQvMuwrP5s16Ooea0VgWwB4x+jqWELveLKqUBDkKxovSDrVTtajYnrYKZT98t
	 jySm2+qczVvYRVAbhjocS3PEQdsy3A0Dl/SViq9bpJ+5UGCha9A8YKkp3FDGaPWBuC
	 iDArM/vYQLmyAV/fEm/UgAgDJ1QhgDbYKTA4KYbgp8LdYRqafwYMTriJP3AcdroFAL
	 TQQRcyR1Jmkj1mOHmHOL3kzbdJj+MMmnSYr6AHP+07sTlMjM0npWp7F90Rt9xt4pgK
	 PNF4KP61IsQew==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id DC29C605A0;
	Thu, 18 Jun 2026 08:44:54 +0800 (AWST)
Message-ID: <63ec2546de213ab24be06024ac67e98854fce446.camel@codeconstruct.com.au>
Subject: Re: [PATCH v6] soc: aspeed: lpc-snoop: Fix usercopy overflow in
 snoop_file_read
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Karthikeyan KS <karthiproffesional@gmail.com>
Cc: joel@jms.id.au, andrew@aj.id.au, Kees Cook <kees@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date: Thu, 18 Jun 2026 10:14:54 +0930
In-Reply-To: <20260617131013.64188-1-karthiproffesional@gmail.com>
References: 
	<033f2657ae6a94ad13d22f717a2900afb75d892d.camel@codeconstruct.com.au>
	 <20260617131013.64188-1-karthiproffesional@gmail.com>
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

On Wed, 2026-06-17 at 13:10 +0000, Karthikeyan KS wrote:
> This looks like a lot of heavily LLM-assisted effort. Please review the
> relevant documentation, starting here:
> =C2=A0=C2=A0 https://docs.kernel.org/process/submitting-patches.html#usin=
g-assisted-by
>=20
> =3D=3D> I partly agree. The code and bug analysis are done manually.
> LLM use was the out of tree test harness and lightly polishing
> the commit message. None of the submitted code is generated.
> If you'd prefer, I can reword the changelog in my own words or
> add an Assisted-by tag ?
>=20

Thanks for the clarification. It's probably okay as-is in that case,
but that was unclear previously.

> I feel the testing strategy is pretty questionable. Any invariant
> violation is possible with that type of meddling.
>=20
> =3D=3D> The underlying bug is a kfifo SPSC contract violation. My intent =
with the
> test wasn't to simulate the race itself, but to reconstruct the post race=
 state
> specifically where (in - out) exceeds the buffer size and show it causes =
a
> usercopy overflow in the unpatched code, handled safely after the fix.
>=20
> =3D=3D> I take your point that forcing that state can itself produce viol=
ations that
> wouldn't occur naturally. Since the bug is provable from the source but h=
ard to
> trigger on demand, I'd rather ask what validation you'd accept here?

I'm aiming to build confidence that the change has been tested in
practice beyond spherical-cow circumstances. Isolating the conditions
this way seems okay, but I'd class the testing approach as necessary-
but-not-sufficient. It's important that the change is tested under
typical conditions to build confidence against regressions, as well as
atypical conditions.

>=20
> I was interested in whether you drove the interrupt sequence via
> emulated hardware. I asked because upstream qemu doesn't currently
> support the snoop device.
>=20
> =3D=3D> My apologies for the confusion, I mixed up things. I have not dri=
ven the
> interrupt sequence in emulation; as you noted, upstream QEMU doesn't mode=
l the
> snoop device. I've described the actual hardware context below.
>=20
> In v3 you said:
> =C2=A0=C2=A0 The issue was observed on physical AST2600 (dual-core Cortex=
-A7)
> =C2=A0=C2=A0 in production under heavy POST code traffic during concurren=
t
> =C2=A0=C2=A0 userspace reads.
> =C2=A0=C2=A0 https://lore.kernel.org/all/20260527175939.2939714-1-karthip=
roffesional@gmail.com/
> Is this true? What platform did you test with?
>=20
> =3D=3D> Yes, the underlying failure is real. It was observed on an AST260=
0-based
> production BMC running a vendor BSP kernel under continuous host reboot
> cycles. Because that platform can't currently be brought up on pure
> mainline without substantial out-of-tree board support, I have not run
> this exact mainline patch on the physical silicon, observed under the
> BSP kernel, not yet verified as the mainline patch. I should have made
> that distinction clear earlier in the thread.

Can you confirm you you have tested on hardware a backport of this
patch to your BSP kernel?

>=20
> =3D=3D> If there's a way you'd consider valid for validating a fix like t=
his
> without a full mainline bring up on the SoC, such as a targeted kfifo uni=
t
> test, or something else you'd accept.I'd appreciate the pointer and I'll
> do that.

No, I believe the change is fine, but the claim of testing under qemu
when qemu doesn't model the necessary hardware was a red flag that
needed to be addressed, doubly so in the absence of your track record
of upstream work.

Thanks,

Andrew

