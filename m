Return-Path: <linux-aspeed+bounces-2307-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38710CAC5A7
	for <linux-aspeed@archiver.kernel.org>; Mon, 22 Sep 2025 02:47:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cVSFH6LGCz2yVP;
	Mon, 22 Sep 2025 12:47:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758509235;
	cv=none; b=Hg/wOWDlC2qAw1BQq2jbXbbDwGN4Dj62YNBJe+gMY81f3JddQ8HRWzy16aHUN6Cwrta29wE5x7H1iAERd+1JtszdlzdZaHEx8ScumnABviTpPVW8+QUQXFqOEwuZgPaHJFYY3/lj4uHG9yXl0Xk1XlX/rH0aibybiL/ZBl28/dHG70slDpfyJ6oRB0s/Zi6uEAmlhJ4hkWsYLPyAAbsEiNLSxDbx5hA1hKpEficO4/7AyzeE0yLQcukgKxIMa1ZD/MS7uJicf33u6KTR5f+tZ4Oi3vroqvfu9cuD7EoXxh9UPqoTy2wmISvq3atrKJ3nW2o455DFYxha4utNHtDoiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758509235; c=relaxed/relaxed;
	bh=8lcFSOzja5E1OdUdSgtdwJamxmrIxOqXabOscv2yoRU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LkKeTeLq/Zyb0d4WGcgCrCh/BpIVimOTIJWUoTnesVt6EM8TQdTZMhPLyJMpGVz/Vv+0l+2QktE5H/OansWzk4nlSSwEyZcngoHX1VRkxRYZhvhppYth+nUm68XDKSF0A2gTC3ULcBkltGurA/CQXFoBw6CNWOCx08hZK++oWRBwGIp10laBXAUwZbphQySjk/Dhi0BwfkDCiZqJun208UKonNaSuoC3/j5HptMeCxSQ+iIhMBNvYBUzsBxJXqo90qGWXf33gGPxZ/SGsfSsbI7G3W9BDOxzvX1Mc3DjyL3g7dkIGOtMkO9DpC0tf9mhKm5NdouOuPCl3UdCHst7Ew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=kZW7zB/6; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=kZW7zB/6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cVSFH33qlz2xck
	for <linux-aspeed@lists.ozlabs.org>; Mon, 22 Sep 2025 12:47:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1758509234;
	bh=8lcFSOzja5E1OdUdSgtdwJamxmrIxOqXabOscv2yoRU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kZW7zB/6EL0FgFn6rLaJ6D2Bl9DGzdY3hWfhg93pcG5VaIa5HGLi1t0AijUmBFVFU
	 GkfqvqEqHM7/BejQe+nvSXxYvVhttNV33t6W5iz4ox1xyAauEHCytqMjQ6y0HsZy+D
	 9D12OQB/X8MZo2FILB5BB824OnU6mImg3jy493UxhkO6w8goh4BkCXp+N44fSU+wUx
	 tP81ueKkSUbA8m2w7e/W4Kzjn6TNr6tQSMJD39Db8KCsxLnLqwWB/4koT8o8IIeZhd
	 xRynaMBpOxEc8iocDzgIl25QQSQdelgZFDeEXhNHqu6bKEdTvsEZL74pMlHNqoUAUr
	 R1INSLBUj+INQ==
Received: from [192.168.68.113] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id DEEE964755;
	Mon, 22 Sep 2025 10:47:12 +0800 (AWST)
Message-ID: <7e6f568da28d7a63738b6ed22b33db3df4c478c9.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1 0/2] Add Meta (Facebook) Yosemite5 BMC (AST2600)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Kevin Tung <kevin.tung.openbmc@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel
 Stanley <joel@jms.id.au>,  Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Date: Mon, 22 Sep 2025 12:17:12 +0930
In-Reply-To: <CABh9gBew1=hbJvg1Mhg5dE7Lr_Z442_kbBX6zTs_6_C2NRyLbw@mail.gmail.com>
References: <20250917074812.4042797-1-kevin.tung.openbmc@gmail.com>
	 <9bb9929a-8130-48da-983e-2901a7c3da36@lunn.ch>
	 <CABh9gBew1=hbJvg1Mhg5dE7Lr_Z442_kbBX6zTs_6_C2NRyLbw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
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

On Thu, 2025-09-18 at 10:21 +0800, Kevin Tung wrote:
> On Wed, Sep 17, 2025 at 11:12=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wro=
te:
> >=20
> > On Wed, Sep 17, 2025 at 03:48:08PM +0800, Kevin Tung wrote:
> > > Summary:
> > > Add device tree for the Meta (Facebook) Yosemite5 compute node,
> > > based on the AST2600 BMC.
> > >=20
> > > The Yosemite5 platform provides monitoring of voltages, power,
> > > temperatures, and other critical parameters across the motherboard,
> > > CXL board, E1.S expansion board, and NIC components. The BMC also
> > > logs relevant events and performs appropriate system actions in
> > > response to abnormal conditions.
> > >=20
> > > Kevin Tung (2):
> > > =C2=A0 dt-bindings: arm: aspeed: add Meta Yosemite5 board
> > > =C2=A0 ARM: dts: aspeed: yosemite5: Add Meta Yosemite5 BMC
> >=20
> > The threading between your patches are broken? How did you send them?
> > git send-email? b4 send?
>=20
> Yes, the threading is broken. I initially used git send-email, but for
> some reason, only the cover letter was sent. I then sent the remaining
> dt-bindings and DTS patches separately as a follow-up.

I recommend using b4, it helps blunt some of the sharp edges of git-
send-email.

https://b4.docs.kernel.org/en/latest/

Can you please send v2 of the series so that it's properly threaded,
after applying tags you've collected for the involved patches, and
checking your work with `make CHECK_DTBS=3Dy aspeed/aspeed-bmc-facebook-
yosemite5.dtb`?

Andrew

