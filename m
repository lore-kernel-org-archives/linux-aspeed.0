Return-Path: <linux-aspeed+bounces-4530-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8647C44536
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Jul 2026 12:07:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4tKc35q0z2xnK;
	Wed, 22 Jul 2026 22:07:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784722036;
	cv=none; b=iB1dc1p2IQYt+UrlBx0WI85Er9bVdLgzfkusl2HD5o7wQyoc2csIfULBJCPTtnDgbAptFxAP7x8ZoQih6P8RN+Zpz5VK9GXOhnjQEcSPdzkZ8DZiB0OlMCs0ll0LirG62NCh0SsyVT/0DZi6YES9XaOviheJvEv/FBPvAjmep3+5pMF2dG94+hWHX6qs2Dilr+AZnll2Vi+qp6TKOsNlOBHTfyf9C+9reBQFtCa0YL1FwYX+sNatpbbc7IWwv7DOmihF4u2GaD+e//HHWFGazc3GgnHl1JaPDKFwaQCoS9HKy5kVWhyxec8cuKC4g1XzTmJtapRbqd//OkP/LRwLvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784722036; c=relaxed/relaxed;
	bh=4g4coC2IuMxL3aYFyteOm3c4yfrMMiVwCHmdodsx/Qo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Li7zhnXiPEGDALOoSAAtXC1Kpdy+SEk6q81OPOqbrKZQWOnHGJ77pkRIINGyki6a5bmY+olzkhoHvS1DlgQ+5cJ486FHky1atHeXRrD/AUug6jr2P8wTtVOLnlGENLjXcDp/HDLG9UhwduDnvI2X702sBn4IGasGSTjrITavviB/CNtTFWVMhK+aGdRewv8+60FM5aRtvhdUwPwopsb+vWGAAYWWMbJMCYB1nQdQrEP9zR1TVFl9m/uPK1M1FvONne8f+LneckjDFdEbCe20Lw3fSIjJA9ug1GnEAV2UCZMXlw9nS4dm8oDSmGS3S9heUoDnSFtYho9PLilpO5n9Mg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=XR/mvfMp; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=XR/mvfMp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4tKb4wkPz2xJT
	for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Jul 2026 22:07:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1784722034;
	bh=4g4coC2IuMxL3aYFyteOm3c4yfrMMiVwCHmdodsx/Qo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XR/mvfMpKCG8tmi7pzG43sBGfvGNOaGpo9M2PY/Jcv3U75dFMchC+rlKSmXi6PhSJ
	 M4KoIjsMDaXmz8Wbj5MWoUX3rViUcKK0RafgyCrZrbqM08GyyPXPdxqxV8x2yFbjzH
	 VeMQeChy5advnbHSjAg02Zvi/hNdeVql/W/+q3qvf+XP/LkAznuexaIQOitO2b8aju
	 UvqaF4UWs3JNzF+cJJJ84YuEKo8FkM2f4io65cLQfM3ucx5XvEwdAiB8BFO5lGdvmU
	 dr6h0bZlff2Ey3/k752UzEXhV3xtnncVUYBSVH5SZN345tkjHRCNE+kleFDK4WKagk
	 a4qz4RzHMLf+Q==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id EA69A662E1;
	Wed, 22 Jul 2026 20:07:13 +0800 (AWST)
Message-ID: <831a8c9b383d3e765a49fa35e1e36d75504fee1d.camel@codeconstruct.com.au>
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: sanmiguel: add current-range
 property for PDB HSC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Mike Hsieh <mike.quanta.115@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>, Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Cosmo Chou
	 <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, Mik Lin
	 <mik.lin@quantatw.com>, Mike Hsieh <Mike_Hsieh@quantatw.com>
