Return-Path: <linux-aspeed+bounces-2329-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC7FCAC5AC
	for <linux-aspeed@archiver.kernel.org>; Wed, 24 Sep 2025 01:47:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cWfqj6LpYz2yDr;
	Wed, 24 Sep 2025 11:47:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::82c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758678465;
	cv=none; b=HQPO8xkekyxLDdvTzhMV35D2K32J/dV+NBgXJOaMJXx+xmpClKdPk765TuuCLLLG6tbytz00Ykq/WEhLaa71JZfJBUn5J8bGkb5FLXAdMT/U7dmhzqzZeWlqq8+LMNbMNjybCB3GAvSvKwJrHWrz0fcldcvOHxRPkUj7HTOHWo/r3g83692tgilTtiVoxc+74soaTEhWq258K0IfKyTEDFkK+gUTmH/n8OlUwr+ArN6r84FaKKr0OJ9rhF+OxYK3ME80dgqrLgG1YUCrppq4qtMQuDJbULAAYwo6w8Bp8+Jpdo10PPkPbWd3qwalfaCopLwOIlY9QUlN3KjkKDgG8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758678465; c=relaxed/relaxed;
	bh=YLgOCUDCg3e15Xq9G1KQ1McYlea09igd4ZKI0Cxr/n0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KD5KIyWMs2Nv3iEp6qgT2e+gv7FZvmNlsni/p8oaeM1V9CHktI78Weqek8QprgHewwAHMWfkLIUrD1MSF/RxVTlGRkZ3SAeUdqfcTm+uJS4u+F6dW7S0j7nW2qZAQ9DrFRDGNrw9k1RBuBAXSVinVVpldjwAQX7Ceny9n1l4X2b5XTIT/3LDkbj0gTZV8yhd6AF/FgmG3Rjb7qLtUGP2FPN50stL+XpL0lFWR787V87ComHxqQbpjfS0WljbGCNxtfhAh0MafzPraDb7tXlRHQxkFs8sykZcQYkSxtom8HqbtRKBZOeC1OFvb1bWgcxjg9fYl66VFc8sj+NGg6lRow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LWkaouri; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::82c; helo=mail-qt1-x82c.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LWkaouri;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::82c; helo=mail-qt1-x82c.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cWfqj0JBYz2xnk
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Sep 2025 11:47:44 +1000 (AEST)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-4b7a8ceace8so68673921cf.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 23 Sep 2025 18:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758678462; x=1759283262; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLgOCUDCg3e15Xq9G1KQ1McYlea09igd4ZKI0Cxr/n0=;
        b=LWkaouriPXG0EUPkWtZCD3/ut+4iqr7LTYUYWtvVi/EVAIXIfrq3wgs8rTBL1OujKJ
         2vpQEplTx6h/tixUQQPBN810yodlLFB42TWbHZYjgtPq54ihvw4BT/72RLidiDTJxxKs
         uxz+/bUdTNv4taMUnDxFSz0mpUK3ded/lMaNXApbcsvND0JhDuF63iNtL5JMtgYLuKSq
         vddSYTS9saySpVX8n0N0c3NqRtQPxE1MCXxlveJwpJGVKDYSZkpLxaFSl0IWkq3aAvIu
         W/5s5xCrFSnyj4p6rEVH6xeQC6ndOAIzduCFoKG7isHRq92pGLx90K7mUpAdP6r9ENlr
         Mw0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758678462; x=1759283262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLgOCUDCg3e15Xq9G1KQ1McYlea09igd4ZKI0Cxr/n0=;
        b=lft5XKMZzbD/lqiB8ifixesbbEUtYeUmEa3SoXtEr6sSIINBu5vzqNW6DwXkgcltjy
         nsAiZoXIjVw7HKTJfQc3X/W7jIFKNnb+Z+w+20VeIvVfNqy6QCaTaV5MHtCuXAgYtwN3
         x1nXioGebU71GEuSDEd+oCt+OItaWrKhlUVELnHAna+5s5OX7y57n1TPVeUCbpFcwAZK
         2urUFH/9hT4v9vN/CoihaTRQRngvPLR6zS2Lhijwf58Y/b1zyPYqXV4TmdvgVTXkI1l7
         vbrQ1Z3PORotPyfkiVK+9fl9q4TeKBYAaSwzdwHrALxnd0yyZAopwbnFIwzlMzF1PJZJ
         Mmzw==
X-Forwarded-Encrypted: i=1; AJvYcCV+4izSYWEbxsM3I0pgGtCmpW9F8mtYVWHMvY2UzMc/vTx31asnbxgEL2pJfx4JMGNaiu741irjtrxXbjg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxT9N1MYqJlKQ6CWgUopGDlw61m/szEdWpRCn166Uw31fbaMb95
	l0wcOiNQ+eQYZdkvzWS/F0xtYPlsnw6RYu8idOqjeX/cqL6XMQtfbz3w0nHeO5FiJGolLxe9KZB
	REM6UwvR5WHseFzyZO3BLEIXNP3eNK4ZXR5Qg
