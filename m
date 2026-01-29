Return-Path: <linux-aspeed+bounces-3444-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D6ED73E9B
	for <linux-aspeed@archiver.kernel.org>; Thu, 29 Jan 2026 22:31:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f2DQ84KQDz2y6G;
	Fri, 30 Jan 2026 09:31:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769725888;
	cv=none; b=Wnj+AT3psBMr2irYGYBVsF8ZAqGzoJ7Y2HQaWpwneO9O78KUnuFjcu2BllXpCrCu2c7WFkpZpN+L+f6tFXJ/QCajkaj7lhvYFAS6niP3fPsr0gYelM2DyYXRLAbGFoV/k/SVKd1rsCx9ZdbHgulDOW2yb9AJEJ5cWq+KLK2WpLa+/cyMHxR+0mnB993btQrBDdmxtJdNRSX2Ciip1X5sFJac5ebB0ScpcLpYkfDn2SpAMgqavNcP2XcQgGdKmdS5/NBBoqgCibKK1qWSyVzuu5h55D7kzWphq3jzGNFnCJj9ESE3OHbQVZTnLfIrZBPUFfvSXpbx0H5U1DvHmpYYRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769725888; c=relaxed/relaxed;
	bh=XeDMpJ65mp+98QISIa6zGzqYGRyHyE/0c63dQ1J//No=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ksI/+MbonRXKGPF6mCJuIHuWbbHotzFShlJ83IDD/Y+Zx9XqAazuxCo0di+pvZmE9wUU1d7I+kLgV3pDTRd+OJZdSnDt3HXDm07MdXp1TP19eRqrsdCsf1z9UZCtS0XX+hfMOEsAoQK4rPWRpZL5NmxLc8dR+4V1XnvpGGotmr3OcQAVupf7RkraN5y0+Q8RfLzQuPQti413e35V0+Qvo+bg+L8UTaf5Z5LIMnVNA/IIOew/uzITF9fp44P0NasE5uREEzl+BMRHIk/67+X6QuEqbXpICte3bSmr6NlwdTlSwJ1QVdrtE7iHWzHw9gasK18+xo3MgJwxcEkQw4U3dA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=maXuXDBD; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=maXuXDBD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f2DQ76VbGz2xpk;
	Fri, 30 Jan 2026 09:31:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1769725886;
	bh=XeDMpJ65mp+98QISIa6zGzqYGRyHyE/0c63dQ1J//No=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=maXuXDBDY5E82w+PEupDgyz4HMJpbKuw1UzO+dIkS5jxTm1C/okzqrlbeKVwP5/2u
	 Qmlwe1QlE+tToivLA+Co71fnsoyIwW+7Ac7wb/oLse0BIQHmHL1b4kESpKUryAJSH5
	 zz1AYVHdKrtJxdw68fXAgjGC3zdLRRl+DqEIzH7+zSxuwZgFryX4FpjGLfaHjLSBnh
	 N4LG5nd9/2dhd4+30p/dIoCMLGZn24TWDGPOKEniU5PKzNcg2d1CNTXMLAUg1Az/hM
	 20YqxQthcjTdbkupxPsQgS4k/x+Blm/TSTl02Q1sKw5XjzbabaZ9c7kQExTjo8WmXj
	 K0yNxc7jhe70g==
Received: from [192.168.68.117] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 679D860035;
	Fri, 30 Jan 2026 06:31:25 +0800 (AWST)
Message-ID: <547396d9f2aaea032fa62e7adcafb423a9467446.camel@codeconstruct.com.au>
Subject: Re: [PATCH RFC 05/16] ARM: dts: aspeed: Remove unspecified LPC host
 controller node
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,  Linus Walleij <linusw@kernel.org>, Joel Stanley
 <joel@jms.id.au>, linux-hwmon@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, 	linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, 	openbmc@lists.ozlabs.org,
 linux-gpio@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-iio@vger.kernel.org
Date: Fri, 30 Jan 2026 09:01:20 +1030
In-Reply-To: <CAL_JsqJxfVaLqzTwm7iEvc4maBzVvpc-i5uD6CZRtiv+V+7+1Q@mail.gmail.com>
References: 
	<20251211-dev-dt-warnings-all-v1-0-21b18b9ada77@codeconstruct.com.au>
	 <20251211-dev-dt-warnings-all-v1-5-21b18b9ada77@codeconstruct.com.au>
	 <CAL_JsqJxfVaLqzTwm7iEvc4maBzVvpc-i5uD6CZRtiv+V+7+1Q@mail.gmail.com>
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

On Thu, 2026-01-29 at 09:16 -0600, Rob Herring wrote:
> On Thu, Dec 11, 2025 at 2:46=E2=80=AFAM Andrew Jeffery
> <andrew@codeconstruct.com.au> wrote:
> >=20
> > For the AST2500 the node was used for pinctrl purposes, and while
> > the
> > hardware capability is also present in the AST2400 and AST2600, the
> > their pinctrl no relationship to it. Further, there's no
> > corresponding
> > binding, remove the node for now to
> > eliminate the warnings.
>=20
> Odd line break.

Ha. The preceding sentence is also a mess. Not sure what happened
there. I've extracted the pinctrl-related patches to their own series
locally, I'll send that out when I have a moment.

Andrew

