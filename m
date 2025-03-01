Return-Path: <linux-aspeed+bounces-895-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 907BFC021B8
	for <linux-aspeed@archiver.kernel.org>; Sat,  1 Mar 2025 18:12:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z4tTh1rNMz2yyJ;
	Sun,  2 Mar 2025 05:12:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::129"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740852760;
	cv=none; b=YQ9dniCTkTW3lrZ0wbG6py99gSAVgMqAD1eikDJgWWB66m3uS1hteC3bQuQ+Epc/cu0uSc7t7CWYPJ92vzILez5XFA/ZkmCsR2UPe25RMkcgKKNibjubN8oWB1HFftoni8D4gAFVd6mkrlhng0QJFfV4cjowkm1SurrNWYaC1ByBXcgqujOQ+MykZ0zuzBknensXLTb2+B0d7XQq5yRmRmAbE7+IEVjIe+d208Idvlge0VKYSTMcuESbgoyICCGeTkH/kQZGAKeFKWmiLU9UvZUuu1v5+/t/U3IFgyZ0pBHjjxreEZfZGp8KN9qBiEPmVNSi0mgiAGhNbu94RSDmNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740852760; c=relaxed/relaxed;
	bh=hO09TeiGW32giSrF/zFbXkUU8toE5ieO9mC6ZpO9u5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CCXIkpnKrd04HVdQrYM6Xvie+384ip2hhAnNpnWZDWRghmz27YQw7qOaVHeAxG3hRdTbdUNTz8G4XJE2gxyzIAgO7R+fDgrAuuRq6ecc/6eeQ+K/FQLA3jbhbltS0Tb6q30NesVRdgRcrxVFaM6CwfctuR2w/mLA0sbbokcwnkroqx6LKOnPfS8hoeqrEHhwi0WeL4rHOnjuWfy52Sr9XVVLGT1TXgNxRc+djT/79E/jOe4mbByrx600wQrRdI8fSQZfFXI2SS977QZPg8IXIqu8APvu7UCQRJCdOC4Nchym86qEZrTx8k0A0gk7GC05nyS7vqc5AbCWYCt4nFlhQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=V1ZuY353; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::129; helo=mail-lf1-x129.google.com; envelope-from=linus.walleij@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=V1ZuY353;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::129; helo=mail-lf1-x129.google.com; envelope-from=linus.walleij@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z4tTg1LFlz2ypP
	for <linux-aspeed@lists.ozlabs.org>; Sun,  2 Mar 2025 05:12:39 +1100 (AEDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5495888f12eso1074576e87.0
        for <linux-aspeed@lists.ozlabs.org>; Sat, 01 Mar 2025 10:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740852756; x=1741457556; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hO09TeiGW32giSrF/zFbXkUU8toE5ieO9mC6ZpO9u5A=;
        b=V1ZuY353E7GFhh1ZqfgzfE3W+tVScf0wpzOGaXnLe58Yc1h4h5a0N0SAAGkPcs4Y8Z
         a5ynXSQRitW/xkkVsm/woFdcM/VhFx5dR74c2pR9oLfyedbzgY/+mt7sq5QDwsY/H4H3
         eMhAT/PWYSGqnn6dD9mQrtzqk70A5mlTUJUzzpQuplCTbGNKJtJVdrZlaHhh+0oMUUNd
         XNUfZ5jXq5hrPssmdbGlU7qXK+SnwF8ByNETE31iu3fxHYDV0srRk2meon/WDR/zYLmE
         /Wt9DIW9lzOAB9FIpCmIOL7SNFp62FK68v5Xtfz+TnAW196yJeMfUWkVwHHAhhRMT0eH
         Zz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740852756; x=1741457556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hO09TeiGW32giSrF/zFbXkUU8toE5ieO9mC6ZpO9u5A=;
        b=gVOjs0OHCQbHLDIgERtRCWBK7PqQqw7BKWCHErsVANfwdYUQAx+gaKTeRTOkCbzFhE
         gICQzZQOyZZzMgK64XiiM7qMPrqabNm2gNgHMzUUEfzPdTGlLDxxIgwZwHQAyfEFFrcB
         OVtKEAetIoLxrdnY1G4uXRemkpn3eBeq2jEa6kor2e27BcwYH1aa7uCXgvFa6UTJ3m4B
         Kj04XqvdnT8XF4h3zIzWTVuyNjPbWI+ktrgD2/NxhwvQ5+CS7/nGWnZTQB+eRo30nZHP
         HCcFV9XdKdQI/vEIPtTXLJfgIPqtQNLRKpqfA/Q/L0FtFlCGRh0y5ZjkRHU6V+9IBVw+
         2Ptg==
X-Forwarded-Encrypted: i=1; AJvYcCVM2n0cUUW9Puk5kGdF0pxyCpf7eSovw3XlTWKCDR7yScfvHSVyZ3Mrd2HB8DAfvezPAcZ4SrL9LTae5tA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxw/JvcrPgS+HTu+0I9AjKLaSEuc8rKtLyabi0//EkT/6G5adtF
	vXviELKMvw3thyXqp+K/S7FDYZPIc2wPc9cRAs1X8YEQN1Z6T8h7w/lJHZ4342l4XXWDYqOsdyv
	FUMD9e2zrHSvKlU9cy9W4+OFJCDvDwXw2K5H6SQ==
X-Gm-Gg: ASbGncu6wwS+wooTcTmCN2eEjF14Rbd866q2nEPMpzfrK+5gz5n7aq5a494qjzJfOnA
	T/Ju9N9veNSc9XxqNTexvxAA1kwqr8cd7Xc+jQKj9QMrYk43MN+AusYd8UC3KvdWn8XqUWsX4b5
	b67QVpv7PaRzN7rzb87jo10pF06Q==
X-Google-Smtp-Source: AGHT+IEwNP6JAG/ImVlBbFKSPeJyF+kN1wgYSyFdUn518Azn4ly4yqI8vygkNmnNaNRO/2W3XMFUQZ4MRvI6PuiQBfo=
X-Received: by 2002:a05:6512:2391:b0:548:f3f5:b26a with SMTP id
 2adb3069b0e04-5494c38bc42mr3507636e87.50.1740852755828; Sat, 01 Mar 2025
 10:12:35 -0800 (PST)
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
References: <20250228-rtc-cleanups-v1-0-b44cec078481@linaro.org> <20250228-rtc-cleanups-v1-6-b44cec078481@linaro.org>
In-Reply-To: <20250228-rtc-cleanups-v1-6-b44cec078481@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 1 Mar 2025 19:12:25 +0100
X-Gm-Features: AQ5f1JrMxHjOeiAFu01e9_js8hUt6QETaY6N275XhvcjrnB0bEBgE0astCzSAEQ
Message-ID: <CACRpkdaWjTiqSUj59YiQZ1jsJWzHZPMo3xS6n4_JwdAW6B_Kfg@mail.gmail.com>
Subject: Re: [PATCH 06/18] rtc: ftrtc010: drop needless struct
 ftrtc010_rtc::rtc_dev member
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, =?UTF-8?B?VMOzdGggSsOhbm9z?= <gomba007@gmail.com>, 
	Dianlong Li <long17.cool@163.com>, linux-kernel@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 3:07=E2=80=AFPM Andr=C3=A9 Draszik <andre.draszik@l=
inaro.org> wrote:

> The memory pointed to by the ::rtc_dev member is managed via devres,
> and no code in this driver uses it past _probe().
>
> We can drop it from the structure and just use a local temporary
> variable, reducing runtime memory consumption by a few bytes.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

