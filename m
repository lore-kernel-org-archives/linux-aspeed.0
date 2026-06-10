Return-Path: <linux-aspeed+bounces-4222-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A90CD98C7
	for <linux-aspeed@archiver.kernel.org>; Wed, 10 Jun 2026 23:12:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbM472b0qz3bpx;
	Thu, 11 Jun 2026 09:12:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::e2d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781104600;
	cv=pass; b=UtIdC08VKAKNfO9lu7PcEd7diVqz/4wW/gh61QImS9YnvYVQdROnkQOAJFOaRlIxFZKLu4o1tPvoTbIDM1AQrVtv8/u2DO4Vkkmoc8cMEnYy2Bp5EJF57mGqHy/DFehnhhry4l4pWuJ7cIMzF+lrpG8ABhP5NkjJS0zwrj+VPrlIl8cGvXTJw12NwGptbZQroVM+u/hf9owjndKEb9pCFnozfCqk+JCVhJwZ1lQ/q/eRbU65UeRpt0YrkcNnz8SfnaE5MmYXm1zz7qe8y5bJuNgcbmVWQals1aGxfphVYPzOVI8yNobVzDBtHRWGhQysm4NtKEeeG0vcvUxb4GonBA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781104600; c=relaxed/relaxed;
	bh=ts8wGeDzZal8GxfKYhzw5ox6k82S2BLaK+sms3HyOZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BfYEwdTRR1FgGufxshr1wP2SuWmAQXmiKIFjcPlKHJBAhyeQbjOgAh6bLZYE8xRj4zy9+465Tc7td1H6BUULXMAQGnt4/fDRb7BEmSuhQ1kUCx/1zV5LnIY9lMtfu8qXqixO+KbjSVs8LdiNF0ityDElsyFuHcpBcI+1VhbPG0HiT/+Ed+U1dApVeTrh2vj+lr62zc9O/j9hvNY6TbGulom5W/D6dG6zugXlQ5bb535rrs+5Shf0idNWScIj8jJbYC5Unb4eGJJBmpmC67sJHSneBtZoagGn79TS55tMg1RU+QljybQAAEoFhGqtcHs0dFSJS8mtYMvtoTjYKpHCmg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VBg4XMjR; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::e2d; helo=mail-vs1-xe2d.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VBg4XMjR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::e2d; helo=mail-vs1-xe2d.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gb8WW33krz2yNn
	for <linux-aspeed@lists.ozlabs.org>; Thu, 11 Jun 2026 01:16:38 +1000 (AEST)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-6ca16bbc52aso2182085137.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 10 Jun 2026 08:16:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781104596; cv=none;
        d=google.com; s=arc-20240605;
        b=N5qc6rRBvKrfgOWp6WOBEdv4fK4Sa+1tBA0cHRlbhiPiFA6ohFLoVPmNqMXiYRKO29
         rj+xoc6r1cstnA4yGmMTI7zVfLaVnLbMcBKxDfL+3R3m/ZePlSRaXQb2/IIqN//LMQZr
         IHbNcfDmDvlaqAtiZi+QGSAaQnyFEwHQa1KBSXfKNSYbm7mjgCnz+giIVh7uqRiX9rF7
         fOFf9F1Uy9piAfvwl2l9EQQi6UEVXzEdQmmcVl+RBjzLw2VzZWZfavYMEPkalx9IPMb3
         ug/JUwmOdHEpWv8i4KVmkj4vCzF9GO7E8NVj+89TWvkb0h2ci+FdlwlM9NuQJMv9elp9
         hKKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ts8wGeDzZal8GxfKYhzw5ox6k82S2BLaK+sms3HyOZM=;
        fh=4Zp6uJPbZh6r7JMH1jIY4eYlB3Qa3UislpQAb2KSL3s=;
        b=aswDvVlcSEYUp6DutwQXjp9LcSoWV/lZzAULqG2fBu8fE2siD5O1YYdgNciL8UoGU3
         vPro97K2nMNfO7qjRUqArNoqUUxxQ5sjSJZ0RsdqxLd4ljyKvcyIy7G8f/GOmWz3i9rk
         lJzxhGawMTZOYF+AfDuZwsrSHWllvzepHvtmammDzSn5n5NbbaYcUpt3jM25un5R57zY
         Tc6jVJZn+Y23q41xIUFLohBRqlaKktDy6Ls/duGE+lCwJyag/bkE/TgUSaDf3dBdUMNQ
         v3Q4VqXp51s3TftAd6dTa4aeZns1KtqTrS9XMEUPj0dTr6nztLXcTkaYiVuQOf3pe09e
         DvbQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781104596; x=1781709396; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ts8wGeDzZal8GxfKYhzw5ox6k82S2BLaK+sms3HyOZM=;
        b=VBg4XMjRAuMzjLXmX74HbkILy1KekWF2H3dw2LZE1o10IMn/PUrwGNNOTe31iHwvjO
         gaTS4+3GfgB9MiVsHlTxq63+E16Vk7zVXs1AFUJI/QmdipztshM2+cQiuAPjagqguEQb
         n95bVWxwvl2Dgb45WJqrZrA4YxRpF54CebNmOW76KTpO9XovfJ4Uz8TvccUMWhSxKv2R
         WBaV7S5fOVIzqAchlSgM4Q2fRKPQFyFESWzBIZV8yRadYFQe4pe7L0iInIpn0xWW+L5T
         ooER8cVKXVDvfTqO6nHX3qy3LKUPF8bJaY3n8akJGe3FuJojmAlC3TK3pi5WtUu4FFfR
         tDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781104596; x=1781709396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ts8wGeDzZal8GxfKYhzw5ox6k82S2BLaK+sms3HyOZM=;
        b=gzu5PdVmTln01ijERuGaOVu/PL6KLAfyOt4I+f98gaGIZ9DO/R3pj5I8Uxmjlnz/rv
         NPTZ8pCFThqraOegzyf75aJhd4i6c6tJbFuY2I4Bhu8eXTvCsooRR6k9E/kBgRl7tMWO
         7I9xUnaRy0URroJhnqL6jL6xKYvzz6bR+hxYolIOJTwsSp04qrsozAZgfk4Hflef2Yrs
         HHFknxQPpaTxUGi8o+Lzf9cThMIrwSa35yjMpbefxN8rURx/k+4m+5CFzie/z4yupyUv
         zJrREHIFAiAkGO0YDzvCZycDpk+i6xINwIIs67d+TO7HgjSDA/WtYln7uUPfJintqJXH
         JViw==
