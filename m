Return-Path: <linux-aspeed+bounces-2593-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007C2CCD1A5
	for <linux-aspeed@archiver.kernel.org>; Fri, 24 Oct 2025 07:57:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ctFcD3Tyyz301K;
	Fri, 24 Oct 2025 18:57:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.217.43
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761292636;
	cv=none; b=afYCsQb0QZu4U+JD8ppfxos9CDI2Vcy7jOfr06pYfDj/cbsmNjhxak62UufCXCHiQcNdn3jSmYX50jItLp+TQbDO++nD+xruGtuAGecoV7VGIMe/wrYjekvKeRQK6VznjEoc8dk8U1DfO1j0SEJtTvHFXhSXTwIF42fOtLVMjRVyU/KliYFIUEUyBebex+GUfN/y4m31HJYGpBJl+PjG1D8mWtlTX0Ki6J+RsD0hhIeUHhx+sCfAzfiV9FfaKMdrrgxnXG6pYNlztKRm/FWyv/emvDuBLh9wuSOLZyiywSNa4lm90L6+wU2D6IlW+QEXeQzPJerrlglTBhttg6S+bg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761292636; c=relaxed/relaxed;
	bh=2H0+Y+0nbHCT1nPmHP2N1suTimvZ79Q7MXGtF4XoMw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=itoUCwDONs9GaOQ83xz5TfbAWOvm1NjEMBi/wqlkCNTwTn3TQfZeUVoyvZHBqZuqDvbsMTQYy/NIetgeKXAfIqwPhkQsRSHn/g5h7T1RL3w3Ci7fVCQBPi/ByPEVUWbwTdBi1YUokyDkqRJtdhyPWtyV6sJC8AbaJ1s7Vns4nW1sWjZwRemMSTu9jgk4en+as8mt+/NtBO/Ce6gdNyLkoAy5VJj6bDmEHQzrpZfUGKfM48ydhlsXlM4N1Grrm8241f/6gwJJyYcl1O6wogrbJjHxwGbBwcFjDLMAHniwrzKInJhtjRBbC+fgJ2WephzrzKRuR8l+y8xTOnkJFLHSSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.217.43; helo=mail-vs1-f43.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.217.43; helo=mail-vs1-f43.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ctFcB6nfSz2yx8
	for <linux-aspeed@lists.ozlabs.org>; Fri, 24 Oct 2025 18:57:13 +1100 (AEDT)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5db394cf0d1so566004137.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 24 Oct 2025 00:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761292631; x=1761897431;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2H0+Y+0nbHCT1nPmHP2N1suTimvZ79Q7MXGtF4XoMw0=;
        b=fggrl7mAb/LL1lqnsHoHp7vC87geKbwgTZSy9qOHYb2NYhEQc3SRiJcmLDrZE+9DLx
         qGnlWEpQia9Faln6nY+bntfw119NWBOLTFsYzlCZ7dwpoMhkl0leuCRSEb8hSOBrKqO/
         lgWnwKyN+5/k8zl5plP797NS5AWgpbiaZ8V7Mo/3ZHM3HOL0m0nML81NT/nft6g4X0F/
         FLdAVt8kp7tNp+9g965HqgI8aG4356MIMDaeqWaT6vvnCbEW3ZpfnbJCbY5zCVYukx1o
         k+EXUvtiwHrWzXgcNhCmJmk8NJAnETRaloLV4A16omvG/YTAOLh0Y93dIQtoEEZ+h4mO
         7G9A==
X-Forwarded-Encrypted: i=1; AJvYcCWR058OXvt3P7USWkfHskXmqGXhoNwKhkoou+UjUfN+hWZHajIeL6us6cKHUQab0V39tvBRv/GswRaEe+0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx6W3PU09acNTUYwvrJdJ2fNherGHfgjqrZaVRyi6ESyObq5CTb
	7yxyv8gHVpnNq5rDWLj3fCeY03l+xK4uM/KFij/kcYnBQXSqWu/l983pQmvCuahQ
X-Gm-Gg: ASbGnctkzfXjFFYQNsPpMrkW5oFEIxyJ3L8i6ecFDFxNtBZKoN0HBNrj/bs9yUi26tZ
	E6uxlDN9tJ5JhWcRfZeURUeA3oaKeNLKZVcq1qu0U2PvADmJDRAtf1rDSUNnbfIaZtqBOkU41Z4
	r93uEF6Ag5NqmS9rYczrNGa+xWfOFoTYONQ3a2Fx+xrCxWmRe1gNCx796W4TmmnXXUT7UBo5qTL
	B2i40GqDaWSC9T3pg5Gys0H5HgToXrCQmQf6kK9GBFRaaG34xoCS3Po/vGHqK9cyIJJFX+8EQp2
	8jdWFnXTwSYrpAG8kytuJc0zEATRxTgWpKs6T+WlFTj1BmbuKjEhiKgXTjdaOaKo4Inzo3EIgWz
	kKX+b7nOrrjpcQIFV+k8kM8h1ajAHvsI6JPS3NqPkSMHhOKaI1qonBbbexvFG4Q0KhwzEiVzavP
	pMJ8wYNxG9hcj3Pkl1bngr9bX5SZXjP1qWx0a1hiIDUnGsm/XuNBNNcGJr2hM=
