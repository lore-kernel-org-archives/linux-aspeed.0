Return-Path: <linux-aspeed+bounces-3259-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12950D1489F
	for <linux-aspeed@archiver.kernel.org>; Thu,  8 Jan 2026 05:48:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dmv8x74ldz2yG3;
	Thu, 08 Jan 2026 16:48:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767851329;
	cv=none; b=CuAxcU50VAETjdUjsySRtvKQ9/htF+daJKwRuSh/ZDz6GLlFH3cIJTYdDV00traL+kac1/Mqo7UyfzSeovrcbWcZkgoYQcbpM8gieldQGPOB4pptpDFsFxs0ed/wH1CuaKD7UszZMvNB5adbrL7su2sS7/FDmkNAIjjQFFlO/YvLmYnw0SYmIIpTQli9X5JYETBO3U2N7dpHPwJnb7JHz+Rff17jn6PnKTdyXnwG4+PPoVjbn+K8Bve6l7Ov6eJKQloRmC4WJrgPi8O5P+vG/3JRWCVKxCUgqGwMqF+vHrWyvWCupP4KVY91q6bq9PEcx1f3LYeMdJuKnWNeU7pUBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767851329; c=relaxed/relaxed;
	bh=6HTw58LbbRBmk04pgi7jyjScM20PkaliJVCu22kzXsE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m3ZXnhwoPnJ8gLNzA5lNlNnma8MG5DWz3GpnJrPuZXyYj1mveOkV5RhK/PaBtmDMhoOiOvNeyh5c1yppuomzSBQbZhkrvPPw7Q1t37inUWC0J+CM2EfW1EAiqIguiT9w7So2i/LP+pgS4MVjha2tcW793YMHUhNVMMBGjyLUOg4NztKQGuJ97pWzXQbhgtzpQr8zcdb6fUdDqBqw1tJBS9jyCwkUOgOBWXAKKwEDa6E/4EKw8jOlZf4RthaJ7TglIyP4gynl6AAVL5tX9I5s52ohFxysQDMT7n+Nz+WMgGUTS1htYfJt8Jd2oURdy9vWxseQAA8g0R9POzGDD2TXwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=IsBBA8QF; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=IsBBA8QF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dmv8x1VH0z2yF1
	for <linux-aspeed@lists.ozlabs.org>; Thu, 08 Jan 2026 16:48:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1767851327;
	bh=6HTw58LbbRBmk04pgi7jyjScM20PkaliJVCu22kzXsE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IsBBA8QFvLxQMVHzF30vbYakhUQgQIaJSTm+nogeqVZl8imjICmyV7Viw/C1K8rvk
	 q0iIVLictrI0z3Oj+xYAHAsgJeqm+rZk53fWWjD1TFwKfxij7eBJgXuTR05FsoH8FQ
	 w0xQSBp5+ILvlonutMkNruM9LFu+3UsrGysq5tlCR4jI7Yhz3RhdFqvpeUkIg5s84T
	 7dEI4YnpbIy9s2aMdefrmwzVXOqw6/lHYMAZzYFfEmR0oiFXTwnDj/XXTsrfygF9gh
	 ugISVJF+eZ7a/MCxwZ6WMeaBUCBudSoOFsLPEnro+N4KSC5oEJZHPt4qbvTyke8s8l
	 0d/eYoRL3+I4w==
Received: from [192.168.68.115] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 68BAF7C834;
	Thu,  8 Jan 2026 13:48:46 +0800 (AWST)
Message-ID: <61e23c80136a6fb5bac79887f24399fd0686157f.camel@codeconstruct.com.au>
Subject: Re: [PATCH v6 1/2] dt-bindings: arm: aspeed: add ASRock Rack
 ALTRAD8 board
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Tan Siewert <tan.siewert@hetzner.com>, Krzysztof Kozlowski
 <krzk@kernel.org>,  Rebecca Cran <rebecca@bsdio.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 devicetree@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, 	linux-kernel@vger.kernel.org
Cc: Billy Tsai <billy_tsai@aspeedtech.com>, Conor Dooley
	 <conor.dooley@microchip.com>
Date: Thu, 08 Jan 2026 16:18:45 +1030
In-Reply-To: <b10a233e-02c3-4b02-8f11-098f6fb8197c@hetzner.com>
References: <20251218161816.38155-1-rebecca@bsdio.com>
	 <20251218161816.38155-2-rebecca@bsdio.com>
	 <5aa36c56-798a-40cc-b0b8-be3f7c92136f@kernel.org>
	 <b10a233e-02c3-4b02-8f11-098f6fb8197c@hetzner.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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

On Thu, 2025-12-18 at 17:44 +0100, Tan Siewert wrote:
> On 18.12.25 17:21, Krzysztof Kozlowski wrote:
> > On 18/12/2025 17:18, Rebecca Cran wrote:
> > > Document ASRock Rack ALTRAD8 (ALTRAD8UD-1L2T and ALTRAD8UD2-1L2Q)
> > > compatibles.
> > >=20
> > > Signed-off-by: Rebecca Cran <rebecca@bsdio.com>
> > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > Tested-by: Tan Siewert <tan.siewert@hetzner.com>
> >=20
> > How was the binding tested?
>=20
> My bad for sending the wrong trailing header in v4. Tested-by should've=
=20
> been only on the dts instead of the dt-bindings+dts.

I've dropped your Tested-by tag from the binding patch while applying
the series.

Cheers,

Andrew

