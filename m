Return-Path: <linux-aspeed+bounces-2283-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7B8CA1013
	for <linux-aspeed@archiver.kernel.org>; Thu, 18 Sep 2025 22:59:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cSWLB0mMCz2xns;
	Fri, 19 Sep 2025 08:59:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758236386;
	cv=none; b=oibybvBj7AV5dShRIXM0qm8IaiHir3LYd6WIhY0Wjehh0IITBI2P3GfM/xpZSTKSPV+AsMwY+O4TKRbVIw1GgscgTTQ1nDzrKYACJcJ4mCSwK1kVLyBlqq9wyw4jzhrapWBkKD3L/J17i1Sc288vQi1PbgyB7BeM8q25el/fynHDxKXLnXQaBrhpDmfHW1aLlWhRpl4EDrG7OCVIXDJIQv6x5PvJxz98aHeSreuXz5IewmNpLhW7M7JtpKlJpGgb6bLRV8oFL39Yw689mjpD8RIzX8teYb76HNTzPSXcspXMxT8hvUeZTyL2qMMEDBa0HgGjh98HFPXSrOSIIZ9LiA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758236386; c=relaxed/relaxed;
	bh=5dBdUrhbuDqZB0LJbY+sCKlawfFaDrXqi8QilwoIBcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsMgh0wyK0zsNNkRbFlwohrqaHUWmIOeBUMpD2it6i2N2kuEeyC67aQEarWq9LAFViSYT0cTcPvsnYr9YTEQJQTM4Y4A/y/TIbmq7jqH6G7ucsGPDzDmaEoREBlzyl0wNftgrdWdyjtgNSYt1g0j/ke7E4E6xDCA40Xzhg70p39Pa7Vyy2GVFsh3dQq0zEZmxjg6Feyxi/MGRKaSdKACcAddDQf26xLnsJC8AgfGZ+dq7hgJs8yfiLr1Q/bHiRLkLSSjP8AWlg58E+w64Ac6QiDDBnFg2cRF48LEHC8tEkHQSdk1A2bbvFkwGuRwl0rDaTqaWnnEBUKx+YGHvIafDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hGzmX8mV; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hGzmX8mV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cSWL92CqCz2xlK
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Sep 2025 08:59:45 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id AA4854033F;
	Thu, 18 Sep 2025 22:59:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41CA5C4CEE7;
	Thu, 18 Sep 2025 22:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758236382;
	bh=Y/MgHo2Lae+1QL5MAWZmOnaVrQ/OZef/Rd+kxRivPCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hGzmX8mVUJUrABLN1gBBk7KJ47AjqR7CEbm5JF9aiumy4OCa2vOa6b1sPKzyERKfj
	 vjtReTBLEa4AM9x5K4BTS01UF2090Ag7dmclcZR9+psQM/EPDshQbH8u/mmu6k61KK
	 MHtpfsrJaLz+uuczz+pC3bciwMR+Ljy0zkBHZlcJuxOV3SSqSbxMpyr7LBMqu2jmyC
	 mxt/Xo//dd+G0aS1e1JKDIKBqedpokRBooN0ma8n42xFZH+t8RqodEAjReAxl6wWft
	 tOPBl1mnUbjYW+ngRf9shPlesrPemsBf0wpSzqjmnA3N/h3flRRVJYcCtdKgoMrzm7
	 HY29RXA/alQrg==
Date: Thu, 18 Sep 2025 17:59:41 -0500
From: Rob Herring <robh@kernel.org>
To: Eddie James <eajames@linux.ibm.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org, krzk+dt@kernel.org,
	andrew@codeconstruct.com.au
Subject: Re: [PATCH v6 0/7] ARM: dts: aspeed: Add Balcones system
Message-ID: <20250918225941.GA3127900-robh@kernel.org>
References: <20250918180402.199373-1-eajames@linux.ibm.com>
 <175823464696.3104136.904298221604133111.robh@kernel.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175823464696.3104136.904298221604133111.robh@kernel.org>

