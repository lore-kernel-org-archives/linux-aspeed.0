Return-Path: <linux-aspeed+bounces-2306-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74BF3CAC5A7
	for <linux-aspeed@archiver.kernel.org>; Mon, 22 Sep 2025 02:40:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cVS5Q0lJVz2yr9;
	Mon, 22 Sep 2025 12:40:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758508826;
	cv=none; b=chy52NN6L38FSLtuYXGvDDI2Xw1U7KxujfC/a9MxkttDfsG22SZpBy8eSvFJAh0CJTPlCSf5mVzgHmcVCGrF3ETdIAG/ZCAjWt3acvNJd1HSfD8YUBLxWe6KJCKsjiLLffrO7jAUf1YMaKRl4hf3si9rqaK87DZ/UZcDwte0fNWmVQatSeM6UtMFxBhG+WPu6PS7C2pKVVkC0EkXjNQNvZNFjkG/Mb+GyMWNfIFMpz7jsWlQOnnuq44Vc+S8exgbb42uxwduQPugWTj7fvNO7fOtkWaAyK8K/vJdNuyZgEIBL0sjVpPN6xoz0hDpn+w4/kIAqXIXjVVJRr3pZcaPDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758508826; c=relaxed/relaxed;
	bh=sbMTFBkaNempQ9R89eRUdq5Tnnibi7nvv+qJWfTi2ys=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EbX5+bDhiKrOKOnJpUfY4dsd3e1zwsVLPhl+EaCTvPQ+H3sbKv7YRVN1vHiR8REYj76kh+8AmVXwnBgdP1PnQ65c6ExLiL6yHTS59SHXH6scWdnSf5A68gFjGQBqHu4mcQlzMdWXYjD26TXTEESIkJEp8UiqMdUYYENaPuApxpVw99/Hjl6QHiju8Ck+uuTOpWjphdPM3Bw9OdiadTj1tu0Js+AQixNm79uO/ji0YGTaLSADuXOja7xYB2y5HLyFn+GScm1/J28rpb53GM4gfb+GHq/MkdvTCAoUBxoeLqSQEQfy5tM929u/E/Ta0yrHhW4ufutn/YlRtLDDdFcYbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=GkIVyXN3; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=GkIVyXN3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cVS5P3qcgz2xck
	for <linux-aspeed@lists.ozlabs.org>; Mon, 22 Sep 2025 12:40:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1758508823;
	bh=sbMTFBkaNempQ9R89eRUdq5Tnnibi7nvv+qJWfTi2ys=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=GkIVyXN3hTKABUPSJs3w6GjAn44kF9bvQknDdWFdldCOnDKkSNfoDnN1uylHmcHD5
	 tvO4lPlxKNJLrZjgvqLxgjxv7nOdwyVqOJO9ta8+M/EQ73dCxpXBptqdTm0wUmSmfX
	 SGuVqkXmK0Yorlsugi587z7v95484+DTFgx25q3w8lJDwFRWtWBfoGexDbaMBtE334
	 MVZ34FU0g9+PdEvqSfuRanyzXxW5cGO/j2EkZ93AOID2fiec5rMi+WhzQBXL+gYEeO
	 A1F5BfbwyH6j3zQRAvBV6KsRe63IrO8nyCIWSjl/LHXSqt/ggdrUQ+lXWfLuDmlUwH
	 dGitfe2CtzYLA==
Received: from [192.168.68.113] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E29CF64755;
	Mon, 22 Sep 2025 10:40:20 +0800 (AWST)
Message-ID: <dd660ce0388afb61e476f164335600f3fc2b1fb6.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 0/2] Add device tree for ASRock Rack ALTRAD8 BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rebecca Cran <rebecca@bsdio.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 22 Sep 2025 12:10:19 +0930
In-Reply-To: <20250917180428.810751-1-rebecca@bsdio.com>
References: <20250917180428.810751-1-rebecca@bsdio.com>
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

On Wed, 2025-09-17 at 12:04 -0600, Rebecca Cran wrote:
> The ASRock Rack ALTRAD8 BMC is an Aspeed AST2500-based BMC for the
> ALTRAD8UD-1L2T and ALTRAD8UD2-1L2Q boards with an Ampere Altra
> processor. The BMC runs OpenBMC.
>=20
> These patches add a device tree and binding for the BMC.
>=20
> **Changes between v1 and v2**
>=20
> - Reordered nodes to be in alphabetical order.
> - Removed status lines.
> - Fixed naming.
>=20
> There are still several warnings from
> make CHECK_DTBS=3Dy ARCH=3Darm W=3D1 aspeed/aspeed-bmc-asrock-altrad8.dtb

Thanks for checking!

> I believe the only one which is reporting an issue in my dts file (as opp=
osed
> to included files) is the first, and that's because the code partition co=
ntains
> the TF-A and UEFI areas. I couldn't see a way to suppress it.
>=20
> aspeed-bmc-asrock-altrad8.dts:578.16-581.6: Warning (unique_unit_address_=
if_enabled): /ahb/spi@1e630000/flash@0/partitions/code@400000: duplicate un=
it-address (also used in node /ahb/spi@1e630000/flash@0/partitions/tfa@4000=
00)

It seems odd that the partitions intersect. Are the offsets correct? If
they are, can you add comments to the DTS discussing what's going on
there?

> aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/memory-controller@1e6e0000: faile=
d to match any schema with compatible: ['aspeed,ast2500-sdram-edac']

*snip*

> aspeed-bmc-asrock-altrad8.dtb: gpio@1c (nxp,pca9557): '#address-cells', '=
#size-cells', 'gpio@0', 'gpio@1', 'gpio@2', 'gpio@3', 'gpio@4', 'gpio@5', '=
gpio@6', 'gpio@7' do not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0=
-9]+)?)$', '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/gpio/gpio-pca95xx.yaml#

This one needs fixing.

Cheers,

Andrew

