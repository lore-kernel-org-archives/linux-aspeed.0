Return-Path: <linux-aspeed+bounces-1180-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73372C369AF
	for <linux-aspeed@archiver.kernel.org>; Sat, 12 Apr 2025 04:16:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZZKxC2Y6Zz2yrQ;
	Sat, 12 Apr 2025 14:16:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::241"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744378244;
	cv=none; b=dhQGaQMrtPjYJSMpuD3nqxAREl8SEVwiwinpS/8TIZG8AtccSnfVQz0FSIa6SNG/p5fH0xHwGWymsUIu8gcneMS8Wlr9XvLOcMDzwpYqlz5sP28FFIiXunv7FT0AQS7S27rLMMAibqJVqX+yoVYo/rVmyWejPjqOemCeUmPlpZzCkJlUsf2ZpasiBFsA1vQ9ceLTW3epFyYzvg7dQv1WnqnLHnX60KlSa++vvhScSITv2tzidx0VovCOPVFNyXTd70uOMaKl1ezVOonylNZQKZXoKUhjnAPqSTkqRc54me5KtG3Whc6Pjtgvj2CSnyS/edt6yaduqCgyV0BlcKNmGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744378244; c=relaxed/relaxed;
	bh=T2R/IkUgsNUQZyYj/hsSGzxvJ2UNWF/IZAubjoxHQl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S9n0oAIrpA6DBEN5AEVlEYkgFP3xCi4HXptHDEMk2pQxxyGpByhTvLvuhYBrwN6NGsiHcwZElz/mxeRmBjA8zyEd7MLDUdvMSUTJOKxy9Nq1groKs/4L7P6Qa0RGco63Dmv9f82uQbhYJuEUtWuQ6smv363B45EvBdQaRt3JBPON5pTsUzvp1oAeIUhhDbFH3UCQcbq44JKqJlqXY9YQBf5RQxMZtWGs2RPEyUkOMsdfNM/GXBw3/GQlNEB/XpFWPEDSjt5gGHU8LqoNNigPkqR0lG7jnjCqJ3Rt7WK4NCilz2nAwssENf4Mb/Ktt7DqrTYjONnu7obnMfxkHzsCAA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=AVSNBOB+; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::241; helo=mail-lj1-x241.google.com; envelope-from=bsdhenrymartin@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=AVSNBOB+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::241; helo=mail-lj1-x241.google.com; envelope-from=bsdhenrymartin@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZYyHQ6V2qz3bv8
	for <linux-aspeed@lists.ozlabs.org>; Fri, 11 Apr 2025 23:30:41 +1000 (AEST)
Received: by mail-lj1-x241.google.com with SMTP id 38308e7fff4ca-30c44a87b9cso15426871fa.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 11 Apr 2025 06:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744378239; x=1744983039; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2R/IkUgsNUQZyYj/hsSGzxvJ2UNWF/IZAubjoxHQl0=;
        b=AVSNBOB+E6wxppmbdkX2vxkdFprbyblEU1+qC/L1tUMM4QrjR/XRhFIlLnQNd+hVbg
         xlImsmbI2MFiEGnMH3RRWJCxW223e8dUWPh/voqqI7yq3HMJxUj/0aAcJdZw4di93M5e
         eQZC5P8U1Ba2qYZZrUhduEIS0CnNZAhcK+0WA2MhoDkVdqd76yH2umvYe7PRMrwImAg7
         NCPKK4dekCMHxoaqBmXwPJ3q5RC4uGnbLw+3y7Nh4NsGkWZXR9AzaSTSrO1WM0gQiSO/
         dTg9dbzI9dLzaz+f6BZgf19lS8HZokXdL2Atgv9YOLHg/gteuICbBPGLz6AVJR9fvPWS
         wl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744378239; x=1744983039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T2R/IkUgsNUQZyYj/hsSGzxvJ2UNWF/IZAubjoxHQl0=;
        b=eNAlCI4/rNzDzud99oMvZRR9GtsC79ByqBOMEfIiKmqr8S/+HxWemIcYgwvpSHymJJ
         lIVGfmZxB8TH3p4b6HgxRUiwwJR7RXmALxZ/lwnh1Dt+3OWxU2adC4KyvhpkQmmnJnSs
         UxuyolNnx1OU0hMKQpYWoeTnpc/neXWGPVjs4z0uqjdspPOLx72SvfiJVbzEQRqsqJ+m
         dHxjqs2zASwDUfoz8d4d5mkF4XuYVO1ICOBVe6eoNIqXqr4EmcjOm7m+KRyPc8VC8nN0
         8/e8Nqsy6gZz6ZDsYJf40cvYJ2l4F5swOrgNafeWbgL9oyFMiOSl2biY9bhhoCASLrHo
         dHvw==
