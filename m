Return-Path: <linux-aspeed+bounces-3241-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3ABEFC6168
	for <linux-aspeed@archiver.kernel.org>; Sat,  3 Jan 2026 01:01:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4djj1P4zL1z2yFW;
	Sat, 03 Jan 2026 12:01:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767306931;
	cv=none; b=nd1pGQPmfqAUD+U6V+LYj3UKRBlXqrHioBjZEPOFGxWXV6QJjCDo219swJv+7LL7uUY2RyFitQ3N73VzSzHNJaNWJm9p96odkJRcl7Z/TdF+gyI7fgbNuxxHOOT6ymb3ufLrZ4SJh82NK8fGucH71xQ9VFFTitnYeM2+XjF7+co4yMNo+/ueeFajOTGHarAJnyV0OBPVbCAxgnU/xDjmJzq2BvQWIy2Wk5uDi0WrN30DDQxO/wftqXaXYJ4GPpL9Ouzvi/pKTPrtfUtiAZ3/b8NrDIDBheSbMIRw/c9SeW9IQhPkdb9SNn178SDTRCq8Nq6ieLzywxaLWAC8ERbnzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767306931; c=relaxed/relaxed;
	bh=QMvcHOsvbeq/KIs3IJ0EOSwRJPyItWeiXV1rTu2E8c4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MaEwg9vdvjm9WO50TlpBgoeSfxjC5nJ/dt+Vyp4QdCoN5PmFjNa2BIOfenN+c0bh5HjL7Nb8U5XgKRoKrK2g95EJpK9gDOvLv7FqzZ8zWTa9kPql7dsTOpgcHDmo3cG3jqvGyv04ubjzi8etzMZXoonuY1KzLlNKN/NwEvzzA8OE2M0qABvkolhae0IxI9EduoirD9l3JCcFC+/6fSl02zYyYO54y/2J2dt5LMF7GWZKFlcztYctj+0Xb4Q320RYoNJUxbxp2b7uzHJpQUd9X65nzcQr8KX9zeNcrgf8GAhnP9uj3yv1FJ0kROxqFElfyuebI0XpzYgqGD4tn8PmQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TamhxSSL; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TamhxSSL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dj1ql2589z2x9W
	for <linux-aspeed@lists.ozlabs.org>; Fri, 02 Jan 2026 09:35:31 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5BB2E60054
	for <linux-aspeed@lists.ozlabs.org>; Thu,  1 Jan 2026 22:35:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14923C4AF0B
	for <linux-aspeed@lists.ozlabs.org>; Thu,  1 Jan 2026 22:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767306927;
	bh=QMvcHOsvbeq/KIs3IJ0EOSwRJPyItWeiXV1rTu2E8c4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TamhxSSLWIOQnVFBB+j1xRP5/0Fc2qml/H9hmn/sRwxOUNMOPZaCOqCscVhB+1UYy
	 TMg0pZ+LKEaH0bFuNBbtzv7tTReSpQlHlrNKLEzWH4THopRGFpKJFlcmQnbW6+BOPv
	 duJoNVJSJsnaKfyD62ZZzg9biYWkXjYLrsoxCWk9AdrG4ZLO+YrO+yitM/GTx0Lv9Q
	 ctW3z6Jss0MV5cRnpcYNa2FWaSRTOoh8TECiSyT1Z9sEDvccbPAX3MEksTrxoyUo6X
	 e0YmE/TdtuLVpv+pLnP9lglEnZt0MlvTtc+Iy3KkO37NMKXzbmDGN8mHbdfQIVImCL
	 dFi7Dt8Nf15xw==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-787da30c53dso110187457b3.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 01 Jan 2026 14:35:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXvml6TV7YFlSnrWMwP7FjGpG2VFQUhInCVetrvMDSTeMHf9NANrRaCsBVNWhL9/9RkS0kWLncGBjAJsqA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz//nznO6SmRluAT5wGVFXriQQRcTb4GewclkC/b9FLHbkYM55J
	3/1evEg+LuU5FlLdE1SsRyIjdMpJSggoyz9C7dmnSNOohVapw/5mxiVBkU6acwjf3pxDSELcUcT
	0NyFgZ1BQaN+w/dOTiM1pw/ph96Q2CTw=
X-Google-Smtp-Source: AGHT+IEeYsqPV6C7f4vJ/O868DjdRj8egVDw87qil6wCyQBZLNxaoQ2yxDSsZp3aYoWeqUg+edGFSQ92tz57Fm1YugI=
X-Received: by 2002:a05:690e:13c8:b0:645:53d0:2d20 with SMTP id
 956f58d0204a3-6466a8bfd42mr31278495d50.62.1767306926398; Thu, 01 Jan 2026
 14:35:26 -0800 (PST)
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
References: <20251219-gpio-of-match-v2-0-5c65cbb513ac@oss.qualcomm.com> <20251219-gpio-of-match-v2-1-5c65cbb513ac@oss.qualcomm.com>
In-Reply-To: <20251219-gpio-of-match-v2-1-5c65cbb513ac@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 1 Jan 2026 23:35:15 +0100
X-Gmail-Original-Message-ID: <CAD++jLn_aED4koAz-4+v-=e1DK2uZwBvLXAEC_g+PYTD1qk28Q@mail.gmail.com>
X-Gm-Features: AQt7F2rtDNyDLbQCzYXEsAv_emsxTb9NcgwKtFoou1KzZzvhme1jN_YZGGSmW2U
Message-ID: <CAD++jLn_aED4koAz-4+v-=e1DK2uZwBvLXAEC_g+PYTD1qk28Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] gpio: aspeed: Simplify with of_device_get_match_data()
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, Srinivas Neeli <srinivas.neeli@amd.com>, 
	Michal Simek <michal.simek@amd.com>, Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 11:12=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@oss.qualcomm.com> wrote:

> Driver's probe function matches against driver's of_device_id table,
> where each entry has non-NULL match data, so of_match_node() can be
> simplified with of_device_get_match_data().
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

