Return-Path: <linux-aspeed+bounces-1243-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84090C54F30
	for <linux-aspeed@archiver.kernel.org>; Tue, 27 May 2025 17:56:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b6L0w3wMGz2yK9;
	Wed, 28 May 2025 03:56:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748368592;
	cv=none; b=ONWdT0QRPCJ6K6socWlfOmPARP9IUlGPiz1qC+fjhMo7WorItc1a2ciXzLW4yIsY0rLCoRGxT5WXjfwsAMfNwqqyz58pS5mxHZybXF0JWkvn6cPS4bzoEGgE2TdAqxu2BBqLklprIIgK5LLpTZJCbLaMFhNkpAXtZjyzUKFjgiIvZqnurIWldqAzHn8DGM0hp3jWtP7/j+x0h7y7tb5mzVhhVQ7ftYPt0GloNBXa5bhxJzVm7Gjm8JuB9SFpqvlZ3IBBLLq4E1FpjBHbo8KL1UNuaESSEIvyNMWtdM7lcSpDU+n4CaMsTv6vKsRCS1O0kyDfnHTU94xOx5Pz1apgog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748368592; c=relaxed/relaxed;
	bh=88LFRY1C/sb7IvXkrqrwR7CSLDQ8c0AS0AISh+o3gcU=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=YPWPO2QyRnNMRfaf3ON52KBPdcfn45hAHASPfRjZgm5/FRYBiO4ou9XtjohtL+FR4E8m/VEnAhAMkgAOdWaDI/DAepjpIgH3fu7fl/rQ01brsdsiqQzDf0jgopUGxf1IX/KPnWSleyty35C3IF29acu2CD26njtuSXtj5aAbHKxbRJfJPNFmcaEERkHBCugQC9t3vLVi+DtbUzUABjORb9J8DoHAKQEaJuOA1nDOm4bYCgd59XE6NFDh0+y0bLy8v8CpNG0Obhaw0MR5Khiu1D0mn//0V2wdlQ5XpPwGhTkoS8r0lXZ62UsX7jq/ynxVJWmSvgPDGOF/O8oaMcIdCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZGDyc1Tv; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZGDyc1Tv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b6L0v55Spz2xPL
	for <linux-aspeed@lists.ozlabs.org>; Wed, 28 May 2025 03:56:31 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0338A49B85;
	Tue, 27 May 2025 17:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8338C4CEE9;
	Tue, 27 May 2025 17:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748368589;
	bh=TYvcN0FXetMET/yMqKYpyaUprPLsn66NSldFSb6Hm7k=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=ZGDyc1TvlC4v+xPxrJd+uSCgvUHnc+I7dcc37XRScxQwVkQRM5clhDUQJOJ0WEYP5
	 3hk+RIDgyNxtDi3gjJ6wljWXK0gMfloB5Qc5bglnfG2in7ZbS6H3EPLVB07hUGUL1M
	 YClwojpcDYcjxt61mjCVvqCoLTbv3IOA0c2cTDIoIOxKIREhkF4cCucs4vcUiPUwR4
	 kXVXsj6GwZpxUMUpr+a10XMBylHsHpI+g8b2jVqNCd4bQngM8y18okvZXxUbtGjIfr
	 omOb10xa8Ja5IsYT9TVH873r9IV8hXXLUEYe0QVvlB3fRpz3GTraoc0bGO4Sl7U8BA
	 XyZGuvPQlJq0Q==
Date: Tue, 27 May 2025 12:56:28 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, george.kw.lee@fii-foxconn.com, 
 leo.jt.wang@gmail.com, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, leo.jt.wang@fii-foxconn.com, 
 Joel Stanley <joel@jms.id.au>, Conor Dooley <conor+dt@kernel.org>, 
 devicetree@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <c5e16072-e6de-4256-b0e2-3b45e420f0c4@kernel.org>
References: <6822b851.050a0220.27a24d.d071@mx.google.com>
 <68343bef.170a0220.23efba.1d80@mx.google.com>
 <c5e16072-e6de-4256-b0e2-3b45e420f0c4@kernel.org>
Message-Id: <174836831148.841003.9353881909107000956.robh@kernel.org>
Subject: Re: [PATCH V3 2/2] ARM: dts: aspeed: clemente: add Meta Clemente
 BMC


