Return-Path: <linux-aspeed+bounces-5140-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66595CA5FFE
	for <linux-aspeed@archiver.kernel.org>; Tue,  6 Oct 2026 01:54:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hzK7S3Vbxz30PJ;
	Tue, 06 Oct 2026 12:54:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::112c" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791251668;
	cv=pass; b=RJFy3XfqWnaGM9wfQyvxWOr86vH3q+iBTrDeXCtr0zqPUqz5S6shKMg4gPyKftobsUghU0SvELMoqJGfoOx63CHuGbUVrIzugaxyYpJkQ3rTEZu3ShIWmki3rVBwdiTVEV4pfifxoyVQDjl7N3hcqLtqaqR0Wauo9KoeDL8SrkUVQk7sFKGldTCnuccqYIfB9w8iLjUy1quESgCbgv5m1+hVAQSTIrpWgVC+8t3mVtBJUfUqNRzAUMSDQSzRBvqhGlU7ikmPxg5SCLQXmcfIje/ny7I79EBDOclzCL7KoBWn9qiKATCFUL61LuvGhHapYzbYWD0onmMLwE8Oe6Yahg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791251668; c=relaxed/relaxed;
	bh=PkSBHDMAWr20ujdoo3JqdsvxzfCoeajX7hq4tGhn34A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=epSU1dSM8y8xauCO4YPPcnDvdqnX+4+Nh/4noqGcvApRD2X3ldeDb8ZAaI5RmPHPAZ/gqlTqEH6x1cvXq/zr0QQQ+SMc+7MDYFqA7s5k9c54k0PDt/W7DwqPp4/y/YavMilaZbL/POUjoJUFkOpY2RhX9DcpDVYROpi8dqB9Kpbn9YNP0LYWNmdPJxHiPH3sZpKWfgbeKURSTIXuW9V25r/8ptZd6BaqRiXBJ9qdBdUKLZD1s3ic4E724xUIuYdLvmD30MN73tUtGNjE3rV8CM1S/n7rj8L3UxuC/dOYen4dv2OmZZQdvSXLT+VtQkxY8Z2fe+khYRQZ3FqrKrt5ng==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=p6s5i0Vn; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::112c; helo=mail-yw1-x112c.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=p6s5i0Vn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::112c; helo=mail-yw1-x112c.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hzK7P5lQRz2ygW
	for <linux-aspeed@lists.ozlabs.org>; Tue, 06 Oct 2026 12:54:24 +1100 (AEDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-8ab37e44643so18384927b3.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 05 Oct 2026 18:54:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791251661; cv=none;
        d=google.com; s=arc-20260327;
        b=GJDfegMNWnCMzckVF+YhhYu+I05quRZb3qxa2l01KHJwpTw23Imwx2HsjVhymx38BH
         XBRtHlMW8ZIzkYdx0Lcx7BSNZ3ZSiShA5twgcimwkh1HNifjYiSex5JOQOIsrUWwZTbM
         E3NqST9iDdmJR8+8XizG2v6neTBR1ZvvjxylUDu5Zgmsc3/lHM4+kJOEsLQrdYFxNIP4
         a5CvmqxXvoplaBzP+IzuCftAmCAsi7FKAh/zMMK/Q2oqYzdLdpleznJV/mqyFwqPoWgf
         KseOvwbkBRdx/hEvR7FtynZY4jyo+rgDvjQDy4J/YQMl0u25CdEZISNSPLoh/hbpNZVc
         Xi6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PkSBHDMAWr20ujdoo3JqdsvxzfCoeajX7hq4tGhn34A=;
        fh=hlhGIi6JikuDPi9O6Wg+/TJOhMfwQWX89bfN6Te167Y=;
        b=F9/ogeb98emzD5/Y8c70NuaW/5wG1t2dZhQEm6u5v31QukWmHFvtcYyO26m+87yEpY
         ZXHd6GLGd3vrt6P6Jzj5bzMA00VEkct/FlqXVJHSniMSzyfLIfYVvtcXIUvctiyogoR4
         YuOUOr1V0P2Hq10TDB9gpPCosqf+CSSgXJZe4X6uNkH6CsoZ6e87zZV1MXlDKGbpHMEh
         v1834CdqVMGdj0EeJMvFfnhxORlc7WQgEynF4ElxuL5bnboWK/QfmRvN41JZR9Xf6VH3
         4ZS6YU0aPa86YLL4a6km0zsIkNHi8XnNBfYW0/6dajxk+332k9hjXrbmaotQvIxIktRl
         pbYg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791251661; x=1791856461; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PkSBHDMAWr20ujdoo3JqdsvxzfCoeajX7hq4tGhn34A=;
        b=p6s5i0VnRmiR87MVTAdC4w94Yat9vFkESQNh8xCowLwDEsuNjPGxaCbHe73ImgE3eL
         FLVoSLokejffWRHq75K5EMydqKxnQMlzauLUOcuXLaOFId17EXKnsBEwQBzuRr5xbwcU
         7c+6zOj9OZtGHgCDIEDAOBTrEXBobMVYk/fsZf/M/TQSU61MTzLNgdwKG4qLB/u7+0Lc
         Wi2RTFavfY6G/3g/k28Z/+tUtCyxpnXEROdWpPxfvvTKmbozrwoH8zKZuk1rIbXJLF7F
         p/1ftI2YuVTjUYgbBsev2RSjaZQv1P4fA7+SB1QG+QM+NdHg60yImNAwP9MlduW9LYY2
         9JbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791251661; x=1791856461;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PkSBHDMAWr20ujdoo3JqdsvxzfCoeajX7hq4tGhn34A=;
        b=wuISiVYoH/fm2EphWhoOcok3vQ8/hBF0rhGDcqoZqCQzW8GpItNkKv8frsetLHg92Z
         ApFJQxBo8LXwRPbANrcg5JSaU7xSvhnX26ortKu2sTZuu0CKQFWN+KHJE23cex4+kSmM
         eoFSN+vmVGytb3us+h+0I/czVKH89rc0BmXYq0Vb99WWAvfkY+JJvrA2AUvZb1l1cwcW
         SZwFf95I2gOQ/622fyvG0PygucTwW6BPdxgFl88NoMHhe6Av9WVphzaa11h68+46WCMi
         FUUvCeTm9cZygqhW4zzOnTixu8ZDLjBfZQQPqxk83m+gfFDvWaJhw2UbqEjx2cwbEGc2
         2Q1w==
X-Forwarded-Encrypted: i=1; AKwUvBz9X4RH6MO6pXgzs8Fknvw34T+XULMdwT73xHKaFYHOWQ1BnVutBEoPKDFzdjNnb783ht93pfX+r0IJFG4=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYL09jr3EC44PxeRlvKmQ/IkkRCegMJgCfh4k8zONI04isaB+VcS
	kbH80EzueI9wL7IwTFRmbkeMEUltFVVm5bxeeKXn3L+DlkHj5HbhFN2QTGa3LsduUqj8DS1xCBO
	gEqTM3V3MNhwJcSJ2mTKYIxwnYG9YN2Y=
X-Gm-Gg: AYBFou2WWb5OzF7IVK7omxy4z6Wh+fImQex+mqJETMKV5Dgo/fxzn9BzazkWl+5cWWK
	clBtLAX0yOg3yPO8IuhiedhWU7z6Qr6Wx1qytTMDIBtff/wzlDQr41SViJiP7LcnM0QcOw1mux8
	3MmBSa3Kho7SlomgeWcRNWMb12gFPqsRXU4br+MDOgvjGezhoeKWziiaZTChMNsl3BMDtOXqljy
	6pxXoAPSkXMVEQJ92dqKLgm7IxXZWhGGCJPkGHnAVau0psEPt0sqLf9rDdfBCIIO5zm4Jl6Pl1K
	msJ3uzYZvxwnROXaiGEP10omnh16EIZmMA21egC5tTkJwqH3WXG73Rbr0g==
X-Received: by 2002:a05:690c:1c:b0:8ac:4b34:6082 with SMTP id
 00721157ae682-8ae95af37f7mr32992497b3.73.1791251661017; Mon, 05 Oct 2026
 18:54:21 -0700 (PDT)
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
References: <CAMFFDGh6XwYD-axu3brX0Tdt3PteJHHGo6oJaghzpvnEyzT58g@mail.gmail.com>
 <OSQPR06MB7252CC7FC2131D45457A1FA98B962@OSQPR06MB7252.apcprd06.prod.outlook.com>
 <CAMFFDGi-Zzwk33Rb2LPVOSz+XJa51iBQ3ZWEP6mLg4C362F=VQ@mail.gmail.com>
In-Reply-To: <CAMFFDGi-Zzwk33Rb2LPVOSz+XJa51iBQ3ZWEP6mLg4C362F=VQ@mail.gmail.com>
From: Prasanth <prasanth.padarthi10@gmail.com>
Date: Tue, 6 Oct 2026 07:24:10 +0530
X-Gm-Features: AclHuK-Bp0TStH-ztm8tO-ezZOGxNIzT501802shaVBj9EoaYz799U7UGfa0dyU
Message-ID: <CAMFFDGgv0+sUL4V4itKw3pezB4MccYr1rGwrS6F0qwD=0HLB0A@mail.gmail.com>
Subject: Re: [RFC QUESTION] AST2600 GPIOP2/GPIOP3 pass-through with gpiolib ownership
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, 
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	"openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>, Joel Stanley <joel@jms.id.au>, 
	Ryan Chen <ryan_chen@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the guidance. I continued with a private B650D4U experiment.
The experiment now reproduces the exact vendor sequence:
SCU4BC idle:                        0x0e000000
SCU4BC transition:               0x02000000
GPIO123 pulse SCU action: cleared
SCU4BC restored:                0x0e000000
On real hardware, OpenBMC now successfully performs:
- Host power-on through DBus.
- Power-good assertion.
- Graceful host power-off through DBus.
- Power-good deassertion.
The private implementation is intentionally B650D4U-specific and is
not proposed for upstream as-is.
Given that THRU1 and GPIO123 are mutually exclusive, what upstream
subsystem should own this temporary transition? Should the
power-control consumer coordinate GPIO and pinctrl states, or is an
Aspeed pinctrl extension preferred?
I would appreciate guidance before preparing a generic implementation.

On Mon, Oct 5, 2026 at 8:33=E2=80=AFPM Prasanth <prasanth.padarthi10@gmail.=
com> wrote:
>
> Since THRU1 claims both pins and is mutually exclusive with GPIO
> control, should the power-control consumer acquire GPIO122/123
> normally and select a temporary pinctrl state that disables THRU1
> before driving GPIO123, then restore THRU1 afterward?
>
> On Mon, Oct 5, 2026 at 8:04=E2=80=AFAM Billy Tsai <billy_tsai@aspeedtech.=
com> wrote:
> >
> > Hi Prasanth,
> >
> > On the AST2600, the THRU1 pass-through and the GPIO123 output share
> > the same path and are mutually exclusive, they cannot be active at
> > the same time, so having the pass-through pair also controllable
> > through gpiolib isn't achievable in hardware. This matches both your
> > observations.
> >
> > Could you help us understand the use case? If the pass-through
> > already handles the host power path, why is switching to GPIO control
> > needed at all =E2=80=94 rather than simply keeping THRU1 enabled throug=
hout?
> >
> > Thanks

