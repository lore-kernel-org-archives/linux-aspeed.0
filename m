Return-Path: <linux-aspeed+bounces-4059-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92ACECD4F52
	for <linux-aspeed@archiver.kernel.org>; Mon, 18 May 2026 11:22:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJwPR6fpHz2xpn;
	Mon, 18 May 2026 21:22:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779103323;
	cv=none; b=a3fzRv3CghThEQF+PKposH/tmJcN0InVqGMFXF4lL5TaIAe4ELwKMQ97Nz3/8J0q7OIYki8u4GHxwWg0DOmuREHSeL4xpqYs2/dtfwENhpadMzP8DC4qB69Aj5vvT5x0DDUzeusyvvOXwKWIGyQGiIFwbqGEWaw4EkZ9V4knO0qHzorM1FbUzMM6JKkggBT6o15rtWKqV1SdXvxpvfconE+Pj39UT0zmpa22snXajppHA38hvZU37qN28jnTEO/Qcwyig691j2Ip8C8EnKSwL6VN2g1qhQOfCmNVMBBVaHrGVf7kpbPQ9eJ5GQ63/HxcOfbLkH4XzHrhkKSirD4k+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779103323; c=relaxed/relaxed;
	bh=w2n0G2+Jazj7BtyrJBZLOCheDF0NMvvyn9XJCPYHCN0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dZapZ3fLwdo8gNSHGhAH6mxILe/vq2N67lbU1qKdIsyKKFIPP5OWfMOykvR8xl3kUtWo4lRa+e0melI6X1pQaB2IRR53+dlh6INw+4CxJwaNez96Tcj0ndgVQekVEbhJOduAUoYLINJgDJNtjxHduMSWS6+EmRuB0ocDSPEfoBQPW3ROMXE2vqzL+LtcsV33P5q3qsKxCg0C9jpH89/U90FTXoOI33efoyrA/uCiH/Yt19bfsQusQKOJ+v1ArdObv1LR5woPcBL+8EcNqbZv5MRSYT0EPG34Y3CC93Rb4TX9Xe2QhhYMS+M2HZeuOppG4FkvMVi4M8NGstE8WA8nuw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=myqoaJPz; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=myqoaJPz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJwPR33Krz2xRw
	for <linux-aspeed@lists.ozlabs.org>; Mon, 18 May 2026 21:22:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1779103322;
	bh=w2n0G2+Jazj7BtyrJBZLOCheDF0NMvvyn9XJCPYHCN0=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=myqoaJPzPyi+al1ubYSV7anQy9yZQTl1plzyC4g+tWiGfye3dcGdVLplqjgQJ73NO
	 qXaY1nm0hrrXiVov2hXCCZYBLMZa0LY11XCaVutXw0bCkmNwizNfInjC5d9ythy+4+
	 coIQVM5ddaRgAmttQpeKxosnh1Ub4ijCFfhhBSEAdFx/2jAbbHMjl2xnFAEBh7ayxB
	 18LWYKqiio2Ug5Jdk5VWe+q/zusQiUta4iwjmoSoElSxROC97srr4qI9pZ2Bt3f7GX
	 p0Cvo1uBUfOP7kGNCab0sRT4ettc/oU71nbxM5GvJkwA8Fa9TTzaUNKaS+UUTU5FTG
	 2lc06OwsWtWsg==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 67FB76054D;
	Mon, 18 May 2026 19:22:02 +0800 (AWST)
Message-ID: <88d92981e89a9c6c62b6ddc2fa4af51dcc32c276.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 1/1] ARM: dts: aspeed: santabarbara: Add system
 monitoring GPIOs
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Fred Chen <fredchen.openbmc@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 18 May 2026 20:52:02 +0930
In-Reply-To: <20260421130344.2751662-2-fredchen.openbmc@gmail.com>
References: <20260421130344.2751662-1-fredchen.openbmc@gmail.com>
	 <20260421130344.2751662-2-fredchen.openbmc@gmail.com>
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

Hi Fred,

On Tue, 2026-04-21 at 21:03 +0800, Fred Chen wrote:
> Add several GPIO expanders to the Santabarbara platform, with ioexp0
> (0x20) configured to aggregate interrupt signals from downstream
> expanders to optimize sideband pin usage.

Can you provide a bit more context? Is this the result of a broader
design change? Or is it a case of adding descriptions of hardware that
was already present in the design?

Andrew

