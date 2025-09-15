Return-Path: <linux-aspeed+bounces-2227-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398CFCAC58E
	for <linux-aspeed@archiver.kernel.org>; Mon, 15 Sep 2025 04:51:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cQCLF6P3dz3d7n;
	Mon, 15 Sep 2025 14:51:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757911909;
	cv=none; b=BRPt/o5lW2tkOunT7TUTuv/TqMu9C7PP7ABCZNHAdjalEDkA+bCnSKwWIYn/FblIqPXJx9+FxDN3JbsreU1JBAS8TxkgpeD2hNklBc1NyyhGXv+mSIJIem+LDeho41vOv2MFnWdrSlqCgVKJMMJHxGuaQh8IlTwRDRPgKaPmnrFFHDBXj9MmaaaPF9CpPl6/2A3PeHAVAz6D7MvtbzhrhNMyMIP2gFJSm55M+67QwEmk5sLhPkmKBNlN+1fILfa7N2oB6tQNjv/DSQzDwARDBkvy/yTTXRQq89cSdCl3TysEYTC+YuXAg0KUDCmAOVAV14gEQPwfW2J9q/C/BjNTQA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757911909; c=relaxed/relaxed;
	bh=BVMHhWMWW+z0ftn6nPGu/42b6y9+COcMk+xOQhhhwi8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AmMstUxy6XRNk7onTlpVi2uUb8tEJcZ4UwtVNbvYwGSgzBsSqG+/OU5ryfYiu+7cZFHer17yslUPYGviQBMnxiY67cujSGKPEO5Q5vY7uu7URQquldM/OhGkIHdytw5zy5Ugpq7KcXjDhF+wAgWwqvEq03L+kwJavI3FKLzpDgDVhBqT84pHOex8PTcJbrRybJRSOHvSj2c5OQRzIfm5YEjwT2F6hGapIGcTYL+Dz9slEjFTdZfGAmggmNYkZrYtmCbe3Z7b9umXQ8mfSTP+jeWVQiKBXFnUSDqegrCFQ2kXC3f8buf9DRWktUaaU5Oq8GFpCvyLEjgut6b4BbBa2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=bPIeS0xz; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=bPIeS0xz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cQCLD3F1Pz3d44
	for <linux-aspeed@lists.ozlabs.org>; Mon, 15 Sep 2025 14:51:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1757911906;
	bh=BVMHhWMWW+z0ftn6nPGu/42b6y9+COcMk+xOQhhhwi8=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=bPIeS0xzB0UGuxDe0qaUYJe5B5ngK9Udw24LmmQDg3olfuibtVqhZDjmR9qPA1uf5
	 6e/O9R4ScNXSvFcagUEcZe+d7VQdQzTqPt9tV57OY6qmcojbUL7dyzzWqsYs9X6nEb
	 zFJA74uy8JM1C6BI3Db36OuzJhwQGSXsT1c9pu/VatP36fASJG7DVKcTYKTktn0xvW
	 vaSv+YmdXDAxdaHgfOWkRLRLD6b3PVLImsj4dOB+x53AMp73yDie/sla6ENAmChbQl
	 e4h7RfL6ZqZsOlwxxoQsSJmW2NtlUhxr7UCJa/pMYIbhEFfIB82iZiquTdQ8ffuc8O
	 5a3yTSkIEy7rw==
Received: from [IPv6:2405:6e00:2430:fb15:b2b4:1872:3690:c682] (unknown [120.20.190.44])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 398DE64CF0;
	Mon, 15 Sep 2025 12:51:42 +0800 (AWST)
Message-ID: <67f2276e99640bcbded80560e8b8d2922b731e81.camel@codeconstruct.com.au>
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: add device tree for ASRock Rack
 ALTRAD8 BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rebecca Cran <rebecca@bsdio.com>, Krzysztof Kozlowski <krzk@kernel.org>,
  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,  Joel Stanley <joel@jms.id.au>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Mon, 15 Sep 2025 14:21:42 +0930
In-Reply-To: <04b0799e-b0a3-4dbc-98f3-239869c79305@bsdio.com>
References: <20250911051009.4044609-1-rebecca@bsdio.com>
	 <20250911051009.4044609-3-rebecca@bsdio.com>
	 <1e4c65c6-4745-45e2-9e20-9d2e69ae2ea4@kernel.org>
	 <04b0799e-b0a3-4dbc-98f3-239869c79305@bsdio.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
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

Hi Rebecca,

On Fri, 2025-09-12 at 17:37 -0600, Rebecca Cran wrote:
> On 9/11/25 00:29, Krzysztof Kozlowski wrote:
> > Never tested.
> >=20
> > It does not look like you tested the DTS against bindings. Please run
> > `make dtbs_check W=3D1` (see
> > Documentation/devicetree/bindings/writing-schema.rst or
> > https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-s=
ources-with-the-devicetree-schema/
> > for instructions).
>=20
>=20
> Am I doing something wrong, or are a certain number of validation issues=
=20
> expected?

I expect you're not doing anything wrong there. There are a number of
historical warnings from the ASPEED DTSIs. However, generally, the
policy is as documented here:

https://docs.kernel.org/process/maintainer-soc.html#validating-devicetree-f=
ile

>=20
> For example, I'm seeing these - most of which are from aspeed-g5.dtsi,=
=20
> not my dts file:
>=20

*snip*

I'm okay with taking new ast2[456]00 devicetrees that don't introduce
any new warnings of their own. However, given you're contributing a new
devicetree, it would be super helpful if you could look at removing one
or two of the warnings from the DTSI while you're at it, as this
improves the utility of the checking tools for everyone.

Cheers,

Andrew