On Mon, 26 May 2025 14:50:24 +0200, Krzysztof Kozlowski wrote:
> On 26/05/2025 12:01, leo.jt.wang@gmail.com wrote:
> > From: Leo Wang <leo.jt.wang@fii-foxconn.com>
> >
> > Add linux device tree entry for Meta Clemente compute-tray
> > BMC using AST2600 SoC.
> >
> > Signed-off-by: Leo Wang <leo.jt.wang@fii-foxconn.com>
> > ---
> >  arch/arm/boot/dts/aspeed/Makefile             |    1 +
> >  .../aspeed/aspeed-bmc-facebook-clemente.dts   | 1195 +++++++++++++++++
> >  2 files changed, 1196 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
> >
> > diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
> > index b3170fdd3096..9d0a465cbb36 100644
> > --- a/arch/arm/boot/dts/aspeed/Makefile
> > +++ b/arch/arm/boot/dts/aspeed/Makefile
> > @@ -19,6 +19,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
> >  	aspeed-bmc-delta-ahe50dc.dtb \
> >  	aspeed-bmc-facebook-bletchley.dtb \
> >  	aspeed-bmc-facebook-catalina.dtb \
> > +	aspeed-bmc-facebook-clemente.dtb \
> >  	aspeed-bmc-facebook-cmm.dtb \
> >  	aspeed-bmc-facebook-elbert.dtb \
> >  	aspeed-bmc-facebook-fuji.dtb \
> > diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
> > new file mode 100644
> > index 000000000000..63b5a13214f1
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
> > @@ -0,0 +1,1195 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +// Copyright (c) 2021 Facebook Inc.
> > +/dts-v1/;
> > +
> > +#include "aspeed-g6.dtsi"
> > +#include <dt-bindings/gpio/aspeed-gpio.h>
> > +#include <dt-bindings/usb/pd.h>
> > +#include <dt-bindings/leds/leds-pca955x.h>
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +#include <dt-bindings/i2c/i2c.h>
> > +
> > +/ {
> > +	model = "Facebook Clemente BMC";
> > +	compatible = "facebook,clemente-bmc", "aspeed,ast2600";
> Missing bindings.
> 
> Or your threading is broken because I did not receive 1/2.
> 
> Just in case:
> 
> Please version your patches (entire patchset!) correctly, e.g. use b4 or
> git format-patch -vX, and add changelog in cover letter or under '---'
> of individual patches describing changes from previous version.
> 
> Do not attach (thread) your patchsets to some other threads (unrelated
> or older versions). This buries them deep in the mailbox and might
> interfere with applying entire sets.
> 
> Best regards,
> Krzysztof
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


This patch series was applied (using b4) to base:
 Base: attempting to guess base-commit...
 Base: tags/next-20250527 (exact match)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/aspeed/' for c5e16072-e6de-4256-b0e2-3b45e420f0c4@kernel.org:

arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: / (facebook,clemente-bmc): compatible: 'oneOf' conditional failed, one must be fixed:
	'facebook,clemente-bmc' is not one of ['delta,ahe50dc-bmc', 'facebook,galaxy100-bmc', 'facebook,wedge100-bmc', 'facebook,wedge40-bmc', 'microsoft,olympus-bmc', 'quanta,q71l-bmc', 'tyan,palmetto-bmc', 'yadro,vesnin-bmc']
	'facebook,clemente-bmc' is not one of ['amd,daytonax-bmc', 'amd,ethanolx-bmc', 'ampere,mtjade-bmc', 'aspeed,ast2500-evb', 'asrock,e3c246d4i-bmc', 'asrock,e3c256d4i-bmc', 'asrock,romed8hm3-bmc', 'asrock,spc621d8hm3-bmc', 'asrock,x570d4u-bmc', 'bytedance,g220a-bmc', 'facebook,cmm-bmc', 'facebook,minipack-bmc', 'facebook,tiogapass-bmc', 'facebook,yamp-bmc', 'facebook,yosemitev2-bmc', 'facebook,wedge400-bmc', 'hxt,stardragon4800-rep2-bmc', 'ibm,mihawk-bmc', 'ibm,mowgli-bmc', 'ibm,romulus-bmc', 'ibm,swift-bmc', 'ibm,witherspoon-bmc', 'ingrasys,zaius-bmc', 'inspur,fp5280g2-bmc', 'inspur,nf5280m6-bmc', 'inspur,on5263m5-bmc', 'intel,s2600wf-bmc', 'inventec,lanyang-bmc', 'lenovo,hr630-bmc', 'lenovo,hr855xg2-bmc', 'portwell,neptune-bmc', 'qcom,centriq2400-rep-bmc', 'supermicro,x11spi-bmc', 'tyan,s7106-bmc', 'tyan,s8036-bmc', 'yadro,nicole-bmc', 'yadro,vegman-n110-bmc', 'yadro,vegman-rx20-bmc', 'yadro,vegman-sx20-bmc']
	'facebook,clemente-bmc' is not one of ['ampere,mtjefferson-bmc', 'ampere,mtmitchell-bmc', 'aspeed,ast2600-evb', 'aspeed,ast2600-evb-a1', 'asus,x4tf-bmc', 'facebook,bletchley-bmc', 'facebook,catalina-bmc', 'facebook,cloudripper-bmc', 'facebook,elbert-bmc', 'facebook,fuji-bmc', 'facebook,greatlakes-bmc', 'facebook,harma-bmc', 'facebook,minerva-cmc', 'facebook,yosemite4-bmc', 'ibm,blueridge-bmc', 'ibm,everest-bmc', 'ibm,fuji-bmc', 'ibm,rainier-bmc', 'ibm,sbp1-bmc', 'ibm,system1-bmc', 'ibm,tacoma-bmc', 'inventec,starscream-bmc', 'inventec,transformer-bmc', 'jabil,rbp-bmc', 'nvidia,gb200nvl-bmc', 'qcom,dc-scm-v1-bmc', 'quanta,s6q-bmc', 'ufispace,ncplite-bmc']
	'aspeed,ast2400' was expected
	'aspeed,ast2500' was expected
	from schema $id: http://devicetree.org/schemas/arm/aspeed/aspeed.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: /: failed to match any schema with compatible: ['facebook,clemente-bmc', 'aspeed,ast2600']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: timer (arm,armv7-timer): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/timer/arm,arch_timer.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: /sdram@1e6e0000: failed to match any schema with compatible: ['aspeed,ast2600-sdram-edac', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: bus@1e600000 (aspeed,ast2600-ahbc): compatible: ['aspeed,ast2600-ahbc', 'syscon'] is too long
	from schema $id: http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: syscon@1e6e2000 (aspeed,ast2600-scu): 'smp-memram@180' does not match any of the regexes: '^interrupt-controller@[0-9a-f]+$', '^p2a-control@[0-9a-f]+$', '^pinctrl(@[0-9a-f]+)?$', '^pinctrl-[0-9]+$', '^silicon-id@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: /ahb/apb@1e6e0000/syscon@1e6e2000/smp-memram@180: failed to match any schema with compatible: ['aspeed,ast2600-smpmem']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: /ahb/apb@1e6e0000/display@1e6e6000: failed to match any schema with compatible: ['aspeed,ast2600-gfx', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: adc@1e6e9000 (aspeed,ast2600-adc0): 'interrupts' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: adc@1e6e9100 (aspeed,ast2600-adc1): 'interrupts' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: crypto@1e6fa000 (aspeed,ast2600-acry): 'aspeed,ahbc' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/crypto/aspeed,ast2600-acry.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: sdc@1e740000 (aspeed,ast2600-sd-controller): sdhci@1e740100:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: sdc@1e740000 (aspeed,ast2600-sd-controller): sdhci@1e740200:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: /ahb/sdc@1e740000/sdhci@1e740100: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: /ahb/sdc@1e740000/sdhci@1e740200: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: /ahb/apb@1e780000/timer@1e782000: failed to match any schema with compatible: ['aspeed,ast2600-timer']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: lpc@1e789000 (aspeed,ast2600-lpc-v2): reg-io-width: 4 is not of type 'object'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: lpc@1e789000 (aspeed,ast2600-lpc-v2): lpc-snoop@80: 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: kcs@24 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: kcs@28 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: kcs@2c (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: kcs@114 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: /ahb/apb@1e780000/lpc@1e789000/lhc@a0: failed to match any schema with compatible: ['aspeed,ast2600-lhc']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: /ahb/apb@1e780000/lpc@1e789000/ibt@140: failed to match any schema with compatible: ['aspeed,ast2600-ibt-bmc']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: fsi@1e79b000 (aspeed,ast2600-fsi-master): compatible: ['aspeed,ast2600-fsi-master', 'fsi-master'] is too long
	from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: /ahb/apb@1e790000/fsi@1e79b000: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: fsi@1e79b100 (aspeed,ast2600-fsi-master): compatible: ['aspeed,ast2600-fsi-master', 'fsi-master'] is too long
	from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: /ahb/apb@1e790000/fsi@1e79b100: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dtb: /ahb/apb@1e790000/dma-controller@1e79e000: failed to match any schema with compatible: ['aspeed,ast2600-udma']






