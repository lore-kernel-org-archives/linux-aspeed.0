Return-Path: <linux-aspeed+bounces-4547-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E26EC531CB
	for <linux-aspeed@archiver.kernel.org>; Thu, 23 Jul 2026 07:56:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5Nk32XChz2yFg;
	Thu, 23 Jul 2026 17:56:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::42c" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784793403;
	cv=pass; b=D+ukrMdaOY/Sm5SGCLYww7ZA/maRCQJFEYOmtsS102sIdO9DjnTwpd4Bz/bizMWgtz+NFUKBQ+E/9Y9Y5Pd+rami6Qy6BqVazFZnYuWkKotHDrmDeJy+CSw3PmG/zRJmIdb8uEsWPRHcxznQBTSHz1qIyDVimbrx/PzRHZ4d5HbZzR+yyEdxox5OTGSgVORfTxveQt8vk3nKhAw4x7OScrEkidR/OlL+A9fqROXfKI3dB1TeiI9Mb++emTpQUoY0US8ebzTRvBiZaXEtWtM1C/aDeUfpPnlDplmeAjBPHKfof2Igrs2yJ51VDR2JKYsC4LrqFS5orI+96jKA57hOaA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784793403; c=relaxed/relaxed;
	bh=b6DqJBZMRrtqgXe1EMHqbmVcaqG/4/r6dtGHJCM8y1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HCY8q9aW9oMvxl1K5LhhVPjp+ClZGqqkLp4mKTLIbcfSAwJSDbfW18Gy22eyIpUx+AYCUjPGa4YUBTLrNh1F3cIgVWmTcYhCzPpNOJxlv19Qv7Lo3eNpf4mUx7NF+VADBRNH+r5/oftKfjQx2VIoZ94Dolq1QQ67m+EhHxUCMFh72D5eeTbO2X/PAYEHNUD5DpKJTiQ/aOYnsPt4o/gYMtggl2NxV4NzjRkjINDgvM+qxyn8kUQc9DRXXx9jzGfCOquUw1HQXx1vits4ivx1oOVilYXrAzhVWvsS0Yjq3PIXe/3VYitoSs3XVBEKXps1nbaz0oN4FbrvlT83n69qSg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=Q9DsY2iM; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=Q9DsY2iM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5Nk13T8Hz2xqJ
	for <linux-aspeed@lists.ozlabs.org>; Thu, 23 Jul 2026 17:56:40 +1000 (AEST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-475417f010dso206543f8f.2
        for <linux-aspeed@lists.ozlabs.org>; Thu, 23 Jul 2026 00:56:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784793396; cv=none;
        d=google.com; s=arc-20260327;
        b=WF2kSwcioUdrNF0ZO9VnO8gGqoQd02c3/pTU7/qXv0vYbJwmWXPx9axzpTw2BeTelS
         EbpYj+IAJ8rrIjM+DeDvOa6nZz7HACruZr+hJAFIVsL217WhSwkzxM7vW5mANECIgj3F
         buZZVWtZo4gBNNrgXeU0DenCoWFiNNlq5T74/iQn0rxciGXjihzXK0rwIgvVdyH24nCn
         cL/+aeD54GHsFZkctWIZbHM4t4uJoOHK1qQSHwGjaEJM9j5Jw4eWDcWXiDIz+rjMk4k4
         XJONLBbYDanI51XGIG2PHW4YyTaeHn4McX8CKgLeSOjdW8NqrwfYcORm2nqt/pWIjN6+
         gIvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b6DqJBZMRrtqgXe1EMHqbmVcaqG/4/r6dtGHJCM8y1k=;
        fh=7ViU8n2nevWdpR0E+vR/IdITP1IyD5cQKjZP9uI1uX4=;
        b=IUVyOMEpI0/IjvyiwiHS+2IpJe6jmyU1wMDL6zMU/5UvKI/amcHLdZZSFoMRND2l1f
         p0dKEnf0vXTCkC1ZxN8nfUg1zfWKov2JIqUCIg+ueJA0dXaZ9UzD6ZdxV6t9/hkOrNpC
         LNztXtMru871pvgyHWhfMgShV+xjpFiw3Y3lDUr4S+ArzD2K17X+ODq/PDcFtLB/PjeW
         s3xRYvYbnhbWWzlV8bpvTDztqoFu0lIW3NwehGGTHt10SCi+o1Uj2H/IU6u1h0v0ntW/
         5gwsm4c+wPfN6hWEZcuiZw82jy54f7+F/FdScvBpyqteUeYRb36nJ+7V9E5HNYzstl7V
         XOgw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1784793396; x=1785398196; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b6DqJBZMRrtqgXe1EMHqbmVcaqG/4/r6dtGHJCM8y1k=;
        b=Q9DsY2iM+WbSfakJ2vWhCi4vHz23cY4KaEtifzqMOyApHVncnYl6Fa1mC2IVbRsJFJ
         Et84ZgRZr0SylAijpGzonVOM9yerWf3nd/rneY8Fkn0jVrMT6SLFuN0sICpmbTdlj1b0
         dPdJczkYvXBP5qn6YgqM+YDaX01qYjL2MRn64Rzl2hjmOnk4W9+MjOTANZhNJAyO43NE
         tMGmyb1jGuDSn//UMSsB9AgX8p02uAt++xn8HvIpTWHo7VH8pcGR9yEL4YEaT9xlSlPL
         qjhwoaSbx0xXLazYI7fHFCKZJJuVVqKFQK0fzU01K67Ho6anBv3ynX3Adu0aWfFJX1rR
         2m3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784793396; x=1785398196;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b6DqJBZMRrtqgXe1EMHqbmVcaqG/4/r6dtGHJCM8y1k=;
        b=YypXYTeE24j80zKjQYZ4PDHPQJydC+44ELUb4Y26SjjMfjCJjMIUIiuOnfAS/eExDl
         KwFO8W4puSOW6VC9/fSnc8ZY6fMC9tf3bQbsSJi26bLXwWYCC+3nJf1ue2pmkK146G5m
         LGpFOVrDoiKYC4VEmcmG528vW7ySoDqwNS5vLXclbIUwopKEk6Zzy1Xe9Dq6ihw82UWn
         RW4/EN+dySdhKkuPP7UUENYm28vFoKErsbVkiUmuF4timrPh4Urwq6q3Lw+Ptl0UeCSy
         72Z4fnji6bEWXqVCNzLScO31K58VRXD7kZUHolF5f5zFOKIqpnNTWfRxUBqz5ricX5Dp
         WIXg==
X-Forwarded-Encrypted: i=1; AHgh+RoJ3AE9ladwZiHukFyKqlzovy1I/9bVm+/JbxChGYJjhtpQbOjCGtwePcVZduGKVhLDIzYg1kT1Sd1P2f0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyY0G1IhK6I9oWh8p31bPYLfjcXTJS0aOmY1FOKnWFEzFg3N0LP
	54U8ahA12AMUXj6k60Oz7OcXjBxMn+0hvTiOKyNCrbTybsn+6z1CjD/+oiIGCxxa5p2vaEkPvIh
	0N0ePd1aXjEly6jKEbKtJSy2lzQfdEfWukk/n6L2jEA==
X-Gm-Gg: AR+sD11iq6F3Xo2UNEJhso228y1FYjHBbQRe11gO0e4GyRKGJ0418Z51EvGvZOuMtwT
	JBsbnZJB1+r+L5zstlFx6jouWNoY5oVuNDfM3CxnAOPvKTK3xysek7nxXxU3D8zKylvRtZEwm6R
	SLH4SQk6ZEpZnAQaBFtBHCTKKSVCbdIUtOaw64/PGgBQJhojfc1cC0IOQMEpUfUB3hhfM2APVmT
	KF7XBJRKD2npQpUDTzR3u1JfcCgEuDTZkOU1Fu5VCEiHewBfNfOFtd8CA8nKvLTWSEDYRIMgKcy
	1u3uh/1aa7f3uDB5C5vZRSOdUDkQIWXL6NCkMVQIZFXIlKQ=
X-Received: by 2002:a05:6000:4717:b0:47f:9254:d45c with SMTP id
 ffacd0b85a97d-47f9254d53dmr642099f8f.31.1784793396668; Thu, 23 Jul 2026
 00:56:36 -0700 (PDT)
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
References: <cover.1784732161.git.gregoire.layet@9elements.com>
 <0b97a66762efc05c9073c14112cc489624871947.1784732161.git.gregoire.layet@9elements.com>
 <afa321db51d5e6cc8e0c15badc7204faa0925251.camel@codeconstruct.com.au>
In-Reply-To: <afa321db51d5e6cc8e0c15badc7204faa0925251.camel@codeconstruct.com.au>
From: =?UTF-8?Q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Thu, 23 Jul 2026 09:56:24 +0200
X-Gm-Features: AUfX_mxaanYxpNJpBfBXDiyLmy6JFC6syJV6bIP4iGx_AuR3yr8T2VahIy9zQKo
Message-ID: <CAFi2wKbNCVqZzApbG_xcDzyrN6yt_Wc01PVVqtPROcjVnp8hRg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: aspeed-g6: add pcie-kcs4
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: joel@jms.id.au, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	corey@minyard.net, devicetree@vger.kernel.org, 
	openipmi-developer@lists.sourceforge.net, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> >  arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dt=
s/aspeed/aspeed-g6.dtsi
> > index 56bb3b0444f7..a93fa4cf5d8f 100644
> > --- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> > +++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> > @@ -617,6 +617,13 @@ kcs4: kcs@114 {
> >                                       status =3D "disabled";
> >                               };
> >
> > +                             pcie_kcs4: kcs@914 {
>
> Nodes need to be ordered by ascending address:

The existing kcs4 node is already not in ascending order of address.

'kcs4: kcs@114' is before 'lpc_ctrl: lpc-ctrl@80'

pcie_kcs4 has been placed here to have ascending addresses locally on
the kcs nodes and still
having all the kcs nodes next to each other. This matches the kcs4
node ordering.

If ascending address is still preferred, I'll change pcie_kcs4 order of cou=
rse.

Regards,
Gr=C3=A9goire

