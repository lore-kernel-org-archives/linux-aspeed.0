Return-Path: <linux-aspeed+bounces-4129-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDE3CD5BC8
	for <linux-aspeed@archiver.kernel.org>; Tue, 26 May 2026 01:05:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPZLV4v4Gz2y8d;
	Tue, 26 May 2026 11:05:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779696399;
	cv=none; b=MsKbRfpdf+HdLSUbK9GotI9x/zKrH2djxpV5xH4l8DTliL+G8WMIDiv6/Tn/thA6as9ODXJgTCM30tHyKqah+bs3eMm/u116GLhQ6d+PEtr1feI33826fgt1EKM46QJBZEzvwMAWcrLDCUGDoaDWCraxuHYhUBpWaB6jrIBv6yXQcy1tEhhCF2hSVIB1jdJzAMIbMQONtZC5Irq5u+e9B/Nn8kifFwbKPx7fy0leEP64VUnsQ7nRdZXqI/rg2Fs+PLuhsrHhgGlz4vk3AHrjEGugs44IZqSshXigGKF7ME7OpeSa/zmBLEC1AKp51OAYEQz3GC1D4C5l33okBUZJXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779696399; c=relaxed/relaxed;
	bh=XBdwrpDpVLZphgnQqjfINiqHGCa1lpywck29IxJWjLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZKYIrAbo3XnbBniaCVyQ54K4zGSNKJzsrbiF7TeIHVBdaEj4btffcNph+dvhGt8Vd3wIx6zN13b5nymHuGWJdyJkWe8cRmSjMt4+VICeGAKl24qma1tTtyowfXRm2aAQb2JnG4KHoOtDw9mD5MGM3lelUxJ0e1uq/Tia6hhxqXUHrkCwBaCCfOEpr7Nheq81USz2aSLXPoGsyJblOtiSPloA+T0JVozcMjwtat4fevW+FTUjGLxyMYsW9SaeAKJ4mxhCNdD+KKsXJLYxKBtm05LoRcxqQoI/lcNRXYfTmLCiDrlz64ZiX4GwgFrHZMw+r2jW9J57wiTzOfEtIakwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fDLEwigv; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fDLEwigv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gP7kk59Mhz2xk7
	for <linux-aspeed@lists.ozlabs.org>; Mon, 25 May 2026 18:06:38 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2409444576
	for <linux-aspeed@lists.ozlabs.org>; Mon, 25 May 2026 08:06:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2E11F0155C
	for <linux-aspeed@lists.ozlabs.org>; Mon, 25 May 2026 08:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779696397;
	bh=XBdwrpDpVLZphgnQqjfINiqHGCa1lpywck29IxJWjLU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fDLEwigvfx3SKEy+abqKr/OzEu8M1uZr5lZwv82fmKYtK+YvG9058zhlwLGw4oST5
	 0478577WUe+Uc5wobNxLnJxUxHa0w2WEc4p42UrWv0+7pcuOFtgl5uQywyTZ7VPHod
	 m5h2YUwU66j6aPQnq84kLOkJiAEg6CCu5bJ6qOal41l2D+aYc8NwfZslUrXD3TEXEo
	 mdqDKnNJXIYIGlGCmp01Qc8O939wTaNiQ0pd7s7tO2h+dEgrhDnjIz6ydkBi29LCXe
	 UCHXvyb1Ig/C7O67TkPG3ciG5fITPX7NAAC6/M4R671dFZbM76Lk0FYLmh0crQXTpu
	 Imm1SJsoC+Ebg==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a87782588cso2181345e87.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 25 May 2026 01:06:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8eJG+DXXfvWb/ymwAGBgfc+YStJXDDzdmUOgRWgdJgpcGHq96QEFydX7fRQgTjGZaJSVe1yx8kU94UsjQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx4FL19+LBtaxWNU3D+cGuEL2GbetooSWRycc98j53XSO3C78ae
	5hnIjcTgnuvQfpm2jI1S4doVCD9OA4bSp/PBVG92G+AF+x1DrQ+aLhlyTGER83H9pOzpOvKMHx/
	sb0DJz9kB++A6onS9jmT8OTBKWKI8odA=
X-Received: by 2002:a05:6512:692:b0:5a8:fc25:3843 with SMTP id
 2adb3069b0e04-5aa323a49d0mr3894276e87.39.1779696395729; Mon, 25 May 2026
 01:06:35 -0700 (PDT)
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
References: <20260521-pinctrl-single-bit-v5-0-308be2c160fc@aspeedtech.com>
In-Reply-To: <20260521-pinctrl-single-bit-v5-0-308be2c160fc@aspeedtech.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 25 May 2026 10:06:23 +0200
X-Gmail-Original-Message-ID: <CAD++jLnxMGux88CCXH70hwEGiQXn9FCJ=vucLaS=JLhp_C48VQ@mail.gmail.com>
X-Gm-Features: AVHnY4LaI0HREPthKKhQrYPPwj27_NpiZglEh2S216je37LkMgP9M9Luyc3lYsg
Message-ID: <CAD++jLnxMGux88CCXH70hwEGiQXn9FCJ=vucLaS=JLhp_C48VQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] pinctrl: aspeed: Add AST2700 SoC1 support
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Bartosz Golaszewski <brgl@kernel.org>, 
	Lee Jones <lee@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>, patrickw3@meta.com, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, BMC-SW@aspeedtech.com, 
	openbmc@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>, linux-clk@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 11:17=E2=80=AFAM Billy Tsai <billy_tsai@aspeedtech.=
com> wrote:

> Legacy ASPEED pin controllers have historically not had a coherent
> register interface. Control fields often had no consistent mapping to
> individual pins, and configuring a function frequently required
> coordinating multiple control bits across several registers. As a
> result, the existing ASPEED pinctrl drivers rely on complex macro
> infrastructure to describe the dependencies between pins, functions,
> and register fields.
>
> The pin controller for SoC1 in the AST2700 breaks from this legacy
> design.
>
> For SoC1, each pin maps directly to a dedicated function field in the
> SCU register space that determines the active mux function for that
> pin. This results in a much more regular register layout compared to
> previous generations.
>
> While the behaviour is conceptually similar to pinctrl-single, the
> register layout and configuration model differ enough that reusing
> pinctrl-single directly is not practical. Therefore this driver is
> implemented as a SoC-specific pinctrl driver using static data tables
> to describe the register layout.
>
> The binding reuses the standard pinmux and generic pin configuration
> schemas and does not introduce any custom Devicetree properties.
>
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

Patches 2 & 3 applied to the pinctrl tree, thanks Billy!

Sashiko is moaning about something, look into it but my confidence
is low since it is using weasel words like "critical" for things that are
certainly not critical, if there is some validty to these comments it
can certainly be fixed up in-tree.

Yours,
Linus Walleij

