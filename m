Return-Path: <linux-aspeed+bounces-3332-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B833D3CC95
	for <linux-aspeed@archiver.kernel.org>; Thu, 15 Jan 2026 01:12:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ds4jC5jnzz2xqj;
	Thu, 15 Jan 2026 12:12:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768439567;
	cv=none; b=kBAu6dV/dlEBmjBip8jV4vEwM1FrPG51vnRs6CuZTkIFSvzVm5jTXnsJjT6He7QqPkgBEF9OCvepvgSvtyyseKldutNeK2iCcXMUUkv6MXVM9WCtWGXZ6UG/SDJxMgb6NU/QvVUOMkeTNGUmKVrK/344hZAElVkEdHTgAZ7Urb7TuGWl6d5Pkr4jg9odb+mOfD/bgqnJj4CU2Wt/iKA0gZgnxz/rShInNjxjqUQb9AXkpVQnPTDiom0eieDQBY0/xvEBCTJwcfDoXYIT2sMkKFuDTtKCyP2OiwHCGLr3qzVGelR3k7DimahM21ebgOyGqn4vXdFMlpQ2RxxUg+n0dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768439567; c=relaxed/relaxed;
	bh=w8qv7zGjKLg/PB6Q6k/X+xJDPtRPLbBTgNo+kvs+s14=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NQqbSRATrTP5uxiBj2B1EudxAtHZcBH34fdEXjWPKV5hkd9FQUGL+W/tUd3xIPEJInnotc1JzQHvfZZ+FCm7uNlO19X48lirslXRYqxS4PvCnFd9Rh8euB2UxwkOs7qngr20mWnf4c0VAzeiLFvA40D2yk1k4zPfvqOOX0jGSos3/dz+0jlU+RZGTryNKkvFVoObazhr5+MkQG6dsgIeLbY26J1uT440+jz9GNUrCXeL8paPZ/vZ6Bth1ODyqel48ZLWkZqFBkvpMP0PUPw/1OJSw6tngPJszo8KWkVJtSsS76LjWLeKbDAdOCwc3B3cA8PfQa9XTDHilhJGSJs97g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=REOw9Uf4; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=REOw9Uf4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ds4jC1lBqz2xHW
	for <linux-aspeed@lists.ozlabs.org>; Thu, 15 Jan 2026 12:12:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1768439566;
	bh=w8qv7zGjKLg/PB6Q6k/X+xJDPtRPLbBTgNo+kvs+s14=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=REOw9Uf4sZS4m++NHjUuL06qkr98+A08cZmsmF48lK0ym7qvP+7KNER4qUUCM6SWg
	 Y0ZXtHU8pHvntidwMv3EicjRZe9P9aRaPTRaeTurl5e8mEJkWDdsFmhe8VSV9dH/XI
	 2O+NTS41YBC70cEUAvg1/rLJrpmXUwuR49Kx1eX/QLnekXayK6n7jaZkA8Xcn+THyK
	 C2m5QScS9gBSfHobr2RK4y85PCueDDG5mRgpp7DA2NkTAqFBuPFEkGJJMTMN/T1IZ3
	 j/72Mwat04UwCNCJKOsjqKgLZvVA4ZyU0d6iN7TR36UXFP/+1i15u0BVisGKa7NdB2
	 CvthhyFlzMEqw==
Received: from [192.168.68.115] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 286836472A;
	Thu, 15 Jan 2026 09:12:46 +0800 (AWST)
Message-ID: <9cdf03250dd923859638de4850ce4b4e4279bf8a.camel@codeconstruct.com.au>
Subject: Re: [PATCH v3 0/2] Add Meta(Facebook) ventura2 BMC(AST2600)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Kyle Hsieh <kylehsieh1995@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Krzysztof
 Kozlowski	 <krzysztof.kozlowski@oss.qualcomm.com>, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley	 <joel@jms.id.au>
Date: Thu, 15 Jan 2026 11:42:45 +1030
In-Reply-To: <c391ded8-6569-48a2-9c49-6b68838f91b0@oss.qualcomm.com>
References: <20260113-ventura2_initial_dts-v3-0-2dbfda6a5b47@gmail.com>
	 <c391ded8-6569-48a2-9c49-6b68838f91b0@oss.qualcomm.com>
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

On Tue, 2026-01-13 at 08:17 +0100, Krzysztof Kozlowski wrote:
> On 13/01/2026 03:57, Kyle Hsieh wrote:
> > Summary:
> > Add linux device tree entry related to Meta(Facebook) ventura2.
> > specific devices connected to BMC(AST2600) SoC.
> >=20
> > Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>=20
> Where? How is this possible?

Kyle: Tags only apply to the patches they were provided for. Tacking
this one on the cover letter implies Krzysztof has acked the devicetree
as well, which is not the case with respect to [1].

[1]: https://lore.kernel.org/all/20251223-ginger-worm-of-swiftness-a8fa05@q=
uoll/

It appears you're already using b4. b4 also handles tags for you:

https://b4.docs.kernel.org/en/latest/contributor/trailers.html

As it suggests, run `b4 trailers -u` to automatically and correctly
apply tags you have received for your changes.

Please fix the issue here (remove the tag from the cover-letter, apply
tags to the correct patches) and send again, _after_ you've addressed
all further feedback on v3.

Andrew

