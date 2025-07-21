Return-Path: <linux-aspeed+bounces-1769-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F96AC87FC5
	for <linux-aspeed@archiver.kernel.org>; Mon, 21 Jul 2025 07:44:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4blsq860yqz2xHp;
	Mon, 21 Jul 2025 17:44:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753083860;
	cv=none; b=It6qI7hFPmVKUT7hRoqOz0n2r7RgGgH/ws137kfiyucDHMy+BZcqrei4sNrQJfzCMxwGXd3W+9zJwuPRUhVbuNJpqz0FH8oWFlEgOR3gZ7K8qRDchQv5vynWSY2KeVx7UEBow+U1kdDeCQnNmkpw7S/Qkm2uEFRqQskMiEDc9ZRc1RCvkcsZypQsqdr44QuPnuQyRu4SQe2cvZ4GB4vvTbacUPLlcbQO1uFEKyZmtPDkQIcDyf7DF8JHYwCRmRWs5K2/8ELQABTX6jniZ9NymONb45cp+W3f5GUrMXCemrG8jmt4K5cIXaaU6G9Us/Jjkg6z+GSWYpW9jLPFrzduHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753083860; c=relaxed/relaxed;
	bh=QjfdYQb3vt4V04Bv05JSqxbXWW9WZpsFUMkpdXWCeng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtxQmMcHkpIvaxs2RrBdagVGvC8AguJaUBrqxLySbT1bL0b0mPP1I9ZeoI5kMTNtFPoNn+nU4Itjg5WtnAj9vVslEZH1U29ZKUp99nx8MbfBMpVxs3Os9WMqidTxCikN4bl8mLSIkrQ6V0tgO2PReDRlS74uFh/m5Hq1jnafpTR22m3tD/XAboHom4l3M6LUj2cv+EGDDl0Pw+Y1PRfMkkPz+ycKVAU2ZZi/uiSf54JGhFSuZRiOW1/TYGQV/LOH1LoLqT7nNkO1V1TnxsTApVbo5YPFwePWR0ggkXVIS+jhtIDv6q0ugacmbTEeP11HVELehh5Kn9iJ3UbOvXtkuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=APLGWMJr; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=APLGWMJr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4blsq80S6Wz2xCW
	for <linux-aspeed@lists.ozlabs.org>; Mon, 21 Jul 2025 17:44:20 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2A64E5C58CD;
	Mon, 21 Jul 2025 07:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404E2C4CEED;
	Mon, 21 Jul 2025 07:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753083857;
	bh=R3ilKXNADnBxk5zEfxWQZZyeUwHHSGqEttZLXNnSuxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=APLGWMJrwvS91kLS73mJMH4GYeW811wsHpGCxgfuwPIubxyQgLnm+tNBzP+04q5LW
	 wJxcYwBN20r5udleMW2IyvT7izI1OW1JqCMH1iC3X+nINtUv2fx06utvXLZJum4v3h
	 eUlJujOwnDFapKvET+PMg5aUgPg9amZtWcJFNwFnV5WLGnq7jDZIZedAT03fpRlOfJ
	 PBD3167foKCn/gjsphntTyWeV6z/nqX4AFttM7+eeBNNNhal42vi7UDnClVGF0kK5J
	 wZNz8j2JC8srj6FW6YrwwFCDwgoWscSVbNnw20eYSojpJeGyHUDCgXmoin66JxfSUB
	 wEn22tKqsJwSg==
Date: Mon, 21 Jul 2025 09:44:15 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Donald Shannon <donalds@nvidia.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	joel@jms.id.au, andrew@codeconstruct.com.au, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] ARM: dts: aspeed: Add device tree for Nvidia's
 GB200  UT3.0b platform BMC
Message-ID: <20250721-hulking-violet-mastodon-16e87a@kuoka>
References: <20250718231118.3330855-1-donalds@nvidia.com>
 <20250718231118.3330855-3-donalds@nvidia.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250718231118.3330855-3-donalds@nvidia.com>

