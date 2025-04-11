Return-Path: <linux-aspeed+bounces-1179-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A65C369A1
	for <linux-aspeed@archiver.kernel.org>; Sat, 12 Apr 2025 04:16:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZZKxC0hL1z3bgX;
	Sat, 12 Apr 2025 14:16:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::243"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744377747;
	cv=none; b=XOCBO7ELsndqgIZAJopqCzGSETqMbnSmECbIPz4CEIMw2Tyl2aWl8apbS2jnXIPeU5sv5v739SijArqv3lFLMOEbTXZ1qWeZIgQtCK7ygUdMVIi/tlmaJM0UBOtIr8XM20CSjgLMeAvKZnwUbQVnM/SmOgcK8lPkP9soUdnXXnOAIcC7wxdgdXVjGQhpp5dG/u+rpF4orF4AgfVvAlyGOgLFypqzmG5V+uETIFqVICMr6wEnA43HsACwTmAdHVfnXtxQXH1pbvzmL1K9sYEP2qnoqCWTUeJzL5N3yz9FWI1VqNGDfM3p4wGxIf/mcCK0D3ifJT5sY92ryi/xd04j/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744377747; c=relaxed/relaxed;
	bh=sah0SVBmFLpz4h/jlec344lM1AesPXbeFTOSULVxmM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gVd/drIlDRt66EwRYIzpWne19eF0NzgELjOWXQHWsiS7XXCKp7KDHIP/0nxCMTAgIzGbkeVvDBWlTLGL38IuQDCYWlV0nAhjh7cF3scrfyy0Y2Rwi1v3TkLFe4XkMQPfB+1gZxODlU50XJntBfg53sUtQNEa6zbvgYTu6C1maUYKidpe/S34T9caNC3Oo76okauyYJcNJCBFsM00mzZgCcoyRV778eImEYvyHU9daeH50kXwasZu02UwEIFP6+rorOB382QcB26MDO5daBZKkHYFCIQm5D7w2uoHSENp0IcQneA+Ndm6LOZV6cfgRX1BNZIHDvlieqJpgOpsmQHIGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bHqVL0Kp; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::243; helo=mail-lj1-x243.google.com; envelope-from=bsdhenrymartin@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bHqVL0Kp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::243; helo=mail-lj1-x243.google.com; envelope-from=bsdhenrymartin@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZYy5s1tTsz2yGY
	for <linux-aspeed@lists.ozlabs.org>; Fri, 11 Apr 2025 23:22:24 +1000 (AEST)
Received: by mail-lj1-x243.google.com with SMTP id 38308e7fff4ca-30bfc79ad97so32585391fa.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 11 Apr 2025 06:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744377739; x=1744982539; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sah0SVBmFLpz4h/jlec344lM1AesPXbeFTOSULVxmM4=;
        b=bHqVL0KpaBiE+wNWAe3fD+1uP4kROX0xvGwlYbf3xMV0Rmy563/p17//VENbrA4wiv
         tH24CtzbIpNvf5bQFg8aNmzTCFQL+QiKB9UmmiD6/MJ07yv9CV+r/+9H/j36zmno1Aad
         Dyln6q377sjSfr/+7a1WLvS6tb5p14jkolgkywiVvsvb2JJptcJsaLeUyVGCR7bh4aW1
         e5EZIyMiV3WifkPfNUijmdbBf0InVoSyJimocQHByvNLvD07ckuR0RLf/6+gjVp14dQ0
         CpxDqaQ3A1lIxpD8UqCcmhJBqMAQZcocr7WdHy/AyT47kVdNP1jBuN4qQ+shsN+xpCed
         WjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744377739; x=1744982539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sah0SVBmFLpz4h/jlec344lM1AesPXbeFTOSULVxmM4=;
        b=iX38lq2pMQixeB1ImDAEisrz3qx0SrfRa3nxRCrwHbXk6WWn25RpY6qx1efoOIUV2f
         enli786W8khe0vh07+1s1t+pRr2G6KwWJWcQs1qr3ldIgfaSCZRGkj25saqbOKnyrzFs
         nSdGSKfdWIsRhmMPtc2vHljuLSUmb3IUE8zTWNVRHvcoiq+AUPM6aj7VuwFVAjSsXOzh
         xp/3l8fIAmfo7k+roM4Whgkz+t8yX0D5+sCL8Cpr/KLrgYvaBdMPU3cEpcY7DNnsywbF
         cCUf0ihJdWEIu6mWK6/oyUffM2v6XXaAw2ebBrLUB8H7fsAwMV5LHdouOz+KswHYXUkW
         CziQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3tCVNnAH3SS4H4WxiboG9ZyM6E06VW0ev4XOQW2KM1VY0xk+fApPTKLPmlIygUyK+5SQLCMhWDCuQSow=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyzwHqK9h+Ly5M0tva5VXrnh1I658k0v287ZASYOKFiQRM5rXmT
	TudV28QY8gFFvvMOp5wEAh+mWpACl6Xd2/H8okT/KeHuM9EezGYdWtiF30VyY3R7yWi2qjFSgcx
	G/c6HDIVo4AHX2SNpyWtd4yKPrEw=
X-Gm-Gg: ASbGncuQthKBmLaVPitA93ZnUhm5Zt+syGaowToiiKx9jKhl86FZQlsJlHwXoJhRMnN
	L2PGtVUDW/h6EXHp247DsMHM8PouBLEBm3TBPGcZh041ZotpofFHx3uEirzjWMzcCUT4kdf59tf
	azaKLoVMsgQkj2j6BehFZtUw==
X-Google-Smtp-Source: AGHT+IHw+lifGU70y9Vd72DyBga7i8AjGwQnPrs/Ioo3jLXofjG+CAq6Y1GhP4WwWrG6KrV6FXm0JU1muYB3vRAji0U=
X-Received: by 2002:a05:651c:312a:b0:30d:c4c3:eafa with SMTP id
 38308e7fff4ca-31048972d82mr10675451fa.7.1744377738559; Fri, 11 Apr 2025
 06:22:18 -0700 (PDT)
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
Date: Fri, 11 Apr 2025 21:22:07 +0800
X-Gm-Features: ATxdqUGEZYsaCXX5XdyoJ9leRiLY8Ans_fSIobpjEITgHPNCVrlUjQY0Xk24xqI
Message-ID: <CAEnQdOoikipXfvBUcfmFUp8As4+K58Bb=oeFKmEH8x_nqkTX_g@mail.gmail.com>
Subject: Re: [PATCH v2] usb/gadget: Add NULL check in ast_vhub_init_dev()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, linux-usb@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Thanks for the review.

This patch was made against v6.14. I=E2=80=99ll rebase it onto v6.15-rc1 an=
d send a v3
shortly.

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

