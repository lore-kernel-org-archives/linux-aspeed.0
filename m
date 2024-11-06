Return-Path: <linux-aspeed+bounces-89-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F376CD59F7F
	for <linux-aspeed@archiver.kernel.org>; Wed,  6 Nov 2024 23:29:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XkLyP1XVzz3bcW;
	Thu,  7 Nov 2024 10:29:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730935773;
	cv=none; b=Qhbt9Av+maAKC6enYGsExX42vUz4TCRcUDsOacf60QmswNkidg4sV5cme9nsJcb4tbQoKMjIgC0ugZHbOS/R1yLJP95Itxd0lLzNqH1vnFdejA3D7L+lnyYh5jIYA2cN21eH+wOrm1Unl7bpJvSGf2eWgRRRFxblK4ENcH+1FSBFroXY8UwAfSvcrQAjD/4TvG0W2sCPQWA4aOtO55T+UTL6aYK7y2ZZPao6aLEHzkz7TU/eRew365gQSixqKezTLGSC/LN+LYYSOFA+VcSiaVF1tbajCwo+DZzu/xUz5axsZhdC6PMC0kZ8knc+Jk+/m0hpEdUOVhTgvq/L8Sinog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730935773; c=relaxed/relaxed;
	bh=TOWl/eUFXyJWI5BavbOyBodSpQ5DsXBDLmnGE28bD/o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hlfVAxYmiiP3y0LDcqK+AiaFGLuPT47ekzTxPXziIx8LOJL9oR++fheSP3lPie7vgoQgIsd4nhj6F2huptIdYlsvEQjB5G+t+nZIwJNAoE2W0DRGEuJcnbGSCrJn1H6ZWBcwyQSxEJDUCCDAMkwo4631I8n17x99vqBnCYLGrJu1n+OaA9z2WJ9engaeRaIECADFwwrSNbHa2DvU7QP+Z+dkDqvJ+BKcAc4SU0tsibI9XkL/ms9n8iNC7j1bHf/pdv7dRjGF8FqrPD70kuUjb8LnNAvMXBezgrz1YOQhwjPbFHXSmCRPW6KZ5WTftTYNhFzkyYXcRefhHKOSBVWCqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=mgxojSU/; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=mgxojSU/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XkLyL6vr8z3bcS
	for <linux-aspeed@lists.ozlabs.org>; Thu,  7 Nov 2024 10:29:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1730935768;
	bh=TOWl/eUFXyJWI5BavbOyBodSpQ5DsXBDLmnGE28bD/o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mgxojSU/QnQp9VU5DKq2xgfomwoyPOCHI920rgB3KltLPzJzfSjeRTuR5h8zXY/n0
	 /7FStouaMtU8Z0oLhTVNLNiTQ3sb/TcABKBTyIWdUNGiJo1QOSkibJaPc/rRr5SRco
	 HOT7khJTWNqG7ZCaVxVzj0ucNW0IjwQJc5tcoKldWCcfVxq7BG6yOe2eK2c6t2rlxx
	 EFof0MeJeEpTE2VwBu6yre/jMPmA0gydBKYhH7mebThgK+gyfzdd9kGciK6yC4L3BM
	 c4pHGo2NSw3m17JgMSq2RaV/yS/wlIBxF6CEWLtX4kr+boCIzsiF0yOe72F84FXYhD
	 ab49POf2aqdXQ==
Received: from [192.168.68.112] (203-173-7-89.dyn.iinet.net.au [203.173.7.89])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 2ACBD6B7C8;
	Thu,  7 Nov 2024 07:29:27 +0800 (AWST)
Message-ID: <6a2f9268449b08a8e48e882bf1b1ce6f605fe3a0.camel@codeconstruct.com.au>
Subject: Re: [PATCH] arm: dts: aspeed: Everest and Fuji: Add VRM presence
 gpio expander
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Eddie James <eajames@linux.ibm.com>, linux-aspeed@lists.ozlabs.org
Cc: joel@jms.id.au, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 07 Nov 2024 09:59:26 +1030
In-Reply-To: <20241106193303.748824-1-eajames@linux.ibm.com>
References: <20241106193303.748824-1-eajames@linux.ibm.com>
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

