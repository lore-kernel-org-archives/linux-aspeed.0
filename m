Return-Path: <linux-aspeed+bounces-76-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA09D1CA0C
	for <linux-aspeed@archiver.kernel.org>; Tue,  5 Nov 2024 00:09:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xj7xj6CP6z2y71;
	Tue,  5 Nov 2024 11:09:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730765385;
	cv=none; b=SRhknhYY5/+O2mOCZxnD2oa/69/Lq+KgFmPOltbfphBZwrB8//NoVSZkW7Bo5L0BFv2GzR3GABCVe6Tq2M6TsuKdALTdQPm5OhqWuYjirzznE6dnw/RHifSAAd86cWOqqDzVTCDJ7ifdYJdqh3KgeLtNdPHj7sYlFJgiOD40bdELNGqkzi4IqOlxNmWwUbyqQMiL7Ip/VzN3w72d1rCjMJChNEKZKw+HiXEm5cjZKw1xd5LVooVP8BXJUHT0eBPUadsIZPsHr4qvRWaVB+5U/dZiYcPq1ZaH1IYez2KhT0TYISDKSudixD9b4jqeoBoXFgAKvnn7OKu3intHgGLXcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730765385; c=relaxed/relaxed;
	bh=IjJLJ70mG0yXKyq0C8oBtomjbMZt3HhC5EaMaSbO7Kc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LV+dYdMDP7gszG8LuPERKm3PhYKroIfewqXueaOkqM9piklH0iomJ2cJaVuHNRe/cRZeTRyn52Iul/JDEhR1OFIoUAPyEjRQY0WnYcS1xLs6SVCL5sbvMD5da0PpOnezlVxpAVTH0UVoQbjuaw8OntaUwnchSP1OUdMKtSgA+KZB5Bs2n65fn0UlBfCXXYlv8G5OOYQLpXH1U3qCN6ovyAkxGDBV4ir0rSg9C6YmNZZk7UFR6ChWbUHvG5L8Hyj9As4PiXMUsDa8T8CdEUOB32wuvAXMqUo0Rlq53iNqb72uaTzXcXQoEw+ha8rPj5Dbko+nGZ16VxqYkG82hjH7ng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=bVLQHcMF; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=bVLQHcMF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xj7xg5Lgnz2xgQ
	for <linux-aspeed@lists.ozlabs.org>; Tue,  5 Nov 2024 11:09:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1730765380;
	bh=IjJLJ70mG0yXKyq0C8oBtomjbMZt3HhC5EaMaSbO7Kc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bVLQHcMFG/lHwHLYBE5Jjz6Tdn/3U3MOp0kh+E16OhOzKDp4U5iBeRw+YCXQWWsPk
	 7zO0yZRvC6R41KdPVVPEKAse4f0sMISbIj/SkCke5jX+bGooxZyzdEgddI7a8ALRzU
	 3UX8aSdti7p9Ps81L/CfvzW5fiwVr30b7zbLCG0ryn35jwPSCIm8StIVEtCc8APgYU
	 WBV95ajz/U5JmouPbpAHluo3zqSiUpDCBjPLTOYUxRULkt1Z/YyXEJLapN1Fo9Hab0
	 s9/m3iigWtirVGX0y6IbySRHrbFYUehpwHA2OCRh7dQVbA1W3zozjclUefuqshUh3t
	 3GefuGksYuy2w==
Received: from [192.168.68.112] (ppp118-210-162-114.adl-adc-lon-bras34.tpg.internode.on.net [118.210.162.114])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9758C6A3C9;
	Tue,  5 Nov 2024 08:09:37 +0800 (AWST)
