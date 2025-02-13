Return-Path: <linux-aspeed+bounces-711-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CDAC0219D
	for <linux-aspeed@archiver.kernel.org>; Thu, 13 Feb 2025 11:30:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YttJw3Wz7z2yvk;
	Thu, 13 Feb 2025 22:30:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::12d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739446224;
	cv=none; b=LIZcxn1w5sb5jwd08X6oFPxuveqCoAWaXZp3Qhj5k7Kts0/XAwPTOfgwXdKHCU8joW+7CIqqJuMEU96IZWcW/qCOaMDRp8A3j6bMfLcHuaLFeuh92Kxm1DzBsdXazh4pSqfTQbKtztyQ90h3t1uK/U9JY0jiizpNmbv23wyHa1TXco0ROw8uR4GybNXv9Cm5yQ1sWnUROK5Ql9Xn0APjsl/cuEX73y+mPhI0hndj4CUzc+SLuCNRR6e+x/L63JApJ3bZwspKRQXddsQbFtiHmbAtj0DhXwgr+dIVQByqzoJnn+DhZmjH+eOZ/q3j6PUYD8L/5QwplfaYwcZvyCQtAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739446224; c=relaxed/relaxed;
	bh=7Z56Y83f+ojrrsd3GpgSgBFA2lIExVUESQWAv2+ulCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JWYhdNphLKPOVxsGkLI2MnMrusQRrgYgRgwW1QSGrND2PEqU87bLntKpAgR/89fDqEkEmaf156gFwJZutI8yAAq27afWX0TNeMTmnTNtpoTXBghZb3JsUMT6xbJ6wCckdVTMy5i0mua3NwFosuQfgDt69uTpu8QAMkHj/RL9iqNqL20alZj44F/Y2LfQmYCrOg2euBuKYCuNzCBjFWL5KOdMrR2gja9WFamWPsc1e37IWZQ5j/EA/7N1jwUGR9HWHSIGFfNPAfnHS2gPrCgFymcroiUoFNtyWWrUlV3TiJltWhCiledRYWk1IfcXm3Z2WMuASseK2h1Gn6cmnOWweQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=k0h5Bg9O; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::12d; helo=mail-lf1-x12d.google.com; envelope-from=linus.walleij@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=k0h5Bg9O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::12d; helo=mail-lf1-x12d.google.com; envelope-from=linus.walleij@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YttJv1Zskz2yVV
	for <linux-aspeed@lists.ozlabs.org>; Thu, 13 Feb 2025 22:30:22 +1100 (AEDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-5450cf3ef63so761191e87.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 13 Feb 2025 03:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739446218; x=1740051018; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Z56Y83f+ojrrsd3GpgSgBFA2lIExVUESQWAv2+ulCQ=;
        b=k0h5Bg9OphDBBmn4Ksi9oh4hsW2Vc7hLqACgMwxGtn+maPTk9ZLJ96dbbjcbr0v03D
         RTXRQaxaiEZvIlyGeafZ5cffQ1wYu7PhRP+726XB0Du50oMK/+Stw3NBgfXD7o8Zfbsc
         TNI/zKbvFsyk5qjMlmQSQVvJgfAC7SAPsL4yw2Im9EtBmq+QgK7fCwQKwUApMrzr5H7e
         64MIi2jNqlGT6XSyT9mOIEg9QO+KiC0xmCbpm6Toivz77sMmk5iNSR6aXWtN/AhbsetZ
         XKC9qAlXm/QwqDElfXtsMacsrdxRRHCJmZbxUMtv2Wwd5g9LBLYggJP8JySRaj3rnCXt
         hPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739446218; x=1740051018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Z56Y83f+ojrrsd3GpgSgBFA2lIExVUESQWAv2+ulCQ=;
        b=OCNH0lcbbtIYZZ5BPTo9FBbUUoHRfuvB04IJxWc/foehAYvu/xJJfd1yBZ3UWRoQm3
         G5Pg1zaZstQ0cEVVjOGr/3X5hUUPFbU7OHupbkzzbgsACIPvC01btTYoMxzTGAL2ahXl
         SaPxO5ctPQrWH3mVLJTl/h2aghyeeKt/zSw9MWl6JcVZ4mSJYMx2zb8XVeiDriORWFF2
         2TwQYdG6vORt4OwEhNTYBHbFecaZtKl/xsqJnBA4Jn3GtVuQTGHeYCCG/p0wZyRdExOo
         gRaWogDQGMVOxMNEKw9ycp9pDLjbaEBkXuvKBYlGbog70lcA4F/86+Ph5FdZFd8JDzSV
         9hlg==
X-Forwarded-Encrypted: i=1; AJvYcCWmYACrJWpNWnZS5rTmkPysBMWV70W9zjuW1vrsBKAdhgS8WmH6YNezioyOFZOzsyHi2G23vZFf1twrdJ0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywak3F9NOiH+hus1sHciY2wZlsEHxtyLxovq27H8Cz/yfn046yB
	TMZfGjqiFL67C6WQoWgX1UABFoC33k6sWDM3TTjfv000XhvO1ZHSDwof8QqaEIfIQsQEHgL5f43
	m63gGuhnlzqCBNhI4QxKIIYLI+diwPMuqeaIAHw==
X-Gm-Gg: ASbGnctFCfxqlGzbC4i0aIrUPly0Tq+0/mF93FW31MfGUR3q3kMc9u0pFTQ3C71G70U
	NDUfHYHSoeZ+CiZj0RJJ+gRXfoEW3IkSIJ9B6ciFaPIm17DxWTIrkNWWtTp9M8ZDnGtbRaoqS
X-Google-Smtp-Source: AGHT+IGtr+B7QUg7ovhczdnIrY54CJufjoazE+Gk4x6uF30Uby+ckGzBKyKIc+SyfPUrY3/AAaJl/Zu1tehVGQNXynI=
X-Received: by 2002:a05:6512:3447:b0:545:b40:6566 with SMTP id
 2adb3069b0e04-5451ddeb857mr591146e87.53.1739446217812; Thu, 13 Feb 2025
 03:30:17 -0800 (PST)
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
References: <20250203144422.269948-1-ninad@linux.ibm.com> <20250203144422.269948-3-ninad@linux.ibm.com>
In-Reply-To: <20250203144422.269948-3-ninad@linux.ibm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 13 Feb 2025 12:30:06 +0100
X-Gm-Features: AWEUYZklvT3HDVtZsVqTrXdrtQL7QNdhFrM_NmeZwuKBhmtHfAH-J4BH0prCplk
Message-ID: <CACRpkdZW9aNbrQk-zz4G0_W-HXrxgpWi_QzuLvActcWkh+U4Tw@mail.gmail.com>
Subject: Re: [PATCH v7 2/9] dt-bindings: gpio: ast2400-gpio: Add hogs parsing
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: brgl@bgdev.pl, minyard@acm.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org, 
	joel@jms.id.au, andrew@codeconstruct.com.au, devicetree@vger.kernel.org, 
	eajames@linux.ibm.com, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 3:44=E2=80=AFPM Ninad Palsule <ninad@linux.ibm.com> =
wrote:

> Allow parsing GPIO controller children nodes with GPIO hogs.
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

