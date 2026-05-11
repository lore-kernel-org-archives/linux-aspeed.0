Return-Path: <linux-aspeed+bounces-4011-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA948CD484E
	for <linux-aspeed@archiver.kernel.org>; Mon, 11 May 2026 23:51:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDxM91SM3z2yFW;
	Tue, 12 May 2026 09:51:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778529850;
	cv=none; b=i4O49H20xM3Dvx5DGCaRQTNcSyqlDxIEA8WzniOlL9h7XDdDewmGEPiqpN+mej41H4TQ+xAKaUawI0kwGCXNCgP/XdTakEw8cQvhEd+2ydPFQ3ypsc34cx8H7jnMyh9Eqn7Xwg6ca9CZpng68nYp8ZVYLCLqBtn942KjFUZShpxJh1Xnsypt58WPj8uRgOoIsX4/cG73YjMrcMLzTlxKnrnlkqe28HQZ8WhLvhDouZ5j7rSBAQ89f6e2MxYpaqIAn4qVXyApXvDv6pwgTpZB3hjyugToeyKSQYBKAG/gEpCeIDIPhZSYpnuJ/gkmaf/YuLhZjfFELt19piHDNZDz5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778529850; c=relaxed/relaxed;
	bh=odtlCf4rIw0DAK3X4l8eqMLcnAKeYn+1YikUttO1+3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HNCbHoX1pj7S4PRq7b8EpYWEPStV2+ubpzCdutfrj1K1Blm18n4zmxHYpwnLkuoFjUj470CgN1WtVQ8bQbTzTq89dOH9KDwFLFXPcXvAL9Fn9clcsllTXdgyKpmCoVRbmnY3T8683oi0t98YOsFLkteFpFy7g3aWSeJlX0yiKd86MejJI6U2v/yog8KJLfQ4o8JN1tMSzfeGTUBZ2FI9cGDRtuY6VxYyoYDgZcGvxv0ua/YwPuLi7v9St8YDKwMhucdd3Zcn2x+cxBsFA3l98WE8hXAGz2zGZR1U4QKsnNNzcalYZC73IrmseowxSQInhKAHMy9QWC+5fKHYfXDi2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uzCl32cH; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uzCl32cH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDrK530yFz2xSG
	for <linux-aspeed@lists.ozlabs.org>; Tue, 12 May 2026 06:04:09 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7B07960121
	for <linux-aspeed@lists.ozlabs.org>; Mon, 11 May 2026 20:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32068C2BCFB
	for <linux-aspeed@lists.ozlabs.org>; Mon, 11 May 2026 20:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778529846;
	bh=odtlCf4rIw0DAK3X4l8eqMLcnAKeYn+1YikUttO1+3g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uzCl32cHmsLYYMmy4oExJqEv8+Di9wjh49qyk9KHzEGnYFtXr8W7PJiyJnE0EVVHz
	 bT0F6XVNgJ+UcgiaWUL8qlL82z+ixmAAN7sjUUe88/W2i3uPs7Pngw+oj3/aLmqGxI
	 TMM6s6yoayzX8p+OXRNa9m/Ruq4eP00cnT+/Uhg6UWtc1DXgo1LyF5qGxLeUz0Ydwm
	 v57sQJs2UUFbwOdx9+NWFiv1/eR6spbuNXCbPUXxX9uQABg7+Ku/bL7u/0FkjfLYaA
	 ikHf55Pi/jAekAJZ8vyV/sXmOtSzoCH1wPAhFc/+6W2eNWsvellSmzZdCZKbdmLZNw
	 fBhgHT23UcBdA==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a8721851e2so5137770e87.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 11 May 2026 13:04:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8mx51pLuVmN7iGIqg/h4zi7til8efF+OI3liT9iK8lMAxL5Eb8jqNRP5NxQ2+iZ2HGpKeradrcmx/ZGW0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxLicZZKmBz7W4YzU2kFIY6URM4vzAtGA+J/t9EtQshsTRJf/xt
	7jKEvFfiXKxO+XRZk29UuVJa0Fy/SlleqcOqYxzA5cnmTrDyWPwDek5ad6gr3uofdCMwdfYRgEH
	BUp0eiKcDJvR4QfVPX56oJBlYU3/euAg=
X-Received: by 2002:a05:6512:1053:b0:5a8:6ca1:425c with SMTP id
 2adb3069b0e04-5a8e31f2461mr6054e87.36.1778529844902; Mon, 11 May 2026
 13:04:04 -0700 (PDT)
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
References: <20260506-upstream_pinctrl-v9-0-0636e22343ad@aspeedtech.com> <20260506-upstream_pinctrl-v9-1-0636e22343ad@aspeedtech.com>
In-Reply-To: <20260506-upstream_pinctrl-v9-1-0636e22343ad@aspeedtech.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 11 May 2026 22:03:52 +0200
X-Gmail-Original-Message-ID: <CAD++jLmMNFJ699OnHmddO+xRWgLCVj5BoSzOsooM3U3QuSOdrg@mail.gmail.com>
X-Gm-Features: AVHnY4IeBgb1SfMX7B73p8P9k7dubKkRwUr_eFji7cM7YkQeG5UUDe_o_9aehh8
Message-ID: <CAD++jLmMNFJ699OnHmddO+xRWgLCVj5BoSzOsooM3U3QuSOdrg@mail.gmail.com>
Subject: Re: [PATCH v9 1/3] dt-bindings: pinctrl: Add aspeed,ast2700-soc0-pinctrl
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Bartosz Golaszewski <brgl@kernel.org>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 10:12=E2=80=AFAM Billy Tsai <billy_tsai@aspeedtech.c=
om> wrote:

> Add a device tree binding for the pin controller found in the
> ASPEED AST2700 SoC0.
>
> The controller manages various peripheral functions such as eMMC, USB,
> VGA DDC, JTAG, and PCIe root complex signals.
>
> Describe the AST2700 SoC0 pin controller using standard pin multiplexing
> and configuration properties.
>
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

Patch applied!

Yours,
Linus Walleij

