Return-Path: <linux-aspeed+bounces-2330-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA25CAC5A5
	for <linux-aspeed@archiver.kernel.org>; Wed, 24 Sep 2025 01:58:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cWg4V5Mwxz2yDr;
	Wed, 24 Sep 2025 11:58:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758679130;
	cv=none; b=k4s+TtZDtCONbKojiQJlVqS/F3oDkjHjP1oy7qG5Q8ti5sNv/ZC2cyqVy2Kg6AX6/Y40TJBvs/uUaf/OFCqpbhBIXY2noB3VPv2zKX+0VeWqb56vS4qgvVBfFETgQlOQ7cuV04XLZQ1vlTwEZtM4gZkqkIft5yt2P8viVVk+FwoN0+5ry0a//KwTM3VseVM55ZR4DXcZoCGXYTcIi8fokOjBT8sjceMhyhyt0qBbpClnApcBEDsT1YLQO3PBGqa58viPUq9GaixpyBW2ewjrXPz2fgNkakIZtEtMOgPsAh/+iOsNBA6ILyQJvCgUKXz4kQC0QagdR7pL8h0WI7KLUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758679130; c=relaxed/relaxed;
	bh=6aTsBsG3b0stGVUU3MEZdAy7klaOCIs/53nUSWSvKzs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GigLTWnbrr+IlWZJGcAI2VBN/FtQh7eQG6TKq2YA0/+Ck68LdhT27jxooFdl2WvONW/gSopLM+DmQqZUmHopDC0B9VBTUaLePPTIFn2+4VBarmyZq8PAO7vbyx12Cgmp3zwFZ4445qJQ5O9lPUmFwIUOMLmCDy/Wly6Y3fl24G13ca7T3v33mCfST+HSA3omDT7f5WMRk4PNO4pw61QnE5L35ZH1fMluXJf0Kv1MsFN09+4qBQ48A/FdWCKY4kaPxVlM/Mr3DhYTgZmVBuxRpdGqHAEONgZJvqUubE7KRbK3dWY41g9ySPXJ+XxBvnFnW8KWt5Lk32WxEJ4KHBeOgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=aup8ujOg; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=aup8ujOg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cWg4T3hg4z2xnk
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Sep 2025 11:58:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1758679127;
	bh=6aTsBsG3b0stGVUU3MEZdAy7klaOCIs/53nUSWSvKzs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aup8ujOgSj/tebaHKpzgUVZXqYRu+3zaYauaxooNC9jEP6uu7nz8yhZdMa19xEJcJ
	 98JW49+VdRenKr1ok13J+k/6gPdVHD7YEMPtOOmILnppIgnTJSCeV8GCb0jjE7T9CV
	 IN0K/eGxkqsC3dFDYRJJTPC7zipVDXUEHsiyQUBp/p0d+k2fKPopKk5gDV6AjsWEuC
	 2ORJdOpZr2PQajFzMwFKM+VKKmChXg+Ie7+GbzQVHgr0JDBQ87ldx1JevgxwkyQqzX
	 Bm9KkmjEyLrQjjcm+r4wIzCKn8x/lz6317TR24RzgrHMLfGoG/U3kWeqmfDxIQ9HSo
	 nvTqGTK6t0dxA==
Received: from [IPv6:2405:6e00:243d:a853:dbe5:4849:b82e:5665] (unknown [120.20.205.123])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id EA720647A7;
	Wed, 24 Sep 2025 09:58:44 +0800 (AWST)
Message-ID: <3c310312cc401bbec13b0935e7b0a83284efdcc5.camel@codeconstruct.com.au>
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: add asrock x470d4u bmc
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Tan Siewert <tan@siewert.io>, Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,  Joel Stanley <joel@jms.id.au>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Wed, 24 Sep 2025 11:28:37 +0930
In-Reply-To: <0c7a28b7-8d6d-4f91-ac6c-8cf37e128139@siewert.io>
References: <20250919185621.6647-1-tan@siewert.io>
	 <20250919185621.6647-3-tan@siewert.io>
	 <20250922200738.GA1124791-robh@kernel.org>
	 <0c7a28b7-8d6d-4f91-ac6c-8cf37e128139@siewert.io>
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

On Tue, 2025-09-23 at 16:48 +0200, Tan Siewert wrote:
> On 22.09.25 22:07, Rob Herring wrote:
> > On Fri, Sep 19, 2025 at 08:56:18PM +0200, Tan Siewert wrote:

*snip*

