Return-Path: <linux-aspeed+bounces-3534-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B0D2EEC2A8
	for <linux-aspeed@archiver.kernel.org>; Mon, 23 Feb 2026 23:00:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fKbsV2Fyfz3c95;
	Tue, 24 Feb 2026 09:59:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::533" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771846236;
	cv=pass; b=SmIfERkEUFctNlp+DxzKqqd2H/95OmgKchlzfqZP3Zo6Ubft0cBUVaOy7KgSNuDemqp7dsMg50LHc3hQ2u0pJlLkH4TEf5BLtLrzEl3KTlUf4F/MMnaMYz9EgKq5A/kF9zr7ZRPl8ud+cRItOG2yPxP0Z9GEpHTIi0QSW66dxYKyKAO1BzlMp9srVIFJSDH8G6xr+xhP61i63mjGoiWeDIHMjWjCdmp+KrcK6+bkX7ttFG+qkga2PUCrCXh7trIJe4b6eklFEXNaowIr+s2BzkI1DA5pf9Z8TUULA3ULIDHaHwy8VBfM+KsTn+E2FfOs6JwqR8pgVyZqJiudHudYYA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771846236; c=relaxed/relaxed;
	bh=Br5siVwmXHkLMmqx3d4sgf29fX12Q6bdQRYt3PwHjas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=We+b7SUJSaAkl2UP2zShE9MeJFsFZHPmSabRTFb9HsKaieLUViLu9JVL53d5EvcK0YfLR3Ze5+rNOvTa7S7fG2trFOwsyVhkcqZixu6T4lGd+R/JYSc7b0PZ6K9FxJdonaRmzyX/SFkFLsOCDER9EMfTsvUL4RRkMie29zou3UTsXqdgYxdqVK2dlzA/9ZdFGHMVXd/Qq22LDBgi9s5AZhWjdTMxJrNp+pzaYKvjXTAMmLMxUzJF70fx3fPuvsBMivUNOF9tWbIjaIHx/j+pCSR6m8CufKUvuCRU8RmtMSIM3XHwIbzTu7FB4qVgOygmONkGCRmpuCJ0U37gxi4YWw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=AEtveWTS; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=AEtveWTS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fKJZ36h4Pz2xN8
	for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Feb 2026 22:30:34 +1100 (AEDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-c6e734ba92bso2047058a12.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Feb 2026 03:30:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771846232; cv=none;
        d=google.com; s=arc-20240605;
        b=KaPrkF5sWGBFGqLffRVXmzh18DKE42t+kmcjKptQcZI3SxTPeX2hby+fm2q0iUEBYY
         2yvSDFL1DHPtkl3Nq9bfG1gzdf9xwnEYerO63IzlEQs2spJeAog6VhAoHuq/S0J56Alv
         DDFFDS+W55SrCV0xLynx6GIDg4XIQmNW6yf9chqO5JjCdE0kQOPEJAZytcfm+QCRt/MJ
         kCV7LO+A95e0hB5un1IRxTHitg3nerIixI4gxx0wiA3UK12h/F7DB6PkHIOgx5jq90f9
         +YacYh5Rh8LjyOXy/O/aSwbHmvwd9L+PoY5cu0oylJdm4LhOYxLP6/6ipnDRsFHkSHrC
         1jNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Br5siVwmXHkLMmqx3d4sgf29fX12Q6bdQRYt3PwHjas=;
        fh=PyM/T4dRxP5+2dqgEoWTj9Su3rTXWiBdcttWiZMm8Z0=;
        b=F8wVD7JzpqEBAsepGm2kJp29D4F8N1CTr7gmOFBdicovPcsbKfY/lP2Jct15NxGh5f
         ZnAPuFaRNyWrJeScEYY1pyG89KBHm1p/rS8iUo2kEHRXDLkLbuwE8zkCkugaNTVHvRz9
         /W+D4MHVxva/rNNNr/Fn3xI8O5a6mAANkFxC+KVUlnaZxj4ArWW93GARY/s+7bnkp8MK
         h2amDO0nlUDV69fQ40GCqRk5inq1TerYIHPr5yla06SgJI9N/IEzEdW4FyPWGVVE0nRx
         xU/SfjlLnvay5CrmybsLNdh7ta6JgSCUvxP5LBNDlp8Rq2M2+Peb63g1cs1cdkRToq9f
         GUnw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771846232; x=1772451032; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Br5siVwmXHkLMmqx3d4sgf29fX12Q6bdQRYt3PwHjas=;
        b=AEtveWTSCxEHYyGgNY1vRkDiIbU0qtkdNJapvJ9mRlehUmlvKfNnsRsXU7t4gsCchN
         e/CFTrR1IzW+BIoIcYuZCsJB2/1CQTxYVK7mutbihk1z6Q7LAVW2weD6XoKDo129dYUf
         i81lXNYyjN39raFCk3YPX6HGVJxa5DaLd5ryE3Q3GMmHjEUWJd7UB0xpG82LU7AM6YxL
         xs2M9tCzBzX4y24QRHQFTnthySuRsX6ImmRFprAi8eXpnyuk6CR+Tovl8F9aAwxM8R1l
         tb0xuXJtF326eurIDETVwZgWoQk2050oj/CPn7cywCCiw63xAFECKdJ+slgVDhpo8yXl
         KzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771846232; x=1772451032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Br5siVwmXHkLMmqx3d4sgf29fX12Q6bdQRYt3PwHjas=;
        b=MspntC/9XZDFn/FdMvv6m/Ps4cIk6JpZZMTfNgNFECKYNywIvOC0OIcyiP1ZabWk7m
         Liy7k+/87Nu1AEhYNlPklF8CaQg7FtWh30tNiw11XO+wy0xD9ggJS4HNH4izCx4in98j
         zLmpbMyHDES8LuxRIHwRaHQb48CEEF4cyF0as/k9mVgOuCvKApLlEg+eDOn7J9pn+spP
         cVlcTrnnjTw++BDWMUB7GpFIa0kN9xH1DrlhAZgVuMXMGH0/TXftm6otw/iycnZLkLx7
         +PUnBM9JP4tLIkVvQBaVAxiSHdm2RXkQxty5insETxDXVNs8IRHjruyBmWYlRneuwzNz
         v6hw==
X-Forwarded-Encrypted: i=1; AJvYcCWqRPZADca7PlAq4NbOXTqyFtVSvwVUf46gSehHxGwVtWyU4yNMa1tNXmsv7q/q3ungeaqZk9CvFbwTzfY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzoIXRlTSI1ZINeKuvnnfR+/xvpXGTBJTc12rhhv00T4WCKoYSQ
	NslMY1vVe6y9HJkqp48I711lvLTRZWtxxChh53KxIPMOnLSThGbf0ikbbicNY7gD/6OXadGulRg
	Bw46kScTw8pCnkoBbs0HKBUUNokXvSUE=
X-Gm-Gg: ATEYQzwqmzGVswOfJdaSWSshvLhHWkoz65uOlRz0eGRdsuL0lcMpqA80K5e+uYKj0fY
	tWq6NFMOEsZ9bsoe89u/wU5D953alWeQW7hJW2ekjibfbASBUl07lQgV8tUEmsMoNR5tux83DFh
	09LJQiJvIGnU3PFeFO7dbt6Cs/GW8bEbksLhfUuMlJHE/g/z1pB/MC/foUewMAMGGQ+4/FtZ6GW
	Bp7ztPr5HguM/5254cY5nBPGCKDJ5uMPKQbNibeBRqJ0bzpSVRI6EoegSSouj4SFinstqQwLHHG
	nhehx2zTTUL4xXhhKbM=
X-Received: by 2002:a17:902:d508:b0:2a7:95d0:d77d with SMTP id
 d9443c01a7336-2ad7453d949mr77681755ad.30.1771846232419; Mon, 23 Feb 2026
 03:30:32 -0800 (PST)
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
References: <20260130-yv5_revise_dts-v4-0-4d924455f3a7@gmail.com>
 <20260130-yv5_revise_dts-v4-5-4d924455f3a7@gmail.com> <73c63bc2f5eaae2c931a4ced1462024bd5a24237.camel@codeconstruct.com.au>
In-Reply-To: <73c63bc2f5eaae2c931a4ced1462024bd5a24237.camel@codeconstruct.com.au>
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Mon, 23 Feb 2026 19:30:21 +0800
X-Gm-Features: AaiRm525snvy4mZcI-Gd7f7l6WX-PGaNQoSq0zz-Wk8sNwF6B9itjJFnA30z6ik
Message-ID: <CABh9gBfuacGFHqSFT-fvE78bx7Q9vZGYzz=4frP2MTM0J0yNWA@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] ARM: dts: aspeed: yosemite5: Correct power monitor
 shunt resistor
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Amithash Prasasd <amithash@meta.com>, 
	Kevin Tung <Kevin.Tung@quantatw.com>, Ken Chen <Ken.Chen@quantatw.com>, 
	Leo Yang <Leo-Yang@quantatw.com>, Jackson Liu <Jackson.Liu@quantatw.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 2:21=E2=80=AFPM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> Hi Kevin,
