Return-Path: <linux-aspeed+bounces-2331-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051E5CAC5A5
	for <linux-aspeed@archiver.kernel.org>; Wed, 24 Sep 2025 02:13:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cWgPW4hj1z302b;
	Wed, 24 Sep 2025 12:13:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758680015;
	cv=none; b=bYzXpxvAa3vIBin8ebkkjgtjqXgZhRxYTGXm2yGVYCUIrolJbyLNfatOcm5FAwcuLe+UYj2l6S5hmCzzl3IqOrmvi1xqTCdm2keaj6xFwGZq3cBpfSmoHL2Rqvtc2nP/pew0KP/sXQodpSh1YFtzCzw/1tkrPH4yGq+HvaTFHEzcibZsKVqr3mnMfQ+RIrlPhSRKTCkc3YZlDJfJGpzPaBoUKIvs2JhrNma0xARWqD5AMioGeu5Xrh6rNm5xC7Yfu7uV+695wNnaAIJUd/rAodJA/fmyd1i0fJl+XkcEfpnEaPdFNpVGFF+UqleurpdJfeG1ReKoNxzT2TvipFnyZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758680015; c=relaxed/relaxed;
	bh=B4+vMC3mMORtvsHhkWNQq4UX2Am1Y6Z4F6Rf3tApsxQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D6bQ7HmbZFWzMw5fOwNHiua7722JDYkN22RTZxlogxdqf50g02Doa7sOlqiviT2Ox0O+cuV9VHyxUPIzU0hZcNsAT0qnz/++PnHKxxxTemzTHQm1QQ6Ib3TaGn37DO6EL7ULBcDjNYnqYoSrFk5ivKaJxJyT6u3/yP1CcZXIQd4BHVqvUiz3MPyA1T38m+PbCHW46k5ayyxpuxAOh/anHPuOj+2o5WajPuPNnmiGkbCKiKWKY2wr9Gv4nDqg5EQkKab2lq4Ogb+8q9711r5rAD2bMZZ7+/t7IhogdbBkSLFDXv5mSYHiG8MpvS8Ein7JPwDHVNgVRW08oNn7L/JuTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=A5MwtSpk; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=A5MwtSpk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cWgPV2BKSz2xcB
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Sep 2025 12:13:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1758680013;
	bh=B4+vMC3mMORtvsHhkWNQq4UX2Am1Y6Z4F6Rf3tApsxQ=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=A5MwtSpk99lhf+43cgkAKPPojgLx74pqY+r+UQSh4x/5AiKNOiHZgfCH2HNZ4xHL/
	 PO4mbROfKEipns/AEsgGIC3OVbEwfj+7LkRhufn7AijYUfXbqTFgdS2/0HRr8m+l3n
	 Fa9OOm0nJK+5zUEQmCfsOAC/CJ3YySS+tqc7M3xul4f9p9/9D2rdkXv0b/X68vX6sb
	 8jNkuIzkI8J+3K/oQYMbUN4cOyFp1ifU89pCZ7b5fZKDYWg985Hxe1CB4wDowxEJj+
	 FCxECcS1NSweh+r859CgR+ADCcGoLCRUaJKMqQF9pZo3kLAPqM81ihaVQyerjjbPmW
	 PL7hsmRlFRX7g==
Received: from [IPv6:2405:6e00:243d:a853:dbe5:4849:b82e:5665] (unknown [120.20.205.123])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E7AED647A7;
	Wed, 24 Sep 2025 10:13:31 +0800 (AWST)
Message-ID: <9990f63e533c538ca95c3a2bd3401d27f031c330.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 0/2] Add device tree for ASRock Rack ALTRAD8 BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rebecca Cran <rebecca@bsdio.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 24 Sep 2025 11:43:30 +0930
In-Reply-To: <2cecaf0b-9fb4-49f9-a346-ea3f44627a15@bsdio.com>
References: <20250917180428.810751-1-rebecca@bsdio.com>
	 <dd660ce0388afb61e476f164335600f3fc2b1fb6.camel@codeconstruct.com.au>
	 <2cecaf0b-9fb4-49f9-a346-ea3f44627a15@bsdio.com>
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

Hi Rebecca,

On Mon, 2025-09-22 at 14:47 -0600, Rebecca Cran wrote:
> On 9/21/25 20:40, Andrew Jeffery wrote:
>=20
> > On Wed, 2025-09-17 at 12:04 -0600, Rebecca Cran wrote:
> > > aspeed-bmc-asrock-altrad8.dts:578.16-581.6: Warning (unique_unit_addr=
ess_if_enabled): /ahb/spi@1e630000/flash@0/partitions/code@400000: duplicat=
e unit-address (also used in node /ahb/spi@1e630000/flash@0/partitions/tfa@=
400000)
> > It seems odd that the partitions intersect. Are the offsets correct? If
> > they are, can you add comments to the DTS discussing what's going on
> > there?
> I'll delete the code partition. I added it to make it easier for my=20
> script to flash both TF-A and UEFI areas at once.

Okay, thanks.

> >=20
> > > aspeed-bmc-asrock-altrad8.dtb: gpio@1c (nxp,pca9557): '#address-cells=
', '#size-cells', 'gpio@0', 'gpio@1', 'gpio@2', 'gpio@3', 'gpio@4', 'gpio@5=
', 'gpio@6', 'gpio@7' do not match any of the regexes: '^(hog-[0-9]+|.+-hog=
(-[0-9]+)?)$', '^pinctrl-[0-9]+$'
> > > 	from schema $id: http://devicetree.org/schemas/gpio/gpio-pca95xx.yam=
l#
> > This one needs fixing.
>=20
> I'm confused, because in the existing device tree files I'm only seeing=
=20
> 'hog' used in the &gpio node, while 'pca[0-9]+' is commonly used as the=
=20
> node names for pca95xx devices.

The error above is referring to properties and sub-nodes of your
nxp,pca9557 compatible node, rather than the name of the node itself.
That said, node names are preferred to be generic (e.g. gpio@) rather
than specific.

>=20
> Does the gpio-pca95xx.yaml file need to be updated?
>=20

It depends on what you're trying to achieve. At v6.17-rc1 no other
devicetree in the kernel defines an nxp,pca9557 node as you have here
with gpio@ subnodes, and neither does the gpio-pca95xx.yaml binding
allow them. What caused you to add them?

I expect what you need to do is remove those sub-nodes, along with
#address-cells and #size-cells.

Andrew

