Return-Path: <linux-aspeed+bounces-3155-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0487DD767C7
	for <linux-aspeed@archiver.kernel.org>; Fri, 19 Dec 2025 10:31:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dXkN040bvz2yFW;
	Fri, 19 Dec 2025 21:31:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766139379;
	cv=none; b=f6Szd7rpLi9svl3fXeJhXTjF0Ify+xrW7/wVjlOV53TZA30AfTNugDjOi5aOI8EPZrLlvMefJr6S63Ju52PYrnNIDwuWWXqRAHrlJD9ySOhwdaBp4lffaGLO13y7Xa13spWw/xqYU5ajKve1ziYuEZHwVK1amTQbsNMCKYoBNoCDl7zIZ2D2x8j6SKMw2kdek1oD4clLfyUv52eHuFIYZfr6bGaw8+8QMVHV6NLlX20U60TiT+3hAO8Ts7b4LdL/b614g/Jdnr+hUJtbbH355jFJAUfWleNgkSGTuqZa1ixzBPs9XyKixZXpEcIIJ43Qk/WwZbDFJ57LN0nufrnIrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766139379; c=relaxed/relaxed;
	bh=TdAjtUXnPi9UdzGYCmAV7NNqxn84GFDS7LKrZANiOVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aqRLSvvFKNX6P4Zfu79JJVuzRDf9awgCa7w51GTT9h2cnI2ABdMss+3YmzGXs+E5jKKEkRa1vlAeMFP6CyNc6brAfilqf9YEZtPYCvD3W89KjloXk9s2HoWIf5N0Mm9AxCzBVxo3a8fB81c3sFhsGO4yvXOmcbfm9dSyjS22GLJgcirHDGWnKRicSbjU24jEnvVBJhfvciBr4rc3jFz2yMT15eu5qe0TmPNpRUfuh2eHJ1QvMa0KkZPg1gwHXRbiFU5TIb/68IuPc6ltkp5E87154zcpQKx1nSg3XT96d40cWChXbi7/6kmKIeiD/GzNtD+qtvBXQY8Wf1fpCxLVXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rCX7FEHu; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rCX7FEHu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXk2p2J9Yz2xfK
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 21:16:18 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 19260441A6
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 10:15:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED524C2BC87
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 10:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766139346;
	bh=TdAjtUXnPi9UdzGYCmAV7NNqxn84GFDS7LKrZANiOVM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rCX7FEHuAsJzXoANVF1g+jpqFnMFQ2EPdpnALxt66lpS2yFHO+yb+/c+s1mOgzQXr
	 sn4dhDkMNL71vaujC9wP3WmesPzqPlSylNIVv3AuMu/8D8uzV1C3iW2dRicMmBEcRM
	 7MHThacOhD1zvaviPLuNsypm0fpf1ZkoGTJUCzJbPbV1cYUJvgMdo436DCtWLpmFm9
	 yH78kZDqsGbnZiZe9vyy1/fIwPC5O8TXvX2at3jJRaO0Qwc4fMATMHhY8qmgQER3Ls
	 rzG4Y+h6xkGKmcuGMGJhGXFumKKgnd3aCR/2ilxFgClZtni16jR/clzhc/XHG3UHjw
	 /zWj+kYodStpg==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5959d9a8eceso1770496e87.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 02:15:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXn06fSrQ36Th47KqBpWeOogL2gGPXJVkqSV0KT5PrU8dWVwFyKPSDPQgb5y5NUtHKpDhonJbbzyr+gS80=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxicjo66LTqp7IyTlJlBVlSvlBPSiZGitDZJIamWzHftVhj6y7w
	zeTTw2+RqOA53rCxgRT2zB3FEB3y0WTPwglebcFrluthnzDCzOVaw6Q0YU0ajsOQFWLzxywGsgJ
	ResLK6l1DrOfFuRyaR97ceIpC1TkHS5XpCOEm57n46A==
X-Google-Smtp-Source: AGHT+IHXXPtjxI+X3g9JF7oZTi0dKlS+jo+mIiQg/lKY3jeto9hFI38mrhvbiHA2Rp4MB/8840d+uPeQ7mLwH8ZXl0A=
X-Received: by 2002:a05:6512:39cc:b0:598:ee60:8af0 with SMTP id
 2adb3069b0e04-59a17d8c2d0mr860672e87.19.1766139344377; Fri, 19 Dec 2025
 02:15:44 -0800 (PST)
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
References: <20251219-gpio-of-match-v2-0-5c65cbb513ac@oss.qualcomm.com> <20251219-gpio-of-match-v2-3-5c65cbb513ac@oss.qualcomm.com>
In-Reply-To: <20251219-gpio-of-match-v2-3-5c65cbb513ac@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 19 Dec 2025 11:15:31 +0100
X-Gmail-Original-Message-ID: <CAMRc=Md=KvKaXZvdwRd_rTp-Oq1qrAo12ENcUqTTWSYnCYSZuA@mail.gmail.com>
X-Gm-Features: AQt7F2rKNUD48qbiAtp8txVUkBhM27TcXELn4tTZ3gej5gIHuBVaFRaHInahGEM
Message-ID: <CAMRc=Md=KvKaXZvdwRd_rTp-Oq1qrAo12ENcUqTTWSYnCYSZuA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] gpio: zynq: Simplify with of_device_get_match_data()
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, Srinivas Neeli <srinivas.neeli@amd.com>, 
	Michal Simek <michal.simek@amd.com>, Linus Walleij <linusw@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 11:12=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@oss.qualcomm.com> wrote:
>
> Driver's probe function matches against driver's of_device_id table,
> where each entry has non-NULL match data, so of_match_node() can be
> simplified with of_device_get_match_data().
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

I think there are some copy-paste leftovers in your commit messages.
You're saying you're using of_ functions but you're really going for
the device_ ones. Also update error messages. And possibly use
dev_err_probe() too while at it?

Same elsewhere.

Bart