>
> On Fri, 2026-01-30 at 16:20 +0800, Kevin Tung wrote:
> > The shunt resistor value defined in the DTS was incorrect and did not
> > reflect the resistor value populated on the board. As a result, power
> > and current readings derived from this value were inaccurate.
>
> Okay, but how did it come to be incorrect in the devicetree? Was the
> documentation wrong and so someone entered the wrong value? Was the
> documentation correct but there was a misunderstanding? Did the
> hardware design change and the devicetree is now just inappropriate for
> your needs?
>
> Essentially, what's preventing this from happening again?
>

Hi Andrew,

The root cause is a hardware design change, which made the previous
devicetree configuration is inappropriate for our needs.
I have updated the commit message to reflect this.

The changes have been confirmed by our power team, verifying that the
power readings now match the latest hardware design.

> >
> > This change
> >
>
> I'd rather you rephrase this to avoid using "This change ...".
> Hopefully the commit message always refers to its change.
>
> Generally, please write in the imperative mood (see [1])
>
> [1]: https://docs.kernel.org/process/submitting-patches.html#describe-you=
r-changes
>

Updated commit message to use imperative mood, thanks for the reference.

Kevin

> > updates the DTS to use the correct shunt resistor value
> > according to the hardware design, restoring accurate power and current
> > measurements.
> >
> > Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
> > ---
> >  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts | 14 ++++++=
+-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts=
 b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
