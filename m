Return-Path: <linux-aspeed+bounces-4525-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57910C44533
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Jul 2026 07:48:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4mbS5dLqz2xpn;
	Wed, 22 Jul 2026 17:48:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::436" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784706532;
	cv=pass; b=QAinF3DvgoXpuWD06g5rtdxjEgEdr/ZQTm7Xpllpou1+hnTiuW0Rgs1sv88oNt5sLLLLBxhkw6ZDz5/xFSWGRN4/3azRMBF5UNZDi4f5sE9HSnD5NUFhyfhNOlOTiuRCu1x87S7KCbeVJrhbp/3W/S6I7/Ct97KcLVukXWD6jpKQjnbK7KeOIxj+0cFpg+BLrtX/qvk+ESgwW5QdgRyaFyMr45IaunpW+AZn0Ofz4bG9aBawyOi3G316ftBvZ/xsKisaGxkeLM9ezUyq7+mO8aqisBlwCa4/MgdRI8zydHgloqdxxqZPqxhFJ967/2xpJuVmojHwbb+jju3AygdksA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784706532; c=relaxed/relaxed;
	bh=6UhFyOhKx+jT3HPS8ykasYawrPgWFTlQSXn9dqJwRwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IF7fJu9smts8MpBAT+D+OZ+/qzWNVdGV8HyfJXO+DVNQFDg1Qa1XNCy9vTL2kXz7TXwezWpHAd8taSR/Nn2ARRhZ5/Bb95ptHRzJoJOGH7M7s4aZnU4l02BPoS4PmLr+5nk4obcn44x4VI+H8bFy6XWKIV/hs0egvkyn00BjKy8aQfP0D1vZuRGRvrU8/2z4LuvPmuPgyfmWRwlWBCvY9+GQJ+PxTGbKwx4mEEw5DzCZaKVfL/fYx0ifo/9EpSd6vmHPh7vG+/4gt2dm6PUvDzkHow6fM9yyz9bHVBf6PRVa21ANQvHuEPVgQLO3QxDXfNwvnpltJV65/RCt01dR4A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=Y2MNJU0y; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=Y2MNJU0y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4mbQ6VMVz2xJT
	for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Jul 2026 17:48:50 +1000 (AEST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so10741250f8f.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Jul 2026 00:48:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784706526; cv=none;
        d=google.com; s=arc-20260327;
        b=dYiby/t93cOn4ItZM0jvZSMy6Gyoiof88MA2hqZZYlrwQGxLrBXF3zZjjTwdP0Dh8T
         9l4WDSnQopJBc+h09Eh1kpZx2uIuLLNBoG/INM/t4gEwgOa8g4qsRXs+Ysf+s4qzaEv+
         JSl5ILGSgQhNh0CWBgpG6PzdFt/jWD0Y+2mWi4kZKhTMeYDTbzy1iIRzweOAdN0EH4ai
         N4w2xvvWquPdSCPcNSb3sOGUH73ELqRDrwj5Nh7HGF+uzzmKNvyMx6HkU53MmVHh3aCu
         IL0DoPwn2CPXyLXNHbinwZ6SCv44XeMhlCJ8UwMGdR6BwqXcm95e/1qhlLk0atvFpj8H
         T/Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6UhFyOhKx+jT3HPS8ykasYawrPgWFTlQSXn9dqJwRwc=;
        fh=N0nwz/SxaLkjlS+Dv3TGEZ+tYt1KV/R6mb3f4uibkjk=;
        b=hMTx5Gn8WYqMoAuM7lSEAh9fSFJ/RiUYxvAQlhvM8fQIMfxYXJ+5m533/V55nw+21N
         ZmEj1qLwMdW0TTnbQsfuag5qx7IzASF1PoGd8oiszaVeQhcrp5F+yBh4Ap1cVyp5/Y36
         Ukg0loVdzHzRfXVaS7K7bbRDUz37C0ymSdap+U0psmnokzdDjyOD1eLKITWUrFU8gBgM
         NkyIw3oKvx1vswWuyaTm38LoL3vttc044acK+vzdT8f5vjA7kWEwRptOSRYrX4naN7R8
         mkEqGRrvnfGruHJgOxZovahwPU7dRDO5zhwBGPJsAuTP8d4Sq8Ol8+tlmpMqAZcoEU9S
         W87w==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1784706526; x=1785311326; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6UhFyOhKx+jT3HPS8ykasYawrPgWFTlQSXn9dqJwRwc=;
        b=Y2MNJU0yRUqFIoef5bmgdtcXzIb9UaMv9elAXNDk8Fvhy5ENVQCStoRE3SVSfSZl+F
         YIAulQfOwRvTOUhMTxtQpmL9+OrdyoWyJr6gQb2ZN+zTModxQH53h0tqiJ0Gc4UF8BDC
         30Ln/HcDy0qm3O/Yl8+5KDNVKZIVEZilo5QhLQcVsDl2GApV+/4SNd6JWQlks3pIWMA2
         hX0EPIGfxv/NnvuWpjzxJIpAGg7aWJbQkjoSziYm0gV88vVlvW+us13Et0UvxP7i8nH2
         v3+hfcKkQtZGMJttvLFRRElgGsRfSGGF0HjIRB37aUW25ArPmdt84oe2iLHJndBN8r4N
         NUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784706526; x=1785311326;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6UhFyOhKx+jT3HPS8ykasYawrPgWFTlQSXn9dqJwRwc=;
        b=GgvzaqKoDBHTonxJzsdAN2vP8yJPP2ApPE1QABAsZd2HnPKxkSjVJsm8/Zj+j7jkPQ
         y1W5nHk/sEpQN5dRKoSHc7AwI9h1TsbT+0Zk5W6zo+1xN/rYKuN5kzzJHokujrgAWZlO
         /0H+9K0wAF98heeo6NCM8kwvFVqoyIHY37QXQId1ZQUt1aWLiVxn1MyAuVJK97I4K/qm
         kKoukPmHf9UoUxMUlIQj/zJQVjd+EnQ/I49Kiu5IckZLRhuB+FtsfyaZkByef93MtsY1
         Axcb1M3qICGzu3lYPosUeSdk4BAFm/BFwamp2jbEQKrzqXtwGamHgl10/7euIjqIuATh
         QNNw==
X-Forwarded-Encrypted: i=1; AHgh+RrlhSCGqNE6DdwQAFEIZbVNgudDhqu5cCY0J4MWTdJBJk6SrgTaCiBcApSn5EC4fvli9PsVj39MQW3U53E=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw0Cxo/U3HXIysSsvtuw1N6krWIudmCRUkEWbbCGjbEhtcbdpb4
	hlbtIqp3AGo7waXjbEaLrpJC9lxZRxPbvA+oBT+ULNqi64OZyvvczuKtfLSFg5p8NX7lflsAf89
	8Ix1TmMqMxQDUpO6Yya7ZrWtZImlYSjYbBRrCLLSbfw==
X-Gm-Gg: AR+sD13hXAMVViQV9bOXXyCark/4zhS2qArbZ5oQlk5JR0ty9qYxfOXPI8siy84RM2X
	oJTizFkNxph8b/0RWWCA49Hkya34w8mhoDunatVHpR0MRTPtz3detD/w16FHjivaWKjvemXyhph
	ZJ/fkLVOcFkN4W01KoLjPfnK1BzFX2EypV0mZRwchar6b6T+lgMqx6dyX3yuBVGF742NRqr1PGR
	lkKmGxXJ18Q/9sV3gdFAx/7tSL9ciy15Nj94Lk8fIPPLpvqZ4TYbEizROy75XiUub6hF4/VcqKD
	sO4RnsJ4vzk3U9jsW1fUzHccN8C/d3UYjyyAxngRgEdScs4=
X-Received: by 2002:a05:6000:1785:b0:47f:7b75:61a with SMTP id
 ffacd0b85a97d-47f7b75083amr12134285f8f.15.1784706526183; Wed, 22 Jul 2026
 00:48:46 -0700 (PDT)
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
References: <de49f2032f5b1f170161dcd6191c0daa48f0b0c2.1784117715.git.gregoire.layet@9elements.com>
 <178412588365.243141.16731478852761544781.b4-review@b4> <CAFi2wKZrya6aHAN9Wtwk43gqQTMPp1BamM9VKKQ+iH1UPzr4HA@mail.gmail.com>
 <793ccb3b7af22f6f38ff6544ed633b7800ea68b6.camel@codeconstruct.com.au>
In-Reply-To: <793ccb3b7af22f6f38ff6544ed633b7800ea68b6.camel@codeconstruct.com.au>
From: =?UTF-8?Q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Wed, 22 Jul 2026 09:48:33 +0200
X-Gm-Features: AUfX_mznQxf2UYusZQbYzHcCnp0qGiF5STuXfQoGRl4lbxGWdovDVg2XFHP_Lfs
Message-ID: <CAFi2wKaWiE61y_rUr_2UNN2_fSAEswG7CXQrPMWT0NiSVBcBVg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed-g6: add pcie-lpc and pcie-kcs4
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Tan Siewert <tan.siewert@9elements.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > > so you're describing a second `ast2600-lpc-v2` node which is unnecess=
ary.
> > >
> > > Suggestion: Merge pcie_kcs4 into lpc@1e789000 and use 914 as offset. =
That way
> > > you don't accidentally cause an overlap for the devices if you descri=
be more in
> > > the future.
> >
> > The 'kcs_bmc_aspeed' driver has the kcs channels address hard-coded.
> > If the 'reg' property does not contain the three addresses used by one
> > of the four channels, the driver returns -EINVAL.
> > So having a pcie-kcs4 with regs 0x914, 0x918 and 0x91c doesn't work.
>
> It does work if you fix the driver to allow it.
>
> >
> > This is why a second LPC node was added, for the pcie-kcs4 to have
> > regs 0x114, 0x118 and 0x11c;
> >
> > I know we should write device tree sources based on hardware rather
> > than around driver limitations.
> > Changing how the driver behaves seems excessive for supporting KCS over=
 PCIe.
>
> I don't think this is true.
>
> > I think a point can be made that the LPC over PCIe is a different LPC b=
us.
>
> In my opinion it's most helpful if Table 8 in the datasheet is used as
> the reference for address ranges in the devicetree. With that in mind,
> I don't intend to apply a patch adding a new node as you've proposed. I
> suggest adjusting the driver to identify the X{{I,O}D,ST}R4 addresses
> as channel 4, under the existing LPC node as Tan suggested.

Sure, thanks for the clear details.
With the Table 8 in mind, I agree and I was wrong.
I'll work on that.

Regards,
Gr=C3=A9goire