X-Forwarded-Encrypted: i=1; AFNElJ8HSO2ci3sobb835gKeEHvAgGG37wui4qN47Nb/XRnHVvJBM/EpcU83IT7jPWk2EzytVOtRK/d/jJXHpdc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy6cm98CwG9OjkQ81L485MX3wq+VA6jtKO8rTMDIEf3CCFFPInw
	GX/vy12wrp4eH+D6bsFjO4Cj9nVny9jMz3kDE3nN9Pcgnzm6+tc40Nw8xh7/oKB5g2f7A0bbMik
	Ef2nKq8PcalyrqydWajyonQPlxopO4sQ=
X-Gm-Gg: Acq92OEVWTSWtCzKgaJBZ2+O+4J9b+paHWMtRjSN6tsmWkYpL+481aMfyjqvwvnY9uT
	IcHIsA/rKxCSnKNqAwDPB41rpKvycCkYTjOo22NgiMWhrmR2wIvNPV/8m+stboH63WKAGAob7cB
	Fs07/W8q5/LPIASIzoysNbWmHkVuR1CihK9ucXzm4PjWRG8rk88nReXCfu78BGmT2OklPph5gzu
	SQSyzpbqi+3U6hPD6YPYuo9KNFqSxiuwwC7TsrRgpT5yTN1pe7idK+MzoRCtfK329wbEm6P6Fz2
	PVkKJ8ivNdjKoKzBWXdd
X-Received: by 2002:a05:6102:6447:b0:631:b834:e05f with SMTP id
 ada2fe7eead31-6ff0610caf4mr14199152137.11.1781104595646; Wed, 10 Jun 2026
 08:16:35 -0700 (PDT)
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
References: <20260602-anacapa-devlop-phase-devicetree-v3-0-7c93c5df8d9b@gmail.com>
 <2d1095b342fe0f4b1b4b99b22bb3af410d9aa60e.camel@codeconstruct.com.au>
In-Reply-To: <2d1095b342fe0f4b1b4b99b22bb3af410d9aa60e.camel@codeconstruct.com.au>
From: Colin Huang <u8813345@gmail.com>
Date: Wed, 10 Jun 2026 23:16:24 +0800
X-Gm-Features: AVVi8Cc7NRfVUhw9WT9jp6Y4XQLBetD1jrzFvFoN05U7Qh5wPj_DELWRqc2qZTs
Message-ID: <CAPBH0A-8VcJ7zDfKrhKn3ZhqdKxz2vt1umJShtHre4=H31pkcg@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] ARM: dts: aspeed: anacapa: restructure devicetree
 for development-phase
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, colin.huang2@amd.com, 
	Carl Lee <carl.lee@amd.com>, Rex Fu <rex.fu.amd@gmail.com>, Andy Chung <Andy.Chung@amd.com>, 
	Peter Shen <peter.shen@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andrew Jeffery <andrew@codeconstruct.com.au> =E6=96=BC 2026=E5=B9=B46=E6=9C=
