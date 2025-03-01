Return-Path: <linux-aspeed+bounces-894-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6002C282D0
	for <linux-aspeed@archiver.kernel.org>; Sat,  1 Mar 2025 18:12:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z4tTG3c7Fz2yt0;
	Sun,  2 Mar 2025 05:12:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::235"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740852738;
	cv=none; b=YqQ2f03FwQS0QkdBz6TSlOdjV/yGugqHgo+G6pphhb6J51a2CE/kANKykFB8ooh0Qs3Y9sju80MVfReKZjyjAG5lnRDdTZ6XHDRAwN5PrBk44QQ5Wy8JVF6mFbZgGUOBZz6dLIu9N7cFT4cwBanytgCdIAtruVepkl1D1dUdo9CSAi14XhygHRksvO5682bX6AXZeZ5XT9xNbg+YcCBaXPnitxlGf77yUmjJUD+/kXClrvNJp5tQpCsnlVFkBTKlXiyO3kEb7bSwSYb7Lpi9bM+WR1x5cSjqNsPcG/ugjtLycWcSQFC/AqNZ2aM1FrA8SRVKzepgD/lHU7EzCDeqRA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740852738; c=relaxed/relaxed;
	bh=Eg0hFQaD8ycLhbpwZvT+7PAZXueZuxzeChkcp4728Mg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TbLawnG7DYeZrt/JXP2+UM+pB/eERBIUgNh5jvkilhEM653gBPW4/CO/Tow06vOI+yQtVTzwwbJpSIrZ83M6Ub1QUAFakV5PB6ExHC001RvpfwOuUAw1vh9T4Up7RJlb5AzxHpxH+TVlwo2cnV51WNd7gyiJt6WmWaGO2rAh3/HDvXPjp5F6ilGI6oETt1HUu9L+5k69K3Sjxe+/SbXigiXv1fMeUAEZP1TqPhWehToyvFrfjqjftE9TRpmdFvQao1OEEhMrZ50Q36eeNaehcLiFHRGvcfm3h1cQgkh0ux6IXeydmDw0UhnjdtDIT4L86fjE4LLJXyvrgOtoFmNLiA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=lGhNNYQ5; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::235; helo=mail-lj1-x235.google.com; envelope-from=linus.walleij@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=lGhNNYQ5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::235; helo=mail-lj1-x235.google.com; envelope-from=linus.walleij@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z4tTD57smz2ypP
	for <linux-aspeed@lists.ozlabs.org>; Sun,  2 Mar 2025 05:12:15 +1100 (AEDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-30ba5cccc19so6582761fa.1
        for <linux-aspeed@lists.ozlabs.org>; Sat, 01 Mar 2025 10:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740852728; x=1741457528; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eg0hFQaD8ycLhbpwZvT+7PAZXueZuxzeChkcp4728Mg=;
        b=lGhNNYQ5bIiiV459O/V/+j8IQ5VtXmtgKPe3ybMN29TfhbTioU9muKV+1Je/SzcOBp
         LWkZBigKUsKRdK0sFpXIs1Nq9bPVdPSVZ2RTIP3rexikge/5u3VNEV/sAne+ZHpVMSYk
         eQgc1dNIASdM7QXCwsIogaEAfNUXtxLbbwjb4T9LnMrZScYWY/DUliOyeAuFVAxKpk5p
         CZ9EnEXvVVDlX9XepUviV0o5FKDdAdLtbz/jcVZOVUwT4L0jHfn+AqLbQtKKmYF0uWUJ
         ZrzqWg9xRLGrCGGNHD9hyckgKInOBmo0bbfBCoXCxozoz09k721IqCw0fGR24Qb87jMz
         uBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740852728; x=1741457528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eg0hFQaD8ycLhbpwZvT+7PAZXueZuxzeChkcp4728Mg=;
        b=NcKK7OkSPSZqL6p+WxSDAO9FD3Q5GHa63q7aGDxAOM4WaHaoy7zxhmlgu9fO48OQ5+
         7HHH4NGDRmS8JnSQdXF9hFrgVha87thziW2zkgsGwCBqQ8J4pZJWlxHeRJ60hciZ6mLI
         2NwtENpxCwrOMUzYKAFUdeVH3K7WQZNhGyiHEofLM/c3R9CGBtSzmy652NkVw1daGC0V
         ClJq/6XOxyjJHAPsaN5U8kQOTEPiv3up9XJKlELwMreC1lRMMnXXFI7fHEN5leKhVw23
         ePzL+r0g5WmkCfCoav78Fa87Z5m/sHrOIjVdTe7MTEDeJAHiZX1TNuyK/HuGOFwBN16k
         hKPw==
X-Forwarded-Encrypted: i=1; AJvYcCV5PHE8Qq/HtEvAn0eEi+RuyAFR94aV2fc84AjssGFEZGgn1cn2Dx20s5TPpvNb9GK9WOcbV64vHAsW3zE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YylXrVz2qclhKbZKZdUwEj2kYO04k2U8QqSFMnRXiBPcPXQ+1mm
	KD09S8qAbTgUrTaU5/Ci6ZTxXqsEhFQBHd+tNLnVVM7QPyQkAbHbG4wPRdBX9HPmRPJAcSIvAAq
	0sq+f6dcyPOQsAURqpuTR4yt/hsXmc0zRptT/Hg==
X-Gm-Gg: ASbGncvxRRBll6TW/5ACvBTHTJOTQNJ0GkSlgDmxDEVZQY4qYJoG7nCep7wOXS7nZ3z
	2juTKajr99v2xSE4V6iEmocDPAzB9BF1BaXH/C4QpeeBqps8gQnsJOY2TPNnWnNJngfjXPBZfVC
	JjCYASbyHb86u7aCe0s0oR/zt6Iw==
X-Google-Smtp-Source: AGHT+IEH99Tq5urSrvxoc72GqejnsJAsNSDML6g3rnh8KP+Vmtk9gqB7j3gZFHmLs6QHmiQqUlP2gDlbwUBJuyx82iI=
X-Received: by 2002:a2e:8052:0:b0:307:e368:6bd6 with SMTP id
 38308e7fff4ca-30b933037d4mr26808421fa.32.1740852727658; Sat, 01 Mar 2025
 10:12:07 -0800 (PST)
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
References: <20250228-rtc-cleanups-v1-0-b44cec078481@linaro.org> <20250228-rtc-cleanups-v1-10-b44cec078481@linaro.org>
In-Reply-To: <20250228-rtc-cleanups-v1-10-b44cec078481@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 1 Mar 2025 19:11:56 +0100
X-Gm-Features: AQ5f1JrUCPCMLG1ATCrGher1b7FQk-JSwRhx_use4qjyzNuoMvAXn5iqo9KhAOA
Message-ID: <CACRpkdamF4B1y+zr-Y_XB8gAoSv2Q2U4VxuZd+ivZq7KV1Quyw@mail.gmail.com>
Subject: Re: [PATCH 10/18] rtc: pl030: drop needless struct pl030_rtc::rtc member
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

> The memory pointed to by the ::rtc member is managed via devres, and
> no code in this driver uses it past _probe().
>
> We can drop it from the structure and just use a local temporary
> variable, reducing runtime memory consumption by a few bytes.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

