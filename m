Return-Path: <linux-aspeed+bounces-2270-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06AD8CAC59A
	for <linux-aspeed@archiver.kernel.org>; Thu, 18 Sep 2025 00:39:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cRxbv4PNkz302l;
	Thu, 18 Sep 2025 10:39:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758155979;
	cv=none; b=PpTU+Y7A6dSWRxvrObYZ0zCp2Jh9AwzQXNY2bqFJ0v6lEAvXNnkrK3bzSbqwNSN1444AYpICXHCsj0EONm2QKUEDe27P4eeDGk3xmxBY8O021RB/HOID5konto8QBYK8BeQnrmOWuTbRHEOjtvXA+SrmrfgZKO6BdCWyQfDRwA4po5P7V75U5KEeavrCbPG9EdANZdTiuC0FnxCYs8N/ccQijv/48BdYAoJWK5WeOoQJFLoLOzlylzL8fz+oL0dA82cEJIQZYa3h+lHMU5MNXQlb+SPyf3FQQNuIkHJWcBNH/pZJJyWMHs7FmSxSm/pC0PJXjMI2rgHj3dvqf5tPng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758155979; c=relaxed/relaxed;
	bh=1iEx54ZOMomOnf2LvfGpRIRuTSbhFJDOgxnOU33qXtQ=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=Dqpw/kcpfUGMfx6ME5mpletHxVaNeH5xzjmjZ+2Dsol1PUVVHw0EcXD3kjCCOZKsvPEFY65sHmhTO32oQv5GrYnviVjpnp2UCM0E0eH6Jo04pizzKs52dI5SvuIvR3KLq7XmdIbuNa45w9UMzjPrEbcP+dI3Hh15jHNLWE7Y2l3PsoserjWFPuwen/h+xwWeXaxSTYEEViD0cgpqihmGTB/HfT2Qdu6bNGymUcs2Onyfv0kN8EcoapgfQJVHZs+2XrJ/qfW/spSgT+gP8nfqP9J2DnKL+TfW1gAnyxpQ2J7q/ULFa9sf/D76zFkbCUOm628KQgzBMABfaUwVrXsNJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uzhruWYX; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uzhruWYX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cRxbt1hj8z3000
	for <linux-aspeed@lists.ozlabs.org>; Thu, 18 Sep 2025 10:39:38 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E546C6000A;
	Thu, 18 Sep 2025 00:39:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC858C4CEF9;
	Thu, 18 Sep 2025 00:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758155974;
	bh=EDq2s+UOe0hB5ybmNUS4sEMfhsLszMAeTal9Gso6a7I=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=uzhruWYXrMwFU9UXJnFSyHZDYmimRy2kqCSlQAFR195x+nMnYWbORFYrvjYiKUMWM
	 lDr4+lH9/PflVERLxpXLCBmp8lTTW1IP6fG8jqSOJj9OqSQxXMGHEeg/SZEXTHVRIs
	 G4pe6JOIlbsASBZ6DfYmCdsJmixw7ZWLlt5U/oicdGjwcrFDHbe1TQWTi0wXTelrKf
	 VbrPr+l9AEQTsHp6hrrCpFKincQOuFIyGlg+KkPqgQPPu1U6uJ4zpux0MtHWkI0jNF
	 gcXW6GZ8xy8krgfx9BpKkoISewAgtozrOWVNIPmivwWXk3rDIPALxyQDZ9okobIt3z
	 7Q+XpF00x5HZg==
Date: Wed, 17 Sep 2025 19:39:31 -0500
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
Cc: devicetree@vger.kernel.org, krzk+dt@kernel.org, 
 andrew@codeconstruct.com.au, linux-aspeed@lists.ozlabs.org, 
 conor+dt@kernel.org
To: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20250917144210.160051-1-eajames@linux.ibm.com>
References: <20250917144210.160051-1-eajames@linux.ibm.com>
Message-Id: <175815587292.3804357.10012138669742636066.robh@kernel.org>
Subject: Re: [PATCH v5 0/6] ARM: dts: aspeed: Add Balcones system


