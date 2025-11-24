Return-Path: <linux-aspeed+bounces-2981-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931FBCFA466
	for <linux-aspeed@archiver.kernel.org>; Mon, 24 Nov 2025 04:44:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dFCsM16Csz2yvN;
	Mon, 24 Nov 2025 15:44:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763959463;
	cv=none; b=Blj0iLC7RphTo0VlH7FWtn5l2395LzQJoWY4R3l5V9vhbNYkewlLwh+wCGCyM831Nq00bRt/gHEDS10HKxRNd6NEYAivXdDtfLuQyQQhm2oqKdKY/HnVghmOv8oqzZS03DmziXTrnzSe9aX2rs8wM/AGgrhaYiYiRhhmOZB6TP+uMgEVjl4FgbI7XCRtBY6szpi+C8tzC/Oa0QW7YfisUas3tbAlxYD2zooloUu7Rx6RXP2pN2sPneKjZWLrVK9ypq0UMXR5FV8RookmZ5jIcHZmWF3JOSrYA6hGdRILRII7e18Sg3F0Rz4uHCQqGXKXoM47NZHRqzfr7xDf2lvkzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763959463; c=relaxed/relaxed;
	bh=ErEcB/qyD7QsiTGNF9CSiehZrNAUsr2NNSV13bbmFB8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kU+Ov4o/Zf9nGtM2i71ITGw7ErXQ+skVB/R+pRZ6MKybnCifxrw0qHrAOx4slSI0Cta3R2mUr+IEi++gCBcjt1g7NsouH3br1nZPlv7cKl0ZV0+udVjvYdoMCkEK3RGkpVH94UHGq6y7UXdKsV8fKox8Mpy2e+kntUyYcDrgfBQyYftBMYnUe+2h87ROGCLCpmUV8qLe0UBhrs5xgtjTBSV7hC4aMUqMELKyxR0XfGsBeRxDt/h2jFrQT3/CrCnrJVGlHfPya4hyZNUdKMCRGf757wqxrj/10FRTaHoMu7bfNzoRAxd9t+s3Ijddam9JxqeEURLeAQO7rDB5DzSN4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=NfOkLKJ9; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=NfOkLKJ9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dFCsL4n78z2xQD
	for <linux-aspeed@lists.ozlabs.org>; Mon, 24 Nov 2025 15:44:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1763959462;
	bh=ErEcB/qyD7QsiTGNF9CSiehZrNAUsr2NNSV13bbmFB8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NfOkLKJ9+KaqsHnZz4BA472PHttN4fhTp0lzqpmLD3f2LiHNL0a8eBA7jU2bGuhve
	 77H0vsNtq3RC/SLBwwshj+HzzPieq17dlfn57Ddq0MOcxfAB6Fxf92PhUdXw3oi7y7
	 BOqrossQs9ah0Xgf4hCTzzDqZdu4S+ExzENq88OjAvmdeg1HVcBnQhFi/R62PVeDjw
	 I5whS1LNAETonXmmeheD+8nNmi+U+rpKDRpjf8KPpsiCv9sAoSMNACLnUhD0AWcd7D
	 qtvSKPGNkPEi9qT31pTBLbKv+B2kpbtLiSlzvXelDDVL+Cy30LhpNop+cxhOiJ61W+
	 pHKlgP20xTFfw==
Received: from [192.168.68.115] (unknown [180.150.112.38])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 75BD97BE0E;
	Mon, 24 Nov 2025 12:44:21 +0800 (AWST)
Message-ID: <74b9c09cebac1de0e6e2e712a1374ab5294f61d8.camel@codeconstruct.com.au>
Subject: Re: [PATCH 3/3] ARM: dts: aspeed: yosemite5: Rename sgpio
 P0_I3C_APML_ALERT_L
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Kevin Tung <kevin.tung.openbmc@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Amithash
 Prasasd	 <amithash@meta.com>, Kevin Tung <Kevin.Tung@quantatw.com>, Ken
 Chen	 <Ken.Chen@quantatw.com>, Leo Yang <Leo-Yang@quantatw.com>, Rob
 Herring	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley	 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Date: Mon, 24 Nov 2025 15:14:21 +1030
In-Reply-To: <20251118-yv5_revise_dts-v1-3-fcd6b44b4497@gmail.com>
References: <20251118-yv5_revise_dts-v1-0-fcd6b44b4497@gmail.com>
	 <20251118-yv5_revise_dts-v1-3-fcd6b44b4497@gmail.com>
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

On Tue, 2025-11-18 at 18:53 +0800, Kevin Tung wrote:
> Rename P0_I3C_APML_ALERT_L to FM_APML_CPU_ALERT_N for clarity.

Are user space components looking for these names? Will updating the
devicetree break older applications? I'd like to see more discussion of
these problems in the commit message.

Cheers,

Andrew

>=20
> Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
> ---
> =C2=A0arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts b=
/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
> index 45b8ac2e8c65a4f672e64571631b7f6944f26213..060757b7211a6da777c51d9f0=
c886796cf2450a4 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
> @@ -964,7 +964,7 @@ &sgpiom0 {
> =C2=A0	"FAULT_P3V3_NIC_N","",
> =C2=A0	"FAULT_P12V_NIC_N","",
> =C2=A0	"FAULT_P12V_SCM_N","",
> -	"P0_I3C_APML_ALERT_L","",
> +	"FM_APML_CPU_ALERT_N","",
> =C2=A0	"ALERT_INLET_TEMP_N","",
> =C2=A0	"FM_CPU_PROCHOT_R_N","",
> =C2=A0	"FM_CPU_THERMTRIP_N","",

