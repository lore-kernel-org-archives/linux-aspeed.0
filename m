Return-Path: <linux-aspeed+bounces-2135-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4539CA0FF2
	for <linux-aspeed@archiver.kernel.org>; Wed,  3 Sep 2025 14:05:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cH4BX6xy6z2xd6;
	Thu,  4 Sep 2025 00:05:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756908324;
	cv=none; b=I6WxaJ/F3T68XeIUSdkiv8mp270Z4zaUNMoNd78KLFz587k+Vvgvi65szHsAQHW+yF8g18xT5xufrZ0Ho3qQthJv+mekjqGempaW3JbUlIR1M9QsI/GLaus+Ctue1rQllR0c0LyEaaB0XnVrRlr+q6EyMGdBGYPML8YWTuwMe+FaeOxmoI1KGVCeaffcnBC6dlHn9FOFJ6MZLnO4zdAIjMO/WXokeo1d6lk8/t0W/zCm7ohbJ1yqSUTQEJ55jrb+pj/Ubzud1oMZXwvouM1JCfZHWm/p7G6ZFWdqgJNwxXFPrSlCX/JN9o/Ir7etFmuli1S80pkTHiqJ1A66AdiXlw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756908324; c=relaxed/relaxed;
	bh=Vg5ewRXhTTAj3dwOtg+KKWn0lOGtPCOEr24O5UKKpJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gWzQ+z+Kuv8t2Row51bwdrKc0xsHGn8tQMMJHp/9TvnYQlMCdBAj7rvivFkrifFpVsLA14rMlEkivtrLBIP4xoFZT8MR1G1qI0fCVbRfgWEAYNRUfbPMftEvM9LHpD+DOlIGvlXURePmOWD+Me8mDqWI4oIvINLsGB2s3k3+CMJ5a8ykPVx0Ewe529kaWEcDo10FRMZlvZ95ZmienKYqPbhWGP72/7/ctsRo8ZI8I0oNizN29Moxt5QMNQtwGoIyaJWhLa+CkRrZG59jcZiQO4lomptvSRaWziQBL0MARPkl81pn0laxdkEK2Sh476eMOT82Kh2+RkHoA5Rqy7KusQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GarjbhYP; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GarjbhYP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cH4BX0bqDz2xQ1
	for <linux-aspeed@lists.ozlabs.org>; Thu,  4 Sep 2025 00:05:23 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B914043A98
	for <linux-aspeed@lists.ozlabs.org>; Wed,  3 Sep 2025 14:05:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F01C4CEF0
	for <linux-aspeed@lists.ozlabs.org>; Wed,  3 Sep 2025 14:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756908321;
	bh=eKNu0P169Q3NEmF9/2kn88R7etBh4b2ftcRq7KbNGzg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GarjbhYPuBwzN4LKvw70mu25trun6v2gsNZoMS79qq5b6fFdnkIvAU84g+t/ZNTuA
	 qItjKLs65j8DmS5uRuHG/tkDx9bXVhY6n/sDUArtE3jYBFiDdbCBST3QfRGBlrIjZZ
	 0EOijnVmbkyGgntMKf9LztVwMTAF3BXSFTiQIhxDLLh5BAaXagqUwEBIB/EXoG4eUl
	 281whCCc5omD9u36zHFpRpeOaOwok4ld/LprRIQlPor080oofNvmT9lX50gaNYeXn4
	 27f6a9fUVkD0fJtu6rpxsExGEGI8IjbPgMEwoK885Yu8kqSJZ31Y78BR6mvEm74tEa
	 BkIhFCAL3LF5Q==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61cd3748c6dso13488736a12.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 03 Sep 2025 07:05:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXAAUnTXMat1EMS0Z/GO1x/i5FKtAHYBO4K5fH4/37zFGouxHxlPA5uDHp9BLeJ2hfNri8d/8lFWWeo8pc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzUry3NwUqhMjg8DJcJCFsykh1v9zNzQ128SJ7Z3fB41TE+vCMS
	zvqWXGFUu4Mxb1AeUEejoxAyqZmxje3FNonCjYuQqQUEmF5Q7caN/J+6gHRnJnj531MXLrDuZWm
	11RjOMWGd986qfnN1OjCHEqcfL2SO8A==
