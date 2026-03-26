Return-Path: <linux-aspeed+bounces-3774-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA2F109E54B
	for <linux-aspeed@archiver.kernel.org>; Thu, 26 Mar 2026 05:27:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhC3F4Ww2z2xlM;
	Thu, 26 Mar 2026 16:27:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774502873;
	cv=none; b=KR8OjpPUu9EOGZi4Q9aN2XLrwzPxGgY7L1wWiWCCc90c+N1xv65cK5qYFY00QtQ04qrK722MNC5R4OwZVLmI3kPC1xqoGCVah6rBs1pqY0JEUKq0RTSxgXrMkNVUP3Y0U3oP/z5PC3nJPPia4jJ3bYxscWiIhyrStFIrUXqp9uc96Y+IWyP4nUj/2RljaV5y8fe0Ajnu7/gX9aJJkWh3IJb/MqAai0Cp5WvJD2SaVz6F5Q33EqrRiUcFEt2Nx/R6czl/AuZWEFo9zNPp/MISz9OdgJIcSy04ha0a7h6AiXueOs/Z7aGJVpWuH4PTwG6yvcKuA5WIhf0mg9DHtirZ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774502873; c=relaxed/relaxed;
	bh=gPXVxe4ANUtFdLLKPWp11SGeawgPJ2lvQwnd9v54erw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DzeRY/rphquVmwd7yyMa24r3C2uKqlNe1RnXJGg9h9TC04W+0+ooi83NYvCViQkNOuJTRS9bXOgtz0aulcvdONVrA/cR7FnWYZFrPPf+WmaXzHWFAhJD0Aj/lTeDi2o7OYdWAX7GfKZNur0BQhe9SisHnOw8NaUs2/++vVeVQnT9isZPmivr+bAyuWYHmEzDrNbVJRfivAiqmr0kyxS6iQ75jn+Syuv6XRvRBp/RnPP21LF71N8pdpPsBggFDu2yjB7NY4r+zl6lehfKVdXqJi6cBOt0VShas7Q9gzHWatBSs72JPELvuax6NzHvSZvlxm49wcgdPq33qpX5/uIjQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=kT+04YXP; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=kT+04YXP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhC3D3ZB1z2xcB
	for <linux-aspeed@lists.ozlabs.org>; Thu, 26 Mar 2026 16:27:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1774502870;
	bh=gPXVxe4ANUtFdLLKPWp11SGeawgPJ2lvQwnd9v54erw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kT+04YXPlRKFDvvUziOIQfXuDkgCsfS1eFgzZe2KSyxC6HjrP+oewnY7kk/IeO87i
	 flJF3N4C3PU9B+v9RoNy1sVeBzI0ENkwIC4B5Y9J4JUqmLARnkNv6xUUd6Pke/HFIn
	 FuIm7IS7I3o2dPQ8klFgikDcu3THMaj3oCFDZiLYOtufO0y4UAG5KeU3ia8+a2LTbw
	 E2EcVsqdP2cr5Uo2pBbkHMOaGrwJT6Tk7toeyE542RnA8D9+VJUrlKejklkHBQv0hj
	 BmUnf853E9alMZBLe8xHC8I+bmGNlju+ZBKac7X1JejtjYkUu16M8jVMIeK2oaUczu
	 Hf4RwvlxMta/g==
Received: from [192.168.68.115] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id AAF4065AE0;
	Thu, 26 Mar 2026 13:27:49 +0800 (AWST)
Message-ID: <7867c2bb2d3fa023d0a201ff1ca24d69916fb2cc.camel@codeconstruct.com.au>
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: ast2600: Add reset
 definition for video
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>
Cc: Haiyue Wang <haiyuewa@163.com>, devicetree@vger.kernel.org, 
	linux-aspeed@lists.ozlabs.org, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "open
 list:COMMON CLK FRAMEWORK"	 <linux-clk@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Date: Thu, 26 Mar 2026 15:57:48 +1030
In-Reply-To: <20260302011651.94682-1-haiyuewa@163.com>
References: <20260302011651.94682-1-haiyuewa@163.com>
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

Hi Michael, Stephen,

On Mon, 2026-03-02 at 09:15 +0800, Haiyue Wang wrote:
> Add ASPEED_RESET_VIDEO reset definition to the ast2600-clock binding
> header. It is required for proper reset control of the video on the
> AST2600 SoC for aspeed-video driver.
>=20
> Signed-off-by: Haiyue Wang <haiyuewa@163.com>
> ---
> v3:
> =C2=A0 - Drop 'Fixes:' tag in header file patch.
> v2: https://lore.kernel.org/all/20260227151602.829-1-haiyuewa@163.com/
> =C2=A0 - Fix checkpatch.pl warning, and send dt-bindings as single patch =
as
> =C2=A0=C2=A0=C2=A0 the submitting-patches guide.
> v1: https://lore.kernel.org/all/20260227123837.70079-1-haiyuewa@163.com/
> ---
> =C2=A0include/dt-bindings/clock/ast2600-clock.h | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/include/dt-bindings/clock/ast2600-clock.h b/include/dt-bindi=
ngs/clock/ast2600-clock.h
> index f60fff261130..7b9b80c38a8b 100644
> --- a/include/dt-bindings/clock/ast2600-clock.h
> +++ b/include/dt-bindings/clock/ast2600-clock.h
> @@ -124,6 +124,7 @@
> =C2=A0#define ASPEED_RESET_PCIE_RC_OEN	18
> =C2=A0#define ASPEED_RESET_MAC2		12
> =C2=A0#define ASPEED_RESET_MAC1		11
> +#define ASPEED_RESET_VIDEO		6
> =C2=A0#define ASPEED_RESET_PCI_DP		5
> =C2=A0#define ASPEED_RESET_HACE		4
> =C2=A0#define ASPEED_RESET_AHB		1


If you would like to take this change I can apply 2/2 later when it
makes sense to do so:

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

Otherwise, I'm happy to take both through the aspeed/arm/dt branch in
the bmc tree with your ack on this one.

Andrew