Date: Wed, 22 Jul 2026 21:37:13 +0930
In-Reply-To: <20260618-sanmiguel-dts-config-hsc-lm5066i-v1-2-cccf959c9b78@gmail.com>
References: 
	<20260618-sanmiguel-dts-config-hsc-lm5066i-v1-0-cccf959c9b78@gmail.com>
	 <20260618-sanmiguel-dts-config-hsc-lm5066i-v1-2-cccf959c9b78@gmail.com>
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

On Thu, 2026-06-18 at 15:41 +0800, Mike Hsieh wrote:
> Configure the ti,current-range property for the four TI LM5066i
> hot-swap controllers on PDB board.
>=20
> This defines the hardware current limit operating mode (low/high)
> for each sensor to match the physical board design.
>=20
> Specific configurations:
> - HSC1 (0x11): low
> - HSC2 (0x13): high
> - HSC3 (0x15): high
> - HSC4 (0x17): low
>=20
> Signed-off-by: Mike Hsieh <mike.quanta.115@gmail.com>
> ---
> =C2=A0arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts | 4 ++++
> =C2=A01 file changed, 4 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts b=
/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts
> index 3faac0925a79..e518e3fc1c97 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts
> @@ -451,6 +451,7 @@ pdb_ti_hsc1: power-monitor@11 {
> =C2=A0		compatible =3D "ti,lm5066i";
> =C2=A0		reg =3D <0x11>;
> =C2=A0		shunt-resistor-micro-ohms =3D <1000>;
> +		ti,current-range =3D "low";
> =C2=A0	};
> =C2=A0
> =C2=A0	pdb_mps_hsc2: power-monitor@12 {
> @@ -462,6 +463,7 @@ pdb_ti_hsc2: power-monitor@13 {
> =C2=A0		compatible =3D "ti,lm5066i";
> =C2=A0		reg =3D <0x13>;
> =C2=A0		shunt-resistor-micro-ohms =3D <321>;
> +		ti,current-range =3D "high";
> =C2=A0	};
> =C2=A0
> =C2=A0	pdb_mps_hsc3: power-monitor@14 {
> @@ -473,6 +475,7 @@ pdb_ti_hsc3: power-monitor@15 {
> =C2=A0		compatible =3D "ti,lm5066i";
> =C2=A0		reg =3D <0x15>;
> =C2=A0		shunt-resistor-micro-ohms =3D <321>;
> +		ti,current-range =3D "high";
> =C2=A0	};
> =C2=A0
> =C2=A0	pdb_mps_hsc4: power-monitor@16 {
> @@ -484,6 +487,7 @@ pdb_ti_hsc4: power-monitor@17 {
> =C2=A0		compatible =3D "ti,lm5066i";
> =C2=A0		reg =3D <0x17>;
> =C2=A0		shunt-resistor-micro-ohms =3D <500>;
> +		ti,current-range =3D "low";
> =C2=A0	};
> =C2=A0
> =C2=A0	pdb_ioexp_20: gpio@20 {

The property isn't inspected by the associated driver, nor is it
allowed by the binding:

   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dtb: power-monito=
r@11 (ti,lm5066i): Unevaluated properties are not allowed ('ti,current-rang=
e' was unexpected)
           from schema $id: http://devicetree.org/schemas/hwmon/pmbus/ti,lm=
25066.yaml
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dtb: power-monito=
r@13 (ti,lm5066i): Unevaluated properties are not allowed ('ti,current-rang=
e' was unexpected)
           from schema $id: http://devicetree.org/schemas/hwmon/pmbus/ti,lm=
25066.yaml
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dtb: power-monito=
r@15 (ti,lm5066i): Unevaluated properties are not allowed ('ti,current-rang=
e' was unexpected)
           from schema $id: http://devicetree.org/schemas/hwmon/pmbus/ti,lm=
25066.yaml
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dtb: power-monito=
r@17 (ti,lm5066i): Unevaluated properties are not allowed ('ti,current-rang=
e' was unexpected)
           from schema $id: http://devicetree.org/schemas/hwmon/pmbus/ti,lm=
25066.yaml

Andrew