=8810=E6=97=A5=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=889:04=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Tue, 2026-06-02 at 21:24 +0800, Colin Huang via B4 Relay wrote:
> > This series refactors the Anacapa BMC devicetree layout to better suppo=
rt
> > development-phase hardware revisions (EVT1/EVT2/DVT) while keeping a pl=
atform
> > entrypoint.
> >
> > Signed-off-by: Colin Huang <u8813345@gmail.com>
> > ---
> > Changes in v3:
> > - Restructure the EVT2 devicetree to inherit from the EVT1 devicetree, =
making it incremental rather than standalone.
> > - Add the DVT devicetree, inheriting from the EVT2 devicetree.
> > - Enable MCTP and FRU support for the NIC.
> > - Align PDB fan GPIO numbering.
> > - Add an EEPROM device node for the NFC adaptor board.
> > - Add an additional EEPROM device node for the SCM.
> > - Add shunt resistor values for HSC monitors
> > - Link to v2: https://lore.kernel.org/r/20260409-anacapa-devlop-phase-d=
evicetree-v2-0-68f328671653@gmail.com
> >
>
> So just to check, the changes in patches 5-8 inclusive are applicable
> to all of EVT1, EVT2 and DVT (given the way you've structured the
> includes)?

Yes, these patch apply to all development phase.

>
> > Changes in v2:
> > - Fix dtbs_check fail.
> >   Validated by following command:
> >     make dt_binding_check DT_SCHEMA_FILES=3Darm/aspeed/aspeed.yaml
> >     make CHECK_DTBS=3Dy DT_SCHEMA_FILES=3Darm/aspeed/aspeed.yaml aspeed=
/aspeed-bmc-facebook-anacapa.dtb
> >     make CHECK_DTBS=3Dy DT_SCHEMA_FILES=3Darm/aspeed/aspeed.yaml aspeed=
/aspeed-bmc-facebook-anacapa-evt1.dtb
> >     make CHECK_DTBS=3Dy DT_SCHEMA_FILES=3Darm/aspeed/aspeed.yaml aspeed=
/aspeed-bmc-facebook-anacapa-evt2.dtb
> > - Link to v1: https://lore.kernel.org/r/20260407-anacapa-devlop-phase-d=
evicetree-v1-0-97b96367cac3@gmail.com
> >
> > ---
> > Andy Chung (1):
> >       ARM: dts: aspeed: anacapa: Enable MCTP and FRU for NIC
> >
> > Carl Lee (1):
> >       ARM: dts: aspeed: anacapa: Add eeprom device node for NFC adaptor=
 board
> >
> > Colin Huang (5):
> >       dt-bindings: arm: aspeed: add Anacapa EVT1 EVT2 DVT board
> >       ARM: dts: aspeed: anacapa: add EVT1 devicetree and point wrapper =
to it
> >       ARM: dts: aspeed: anacapa: add EVT2 devicetree inheriting EVT1
> >       ARM: dts: aspeed: anacapa: add DVT devicetree inheriting EVT2
> >       ARM: dts: aspeed: anacapa: add additional EEPROM node for SCM
>
> If you need to respin this series for some reason, can you please
> capitalise the first word of the short description (the bit after the
> last ':') for the commits above and the one below?
>

Got it.  Capitalise the first word.of the short description.

> >
> > Peter Shen (1):
> >       ARM: dts: aspeed: anacapa: evt2: add shunt resistor values for HS=
C monitors
> >
> > Rex Fu (1):
> >       ARM: dts: aspeed: anacapa: Align PDB fan GPIO numbering
> >
> >  .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    3 +
> >  .../dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dts |  178 +++
> >  .../aspeed/aspeed-bmc-facebook-anacapa-evt1.dts    | 1179 ++++++++++++=
++++++++
> >  .../aspeed/aspeed-bmc-facebook-anacapa-evt2.dts    |  228 ++++
> >  .../dts/aspeed/aspeed-bmc-facebook-anacapa.dts     | 1077 +-----------=
------
> >  5 files changed, 1589 insertions(+), 1076 deletions(-)
> > ---
> > base-commit: 7ca1caf017d34396397b19fb4de9ecef256f4acc
> > change-id: 20260407-anacapa-devlop-phase-devicetree-4101d3f312c0
> >
> > Best regards,
>
> Andrew

