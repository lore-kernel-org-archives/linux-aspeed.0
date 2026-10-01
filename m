Return-Path: <linux-aspeed+bounces-5105-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF19CA5FD4
	for <linux-aspeed@archiver.kernel.org>; Fri,  2 Oct 2026 05:39:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwyJw59dQz2yDs;
	Fri, 02 Oct 2026 15:39:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790839119;
	cv=none; b=LU2SHmonWU2A1DLijQYQvPb8rOkOBo+biJpBGDd7zhulpTxWgnvS53n2KPc4tEBkS188oWxaxuaAEIqnqpu/W0GACQFBNA+SxEEXTlYWYJHy5qA2jOyW7aAkSJfHC75614zbVOGZn0A2TnhcHDuy9wCQJjm4xPL9QYmB7tN0UOp0+auvZIl7FcNZfxcVg62ODWFrDYIpjvHL9GWXuir0ifyIJQjaRzvsZ7AYHXz8Vf3dfcfNzr3AXwIK3jMEWlZhKiwm8XLFtWRNtHpAg5iS9p+L0yB3Sz3E1SnbI2xJCfi3GG+6igO/27Jc4tij8hPVfOKx0zvVsPL9uGm+G+J/oA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790839119; c=relaxed/relaxed;
	bh=y+YWX6gQgZo8y4R4a+T3medFXiXOGcAYD9z8MlqiloU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hzXBku1hlN1kccRv5Ei+/Qq5s/jvm5m+qbTHR5S/sqLexFWkWJHQjlMK++xow4AvEoiLE4l9m/XYjPYbN7dPHR6aJSOVKjIEmsk3FNIlWKbI4An8J4gdWrzzYqhX5cCk7JBqCp5XA82ztPp2K1k986B5k4cuvJBlEYzbKkabAC5Ja1jzXh4BPNKd0OZdXCBA/4JNmvVGlFMpn92VvV22HCsGeSx84xFD9KPcOaRBph4mUg3CvEC7FGQPWUSAcDwhxTKQrP5wgnlSd+mCpg0Z2XFelFJctEaRqcVb60lCE/mW27qXtncCZuwdhZXpvkq1XhRxZO7bsJVZJ9rUB4sxrA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OlbH+J5L; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com; envelope-from=joshua.crofts1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OlbH+J5L;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com; envelope-from=joshua.crofts1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com [IPv6:2a00:1450:4864:31::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwNYn0LZMz2y2Z
	for <linux-aspeed@lists.ozlabs.org>; Thu, 01 Oct 2026 17:18:35 +1000 (AEST)
Received: by mail-wm2-x10.google.com with SMTP id 5b1f17b1804b1-4a006bb267eso22294125e9.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 01 Oct 2026 00:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790839107; x=1791443907; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y+YWX6gQgZo8y4R4a+T3medFXiXOGcAYD9z8MlqiloU=;
        b=OlbH+J5LxaaaRO7dFExaUej3y4pLPlQPNZ71O2grHety4p+ysNXaLuO+aJQQAojPca
         3OkIm6Eop18eKgGb+tFaSzicYUW0dg+x309TIFfsyzSqu1VpiW9cwHhITAczCIijTqnk
         DIJCFq8TND9Ld7WKCwcngD8KmzIsPCDMp55JBkyjqqPRxMoz8vsF5DpU3Ytxqm+m3KMV
         boAPKysK/kPzrMeJwc9NPIGSaHZC7EIE6EZW9J1/qy0Z7KnuGdyyfuOIb7Lu1WSFev82
         nlmqqCpTw3MbGJdSmS22uF5b5xrggDWpsNwj0jfzj4Ryjtt+WYqcYIEjOq9dVtsh3Pe6
         UEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790839107; x=1791443907;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y+YWX6gQgZo8y4R4a+T3medFXiXOGcAYD9z8MlqiloU=;
        b=hTjRWV8Fbny0lD8DyveiSO53TGVCdzJM+YZzpwZGMpXR4Ld57qjFFzD1D21tkzoymC
         9aQf4ebLHxboNS0ocZm9tjo9JAqYDlYh+2RvmNfoj8j2AvQJGcnKFnp2JDDARp9bw0vp
         blM/XpVoI15fRvJiJHfPdN34/Xeypeyqg16KZ4CvzdoZpHgjwYHWA/m8xtwDdBmJZkaT
         wWdOMZ/kEoyUogb++Q9V31CLOpEKEY8Mu0qp6BgS0XKCdQR/SrvPi4Bll3vXu95Z7hBk
         cNgjvJNGFahlvy/+iDW/bQeyfm48Fe79D4koQ2JgSmWVP7IgG+vUM1nTYFerjDIb132w
         PlhQ==
X-Forwarded-Encrypted: i=1; AKwUvByhpQRjWqRrk363x8bleHn1Ef7G/i2wqCYKy5n+bSc+aMRuMpZNIXDk/hdUwA37yWQOJ0HV1nu/Hg33tSs=@lists.ozlabs.org
X-Gm-Message-State: AFuF++n/g1volX8XsLSveoEAZOnDjn6zBkztDOE4LgedPvBLL4yUW0qp
	gHb+ZjNMRI4HPZHHODSBmHMXu1rAob9VMECdbXt63+lTBUpEoMiQve5f
X-Gm-Gg: AYBFou2S5fZgnNL5/TQrliyttfznq/41jlnvDXF1wGcFFE8A1a9eLTaJltPgmv+XRdx
	YjbwvF043BYokvAxSqjJYCQnQjOGp3WBn+gwIIqFN/FmO2Q6iCGe4eTAB7hpSuG55nyJW5NkXri
	PufshEWVB9aUFPucIbyiVO0vgosR4NCXwLYhu506pcigLCqQ9I8Y+wMm3r2POrrYcdqn50zzkx6
	1Z6r0L8LBtTt9kHAZa5l6npwrejvWy7wk0o1AFuPL8gajhTL7i0A1ODO2C/Pcyxim5/YIvQIBUM
	Q/3i7V6YPDWjV1l5g5S7bm11QduyJF/cW3zFGFJrjOllgHWFqRTz7B9i7l159elmQRtUF+cifZq
	ojYZfHGXlfEYkfOMZCCmLAEgS4TgPfkjY/rgVp7jsGWnoxFXG+70ycswdx3jXHGZXOkhMbUB9vB
	hlUK4h525TpObfMA+HHPCaaUOodxv8M6n5IRYt3frveDFScfNxRbCPcqwsNW9oeTf3GNyZs7+f3
	HcDdRe66wR3RhWj3xPgzBQKtP+CL4wP/VAcPI44Z1reeF5+Jitgl73McqVxs6rfuBzQxN087qJB
	FbOFiCpBOftIFey2o3w3XFMfPqCoIioHGvpBMSCURTQ+d+PlU/QeS0uFxCwvHzfNqb84HbW275S
	IvyU2XBnsI87RmVc7YSrl9nloFvne59Ky066CqLTVPYRzxsuRU5vwMRLwMyodCjyoEdVbYk+Cel
	urreFB
X-Received: by 2002:a05:600c:c162:b0:49e:7a00:b9a5 with SMTP id 5b1f17b1804b1-4a01ad907efmr63944185e9.4.1790839106608;
        Thu, 01 Oct 2026 00:18:26 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a023ecef86sm8562995e9.3.2026.10.01.00.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 00:18:26 -0700 (PDT)
Date: Thu, 1 Oct 2026 09:18:27 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Joel Stanley" <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, "Ryan Chen" <ryan_chen@aspeedtech.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] iio: adc: aspeed: Fix SCU lookup for multi-SCU
 AST2700
Message-ID: <20261001091827.00001410@gmail.com>
In-Reply-To: <20261001-ast27xx-adc-upstream-v1-0-5ace57533418@aspeedtech.com>
References: <20261001-ast27xx-adc-upstream-v1-0-5ace57533418@aspeedtech.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Oct 2026 11:28:43 +0800
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> The ADC's reference-voltage trimming data lives in a SCU register. The
> driver has always located that SCU with a global, name-based
> device-tree search, which works as long as a platform only has a
> single node named "syscon". AST2700 splits its SCU into two
> instances, syscon0 and syscon1, that share that same node name and
> differ only by label and unit address, so the lookup always resolves
> to syscon0 even when the ADC's trimming data lives in syscon1.
> 
> This series adds an explicit "syscon" phandle property so multi-SCU
> platforms can point the ADC at the right SCU, keeps the existing
> global lookup as a fallback for single-SCU platforms and already
> deployed device trees, and wires the new property up on AST2700.
> 
> Patch summary:
> 1. dt-bindings: iio: adc: Add syscon property for multi-SCU SoCs
> 2. iio: adc: aspeed: Use syscon phandle for trimming data when available
> 3. arm64: dts: aspeed: Add syscon phandle to AST2700 ADC nodes
> 
> Assisted-by: Claude:claude-sonnet-5

All Assisted-by tags in your series should be changed to "Assisted-by: LLM"

> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
> Billy Tsai (3):
>       dt-bindings: iio: adc: Add syscon property for multi-SCU SoCs
>       iio: adc: aspeed: Use syscon phandle for trimming data when available
>       arm64: dts: aspeed: Add syscon phandle to AST2700 ADC nodes
> 
>  .../bindings/iio/adc/aspeed,ast2600-adc.yaml       | 28 ++++++++++++++++++++++
>  arch/arm64/boot/dts/aspeed/aspeed-g7-soc1.dtsi     |  2 ++
>  drivers/iio/adc/aspeed_adc.c                       | 20 +++++++++++-----
>  3 files changed, 44 insertions(+), 6 deletions(-)
> ---
> base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
> change-id: 20261001-ast27xx-adc-upstream-34b3d9e8e27b
> 
> Best regards,



-- 
Kind regards,
Joshua Crofts

