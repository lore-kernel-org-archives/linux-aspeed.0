Return-Path: <linux-aspeed+bounces-3541-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92024EEC2A9
	for <linux-aspeed@archiver.kernel.org>; Mon, 23 Feb 2026 23:07:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fKc1L3Btdz3cBb;
	Tue, 24 Feb 2026 10:06:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::102b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771846485;
	cv=pass; b=GMZh8/Sbq7F4G8KQVQQ78for1lov8Z4Y8MCajQUzGLfhKcSXGHi6dlA7CieEbfm1cXViGblWaNvRBfbl+wyxnpeweTGmDKawNVYHpCpniPMELbgq36PmUoLaEFZh/3capzd9YOaQt65Got/FRk4MwPf14Tg7jiFTHnkdyQ5J673mGdVqlk1zMzwP0iwmyRXTZ3cSC6vHD8WIKU5+VVSIjMa6W0T5/iYGFPLuVP5rUR2r8B3OJGhHS4tknrZ6tn9PB0uU0ZnELEpNauuwGhqgoCpsaY65BOkI3Z/kW+INg66zGd0lmpKPrwsIkQQB/ODCJOcuWC5/G7DBvSn0D98Wpg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771846485; c=relaxed/relaxed;
	bh=mGYStsQlHuKPzU2WNtYOMLZuzbUrY0YdQicljirRGq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A2GpMGw+8lNyBT5njLvoTh3z7LmnZQVgH9beOuB11q6Ky6FkjotgQCsO457ADCKKoerx6zUSdSTRUiRYalK8r1TeU4YakEBt4iMJ/pyFHgeI2KHMDNrCI7hTShaxsYSRYcZz+APlQnAi/B7uKBjP0JCjo+GZeE2N3JxKJx3Jsh0Sf65I1ppSNIAlGev1bLlKtu5fVsuB5fDRF5OY14DJy2JOVgNcGP2EX6WMmK/540v4ImcYyY4opzuZN30tFE2P9jv4AL/Q0qBEcxqAS2uBV50DxCmwankkfIaD2mSYeOn46YrfmaCBesLlyLAHSAIxJ/WGuK36gKm+rHTVBDFBhA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ZdY/omuJ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ZdY/omuJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fKJfr4Sztz2xN8
	for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Feb 2026 22:34:44 +1100 (AEDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-3530e7b3dc2so4377384a91.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Feb 2026 03:34:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771846483; cv=none;
        d=google.com; s=arc-20240605;
        b=ioI7N+OUP8R7P0l+enBzOFhz7ZHsCw4x0Wn2i44p3tRXUa8k01hoyWgWSgaWPjWOV/
         ZsrldQS5w09yAtQdfLsAsrF1MfQgDBy6asgNBM8Q9r/mM4wMK2I9TPuA1i0Nhko88dnJ
         Mo1QDedIhIMuW9w/mndQoV/2uvyEnqX0yy63JRJlzmU/CQ9E/nSVC7olQKWtOzdSE5aa
         koJ2MT0vvR0o+c4I5qOhW3m0ycNvk4oTJ9ibJLSFCL+6eRH2sM/jSPnxISfUgOtrAJnb
         dQWOHXg2ZiyeHv71YwR86jyVGZheUjNjiPXC3L21xbeoBU8fMtmEaE9IEOze69XaNeUb
         3O6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mGYStsQlHuKPzU2WNtYOMLZuzbUrY0YdQicljirRGq0=;
        fh=wXzFnwTxHzxvJcgPixjKKQFMGOPSI3WjIiSW8EuktZk=;
        b=KSwNgVpJ821kcJ69AsuK7EJ1OuaZYDtX9SEkvt36M6yunY1AoAavHy6T3tmEa4o2nG
         vG/YuPsv+BON/nwf0+GWRkRLGjO4SY5bUuDVYjtBzA8/jnjievM1ztFylvWL/oTDQGXl
         JBTJISg8pIO7dFomZLvlvXghp4mrP16Qh+e7BFI/yIo7VidC8SJ/7z58P1nWpj6zsKJu
         g19/ggTkEJ4d7mBV0BmfyhDkdEwW0NMXqdVoQdJEWXBqG6whUsR/df5kJcKkKZAvO8cv
         xIFlWw306vb6WOGECEBtocNcwkJ+aRqvZPETVJ7sU1U0ksKBPa4YS+9ETwGjfNgDz5vh
         PCtQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771846483; x=1772451283; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGYStsQlHuKPzU2WNtYOMLZuzbUrY0YdQicljirRGq0=;
        b=ZdY/omuJbVIXUASgoKW5/0pNbqXKlauNkPTr2GIfWMoClZIUPkHEdTsZlCYMekemaM
         ewnc90nWqTrBstYG/wHuppWVkWWO9inYVIdcPCI8ERQUbFywWE+fNwujFQFT2cavKXzW
         hr9pVQqlKY424RGj4nE6gobYICkEzHxa/niBfPCSGRwTrIE7aoEb5sl1D9Dgo/H7nvl+
         5dUJcwgORXGhIIXJlRxZv9sIfHdBxDbvsCIyVhKt792SrhwuWbLdUBSWy3JxrdeXSxji
         DokozO3cXeMt+rNnLnG37b9A5kje3UOJtFRdY74LOoNjkeMf6rbCTNNmIyxPzOu5YTnf
         1/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771846483; x=1772451283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mGYStsQlHuKPzU2WNtYOMLZuzbUrY0YdQicljirRGq0=;
        b=GcdEVHNgN0Sb/Gig321L4OGFVMNQXrnd8RrmHsIVW8rn2EJYbLUSacQReq5r1VsrXl
         sPJEzjlJSkCvb8SHCdA5B8eILHsW3G+BMHGRuHKYcQG+e5JYZyOuoCYYT5RUJoUr/nxn
         QhHT78PRuNFoAy6djYI3CtAojqvevlk2YkXRTHJSO7iO4XP0cbXCCkY5IdAoDFGsN3m2
         DOKj51MfYv+w6VioYyPmx9ZztYso58Co31kixg3GimMkklihYITkyeBi3yxE7r8Gqa8Y
         bMXOpPvTEJzUAW+ZpWyxj32osfm+CqsMABc4EFX4m3g0oJbing8u5KUmzcQhi9cmhny8
         N6Tw==
X-Forwarded-Encrypted: i=1; AJvYcCUgxtizdiSnJXlFIe4e11lWavLrTLd5KkxkffCCR0lQ2DdL82twhRvQYZyx3E1eINMHxEsWpGkir56r8oA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxHJdfCHObo44/O5CUpgpT69vPFOvwaq/H8RsThBmh3qU4uCMjP
	sb840biXtwDQnKHrJHLnVekYmozqQFstGJoovyDpSDxbYDJUaqbBsYNfg0TtpxFzkGsmLWG3+/s
	kWyONovV8QMadJt/gKTl4Xlk1Cka9K3k=
X-Gm-Gg: ATEYQzyxeRnmaSMy4ojZOFcPXWqaaw2u769/e5rQRRcQheGu1KZgOLfI99V58wTeRuL
	/H6xnkLuEkNaF5J9kXgY6MiXKZhTaivM/fDaT/U1ccdmHlxSVO/QlnYCQKMQooC3SFLuq0BL3Ih
	ZHeR4Gbcr+9gQtmqXpbm8edaLYtXMSzKGNDsn7zwTYVKlH9jPr9esrMLhV9pec64ugzNeaM7z6/
	dXa7y92zQDXcSHmWJKJyqtoCiBWxelJiVN7Wbpbi2+HEBKJxDnqSuU6OlA19kgJcws+9toCftxr
	4UE+fphE
X-Received: by 2002:a17:90b:1d82:b0:354:c7f8:6d7b with SMTP id
 98e67ed59e1d1-358ae8d0700mr7036064a91.27.1771846482857; Mon, 23 Feb 2026
 03:34:42 -0800 (PST)
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
 <20260130-yv5_revise_dts-v4-6-4d924455f3a7@gmail.com> <62b7557d7af89742d142c1c8d317b8fa14f7ba24.camel@codeconstruct.com.au>
In-Reply-To: <62b7557d7af89742d142c1c8d317b8fa14f7ba24.camel@codeconstruct.com.au>
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Mon, 23 Feb 2026 19:34:31 +0800
X-Gm-Features: AaiRm506Z318uNW6kWrp7bDcWB7y0VDBV6c7Bjo1a43ppRROQOdO1rn-vpstytM
Message-ID: <CABh9gBduHH5qN7Sv_Baoj=khADxEDv2zJFgXWBQi1K7SS6bRGQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] ARM: dts: aspeed: yosemite5: Add PDB IO expander
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Amithash Prasasd <amithash@meta.com>, 
	Kevin Tung <Kevin.Tung@quantatw.com>, Ken Chen <Ken.Chen@quantatw.com>, 
	Leo Yang <Leo-Yang@quantatw.com>, Jackson Liu <Jackson.Liu@quantatw.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 2:27=E2=80=AFPM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> On Fri, 2026-01-30 at 16:20 +0800, Kevin Tung wrote:
