Return-Path: <linux-aspeed+bounces-2533-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54445CCD199
	for <linux-aspeed@archiver.kernel.org>; Mon, 20 Oct 2025 09:40:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cqr5X5nsmz3000;
	Mon, 20 Oct 2025 20:40:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=71.19.156.171
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760953248;
	cv=none; b=OqLuj39mOgM610jNBMn2Pd31uAV6Gwc76d+cBjAdMu7fvEDXGfZWsmqKXvoyB7xYhjOgwCTNmzwT4RU+PbB91kEb/WJI9brd9/F9vrZDEgxNlA2xtyZpbdBwEUwNGfhQZorciQLmFEC5zl9tHbuA3/06A2Se5YgPY0c7sMWqKCJB84m47tbQscxzzpMlFMaHapIFTQJRjjx70Tf1aE3+m+VXmIdjq4LDI7rcUZQRYQVGrr1saLJlS5DvJjK61Tsa859LztFrSZCGnNWBuTMqJg9tod5Xs26jgCbwuOVI+kNVdYMHx6HmejfvShFqEqJN2v6zb6Df8KQ4w6aH14uyiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760953248; c=relaxed/relaxed;
	bh=OCbONFN78XpgRKAC0O9n8v5Ot2s4SJuk+oXKqyYYcm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMQed++LN1oSQ+so82nNFRaA6WkH4bSp8Sb8a6A2B1R90y32QMnECzo8FEAlRQK/7I4cfjI8U/FRZOAW5+zKSoiUziJPLR9SkrXqSPR2qD0qIswhu43sYQdSlDk2eaeG1Z5tEe3OWQOxzgwun364a4Mm6/PyAvzPIt6zkc8kACJ76xFppx5UA6uT3JrakZIQqbCljRYlJNhWZCOm1Kmtm3mHe4zNvpOCi/MvfRin15lnj7cIJJ2bHFSPLzHc7K35fFGUhL05Qiu+M2VAgmBwmO8KjTkeJw0NH+FEzxFuWZYT2Oo3yQ8j0H60xN40ZwmOFYEywLsqKotSydcSV0kvrg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net; dkim=pass (1024-bit key; unprotected) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.a=rsa-sha256 header.s=thorn header.b=aptjzpRb; dkim-atps=neutral; spf=pass (client-ip=71.19.156.171; helo=thorn.bewilderbeest.net; envelope-from=zev@bewilderbeest.net; receiver=lists.ozlabs.org) smtp.mailfrom=bewilderbeest.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.a=rsa-sha256 header.s=thorn header.b=aptjzpRb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bewilderbeest.net (client-ip=71.19.156.171; helo=thorn.bewilderbeest.net; envelope-from=zev@bewilderbeest.net; receiver=lists.ozlabs.org)
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cqr5V03t2z2yjw
	for <linux-aspeed@lists.ozlabs.org>; Mon, 20 Oct 2025 20:40:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
	s=thorn; t=1760953240;
	bh=OCbONFN78XpgRKAC0O9n8v5Ot2s4SJuk+oXKqyYYcm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aptjzpRbLNK18PePpTlYK3Ta3tm2B6yYpVnLCfkvKXEfjhNNsUocyvhpodPmW0RkQ
	 XbIVRPvkYeiN+LQR7b4xuv9p8RAWaVVuvm4PvRXEdlpSb/YJmzRcAGorehH7XYDEdi
	 Oc8ODPoqb2YI4tkvMxpHazLfnCJFMCt6GB29oHdk=
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:713c:eb00::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: zev)
	by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 94B0B1BF;
	Mon, 20 Oct 2025 02:40:40 -0700 (PDT)
Date: Mon, 20 Oct 2025 02:40:33 -0700
From: Zev Weiss <zev@bewilderbeest.net>
To: Tan Siewert <tan@siewert.io>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ARM: dts: aspeed: add asrock x470d4u bmc
Message-ID: <c6ee0814-1d36-45b5-8598-2a30efeee5a5@hatter.bewilderbeest.net>
References: <20251011112124.17588-1-tan@siewert.io>
 <20251011112124.17588-3-tan@siewert.io>
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
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251011112124.17588-3-tan@siewert.io>

