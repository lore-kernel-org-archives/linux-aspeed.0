Return-Path: <linux-aspeed+bounces-2122-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B36CA100B
	for <linux-aspeed@archiver.kernel.org>; Wed,  3 Sep 2025 05:31:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cGrnQ6XXQz2xWQ;
	Wed,  3 Sep 2025 15:31:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756877482;
	cv=none; b=aisgu8SjjI668EMmyRyVi4+vrQZZ5+5XTA/Z0kev2ahMrQTunjtzqqoZuetma0rhKTaxf7Ac0OL5eouT/58KhL5argIlBc9aYZ3d+HjziugHzV9XNR2FkbbRT7yDDpZghbT8Y0Qr/bC4rx8ZGBYqCouUm1G0EONdMrusZaJbMNISAcgjonJREK24SZYPO5TTcYxpBWGi/2Yh+lVAVgG/qOgbSvPO8K2T/uJg6aXX65Pz+0u8ipeWhZX7I51hL/IHL2SFJISeYlQd0OYaoFooVqTSgCR3VNENEmsJxawrCaRTyqbROhg+1X5JhvluJfrmOftNWQ4scJ60FyxYubPeGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756877482; c=relaxed/relaxed;
	bh=JnGCK1lahw6eKRr1X7LuKjE36AI6nTTs35DYpWRjgPc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RCR2W2UdY+xtp7llPWqcM6NXpTNYpT+XpVQBfBn05mugsuqtJDMXy5xlb9JlZSda2Q6WYInnsf6ZJ3du5BJEDcbxruhjwVmnbh1UMfqVbu28rbdZ1g2JRGbg8MHtjSU+1l7acX8gaeKczViFherIBJn9IuO5TJy1942SzY4kuHAtSdZic+FQWs0xFEiURIOfWkQ4+gh8CsIO/nc0hzub8MQYzs6NpfcB/vEtqztiGlmOx0QGukMi1rJWOcD8DLzQAIZOpydDdKCWdCtS7imLLTcaxPl2OMX2dO3DOWLPvh05DEJ51lAGWtDg4RPpcT76i6e2zjd2fs2cMY9sKGjG0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=fACK4iWC; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=fACK4iWC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cGrnQ1QD7z2xQ4
	for <linux-aspeed@lists.ozlabs.org>; Wed,  3 Sep 2025 15:31:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1756877481;
	bh=JnGCK1lahw6eKRr1X7LuKjE36AI6nTTs35DYpWRjgPc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fACK4iWCaKo+xngoM6xHxCzq0XPdutG9X6hPIigvvWVSmK74s7mhro+frrRzWJf8X
	 OOYOjzr4AOdyVtWojQJJE9cQfqj7xvXWFZpR3a+PY+wIfKrOKt55gO4N+8L09S8Tof
	 nA+VmVkuO2mOzgy7lo0knxxgHC7hsYG92ijBNNs2CMCqkTVcQk9KEMdD0UFul/dnju
	 ISXtX1w929DiSsKtz9ZKAGunLxnoeB4VbtTHYubhHvG677FF4F4W32PwzSXte0UPDK
	 KHrFXLX0JS5qVR35s/NXnjkWfUMyz/fjnuHj+h68ZgA6PWkdyMzMCOoyfOD4CGbljF
	 9jSktTJKjFDYg==
Received: from [192.168.68.113] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id D93F56E02C;
	Wed,  3 Sep 2025 13:31:20 +0800 (AWST)
Message-ID: <307fa87eb552ac4a1f6dd6139450786195e3892a.camel@codeconstruct.com.au>
Subject: Re: [PATCH] ARM: dts: aspeed: Fix/add I2C device vendor prefixes
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: "Rob Herring (Arm)" <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
 <joel@jms.id.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm
 <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Date: Wed, 03 Sep 2025 15:01:20 +0930
In-Reply-To: <20250815230841.3487764-1-robh@kernel.org>
References: <20250815230841.3487764-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
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

Hi Rob,

On Fri, 2025-08-15 at 18:08 -0500, Rob Herring (Arm) wrote:
> The ASpeed DTS files have various I2C devices with missing or incorrect
> vendor prefixes in their compatible strings. This hasn't really mattered
> and doesn't impact ABI compatibility as I2C devices get matched with thei=
r
> vendor prefix stripped.
>=20
> With this, the "maxim,max31790" nodes now validate and have some
> warnings. Remove the spurious "#address-cells" and "#size-cells"
> properties to fix the warnings.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> =C2=A0.../aspeed-bmc-arm-stardragon4800-rep2.dts=C2=A0=C2=A0=C2=A0 |=C2=
=A0 2 +-
> =C2=A0.../dts/aspeed/aspeed-bmc-facebook-harma.dts=C2=A0 |=C2=A0 8 ++----=
-
> =C2=A0.../aspeed/aspeed-bmc-facebook-minerva.dts=C2=A0=C2=A0=C2=A0 | 24 +=
++++--------------
> =C2=A0.../aspeed/aspeed-bmc-facebook-tiogapass.dts=C2=A0 |=C2=A0 2 +-
> =C2=A0.../dts/aspeed/aspeed-bmc-lenovo-hr855xg2.dts |=C2=A0 2 +-
> =C2=A0.../dts/aspeed/aspeed-bmc-opp-palmetto.dts=C2=A0=C2=A0=C2=A0 |=C2=
=A0 2 +-
> =C2=A0.../boot/dts/aspeed/aspeed-bmc-quanta-s6q.dts |=C2=A0 4 ++--
> =C2=A07 files changed, 14 insertions(+), 30 deletions(-)
>=20

I see you've applied this to your tree. Sorry for being slow on the up-
take, I've been focusing on other things recently. Happy to take it
though, if you're happy to drop it?

Andrew

