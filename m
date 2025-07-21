Return-Path: <linux-aspeed+bounces-1758-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD87C83F1A
	for <linux-aspeed@archiver.kernel.org>; Mon, 21 Jul 2025 01:14:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4blj8n4453z30hF;
	Mon, 21 Jul 2025 11:14:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753060441;
	cv=none; b=NKwM+DV2RP0H57blesDGw5O9Qs8N71d52UgZNDisqqZ1pTY0TmEj1aDUaIulxGvXP8NneyV1nWTzVgylKhIbPpVq5PyMIRpvQrHi2SmNqBGmVuB0e89TsBdI1zhjonc4PMH+4j+rADpX2bbPNOq8Q+K16dlfX6p2dDuaKl5ORbx8dEfO4rl8sfLeZwwEUXQAezVrUJ4VHkhoydIDQuuj1HVs6tfJjeMqJUZGsvOUmuDBqohvmAr47G0Uy3cUFlwp8kChtEjk2FvfbNKt6igLph7VOheVjbRxYWNvemTUGU+p5qVOwJbAXJD/Y7+7EeNdeTUgwTKClZOF4RDmuu+unA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753060441; c=relaxed/relaxed;
	bh=Ava61Vivu7w/mcZfCfpTOpBif8IfUW5XaEI9F1IJOB4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bAsNOGelPgOQJm55aIfpmVRHnZPByHvRC97blYYNNvvgwfC5kGwqbIN8RAgGE9nZMFwAx0TEqXmwRGefhOtdXK8Z7SvouS1jKhtzzuBWFgi3EtriLAW+3WEMwg6WLTV7Zgga6SaNgGSeRD0GEfaY4VlsLTrwMhsWLOo9NrUqmgrIbWCV9Bp7FIP4vdba71/z/Q3UCi1SF6tkLoAUkx4SyF7rOhdD7q+wrpnGlHWdB54N3Iiu12q2FjMFGB7aZHTcnEJReSTmyFrnYryFCvQo7gwKKq68ySSiuVkmxhwd8ekZ1H0ynJEdhUjzc0y4yB8NZ9xQQPPAhrnLgJnV/vORaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=csbDTtQ2; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=csbDTtQ2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4blj8n136fz2yfx
	for <linux-aspeed@lists.ozlabs.org>; Mon, 21 Jul 2025 11:14:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1753060440;
	bh=Ava61Vivu7w/mcZfCfpTOpBif8IfUW5XaEI9F1IJOB4=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=csbDTtQ2jgTPppbMqU8+YPTQ1SgrQ9HL3Lbe0Dhffbn3xftWGJ66X4mI6t9ZdKgxH
	 cesOBugB8X1kPhlHniy8n4njJnYdtELyIWEeQaQ+QB1ySQDFedAFu3RxUDdlyTGNpl
	 hrtKLAp8anZzDl+T1H0zq2KMxEeUR6QLf+pINuDPOMjvmO65nTvCjUtanpyOz4hQDz
	 ytAHYh/NAVuso/BsJMy85oZEmMco4h/VE2q4I+CnyeED8mVpVwoZkJbZKdD7pLQRJp
	 y0sxTBLcUaTo2zMB8xDHqBJdqG9FPUQ1PVRFEg5Qp/azDvSBCCgDJQ7SKBOQvh+YFk
	 S/n6bWfYWu6Yw==
Received: from [192.168.68.112] (unknown [180.150.112.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E86056443C;
	Mon, 21 Jul 2025 09:13:59 +0800 (AWST)
Message-ID: <f61d9b4f25e18c37e88c56e3222a387b9ece6c0d.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 6/9] ARM: dts: aspeed: Move flash layout out of
 Facebook netbmc-common.dtsi
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: rentao.bupt@gmail.com, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel
 Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Tao Ren
 <taoren@meta.com>
Date: Mon, 21 Jul 2025 10:43:59 +0930
In-Reply-To: <20250706042404.138128-7-rentao.bupt@gmail.com>
References: <20250706042404.138128-1-rentao.bupt@gmail.com>
	 <20250706042404.138128-7-rentao.bupt@gmail.com>
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

On Sat, 2025-07-05 at 21:23 -0700, rentao.bupt@gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
>=20
> Move BMC flash layout from ast2600-facebook-netbmc-common.dtsi to each
> BMC platform so it's easier to apply different layout settings.
>=20
> The fuji data0 partition was already extended to 64MB in Meta
> environment. Elbert flash layout is not changed.
>=20
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> ---
> Changes in v2:
> =C2=A0 - None (the patch is introduced in v2).
>=20
> =C2=A0arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts=C2=A0=C2=A0=
=C2=A0=C2=A0 | 6 ++++++
> =C2=A0arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 6 ++++++
> =C2=A0.../arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi | 2 --
> =C2=A03 files changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts b/ar=
ch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts
> index 74f3c67e0eff..673cabbec92e 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts
> @@ -50,6 +50,12 @@ spi_gpio: spi {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> =C2=A0};
> =C2=A0
> +&fmc {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0flash@0 {
> +#include "facebook-bmc-flash-layout-128.dtsi"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> +};
> +
> =C2=A0&lpc_ctrl {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
> =C2=A0};
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts b/arch=
/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
> index 840d19d6b1d4..71f58ad1ff06 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
> @@ -223,6 +223,12 @@ eeprom@2 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> =C2=A0};
> =C2=A0
> +&fmc {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0flash@0 {
> +#include "facebook-bmc-flash-layout-128-data64.dtsi"

Please don't bury the change of flash layout in a patch that only
claims to push the layout choice down to the platform dts.

Also see my reply on patch 5/9 regarding maintenance for the Wedge400
flash layout.

Andrew

> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> +};
> +
> =C2=A0&i2c0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0multi-master;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bus-frequency =3D <100000=
0>;
> diff --git a/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi=
 b/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
> index 208cf6567ed4..4f819bf8c909 100644
> --- a/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
> +++ b/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
> @@ -54,8 +54,6 @@ flash@0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0status =3D "okay";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0m25p,fast-read;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0label =3D "spi0.0";
> -
> -#include "facebook-bmc-flash-layout-128.dtsi"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0flash@1 {