On Wed, 17 Sep 2025 09:42:04 -0500, Eddie James wrote:
> The Balcones system is similar to Bonnell but with a POWER11 processor.
> 
> Changes since v4:
>  - Add patch to fix max31785 warnings
>  - Add patch to fix missing Bonnell documentation
> 
> Changes since v3:
>  - Add max31785 to the max31790 document instead of to trivial-devices
>  - Fix minor formatting in dps310 document
> 
> Changes since v2:
>  - Fix a couple of incorrect i2c addresses
>  - Document dps310 and max31785 properly
>  - Drop the UCD binding documentation update, it's been fixed
> 
> Changes since v1:
>  - Add all the ucd9000 driver supported compatible strings
>  - Fix node ordering in Balcones device tree
>  - Improve commit message to explain addition of ibm-power11-dual.dtsi
> 
> Eddie James (6):
>   dt-bindings: arm: aspeed: add IBM Balcones board
>   dt-bindings: arm: aspeed: add IBM Bonnell board
>   dt-bindings: iio: Add Infineon DPS310 sensor documentation
>   dt-bindings: hwmon: Move max31785 compatibles to max31790 document
>   ARM: dts: aspeed: Add Balcones system
>   ARM: dts: aspeed: Fix max31785 fan node naming
> 
>  .../bindings/arm/aspeed/aspeed.yaml           |   2 +
>  .../devicetree/bindings/hwmon/max31785.txt    |  22 -
>  .../bindings/hwmon/maxim,max31790.yaml        |   6 +-
>  .../iio/pressure/infineon,dps310.yaml         |  44 +
>  .../devicetree/bindings/trivial-devices.yaml  |   2 -
>  MAINTAINERS                                   |   1 +
>  arch/arm/boot/dts/aspeed/Makefile             |   1 +
>  .../dts/aspeed/aspeed-bmc-ibm-balcones.dts    | 609 ++++++++++++++
>  .../dts/aspeed/aspeed-bmc-ibm-bonnell.dts     |   6 +-
>  .../dts/aspeed/aspeed-bmc-ibm-everest.dts     |  10 +-
>  .../boot/dts/aspeed/aspeed-bmc-ibm-fuji.dts   |   2 -
>  .../dts/aspeed/aspeed-bmc-ibm-rainier.dts     |  14 +-
>  .../boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts |  10 +-
>  .../dts/aspeed/aspeed-bmc-opp-witherspoon.dts |   2 -
>  .../arm/boot/dts/aspeed/ibm-power11-dual.dtsi | 779 ++++++++++++++++++
>  .../arm/boot/dts/aspeed/ibm-power11-quad.dtsi | 769 +----------------
>  16 files changed, 1459 insertions(+), 820 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/max31785.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dts
>  create mode 100644 arch/arm/boot/dts/aspeed/ibm-power11-dual.dtsi
> 
> --
> 2.51.0
> 
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
 Base: tags/next-20250917 (best guess, 12/13 blobs matched)

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/aspeed/' for 20250917144210.160051-1-eajames@linux.ibm.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts:483.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c@200/max31785@52/fan-0:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts:496.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c@200/max31785@52/fan-1:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts:509.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c@200/max31785@52/fan-2:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts:522.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c@200/max31785@52/fan-3:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts:481.9-492.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@200/max31785@52/fan-0: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts:481.9-492.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@200/max31785@52/fan-0: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts:494.9-505.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@200/max31785@52/fan-1: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts:494.9-505.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@200/max31785@52/fan-1: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts:507.9-518.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@200/max31785@52/fan-2: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts:507.9-518.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@200/max31785@52/fan-2: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts:520.9-531.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@200/max31785@52/fan-3: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts:520.9-531.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@200/max31785@52/fan-3: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts:2068.6-16: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c@780/i2c-mux@70/i2c@3/max31785@52/fan-0:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts:2074.6-16: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c@780/i2c-mux@70/i2c@3/max31785@52/fan-1:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts:2080.6-16: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c@780/i2c-mux@70/i2c@3/max31785@52/fan-2:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts:2086.6-16: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c@780/i2c-mux@70/i2c@3/max31785@52/fan-3:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts:2066.11-2070.7: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@780/i2c-mux@70/i2c@3/max31785@52/fan-0: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts:2066.11-2070.7: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@780/i2c-mux@70/i2c@3/max31785@52/fan-0: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts:2072.11-2076.7: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@780/i2c-mux@70/i2c@3/max31785@52/fan-1: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts:2072.11-2076.7: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@780/i2c-mux@70/i2c@3/max31785@52/fan-1: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts:2078.11-2082.7: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@780/i2c-mux@70/i2c@3/max31785@52/fan-2: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts:2078.11-2082.7: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@780/i2c-mux@70/i2c@3/max31785@52/fan-2: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts:2084.11-2088.7: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@780/i2c-mux@70/i2c@3/max31785@52/fan-3: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts:2084.11-2088.7: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@780/i2c-mux@70/i2c@3/max31785@52/fan-3: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: max31785@52 (maxim,max31785a): fan-0: Unevaluated properties are not allowed ('compatible', 'maxim,fan-dual-tach', 'maxim,fan-fault-pin-mon', 'maxim,fan-no-fault-ramp', 'maxim,fan-no-watchdog', 'maxim,fan-pwm-freq', 'maxim,fan-ramp', 'maxim,fan-rotor-input', 'tach-pulses' were unexpected)
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: max31785@52 (maxim,max31785a): fan-1: Unevaluated properties are not allowed ('compatible', 'maxim,fan-dual-tach', 'maxim,fan-fault-pin-mon', 'maxim,fan-no-fault-ramp', 'maxim,fan-no-watchdog', 'maxim,fan-pwm-freq', 'maxim,fan-ramp', 'maxim,fan-rotor-input', 'tach-pulses' were unexpected)
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: max31785@52 (maxim,max31785a): fan-2: Unevaluated properties are not allowed ('compatible', 'maxim,fan-dual-tach', 'maxim,fan-fault-pin-mon', 'maxim,fan-no-fault-ramp', 'maxim,fan-no-watchdog', 'maxim,fan-pwm-freq', 'maxim,fan-ramp', 'maxim,fan-rotor-input', 'tach-pulses' were unexpected)
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: max31785@52 (maxim,max31785a): fan-3: Unevaluated properties are not allowed ('compatible', 'maxim,fan-dual-tach', 'maxim,fan-fault-pin-mon', 'maxim,fan-no-fault-ramp', 'maxim,fan-no-watchdog', 'maxim,fan-pwm-freq', 'maxim,fan-ramp', 'maxim,fan-rotor-input', 'tach-pulses' were unexpected)
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: /ahb/apb/bus@1e78a000/i2c@200/max31785@52/fan-0: failed to match any schema with compatible: ['pmbus-fan']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: /ahb/apb/bus@1e78a000/i2c@200/max31785@52/fan-1: failed to match any schema with compatible: ['pmbus-fan']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: /ahb/apb/bus@1e78a000/i2c@200/max31785@52/fan-2: failed to match any schema with compatible: ['pmbus-fan']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: /ahb/apb/bus@1e78a000/i2c@200/max31785@52/fan-3: failed to match any schema with compatible: ['pmbus-fan']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: timer (arm,armv7-timer): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/timer/arm,arch_timer.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: /sdram@1e6e0000: failed to match any schema with compatible: ['aspeed,ast2600-sdram-edac', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: bus@1e600000 (aspeed,ast2600-ahbc): compatible: ['aspeed,ast2600-ahbc', 'syscon'] is too long
	from schema $id: http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: syscon@1e6e2000 (aspeed,ast2600-scu): 'smp-memram@180' does not match any of the regexes: '^interrupt-controller@[0-9a-f]+$', '^p2a-control@[0-9a-f]+$', '^pinctrl(@[0-9a-f]+)?$', '^pinctrl-[0-9]+$', '^silicon-id@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: /ahb/apb/syscon@1e6e2000/smp-memram@180: failed to match any schema with compatible: ['aspeed,ast2600-smpmem']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: adc@1e6e9000 (aspeed,ast2600-adc0): 'interrupts' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: adc@1e6e9100 (aspeed,ast2600-adc1): 'interrupts' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: crypto@1e6fa000 (aspeed,ast2600-acry): 'aspeed,ahbc' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/crypto/aspeed,ast2600-acry.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: /ahb/apb/lpc@1e789000/lhc@a0: failed to match any schema with compatible: ['aspeed,ast2600-lhc']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: /ahb/apb/lpc@1e789000/ibt@140: failed to match any schema with compatible: ['aspeed,ast2600-ibt-bmc']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dtb: /ahb/apb/dma-controller@1e79e000: failed to match any schema with compatible: ['aspeed,ast2600-udma']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1082.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-0:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1088.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-1:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1094.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-2:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1100.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-3:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1106.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-4:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1112.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-5:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1080.15-1084.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-0: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1080.15-1084.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-0: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1086.15-1090.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-1: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1086.15-1090.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-1: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1092.15-1096.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-2: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1092.15-1096.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-2: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1098.15-1102.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-3: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1098.15-1102.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-3: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1104.15-1108.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-4: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1104.15-1108.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-4: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1110.15-1114.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-5: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1110.15-1114.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-5: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: max31785@52 (maxim,max31785a): fan-0: Unevaluated properties are not allowed ('compatible', 'tach-pulses' were unexpected)
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: max31785@52 (maxim,max31785a): fan-1: Unevaluated properties are not allowed ('compatible', 'tach-pulses' were unexpected)
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: max31785@52 (maxim,max31785a): fan-2: Unevaluated properties are not allowed ('compatible', 'tach-pulses' were unexpected)
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: max31785@52 (maxim,max31785a): fan-3: Unevaluated properties are not allowed ('compatible', 'tach-pulses' were unexpected)
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: /ahb/apb/bus@1e78a000/i2c@780/i2c-mux@70/i2c@3/max31785@52/fan-0: failed to match any schema with compatible: ['pmbus-fan']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: /ahb/apb/bus@1e78a000/i2c@780/i2c-mux@70/i2c@3/max31785@52/fan-1: failed to match any schema with compatible: ['pmbus-fan']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: /ahb/apb/bus@1e78a000/i2c@780/i2c-mux@70/i2c@3/max31785@52/fan-2: failed to match any schema with compatible: ['pmbus-fan']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: /ahb/apb/bus@1e78a000/i2c@780/i2c-mux@70/i2c@3/max31785@52/fan-3: failed to match any schema with compatible: ['pmbus-fan']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb: max31785@52 (maxim,max31785a): fan-0: Unevaluated properties are not allowed ('compatible', 'tach-pulses' were unexpected)
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb: max31785@52 (maxim,max31785a): fan-1: Unevaluated properties are not allowed ('compatible', 'tach-pulses' were unexpected)
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb: max31785@52 (maxim,max31785a): fan-2: Unevaluated properties are not allowed ('compatible', 'tach-pulses' were unexpected)
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb: max31785@52 (maxim,max31785a): fan-3: Unevaluated properties are not allowed ('compatible', 'tach-pulses' were unexpected)
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb: max31785@52 (maxim,max31785a): fan-4: Unevaluated properties are not allowed ('compatible', 'tach-pulses' were unexpected)
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb: max31785@52 (maxim,max31785a): fan-5: Unevaluated properties are not allowed ('compatible', 'tach-pulses' were unexpected)
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb: /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-0: failed to match any schema with compatible: ['pmbus-fan']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb: /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-1: failed to match any schema with compatible: ['pmbus-fan']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb: /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-2: failed to match any schema with compatible: ['pmbus-fan']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb: /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-3: failed to match any schema with compatible: ['pmbus-fan']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb: /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-4: failed to match any schema with compatible: ['pmbus-fan']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb: /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-5: failed to match any schema with compatible: ['pmbus-fan']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1082.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-0:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1088.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-1:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1094.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-2:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1100.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-3:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1106.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-4:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1112.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-5:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-1s4u.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-1s4u.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-1s4u.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-1s4u.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1080.15-1084.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-0: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1080.15-1084.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-0: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1086.15-1090.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-1: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1086.15-1090.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-1: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1092.15-1096.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-2: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1092.15-1096.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-2: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1098.15-1102.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-3: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1098.15-1102.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-3: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1104.15-1108.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-4: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1104.15-1108.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-4: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1110.15-1114.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-5: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1110.15-1114.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-5: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1082.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-0:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1088.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-1:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1094.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-2:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1100.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-3:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1106.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-4:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1112.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-5:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-4u.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-4u.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-4u.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-4u.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1080.15-1084.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-0: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1080.15-1084.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-0: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1086.15-1090.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-1: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1086.15-1090.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-1: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1092.15-1096.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-2: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1092.15-1096.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-2: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1098.15-1102.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-3: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1098.15-1102.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-3: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1104.15-1108.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-4: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1104.15-1108.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-4: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1110.15-1114.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-5: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts:1110.15-1114.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-5: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:279.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-0:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:285.4-14: Warning (reg_format): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-1:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:277.15-281.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-0: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:277.15-281.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-0: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:283.15-287.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-1: Relying on default #address-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:283.15-287.5: Warning (avoid_default_addr_size): /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-1: Relying on default #size-cells value
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-1s4u.dtb: max31785@52 (maxim,max31785a): fan-0: Unevaluated properties are not allowed ('compatible', 'tach-pulses' were unexpected)
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-1s4u.dtb: max31785@52 (maxim,max31785a): fan-1: Unevaluated properties are not allowed ('compatible', 'tach-pulses' were unexpected)
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-1s4u.dtb: max31785@52 (maxim,max31785a): fan-2: Unevaluated properties are not allowed ('compatible', 'tach-pulses' were unexpected)
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-1s4u.dtb: max31785@52 (maxim,max31785a): fan-3: Unevaluated properties are not allowed ('compatible', 'tach-pulses' were unexpected)
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-1s4u.dtb: max31785@52 (maxim,max31785a): fan-4: Unevaluated properties are not allowed ('compatible', 'tach-pulses' were unexpected)
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-1s4u.dtb: max31785@52 (maxim,max31785a): fan-5: Unevaluated properties are not allowed ('compatible', 'tach-pulses' were unexpected)
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-1s4u.dtb: /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-0: failed to match any schema with compatible: ['pmbus-fan']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-1s4u.dtb: /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-1: failed to match any schema with compatible: ['pmbus-fan']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-1s4u.dtb: /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-2: failed to match any schema with compatible: ['pmbus-fan']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-1s4u.dtb: /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-3: failed to match any schema with compatible: ['pmbus-fan']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-1s4u.dtb: /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-4: failed to match any schema with compatible: ['pmbus-fan']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-1s4u.dtb: /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-5: failed to match any schema with compatible: ['pmbus-fan']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-4u.dtb: max31785@52 (maxim,max31785a): fan-0: Unevaluated properties are not allowed ('compatible', 'tach-pulses' were unexpected)
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-4u.dtb: max31785@52 (maxim,max31785a): fan-1: Unevaluated properties are not allowed ('compatible', 'tach-pulses' were unexpected)
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-4u.dtb: max31785@52 (maxim,max31785a): fan-2: Unevaluated properties are not allowed ('compatible', 'tach-pulses' were unexpected)
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-4u.dtb: max31785@52 (maxim,max31785a): fan-3: Unevaluated properties are not allowed ('compatible', 'tach-pulses' were unexpected)
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-4u.dtb: max31785@52 (maxim,max31785a): fan-4: Unevaluated properties are not allowed ('compatible', 'tach-pulses' were unexpected)
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-4u.dtb: max31785@52 (maxim,max31785a): fan-5: Unevaluated properties are not allowed ('compatible', 'tach-pulses' were unexpected)
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-4u.dtb: /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-0: failed to match any schema with compatible: ['pmbus-fan']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-4u.dtb: /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-1: failed to match any schema with compatible: ['pmbus-fan']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-4u.dtb: /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-2: failed to match any schema with compatible: ['pmbus-fan']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-4u.dtb: /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-3: failed to match any schema with compatible: ['pmbus-fan']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-4u.dtb: /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-4: failed to match any schema with compatible: ['pmbus-fan']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-4u.dtb: /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-5: failed to match any schema with compatible: ['pmbus-fan']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: max31785@52 (maxim,max31785a): fan-0: Unevaluated properties are not allowed ('compatible', 'tach-pulses' were unexpected)
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: max31785@52 (maxim,max31785a): fan-1: Unevaluated properties are not allowed ('compatible', 'tach-pulses' were unexpected)
	from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-0: failed to match any schema with compatible: ['pmbus-fan']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: /ahb/apb/bus@1e78a000/i2c@400/max31785@52/fan-1: failed to match any schema with compatible: ['pmbus-fan']