X-Google-Smtp-Source: AGHT+IHhgqqdWQtLgJ3n4i+fkorAw1PLf/dG7GMkfPu1VyhaFYexbX0Opd6FI4UepF1zq8MJg0/D/0FlKAcuRTaWSho=
X-Received: by 2002:a05:6402:1ed6:b0:61e:9ebf:d340 with SMTP id
 4fb4d7f45d1cf-61e9ebfd58cmr10082183a12.32.1756908320220; Wed, 03 Sep 2025
 07:05:20 -0700 (PDT)
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
References: <20250815230841.3487764-1-robh@kernel.org> <307fa87eb552ac4a1f6dd6139450786195e3892a.camel@codeconstruct.com.au>
 <360776d4dd765dc2c98f0c1b718fe63d4a8a70d4.camel@codeconstruct.com.au>
In-Reply-To: <360776d4dd765dc2c98f0c1b718fe63d4a8a70d4.camel@codeconstruct.com.au>
From: Rob Herring <robh@kernel.org>
Date: Wed, 3 Sep 2025 09:05:06 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+TcACG=vGp__tT8RE6kOjchoUSq59i=H_+qSRn-ucMkw@mail.gmail.com>
X-Gm-Features: Ac12FXwkg-WgIKnHEs8UoaeM3TBl6YtocnO-RvpeXFYLKucgpiCnVNz9w-PqANM
Message-ID: <CAL_Jsq+TcACG=vGp__tT8RE6kOjchoUSq59i=H_+qSRn-ucMkw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: Fix/add I2C device vendor prefixes
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 1:52=E2=80=AFAM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> On Wed, 2025-09-03 at 15:01 +0930, Andrew Jeffery wrote:
> > Hi Rob,
> >
> > On Fri, 2025-08-15 at 18:08 -0500, Rob Herring (Arm) wrote:
> > > The ASpeed DTS files have various I2C devices with missing or incorre=
ct
> > > vendor prefixes in their compatible strings. This hasn't really matte=
red
> > > and doesn't impact ABI compatibility as I2C devices get matched with =
their
> > > vendor prefix stripped.
> > >
> > > With this, the "maxim,max31790" nodes now validate and have some
> > > warnings. Remove the spurious "#address-cells" and "#size-cells"
> > > properties to fix the warnings.
> > >
> > > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > > ---
> > >  .../aspeed-bmc-arm-stardragon4800-rep2.dts    |  2 +-
> > >  .../dts/aspeed/aspeed-bmc-facebook-harma.dts  |  8 ++-----
> > >  .../aspeed/aspeed-bmc-facebook-minerva.dts    | 24 +++++------------=
--
> > >  .../aspeed/aspeed-bmc-facebook-tiogapass.dts  |  2 +-
> > >  .../dts/aspeed/aspeed-bmc-lenovo-hr855xg2.dts |  2 +-
> > >  .../dts/aspeed/aspeed-bmc-opp-palmetto.dts    |  2 +-
> > >  .../boot/dts/aspeed/aspeed-bmc-quanta-s6q.dts |  4 ++--
> > >  7 files changed, 14 insertions(+), 30 deletions(-)
> > >
> >
> > I see you've applied this to your tree. Sorry for being slow on the up-
> > take, I've been focusing on other things recently. Happy to take it
> > though, if you're happy to drop it?
>
> Actually, do you mind dropping it from your tree? It conflicts with
> Krzysztof's patch that I'd already applied:
>
> https://lore.kernel.org/all/20250819131743.86905-2-krzysztof.kozlowski@li=
naro.org/
>
> I've applied your patch here with a note in the trailer:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git/commit/?h=
=3Daspeed/dt&id=3D61a913644a8c5b6c8bd9da09f78f88e50edfaeb

I've dropped it. That was inadvertent.

Rob