On Fri, Jul 18, 2025 at 04:11:18PM -0700, Donald Shannon wrote:
> +
> +/ {
> +	model = "AST2600 GB200 UT3.0b BMC";
> +	compatible = "nvidia,gb200-ut30b", "aspeed,ast2600";
> +
> +	aliases {
> +		serial2 = &uart3;
> +		serial4 = &uart5;
> +		i2c16   = &imux16;
> +		i2c17   = &imux17;
> +		i2c18   = &imux18;
> +		i2c19   = &imux19;
> +		i2c20   = &imux20;
> +		i2c21   = &imux21;
> +		i2c22   = &imux22;
> +		i2c23   = &imux23;
> +		i2c24   = &imux24;
> +		i2c25   = &imux25;
> +		i2c26   = &imux26;
> +		i2c27   = &imux27;
> +		i2c28   = &imux28;
> +		i2c29   = &imux29;
> +		i2c30   = &imux30;
> +		i2c31   = &imux31;
> +		i2c32   = &imux32;
> +		i2c33   = &imux33;
> +		i2c34   = &imux34;
> +		i2c35   = &imux35;
> +		i2c36   = &imux36;
> +		i2c37   = &imux37;
> +		i2c38   = &imux38;
> +		i2c39   = &imux39;
> +		i2c40	= &e1si2c0;
> +		i2c41	= &e1si2c1;
> +		i2c42	= &e1si2c2;
> +		i2c43	= &e1si2c3;
> +		i2c48	= &i2c17mux0;
> +		i2c49	= &i2c17mux1;
> +		i2c50	= &i2c17mux2;
> +		i2c51	= &i2c17mux3;
> +		i2c52	= &i2c25mux0;
> +		i2c53	= &i2c25mux1;
> +		i2c54	= &i2c25mux2;
> +		i2c55	= &i2c25mux3;
> +		i2c56	= &i2c29mux0;
> +		i2c57	= &i2c29mux1;
> +		i2c58	= &i2c29mux2;
> +		i2c59	= &i2c29mux3;
> +	};
> +
> +	buttons {
> +		button-power {
> +			label = "power-btn";

How is this supposed to work? How does anything bind here?

> +			gpio = <&sgpiom0 156 GPIO_ACTIVE_LOW>;
> +		};
> +		button-uid {
> +			label = "uid-btn";
> +			gpio = <&sgpiom0 154 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	chosen {
> +		stdout-path = &uart5;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		led-0 {
> +			label = "uid_led";
> +			gpios = <&sgpiom0 27 GPIO_ACTIVE_LOW>;
> +		};
> +		led-1 {
> +			label = "fault_led";
> +			gpios = <&sgpiom0 29 GPIO_ACTIVE_LOW>;
> +		};
> +		led-2 {
> +			label = "power_led";
> +			gpios = <&sgpiom0 31 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x80000000>;
> +	};
> +
> +	reg_3v3_stby: regulator-3v3-standby {
> +		compatible = "regulator-fixed";
> +		regulator-name = "3v3-standby";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		gpio = <&gpio0 ASPEED_GPIO(M, 3) GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-always-on;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		vga_memory: framebuffer@9f000000 {
> +			no-map;
> +			reg = <0x9f000000 0x01000000>; /* 16M */
> +		};
> +
> +		ramoops@a0000000 {
> +			compatible = "ramoops";
> +			reg = <0xa0000000 0x100000>; /* 1MB */
> +			record-size = <0x10000>; /* 64KB */
> +			max-reason = <2>; /* KMSG_DUMP_OOPS */
> +		};
> +
> +		gfx_memory: framebuffer {
> +			compatible = "shared-dma-pool";
> +			reusable;
> +			size = <0x01000000>;
> +			alignment = <0x01000000>;
> +		};
> +
> +		video_engine_memory: jpegbuffer {
> +			compatible = "shared-dma-pool";
> +			reusable;
> +			size = <0x02000000>;	/* 32M */
> +			alignment = <0x01000000>;
> +		};
> +	};
> +};
> +
> +// Enable Primary flash on FMC for bring up activity
> +&fmc {
> +	status = "okay";
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		label = "bmc";
> +		spi-max-frequency = <50000000>;
> +		status = "okay";

Why do you need it? Anything disabled it?

Best regards,
Krzysztof


