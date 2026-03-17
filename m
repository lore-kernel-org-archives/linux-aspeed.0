Return-Path: <linux-aspeed+bounces-3696-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3199CFB5E8B
	for <linux-aspeed@archiver.kernel.org>; Tue, 17 Mar 2026 00:52:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZYMC3lBBz2yZc;
	Tue, 17 Mar 2026 11:52:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773708727;
	cv=none; b=YSK023rrf8tHYGQ/79JINXYFQf/lHVgI+EvAGokZH4DFgva4mDh0+v5KGk2Da8+9QphQdUI9TyWwoFjNtuBBriPpXhryV3zdj8APyEX8FOXmA9ZTtEvMbu0Y1ruak/V/ZWUr6qBGOlOR9s2heXOGZVn6P35jSc25FOfAhjidodFJT5CE7WmbKUdu13FXMtWDnxCpL4j2gHQglYPE2OFSQ05JvSz/6Ntvah3dUZJqCQV/hEaf5uGYvajR5kOJNs/8cKBJXWLUHMH89PLY9v74X3Nl0Fpv02x4dK6lUl+1YAVmotbOk/wGTrMPm2Qjq/VpYI3rqK9RLJW/ffw4JlheRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773708727; c=relaxed/relaxed;
	bh=7Wva0cCBDpLbK0JVmBe4Ub0EUtCjNYf1GYoc0uieWEk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SOeMbZUv8gLMUGexTPxw7leSIBtZUt3Qm8jTytIkYrMGeRAZfwNfiwzH1PAU9QQxlRWoc3Wu8Kg8OLGmDAMcuEGt9vxaIXvspB8p9au7zNu0Qj8ddM9Hf8hv0xsTtqek+wT3yQM5cJgdENvwjQ6AoTpf4JBD/7BuKKKQLeQjp2+EKIBvtRqnidwOQxZCEvkzRTffMlApCcL0AwXXJQYOo8m3Eweqs/gbWdGGNH6r3gi1nYNZ8JDaaced4Mz+XNYWPFP7CA2zFqm7k/871mMRmmvCTYZPWaRy5ONLTrzNYSCMPbJkdUil2N8AO9kIKDbTcdE5j9RVHaJy6mtH/r1mCQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=GzkAukyh; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=jk@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=GzkAukyh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=jk@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZYM96SMNz2xb3;
	Tue, 17 Mar 2026 11:52:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1773708723;
	bh=7Wva0cCBDpLbK0JVmBe4Ub0EUtCjNYf1GYoc0uieWEk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GzkAukyhJbTthnB88ExXDqDQGE2jqt5wnSezRMJF/nKkq1miLa0jjJu7FsM6JU7y8
	 HXKCxxPAoh+7kuQFvbvs8SRgYpkb3CqApgFvWPP4aVySvcSkGnL/zrGUiw0l6yPDbd
	 XYU8i6Gd5hjtCTmSG9Qi1BKyrz6plS00DEAK9msDg7NuO/xA1FiH2Dyx6l0W4kC68D
	 nHehRORN+FihBZog5/cJVewhMxKdu2qKYkWNMGm45o4KB2asEF0iv9YHOO27XbFB07
	 QYnL8jlJJpDqpxkAEgKxybD6zW9VeQQqzU2V8Mp9vhvk5PJx0QCwY+Tpoq4fqxNiHo
	 fgr2dIbmEuINQ==
Received: from [192.168.72.167] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E07786009B;
	Tue, 17 Mar 2026 08:52:01 +0800 (AWST)
Message-ID: <eeac1db0a5692ae45b5528a85ed1510b8b1cf771.camel@codeconstruct.com.au>
Subject: Re: [PATCH v26 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs and transfer-mode properties
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>,
 "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
 Andi Shyti <andi.shyti@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
 <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, "linux-i2c@vger.kernel.org"
 <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
 <linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "openbmc@lists.ozlabs.org"
 <openbmc@lists.ozlabs.org>
Date: Tue, 17 Mar 2026 08:52:03 +0800
In-Reply-To: <CAL_JsqKQp=HyA90rQ2Hzu148k63k5-qrGLH6sEHXNcjAu3QSwg@mail.gmail.com>
References: <20260309-upstream_i2c-v26-0-5fedcff8ffe8@aspeedtech.com>
	 <20260309-upstream_i2c-v26-2-5fedcff8ffe8@aspeedtech.com>
	 <20260313232125.GA3618633-robh@kernel.org>
	 <TY2PPF5CB9A1BE6A19D439C675AF5028C13F242A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
	 <7ae8222bf6abd83a3c2ac976f54a2edbe4e9727a.camel@codeconstruct.com.au>
	 <CAL_JsqKQp=HyA90rQ2Hzu148k63k5-qrGLH6sEHXNcjAu3QSwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2+deb12u1 
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

Hi Rob,

> > I don't think that really addresses Rob's point there.
> >=20
> > The selection of mode is somewhat a driver implementation decision (and
> > so would not belong in a DT binding) - *except* that there are
> > considerations around the use of hardware DMA channels, as covered in
> > earlier review.
>=20
> Am I supposed to go read the prior 25 versions?

Not at all - the next paragraph was my attempt at a recap of those, but
Ryan, please correct me if I am wrong on any of those points.

> > [My understanding is that the mode needs to be defined here to select
> > which i2c devices have a DMA channel allocated to them. I also
> > think that byte mode may be useful in some scenarios, but that
> > consideration certainly does not belong in the DT binding spec]
>=20
> But this is selecting DMA for the bus, not specific devices. I would
> think the decision would be dynamic based on some xfer size. Certainly
> if the xfer is less than the buffer size (32bytes), then there is no
> advantage of DMA.
>=20
> Or do you mean some instances of the I2C controllers have DMA and some
> do not?

Yes, some of the controllers may be allocated a DMA channel. A driver
implementation may (or may not) make use of that channel.

Since the hardware has a limited numbers of DMA channels, Ryan's aim
here is to specify which controllers may consume a channel.

(in relation to the 'bus' terminology though: there is a 1:1 mapping
between i2c buses and controllers here, plus a small area of global
registers which apply to all controller peripherals)

>  If so, then ...

[...]

> > In that case, we would just have a boolean property, like:
> >=20
> > =C2=A0=C2=A0=C2=A0 aspeed,i2c-dma-enabled;
>=20
> ... yes, this is fine.

Brilliant, thanks.

Ryan: I think this gives us a much cleaner approach to the binding.

Cheers,


Jeremy

