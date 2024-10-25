Return-Path: <linux-aspeed+bounces-31-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47A4D1038E
	for <linux-aspeed@archiver.kernel.org>; Fri, 25 Oct 2024 00:08:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XZNRL6FGRz2yN3;
	Fri, 25 Oct 2024 11:08:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729814910;
	cv=none; b=BsUYB7qc97/1Do6OtaZPtSEqP6SEBBEQ1ZnUnyx4RTlp+Z80N9R2trGkAe3tEddewq12zesSZkVP6zjW/Bdj1MYAr/ssFxJFvbdmj3gfvAkKBPiCiBkKAFYFNGX9uzzU0nzAJnrgHxseG6lCGk6U5wus/S46YqGVetfhsvEW2OiQUuzYCL3mehBMhRjahExq1vqRmg+Om3klrFLxqB7e+iZy+NK5Q8+f1TigWKdE8bA6n0ydCqKvzd+RXAcn6qqIgVqZs9Io9IfAIunACkDjML/IDM+jVkg3EAwO72GNEciY4G3Ibq8P752ixgIqrGxMvyog3uTxZWw+hp5WdQombw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729814910; c=relaxed/relaxed;
	bh=DyDRu2d2LXSwr33hw3dE4eqSmypF32zZ6onJtYX/xyw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KOJjK8iSzsddYWorUYmh/KKEdbP3VEZ/sHbd+y1091feanXyEwRl4MWhiYwi2dTsPnIs7Ikmg0dX4e3KW7g49kOlR93ELuuVtxQzMN0J4NwSzCjWk3BVa/SIzTNwsVr95kTtyNIgIBG6NeGp+NT7qbRNNarDduHefQ61fnvxfHNH2PRYOjHY0I29Ub22zs7ueHVnROtqYWIWIDwKtWYj886hwk2gswfrT70GzUrNtOWsWsH8kL8yOjr+Jz4N+N+AAOsP6WregNq+ZnpWXunyNFRrnPFt4R3tXkcGBQAYw1MQ0zKpcTRn8KUh8BShiKvBUaZh6tSMPLuXPZIcWWln4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=nXsEEgHG; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=nXsEEgHG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XZNRJ6LSXz2yLg
	for <linux-aspeed@lists.ozlabs.org>; Fri, 25 Oct 2024 11:08:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1729814906;
	bh=DyDRu2d2LXSwr33hw3dE4eqSmypF32zZ6onJtYX/xyw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nXsEEgHGQElnKen9ggtsz3jVQPN+whxS4bNbRKgx3y0ecfBavbM6l1K46f91sO6HA
	 21RdOjbvpLYr1vUPAIjx7UPblll+7c4R4m0H70TpwAdGbLQ8JNScjoi36yHH9jl/mU
	 rkKUe4rApd2Tb0OSdIOfgmS2rSi1QF/EuBYP7pAZzB2nP+26TlgClJQ/Wo8XAsLAVa
	 X4X9RAROWnSwLV+4VFZro3K+RL++Z8knQJHc+pqUkD5NJEgV9ZBlIFdJGJmgKbVJtj
	 LyIUBliH9eJaCTHOCYDLyz/u2jfRXtvJv1rRVF81QvKr6B4rvIx185Yr+quMyEWRbE
	 x6vKMovKGdeHQ==
Received: from [192.168.68.112] (ppp118-210-190-208.adl-adc-lon-bras34.tpg.internode.on.net [118.210.190.208])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 2A396699DE;
	Fri, 25 Oct 2024 08:08:23 +0800 (AWST)
Message-ID: <a54cbc4c1f874f24d556b01004aecd1cabe00e56.camel@codeconstruct.com.au>
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: ventura: add Meta Ventura BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Jason-Hsu <jasonhell19@gmail.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, patrick@stwcx.xyz, 
	yang.chen@quantatw.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, jerry.lin@quantatw.com, joel@jms.id.au, 
	conor+dt@kernel.org, krzk+dt@kernel.org, linux-aspeed@lists.ozlabs.org, 
	devicetree@vger.kernel.org
Date: Fri, 25 Oct 2024 10:38:22 +1030
In-Reply-To: <172978739533.623426.6741150637312458347.robh@kernel.org>
References: <20241022021724.2322506-1-jasonhell19@gmail.com>
	 <172978739533.623426.6741150637312458347.robh@kernel.org>
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

Hi Jason,

