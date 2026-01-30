Return-Path: <linux-aspeed+bounces-3447-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C84D172A6
	for <linux-aspeed@archiver.kernel.org>; Sun,  1 Feb 2026 22:41:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f44V40bwZz309y;
	Mon, 02 Feb 2026 09:41:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::535" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769762042;
	cv=pass; b=LyL1LfctLkohFMBdUD73Oxvj20+2qn6h4NHMb9PzIAlTcusL7CuJxF2GnexZzvvZmA9PXVgvJ7xzppW9nB0FK9Byoo7UJlFRXoTzcNSVuCfQq6P0C3rofqHagou+XSpKJpVnm0r04B/e2j7RhsihqunekBGr1E7srrbZ14zodxopcV5zdsyBGzHqzoDTgtdvPFKlOn60nXJHVGrbffVjMS2nUABNUAK11GzLWInQoXrsIIAWxXQZFGFI7529V5cxy6d5VkNZjPGTZNapaKy+l/kPYciSq/g2ETz6Vv88ccw0KHvTbFzbMMG3CMy887yHXGgOSctgCRnBqbTJd8AOGA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769762042; c=relaxed/relaxed;
	bh=DstjTp6u8Wd7y76xr8vc9Pr66uNL9CypP1+PauCth48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U12R22rg67J7GfbZyxIp0z8n3v8on8167OaDZQbkWzkHFGPP1a6Bs/jGj1EW1hLsqGjbEyqWmq7ZMwRzVatDXu3ldp+zvxDnYPc2/WbZq/KPkGebev3h6WaReUetGOpNHBaOEdg/OUrBoGi9cb3rScvN5fsqjWne28eN378i0GdnVCWx8+ztiJJzkjgF6K4YfE+FYJK0gGrgBQDusVmYM+JI9MgDK7/hEbiNnU9pWNkUWtaJn7p0cr3zUyBySAJSotRXikgSjgBqIw8KlDUYHVN0v112XeBGhelIACXIhJiH185GuPK794EaPTgc4qiM+341nCOOOW3jtPGzf4e0AQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LHoaqRWu; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LHoaqRWu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f2TnP1x77z2xjP
	for <linux-aspeed@lists.ozlabs.org>; Fri, 30 Jan 2026 19:34:01 +1100 (AEDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-c46d68f2b4eso1069692a12.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 30 Jan 2026 00:34:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769762039; cv=none;
        d=google.com; s=arc-20240605;
        b=AckRNPTBJsHt4RI/b38DKO2B3qQldzNwdzhJtUTWuKkh452hbAZbYjetCdSmacE901
         fvoHoztx0RXeQiEEqy9Z5396oUNFG7UWynXn5ME3rtHlalhN67suQdYvflBmvOnH0SDo
         G1ISwhW3u03gZoydShkNZRHmYKsTtSxvx8eViat2dP/ydXdwFaUfdS1t3fOvYFPIdt73
         NMCidLayalAm0YrTtXccg1TDxwYv1VRLOEOAgH9NPGkozACyHqe+Mcw4gqsRYBqk92yC
         HbUh9hADZTZU/erB4NNyCfYarrLRCiYgTvJbdNlQVhNLWEGM6bgsOXNxCT7w8QTWxQpo
         +8VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DstjTp6u8Wd7y76xr8vc9Pr66uNL9CypP1+PauCth48=;
        fh=3Twds7G3vzhSbtGJszOuug6Ra1BvTEQdilUuGj/Xo2o=;
        b=TQsp3vJStanCOpif1yo8joIODtwHAfs23ePO2d9Kuxsgva666z1Q4ZcK8/jW8tS4UF
         0pZ6wLG/Za1VhET4Kvk8jEdBlpcK6HwtibxSNCB1qXxkh1Lp65MCqTVav5Cyt4dYjlTH
         Qghovh1Nzm0imkAzyKzNb9ig9Q+XR/revjKW3FhumuzyfOdXq7ctnI3wBgo01dASCGLw
         boHEiP8Z/gZPQv7ewOACFCjs9gMqEmvsSVPESmae5SQt5VFx/d5FkB+SDsiFlwKhErmf
         eawEhwmETOrVLh05kqA1PzqVyJYEd3/jg3Ft8VyobbgSwrFbsA7zKIG80zbawmHgSLit
         UznA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769762039; x=1770366839; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DstjTp6u8Wd7y76xr8vc9Pr66uNL9CypP1+PauCth48=;
        b=LHoaqRWumwXkurN2rvCeZOH2lXXzG2pZQkQ60Gj0xZhF49YFdV5tIMgPqGr0K4fCl9
         qTjgncsnyymVB/1MD5X4gVze31yurTsDqen5BHlWwjEG5xF/TknXvg7Uky25y6F9SHR8
         vptK5aMiO6lRB8QiNR1Bhylt/JtQY9th8hhMwy3OBx+oLqarmrMvNC++kONCSNoIvfMT
         QsqS0x5dWIHsLDJefsPA7swJr2aNereoRdEuDDM9IegebaSr5Ae8cloY3KiX3V8XyRDx
         rC2Fcn/49zvIlrTVAdSCeLDHIhdMYnnpTUf4thrdF8HBZTlmMJA+nwuWqW9aA1u8DXT/
         Al1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769762039; x=1770366839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DstjTp6u8Wd7y76xr8vc9Pr66uNL9CypP1+PauCth48=;
        b=qdFSmFtINEl8q3yCq4St5zWGdosEvlA36hNvpJqw4ElTzjiDC3adntpafNuRPlzkcp
         LiGa/jJz8BhmRz8kIcikYVVDx3oCvVQ2wynzmKzZgdof2KDbc+vjrV1yxbEoLO0q/0NY
         PhwBLnwwMRjE/Q5zZ2nHBjXeQtKd5lzEdaabIx9ipk6qB6VweDEnfQXmcY444Hh8ycdq
         eyV7AtAy38ka343m+EhErR6uhHBXT3q2h+/FGHVRzTLD21utZD8rb3wBYXsQw+0XiVvo
         ZdM1m/LJf9F1G2o/AJXVdOYVJMZEiF5GBlDrV0XPWpKyGVDhxYeGyOKotBPssswHgZnf
         fpNw==
X-Forwarded-Encrypted: i=1; AJvYcCWAic6tqEdsV6FIykDRAanSgTKgX3kDQsNcTFLkDdhVbsmZLOqFMwNU5685YgCsBgEe6HbXibpHi/F+SNg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx6ZVWD9auCh68JSXeKJGmqlZ5PsUGBKb+ZuScxFKmcyK0M/XR0
	114zM+yK6oEaxAS5KvIvPRGMpWLX6BvvsR2OCZp0Zd5a0lrFqetUHGbndrPfezgb/blIiehvVxn
	QONHhfiSpa0bwv4jbkHUZlN2QjrM/cN8=
X-Gm-Gg: AZuq6aJZOiLCTXB+imv0Zpy589ogjSn96IztcjrBgze3d4ur3hQ7hP6NpaiOwZKqmfI
	o09XLnK8OWSe9UBYDp0E1bRIrHFncPNyKrHGE8o6UhVpMAlVa21ER8vUFUJpmfmRiEKlX1WtQ0Z
	CBq5u1UNRVFCmGSNGTsu78SUtCwzOTtvFaPutonxZ7s2BsXtcYa5J65H/Eal/1+wqZwLHVRlffg
	JNrXhORaNfriYDgQ61LPXRWNAf3nTQcs9AjfLNsGZBD1cYKeOkc2D2Qc9JTiTKEpg81x4Ue
X-Received: by 2002:a17:90b:4c48:b0:343:7714:4c9e with SMTP id
 98e67ed59e1d1-3543b2dbfcbmr2065013a91.2.1769762038772; Fri, 30 Jan 2026
 00:33:58 -0800 (PST)
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
References: <20251219-yv5_revise_dts-v3-0-ca1d5a382013@gmail.com>
 <20251219-yv5_revise_dts-v3-5-ca1d5a382013@gmail.com> <4441e66d607fe442e392b8a82c134adced03a5dc.camel@codeconstruct.com.au>
In-Reply-To: <4441e66d607fe442e392b8a82c134adced03a5dc.camel@codeconstruct.com.au>
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Fri, 30 Jan 2026 16:33:47 +0800
X-Gm-Features: AZwV_QjbYy8HAFQFUZ1te0gk0l1xAwC-03Aak4VTwnvQbs5Hj8-mYxy6LbRydf0
Message-ID: <CABh9gBe=OcM8ExpEJFYj+cwiohyDRCXrTyeHZqQoyfJAsbmDtg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] ARM: dts: aspeed: yosemite5: Correct power monitor
 shunt resistor
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Amithash Prasasd <amithash@meta.com>, 
	Kevin Tung <Kevin.Tung@quantatw.com>, Ken Chen <Ken.Chen@quantatw.com>, 
	Leo Yang <Leo-Yang@quantatw.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 1:22=E2=80=AFPM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> Hi Kevin,
>
> On Fri, 2025-12-19 at 16:09 +0800, Kevin Tung wrote:
> > Correct the shunt resistor value in the DTS with the hardware setting
> > to ensure accurate power and current measurements.
>
> Why were the existing values wrong? Why are the new values correct? Can
> you please add more information here explaining both concerns?
>
> Andrew

Hi Andrew,

Sorry for the late reply. I=E2=80=99ve sent v4 with additional details to
explain the patch better. Thanks.

Kevin

