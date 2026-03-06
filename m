Return-Path: <linux-aspeed+bounces-3620-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74598F55106
	for <linux-aspeed@archiver.kernel.org>; Sun,  8 Mar 2026 00:54:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fT1rQ4yWmz3bhG;
	Sun, 08 Mar 2026 11:54:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::e2f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772777196;
	cv=pass; b=j+Lv3DZltZ/yvQq73VXkIwfGbt/sAAVhwExl3iJjMEPzEPwcOazyEdblOlHZltjprd3dnopQWFCyJCs5nwH5Jcq83zEQ/vjuMiO+3gt+hFHHEiFvgJfI+l4DnZRp1BFC5AN0+aPLE2dzTcKAykFzwI1MTcOIkoVxxQH8Nt+NPizT4iQ0Lr9NWp4vxsW99ep1Ue2t8Or/1RW2mYVVYE/p/NQKhZQJ8s6jIoCFAKIOAPWFBlTlQauFL103cEJt6TyRrmY1s4GWIKYR9YLXcKpGFiCPR279GGAC7IwhQAsTc/Gi5JPym7n45cye61jrMMZ3zfyN0s8ie0Us3vUXNNe5fg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772777196; c=relaxed/relaxed;
	bh=EGovAVgDeech9oAFJyAwU6fo6Sipfg2mUwR4uyiECh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fnHTdfLDFaoupLM6X7ufHc2enxoJg2WWGBPRj3UmT1ischIoYD+qbLBp1CGtwqlSKLJH+sllZbeJFDLi5xG4ku2IeklkHDYieVJIbMmsGLKwds/iXPLcj67+z5zBmas9QN3xGoBnIkC5ptb+TBVerbgp7bSNMhre58KF8JsCmMcZej//MWEYvHXTmx88Q52rRv+h6sq1zOZX1d3xe7jLgiPyyzgmAi3yMxqi9yLgTfEPleKP/gakFBXRmIDT45BVzXoSXSqcjNKTufJ71MAK+IW0HJjIXD77a+eVxAcOq0lT6E4g3KimUG7FRWwHZmtrCfo/vBcAZ9XTYG2tnj4dmA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=jpBRZ5FW; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::e2f; helo=mail-vs1-xe2f.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=jpBRZ5FW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::e2f; helo=mail-vs1-xe2f.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fRws76mK3z3bn7
	for <linux-aspeed@lists.ozlabs.org>; Fri, 06 Mar 2026 17:06:34 +1100 (AEDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-5ffbd778410so752333137.3
        for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Mar 2026 22:06:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772777192; cv=none;
        d=google.com; s=arc-20240605;
        b=Pn08UtWe6gQKae/luDLQZXFPCTP+xGs3kCX3Nqq29/H8g/BIQiVdcnuObSA7vedJZD
         Hj+7dF7JFSoqWcdl5p1bZrblanW4ymP7V7qjKhzG0LEy7ikL5OdBikF+qwtaMZMKWNv2
         fm+UtXshaxpvoedLPqlVAamPe3P4VSWaz3UVmgQoIT6YzK2cRStFbMDImbDiY78/e7A7
         UIyKLy4X8USReDnrqFowjLgw7b9OemtIsL4jWHXkyJSbTYBPWmS2rqTJ/1bgpOjANmHS
         JDRMesSaGMFbJ0NL6sD/mljXGQ8D/ZP1DSXZXLUndI02UoY7/DPvHUTvNhcfMgVC2LZL
         1yrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EGovAVgDeech9oAFJyAwU6fo6Sipfg2mUwR4uyiECh8=;
        fh=BpLVP8KmGPhjkX5VEqGt+uF/71urwx4UtTbokXKgg8k=;
        b=FYnkK7BVHKKIbUiLMUUXVVWvkoDnMVcoCagnj7WrXIQ62fNSC+QuuTaHAMdtcxrvs0
         7o2tSYPsLeuPAzUsxSTjr6Tp5f1AIrdnX8+HYziMG+xSyPx7yP8AEiyPxuBkLddHiECk
         dWSIytIv9pE17In9luQbEk0jatMD+9XZDkv36jkk9wXXTNEW1ElMF8QidYh0nZxknEOg
         sU7rUgi3Pnp5WZ6TdzpLP/JX383Srzy0qsiidh2LfVW65bV6t/PMF1QvMNGxPwn1tWIG
         ug2T8TWXi4CeN52KGVdpJ+n5ZX/G0k7sUiRUeZ7yMuUQQUnmJog42+aJhOoF/53LFCI6
         eI7A==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772777192; x=1773381992; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGovAVgDeech9oAFJyAwU6fo6Sipfg2mUwR4uyiECh8=;
        b=jpBRZ5FWW8Uh1piosAybPNHSu97ZSgo6ar3ABO9MnpjnJlC+W0iiqLT9vTXsMubZSX
         lyoJ7bLtC49RUEMxOGhusVSayQGdDH4+nKURxc/J8b7AiGk1Q4FoZ2KUfqVPwbNQ3YiG
         ezYjLhyHCiH98LNIpjMEHZx9Wr426BceKRxSLa5CRLSS0U15q7sY4PulNV8umGAaWzPR
         ND0cL6bHHgMW2wwDXxQzgQ5jhfydu2f6arkdOsNRTjOK8YkOrDRqRZq7pC9KBVjjG89Q
         EtkmTfx3pXZDVP4WWykIpYahgeOSQPIgto7xcnzpNmr9tb4H2HprB3fxM69Ym8PsdRUu
         do7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772777192; x=1773381992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EGovAVgDeech9oAFJyAwU6fo6Sipfg2mUwR4uyiECh8=;
        b=aBFN48Q+gxO3ceCx21c+djYWegINvwaPy+Uu2Y2pETf8gHjGb6cjuspfgFBy/PAwVw
         2XGi1du9tJT1+MSHasF2DXQl7gcoREAzT5L+cVw0ffMMypsMJ9cZl3Lc5Ac2CMfLr4fS
         9gDTlWdAH/z3VpJ1GDktfYFTttQx2JSWv02utfDwBkQL8Xhz6tv+bHBAScUeVN2ZsHfB
         z7gFsEpl+yFZJ34kGqsYaBERBZfS/r4tSOJqTuxzSKf/eF2meBexr1YYOTMRCnK2qhyM
         kzXanxsYxQjwZRI15KJGOpD6vL+xSb+6UEUIKJodpceQ3jw1u4hKHWwO+pjlnQju+n4m
         /INA==
X-Forwarded-Encrypted: i=1; AJvYcCWdBgsTJ+2pYmj/Oq83RsiGP1kyr2BwUEc2/flKnCw/SdfdxxPKVb+L8/e3FkGsAUw/qxjvsV3rBafU53g=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxkxJHZVJbIHL5d0PoPrbwqmeXUXQpaw36EY5zwuz+11fmtbPIO
	6JpJ+E6GS6jcm4R8E6Rg9rF+EbTCOylLhB/rwmh/OdayY5gV8783PjT9rAvGb4UjAFJcAX/8blD
	cQ0je6Wpj9jkHwUOSD5F7a6ZEcBjr9lo=
X-Gm-Gg: ATEYQzxR6tYayT3ThLcI0RZ8a1jKmxvdjoOlGMdQElA130kouEMyx9jR71cocse64Wb
	T/qxKNn7lbMHlq1ruVAxtrILrLyBSKKGDh3bvIqIaItx72NaOLHph5tLHPrYiYgZjVmId+bBi9c
	20ZBe13BNcN6JXujEqEV3dMFBp+XYFvmLetg/LztEw+6niei0mMd2b6BAeaMzEObpGPh3N76Goi
	iMM/RkuZXBdgLJQNZzX641RuHdJ+RHsB7OZIXAhDrb/7P9UJWhASCiFze+Ks1Ihs/AQDhjH7vDN
	a2oDVQ==
X-Received: by 2002:a05:6102:c02:b0:5df:8f4:61e6 with SMTP id
 ada2fe7eead31-5ffe61bf1f4mr409120137.32.1772777192540; Thu, 05 Mar 2026
 22:06:32 -0800 (PST)
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
References: <20260302-add-new-eeprom-node-v1-1-2bcf87bc22e4@gmail.com> <fd932aa3f0cae64f40c3b207657032e7bf61066a.camel@codeconstruct.com.au>
In-Reply-To: <fd932aa3f0cae64f40c3b207657032e7bf61066a.camel@codeconstruct.com.au>
From: Colin Huang <u8813345@gmail.com>
Date: Fri, 6 Mar 2026 14:06:21 +0800
X-Gm-Features: AaiRm50kmoskXtONuaiHe2cCtn5FjwA6MJ2fKHVggzbYT0hgr46ptkqqm2zNPM0
Message-ID: <CAPBH0A9oatx7U2+3dvGVgonHEm+yq5TFM9mTcdStau2Lk1XytA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: anacapa: Add eeprom device node
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, colin.huang2@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Thanks for the feedback.

In our case the only functional difference between DCSCM rev=E2=80=AFB/C an=
d
rev=E2=80=AFD is the EEPROM I=C2=B2C address change (0x50 =E2=86=92 0x51).
Other than this, the hardware is identical and all device-tree
described components share the same wiring and behaviour.

Maintaining two separate devicetrees for a single=E2=80=91byte address shif=
t
doesn=E2=80=99t scale well for us. Only side effect of listing both EEPROM
nodes is that the non=E2=80=91matching node produces a harmless driver bind
error in dmesg. It does not affect functionality on either revision =E2=80=
=94
the correct node always binds, and the unused one simply fails probe
and is ignored by the driver. From a system behaviour standpoint both
board revisions operate normally.

So the trade=E2=80=91off we chose is:

  * One DT shared across all revisions =E2=86=92 low maintenance cost, one
source of truth.
  * A benign bind failure on the unused EEPROM =E2=86=92 visible in logs bu=
t
functionally harmless.

If more hardware differences appear in later revisions, separating the
devicetrees would make sense. But given the current situation, keeping
a unified DT is the most maintainable choice.

Thanks,
Colin

Andrew Jeffery <andrew@codeconstruct.com.au> =E6=96=BC 2026=E5=B9=B43=E6=9C=
=885=E6=97=A5=E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=888:12=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On Mon, 2026-03-02 at 12:20 +0800, Colin Huang wrote:
> > eeprom address changed (0x50 to 0x51) in DCSCM rev D
> > To support previous rev (B/C) and rev D,
> > add eeprom device node for DCSCM rev D.
> >
> > Signed-off-by: Colin Huang <u8813345@gmail.com>
> > ---
> > DCSCM rev D changed the eeprom address from 0x50 t0 0x51
> > To support previous rev(B/C) and rev D.
> > add new eeprom node for devscm rev d.
>
> I feel different hardware revisions may deserved different devicetrees.
> What are the trade-offs that lead you to avoiding that?
>
> Why is it better to cause driver bind errors on both revisions?
>
> Andrew