On Thu, 2024-10-24 at 11:33 -0500, Rob Herring (Arm) wrote:
> On Tue, 22 Oct 2024 10:17:24 +0800, Jason-Hsu wrote:
> > Add Linux device tree related to Meta(Facebook) Ventura specific device=
s connected to BMC(AST2600) SoC.
> > Add subject prefix for the patch.
> >=20
> > Signed-off-by: Jason-Hsu <jasonhell19@gmail.com>
> > ---
> >  arch/arm/boot/dts/aspeed/Makefile             |   1 +
> >  .../aspeed/aspeed-bmc-facebook-ventura.dts    | 884 ++++++++++++++++++
> >  2 files changed, 885 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventur=
a.dts
> >=20
>=20
>=20
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
>=20
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
>=20
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
>=20
>   pip3 install dtschema --upgrade
>=20
>=20
> New warnings running 'make CHECK_DTBS=3Dy aspeed/aspeed-bmc-facebook-vent=
ura.dtb' for 20241022021724.2322506-1-jasonhell19@gmail.com:
>=20
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /: compatible: =
'oneOf' conditional failed, one must be fixed:
> 	'facebook,ventura-rmc' is not one of ['delta,ahe50dc-bmc', 'facebook,gal=
axy100-bmc', 'facebook,wedge100-bmc', 'facebook,wedge40-bmc', 'microsoft,ol=
ympus-bmc', 'quanta,q71l-bmc', 'tyan,palmetto-bmc', 'yadro,vesnin-bmc']
> 	'facebook,ventura-rmc' is not one of ['amd,daytonax-bmc', 'amd,ethanolx-=
bmc', 'ampere,mtjade-bmc', 'aspeed,ast2500-evb', 'asrock,e3c246d4i-bmc', 'a=
srock,e3c256d4i-bmc', 'asrock,romed8hm3-bmc', 'asrock,spc621d8hm3-bmc', 'as=
rock,x570d4u-bmc', 'bytedance,g220a-bmc', 'facebook,cmm-bmc', 'facebook,min=
ipack-bmc', 'facebook,tiogapass-bmc', 'facebook,yamp-bmc', 'facebook,yosemi=
tev2-bmc', 'facebook,wedge400-bmc', 'hxt,stardragon4800-rep2-bmc', 'ibm,mih=
awk-bmc', 'ibm,mowgli-bmc', 'ibm,romulus-bmc', 'ibm,swift-bmc', 'ibm,wither=
spoon-bmc', 'ingrasys,zaius-bmc', 'inspur,fp5280g2-bmc', 'inspur,nf5280m6-b=
mc', 'inspur,on5263m5-bmc', 'intel,s2600wf-bmc', 'inventec,lanyang-bmc', 'l=
enovo,hr630-bmc', 'lenovo,hr855xg2-bmc', 'portwell,neptune-bmc', 'qcom,cent=
riq2400-rep-bmc', 'supermicro,x11spi-bmc', 'tyan,s7106-bmc', 'tyan,s8036-bm=
c', 'yadro,nicole-bmc', 'yadro,vegman-n110-bmc', 'yadro,vegman-rx20-bmc', '=
yadro,vegman-sx20-bmc']
> 	'facebook,ventura-rmc' is not one of ['ampere,mtmitchell-bmc', 'aspeed,a=
st2600-evb', 'aspeed,ast2600-evb-a1', 'asus,x4tf-bmc', 'facebook,bletchley-=
bmc', 'facebook,catalina-bmc', 'facebook,cloudripper-bmc', 'facebook,elbert=
-bmc', 'facebook,fuji-bmc', 'facebook,greatlakes-bmc', 'facebook,harma-bmc'=
, 'facebook,minerva-cmc', 'facebook,yosemite4-bmc', 'ibm,blueridge-bmc', 'i=
bm,everest-bmc', 'ibm,fuji-bmc', 'ibm,rainier-bmc', 'ibm,system1-bmc', 'ibm=
,tacoma-bmc', 'inventec,starscream-bmc', 'inventec,transformer-bmc', 'jabil=
,rbp-bmc', 'qcom,dc-scm-v1-bmc', 'quanta,s6q-bmc', 'ufispace,ncplite-bmc']
> 	'aspeed,ast2400' was expected
> 	'aspeed,ast2500' was expected
> 	from schema $id: http://devicetree.org/schemas/arm/aspeed/aspeed.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /: failed to ma=
tch any schema with compatible: ['facebook,ventura-rmc', 'aspeed,ast2600']

You need to sort out your message threading issue so these warnings go
away.

> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: timer: 'clocks'=
 does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/timer/arm,arch_timer.yaml=
#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /sdram@1e6e0000=
: failed to match any schema with compatible: ['aspeed,ast2600-sdram-edac',=
 'syscon']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: bus@1e600000: c=
ompatible: ['aspeed,ast2600-ahbc', 'syscon'] is too long
> 	from schema $id: http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.y=
aml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: syscon@1e6e2000=
: 'smp-memram@180' does not match any of the regexes: '^interrupt-controlle=
r@[0-9a-f]+$', '^p2a-control@[0-9a-f]+$', '^pinctrl(@[0-9a-f]+)?$', '^silic=
on-id@[0-9a-f]+$', 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.ya=
ml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /ahb/apb@1e6e00=
00/syscon@1e6e2000/smp-memram@180: failed to match any schema with compatib=
le: ['aspeed,ast2600-smpmem']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /ahb/apb@1e6e00=
00/syscon@1e6e2000/interrupt-controller@560: failed to match any schema wit=
h compatible: ['aspeed,ast2600-scu-ic0']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /ahb/apb@1e6e00=
00/syscon@1e6e2000/interrupt-controller@570: failed to match any schema wit=
h compatible: ['aspeed,ast2600-scu-ic1']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /ahb/apb@1e6e00=
00/display@1e6e6000: failed to match any schema with compatible: ['aspeed,a=
st2600-gfx', 'syscon']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: adc@1e6e9000: '=
interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-ad=
c.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: adc@1e6e9100: '=
interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-ad=
c.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: crypto@1e6fa000=
: 'aspeed,ahbc' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/crypto/aspeed,ast2600-acr=
y.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /ahb/video@1e70=
0000: failed to match any schema with compatible: ['aspeed,ast2600-video-en=
gine']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: sdc@1e740000: s=
dhci@1e740100:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
> 	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: sdc@1e740000: s=
dhci@1e740200:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
> 	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /ahb/sdc@1e7400=
00/sdhci@1e740100: failed to match any schema with compatible: ['aspeed,ast=
2600-sdhci', 'sdhci']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /ahb/sdc@1e7400=
00/sdhci@1e740200: failed to match any schema with compatible: ['aspeed,ast=
2600-sdhci', 'sdhci']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /ahb/apb@1e7800=
00/timer@1e782000: failed to match any schema with compatible: ['aspeed,ast=
2600-timer']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: lpc@1e789000: l=
pc-snoop@80: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: lpc@1e789000: r=
eg-io-width: 4 is not of type 'object'
> 	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: kcs@24: 'clocks=
' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-b=
mc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: kcs@28: 'clocks=
' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-b=
mc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: kcs@2c: 'clocks=
' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-b=
mc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: kcs@114: 'clock=
s' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-b=
mc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /ahb/apb@1e7800=
00/lpc@1e789000/lhc@a0: failed to match any schema with compatible: ['aspee=
d,ast2600-lhc']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /ahb/apb@1e7800=
00/lpc@1e789000/ibt@140: failed to match any schema with compatible: ['aspe=
ed,ast2600-ibt-bmc']

Ignore the warnings above for now, I have some work to do to define the
bindings and fix the DTSIs for the Aspeed SoCs.

> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /ahb/apb@1e7800=
00/bus@1e78a000/i2c@200/i2c-mux@77/i2c@5/pwm@20: failed to match any schema=
 with compatible: ['max31790']

This must rather be "maxim,max31790".

> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /ahb/apb@1e7800=
00/bus@1e78a000/i2c@580/power-monitor@69: failed to match any schema with c=
ompatible: ['pmbus']

"pmbus" is not a valid compatible. Please describe the _device_ in the
usual form ("manufacturer,part-number"). You may need to define the
binding for this device.

> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: fsi@1e79b000: c=
ompatible: ['aspeed,ast2600-fsi-master', 'fsi-master'] is too long
> 	from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-ma=
ster.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /ahb/apb@1e7900=
00/fsi@1e79b000: failed to match any schema with compatible: ['aspeed,ast26=
00-fsi-master', 'fsi-master']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: fsi@1e79b100: c=
ompatible: ['aspeed,ast2600-fsi-master', 'fsi-master'] is too long
> 	from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-ma=
ster.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /ahb/apb@1e7900=
00/fsi@1e79b100: failed to match any schema with compatible: ['aspeed,ast26=
00-fsi-master', 'fsi-master']
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /ahb/apb@1e7900=
00/dma-controller@1e79e000: failed to match any schema with compatible: ['a=
speed,ast2600-udma']
>=20

Ignore these as well for now. Again, they are my problems to fix.

Andrew

