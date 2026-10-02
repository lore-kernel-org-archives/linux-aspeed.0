Return-Path: <linux-aspeed+bounces-5119-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B84BECA5FE3
	for <linux-aspeed@archiver.kernel.org>; Sat,  3 Oct 2026 00:06:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxQtR6pSjz30Sx;
	Sat, 03 Oct 2026 10:06:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:30::e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790932561;
	cv=none; b=KFuhml9OXnIR4n8eSccUI/vKGe5lJPg4KBez11Y+GC1IitMY3+ijJy2sLU1lAtN4B0TIWjUtiak9xbTgvwiTFRFjLgD54s9tyzblEZHq6LaAMaAlaFxOxmIm7/riSs41spd1Qsg7fOeOD63mI33B7eIObzM6G4ZxT3fjJWBGz/TAevTZneTISkc+H4GHlLyUG7pySm8Zsb129XqTY/lxZR9VD+bPc3m8n0237dDfc6ONtMdYCNuNexVkFWjGy074AMfZqVVzoOxfXELaVUQc2PocKZQ0+UsWbe7xzwmFc94h95FrhImi0uhqKxEVPWpE2+Til8oPdRFFRX4tGplyQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790932561; c=relaxed/relaxed;
	bh=jRPrTGUlYlRMvJF+ftPXWXm2emGl+fkBUfXA6bf3Pvw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l8cyP01B0PBFyn1VXTRgZa3ey4hLS86rKbrwOh0U7vQG+ZWiS69kGBVc8fz+KUGpSJd7jkQoP/F0wB6YaO6HkkYNcZliFZzo9p7WedFXwaWwfkerodpapRsHoebLv3SgIy7LtStcmiJvqNGAqfepQSw7rjDVHk9kMrR52KjXBPDhy4F8G6DQohNcqujDIDydbaE53qhEDOGP5TzjcpkE45YxyZkg8yfVY7JwIFg/WAxdKJqD44N/trMEUTVST1Z1yBr8nRFqNrbgKrcMRIz9q5P8wmh8hdeNlgA6TB3yqtAALDJSx3giJzp6OBPjECiyJ8v4H1yaYBepCTE8wM12pQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dKme0yT7; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:30::e; helo=mail-wr2-x0e.google.com; envelope-from=joshua.crofts1@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dKme0yT7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:30::e; helo=mail-wr2-x0e.google.com; envelope-from=joshua.crofts1@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr2-x0e.google.com (mail-wr2-x0e.google.com [IPv6:2a00:1450:4864:30::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hx36m12LLz30Bd
	for <linux-aspeed@lists.ozlabs.org>; Fri, 02 Oct 2026 19:15:59 +1000 (AEST)
Received: by mail-wr2-x0e.google.com with SMTP id ffacd0b85a97d-48af929e59dso2722009f8f.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 02 Oct 2026 02:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790932556; x=1791537356; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jRPrTGUlYlRMvJF+ftPXWXm2emGl+fkBUfXA6bf3Pvw=;
        b=dKme0yT7ETV2s0tP+N+rAw6BBkFUUaBB71v18CzabH8KtzFq/VZOyFWrQrOCeVOSpv
         frWZfAr7ucnjLRAHOjFOHb+lq+ERCcOS6lZuAVpfEAf4nkmbkdfydbOhO+vXxjAtAyEN
         zneCnSpCGT0bkNkikTIgqfL95puEd/k0B1joWUjMZF+WqVWniyVkLEm2/H/NjSj27Lqu
         1/zVq5ZRm9tzSL2hwWPKn2EoL6MbZrY1oxDEBO93QYfpA7sLgOdrL+mUDvqgQRcN78KF
         /jMScwXv4IPN/fZ0kA0a4+4a3eaRyl1JnPP9YUL7WhmjgDUef/R0NizWu4jnBzLaQLiJ
         EiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790932556; x=1791537356;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jRPrTGUlYlRMvJF+ftPXWXm2emGl+fkBUfXA6bf3Pvw=;
        b=MTZe5oK8wG8CDpGwNzGJ3+LbOXPzTlBrBXVLXP/+9OMo+fvAPBO28eWC2xkGnoiawe
         NKs3u8enMn97VuAuYvCPKnxCuGyOV8VG6asFkG8IMD/OJIR1L0Wnt/+5y1O9rpA36POE
         xycEErgzrF5AwusvUYxFT6djSClBkqR6jsU4oO59LPaFQx3X7BMfcswj0zsx2VSH/xii
         /1td7QTVc/m6PbRjtQosOSig2VQpQ8KAnn1Mi6coQzVOHgZDqi4xMjjxd7qW7TnToZpH
         VoEIMT0us/03wYXji3pSd21GU1JZRS+UyjqqEZOM04x6q7ocHuHgsk0ua90XzselHaLF
         mr5w==
X-Forwarded-Encrypted: i=1; AKwUvBzJO47ajZnncyu1X3x3rrcQEbKeW+AVhz+zblcwEjLfHKhwjeiTkFFEubIZoLMSiY1zOUE+7Xbkx96O5nw=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIVXeGCP8qZHMAEV25feMLV0kjPkOSBZQYz6iU4YVGScJ7wdtFG
	8y5G6qzM0EQBsuF+2PoXEB8mRszh7cH5uAFfWF5bfcY8vEzlgXaYSeds
X-Gm-Gg: AYBFou3qPmp1ILw58mfMgvbclbmnqvEsQDUTDgk9YB1+Bn3gOQi1s/F0aYHJpQdcPQo
	4VR3VaXS3y6wg3foG4qeCJgIG8z95Th4TeAA6PpQOExoK0QMyGFvyTkyxcFuJn6e/W6vIUsBjZq
	CQM0v0bgwskz8MP14UOCKQV1cx8RfLVGyXsb6LICcZOLV2R6qX3m1ompgyCi/3d/YxC3macsRdh
	o4mruqtjKK5M+O6sMcajTmi5yaQf/23MVmtXLtza1toign/m+OEfNhzVm2mPTSeiWm5zpT0K1mo
	fzcEVC9G0rBD8gTTvFoX/Tv9NnQcRdUJWij4XQYgqtZZWlKI4TVpRTOR+4JFYQSuiMJrGA5JxWO
	TT+Mn3c56cimrhA4x31buI34md+gXNg3jby49aHrts14bEn900mprW4Kf2BzBrsEtUwUJWBhLc9
	rZu2x3qqHXc9jWWCjU2jPbBMuAozBwE/giDsmcYPoljOXitgQQFGWBK0rQSVuI8Oeme8CR0CGJA
	912LcWUCAJLFG3OOhzdVW10MdcKWTkmvocr1KT+/UxJxsB2tG13qsU27HIhCM5E7bT7A2BzycVC
	aA5KQXx6Rt04Oskv8gGJUaACjDfxZ5ucLdS+Jzdv0rvyqC9tPs1M4UMieaSHfN5ohAFob2msYt7
	0yCPBlf7hqb0PzWXedTvYfJfeAtH+UWglRPhdCq5bTBUqHulfADL240ey18UNFNk+YTgXwP9w9M
	XBmjBg
X-Received: by 2002:a05:6000:4809:b0:48a:fcec:2a29 with SMTP id ffacd0b85a97d-48b1273b029mr4027458f8f.20.1790932555893;
        Fri, 02 Oct 2026 02:15:55 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b382f89c3sm3966667f8f.34.2026.10.02.02.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 02:15:55 -0700 (PDT)
Date: Fri, 2 Oct 2026 11:15:52 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Billy Tsai <billy_tsai@aspeedtech.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
 <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Ryan Chen
 <ryan_chen@aspeedtech.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: adc: Add syscon property for
 multi-SCU SoCs
Message-ID: <20261002111552.000049d3@gmail.com>
In-Reply-To: <20261002-succinct-voracious-orangutan-fdac5e@quoll>
References: <20261001-ast27xx-adc-upstream-v2-0-2f9c15cc0064@aspeedtech.com>
	<20261001-ast27xx-adc-upstream-v2-1-2f9c15cc0064@aspeedtech.com>
	<20261002-succinct-voracious-orangutan-fdac5e@quoll>
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

On Fri, 2 Oct 2026 11:03:33 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On Thu, Oct 01, 2026 at 05:50:36PM +0800, Billy Tsai wrote:
> > The ADC's reference-voltage trimming data lives in a System Control
> > Unit (SCU) register. SoCs with a single SCU instance let the driver
> > locate it without any additional information, but SoCs such as AST2700
> > that expose more than one SCU node need an explicit phandle to
> > disambiguate which one holds the trimming data.
> > 
> > Add an "aspeed,trim-syscon" phandle property, and require it for the
> > AST2700 compatibles since they are the first multi-SCU SoCs supported
> > by this driver.
> > 
> > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> > Assisted-by: Claude:claude-sonnet-5  
> 
> Your SoB is the last one.
> 

And the Assisted-by should have just "LLM" instead of "Claude:claude-sonnet-5".

-- 
Kind regards,
Joshua Crofts

