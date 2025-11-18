Return-Path: <linux-aspeed+bounces-2950-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27968CF2562
	for <linux-aspeed@archiver.kernel.org>; Tue, 18 Nov 2025 22:11:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d9zMx45lXz2yv9;
	Wed, 19 Nov 2025 09:11:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763453517;
	cv=none; b=P9Uj5IoJ+k1+jEoNem0KaWlYjT0ZheAMsPod6abRhXQZnpR3QAttX0yezVjTtfLki+I90ZpigGREDldeZreYoCSW8bmMU24HRLWX6RXsoNz4/LALWeWpKwRDL1Mw7Q1x1hoY+QjP277B1UonC/OM9pz0GXf1niqEcVCmmRpLFaR1VjUy8rulfFS3TEeKOI2eKvGWsoxwT/FqPP3ubYZ5e8lId5L+AuYNGUHojZ09vIpUnunhNxdHJGvyelm8Ktno6lEQqWG/WJ7izKotWf9qCfe6Xht2GuvkmNSycR4Nzopc1sHAQq7hdbBRDHwaZLwqO78sJSbyL0dvkchcCtYftw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763453517; c=relaxed/relaxed;
	bh=FangEPCYJ/rRCDDLMOYHEdKjmgCazFk4RNT28+XjQGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lVoRDpsfn1EsOy5gnv1/WCXf1brusgU5r3xR3oNCITcy9RARH7iwn7Z01UzAahng041LomOHc7HC3PlPvyqQYGO+7AgXCdqvXoO0WmXkoBUgLl42E0RdmW9+Mp+vsmB1E4oMb4HSBSvJvJBzrWRvLwSCvy/qFiBLq0z4K3ZCor2eAy/VEj0bQyv6tq5cr8Ya8md7bxTbUvnQYRz4TpqCaT2waQLeUi2KMZ1UltbM9ibYsKO76pScu7wFjxtzI5Aw2rHaRVxN79FtO6FfVWurc/SVtwp8yryoK8n546fPNnrwuLbRewDzBNpuzZPUHmARieB3EBlWRCPl5wdx1mRRTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=jzXB8wIS; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com; envelope-from=sjg168@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=jzXB8wIS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com; envelope-from=sjg168@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d9clc4q01z2xP8
	for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Nov 2025 19:11:56 +1100 (AEDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-b7291af7190so748386466b.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 18 Nov 2025 00:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763453513; x=1764058313; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FangEPCYJ/rRCDDLMOYHEdKjmgCazFk4RNT28+XjQGE=;
        b=jzXB8wISqugzlDYl+JRvbj3zhk5MH92HJhDQXHW+LAdnK5edG+UV8GfDbZ8x8g7kG4
         k+pwYt+M/XJKgVaTc0c9YvJB3CaOQZgAlkI1rlZST5GqGmQXCgj2Ac8hqsYXLP1XDBHi
         7WPVTJEG8rNFHYu8DAirL8b37hKznD1WLvExppdbjEgj5HzY6mm4432s2bfXCpcczrty
         OKuLNPkpdXKMIXpjzUst6dQwLMj6Q9bgHJ4+damZhdJMmwlB2QxzvVxID06yahSp/XO3
         1CeDG7lHMXpq5tVgewpAOWlROM9zwdJhNA8qhaLNJfxIsXR/dY9BJ6ok2FrCY5wmkOyJ
         zGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763453513; x=1764058313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FangEPCYJ/rRCDDLMOYHEdKjmgCazFk4RNT28+XjQGE=;
        b=wzZzZpRORHt9alt/5/DIWCaadGi5ljVTVurCRIIo23+9uDZIy2SzqXG1LoXZrkn8dU
         WL79zQmYX4qtO0exzSEhiMDumNurrXO7R1oCGAN3L7WDRgDDpoLcCI5D+t3V2aRNrDtn
         yDyAVWVYLtsoQEuwrDSFg9zseOBk+tG2/Q2BWB+KPeOBxTOEh4wH+QRio98KWjelDE3c
         Cjf3PRpVJCGdU/HKAImo4T4/REqIpHZDKP88juDqkIBS5Hq4TtnJ1rHU+FXdzbSp9dyQ
         5JI4iBKTkvNxvTTshICOEL7J2n4YOuO8YeU/mWoD1PQT9ihDl7QaCZTh7Uu/8W45CBvb
         LXcA==
X-Forwarded-Encrypted: i=1; AJvYcCVBHU/PKZT/hzJAsk3x8hgk9ktLiaO3iyQ6rLH3kgxLBi/p4dLcQ+0I9bxL4thE8I5hslMtH+F2HF6SGzw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxn/i/Jk3GT2oY/82DlJaGZGabMdXJL27q2xDW72g6fOZqmExed
	QBxw7x7zxdlVzTrsmjCQ13tRMaqbKRmbeSxjmsR1FEP4QUBtuOgfv2Mw9u8pOMxanGat4nqZt51
	VqNFFOJEDk923bZK8Lcfjnv0qLRtRkdq93tiEn0Rnqr2E
X-Gm-Gg: ASbGncuDxK0M4SXXtpYTUc1wypud6Zn0+xXHm3BYIQ5vMGXJQxid93PO8mgE2+xJGcD
	noCLrPa4RP1qWKZnz4THgCNYLrrsHH3ZYqODET4se4USPgT1FEQTxYR5C5liSRFg81Ctl6s/sgu
	TivwYt2/tf/oBmCwWauMteKCRA9npzv/ZvT9apRSgjItYZG3JJFmFnmufvER0/4u3Vq1QJw+sU8
	wH1quCdNvG3kCKnsW4nDTyHvRYZJJb5i52bScekffJhrExB4yHogCx/SDn8csbCeQpyh0/n
X-Google-Smtp-Source: AGHT+IEHcPR+OwRwsqJJ0/uai7T9Z5bK+GvtX4wZ68Jnfq3MM6pnPM1BSU0qX5Ee3pQ1MpaQJy38JCaslU+Q+taVZiE=
X-Received: by 2002:a17:906:fe07:b0:b73:870f:fa2b with SMTP id
 a640c23a62f3a-b73870ffaf8mr1152686566b.27.1763453513074; Tue, 18 Nov 2025
 00:11:53 -0800 (PST)
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
References: <20251112211248.3711889-1-sjg168@gmail.com> <20251118041058.1342672-1-sjg168@gmail.com>
 <20251118041058.1342672-2-sjg168@gmail.com> <c061ee38-5026-497d-b757-b0b9db2e6729@kernel.org>
In-Reply-To: <c061ee38-5026-497d-b757-b0b9db2e6729@kernel.org>
From: Peter Shen <sjg168@gmail.com>
Date: Tue, 18 Nov 2025 03:11:41 -0500
X-Gm-Features: AWmQ_blpk2ySgsdJXTAlDZEU8KUMAaf5aD3b5YcZV7RoXMMcHgsFu67psNDCtEU
Message-ID: <CAJTz7Jd_fuTXpsseEE_161a7nLgoh4g9nH7M__HTsGihqNLQWA@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] dt-bindings: arm: aspeed: Add compatible for
 Facebook Anacapa BMC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	peter.shen@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

