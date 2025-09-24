Return-Path: <linux-aspeed+bounces-2337-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28604CAC5A5
	for <linux-aspeed@archiver.kernel.org>; Wed, 24 Sep 2025 23:45:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cXD3b5qfVz30P3;
	Thu, 25 Sep 2025 09:44:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758719102;
	cv=none; b=MC4h/SRmkdKWY1Dr/aq4ACekaVNr99YcjFrduoUnKm8E7YQ0E40ZRR/8KfT4hnIpY3Vdb3umiDK+bOc2FieUMcH+23DIeNuR9AymAolFxkehFM7ZT0I0geQYS8UoSIdU65uE1RYoCULeEBjgIQpGyQMEeQ1eBosLNFz4MpKqbj7FFddbDfkxxmnxwFO0whD1hCApA7Kd0HKnqbmnzBAQhcJmH1S8pEgXoaQsE3wift3EbP5ivyxZgU5pn4IgbcyfEQW3KtBe5E1bKXzeTNe+06Od9LbX4nPTZRLhEPlJc+u6U7o0XvcAGsgaf6xu3sTzF243qE8GMnPi7P8uBxpImw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758719102; c=relaxed/relaxed;
	bh=ML8MT93NBaCozkqy3f5m8pHWK455oP1ORVjpuJLm5oc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=in9gkK67ZharjbWC3ZjCmy9P7fiwYmj2l2NymiZMKRTy5afeyLxCcyJTP3VUHdYmOqlL70vGRwKBJpmi9Gk0aM/1dwxJFy3Ww4tNnUbHe8sCT5oCuzDYjb8BZUJM/F0PTeOciN2piPSlWUJsxLZPhsKgg4qAFYBvxRxrpPyxmUs+bKdYdyTE+pRUidXBXOSZjOgmHSr61ecCECa5A3MYkUO4650jXYoVo9BC2dBtmWDERfvyPp1zQ3zDOvYwdHIHSHRgHWk0UEktlFLY4gaBFABDRgzbJm1A4KBA5kajVgwahodz+04zSQFMI8j8iSRXtX3BDiEJafpqxxVhANE/Lg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=b3WqdC+m; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=b3WqdC+m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cWxs95pMZz2yqP
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Sep 2025 23:05:01 +1000 (AEST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-77f429ea4d5so2734964b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Sep 2025 06:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758719100; x=1759323900; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ML8MT93NBaCozkqy3f5m8pHWK455oP1ORVjpuJLm5oc=;
        b=b3WqdC+mybuBw+8V82nx1Wc3IvdruvJrkLGjJr3ngLU+bSURTAIDS9oWQsc+vbiyHU
         ape5euHLrKNmCiO2xZ6N27nEQwQuOmfMJSYACxbtq3vRps47CmisRMmQ527RB8STZApl
         mE+LoGOznnlX1p5DF9v+VyE/AHdFQEOoY7Fu3tjiH2ISxEg9ag+g5k26daOpk5DoBuev
         zRJv07MsqpYLafrdTeNOna6EUJRiCi38B/t8ccXznAKN4Auh64N+vFX+O3M/Ej8FuKxE
         DgyAdeDNfTYiUKMd3ln/klyqVmN6wWzpT3YCuFqNIn+G4HpKYGfd81cDSeAq7378kq6q
         ERtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758719100; x=1759323900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ML8MT93NBaCozkqy3f5m8pHWK455oP1ORVjpuJLm5oc=;
        b=TSDle6KOy7NVolXNRJmhJ/u1VcWAKf/1fbm8Kz17dVCWAkU60rTwdYjb5qvjIdjn0b
         u0s4jLu6rHi+X+AEO/L5TJZ+2dYe3Nn+FzF88dHEYGwRdD4HvjmSVI2IM6PyXgaY9gzL
         2cYKjCO413t3cJr6sGxHNg/zVK8nfl+rZwQDw7QXTUVH+7V1XIBgPkdx3Pk0JxQjTowj
         r4vwkcOrmvnIk4QRg3VucF7zYKCfJJqlewEugJkAT/uvLtbKqgtK+PbSqkQWKC0DuApk
         CNVXCA8q0No+DIhXrg9y58136eeO4xcKeYb1YV+IhP7RlNyHV7zDskUqr0JqgoqzMI3r
         nHfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4TALD7Dm82myA3Bliy9qhdqCYwEKsqJu7CYIcCuO9G+zHO9zMzw1w9uUwEPigt+ZdIo2XJTlkYpUIzGQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzt7LTaiZ4J+vrBTZfMB3PuRtWboeLtZaaeKeUKUeXtesm/kXFi
	NrLeN5WY3v3L2brD0yGMee30mmd6gbAbO+wx/XQI96IJkvobCf4gcBz2qNFctAAAYG0hx6vlqwx
	IGFaLoxSXX152gnPnnn58LNfJ4ydImZ0=
X-Gm-Gg: ASbGncvSrHVuNYaeLYvJPglEfTi4v9HwSECrAyV8UKyuhiktIE2sMz4qQpz38kw9Jh3
	egcaNPiqIsX8XmO7X+F0JkYl2EUTSnpERVgVO+47KQAjzSA3597lsrBL1g6Rt8mgevl1Z6n7xlf
	ivKEsoC4Bc+cKtyN10KeRR1DUpVy0CauBIngYoD8ouwKSBueqvsk5WHLnSidVeqShqmN8dIbUhV
	L1u+umV
X-Google-Smtp-Source: AGHT+IGCUZlb7GHgT5j+JVNTpOON3z17rHhaJH8wYaV5Fzq+5A7QIaXDxQAJZsuGjTC053XYov/IrdtaNcnRVtX6QBE=
X-Received: by 2002:a05:6a20:6723:b0:2d5:e559:d241 with SMTP id
 adf61e73a8af0-2d5e559e089mr4875908637.7.1758719099609; Wed, 24 Sep 2025
 06:04:59 -0700 (PDT)
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
References: <20250917074812.4042797-1-kevin.tung.openbmc@gmail.com>
 <9bb9929a-8130-48da-983e-2901a7c3da36@lunn.ch> <CABh9gBew1=hbJvg1Mhg5dE7Lr_Z442_kbBX6zTs_6_C2NRyLbw@mail.gmail.com>
 <7e6f568da28d7a63738b6ed22b33db3df4c478c9.camel@codeconstruct.com.au>
In-Reply-To: <7e6f568da28d7a63738b6ed22b33db3df4c478c9.camel@codeconstruct.com.au>
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Wed, 24 Sep 2025 21:04:48 +0800
X-Gm-Features: AS18NWDPd9WPADUis1pKLRli7PBC0PtWHTmrvMja5YpnlZ2VdCkq5JfPN2APv_M
Message-ID: <CABh9gBcoWbXurPo0f9U9+gz8k6gttUvj=NMMDVfgjo5dgaTLSA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Add Meta (Facebook) Yosemite5 BMC (AST2600)
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 10:47=E2=80=AFAM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> On Thu, 2025-09-18 at 10:21 +0800, Kevin Tung wrote:
> > On Wed, Sep 17, 2025 at 11:12=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> w=
rote:
> > >
> > > On Wed, Sep 17, 2025 at 03:48:08PM +0800, Kevin Tung wrote:
> > > > Summary:
> > > > Add device tree for the Meta (Facebook) Yosemite5 compute node,
> > > > based on the AST2600 BMC.
> > > >
> > > > The Yosemite5 platform provides monitoring of voltages, power,
> > > > temperatures, and other critical parameters across the motherboard,
> > > > CXL board, E1.S expansion board, and NIC components. The BMC also
> > > > logs relevant events and performs appropriate system actions in
> > > > response to abnormal conditions.
> > > >
> > > > Kevin Tung (2):
> > > >   dt-bindings: arm: aspeed: add Meta Yosemite5 board
> > > >   ARM: dts: aspeed: yosemite5: Add Meta Yosemite5 BMC
> > >
> > > The threading between your patches are broken? How did you send them?
> > > git send-email? b4 send?
> >
> > Yes, the threading is broken. I initially used git send-email, but for
> > some reason, only the cover letter was sent. I then sent the remaining
> > dt-bindings and DTS patches separately as a follow-up.
>
> I recommend using b4, it helps blunt some of the sharp edges of git-
> send-email.
>
> https://b4.docs.kernel.org/en/latest/
>
> Can you please send v2 of the series so that it's properly threaded,
> after applying tags you've collected for the involved patches, and
> checking your work with `make CHECK_DTBS=3Dy aspeed/aspeed-bmc-facebook-
> yosemite5.dtb`?
>
> Andrew

Sure! I have sent v2 of the series using b4, and the patches are now
properly threaded.
I also checked the work with `make CHECK_DTBS=3Dy
aspeed/aspeed-bmc-facebook- yosemite5.dtb`,
and the warnings that appear are not related to these patches.

Kevin

