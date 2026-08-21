Return-Path: <linux-aspeed+bounces-4766-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F3AC5DF88
	for <linux-aspeed@archiver.kernel.org>; Fri, 21 Aug 2026 06:48:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hR9rL2H4bz2xnW;
	Fri, 21 Aug 2026 16:48:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::236" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787294930;
	cv=pass; b=hpKsW8GI9HPqrdunSnXN/d5623btvLWLtWmjG3C729yB8gD4RewYDz+3a5szm91WccvTVdbTugaZuFEA6oAkWQVc/U6aYV/Ae+4PvDQws2tvTAIkj9yNFDswB0VzYAIQI20GCwKnhg6Zfq1yZGNDdpyoyx6Y99oNVw7ZWB3F4Jbt2OBkZqlGnTBpfZ846uFP8nhambD90n09pnlMMeAXhVhTk6vN6x6pC+rHvh7Q4BRHBjkSgWmmFMTHjUHxa7shpPaKbkDhnS3NIRr8Quq0+WojLCwBHF6sBMBX8Kbm9oy1J90KRBpAT0Zo6UsOAFEsAQVp8r/QdlqVfsw9UqsQ5w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787294930; c=relaxed/relaxed;
	bh=ZZV2eo8l44i659VRpU6Jc0rPYdN+/WIVgMkUx/EFXO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yb+JKK6y6/jt0VsmoxMxyjUOHZLTbBL94XMzu+xW/J6jGAqdWrumg67t3Omx16OZyeW2BKl3l/bCSdCxduDQa868AW1UWUyOoBRWeKgptNOHyIfb5Qela6W6rSjLugSc4c9kb1PWUSfTn3G9jkPxRNWGZRw27/nCpjIEQyKW5rIcNp/iRbji63jXpf+Nab2cElPlhTM5+60SfeH5Uv5AJ3LTtFQc5PTwQM3o9QbCVBFF1xOTnijsIKXNWbqs41gsZJARtmfmdNBfQVH4u9BWCHu1Bs4NqyZcvaAkC8IAgmqkH62S/ryG12fBoMgHyd7W1dyqe5EfLwZeOC6M5VXY7g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YB0yGmJz; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::236; helo=mail-lj1-x236.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YB0yGmJz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::236; helo=mail-lj1-x236.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hR9rJ5Wqlz2xWt
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Aug 2026 16:48:47 +1000 (AEST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-39c74722e27so8959971fa.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Aug 2026 23:48:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787294924; cv=none;
        d=google.com; s=arc-20260327;
        b=gzU+jY4oV0phlfq3TVd9965CF9lE8QigRYekFyufzVMRVD3ojTlH4kY3xe3OkYVQ56
         XgAOTl2HTRnEKbzQAa+9v9FTlcqQrfxSBd4hDCxC9M3aBQXId4XiOctbSWu8SYY9OA61
         ZlTiszw8KZ005vRzNyEcvFWESYq7ZW5pabJSw24+lAqwxpG+2ISLPi7AfqLzNiCHTvsf
         pvUG4iiVXR1QjkFTOjX7itly8eO1Q0+QoUr03Ff8RHD53YDo11bvAkLcmweNVesM10wB
         1sIXHsZpNfDZlzZSSjch7i6ebv6TdKT5Y0oIlvLkhUbnyFC2ND2HzViv8ajgtMMbmQi3
         igIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZZV2eo8l44i659VRpU6Jc0rPYdN+/WIVgMkUx/EFXO4=;
        fh=0OWgvJzaQqbJ91u4wgbsS3WEjlg1DXqzUN59JzR1uvs=;
        b=RV6L9uoPyXlDPPRZg2Kbr0MnzzuSfDI2dfkWzQ6+ypFgDpZfCGiJdIrSUYpp+WDsBA
         6nqRvVqHg2BhtsgGUraa11GK/YC+uZLK9voUOxKt1Mza/ChSpRKsSlDUGKjA+UZE/YYY
         MXq3tkGxGdmxJwW75RPYDpDxiyFv6J1pPZ+nPndJEbq/SyuCQSX7JhXnWTIClVUcDVxd
         2cHS034K+QW4Iv1p/IS6gg1dwDjMrKiWyRfKNcs3b2G45KidTHa49vwAZe6S8vU2HQhc
         iFbP1nGgIi/OM/YE2RFDzUWcvl4aRk9O0H4tIs9enpWYUkZbhJg2aZsF5WH04rLglLaB
         I92A==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787294924; x=1787899724; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZZV2eo8l44i659VRpU6Jc0rPYdN+/WIVgMkUx/EFXO4=;
        b=YB0yGmJzkPVy9XmUr9pLmbVsmzGcFKOeM1BD/9rVzF4e04HKdriZGFOXvcD7UGv7XB
         pv0vA9brQIntKpYx+i5lbHqypYvRQoVy3hsZ3ApwAIedfgnnZYZCoQbcH9fkNRys65MM
         x+XzkWNh6vGuYMQteLSwxB0uY1wNJZ7pKfJ63cjMXrmzEPcOrCccQNuiPn4gyaC+orMP
         4mnkN+at26luHfnVLlWMYCDLZmC8Ey9V6Cvrh+7mUYyk2uGVsLgqcy9KJAWyrtua5yn4
         cSnbB3piUAaV6X74NNq5XrOCFkO7Rp51p1Y704nFH+ZOdlctHsBTv0LXQnZmUPDiVpBK
         N+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787294924; x=1787899724;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZZV2eo8l44i659VRpU6Jc0rPYdN+/WIVgMkUx/EFXO4=;
        b=RTZS69/qzFyWaEKu7Lw8TsUyM5CrPneJ2vkyGte47HRJGk/CAeMBi8r40ERUsklFB3
         DLtv/GLTHDfKxp5AcIDuDgofeq1ULNL8dMsLb8nRysQcg0boQAl5+fjh/ajmxjGlJ7lr
         TeTacho8KJMX4CjoE1xRkrZ3A8hLspwdui5zppUqA8whI0bC3o3Uoxh7MpOOCg2XE+uB
         BbkSis4WFZrJ2c5OIlq9GGTNrRrflGPRkQV1a5wmP7u1GwTmEjNxHvieBnu/yx7r9rAC
         Na9xU9BRn6HgLCDe9PRW1cGf6Ei8yhZnMtbxeSOiYJoPEFNeKZXlUpbhofZCeYNkwkdb
         C4Ng==
X-Forwarded-Encrypted: i=1; AHgh+RqiV074Vfy2iYMZaw42IWnM8jhUbcFY//EWbqN7Y9erNzN6onodO86QDwOEiBpUDLTrn/T2Oy+lPdoheAc=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nIaAj5pVnWQL6rDFAgbZOhqIRKZPMcQ9Nj+x6eDUYMqMZJQICH
	lTNDW9xngsJxqQ0fSB3xsqmKTEW/Ul/oHBfx5gbCo2TcMgqBAT5dKvLJrpgJCEksdIwqgil3pYK
	pf0oeD182lcYTYESVYxf8Rdni/a/iyFY=
X-Gm-Gg: AR+sD10MYfJzJbFyMJun6DD/YLP04eKg6+2sgxSUeOd6vuYA9QKu7JPfMUZQ4F38X5N
	UtOCoN5Jkyp5Af5uRFhV0IUm8ifc1CyPWD/UUb0S9iHKbuuajDduxAgUY76GIgskNSi+XCE+Ap6
	f16DW1V2/b5kNNYOz8cl54T/uCdo97yD4C7WAbWR7Rl9eyZdtYA40YWgKHDjbWk++A9qqIGco5H
	L/sQxz9vapBqvEY2JjC5NUCdWm74qs42yCmRNqyz4YJKrzHpvGLstfSxj4xtTX+eotYjj2L69yd
	zZFxYNJsS5ER+C6mWDV8CtccNHsw9CDhy+2tNPzuBsdy9g==
X-Received: by 2002:a05:651c:222b:b0:3a1:8dd6:aada with SMTP id
 38308e7fff4ca-3a1b0e134edmr3994451fa.4.1787294924052; Thu, 20 Aug 2026
 23:48:44 -0700 (PDT)
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
References: <20260727-ventura2_initial_dts-v9-0-504c0ec68039@gmail.com>
 <20260727-ventura2_initial_dts-v9-2-504c0ec68039@gmail.com>
 <178724902712.20555.7009712214570349708.b4-review@b4> <CAF7HswN1ZzwjfXjG2hV5tEkVZkZYp0CiVNSo_9A4m3tsqQp_Bg@mail.gmail.com>
In-Reply-To: <CAF7HswN1ZzwjfXjG2hV5tEkVZkZYp0CiVNSo_9A4m3tsqQp_Bg@mail.gmail.com>
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Fri, 21 Aug 2026 14:51:47 +0800
X-Gm-Features: AcwNN1U6V2Do82rvIt74ZZ-aX7aerlDnXhaA1qYUWN10XHuS2TwjSTUhQfWOomU
Message-ID: <CAF7HswMpfibMRysJQYrkA4EC2Ks3C_20nZkhpVPP3w-J4BoxQA@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] ARM: dts: aspeed: ventura2: Add Meta ventura2 BMC
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Tan Siewert <tan.siewert@9elements.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Fri, Aug 21, 2026 at 2:31=E2=80=AFPM Kyle Hsieh <kylehsieh1995@gmail.com=
> wrote:
>
> Hi Tan,
>
> Thanks for the review.
>
> On Fri, Aug 21, 2026 at 2:04=E2=80=AFAM Tan Siewert <tan.siewert@9element=
s.com> wrote:
> >
> > Hi Kyle,
> >
> > > Ventura2 is a Rack Management Controller. It is a modular
> > > device designed to manage liquid cooling systems and monitor hardware
> > > states within an IT rack. The system uses an AST2600 BMC for manageme=
nt.
> > >
> > > RMCv2 serves several critical roles:
> > > - Detects liquid leakage at both tray and rack levels.
> > > - Communicates with and controls liquid cooling equipment.
> > > - Manages leakage events and executes system recovery protocols.
> > >
> > > Key hardware features include:
> > > - An extensive I2C and IO expander topology to support comprehensive
> > >   sensor monitoring and backward compatibility with legacy trays.
> > > - MCTP over I2C support for asynchronous device communications.
> > > - A dual-flash design for BMC firmware redundancy.
> > >
> > > Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
> >
> > *snip*
> >
> > > diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dt=
s b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts
> > > new file mode 100644
> > > index 000000000000..f1273ca31bf8
> > > --- /dev/null
> > > +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts
> > > @@ -0,0 +1,3005 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +// Copyright (c) 2023 Facebook Inc.
> > > +/dts-v1/;
> > > +
> > > +#include "aspeed-g6.dtsi"
> > > +#include <dt-bindings/i2c/i2c.h>
> > > +#include <dt-bindings/gpio/aspeed-gpio.h>
> > > +
> > > +/ {
> > > +     compatible =3D "facebook,ventura2-rmc", "aspeed,ast2600";
> > > +     model =3D "Facebook Ventura2 RMC";
> > > +
> > > +     aliases {
> > > +             /*
> > > +             * Pre-allocate I2C bus aliases for userspace predictabi=
lity.
> > > +             * Several I2C channels are intentionally left empty in =
this
> > > +             * DTS as they are strictly reserved for future hardware
> > > +             * feature expansions and add-on boards that will interf=
ace
> > > +             * with these busses.
> > > +             */
> > > +             /*
> > > +             * i2c switch 0-0077, pca9548, 8 child channels assigned
> > > +             * with bus number 16-23.
> > > +             */
> >
> > This alignment is one of the things that seem to be a false-positive fo=
r
> > dt-check-style in strict mode (value-whitespace). See [0] where Krzyszt=
of said
> > that it may report false-positives, and "Review and investigate warning=
s from
> > 'strict' mode, but do not fix them automatically without thinking".
> >
> > @Krzysztof wdyt about this one?
>
> You're right, and this is a regression I introduced in v9. In v8 these co=
mment
> blocks used the standard kernel style. While running dt-check-style, I ap=
plied
> the strict-mode output too mechanically and dropped the space before '*' =
in all
> 38 comment blocks in the file. I will restore to the standard style in v1=
0.

This is the part I'd like your input on, since it goes against your v8
review where you asked me to fix the 49 mixed-indent-chars reported in
relaxed mode.

Looking at the output again, all 52 hits on the current file are on comment
lines. The standard kernel comment style '\t * ' is a tab followed by a
space, so the tool flags every correctly formatted multi-line comment. The
49 you saw in v8 were the same thing. [property-order] on the spi node
behaves the same way - it wants #address-cells and #size-cells split apart,
which is what Tan asked me to change back.

So I can either restore the kernel comment style and note these as false
positives in the cover letter, or keep the v9 form that satisfies the tool.
Which would you prefer for v10?

Thanks,
Kyle Hsieh