Thanks for your detailed explanation. I apologize for ignoring it earlier.
I now understand the importance of Acked-by/Reviewed-by/Tested-by tags, and=
 of
not attaching patchsets to unrelated threads.

I will follow the proper process from now on, and also fix my local b4
environment so that generating the correct trailers works smoothly.

Best regards,
Peter

Krzysztof Kozlowski <krzk@kernel.org> =E6=96=BC 2025=E5=B9=B411=E6=9C=8818=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=882:21=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On 18/11/2025 05:10, Peter Shen wrote:
> > This patch adds the compatible string for the Facebook Anacapa BMC
> > which uses an Aspeed AST2600 SoC. This is required before adding
> > the board's device tree source file.
> >
> > Signed-off-by: Peter Shen <sjg168@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
> >  1 file changed, 1 insertion(+)
>
>
> So you just ignored everything I wrote? Long explanation and you just
> don't care?
>
> If so, then:
>
> NAK,
>
> Also, do not attach (thread) your patchsets to some other threads
> (unrelated or older versions). This buries them deep in the mailbox and
> might interfere with applying entire sets. See also:
> https://elixir.bootlin.com/linux/v6.16-rc2/source/Documentation/process/s=
ubmitting-patches.rst#L830
>
> Best regards,
> Krzysztof

