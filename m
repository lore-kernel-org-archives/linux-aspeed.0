Return-Path: <linux-aspeed+bounces-3972-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0CC1FF8875
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Apr 2026 00:06:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4yJy31cfz2yTH;
	Wed, 29 Apr 2026 10:06:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777367455;
	cv=none; b=krpBZMsxOsOmHiFB0wY4g+9ERzHEKUDx2h6clnibRn/hz9fPhUxRm7O1i93s3ZyAjk/wgus+ZvQplxiE0e5TBEhyeoQzUKE2iXKiwjtEFVyg/G4EjGOjC8hTFKpuziVJzecpBG17btTH8prTd4hi76OKViHJj489WPEpCXfXRLehdn+q295Lk863w1bHvL5y6BG+AhrGwIYzRn4pPJp7EfaYS5fPyNYR6kS0cGYqyPG3QUvgcz3V+FVDXqlkzrmVkKssVPjQUPe1roF9Lda8oaEEzjodcbZY3OJisbYzXCUDCF72i74t2A+z4OT8j+LP5AFnU/TyUqzf4jOrzsxFvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777367455; c=relaxed/relaxed;
	bh=TvOzo8RjsLIaVVajzywOgjFrzZwCgL5apopPTnfRjy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J+h5HUP+Ak1Si/R4gwnbnMakJHsrDWYLuW5SH87KU/EZTOkbkx+unUc09DZXNCGieq9xXOzgkr+ahrkxHFfSnBPEbC+56Hhm0jeA0PqwowZ3HMoPQNVE0CBNctN4Nn2OpDog2IAwZzilSn8Vqqa4xSi3LFnAxHwiAwbAIUhJ53V6RShZmJWKUyfgU5rfFwE7+MObJbAHhtZfDRjs0gX/Yw/R4SHAOB2WBNAwP5onT+tQJcD3YZ0ioVffI2wLnY02LeP/zKY6nUknoMjaH5jEsf+d/3xYqWV2srCryV6eys4wA72YA+XcrT537zbUHm191UAxBFh7YC7bcjv1fYG62g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YN0cVSjB; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YN0cVSjB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4ZRL5Rx9z2ySf
	for <linux-aspeed@lists.ozlabs.org>; Tue, 28 Apr 2026 19:10:54 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 82EDA60141
	for <linux-aspeed@lists.ozlabs.org>; Tue, 28 Apr 2026 09:10:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397E8C2BCAF
	for <linux-aspeed@lists.ozlabs.org>; Tue, 28 Apr 2026 09:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777367452;
	bh=TvOzo8RjsLIaVVajzywOgjFrzZwCgL5apopPTnfRjy0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YN0cVSjBhpqxw6QKrKuxWUGd11SDdOBA7ABeXT/kOAoepwMDJDSxLRF5wJQo5lmAP
	 PSuUNffzGyUujMFAi+ZvFWFsQSoZcLjM7nxpc0Up75sWfxrRjGBebrtFdIxP6OGCDo
	 pkpUQuOt67WzOzVgBAt+S/e+k8LPQh7RI7z4l3usttSPrYRukOqTNkcoWGJIWwWMAq
	 tHin3fxcpQQsW0FTtXaqUyDnD9Rhmwo6JG0oA5MlDDZCKjaIL2158mr5VKncs++iS9
	 Xn+8aXW/EkwWjC7/iUFZ1fVl0woDNBSBjUgLj7NRrdY1nnQFuSYkMr4X8piUWhPF8w
	 5MXRvYG/B0hGQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59e4a04f059so13680667e87.2
        for <linux-aspeed@lists.ozlabs.org>; Tue, 28 Apr 2026 02:10:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9+mczJNqTziRWS3tP1HHeI/qCZvqp1mFM9ORZusj4Eds4pY3hiMs4qmFyjLDrKbNTGjUXu8Irymxoe3jc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yym7JtghAhg+70iZRhxNu5ivViZONlCPK2UbhHilD3h1+tsiaUs
	e8rjl80JXkL9yijvoOMtajn5gOtq6hRakZc8pr8mmQo/6vvQgeFG1Qg6GZvngg2NqzW6zKXIwZD
	v7IX1d268g2j+oQMaUij1J+dwb2cOTXQ=
X-Received: by 2002:a05:6512:3f28:b0:5a4:505:f633 with SMTP id
 2adb3069b0e04-5a74662df1emr1039066e87.38.1777367450963; Tue, 28 Apr 2026
 02:10:50 -0700 (PDT)
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
References: <20260410-pinctrl-testing-v1-0-6f708c855867@oss.qualcomm.com>
In-Reply-To: <20260410-pinctrl-testing-v1-0-6f708c855867@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 28 Apr 2026 11:10:37 +0200
X-Gmail-Original-Message-ID: <CAD++jLmeH6Hy1tm-uTV7YP9gHc7vk+-vaYNT5cqZPU75Jyt-=w@mail.gmail.com>
X-Gm-Features: AVHnY4Lt1Nb-eIUW4vHkvKpaNVPQodgCRHtRa3BH6rlTVPd0JsgyLmESZ18n1Jo
Message-ID: <CAD++jLmeH6Hy1tm-uTV7YP9gHc7vk+-vaYNT5cqZPU75Jyt-=w@mail.gmail.com>
Subject: Re: [PATCH 0/4] pinctrl: More compile testing
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, linux-aspeed@lists.ozlabs.org, 
	openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	Joel Stanley <joel@jms.id.au>, linux-realtek-soc@lists.infradead.org, 
	James Tai <james.tai@realtek.com>, Yu-Chun Lin <eleanor.lin@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 3:05=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@oss.qualcomm.com> wrote:

> Follows https://lore.kernel.org/r/20260410103005.163128-2-krzysztof.kozlo=
wski@oss.qualcomm.com/
> but should not depend on it anyhow.
>
> More compile testing means better bot coverage. Plus having ||
> COMPILE_TEST and obj-CONFIG_ARCH_FOO is kind of pointless.

Patches applied, early in the kernel cycle so the more build errors
we get from these the better, we have time to harden the patches.

Yours,
Linus Walleij

