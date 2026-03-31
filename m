Return-Path: <linux-aspeed+bounces-3825-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9AFA10F930F
	for <linux-aspeed@archiver.kernel.org>; Tue, 31 Mar 2026 23:26:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flklh5fflz2yYY;
	Wed, 01 Apr 2026 10:26:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774940448;
	cv=none; b=aT+x9z/UJAiNZPfjaPR4TDDrHyDYMOlilNFRE4kdmhJ7l6erR1IBbA4YXHOG3Og+fsRe001aX8DnBhFsWEWASrAdsw43/LW4RdC5aacsfqaVwFmObzUT8HPY7+Wh9KZnxDGYB6sk5IeU4oVPkgpFtkXlZ9Gavok+EYDq/bC+2woN53VgKLk0zgK9oJ2mgfsz6wVdoN/UOclO9iGG+8cDzdntyAN8pxq4BnLx57bFl7LEIM6Cgbv6/kZMjAmSHZnxvwUxHjIn0h4MsewzhxuvW6dRwO4lafcEIGO/rhy0AwXRt1BELIM7b7w3NBFkKvFI4JNwhbLhgXZ/OP/JTCS6aw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774940448; c=relaxed/relaxed;
	bh=RTmsuImCn3CtzefM7fomAbHA5I/f+UtO2YDEaei1OTI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HaJBWcUh0+b3e//In0Rk8Knjs3yOA4H4GxPZAwkqY8unax0nh/jbsJuqfwDfMDAsBOEkI6TgdKjHQhPP+jtPRgjMhm4Pzq8asbHRxUr2+cW6lT9elvLr5YMnviBbArO3QTXA6fgx4McnOK7SQefhCnhvbpVKEROG37p2JVkitAcIUk6oobNhRNUFqY1FzreEWz75tv8rb+sW4ElxEFs/cwYHbpBCZ0YKwwNixY5MVyc5NuqG7M0cx3X3LHpNID7wsg82tSoQF+5xNnx13CGf5CSTOpSamhYcofm+w6ONtrFpX/a7iJ3X0bW2aORHEBZ+7s88gG2ilQbLqGLOyNyJGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=QteUuSwe; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=jk@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=QteUuSwe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=jk@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flJt72pTBz2xSb;
	Tue, 31 Mar 2026 18:00:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1774940445;
	bh=RTmsuImCn3CtzefM7fomAbHA5I/f+UtO2YDEaei1OTI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QteUuSwewXeKt35dLgpxQsZXo5XcyHBW/48b/IrIeozShAmj9VPjbHWDFcv/7wrMN
	 EbUx9muoJkfo62g8yHdbEXleSmEM7DvOFC9FI9c4YM4maKbG5CbivJrN7I9CaVCD/F
	 od6I5UEuh44ELgSAxSMKT4cPTf1mkGetpkyAsp+5QMH5pkKIaJLJD3kudVjLBpwp4y
	 92WKhncfZ73BaknEFEK/ojuJhc5+qr9ztjoY/aKvdSk1ekZm2uqGCMb7taHI/WOwnj
	 KNmh+i7o7sjAYUZDtqWcP1Wg2GeKoZkRQZCiCI1Qh/5TjAbI/27q+jqbGF9E06udHO
	 2daLsjmnVJuqw==
Received: from [192.168.72.167] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5B5616002E;
	Tue, 31 Mar 2026 15:00:43 +0800 (AWST)
Message-ID: <09cbc12bea5707f794e139ea1bfafac82c2d2c12.camel@codeconstruct.com.au>
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
Date: Tue, 31 Mar 2026 15:00:43 +0800
In-Reply-To: <TY2PPF5CB9A1BE6F267C60EEC34B6A75400F253A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260330-upstream_i2c-v28-0-17bdae39c5cb@aspeedtech.com>
	 <20260330-upstream_i2c-v28-2-17bdae39c5cb@aspeedtech.com>
	 <20260331-fanatic-certain-bustard-fb13bc@quoll>
	 <TY2PPF5CB9A1BE6F267C60EEC34B6A75400F253A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
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

> All AST2600 I2C controller instances have DMA hardware.
> I will remove the aspeed,enable-dma property and instead expose sysfs
> attribute in driver to allow users to enable dma/buffer/byte.

Sounds reasonable, but before you do so, how are you planning to manage
the allocation of DMA channels across multiple i2c peripherals?

Cheers,


Jeremy

