Return-Path: <linux-aspeed+bounces-3821-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36BC410F9308
	for <linux-aspeed@archiver.kernel.org>; Tue, 31 Mar 2026 23:16:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flkXN5YXxz2yVT;
	Wed, 01 Apr 2026 10:16:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774941449;
	cv=none; b=FmbONbuqaXynAri4cD2RijHcLiy8qZjbcAstazW12d7Ac9jEu2DEoougAMAufCPukwFT5fdouWtvkp+/eiAnTqlD2J2BIqK4wVr9i43vISvLmrW6WQcv0sZYLKOkKxq3HP1HTTva8OdMgm5N2Xm+pvIq3+k9Qz5yxeomYGWR60EZDqNj6rodHvajFHaDtPYC/ZbTSKJb5DXSzi/GT2PDrVgUop8qEEZ5x1xYGJm6wi86kGByfF0T0FyDpty/KgimLpIsKqq1Ew8jqphboDHMLdD0sl2BjZTOiR7fSwwLwre1Vq4oOkV1QUJaXizmwr4WDZf5GLnHA0juKakrwwJtRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774941449; c=relaxed/relaxed;
	bh=qkbimkF7HoXE/Jf1vzsZkAfNbNEc1Y65ZFXjx0QhOzM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ILIb7EZy01+8bXdD9MM4qcitFyhpnZy416u1JZ+832+vXuhQTjkstK4aoR1IEGDKWr1go5U7LoKVFLenxIFdJpOcpP/23aZKwsxYnQp7hkqcS1H9Dj00QNvb0pqaPfXrFvekSAuc+r0Fu2+D5lGAwsZ9khv1s5jKgUJ7HzJmNSynMzTdZSeMGLr5WVfwKHqt1g0QKfkne+3u22JHaW5c5z84iadGASz4a5lHbCWqeepkMWsJ3TQ3bDlI3ciEBqHAmpz+YVF3Rlka0PI105+9NqicRwp79nO+mS0W1KShVKZuXOSOq0C3HUIwwHiDHY9qbr5OciTIDm769TG9voFRWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=NISHE6MX; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=jk@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=NISHE6MX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=jk@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flKFP0Xfcz2ybQ;
	Tue, 31 Mar 2026 18:17:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1774941448;
	bh=qkbimkF7HoXE/Jf1vzsZkAfNbNEc1Y65ZFXjx0QhOzM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NISHE6MXoK8tfRV9S8pt+leeucFZ70wxemyKXKi9pRF+a6WzkAGIquNAVMhKf2cnG
	 YN5MOUGglqn76zKkmoH/lrTvgp8y8TAQJXrZIOd3X/VQwwzBZWwBnHnDKY54P56KGx
	 XcB6sQ8EvgaaZQZkMHg5IsZzaH4wlCvxsA87d9poVrwV3A8tkMtbM4j6rgTVkkVLdi
	 TNjJawi4Hvre/DNptnvZk6d650ymJ9y+B5x7pjivv+j2W/GEJ6aEu2cemVW7T2VGaX
	 WTpk7L2R3bDnuaKMlcpG8Ff9O4/81GyOFLTUht1LMBFiTKMMjYE7AOQxcDFQzKDG2D
	 8CH2GwMt2fcoA==
Received: from [192.168.72.167] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 3163E6002E;
	Tue, 31 Mar 2026 15:17:28 +0800 (AWST)
Message-ID: <72517fcf99a7453841ee75243dc54e735c10238f.camel@codeconstruct.com.au>
Subject: Re: [PATCH v28 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs and enable-dma properties
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Ryan Chen <ryan_chen@aspeedtech.com>, Krzysztof Kozlowski
 <krzk@kernel.org>
Cc: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
  Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
 <linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "openbmc@lists.ozlabs.org"
 <openbmc@lists.ozlabs.org>
Date: Tue, 31 Mar 2026 15:17:28 +0800
In-Reply-To: <TY2PPF5CB9A1BE6EA5BABE55EB8A7003D22F253A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260330-upstream_i2c-v28-0-17bdae39c5cb@aspeedtech.com>
	 <20260330-upstream_i2c-v28-2-17bdae39c5cb@aspeedtech.com>
	 <20260331-fanatic-certain-bustard-fb13bc@quoll>
	 <TY2PPF5CB9A1BE6F267C60EEC34B6A75400F253A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
	 <09cbc12bea5707f794e139ea1bfafac82c2d2c12.camel@codeconstruct.com.au>
	 <TY2PPF5CB9A1BE6EA5BABE55EB8A7003D22F253A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2+deb12u1 
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

Hi Ryan,

> > Sounds reasonable, but before you do so, how are you planning to manage=
 the
> > allocation of DMA channels across multiple i2c peripherals?
> >=20
> The AST2600 I2C hardware has only one can use DMA at a time.
> To avoid the complexity of managing DMA channel contention,
> I plan to use buffer mode by default for all controllers, which still pro=
vides
> better performance than byte mode without requiring DMA channel allocatio=
n.

OK, but your wording there ("by default") implies that DMA is still
selectable for one controller peripheral. In which case: you still have
the problem of managing DMA channel contention, but now it's at runtime
instead.

So my question still stands: how are you planning to enforce that DMA is
only enabled for one controller?

Or are you planning to disable I2C DMA entirely on AST2600?

Cheers,


Jeremy

