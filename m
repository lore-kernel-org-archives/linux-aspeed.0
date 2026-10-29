Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F9C606A31F
	for <linux-aspeed@archiver.kernel.org>; Thu, 29 Oct 2026 09:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Huh6i3il
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFfh82JCNz308H;
	Thu, 29 Oct 2026 20:54:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793267640;
	cv=none; b=b+h6zvC069rX3mem9bM/qKhMByotZs8yydkBn3GEni2cDd1AvtP7GkBH2sspf4MxlS+AnRBUvWt2lZZbLOGCbKawMDzUs3aEDhMwsOJgtI8zVBr3IqCrMKb+zJX19v9VqwJtLH4QdUdKrAojKUuvmEofNSqymjlEQv7WU/UsA4CK8lxjqGi7dRNUE2icxg+/TjNkSN16ByE+ow4xBHJ3S8Gd6gnZzF7SvGyKhw7RjzNSscbR6dSoeIQAsnYr2C2fE+KwAlsjEtm4l1IdbhPZXm6WaVQ3ZWq0lguvj7s2GSzzsoOWoa7ajteqo2dAyb37OTRjMcbnlCgnfQRig3dLEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793267640; c=relaxed/relaxed;
	bh=V6Z3lx8HB/65IktpMvGzORYJmEAvTuwDLE0nRJTp3hM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbt5VkRtioBZADT0GmYFzFLx/HDFL1HjEn+UMf5VoLGF/A+rnGIKgLsUf3sB7eRpWvpShBKReSZra71roh17QwcHf5RmpbC0zhCTBQecxDgCTtMq7WIf0o4de4QKZTr16PeGvzBWLqah5Ekpz2crE7+20Tr0EXROUs2cDWEHWhP/UFhxIZw8GFgOItf3OE70XuLJo4DFdSb5uFLRM6gvvD3c1RORD3SeX4EltT8v/IECbjBC5gNXadyqCamy3Ojf3G0U1/mpaiJETzXKDBaopPFoS0V2DfpauVMOLtKZ2GzaZF2UeDsCxgxzyZG/F9qDX8Wihz2otMsLDOX0RT/sVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Huh6i3il; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Huh6i3il;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFfh71SPHz2ylj;
	Thu, 29 Oct 2026 20:53:59 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A8B3F43EE8;
	Thu, 29 Oct 2026 09:53:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746B41F01828;
	Thu, 29 Oct 2026 09:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793267636;
	bh=V6Z3lx8HB/65IktpMvGzORYJmEAvTuwDLE0nRJTp3hM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Huh6i3ilGxlUQtbUPcQDEACaSC8dodvTAcDQ770a1bA7dtYFzJThClWwToRi++ZcX
	 KtkrkWvDmOnZzC0u6SlsKhXDqNDQqXYnd1M9sD93SHFaWE1dX0FgWhUpzzxZlvgK+p
	 MAyJsDAj0RE0wrqixzclF1d2n4gSm33fKp6WZTCAN5cZKRBpUz8JsqtVjTmLy4bARb
	 CybTuhe4dijZoxnpCQRaAfR3hFwwapnXga6wLeXvmvaeOExekqVhckzlPFqC3e1TzR
	 xAXRoop5zsm3ryCjDYklCHKD4HDvbsdQVDL6Fv+32yDrYtm4+2nyZencxYzHbcMra4
	 k0tMVJQTV3iUg==
Date: Thu, 29 Oct 2026 10:53:52 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jacky Huang <jackyhuang@nvidia.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>, 
	Billy Tsai <billy_tsai@aspeedtech.com>
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: Add NVIDIA MGX Vera C2 BMC
Message-ID: <20261029-gentle-devious-trogon-de665e@quoll>
References: <cover.1793243187.git.jackyhuang@nvidia.com>
 <0d221cbd11c8b582d43b21e4156dfb7c83b121b3.1793243187.git.jackyhuang@nvidia.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0d221cbd11c8b582d43b21e4156dfb7c83b121b3.1793243187.git.jackyhuang@nvidia.com>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 01:58:08PM +0900, Jacky Huang wrote:
> +	chosen {
> +		bootargs = "console=tty0 console=ttyS4,115200n8 earlycon";

Drop bootargs. Console (and baudrate) goes to stdout-path. earlycon is
for debugging, not mainline wide-usage.

> +		stdout-path = &uart5;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		fault-led {
> +			gpios = <&exp7 12 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		power-led {
> +			gpios = <&exp7 8 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		uid-led {
> +			gpios = <&exp7 10 GPIO_ACTIVE_LOW>;
> +		};
> +	};

...

> +				device@1 {
> +					compatible = "usb955,cf11";
> +					reg = <1>;
> +					#address-cells = <2>;
> +					#size-cells = <0>;
> +
> +					cp2112: interface@1 {
> +						compatible = "usbif955,cf11.config1.1";
> +						reg = <1 1>;
> +						#gpio-cells = <2>;
> +						gpio-controller;
> +						#interrupt-cells = <2>;
> +						interrupt-controller;
> +
> +						i2c {
> +							#address-cells = <1>;
> +							#size-cells = <0>;
> +
> +							/* CPU0 IROT/thermal/SOCAMM/JTAG */
> +							pca9555@50 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
If you cannot find a name matching your device, please check in kernel
sources for similar cases or you can grow the spec (via pull request to
DT spec repo).

> +								compatible = "nxp,pca9555";
> +								reg = <0x50>;

...

> +
> +/* Board 0 management bus 1: GPIO expanders + HPM MCU MCTP */
> +&i2c1 {
> +	mctp-controller;
> +	multi-master;
> +
> +	status = "okay";
> +
> +	/* MCTP for HPM MCU */
> +	mctp@18 {
> +		compatible = "mctp-i2c-controller";
> +		reg = <(0x18 | I2C_OWN_SLAVE_ADDRESS)>;
> +	};
> +
> +	/* Board 0 management bus 1 GPIO expander 0 */
> +	pca9555@20 {
> +		compatible = "nxp,pca9555";
> +		reg = <0x20>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
> +		vcc-supply = <&standby_power_regulator>;
> +		gpio-line-names =
> +		"B0_M1_MCU_RESET_L-O",

Messed indentation.

Are you sure you run dt-check-style here?

Best regards,
Krzysztof