> > > +/ {
> > > +	model =3D "Asrock Rack X470D4U-series BMC";
> > > +	compatible =3D "asrock,x470d4u-bmc", "aspeed,ast2500";
> > > +
> > > +	aliases {
> > > +		serial4 =3D &uart5;
> > > +	};
> > > +
> > > +	chosen {
> > > +		stdout-path =3D &uart5;
> > > +	};
> > > +
> > > +	iio-hwmon {
> > > +		compatible =3D "iio-hwmon";
> > > +		io-channels =3D <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>, <&adc 4>,
> > > +			<&adc 5>, <&adc 6>, <&adc 7>, <&adc 8>, <&adc 9>,
> > > +			<&adc 10>, <&adc 11>, <&adc 12>;
> > > +	};
> > > +
> > > +	leds {
> > > +		compatible =3D "gpio-leds";
> > > +
> > > +		heartbeat {
> >=20
> > led-0
>=20
> I guess `led-heartbeat` would be fine too, right?
>=20
> >=20
> > This should have given you a warning. You did run "make dtbs_check"
> > check the warnings, right?
>=20
> I did and there were no warnings, even after a full clean. The full=20
> command I ran before submitting was `make dtbs_check W=3D1=20
> DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/arm/aspeed/aspeed.yam=
l`

Ah, so that's probably unhelpful, as you're excluding all the other
schemas. Rather, try:

   make -j$(nproc) CHECK_DTBS=3Dy aspeed/aspeed-bmc-asrock-x470d4u.dtb

Running that on your series locally produces:

     SCHEMA  Documentation/devicetree/bindings/processed-schema.json
     HOSTLD  scripts/dtc/dtc
     DTC [C] arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dtb
   arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dtb: /ahb/apb/memory-=
controller@1e6e0000: failed to match any schema with compatible: ['aspeed,a=
st2500-sdram-edac']
   arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dtb: /ahb/apb/syscon@=
1e6e2000/p2a-control@2c: failed to match any schema with compatible: ['aspe=
ed,ast2500-p2a-ctrl']
   arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dtb: /ahb/apb/display=
@1e6e6000: failed to match any schema with compatible: ['aspeed,ast2500-gfx=
', 'syscon']
   arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dtb: /ahb/apb/timer@1=
e782000: failed to match any schema with compatible: ['aspeed,ast2400-timer=
']
   arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dtb: /ahb/apb/pwm-tac=
ho-controller@1e786000: failed to match any schema with compatible: ['aspee=
d,ast2500-pwm-tacho']
   /home/andrew/src/kernel.org/linux/origin/build.arm.aspeed_g5/arch/arm/bo=
ot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dtb: fan@1: aspeed,fan-tach-ch: b'\=
x01' is not of type 'object', 'integer', 'array', 'boolean', 'null'
           from schema $id: http://devicetree.org/schemas/dt-core.yaml#
   /home/andrew/src/kernel.org/linux/origin/build.arm.aspeed_g5/arch/arm/bo=
ot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dtb: fan@2: aspeed,fan-tach-ch: b'\=
x02' is not of type 'object', 'integer', 'array', 'boolean', 'null'
           from schema $id: http://devicetree.org/schemas/dt-core.yaml#
   /home/andrew/src/kernel.org/linux/origin/build.arm.aspeed_g5/arch/arm/bo=
ot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dtb: fan@3: aspeed,fan-tach-ch: b'\=
x03\x0b' is not of type 'object', 'integer', 'array', 'boolean', 'null'
           from schema $id: http://devicetree.org/schemas/dt-core.yaml#
   /home/andrew/src/kernel.org/linux/origin/build.arm.aspeed_g5/arch/arm/bo=
ot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dtb: fan@4: aspeed,fan-tach-ch: b'\=
x04\r' is not of type 'object', 'integer', 'array', 'boolean', 'null'
           from schema $id: http://devicetree.org/schemas/dt-core.yaml#
   /home/andrew/src/kernel.org/linux/origin/build.arm.aspeed_g5/arch/arm/bo=
ot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dtb: fan@5: aspeed,fan-tach-ch: b'\=
x05\x0e' is not of type 'object', 'integer', 'array', 'boolean', 'null'
           from schema $id: http://devicetree.org/schemas/dt-core.yaml#
   /home/andrew/src/kernel.org/linux/origin/build.arm.aspeed_g5/arch/arm/bo=
ot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dtb: lpc@1e789000 (aspeed,ast2500-l=
pc-v2): lpc-snoop@90: 'clocks' does not match any of the regexes: '^pinctrl=
-[0-9]+$'
           from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.ya=
ml#
   /home/andrew/src/kernel.org/linux/origin/build.arm.aspeed_g5/arch/arm/bo=
ot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dtb: kcs@24 (aspeed,ast2500-kcs-bmc=
-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
           from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast24=
00-kcs-bmc.yaml#
   /home/andrew/src/kernel.org/linux/origin/build.arm.aspeed_g5/arch/arm/bo=
ot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dtb: kcs@28 (aspeed,ast2500-kcs-bmc=
-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
           from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast24=
00-kcs-bmc.yaml#
   /home/andrew/src/kernel.org/linux/origin/build.arm.aspeed_g5/arch/arm/bo=
ot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dtb: kcs@2c (aspeed,ast2500-kcs-bmc=
-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
           from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast24=
00-kcs-bmc.yaml#
   /home/andrew/src/kernel.org/linux/origin/build.arm.aspeed_g5/arch/arm/bo=
ot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dtb: kcs@114 (aspeed,ast2500-kcs-bm=
c-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
           from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast24=
00-kcs-bmc.yaml#
   arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dtb: /ahb/apb/lpc@1e7=
89000/lhc@a0: failed to match any schema with compatible: ['aspeed,ast2500-=
lhc']
   arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dtb: /ahb/apb/lpc@1e7=
89000/ibt@140: failed to match any schema with compatible: ['aspeed,ast2500=
-ibt-bmc']
   /home/andrew/src/kernel.org/linux/origin/build.arm.aspeed_g5/arch/arm/bo=
ot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dtb: leds (gpio-leds): 'heartbeat',=
 'identify', 'systemfault' do not match any of the regexes: '(^led-[0-9a-f]=
$|led)', '^pinctrl-[0-9]+$'
           from schema $id: http://devicetree.org/schemas/leds/leds-gpio.ya=
ml#
  =20

Andrew

