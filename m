Return-Path: <linux-aspeed+bounces-4764-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F97EC5DF81
	for <linux-aspeed@archiver.kernel.org>; Thu, 20 Aug 2026 18:04:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQrt65WS1z2xW5;
	Fri, 21 Aug 2026 04:04:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787249054;
	cv=none; b=BUiKUe9UfD/NgaQM7eZB9nTpbzF3yZd4hLuIAVzoNMO9vu3Lqo3lo67PzdIL2KxbAO5YQOodw29BUXYxdYr18jT1BPyD19+q9anfN+LKtU8dDua/LnhbWMFIpccIUJcXHUfgVi4qIFWojkkNwvgONvTv9Z/midJf+mAt33ey5oJSTZon9M1N4+l/gNNIypaczDXlTsPtyUqURrgAPd3VIVRspFOLbISsRZvVQdYd5r+iImaXaCmbKBBxfWyljoqK53l1gSzj2FUscmIq+dfSxzbKkawqAp4b9fVq1V3V5rM+QHFYix1PtXH9FbVPhaOB5Hmkf4xNGz5SUpPkUtxdLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787249054; c=relaxed/relaxed;
	bh=v0qjpTqnwOT8F+S6Xael7lBooJw6Dvt+DoYZ8ijRRr4=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=CCBc+j3ybQUM8BMR/T+m/Nbbrbhvee08YjBhaeUgwz8XDzPv9FwKCa+VhNwt9rdmIPuapNUdegcFojMVIUrq8QEEDg+2qWzBL/b3TH/XtdALQFfeXYOiqhVpu+PRAB9JDYyZ+PTj2zuRSNvZA+wje+geomc4FCRapkC1bNe7YPPZ+ssggAJwlShELmsZFWds0ioePY8yx0WhhO6dMHrZNWVEb0MWXp0IHn2vX5yUupkIgbPJyj65ldAJyrJ0JsSeig+qxTZVv5+rHQeqZcXBnb03HakmPRZh6nnZ3oc37BGxhj7UsH+lHuAyMxATWuAifE1Iv65xB2cWqfMQ670ukg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=gMEHXqWw; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=gMEHXqWw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQrt36SZwz2xRw
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Aug 2026 04:04:10 +1000 (AEST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-482938466a7so204350f8f.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Aug 2026 11:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1787249042; x=1787853842; darn=lists.ozlabs.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=v0qjpTqnwOT8F+S6Xael7lBooJw6Dvt+DoYZ8ijRRr4=;
        b=gMEHXqWwRrgk0shzZlEddv18pog/vMT5DCDEAkPkWZkERcXiSsMpaDrmUzscleFoXf
         tv0CRx+BSU6IN+aLyYQm8Mm9LwFcM1bjmiH0Pue/sPpAX6NJHebfVhRcB2CagODSzadc
         XU+u0x82ucLkXuuGDUcxAGZSVQKjitUhv0w5WkNA6ZtLVS2vLymcyeKKl99khUT8GEPc
         S4mEeFtq+vwj+FRWzNnyjnp/QEnxbWeTeS0yEY0LjI6w7M3wGKuOPjf1fn15CSJOP+Lc
         SC/rQJA8qMbjb0/qSzJCQE40cLMh8E4izcfAOS7Tnx9y6Eyn01lMsZwe6U1lQUMuf9VH
         D06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787249042; x=1787853842;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v0qjpTqnwOT8F+S6Xael7lBooJw6Dvt+DoYZ8ijRRr4=;
        b=J3uJgDFPG1sIU0BE19B01CEl9ljUwRDmV+L5hTerttwV9rSX1tw59HObRiMxfOi96k
         wCszgqBF0ucFsafOxiN/sroFSH1iDLJNfx2O7qPxpy6W1WMEsCnXYrJzcr9U4VWV12bz
         gKdoeCyfCiALHUeKCEy4PbzG2SeHsG04vcSguLRtGcNUzHdmAGDP76Z3srP1AKjpsTWA
         BMydd3go5VGChPQLCUnRWYIVn1CMgEX4AfRPLGdQ2qAZVss9FXJdp0rpYNGrxhTxsLUc
         jZNV4zqeZhFyzOyZD0+tlYu5o+l7FdfUh1yODGyBk6fkv8epDHO0z/FMAaEB6In3B/T2
         bTrQ==
X-Forwarded-Encrypted: i=1; AHgh+RrVfMeNYmObx3V1/z5CKqiPt+u/nuYNKsZrKLm282sZfx25gruSGZ1fl4TQxErooJVU26VmiHlQTXOem44=@lists.ozlabs.org
X-Gm-Message-State: AFuF++loYJOLYbebCeIZynJTkLWJW0jf3PV79gEdX8MIddYuYXRHYLDc
	3XZ/IKLWBOs3Z+0lXCe1DMpjxg8gPK0BxxH65t4NhrZ3jmWNP4T1HoqyyBY1ehVgjPk=
X-Gm-Gg: AR+sD13s7A/KEmrMHHwIsJ6lBWvQDAliyXmqlNrLSiGpNSBlvJdt9WaPlqLWIOrKPZo
	iNrWDTQNF4C5NfcZOl+2Gnl45hZ0xFuZOB+f8j6ES4FtJ0x8vDsgddlkej/xi9J4S9yQCCQoe0n
	I2O9lDyV+NNmfRepzZaYrP/Y3zs17dN8pp8nPTttP7gerMt+2S5/upW9QAMK9udyKZ0lbnptPnh
	G5o10KK3e+bmMibPIxp8+yNFXmPMUwZ2GrAz4KPsvz5MbpEAqH6Hv4FtoSGqp6+5iex9BG5MAt6
	s72ApSAnH+DXrCAq233pBxCXpey2cRXkhlnboQeefDcyqAXzBJdOig0u0PmcDNYFSBE74OG3iN9
	1ZR3kjemIDx/crspCfOcDYzCmEkg85E4vik2kY8z7MdxhKgXVpHzi6EtpQAa5VwhAnNcSU9jjMe
	pMHnqU0L137gszS10DNb6MM7MaJpMzVjBD5ytPmHT7fJANWDBa3+BhMwoKgztQJC38OezWwh8vO
	/pGig==
X-Received: by 2002:a05:6000:310f:b0:481:5bce:4485 with SMTP id ffacd0b85a97d-482c0b973acmr747490f8f.13.1787249041680;
        Thu, 20 Aug 2026 11:04:01 -0700 (PDT)
Received: from white-mocha.local ([2001:9e8:2f3:2d01:a8c3:fb9e:cfe9:fc36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14b7d4asm12416365f8f.21.2026.08.20.11.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 11:04:01 -0700 (PDT)
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v9 2/2] ARM: dts: aspeed: ventura2: Add Meta ventura2
 BMC
From: Tan Siewert <tan.siewert@9elements.com>
To: Kyle Hsieh <kylehsieh1995@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Tan Siewert <tan.siewert@9elements.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260727-ventura2_initial_dts-v9-2-504c0ec68039@gmail.com>
References: <20260727-ventura2_initial_dts-v9-0-504c0ec68039@gmail.com>
 <20260727-ventura2_initial_dts-v9-2-504c0ec68039@gmail.com>
Date: Thu, 20 Aug 2026 20:03:47 +0200
Message-Id: <178724902712.20555.7009712214570349708.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787249032; l=5992;
 i=tan.siewert@9elements.com; s=20260527; h=from:subject:message-id;
 bh=xkWAHbvERekeZVhLd1I6wnLOphqgBrouvz38NaGNYY4=;
 b=0/jvytgo6mJLzFT571ev1e0JoXXcjVpaJpVyrgS3abI7bpwqvu3jemBPBCGtwqkZJ3BFd3enh
 VJQBdxWcwzhDGwXmSyj1PsTyM3CxG6hUAZpOcnhFY2e96Lc39yXoCz4
X-Developer-Key: i=tan.siewert@9elements.com; a=ed25519;
 pk=ORQd/zQf+LsAvJGXP1CjQwVO6t6iEOGq/eGUsmRVTG4=

Hi Kyle,

> Ventura2 is a Rack Management Controller. It is a modular
> device designed to manage liquid cooling systems and monitor hardware
> states within an IT rack. The system uses an AST2600 BMC for management.
> 
> RMCv2 serves several critical roles:
> - Detects liquid leakage at both tray and rack levels.
> - Communicates with and controls liquid cooling equipment.
> - Manages leakage events and executes system recovery protocols.
> 
> Key hardware features include:
> - An extensive I2C and IO expander topology to support comprehensive
>   sensor monitoring and backward compatibility with legacy trays.
> - MCTP over I2C support for asynchronous device communications.
> - A dual-flash design for BMC firmware redundancy.
> 
> Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>

*snip*

> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts
> new file mode 100644
> index 000000000000..f1273ca31bf8
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dts
> @@ -0,0 +1,3005 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2023 Facebook Inc.
> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/i2c/i2c.h>
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +
> +/ {
> +	compatible = "facebook,ventura2-rmc", "aspeed,ast2600";
> +	model = "Facebook Ventura2 RMC";
> +
> +	aliases {
> +		/*
> +		* Pre-allocate I2C bus aliases for userspace predictability.
> +		* Several I2C channels are intentionally left empty in this
> +		* DTS as they are strictly reserved for future hardware
> +		* feature expansions and add-on boards that will interface
> +		* with these busses.
> +		*/
> +		/*
> +		* i2c switch 0-0077, pca9548, 8 child channels assigned
> +		* with bus number 16-23.
> +		*/

This alignment is one of the things that seem to be a false-positive for
dt-check-style in strict mode (value-whitespace). See [0] where Krzysztof said
that it may report false-positives, and "Review and investigate warnings from
'strict' mode, but do not fix them automatically without thinking".

@Krzysztof wdyt about this one?

> +		i2c16 = &i2c0mux0ch0;
> +		i2c17 = &i2c0mux0ch1;
> +		i2c18 = &i2c0mux0ch2;
> +		i2c19 = &i2c0mux0ch3;
> +		i2c20 = &i2c0mux0ch4;
> +		i2c21 = &i2c0mux0ch5;
> +		i2c22 = &i2c0mux0ch6;
> +		i2c23 = &i2c0mux0ch7;

*snip*

> +	spi {
> +		compatible = "spi-gpio";
> +		#address-cells = <1>;
> +		cs-gpios = <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
> +		miso-gpios = <&gpio0 ASPEED_GPIO(Z, 5) GPIO_ACTIVE_HIGH>;
> +		mosi-gpios = <&gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
> +		num-chipselects = <1>;
> +		sck-gpios = <&gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
> +		#size-cells = <0>;

Shouldn't #address-cells and #size-cells be ordered together? If reported by
dt-check-style as issue, then it might be a false-positive.

> +
> +		tpm@0 {
> +			compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
> +			reg = <0>;
> +			spi-max-frequency = <33000000>;
> +		};
> +	};
> +};
> +
> +&adc0 {
> +	pinctrl-0 =
> +		<&pinctrl_adc0_default &pinctrl_adc1_default
> +		&pinctrl_adc2_default &pinctrl_adc3_default
> +		&pinctrl_adc4_default &pinctrl_adc5_default
> +		&pinctrl_adc6_default &pinctrl_adc7_default>;
> +	pinctrl-names = "default";
> +	vref-supply = <&p1v8_bmc_aux>;
> +
> +	status = "okay";
> +};
> +
> +&adc1 {
> +	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc10_default>;
> +	pinctrl-names = "default";
> +	vref-supply = <&p2v5_bmc_aux>;
> +
> +	status = "okay";
> +};
> +
> +&ehci0 {
> +	status = "okay";
> +};
> +
> +&ehci1 {
> +	status = "okay";
> +};
> +
> +&fmc {
> +	status = "okay";
> +
> +	flash@0 {
> +		label = "bmc";
> +		spi-max-frequency = <50000000>;
> +		m25p,fast-read;
> +
> +		status = "okay";
> +		#include "openbmc-flash-layout-128.dtsi"
> +	};
> +
> +	flash@1 {
> +		label = "alt-bmc";
> +		spi-max-frequency = <50000000>;
> +		m25p,fast-read;
> +
> +		status = "okay";

Missing '#include "openbmc-flash-layout-128-alt.dtsi"'?

> +	};
> +};

*snip*

> +&mac2 {
> +	phy-mode = "rmii";
> +	pinctrl-0 = <&pinctrl_rmii3_default>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +
> +	/*
> +	* The Marvell 88E6393X is initialized at boot via EEPROM
> +	* configuration and hardware straps.
> +	* The BMC connects via an RMII fixed-link; link parameters are fixed
> +	* by board design.
> +	*/

This kind of writing gives me the suspicion that it was written with assistance
by an LLM, but I might be wrong.

Either way, if you have used AI assistance for your series (or only for this
patch), even if you have only used it for the commit message, then you must
declare it via the "Assisted-by" trailer [1][2].

> +	fixed-link {
> +		full-duplex;
> +		speed = <100>;
> +	};
> +};
> +
> +&mac3 {
> +	pinctrl-0 = <&pinctrl_rmii4_default>;
> +	pinctrl-names = "default";
> +	use-ncsi;
> +
> +	status = "okay";
> +};
> +
> +&peci0 {
> +	status = "okay";
> +};

You mentioned that this is a rack management controller. Does it really require
PECI?

> +
> +&sgpiom0 {
> +	bus-frequency = <100000>;
> +	gpio-line-names =
> +	/*"input pin","output pin"*/
> +	/*A0 - A7*/
> +		"power-chassis-good","FM_PLD_HEARTBEAT_LVC3_R",
> +		"host0-ready","R_BMC_PTH_RST_BTN_L",
> +		"CONTROL_VT2_SUPPLY1_CLOSE","FM_MDIO_SW_SEL_PLD",
> +		"CONTROL_VT2_SUPPLY2_CLOSE","FM_88E6393X_BIN_UPDATE_EN_N",
> +		"CONTROL_VT2_SUPPLY3_CLOSE","Sequence_TransFR_Alert",

Why's "Sequence_TransFR_Alert" written in camelcase?

Tan

[0] https://lore.kernel.org/linux-aspeed/3523fefc-8ba8-4512-b088-7a94a2df73f8@oss.qualcomm.com/
[1] https://docs.kernel.org/process/submitting-patches.html#using-assisted-by
[2] https://docs.kernel.org/process/coding-assistants.html

-- 
Tan Siewert <tan.siewert@9elements.com>

