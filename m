Return-Path: <linux-aspeed+bounces-45-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E6ED10C11
	for <linux-aspeed@archiver.kernel.org>; Mon, 28 Oct 2024 12:59:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XcYPW07Hvz2yPD;
	Mon, 28 Oct 2024 23:59:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::129"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730120366;
	cv=none; b=Iw8saQhpjycIWWpHJ2ciXPDYRK+mRSo1PCVL0szqrVNAVq2huQCxNLN5h1j0UpM/TUaGgr28FoBlmsYdj6tDz2omL+Ht+YRtlXi86tdZDuYFo5hJLE2Q8zyRw1duNDNwhCQ62lQVv8ZOFjyA2O2/Jg1gxM5KCVeIIuieX8kjljVHZyIzPGhhyySdqTEyIplhAZf2bbuQ7AXKzRNhUPsTVqiekoNwGR3K2RVKz8N2gqxHzVlehSUKibTj7h6+afjsGqpemE7C8dPbdfc2xcBV4WunhKR2pPnkzeFN24SzFsWwjVXIta6Zpk9sEA1qvu40z3jXU5QetJaECvjSJcrgcw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730120366; c=relaxed/relaxed;
	bh=8FPOv073XmotRWP+rOXc9l76Bgjr4K2jU62eaHorWlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JqFR1SCKOR8Q1ilkYzS/V3LvEeqUoPtjUL5BbADBz9G+C82ChhAncJkbWyAFSJQBmTPtI5o4B+I0UaoUJT7/SA5uKvWVVDI+3JEzT+kRlGfQt8NoBpUolAAuXrMmVgMPBKop7Xhg/UVdaJQaqfqtZt5Mk8QPz+hAeOvYg/ARy6/OXeScAicUT0ZUpweSMzlJxH5I0NFlaEMJHB0VF4M1a+bA/6Y3IFPvelz0YesQWL6t7tgKppwDqlDa9Gp6y6wgx/eZSRgI/YsxCEdTWeukSIvEu0vwAlnwsR0gGWsonXtupdhXuCydxJSY86DYjuzPKvPm9eidQtK3Qho9COkA9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PrxdT6uZ; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::129; helo=mail-lf1-x129.google.com; envelope-from=linus.walleij@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PrxdT6uZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::129; helo=mail-lf1-x129.google.com; envelope-from=linus.walleij@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XcYPT2Fbgz2yMD
	for <linux-aspeed@lists.ozlabs.org>; Mon, 28 Oct 2024 23:59:23 +1100 (AEDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-53a0c160b94so4693794e87.2
        for <linux-aspeed@lists.ozlabs.org>; Mon, 28 Oct 2024 05:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730120357; x=1730725157; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FPOv073XmotRWP+rOXc9l76Bgjr4K2jU62eaHorWlA=;
        b=PrxdT6uZhTeCaDKBvbaogUyaO0+mKLCCWTNtZkfZbpToif/WRsSb/0vIaJzJz9Z4p0
         yB9OIu6sJB/TKsDab1kiTrVn18KTaRA+gp6PDW9xJq/P/EeW8IR4SSicVUCPiuawT3YO
         bq16OtFQIQYlIT3mYYwxdsLDNrURUSuNfsm4Irmm7SKoXDBAyEiJCEI0XNrksfIN7hfX
         0zgzrdNRkdM29XMHZTODdaiqqPiydXJQM6C4vDQFQR2/xHOMbyWNM5kk8ypJ2fSaaBy+
         RHFgzLnHDnkR9MhSpvposFFk9hLwYhfvi+ROhmQE5TE/Xvdf8Snx+TE2rlRCGWKxR3IK
         v01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730120357; x=1730725157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8FPOv073XmotRWP+rOXc9l76Bgjr4K2jU62eaHorWlA=;
        b=DbbIKCS1bCODyXlPlE5hIRPw2Fix9z/2sd6H286UcNd0LHpEWlAFpsTJyOfj74V5wf
         WixC55B5yBlfD4vXjkPQs4GwGSPWXgS+3UUzNF9zUnJxYLg8u/+Alu4bMl1UvgMcSgS3
         87DxG4KVsNIRP9AuQOspG2dJ3tCyXnbTzb+bF9OuSICm31l5wNNFB1onMV+Mwz561Ugu
         Bv0LEOLD+zIUjpqFI31V98+7V99S2JX9mSTIov3DgesvupfnLH7cMvbBBox+rADKlaQ6
         ypfoUyaJwZwnadb3DisfVSWCvpgeAwQfdngox/3aEZ7H2pyIKI2AmogfRuoJvIyJ2Lkr
         tbwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXt1HrFmCxq6yFCkHWgUQgYwQ2aHuWHVHezfaXMRPXE/9WIC7nNXakHKBH4IY/bBFqpaOsZR4Si/dqcWQE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzrz5IFk2l+Dm6HmY5JGqyznyNnidbd3fZTNClhC2d/pSpTAunu
	7qPWUuqF7hOTD+4q4l9qYczY20dSTlRWBE/yf9BZB9znCcKabBzHQp34P7zGqvPWTJp8Zs5VGvE
	IeICOf52KenBU+HDBidnBftI41e/ULTASd4BKEw==
X-Google-Smtp-Source: AGHT+IGx7tfNH0mZRuKTFpu/Lt1lVaJ5wzth2GIk/zrU6MEJ3/k+kc+DMdfavO6Q5ppLTlt1sP5ACchOTuFdcWBszp8=
X-Received: by 2002:a05:6512:3e11:b0:535:66ff:c681 with SMTP id
 2adb3069b0e04-53b34a1b681mr3290500e87.48.1730120356663; Mon, 28 Oct 2024
 05:59:16 -0700 (PDT)
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
References: <20241023104406.4083460-1-billy_tsai@aspeedtech.com>
In-Reply-To: <20241023104406.4083460-1-billy_tsai@aspeedtech.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 28 Oct 2024 13:59:05 +0100
Message-ID: <CACRpkdYEbczXUFD-CFpE6SYiqhwTdxS+w5+dDtLF=2BmeiJeVg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: aspeed-g6: Support drive-strength for GPIOF/G
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: andrew@codeconstruct.com.au, joel@jms.id.au, linux-aspeed@lists.ozlabs.org, 
	openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 12:44=E2=80=AFPM Billy Tsai <billy_tsai@aspeedtech.=
com> wrote:

> Add drive strength configuration support for GPIO F and G groups.
>
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

Patch applied.

Yours,
Linus Walleij

