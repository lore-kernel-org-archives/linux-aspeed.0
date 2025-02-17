Return-Path: <linux-aspeed+bounces-751-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E740C02198
	for <linux-aspeed@archiver.kernel.org>; Mon, 17 Feb 2025 01:01:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yx49M6nXFz2ytN;
	Mon, 17 Feb 2025 12:01:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739754087;
	cv=none; b=NzVmCKHl2NwCZrxhiNaXFRXsSiT+XqFa9m04uZP0+rjMMcBSTaT8HDpiH+qXMM/TIcilzmIVHSzaJZFGB4ilBuRddGz2+tIg5jEv7VGxziFZ1inCGxslxEY94GMv4pPHfJ1c9ZSjKNHwhUWjg0XxAxHTiLmEMB/g9VTMyrUP/zMetLV/EWrXWfay573LSti2eRtK7ywCC316HHN+F9J2eaqK1Jlt4DQJ7KWFTQqq+XrQH8OA7tXOYKHEhFwqLaoRaDkbmX/4P0BoxFQKPP1VSnO0DPYSS31YkEJ4TS3Vk4pBvu5U9RGkvzHIJDQStdJ1JBuQGgPmJVAJGop3UhNiDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739754087; c=relaxed/relaxed;
	bh=197jgArcHmxjLWJHP3d90o+UVqJqNHrwpTlU4PAOVr8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R4rtNRrZxWiVUF28Vbxz8IHgnO/8ukCnVnLZnpfYBTtBcxIOK4txhJS7E5aCdB5N2TbWgh/5di3xIvPqJqkXuk/lBHVES9PtiTR28F3i5IBimjsovZYXTLb4DMUVAC354lUZpeVJ9OX6fIddC1CZoVgnW6n3daWeFCJmMzJAPK7eckEM6Lbx1qINDJCpxFqFSaXwBuQwXgkTCj90grVyTervq2vD/Iwf4XKqN5P7uiwWbel9luK4HzTgPsnDNZXG6GFK37L0XlKB0xAHZRu5YAaG0l+u0+PZ8a9R+a9PdXyeteU5epk+Z618ea1tkKQ0D6/d1VTTGcZ5v4Kk67hxJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=dVKCB49I; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=dVKCB49I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yx49M24Qbz2xdn
	for <linux-aspeed@lists.ozlabs.org>; Mon, 17 Feb 2025 12:01:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1739754086;
	bh=197jgArcHmxjLWJHP3d90o+UVqJqNHrwpTlU4PAOVr8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dVKCB49IuOAKDBlVaPc9OJo6YDFoJZbcM/73itjicoXBVo6S2sPz98dFefq4uonsz
	 0BOxMYXB3j2NK8CAWrVU1QDuLIi72fkv/qGyupH2DHgDsjVyyLyY/pQ9gcPQVdIRiN
	 gh85us7w3ofG5oaX9OrRJ7r85MgpoDeJbBNtYtpOjLvnB6Sasq++sGDmHN2A0g5cLB
	 lXnfnx/7FBFsUK91O82KNMj+2Py7brat2sbPFe1om68YHwBKdLtp+nTOyEo8RkWIJf
	 hj+Y3J40hjbSES0Y1Q2wl0/HFqwK/O645xee/IlHgmN9ZNkmH5W0rx5iRXBl3vtwAy
	 Z+pURH3shKXwA==
Received: from [192.168.68.112] (ppp118-210-170-58.adl-adc-lon-bras34.tpg.internode.on.net [118.210.170.58])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 0C16364E5C;
	Mon, 17 Feb 2025 09:01:25 +0800 (AWST)
Message-ID: <047ea26fbb5713e852431d0731e21d34af39e1c2.camel@codeconstruct.com.au>
Subject: Re: [PATCH dev 6.6 v3] ARM: dts: aspeed: yosemite4: add I3C config
 in DTS
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: MarshallZhan-wiwynn <marshall_zhan@wiwynn.com>, patrick@stwcx.xyz
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Date: Mon, 17 Feb 2025 11:31:23 +1030
In-Reply-To: <24d2d411365004f11498777501da54d6a9c6e758.camel@codeconstruct.com.au>
References: <20250214011556.1891113-1-marshall_zhan@wiwynn.com>
	 <24d2d411365004f11498777501da54d6a9c6e758.camel@codeconstruct.com.au>
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

On Mon, 2025-02-17 at 11:14 +1030, Andrew Jeffery wrote:
> Hi Marshall,
>=20
> On Fri, 2025-02-14 at 09:15 +0800, MarshallZhan-wiwynn wrote:
> > Set I3C config in yosemite4 DTS.
> >=20
> > Test plan:
> > Tested pass with aspeed I3C patches and I3C hub driver.
>=20
> Can you please expand the commit message to provide details? This
> statement is quite vague, and I don't find it terribly helpful as it
> stands. Which aspeed patches? What tests?

Also, you've sent this patch to the upstream lists and maintainers, but
it appears you're intending this to be applied to the OpenBMC kernel
fork. Please understand the difference between the two and review my
recent response to Rush Chen:

https://lore.kernel.org/all/9f0447151e6574d74e7fa9cbbb50d8e970059273.camel@=
codeconstruct.com.au/

Beyond that, for patches to be backported into the OpenBMC fork they
should first be merged upstream, in which case they must be tested
against a recent upstream tag (e.g. v6.14-r3) before they are sent. It
will be worth reviewing the following:

https://docs.kernel.org/process/development-process.html

The "Submitting Patches" documentation provides a more succinct
treatment:

https://docs.kernel.org/process/submitting-patches.html

If you have any questions, please feel free to contact myself or Joel
off-list.

Andrew