X-Gm-Gg: ASbGncs6U4cc0iuZwe4LioFnml75rTw01O5b+NH1W9rpX6yRASRFbNq07UVRbTnEMUY
	xGuhsUj8niFipWYXLHOZfJT7tKN3y0lpmNgCGV9h+Dg8m7hMHk/c7JZBRNPbN9lV3Nw4Vbn44hP
	7bFtisKwmNEIX51ujdsUoh/QvUChMiSSIBit8JnQRnw7qkglKDkR4WE1Z/QvpeVLuJmkeYdxjcv
	dsByll8qhD7IW0+pWucUpR3xeDT0StyO/hPZWicqQ==
X-Google-Smtp-Source: AGHT+IGIdRfHkiKs+mEVrqwOIqebc0C5zEl3UZbwuHFpU0JBMj41WZopp8n9Y9s727VjtGPa/Ul2Bjj4jr777iaGRvg=
X-Received: by 2002:ac8:5ccc:0:b0:4b6:299d:dfe4 with SMTP id
 d75a77b69052e-4d36b0ee114mr51190071cf.32.1758678461949; Tue, 23 Sep 2025
 18:47:41 -0700 (PDT)
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
References: <20250917101828.2589069-1-peteryin.openbmc@gmail.com>
 <20250917101828.2589069-4-peteryin.openbmc@gmail.com> <f76e867ca4dff82744958a8b555cf226139bcd78.camel@codeconstruct.com.au>
In-Reply-To: <f76e867ca4dff82744958a8b555cf226139bcd78.camel@codeconstruct.com.au>
From: Peter Yin <peteryin.openbmc@gmail.com>
Date: Wed, 24 Sep 2025 09:47:31 +0800
X-Gm-Features: AS18NWC-njmIqq9F1PhVUvHcod54siZvcbKXObiObG8-iSHcZRG1G-1XqSgV-2s
Message-ID: <CAPSyxFSOBRT8muKmFbqc+_OkKZvO9YR9_bGvHVGaC2XP4yi=cg@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] ARM: dts: aspeed: harma: add sq52206 power monitor device
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andrew Jeffery <andrew@codeconstruct.com.au> =E6=96=BC 2025=E5=B9=B49=E6=9C=
=8822=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8811:36=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Wed, 2025-09-17 at 18:18 +0800, Peter Yin wrote:
> > Add the SQ52206 power monitor device and reorder the sequence.
> >
> > Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> > ---
> >  .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 28 +++++++++++------
> > --
> >  1 file changed, 17 insertions(+), 11 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> > b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> > index bcef91e6eb54..fe72d47a7632 100644
> > --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> > +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
> > @@ -353,14 +353,15 @@ eeprom@52 {
> >               reg =3D <0x52>;
> >       };
> >
> > -     power-monitor@69 {
> > -             compatible =3D "pmbus";
> > -             reg =3D <0x69>;
> > +     power-monitor@40 {
> > +             compatible =3D "infineon,xdp710";
> > +             reg =3D <0x40>;
> >       };
> >
> > -     temperature-sensor@49 {
> > -             compatible =3D "ti,tmp75";
> > -             reg =3D <0x49>;
> > +     power-monitor@41 {
> > +             compatible =3D "silergy,sq52206";
> > +             reg =3D <0x41>;
> > +             shunt-resistor =3D <500>;
> >       };
> >
> >       power-monitor@44 {
> > @@ -369,16 +370,21 @@ power-monitor@44 {
> >               shunt-resistor-micro-ohms =3D <250>;
> >       };
> >
> > -     power-monitor@40 {
> > -             compatible =3D "infineon,xdp710";
> > -             reg =3D <0x40>;
> > -     };
> > -
> >       power-monitor@45 {
> >               compatible =3D "ti,ina238";
> >               reg =3D <0x45>;
> >               shunt-resistor =3D <500>;
> >       };
> > +
> > +     power-monitor@69 {
> > +             compatible =3D "pmbus";
>
> I realise you're just moving this node, but I'm surprised it hasn't
> caused trouble otherwise. This happens to work due to a quirk of I2C
> device IDs in the kernel but it's not a documented compatible.
>
> Compatible strings need to represent the physical device. Can you
> please split out a patch either dropping this node, or replacing the
> compatible string with something appropriate?
>
> Andrew

Ok, but this device BMR350 is not in the pmbus_id[] list.
I will add BMR350 to the pmbus_id[] list, and then fix the DTS
compatible string.