> > index 84d3731b17f7c7c87338672bbcc859de2b89b722..524597a81365ef10cd03b67=
d35eeb88a965cbe0a 100644
> > --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
> > +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
> > @@ -415,7 +415,7 @@ power-sensor@42 {
> >       power-monitor@43 {
> >               compatible =3D "lltc,ltc4287";
> >               reg =3D <0x43>;
> > -             shunt-resistor-micro-ohms =3D <250>;
> > +             shunt-resistor-micro-ohms =3D <100>;
> >       };
> >
> >       power-sensor@44 {
> > @@ -461,25 +461,25 @@ eeprom@57 {
> >       power-monitor@58 {
> >               compatible =3D "renesas,isl28022";
> >               reg =3D <0x58>;
> > -             shunt-resistor-micro-ohms =3D <1000>;
> > +             shunt-resistor-micro-ohms =3D <10000>;
> >       };
> >
> >       power-monitor@59 {
> >               compatible =3D "renesas,isl28022";
> >               reg =3D <0x59>;
> > -             shunt-resistor-micro-ohms =3D <1000>;
> > +             shunt-resistor-micro-ohms =3D <10000>;
> >       };
> >
> >       power-monitor@5a {
> >               compatible =3D "renesas,isl28022";
> >               reg =3D <0x5a>;
> > -             shunt-resistor-micro-ohms =3D <1000>;
> > +             shunt-resistor-micro-ohms =3D <10000>;
> >       };
> >
> >       power-monitor@5b {
> >               compatible =3D "renesas,isl28022";
> >               reg =3D <0x5b>;
> > -             shunt-resistor-micro-ohms =3D <1000>;
> > +             shunt-resistor-micro-ohms =3D <10000>;
> >       };
> >
> >       psu@5c {
> > @@ -723,13 +723,13 @@ gpio-expander@21 {
> >       power-sensor@40 {
> >               compatible =3D "ti,ina230";
> >               reg =3D <0x40>;
> > -             shunt-resistor =3D <2000>;
> > +             shunt-resistor =3D <1000>;
> >       };
> >
> >       power-sensor@41 {
> >               compatible =3D "ti,ina230";
> >               reg =3D <0x41>;
> > -             shunt-resistor =3D <2000>;
> > +             shunt-resistor =3D <1000>;
> >       };
> >
> >       power-sensor@42 {
>
> The way the commit message is written suggests it was just one shunt
> resistor, but that's clearly not the case.
>
> Andrew

