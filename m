Return-Path: <linux-aspeed+bounces-3418-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94078C44506
	for <linux-aspeed@archiver.kernel.org>; Wed, 21 Jan 2026 22:02:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dxJ815GBRz30Lw;
	Thu, 22 Jan 2026 09:02:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768999366;
	cv=none; b=fYK7gW1TrbQIeR5onOSFj+QGJM+nY7elXBiwN28e5BId0k4PiUeZqIWiACcb1WLzxgITFNxzCYsKnALS/+E+vwXMoNZy4IGnHBF0D/m52vm7315ktz1Pq9NF2JLVEXKjzMj2Gm3tF5C68i06d2NDZIGfSHaWdAb9SyB1RgtbfF8FVbSLk0MOeOii/VSIW6npOUvonpXtqnQRlMKkHf/8SI7lKm1iO2Aw1gl19VjvfETE4Fv8rBjZ4DJbB0BEojneFzcZRDI6m4UnviKwhX6Q9x8eVDiwAJJlB/C9tMkV64nTdzwIfnmO06NuVmwH55fDc0Gu6V4P31fBHVzgxpgwQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768999366; c=relaxed/relaxed;
	bh=0HjdByAbPJTeDuGEDNiYTUtgD0UckMjRF1RPmGXvzV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RxiY3EB4us7dVchKCQQlBxqRLKRPjyn1hQJXwdrCSIxBP7U4GNg7jIMnW0ZeSPMz43uVwhRDqAExwQ6vc7EwRgQulb5exBhoXNvH2hQMbk2u73H1YRQEemoFFsO6CDUk8b8CjYiO4u54ulRiEnVGBf/N0FreENSinik8BTtHEUuy01HquhSp5XpDVNu9ynWSsaq7f+SDpRZ3YMJ4aEN4m/YEFVhnmyc0BGrRMoxlz0ns5851Dui94blo/87aVohTRR96K5xixvlauoQih5DgwRjiPJ/tQ37NBJq2JHiDUFJiBCeKY+gcQcta7/VXi/++EJvA9TwwJp18/dGkDNhONA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UnVC/BhA; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UnVC/BhA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dx3kY62qWz2xqD
	for <linux-aspeed@lists.ozlabs.org>; Wed, 21 Jan 2026 23:42:45 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E8C5940B2B
	for <linux-aspeed@lists.ozlabs.org>; Wed, 21 Jan 2026 12:42:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C85ADC19421
	for <linux-aspeed@lists.ozlabs.org>; Wed, 21 Jan 2026 12:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768999363;
	bh=0HjdByAbPJTeDuGEDNiYTUtgD0UckMjRF1RPmGXvzV8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UnVC/BhAV8RExjfRBGxd4SayHpkI6BXVApiddURNH6LADLweuCDo1yeyzxzzcjMKt
	 MNmEBWXfNGJ/p7Wg1W+pMupV/HHb7qvugLSoAFgklqtk/REb8XEEB9KfAXCZes1942
	 rY6K4B8xvhtKwh5ACxg0EykQDuq46vPZLAbl4G3hJ8VrEk99svpl4XvZ32gcUZSMxg
	 9ggkZOIeMQD+lgwX/pdji+pctRty4i7P5G1gCLjpL3IVfClR+H2k0YoV1a5hPhpliT
	 re4rsZjSWR0PC4HxDmXFVifTZsgaA6x4Sd/nqvrq9MruUBraCOoRiax28OHE38+a3K
	 L5qypK48qfwbw==
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-649488dc7bdso524176d50.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 21 Jan 2026 04:42:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWhbj+4U5fnxEuoYZn1zd94p/FiMLHJLC7+DgIhkgEh8rzc53scFYN6+xOPLL9CybfwqE9LH4y40UHADsc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy0pfQgZiyBw9/qi979N14OxEZnDmHTykDdZRL2jqFEBP5SfEcs
	9aiNYg9znCZpHU7cGvjxJg4sf8usBkY/i4athED+pZkIqj/ap7k2XARNkr/c0jfvCr7He7oY23c
	cIS9HdymDzJ+ZSjr7dTUz8qDClL+iCQk=
X-Received: by 2002:a05:690e:188d:b0:644:60d9:7525 with SMTP id
 956f58d0204a3-6491651e69dmr12004302d50.87.1768999363203; Wed, 21 Jan 2026
 04:42:43 -0800 (PST)
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
References: <20260117-upstream_sgpio-v1-0-850ef3ffb680@aspeedtech.com>
In-Reply-To: <20260117-upstream_sgpio-v1-0-850ef3ffb680@aspeedtech.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 21 Jan 2026 13:42:31 +0100
X-Gmail-Original-Message-ID: <CAD++jLkSmV1kVT+c2Nk-oWMS7WPgeu2NbF0yt4SUVsTmAUjq3g@mail.gmail.com>
X-Gm-Features: AZwV_QiQRH_FgyO-4O8MQg7hUCGXaZg8vwoF5MWGo_Re4DDhsmu71vEaHa_pOBQ
Message-ID: <CAD++jLkSmV1kVT+c2Nk-oWMS7WPgeu2NbF0yt4SUVsTmAUjq3g@mail.gmail.com>
Subject: Re: [PATCH 0/5] Add Aspeed G7 sgpio support
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org, 
	bmc-sw@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 17, 2026 at 12:17=E2=80=AFPM Billy Tsai <billy_tsai@aspeedtech.=
com> wrote:

> The Aspeed 7th generation SoC features two SGPIO master controllers: both
> with 256 serial inputs and outputs. The main difference from the previous
> generation is that the control logic has been updated to support
> per-pin control, allowing each pin to have its own 32-bit register for
> configuring value, interrupt type, and more.
> This patch serial also add low-level operations (llops) to abstract the
> register access for SGPIO registers making it easier to extend the driver
> to support different hardware register layouts.
>
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

Changes look reasonable to me!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