On Sat, Oct 11, 2025 at 04:21:20AM PDT, Tan Siewert wrote:
>The ASRock Rack X470D4U X470D4U is a single-socket X470-based microATX
>motherboard for Ryzen processors with an AST2500 BMC and either 32MB or
>64MB SPI flash.
>
>This mainboard exists in three known "flavors" which only differ in the
>used host NIC, the BMC SPI size and some parts that may be un-populated.
>
>To keep the complexity low with the BMC SPI, use the 32MB layout
>regardless of the used SPI or mainboard flavor.
>
>Signed-off-by: Tan Siewert <tan@siewert.io>
>---
>v2:
>  - fix led node names [robh]
>  - fix missing gfx memory region and other offenses [Tan]
>---
> arch/arm/boot/dts/aspeed/Makefile             |   1 +
> .../dts/aspeed/aspeed-bmc-asrock-x470d4u.dts  | 350 ++++++++++++++++++
> 2 files changed, 351 insertions(+)
> create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts
>
>diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
>index 0f0b5b707654..c601af36915e 100644
>--- a/arch/arm/boot/dts/aspeed/Makefile
>+++ b/arch/arm/boot/dts/aspeed/Makefile
>@@ -13,6 +13,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
> 	aspeed-bmc-asrock-e3c256d4i.dtb \
> 	aspeed-bmc-asrock-romed8hm3.dtb \
> 	aspeed-bmc-asrock-spc621d8hm3.dtb \
>+	aspeed-bmc-asrock-x470d4u.dtb \
> 	aspeed-bmc-asrock-x570d4u.dtb \
> 	aspeed-bmc-asus-x4tf.dtb \
> 	aspeed-bmc-bytedance-g220a.dtb \
>diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts
>new file mode 100644
>index 000000000000..e9804b0ace9f
>--- /dev/null
>+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts
>@@ -0,0 +1,350 @@
>+// SPDX-License-Identifier: GPL-2.0+
>+/dts-v1/;
>+
>+#include "aspeed-g5.dtsi"
>+#include <dt-bindings/gpio/aspeed-gpio.h>
>+#include <dt-bindings/leds/common.h>
>+#include <dt-bindings/interrupt-controller/irq.h>
>+
>+/ {
>+	model = "Asrock Rack X470D4U-series BMC";
>+	compatible = "asrock,x470d4u-bmc", "aspeed,ast2500";
>+
>+	aliases {
>+		serial4 = &uart5;
>+	};
>+
>+	chosen {
>+		stdout-path = &uart5;
>+	};
>+
>+	iio-hwmon {
>+		compatible = "iio-hwmon";
>+		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>, <&adc 4>,
>+			<&adc 5>, <&adc 6>, <&adc 7>, <&adc 8>, <&adc 9>,
>+			<&adc 10>, <&adc 11>, <&adc 12>;
>+	};
>+
>+	leds {
>+		compatible = "gpio-leds";
>+
>+		led-heartbeat {
>+			/* led-heartbeat-n */
>+			gpios = <&gpio ASPEED_GPIO(H, 6) GPIO_ACTIVE_LOW>;
>+			color = <LED_COLOR_ID_GREEN>;
>+			function = LED_FUNCTION_HEARTBEAT;
>+			linux,default-trigger = "timer";
>+		};
>+
>+		led-systemfault {
>+			/* led-fault-n */
>+			gpios = <&gpio ASPEED_GPIO(Z, 2) GPIO_ACTIVE_LOW>;
>+			color = <LED_COLOR_ID_AMBER>;
>+			function = LED_FUNCTION_FAULT;
>+			panic-indicator;
>+		};
>+
>+		led-identify {
>+			/* led-identify-n */
>+			gpios = <&gpio ASPEED_GPIO(D, 6) GPIO_ACTIVE_LOW>;
>+		};
>+	};
>+
>+	memory@80000000 {
>+		reg = <0x80000000 0x20000000>;
>+	};
>+
>+	reserved-memory {
>+		#address-cells = <1>;
>+		#size-cells = <1>;
>+		ranges;
>+
>+		pci_memory: region@9a000000 {
>+			no-map;
>+			reg = <0x9a000000 0x00010000>; /* 64K */
>+		};
>+
>+		video_engine_memory: jpegbuffer {
>+			size = <0x02800000>;	/* 40M */
>+			alignment = <0x01000000>;
>+			compatible = "shared-dma-pool";
>+			reusable;
>+		};
>+
>+		gfx_memory: framebuffer {
>+			size = <0x01000000>;
>+			alignment = <0x01000000>;
>+			compatible = "shared-dma-pool";
>+			reusable;
>+		};
>+	};
>+};
>+
>+&adc {
>+	status = "okay";
>+	pinctrl-names = "default";
>+	pinctrl-0 = <&pinctrl_adc0_default		/* 3VSB */
>+			&pinctrl_adc1_default		/* 5VSB */
>+			&pinctrl_adc2_default		/* VCPU */
>+			&pinctrl_adc3_default		/* VSOC */
>+			&pinctrl_adc4_default		/* VCCM */
>+			&pinctrl_adc5_default		/* APU-VDDP */
>+			&pinctrl_adc6_default		/* 1V05-PROM-S5 */
>+			&pinctrl_adc7_default		/* 2V5-PROM */
>+			&pinctrl_adc8_default		/* 1V05-PROM-RUN */
>+			&pinctrl_adc9_default		/* VBAT */
>+			&pinctrl_adc10_default		/* 3V */
>+			&pinctrl_adc11_default		/* 5V */
>+			&pinctrl_adc12_default>;	/* 12V */
>+};
>+
>+&ehci1 {
>+	status = "okay";
>+};
>+
>+/*
>+ * Although some board flavors have a 64MB SPI, use the
>+ * 32MB SPI layout to be compatible with all boards.
>+ */
>+&fmc {
>+	status = "okay";
>+	flash@0 {
>+		status = "okay";
>+		label = "bmc";
>+		m25p,fast-read;
>+		spi-max-frequency = <10000000>;
>+#include "openbmc-flash-layout.dtsi"
>+	};
>+};

Hmm -- I can see the simplicity argument, but it seems a bit of a shame 
to let the other 32MB go to waste on boards with 64MB chips (especially 
given how tight a fit OpenBMC is getting in 32MB these days).

Could we maybe have an aspeed-bmc-asrock-x470d4u-64.dts alongside this 
one that #includes it and then drops in the 64M layout over the default 
32?  You could then arrange for a flag in the OpenBMC bitbake recipes to 
opt in to using that dts if you want to.


Zev