> > The new hardware design adds an IO expander on the PDB
> >
>
> What does "PDB" mean? Can you please expand this in the commit message?
>
> >  to support
> > fan presence detection and HSC
> >
>
> What does "HSC" mean? Can you please expand this in the commit message?
>
Hi Andrew,

Sure, I have expanded both abbreviations in the commit message as requested=
.

Kevin

> >  fault monitoring. So Add the PDB
> > IO expander device node to the DTS.
> >
> > The IO expander interrupt is connected to SGPIO92, which was
> > previously named ALERT_PADDLE2_SMB_N and not used by the system.
> > This pin is now repurposed and renamed to FM_IOE_ALT_N to reflect
> > its function as the PDB IO expander interrupt.
> >
> > Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
> > ---
> >  .../dts/aspeed/aspeed-bmc-facebook-yosemite5.dts    | 21 +++++++++++++=
+++++++-
> >  1 file changed, 20 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts=
 b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
> > index 524597a81365ef10cd03b67d35eeb88a965cbe0a..48f864b52d1a22b12f8a39b=
a9703a90349ed930d 100644
> > --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
> > +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
> > @@ -389,6 +389,25 @@ adc@1d {
> >               ti,mode =3D /bits/ 8 <1>;
> >       };
> >
> > +     /* PDB IOEXP */
> > +     gpio-expander@24 {
> > +             compatible =3D "nxp,pca9555";
> > +             reg =3D <0x24>;
> > +             interrupt-parent =3D <&sgpiom0>;
> > +             interrupts =3D <92 IRQ_TYPE_LEVEL_LOW>;
> > +             gpio-controller;
> > +             #gpio-cells =3D <2>;
> > +             gpio-line-names =3D
> > +                     "FM_P52V_AUX_FLT_N", "FM_P12V_AUX_PWRGD",
> > +                     "FM_SLOTX_HSC_FAULT_N_FF", "",
> > +                     "","",
> > +                     "","",
> > +                     "PRSNT_FAN0","PRSNT_FAN1",
> > +                     "PRSNT_FAN2","PRSNT_FAN3",
> > +                     "","",
> > +                     "","";
> > +     };
> > +
> >       power-sensor@40 {
> >               compatible =3D "ti,ina238";
> >               reg =3D <0x40>;
> > @@ -937,7 +956,7 @@ &sgpiom0 {
> >       "ALERT_OC_PADDLE2_N","",
> >       "ALERT_OC_PWR2_N","",
> >       "ALERT_OC_PWR11_N","",
> > -     "ALERT_PADDLE2_SMB_N","",
> > +     "FM_IOE_ALT_N","",
> >       "ALERT_PWR14_SB2_LEAK_DETECT_N","",
> >       /*bit48-bit55*/
> >       "ALERT_PWR14_SB3_LEAK_DETECT_N","",