On Wed, 2024-11-06 at 13:33 -0600, Eddie James wrote:
> Add the gpio expander that provides the VRM presence detection
> pins.
>=20
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
> =C2=A0.../dts/aspeed/aspeed-bmc-ibm-everest.dts=C2=A0=C2=A0=C2=A0=C2=A0 |=
 27
> +++++++++++++++++++
> =C2=A0.../boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts=C2=A0=C2=A0 | 27
> +++++++++++++++++++
> =C2=A02 files changed, 54 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
> b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
> index 513077a1f4be..9961508ee872 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
> @@ -353,6 +353,33 @@ pca1: pca9552@62 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"pr=
esence-base-op",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0led-controller@63 {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0compatible =3D "nxp,pca9552";

So Lee has queued the binding for the pca9552 in the leds tree[1], and
I've applied the patch on that basis.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git/commit/?h=
=3Dfor-leds-next&id=3Df92d2e9334171d07b47189397f222f64dcb77617

However, when merging for-leds-next into a tree with your patch here to
test, it surfaced a bunch of further (unrelated) issues:

    +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot=
/dts/aspeed/aspeed-bmc-ibm-everest.dtb: pca9552@65: 'led@10', 'led@11' do n=
ot match any of the regexes: '^led@[0-9a-f]$', 'pinctrl-[0-9]+'
    +       from schema $id: http://devicetree.org/schemas/leds/nxp,pca955x=
.yaml#
    +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot=
/dts/aspeed/aspeed-bmc-ibm-everest.dtb: pca9552@31: 'led@10', 'led@11', 'le=
d@12', 'led@13', 'led@14', 'led@15' do not match any of the regexes: '^led@=
[0-9a-f]$', 'pinctrl-[0-9]+'
    +       from schema $id: http://devicetree.org/schemas/leds/nxp,pca955x=
.yaml#
    +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot=
/dts/aspeed/aspeed-bmc-ibm-everest.dtb: pca9552@32: 'led@10', 'led@11', 'le=
d@12', 'led@13', 'led@14', 'led@15' do not match any of the regexes: '^led@=
[0-9a-f]$', 'pinctrl-[0-9]+'
    +       from schema $id: http://devicetree.org/schemas/leds/nxp,pca955x=
.yaml#
    +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot=
/dts/aspeed/aspeed-bmc-ibm-everest.dtb: pca9552@33: 'led@10', 'led@11', 'le=
d@12', 'led@13', 'led@14', 'led@15' do not match any of the regexes: '^led@=
[0-9a-f]$', 'pinctrl-[0-9]+'
    +       from schema $id: http://devicetree.org/schemas/leds/nxp,pca955x=
.yaml#
    +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot=
/dts/aspeed/aspeed-bmc-ibm-everest.dtb: pca9552@30: 'led@10', 'led@11', 'le=
d@12', 'led@13', 'led@14', 'led@15' do not match any of the regexes: '^led@=
[0-9a-f]$', 'pinctrl-[0-9]+'
    +       from schema $id: http://devicetree.org/schemas/leds/nxp,pca955x=
.yaml#
    +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot=
/dts/aspeed/aspeed-bmc-ibm-everest.dtb: pca9552@34: 'led@10', 'led@11', 'le=
d@12', 'led@13', 'led@14', 'led@15' do not match any of the regexes: '^led@=
[0-9a-f]$', 'pinctrl-[0-9]+'
    +       from schema $id: http://devicetree.org/schemas/leds/nxp,pca955x=
.yaml#
    +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot=
/dts/aspeed/aspeed-bmc-ibm-everest.dtb: pca9552@35: 'led@10', 'led@11', 'le=
d@12', 'led@13', 'led@14', 'led@15' do not match any of the regexes: '^led@=
[0-9a-f]$', 'pinctrl-[0-9]+'
    +       from schema $id: http://devicetree.org/schemas/leds/nxp,pca955x=
.yaml#
    +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot=
/dts/aspeed/aspeed-bmc-ibm-everest.dtb: pca9552@60: 'led@10', 'led@11', 'le=
d@12', 'led@13' do not match any of the regexes: '^led@[0-9a-f]$', 'pinctrl=
-[0-9]+'
    +       from schema $id: http://devicetree.org/schemas/leds/nxp,pca955x=
.yaml#

Can you please send a follow-up patch resolving those and any similar
warnings for Fuji?

Thanks

Andrew

