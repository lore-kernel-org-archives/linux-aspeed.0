Return-Path: <linux-aspeed+bounces-827-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61441C021B2
	for <linux-aspeed@archiver.kernel.org>; Tue, 25 Feb 2025 04:34:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z24Wj0K24z2yvv;
	Tue, 25 Feb 2025 15:34:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740458080;
	cv=none; b=KUtEhKEAhEffMqc3OUID21+M7baBV4ppkIkVvc1ZIjAMRlOx+LtbuXf5T7pOuycaCv8Sven4Pmi/Mbunl4lEOq6Fdmd8qarW6mcI8lePp7ZNiMGGUblZEbxzFLKlt8s2j7kCj1ETGnGVk+KXDYoLwcyxTPz6Pz/UhN3vs7jEgaXFuu2fwNB29h3T4QhfQ4Rpk7yaF75UvyQqoBHLA3RKOR2GP9q7nJHqVqGabZE0PDEitGauJ0x7lE+7gSbZSIVC5PgF4HRKuWFzkPq1StOOVPgX6chxi3hAg+rWShcqfAbyzhBSicHJHxaU4rfMWe39N+tb+6Q8XwIZQENpsWzaWA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740458080; c=relaxed/relaxed;
	bh=hA7l65NXvsJflq/93AYWgxASOiOOSnSvYF4RagQIqR0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RNXnxXq3LMHPfqxKhunTaXLC3dppRe5b3YtJEcMQ7fBrjhqBpRl6e1KlcYhT/IxzEkJwGZdoxEuBI0UGdv+n7AbUlTHFmwwqcbDRDx4Xa/3RJ4gHby6UE194HkgxBiH7e+uhp/tQw/s/stwPOOh7WZejssm3Mzfs2hIgQne7HhNNKFn23hXvxEbEXLrClkCrM/Hz5xopeP6887am65CWqqeo7YsKV95wkXWbqFwpNckOtpOo0a+ONqqAyUisSsntZ1gsg9g5YrQ+TxyPOIcJmENGd6PyOfDaPISkK5tWGFMOIQ4lgGkGqWQUr4MMgAIrYErNxa43ZoPVUpRZ7LLjwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=HphCKdV8; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=HphCKdV8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z24Wh38hmz2yF4
	for <linux-aspeed@lists.ozlabs.org>; Tue, 25 Feb 2025 15:34:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1740458079;
	bh=hA7l65NXvsJflq/93AYWgxASOiOOSnSvYF4RagQIqR0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HphCKdV8WVe19zcmS4c1BmTEEehUUuZWBdq10ExtlLzTKVdA0lajrHqa5rOydTwVE
	 hIZ1/w5Lg+u2ijJ4XM7jMdfbqbCwxkCvmakmfBl7C5J4YYWrMiH/IZ5BRaDR/1PIVq
	 cD0nnVTfIWs2Xch8/3stbNPnC8u1Yd1daCy/nTvzHXgboj7Sp9zrg2wf2TIOROxkz/
	 p7tQeZsmxDv+/KxQojQMmaXo0zLGlI8lEE61DLKWlSLnVdoMehKy2OIbfElfvnMSmQ
	 XL86iKutpkFQD5Nosp0gmMbyQ2jBJKVFdfKjEGWlyF5uXIvkoF+vUtxRinWm1TLJe6
	 /dowIIidh8+TA==
Received: from [IPv6:2405:6e00:2421:8fa3:333c:2fc8:332d:ddb4] (unknown [120.20.122.15])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 95D9370B52;
	Tue, 25 Feb 2025 12:34:38 +0800 (AWST)
Message-ID: <52f6f6fc93144b6bd93870e9ef054da19d809b05.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 0/3] ARM: dts: aspeed: Add Balcones system
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Eddie James <eajames@linux.ibm.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, krzk+dt@kernel.org, 
 devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
 conor+dt@kernel.org
Date: Tue, 25 Feb 2025 15:04:37 +1030
In-Reply-To: <174015998324.3469672.1009055817022487781.robh@kernel.org>
References: <20250220205948.1777200-1-eajames@linux.ibm.com>
	 <174015998324.3469672.1009055817022487781.robh@kernel.org>
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

On Fri, 2025-02-21 at 12:11 -0600, Rob Herring (Arm) wrote:
>=20
> On Thu, 20 Feb 2025 14:59:45 -0600, Eddie James wrote:
> > The Balcones system is similar to Bonnell but with a POWER11 processor.
> >=20
> > Changes since v1:
> > =C2=A0- Add all the ucd9000 driver supported compatible strings
> > =C2=A0- Fix node ordering in Balcones device tree
> > =C2=A0- Improve commit message to explain addition of ibm-power11-dual.=
dtsi
> >=20
> > Eddie James (3):
> > =C2=A0 dt-bindings: arm: aspeed: add IBM Balcones board
> > =C2=A0 dt-bindings: hwmon: ucd90320: Add additional compatible strings
> > =C2=A0 ARM: dts: aspeed: Add Balcones system
> >=20
> > =C2=A0.../bindings/arm/aspeed/aspeed.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > =C2=A0.../bindings/hwmon/pmbus/ti,ucd90320.yaml=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 6 +
> > =C2=A0arch/arm/boot/dts/aspeed/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > =C2=A0.../dts/aspeed/aspeed-bmc-ibm-balcones.dts=C2=A0=C2=A0=C2=A0 | 59=
4 +++++++++++++
> > =C2=A0.../arm/boot/dts/aspeed/ibm-power11-dual.dtsi | 779 +++++++++++++=
+++++
> > =C2=A0.../arm/boot/dts/aspeed/ibm-power11-quad.dtsi | 769 +------------=
----
> > =C2=A06 files changed, 1383 insertions(+), 767 deletions(-)
> > =C2=A0create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcon=
es.dts
> > =C2=A0create mode 100644 arch/arm/boot/dts/aspeed/ibm-power11-dual.dtsi
> >=20
> > --
> > 2.43.5
> >=20
> >=20
> >=20
>=20
>=20
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
>=20

...

> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: gpio@1e780000: 'usb=
-power-hog' does not match any of the regexes: 'pinctrl-[0-9]+'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id: http://d=
evicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#

Ah, can you address this one?

> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: /ahb/apb/bus@1e78a0=
00/i2c@400/pwm@53: failed to match any schema with compatible: ['maxim,max3=
1785a']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: pressure-sensor@76:=
 '#io-channel-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id: http://d=
evicetree.org/schemas/trivial-devices.yaml#

And these also?

The rest looked like the usual noise.

Andrew

