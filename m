Return-Path: <linux-aspeed+bounces-659-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF6DC02194
	for <linux-aspeed@archiver.kernel.org>; Wed,  5 Feb 2025 00:05:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YngVj52m0z30NF;
	Wed,  5 Feb 2025 11:05:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738713949;
	cv=none; b=I5jgPaUbEXObrKHTUozLg4+JItGtobVtw4dtMR/476yQilSRN8qwjHOHA3/IDIwxxqS6+u/8eWugX5Oo1JQp5RiCaD+aSfuOqAjNfd36kt6K/IL8ORkoJC1W7ho4tJBXzqmCO3crDQQd8i7XjVcHt0zaSzQ+HUFhNxsMWeBT0wDWaaFwSKN2LcmAUj2szbMJGZz5u1enfMBnFlzJfg/Z/d65QPUhdMVZBXqQ/Af0r/700NMmtyypYE5ED3NVlfgOmayRHWKqkDzVw4MYpbHaR/pTHdppEJWHFEuKK5jPoeYOgD2qez14iyHbAoDmkov/ByFJBW9Me/JAdTPX+DYqXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738713949; c=relaxed/relaxed;
	bh=aMffe2cuyieFMT/ZvHdJ4Q+mva2yTWC26VFHFOFlKeI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c6DsMF/4hc82i6yHNNbgf4QJTcVHjNAHp8vMPDaylNW84mfgifu+WPJ66Zarh0xWExdGhHNLDns0irAzo8z7htrxTrKIdQbH4VBAFge4i7VidSaTrnE2fK2bs1BKRtVkE2awiyWxV0yFY+ZfL1okX7pAjRUUCcuOtuTa7I9lFvuA52k6ceWpLZtxKuS2/I0droxv7G4r19Y4rm/yredCS4s4AZc0KV9ul+iayDMdZtQsCMjvCpLTFnLaW2pVci6YRJtWSrB4U5RVYpGyboML+i2jt9Br4rcsP3b3aU3AvdkVbIbGln5r8nhkV5eIc4Fi0uj21Gid51DG7c3K/hbsAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=LRIFxGFF; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=LRIFxGFF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YngVj0RD8z30Mn
	for <linux-aspeed@lists.ozlabs.org>; Wed,  5 Feb 2025 11:05:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1738713948;
	bh=aMffe2cuyieFMT/ZvHdJ4Q+mva2yTWC26VFHFOFlKeI=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=LRIFxGFFHQUulv7+gJaJmDaWZ/PPEQJVmMZGlxQsy7SG15tOvvOCxT6hHwupywBAO
	 bFTs9JIdo0/N5USrIdXdMxDqzfYs4LDT+w+9d2V2E6DVvPhUXbKta2mrcRSWADjZjJ
	 IFHRP+OSir09zKCOJGmq5BNwhrDamJW5HcnePqwfJgdo1JUjcRR3AruwfHcdOG7cnG
	 qKxX8ddUePxs12+jcVYZTdNBiXM3WMdrbFtjW2Xca+mLz/lRWd4bOXsBk568jKtjeo
	 SrzUlAatdu22ie+tuIF/MRU3W8Vf34yIuNph5y4IBwrSBZ+EBo8i/jo1WRRyHZfnjV
	 O7vCiBEdMjeRA==
Received: from [192.168.68.112] (ppp118-210-185-209.adl-adc-lon-bras34.tpg.internode.on.net [118.210.185.209])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 941067104E;
	Wed,  5 Feb 2025 08:05:46 +0800 (AWST)
Message-ID: <acf79ff017d7648d4d502b7031b88c4853bf724c.camel@codeconstruct.com.au>
Subject: Re: [PATCH v7 0/9] DTS updates for system1 BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Ninad Palsule <ninad@linux.ibm.com>, brgl@bgdev.pl, 
 linus.walleij@linaro.org, minyard@acm.org, robh@kernel.org,
 krzk+dt@kernel.org,  conor+dt@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net,  edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com,  openipmi-developer@lists.sourceforge.net,
 netdev@vger.kernel.org, joel@jms.id.au,  devicetree@vger.kernel.org,
 eajames@linux.ibm.com,  linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org,  linux-kernel@vger.kernel.org
Date: Wed, 05 Feb 2025 10:35:46 +1030
In-Reply-To: <66e2e5e4-5ce5-442c-ba0f-d12cbe79e868@linux.ibm.com>
References: <20250203144422.269948-1-ninad@linux.ibm.com>
	 <79b819b6d06e3be0aa7e7f6872353f103294710c.camel@codeconstruct.com.au>
	 <66e2e5e4-5ce5-442c-ba0f-d12cbe79e868@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
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
MIME-Version: 1.0

On Tue, 2025-02-04 at 13:40 -0600, Ninad Palsule wrote:
> > This one needs an ack from Linus W or Bartosz if I'm to take it.
> > However, it's also causing some grief from Rob's bot:
> >=20
> > https://lore.kernel.org/all/173859694889.2601726.10618336219726193824.r=
obh@kernel.org/
> >=20
> > As the reported nodes should all be hogs the name shouldn't matter
> > anywhere else (as far as I'm aware). It would be nice if all the
> > warnings were cleaned up before we merged the binding update. That way
> > we don't cause everyone else looking at the CHECK_DTBS=3Dy output more
> > grief than they already get for the Aspeed devicetrees.
> >=20
> > In order to not get bogged down it might be worth splitting out both
> > the IPMB- and GPIO- related patches like you did the FTGMAC100 patch,
> > and then I can merge what remains (from a quick look they seem
> > relatively uncontroversial).
> >=20
>=20
> The warnings are fixed by different patch by Krzysztof. As there are no=
=20
> more changes then I will wait for other responses. If I don't get those=
=20
> response in couple of days then I will split it.
> https://lore.kernel.org/linux-kernel/20250116085947.87241-1-krzysztof.koz=
lowski@linaro.org/

That patch fixes a couple of Marvell systems. I think you might have
meant this:

https://lore.kernel.org/all/20250116090009.87338-1-krzysztof.kozlowski@lina=
ro.org/

In which case, I've applied it.

Thanks,

Andrew