On Thu, Sep 18, 2025 at 05:33:06PM -0500, Rob Herring (Arm) wrote:
> 
> On Thu, 18 Sep 2025 13:03:55 -0500, Eddie James wrote:
> > The Balcones system is similar to Bonnell but with a POWER11 processor.
> > 
> > Changes since v5:
> >  - Add patch to add address and size cells to max31790 document
> >  - Don't remove address and size cells in max31785 fixes change
> > 
> > Changes since v4:
> >  - Add patch to fix max31785 warnings
> >  - Add patch to fix missing Bonnell documentation
> > 
> > Changes since v3:
> >  - Add max31785 to the max31790 document instead of to trivial-devices
> >  - Fix minor formatting in dps310 document
> > 
> > Changes since v2:
> >  - Fix a couple of incorrect i2c addresses
> >  - Document dps310 and max31785 properly
> >  - Drop the UCD binding documentation update, it's been fixed
> > 
> > Changes since v1:
> >  - Add all the ucd9000 driver supported compatible strings
> >  - Fix node ordering in Balcones device tree
> >  - Improve commit message to explain addition of ibm-power11-dual.dtsi
> > 
> > Eddie James (7):
> >   dt-bindings: arm: aspeed: add IBM Balcones board
> >   dt-bindings: arm: aspeed: add IBM Bonnell board
> >   dt-bindings: iio: Add Infineon DPS310 sensor documentation
> >   dt-bindings: hwmon: Move max31785 compatibles to max31790 document
> >   dt-bindings: hwmon: max31790: Document address and size cells
> >   ARM: dts: aspeed: Add Balcones system
> >   ARM: dts: aspeed: Fix max31785 fan node naming
> > 
> >  .../bindings/arm/aspeed/aspeed.yaml           |   2 +
> >  .../devicetree/bindings/hwmon/max31785.txt    |  22 -
> >  .../bindings/hwmon/maxim,max31790.yaml        |  12 +-
> >  .../iio/pressure/infineon,dps310.yaml         |  44 +
> >  .../devicetree/bindings/trivial-devices.yaml  |   2 -
> >  MAINTAINERS                                   |   1 +
> >  arch/arm/boot/dts/aspeed/Makefile             |   1 +
> >  .../dts/aspeed/aspeed-bmc-ibm-balcones.dts    | 609 ++++++++++++++
> >  .../dts/aspeed/aspeed-bmc-ibm-bonnell.dts     |   4 +-
> >  .../dts/aspeed/aspeed-bmc-ibm-everest.dts     |   8 +-
> >  .../dts/aspeed/aspeed-bmc-ibm-rainier.dts     |  12 +-
> >  .../boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts |   8 +-
> >  .../arm/boot/dts/aspeed/ibm-power11-dual.dtsi | 779 ++++++++++++++++++
> >  .../arm/boot/dts/aspeed/ibm-power11-quad.dtsi | 769 +----------------
> >  14 files changed, 1465 insertions(+), 808 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/hwmon/max31785.txt
> >  create mode 100644 Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
> >  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dts
> >  create mode 100644 arch/arm/boot/dts/aspeed/ibm-power11-dual.dtsi
> > 
> > --
> > 2.51.0
> > 
> > 
> > 
> 
> 
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
> 
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
> 
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
> 
>   pip3 install dtschema --upgrade
> 
> 
> This patch series was applied (using b4) to base:
>  Base: attempting to guess base-commit...
>  Base: tags/next-20250917 (best guess, 10/11 blobs matched)
> 
> If this is not the correct base, please add 'base-commit' tag
> (or use b4 which does this automatically)
> 
> New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/aspeed/' for 20250918180402.199373-1-eajames@linux.ibm.com:
> 
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: timer (arm,armv7-timer): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
> 	from schema $id: http://devicetree.org/schemas/timer/arm,arch_timer.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: /sdram@1e6e0000: failed to match any schema with compatible: ['aspeed,ast2600-sdram-edac', 'syscon']
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: bus@1e600000 (aspeed,ast2600-ahbc): compatible: ['aspeed,ast2600-ahbc', 'syscon'] is too long
> 	from schema $id: http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: syscon@1e6e2000 (aspeed,ast2600-scu): 'smp-memram@180' does not match any of the regexes: '^interrupt-controller@[0-9a-f]+$', '^p2a-control@[0-9a-f]+$', '^pinctrl(@[0-9a-f]+)?$', '^pinctrl-[0-9]+$', '^silicon-id@[0-9a-f]+$'
> 	from schema $id: http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: max31785@52 (maxim,max31785a): fan-0: Unevaluated properties are not allowed ('compatible', 'maxim,fan-dual-tach', 'maxim,fan-fault-pin-mon', 'maxim,fan-no-fault-ramp', 'maxim,fan-no-watchdog', 'maxim,fan-pwm-freq', 'maxim,fan-ramp', 'maxim,fan-rotor-input', 'tach-pulses' were unexpected)
> 	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: max31785@52 (maxim,max31785a): fan-1: Unevaluated properties are not allowed ('compatible', 'maxim,fan-dual-tach', 'maxim,fan-fault-pin-mon', 'maxim,fan-no-fault-ramp', 'maxim,fan-no-watchdog', 'maxim,fan-pwm-freq', 'maxim,fan-ramp', 'maxim,fan-rotor-input', 'tach-pulses' were unexpected)
> 	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: max31785@52 (maxim,max31785a): fan-2: Unevaluated properties are not allowed ('compatible', 'maxim,fan-dual-tach', 'maxim,fan-fault-pin-mon', 'maxim,fan-no-fault-ramp', 'maxim,fan-no-watchdog', 'maxim,fan-pwm-freq', 'maxim,fan-ramp', 'maxim,fan-rotor-input', 'tach-pulses' were unexpected)
> 	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: max31785@52 (maxim,max31785a): fan-3: Unevaluated properties are not allowed ('compatible', 'maxim,fan-dual-tach', 'maxim,fan-fault-pin-mon', 'maxim,fan-no-fault-ramp', 'maxim,fan-no-watchdog', 'maxim,fan-pwm-freq', 'maxim,fan-ramp', 'maxim,fan-rotor-input', 'tach-pulses' were unexpected)
> 	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: /ahb/apb/bus@1e78a000/i2c@200/max31785@52/fan-0: failed to match any schema with compatible: ['pmbus-fan']
> arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: /ahb/apb/bus@1e78a000/i2c@200/max31785@52/fan-1: failed to match any schema with compatible: ['pmbus-fan']
> arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: /ahb/apb/bus@1e78a000/i2c@200/max31785@52/fan-2: failed to match any schema with compatible: ['pmbus-fan']
> arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: /ahb/apb/bus@1e78a000/i2c@200/max31785@52/fan-3: failed to match any schema with compatible: ['pmbus-fan']

Sigh. Are you testing this before sending?

None of these "maxim" properties are documented nor used by any driver. 
I don't know what a 'pmbus-fan' is as it is not documented.

For the fan child nodes and their node names, it is quite simple. You 
have 2 options:

fan-[0-9]+:
- no reg property
- no #address-cells or #size-cells in the parent node

fan@[0-9a-f]:
- must have reg property
- must have #address-cells or #size-cells in the parent node

If the parent device has a concept of fan channels (perhaps pages as 
the driver calls them?), then you should use 'reg' to map the fan 
channels to child nodes. For some fan controllers, 'reg' corresponds 
to the PWM number or pin number. Node names are generally not considered 
ABI, so you shouldn't be using them at all. That means the "fan-[0-9]+" 
case has no mapping between the fan node and instances in the fan 
controller.

Rob