Message-ID: <f468a5c0a0112cee35815fb6c7b7f9933934adc2.camel@codeconstruct.com.au>
Subject: Re: [PATCH v6 1/2] dt-bindings: arm: aspeed: add IBM SBP1 board
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Conor Dooley <conor@kernel.org>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: Naresh Solanki <naresh.solanki@9elements.com>, jdelvare@suse.com, Conor
 Dooley <conor.dooley@microchip.com>, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 krzk+dt@kernel.org,  sylv@sylv.io, linux-arm-kernel@lists.infradead.org,
 linux-hwmon@vger.kernel.org,  linux@roeck-us.net, Joel Stanley
 <joel@jms.id.au>, conor+dt@kernel.org
Date: Tue, 05 Nov 2024 10:39:34 +1030
In-Reply-To: <20241104-saturate-device-d020a0d7321f@spud>
References: <20241104092220.2268805-1-naresh.solanki@9elements.com>
	 <173072771091.3690717.11563964377469449295.robh@kernel.org>
	 <20241104-saturate-device-d020a0d7321f@spud>
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

Hi Conor,

On Mon, 2024-11-04 at 18:49 +0000, Conor Dooley wrote:
> On Mon, Nov 04, 2024 at 08:39:21AM -0600, Rob Herring (Arm) wrote:
> >=20
> > On Mon, 04 Nov 2024 14:52:14 +0530, Naresh Solanki wrote:
> > > Document the new compatibles used on IBM SBP1.
> > >=20
> > > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > ---
> > > Changes in V4:
> > > - Retain Acked-by from v2.
> > > - Fix alphabetic order
> > > ---
> > > =C2=A0Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
> > > =C2=A01 file changed, 1 insertion(+)
> > >=20
> >=20
> >=20
> > My bot found new DTB warnings on the .dts files added or changed in
> > this
> > series.
> >=20
> > Some warnings may be from an existing SoC .dtsi. Or perhaps the
> > warnings
> > are fixed by another series. Ultimately, it is up to the platform
> > maintainer whether these warnings are acceptable or not. No need to
> > reply
> > unless the platform maintainer has comments.
> >=20
> > If you already ran DT checks and didn't see these error(s), then
> > make sure dt-schema is up to date:
> >=20
> > =C2=A0 pip3 install dtschema --upgrade
> >=20
> >=20
> > New warnings running 'make CHECK_DTBS=3Dy aspeed/aspeed-bmc-ibm-
> > sbp1.dtb' for
> > 20241104092220.2268805-1-naresh.solanki@9elements.com:
>=20
> Really? This many warnings on a v6?
>=20

I understand that it's surprising and disappointing, however these
warnings are from the Aspeed DTSIs and not directly from the proposed
DTS. Many are an artefact of history, and I'm (slowly) working to clean
them up. Recently I haven't had any time to dedicate to that effort,
and as I'm somewhat responsible for the state of things, I'm not
prepared to block other people's patches and push my own
responsibilities onto them.

I've been replying to those proposing new Aspeed-based devicetrees to
separate the warnings they're introducing from the warnings that
already exist, and requiring them to fix the issues they're responsible
for. I hope that I'll have time to continue to improve the situation,
as this is obviously a tedious task for me too.=20

Andrew

