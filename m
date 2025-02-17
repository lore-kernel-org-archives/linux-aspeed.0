Return-Path: <linux-aspeed+bounces-750-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F34C02198
	for <linux-aspeed@archiver.kernel.org>; Mon, 17 Feb 2025 00:44:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yx3pL4Pk9z2yG9;
	Mon, 17 Feb 2025 11:44:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739753098;
	cv=none; b=M5imZzECSUCmHtb6o1SYTp6Ld/5onSp+Gz4OdZZ0wC68IukRt1wmvNg26cJoUjZjtDaZHHsShlE2jq7+yrP1uoHLAQ/fGLc+wGYsR4xNUO/RUKZW6bXn2jvHCAmQUY1tpjPTKy7cTiEWj2mF20IfAWXAtZ5Tz2J8y8FtQKRfSR5fdFUiIt7xohx1UoHn6JoO4EQshF5VFT7NYtclpc3UrUN19ImX8FvOKUZOX47mBy+FOaPcvI4qZoR69JTXqEtqe7zYHqW4BH1texlX+wEm9VRVxqiAUuALlm6DbS0DR6AZkuJI+umh5zmlnvbGFXBU8lfe83xeWHLGwYLdJhZ88g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739753098; c=relaxed/relaxed;
	bh=FsLbrEcDHR1CqcdDrTwnQzpK6jcP3o5E5bXCv2mXd5Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kyk/cdDtQbDmHrf6yQYq3GYAPYJmRWrC59V1CmaeBZGywlNqymQJWvpWaCp76gp703IcqZyaR+drgFDP0+cjkIOWJ9zdcD5yQG8kpD/aaEdGVxLngNYMspFctDQuOGlfxQEmBH2gxFy3kW4PeMEp4UBLhUIogxK7CJZLy7/5UyYeSQo+om7LSIDtGhfgmEonjFrtJPr4iuNTHwG+RAmwOx2Efc8MyD8x7NUhQgBORh6Yj/Sp6C+wOzzahDe5ip5ou/1f70ceaVuS/oriEP0JT6gtrPodB+vEz8P/jp3NBZfUYcEZdZue/iL3bdMgGlu+d0AXoDuiIlfPRzLArvGPuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=e12xb8n0; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=e12xb8n0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yx3pL0JwNz2xt7
	for <linux-aspeed@lists.ozlabs.org>; Mon, 17 Feb 2025 11:44:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1739753097;
	bh=FsLbrEcDHR1CqcdDrTwnQzpK6jcP3o5E5bXCv2mXd5Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=e12xb8n0CJf/RnYIfowfnxv1ZGM+A7mQVlP9zgn8rTq9f1NSNUWQQiC1+0SKi5LZF
	 BpjqJElLlN25eGELSxpbovzmH1pPT/XFbRvbs5PDMgMIl8ojEUeS67GavpurJrry0G
	 UC2EK31KM+F86fSM5j2fYSWDYkqBCd/cAZUcwXT7b/MZB1FAOmLCvj1EgXLEppQDDv
	 gF/8m7Xf78pPYZ/y0yKUo1TSlpNGAYM2lJWxGXe+ygURPUDlOpNkOJAkbvn3v28+cy
	 BPARfhX9p04L45+dl6+JbAev5GJUaQ/1Mlf6ApFXfTPOpeMccWRIeJhV3gth9w/t3A
	 d/BSMCO6hBy1Q==
Received: from [192.168.68.112] (ppp118-210-170-58.adl-adc-lon-bras34.tpg.internode.on.net [118.210.170.58])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id B9F5C64E5C;
	Mon, 17 Feb 2025 08:44:56 +0800 (AWST)
Message-ID: <24d2d411365004f11498777501da54d6a9c6e758.camel@codeconstruct.com.au>
Subject: Re: [PATCH dev 6.6 v3] ARM: dts: aspeed: yosemite4: add I3C config
 in DTS
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: MarshallZhan-wiwynn <marshall_zhan@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Mon, 17 Feb 2025 11:14:56 +1030
In-Reply-To: <20250214011556.1891113-1-marshall_zhan@wiwynn.com>
References: <20250214011556.1891113-1-marshall_zhan@wiwynn.com>
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
MIME-Version: 1.0

Hi Marshall,

On Fri, 2025-02-14 at 09:15 +0800, MarshallZhan-wiwynn wrote:
> Set I3C config in yosemite4 DTS.
>=20
> Test plan:
> Tested pass with aspeed I3C patches and I3C hub driver.

Can you please expand the commit message to provide details? This
statement is quite vague, and I don't find it terribly helpful as it
stands. Which aspeed patches? What tests?

>=20
> Signed-off-by: MarshallZhan-wiwynn <marshall_zhan@wiwynn.com>
> ---
> =C2=A0.../aspeed/aspeed-bmc-facebook-yosemite4.dts=C2=A0 | 88
> +++++++++++++++++++
> =C2=A01 file changed, 88 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-
> yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-
> yosemite4.dts
> index ab4904cf2c0e..3f98e67674d0 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -1317,6 +1317,94 @@ eeprom@50 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> =C2=A0};
>=20
>=20
...
> =C2=A0&adc0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D "okay";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl-0 =3D <&pinctrl_adc0_d=
efault &pinctrl_adc1_default
> --
> 2.25.1
>=20
> WIWYNN PROPRIETARY
> This email (and any attachments) contains proprietary or confidential
> information and is for the sole use of its intended recipient. Any
> unauthorized review, use, copying or distribution of this email or
> the content of this email is strictly prohibited. If you are not the
> intended recipient, please notify the sender and delete this email
> immediately.

Please avoid including these confidentiality clauses:

https://subspace.kernel.org/etiquette.html#do-not-include-confidentiality-d=
isclaimers

Andrew