X-Forwarded-Encrypted: i=1; AJvYcCX4YinGcR5MEIAT8+lQo+FmWVzP3+1x9NiX3BILpeRbSquQIwngtMqzpSA36e5ya/I5E/mkDvz009m4NTM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywsr7HX7cQNbkLwHDH+s9Vk2J9BFL87ryYMUN2wz8KanDXsnzU1
	IUZL5i2uNIpXVxO66/Fu+JmJcGqyBX08XvRDUZSROzp3dElxHfePFEzzgUDUT+MhlNTqIhsUWNX
	VwoMPILXZ0fdhNfZOql8FOVWA4y4=
X-Gm-Gg: ASbGncvcea5Phr9w584z6lps6B0/nntx8ProlK6lRpMlvZFcgo45dpl+idJ8zz86qW5
	DervaxVpZdM8KUYCNvoe2r/BTAXbn84Tx0lQ3QvANQHwlyPJXnap/HuoRIhiWKqqk/CtfJqoxMC
	GA+1xcMI4LVRX7j5E55KE5
X-Google-Smtp-Source: AGHT+IG1lqVlN04eQ+Cdjd0vIhu0KNn3WIjR2MqivG0AARDZu5eY1L6Hi/Vnc2KqgBWl1QD8jRqYqg+Y0ThYnZbHxqc=
X-Received: by 2002:a2e:a545:0:b0:30b:a92e:8b42 with SMTP id
 38308e7fff4ca-31049a930d6mr9258461fa.26.1744378237355; Fri, 11 Apr 2025
 06:30:37 -0700 (PDT)
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
MIME-Version: 1.0
References: <20250405113020.80387-1-bsdhenrymartin@gmail.com> <2025041119-debit-cosmic-f41c@gregkh>
In-Reply-To: <2025041119-debit-cosmic-f41c@gregkh>
From: henry martin <bsdhenrymartin@gmail.com>
Date: Fri, 11 Apr 2025 21:30:26 +0800
X-Gm-Features: ATxdqUFFH3sTnc2x3CM9EZtpM34AzSWHqdFLolBE3C_g_Sf3mnv8aMarh0qkivM
Message-ID: <CAEnQdOqmq3wwn3FLNq2wiq6MuM9ZMgcs6vcmwpVVgwzY=zeceg@mail.gmail.com>
Subject: Re: [PATCH v2] usb/gadget: Add NULL check in ast_vhub_init_dev()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, linux-usb@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> What kernel version did you make this against?  It does not apply to
> 6.15-rc1 for me :(

Apologies for the noise.

I just rebased onto v6.15-rc1 and noticed that this issue has already been
fixed upstream.
Thanks again for taking the time to review =E2=80=94 I'll drop this patch.

Best regards,
Henry

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2025=E5=B9=B44=E6=9C=8811=E6=
=97=A5=E5=91=A8=E4=BA=94 21:06=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Apr 05, 2025 at 07:30:20PM +0800, Henry Martin wrote:
> > devm_kasprintf() returns NULL when memory allocation fails. Currently,
> > ast_vhub_init_dev() does not check for this case, which results in a
> > NULL pointer dereference.
> >
> > Add NULL check after devm_kasprintf() to prevent this issue.
> >
> > Cc: stable@vger.kernel.org    # v4.18
> > Fixes: 7ecca2a4080c ("usb/gadget: Add driver for Aspeed SoC virtual hub=
")
> > Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> > ---
> > V1 -> V2: Add Cc: stable label and correct commit message.
> >
> >  drivers/usb/gadget/udc/aspeed-vhub/dev.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/usb/gadget/udc/aspeed-vhub/dev.c b/drivers/usb/gad=
get/udc/aspeed-vhub/dev.c
> > index 573109ca5b79..5b7d41a990d7 100644
> > --- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
> > +++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
> > @@ -548,6 +548,8 @@ int ast_vhub_init_dev(struct ast_vhub *vhub, unsign=
ed int idx)
> >       d->vhub =3D vhub;
> >       d->index =3D idx;
> >       d->name =3D devm_kasprintf(parent, GFP_KERNEL, "port%d", idx+1);
> > +     if (!d->name)
> > +             return -ENOMEM;
> >       d->regs =3D vhub->regs + 0x100 + 0x10 * idx;
> >
> >       ast_vhub_init_ep0(vhub, &d->ep0, d);
> > --
> > 2.34.1
> >
>
> What kernel version did you make this against?  It does not apply to
> 6.15-rc1 for me :(
>
> thanks,
>
> greg k-h