> >=20
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: timer: 'clocks'
> > does not match any of the regexes: 'pinctrl-[0-9]+'
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id:
> > http://devicetree.org/schemas/timer/arm,arch_timer.yaml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: /sdram@1e6e0000:
> > failed to match any schema with compatible: ['aspeed,ast2600-sdram-
> > edac', 'syscon']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: bus@1e600000:
> > compatible: ['aspeed,ast2600-ahbc', 'syscon'] is too long
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id:
> > http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.yaml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: syscon@1e6e2000:
> > 'smp-memram@180' does not match any of the regexes: '^interrupt-
> > controller@[0-9a-f]+$', '^p2a-control@[0-9a-f]+$', '^pinctrl(@[0-
> > 9a-f]+)?$', '^silicon-id@[0-9a-f]+$', 'pinctrl-[0-9]+'
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id:
> > http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.yaml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb:
> > /ahb/apb@1e6e0000/syscon@1e6e2000/smp-memram@180: failed to match
> > any schema with compatible: ['aspeed,ast2600-smpmem']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb:
> > /ahb/apb@1e6e0000/syscon@1e6e2000/interrupt-controller@560: failed
> > to match any schema with compatible: ['aspeed,ast2600-scu-ic0']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb:
> > /ahb/apb@1e6e0000/syscon@1e6e2000/interrupt-controller@570: failed
> > to match any schema with compatible: ['aspeed,ast2600-scu-ic1']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb:
> > /ahb/apb@1e6e0000/display@1e6e6000: failed to match any schema with
> > compatible: ['aspeed,ast2600-gfx', 'syscon']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: adc@1e6e9000:
> > 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id:
> > http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: adc@1e6e9100:
> > 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id:
> > http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: crypto@1e6fa000:
> > 'aspeed,ahbc' does not match any of the regexes: 'pinctrl-[0-9]+'
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id:
> > http://devicetree.org/schemas/crypto/aspeed,ast2600-acry.yaml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb:
> > /ahb/video@1e700000: failed to match any schema with compatible:
> > ['aspeed,ast2600-video-engine']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: sdc@1e740000:
> > sdhci@1e740100:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too
> > long
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id:
> > http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: sdc@1e740000:
> > sdhci@1e740200:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too
> > long
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id:
> > http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb:
> > /ahb/sdc@1e740000/sdhci@1e740100: failed to match any schema with
> > compatible: ['aspeed,ast2600-sdhci', 'sdhci']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb:
> > /ahb/sdc@1e740000/sdhci@1e740200: failed to match any schema with
> > compatible: ['aspeed,ast2600-sdhci', 'sdhci']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb:
> > /ahb/apb@1e780000/timer@1e782000: failed to match any schema with
> > compatible: ['aspeed,ast2600-timer']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: lpc@1e789000:
> > lpc-snoop@80: 'clocks' does not match any of the regexes: 'pinctrl-
> > [0-9]+'
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id:
> > http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: lpc@1e789000:
> > reg-io-width: 4 is not of type 'object'
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id:
> > http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: kcs@24: 'clocks'
> > does not match any of the regexes: 'pinctrl-[0-9]+'
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id:
> > http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: kcs@28: 'clocks'
> > does not match any of the regexes: 'pinctrl-[0-9]+'
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id:
> > http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: kcs@2c: 'clocks'
> > does not match any of the regexes: 'pinctrl-[0-9]+'
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id:
> > http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: kcs@114: 'clocks'
> > does not match any of the regexes: 'pinctrl-[0-9]+'
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id:
> > http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb:
> > /ahb/apb@1e780000/lpc@1e789000/lhc@a0: failed to match any schema
> > with compatible: ['aspeed,ast2600-lhc']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb:
> > /ahb/apb@1e780000/lpc@1e789000/ibt@140: failed to match any schema
> > with compatible: ['aspeed,ast2600-ibt-bmc']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb:
> > /ahb/apb@1e780000/bus@1e78a000/i2c@280/bmc-slave@10: failed to
> > match any schema with compatible: ['ipmb-dev']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: fsi@1e79b000:
> > compatible: ['aspeed,ast2600-fsi-master', 'fsi-master'] is too long
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id:
> > http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb:
> > /ahb/apb@1e790000/fsi@1e79b000: failed to match any schema with
> > compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: fsi@1e79b100:
> > compatible: ['aspeed,ast2600-fsi-master', 'fsi-master'] is too long
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id:
> > http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb:
> > /ahb/apb@1e790000/fsi@1e79b100: failed to match any schema with
> > compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
> > arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb:
> > /ahb/apb@1e790000/dma-controller@1e79e000: failed to match any
> > schema with compatible: ['aspeed,ast2600-udma']
> >=20
> >=20
> >=20
> >=20
> >=20


