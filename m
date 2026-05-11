Return-Path: <linux-aspeed+bounces-4013-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17104CD37BE
	for <linux-aspeed@archiver.kernel.org>; Mon, 11 May 2026 23:51:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDxMC1H7wz2yGf;
	Tue, 12 May 2026 09:51:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778529906;
	cv=none; b=jVn9HHZS8SvQfX3QoKxvr3kfKqzRYvp23loCyCKTsmHPUYNukctujeNyuqYuP0wMZkUIk2PSknpCWoczQwzfWxiQRk3JBA4LWfKEL2ysN+wBTTa+cjHh0tIpO0mXcN0TvqaMjfF0aapeaXX9jBT2lDLBmk18EodhNfKKq6+Njnlgm+XDkgL+f7GARRaF2cQHl036dcHTzfFaK6trv7FnYO7mSc9PuTuc/8wpR9fF2ofg8gC9QV5v4jkKPhETgo6nyoVbBhvdhvkbMqxmY50IwPfASYBM2Ge62Gk9/AXlUIBMol01sOxF/DdoI0wlPPHCuFzHdeOZF+I7WeY7vY/z4A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778529906; c=relaxed/relaxed;
	bh=vifrlnSm2hwvPtyavVza6RSqJuHvkSa7YEqnDg6i8hI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=agSYvH/u07/FiIRdJPySn/ZNeI5+ph5QTM/TRoSIcKVqy65GlOsSNdwu082O9l6n003y11+nGZZFDCobGfS3Q/hKHKrWMhiudzhXa+iUbQkFV1T37s4Sf3kxmFNyI9UUf74KqQg152FqEButGcuFcSKINciYTo0vmqvqpRq2fQEDzrrcZHSrpJXxnNYaEehkeqkaNsRFoMXqWEj6w6V0qOKcSD5TDjOLEFpda8mw5HhCCZZqA1q7bplYS1nfgzWcdxIpvwhA9KFLPgohQTvD9E0c6rp4DKc0ItR5aU/1BbU54akT5jC/HbxQvl5SrT4Y+HMNzNmEaL/l3TUrQ+zlRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Nt3Ua8ch; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Nt3Ua8ch;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=linusw@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDrL96bw0z2xQB
	for <linux-aspeed@lists.ozlabs.org>; Tue, 12 May 2026 06:05:05 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 65FF944419
	for <linux-aspeed@lists.ozlabs.org>; Mon, 11 May 2026 20:05:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4826CC2BCFB
	for <linux-aspeed@lists.ozlabs.org>; Mon, 11 May 2026 20:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778529904;
	bh=vifrlnSm2hwvPtyavVza6RSqJuHvkSa7YEqnDg6i8hI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Nt3Ua8chsChWviUtf3nByVpkkunRyWEk+lT4AotDC9Y05Z3PHcf4uvVkTAmdFJuDv
	 s0KcDVTcLlF6KKv723rdN5giJIJLedqFepwwUSt9yplhxFPiNWsVhOtEd0OUoygCsC
	 9A+yD2JsJ2gqpGysBftNJ27epa4O4oyINB0D6HGTZ/355ObItcJrciIx4zF8LAJRBd
	 H1PPFlmgr/uTHGxyIpf6cX+sDcQhcPLsYt6YhCoOQwAigAocoMdMXzoCO75pyc8V5u
	 Iz5LD9vcUWvh8HzOLBEuXOZIw23m8RPWXzpxADikZnwyd4o5qsM2hf3wIENp7X0URd
	 jMXZsTsI0YMpg==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-393d07e8938so44290221fa.2
        for <linux-aspeed@lists.ozlabs.org>; Mon, 11 May 2026 13:05:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ84wnaWKFcEbgQrWnupGKbzQQTomgwJNRMZnar0ED+qNjXwXBFTC/P0GnLBbkYb5baUSmVj9QNulzAr3BY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx2GFbMgWn8VEMNoAMjfAe3pGo5BmkPQRNDI8PLw1EwncfkFNM5
	BgCB8eRictcLEo5ZM95b3+NBzufHdALt5kwKiGt9iae2Ztm4akWF5jp8zY6Zg2BlITOL+34QwIX
	gjWDBtMjkAJfAVd+lnKTcGLyB6ytPOYE=
X-Received: by 2002:a05:6512:3b21:b0:5a8:6793:e701 with SMTP id
 2adb3069b0e04-5a887ce64c1mr7724276e87.33.1778529903006; Mon, 11 May 2026
 13:05:03 -0700 (PDT)
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
References: <20260506-upstream_pinctrl-v9-0-0636e22343ad@aspeedtech.com> <20260506-upstream_pinctrl-v9-2-0636e22343ad@aspeedtech.com>
In-Reply-To: <20260506-upstream_pinctrl-v9-2-0636e22343ad@aspeedtech.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 11 May 2026 22:04:50 +0200
X-Gmail-Original-Message-ID: <CAD++jL=3p9BvDgaot3=emM4Zn5jU-ZAUKtB4UwT1HzDiyzKq4Q@mail.gmail.com>
X-Gm-Features: AVHnY4JtxK2F1JLguIEb3zBOcAZHVynLHNdMopJnlqbcSYRx0cEplr-yGb19hdA
Message-ID: <CAD++jL=3p9BvDgaot3=emM4Zn5jU-ZAUKtB4UwT1HzDiyzKq4Q@mail.gmail.com>
Subject: Re: [PATCH v9 2/3] dt-bindings: mfd: aspeed,ast2x00-scu: Describe
 AST2700 SCU0
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

On Wed, May 6, 2026 at 10:07=E2=80=AFAM Billy Tsai <billy_tsai@aspeedtech.c=
om> wrote:

> AST2700 consists of two interconnected SoC instances, each with its own
> System Control Unit (SCU). The SCU0 provides pin control, interrupt
> controllers, clocks, resets, and address-space mappings for the
> Secondary and Tertiary Service Processors (SSP and TSP).
>
> Describe the SSP/TSP address mappings using the standard
> memory-region and memory-region-names properties.
>
> Disallow legacy child nodes that are not present on AST2700, including
> p2a-control and smp-memram. The latter is unnecessary as software can
> access the scratch registers via the SCU syscon.
>
> Also allow the AST2700 SoC0 pin controller to be described as a child
> node of the SCU0, and add an example illustrating the SCU0 layout,
> including reserved-memory, interrupt controllers, and pinctrl.
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

This is an MFD patch in the middle of a pinctrl series, I think Lee
should apply this.
FWIW:
Acked-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

