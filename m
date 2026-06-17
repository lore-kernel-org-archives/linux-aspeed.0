Return-Path: <linux-aspeed+bounces-4267-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D26D7CD98D2
	for <linux-aspeed@archiver.kernel.org>; Wed, 17 Jun 2026 00:44:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gg4rK1SY4z3c4v;
	Wed, 17 Jun 2026 10:44:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781657089;
	cv=none; b=QcSxgHin5ptP1+aN48KZQvAkSz/Cjlcj/N0m3Tfg7zZU9jpE99G57oQsXcpQ3IYZ+IuvWuCFpzmc0s2FD80ZL1iUsOxu5D4BOD0soLt/K58z2U/C+vxt28b0P+6CmyjFC7UofIckJjAiues+SAnH8e4n1SiQfLje4+ESDrmNBEItknTw9H1YiPBbS33b1XGAtutkSyBfyaIOym3mTEYBcXlP/haSIT5glRkiWStggnXkGCiyozAsap+sCXbS+1aoL0d5i3sK2cRPlHqDLQRlzTYvcy7+I187QADiCPYE6Gomjf/NbpZEKvKzhkffGxxOFL59jK1BmKifJ2hdEWohCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781657089; c=relaxed/relaxed;
	bh=oW3NBxoz0h1ByrSqH5tPVmY3lr7CHCdPxDnqXMlrypY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LmnsNQYz3DxjHrYQaqIxIGI7iMMeY0zTFaOag/aTOTa1iMqHJPk3L0g8pDHgmiCnO3WCVpLsCzv0cmFnNFOQmGyfJgxBwEoxnOb/kUPqmqR11ryktBojWZVI+FdnVbw6wZ3jsdKxoV9rRvMklRMDVjE1M6Wfn+gGySpb7gER1oeuebu3o/6a2U0v0n3kmH0Ff1E4VRmvxNqoyZABGfFHGZc007/4BT6g2fevVuAf75Y0Pp6OP7HHH9TzZj+7kGAde/U4PAVqvjdpdTHGHzdmXxE34KGHbHqC1/qdh85RBtDhQ0r/9Uycf82vqpz5DwtAmq1OhpT1JPXVpDQpIEYnVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=ZL2rTl7Z; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=ZL2rTl7Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gg4rJ0Q1Lz3bsY
	for <linux-aspeed@lists.ozlabs.org>; Wed, 17 Jun 2026 10:44:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1781657086;
	bh=oW3NBxoz0h1ByrSqH5tPVmY3lr7CHCdPxDnqXMlrypY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZL2rTl7ZbPOIJdHwOxroNvNWUC/kgtRAbAsWGXCKonHXLRrmL/CwWU+Z7+Gkh+iwA
	 rkleWiff1R18xZXbDHV+V6vMusxH4YNZC0aGcNbfh4HOuA7mznwR5ltcHkR4fT3sDm
	 x/mZEoOJHLzPyiLd/vEHJeeIGlfhNiMfAETpc0G+CkSpDn7tzt4F4t1En5OBL/lM76
	 LzFyNucIhKKmtxaZyCp/u1GAB7I+Mr7Ul1tYOBMQ6EbabGD4O1M8frojJ/D/NRwiPU
	 Iu+YKrclcxY0vsp14NBVCDcBduvG3TjzN8iwbtZkI6ijucd3m8yoAvkqE898hdaM/q
	 MxOsQal375ETw==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 0A1D7659B9;
	Wed, 17 Jun 2026 08:44:45 +0800 (AWST)
Message-ID: <b50b84b169b632200ca348971451baca83357c7b.camel@codeconstruct.com.au>
Subject: Re: [PATCH v6] soc: aspeed: lpc-snoop: Fix usercopy overflow in
 snoop_file_read
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Karthikeyan KS <karthiproffesional@gmail.com>
Cc: joel@jms.id.au, andrew@aj.id.au, Kees Cook <kees@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date: Wed, 17 Jun 2026 10:14:44 +0930
In-Reply-To: <20260616073053.1144730-1-karthiproffesional@gmail.com>
References: 
	<033f2657ae6a94ad13d22f717a2900afb75d892d.camel@codeconstruct.com.au>
	 <20260616073053.1144730-1-karthiproffesional@gmail.com>
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

On Tue, 2026-06-16 at 07:30 +0000, Karthikeyan KS wrote:
> Hi Andrew,
>=20
> Happy to. Short version: ast2600-evb can't hit the SMP timing window,
> so I reproduce each missing piece deliberately. The driver code under
> test is unmodified -- only the stimulus and the post-race state are
> injected. Stock qemu-system-arm (Debian 8.2.2), no QEMU changes.
>=20
> Three obstacles, and what I did about each:

This looks like a lot of heavily LLM-assisted effort. Please review the
relevant documentation, starting here:

   https://docs.kernel.org/process/submitting-patches.html#using-assisted-b=
y

I feel the testing strategy is pretty questionable. Any invariant
violation is possible with that type of meddling.

I was interested in whether you drove the interrupt sequence via
emulated hardware. I asked because upstream qemu doesn't currently
support the snoop device.

In v3 you said:

   The issue was observed on physical AST2600 (dual-core Cortex-A7)
   in production under heavy POST code traffic during concurrent
   userspace reads.

   https://lore.kernel.org/all/20260527175939.2939714-1-karthiproffesional@=
gmail.com/

Is this true? What platform did you test with?

Andrew