X-Google-Smtp-Source: AGHT+IEGFGjHlPyOUBqG/MPkEKa6ogxjoi94AjO5TwigwjFwCpu3mvShMYWRQUg20AuX3SKsC0zVdQ==
X-Received: by 2002:a05:6102:5f0c:b0:5db:27b9:c20b with SMTP id ada2fe7eead31-5db27b9ce0amr3146823137.34.1761292630684;
        Fri, 24 Oct 2025 00:57:10 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-934aba93695sm1816881241.4.2025.10.24.00.57.09
        for <linux-aspeed@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 00:57:09 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5db2d2030bbso762657137.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 24 Oct 2025 00:57:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVAAB//pgfwF+8Heh5uKaTbB8ir4JFzhFVFTAV1n+BgiuHCluXV1dimAK+rMOBNHhhoGwUG7yM1jHkVciw=@lists.ozlabs.org
X-Received: by 2002:a05:6102:50a3:b0:5db:2f62:c15 with SMTP id
 ada2fe7eead31-5db2f621029mr1782604137.41.1761292628800; Fri, 24 Oct 2025
 00:57:08 -0700 (PDT)
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
References: <20251022070543.1169173-1-ryan_chen@aspeedtech.com>
 <20251022070543.1169173-5-ryan_chen@aspeedtech.com> <b5441728-06a7-44ea-8876-3a9fc3cf55be@app.fastmail.com>
 <TY2PPF5CB9A1BE626A2F0F6307461D8F64BF2F0A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <6a97fbb4-19c2-4ffa-9c73-26aea02c27e4@app.fastmail.com>
In-Reply-To: <6a97fbb4-19c2-4ffa-9c73-26aea02c27e4@app.fastmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 24 Oct 2025 09:56:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXTZZK-Tk0gerpARfr+jUNGPhEfRqGOtTvTTJp=SZ2ayg@mail.gmail.com>
X-Gm-Features: AWmQ_bnSAouTBsQ6YdE-Y1_3m37NwmxEYp_NrgytrqguGhvssb4gZifd3I_f9eg
Message-ID: <CAMuHMdXTZZK-Tk0gerpARfr+jUNGPhEfRqGOtTvTTJp=SZ2ayg@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] arm64: dts: aspeed: Add initial AST2700 SoC device tree
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>, BMC-SW <BMC-SW@aspeedtech.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Jeremy Kerr <jk@codeconstruct.com.au>, Lee Jones <lee@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, Nishanth Menon <nm@ti.com>, 
	=?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Taniya Das <quic_tdas@quicinc.com>, 
	"Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Eric Biggers <ebiggers@kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Oct 2025 at 22:11, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Oct 23, 2025, at 09:37, Ryan Chen wrote:
> >> > +  aliases {
> >> > +          serial0 = &uart0;
> >> > +          serial1 = &uart1;
> >> > +          serial2 = &uart2;
> >> > +          serial3 = &uart3;
> >> > +          serial4 = &uart4;
> >> > +          serial5 = &uart5;
> >> > +          serial6 = &uart6;
> >> > +          serial7 = &uart7;
> >> > +          serial8 = &uart8;
> >> > +          serial9 = &uart9;
> >> > +          serial10 = &uart10;
> >> > +          serial11 = &uart11;
> >> > +          serial12 = &uart12;
> >> > +          serial13 = &uart13;
> >> > +          serial14 = &uart14;
> >> > +  };
> >>
> >> This looks like you just list all the uarts that are present on the chip, which is
> >> not how the aliases are meant to be used. Move this block into the board
> >> specific file and only list the ones that are actually enabled on that particular
> >> board.
> >>
> >> In particular, the alias names are meant to be local to the board and don't
> >> usually correspond to the numbering inside of the chip. In the defconfig, we
> >> currently set CONFIG_SERIAL_8250_NR_UARTS=8, which is enough for any
> >> board we support so far, but that means only the first
> >> 8 aliases in the list will actually work.
> >
> > Understood. I'll move the aliases block from the SoC dtsi into the
> > EVB board dts. For the EVB, UART12 is used as the default console,
> > and the board labels match the SoC numbering, so I plan to keep:
> >
> > Does that look acceptable?
> > ast2700-evb.dts
> >       aliases {
> >               serial0 = &uart0;
> >               serial1 = &uart1;
> >               serial2 = &uart2;
> >               serial3 = &uart3;
> >               serial4 = &uart4;
> >               serial5 = &uart5;
> >               serial6 = &uart6;
> >               serial7 = &uart7;
> >               serial8 = &uart8;
> >               serial9 = &uart9;
> >               serial10 = &uart10;
> >               serial11 = &uart11;
> >               serial12 = &uart12;
> >               serial13 = &uart13;
> >               serial14 = &uart14;
> > }
>
> I think this would be broken for the defconfig if the consol is
> on serial12. I would recommend using serial0 as the console, like
>
> aliases {
>        serial0 = &uart12;
> }
>
> in this case. If additional uarts are enabled, add those as
> further aliases.

Indeed. Are all these serial ports exposed on the board?
Aliases is mean to list only the ones that are exposed, and the alias
number should match the label on the board/port ("serialN", "debugN",
...), ideally.

Typically only a few ports are exposed, so you may end up with something like:

arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi:           serial0 = &scif1;
arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi:           serial1 = &scif3;
arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi:           serial3 = &scif0;

I deliberately picked this example, as it shows how the serialN
numbering does not need to match the scifM (or uartM) numbering.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

