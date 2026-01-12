Return-Path: <linux-aspeed+bounces-3284-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89026D25030
	for <linux-aspeed@archiver.kernel.org>; Mon, 12 Jan 2026 02:46:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dqGwM34Mqz2yrQ;
	Mon, 12 Jan 2026 13:46:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768185422;
	cv=none; b=ZufQ110M/diVSU1jxJ1hcG5zZkVse0zVpK7L8vIDYLvLqe9yuweCR0X9ghKktKmVtGxTtVVvo8kVdrV8TtBPd7FHDpC1J7PDide6n9li3moFd94jisUi3TVEgTqPU0naeILlXAT60k9ZLbOrSGA/oHz8LnsiTbRVwYNVPRMyCBfqpyE6D7MbZdXGeMrUIKw2KwUWKGiXVGJxw8s/ts15rO9f82F6NBnovfOL5UpBYUxGsl58q8dMnVofbka7H1D0+GOsUbKTgrwothVULWSv362yOTGhNmuTxNTCxRnHBbBfxubOE9uUWJLhLZVUhiSSytMGSFNRaeLNkY4gHQgCvA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768185422; c=relaxed/relaxed;
	bh=fNMDVPREvTyCqFpCO4GGC8yTEzwn1qHeHys6UKrheCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lznoqaHGgY70GAY3frgUKh/kFbDkS2IeIWmyaipo/zU9Nfe+iyWXwrtNzmrFz9RPHQ9+qcKJMCIoFWCCctg9DzsRs3x2ndC4prj9t6P7Iui24U0Ku3MxjpPSkv1KTPiAZ9ouDildJ3UzLfVaBuC76qMHWGVFvu24p4Bsbk7cCt/vb8/h2Eb7Pa/YYRjyxfxjYubnncWP67RLolVp36tLDuV4yHOwfNc2q8c1IO8jl4D+ZLKeNvK+J5riAeVD2oImL6T4QVVfZxX3NgkvDUfDg1C1llW6MAjkOAeRsJxusJT4dgIB0FV7/4PAmAad63D9TUoGyevq7xcf+DBnhT/U3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LaRj473T; dkim-atps=neutral; spf=pass (client-ip=74.125.82.42; helo=mail-dl1-f42.google.com; envelope-from=anirudhsriniv@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=LaRj473T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=74.125.82.42; helo=mail-dl1-f42.google.com; envelope-from=anirudhsriniv@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dqGjm63TPz2yr7
	for <linux-aspeed@lists.ozlabs.org>; Mon, 12 Jan 2026 13:37:00 +1100 (AEDT)
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-121b14d0089so6351619c88.0
        for <linux-aspeed@lists.ozlabs.org>; Sun, 11 Jan 2026 18:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768185359; x=1768790159; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNMDVPREvTyCqFpCO4GGC8yTEzwn1qHeHys6UKrheCs=;
        b=LaRj473TyJ5Yr5Fz4/oQf1RUlSq99pvmQz74x34jl3qZN1sV8YZKayVfksr21Jz1Gu
         1fZjFhXg04duCFJ1P1ThiZfanmasadXo1yPM8oC6aRPz0qYVz2IsoeRPoHrHm615FiCy
         DgTaYY/KS1bfl/cmKSoM3lE5jCJGhZDuOlMNqDFRVVC4mVwX8E/MK7LBhnOI8BP7UG/f
         15TOQOCTZQuo9wY6g2hF8UNECFGLBlfCX5nOH3M+D9zPSldnLyamd22mZjxlVQRY8uuR
         Pul4Ja1BbsRwmCEpBA1impoTvvNo2UmBxJDmGjRa/0EpWHdpiH0X7nSKR6uq0XeQaCe1
         hzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768185359; x=1768790159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fNMDVPREvTyCqFpCO4GGC8yTEzwn1qHeHys6UKrheCs=;
        b=f5dEcAwrG4bqmUqk+GWHb7y60ANr49JCtacnmxKjorrpvbGnT+y4xS6f+khwNrQiWx
         +XEkJRl9EO8gIQu/COa2urHf+nZS+ciKEb7Gcu/p5fDWs0GBt1U9QUNKVeU2rF42s/fW
         2uqgelKIkASh5Em1F7tVb49fq9CfAbcCfvN2PrC3hhXkfdXhb2UjSUgKuwE74c1kI47Q
         VAdhsIC50jHAxAOoUI87SlrBzDX8+bO9bHOSaH3k4apq0bHyEDjJnJVhNygei4Gfej9d
         0aDUBGw08dsQMdL5gZ9CA/HD22fjuw/GUgZeIYO/q6nNXpGAKJ/6VAl4pDfk2YYmBDtd
         0w7w==
X-Forwarded-Encrypted: i=1; AJvYcCVpuhP7qiG5pdgyZujFHas6+ZGnLGGTSV0kXFDFhcue8K7tkY9XsZ4DoklD0sUXKR3y+M1SXn/kF9kDOCE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyZOcc09rMEL7A3/5kbQRyIc8VomjlmPLo6PxyRxX2FsHPJ/zHE
	vvEr12Nucxi+2CY6tzrt+czOsRGcwoOgtoJaYli+XkLCDhsMkMBxeOCK12F2BkW614Gdxd1anI3
	BuPEgaSxd0UKiObJyPrIC9FDB7PqQ5lw=
X-Gm-Gg: AY/fxX6s+b9Bof6iTzcJ9YGUl46pNZjKTx/D5h6HDtJtTXAcYC6tZV7hhnfdYFmTBPT
	nz5tKIkWo3f2I5KMmOkPYgpsxqwMK2Fo/Fvt3KGgTvyMIH2ffAKeonfkxYvP09lUw5OxGxt6+Qo
	Vbf721xEBn8Q8ipmepiBXo29pn9ERvxn7cb7Lhm8Nhzm4KJAi7LjV6XSFeg+8ATuZjE/YdAot+g
	k8M6SThrL8omFTYJtYLS4q+052PRyEDyyOp0eLQZm0bvQP6R0Gwj0JmLsr7JXWpezBpxX2i0EJr
	K7SOqsb7
X-Google-Smtp-Source: AGHT+IHqGWk88ovtC3TEuodNYX+bMcqvdaiZBR/imT8MmvR+sMpm1rfrn9QGmXdJQVUgOtHq5GsIR9y5lIaO8jo6K2c=
X-Received: by 2002:a05:7022:69f:b0:119:e56b:98ba with SMTP id
 a92af1059eb24-121f8b8ba79mr16811710c88.33.1768185358522; Sun, 11 Jan 2026
 18:35:58 -0800 (PST)
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
References: <20260111201040.162880-1-anirudhsriniv@gmail.com>
 <20260111201040.162880-3-anirudhsriniv@gmail.com> <3db927cd7ece9b0672b9e62eab64b951594470dd.camel@codeconstruct.com.au>
In-Reply-To: <3db927cd7ece9b0672b9e62eab64b951594470dd.camel@codeconstruct.com.au>
From: Anirudh Srinivasan <anirudhsriniv@gmail.com>
Date: Sun, 11 Jan 2026 20:35:47 -0600
X-Gm-Features: AZwV_Qj-g-Hn-yu4F1rRiaFK5tjlEcz8m4j6EVdmevlQ3RV8K5KL_wx3zDjzXrM
Message-ID: <CAJ13v3TmUQ8oQT6uwK_=rP7vWXy37Gzjmgv=cg_3HkgerPJNFA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: Add Asus IPMI card
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Sun, Jan 11, 2026 at 7:47=E2=80=AFPM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> > +/ {
> > +     model =3D "ASUS IPMI Card BMC";
>
> I'd drop the "BMC" from the model description as well (wrt the
> discussion on patch 1/2).

Yes, I realized sticking to its official name everywhere might just
make better sense.

I'll make this name "ASUS IPMI Expansion Card", change the compatible
to "asus,ipmi-expansion-card" and the dtb name to
"aspeed-bmc-asus-ipmi-expansion-card.dtb".

>
> This looks good in general.
>
> For the purpose of review I've started requesting that phandle
> references be ordered alphabetically, because it's tedious to confirm
> they're ordered by unit address, and it's nice to have consistency
> across the files. Can you please fix that along with Andrew Lunn's
> concern about the phy-mode?

Will fix this up and resend another series. Thanks for your quick response.

--
Regards
Anirudh Srinivasan

