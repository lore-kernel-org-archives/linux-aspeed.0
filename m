Return-Path: <linux-aspeed+bounces-2210-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 641AECAC587
	for <linux-aspeed@archiver.kernel.org>; Thu, 11 Sep 2025 23:38:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cNDX60Jp6z2yrl;
	Fri, 12 Sep 2025 09:38:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757568039;
	cv=none; b=nGzL0xV1EUxK2IZQW+iWN90JTswdsG07XokFwYaSQFLEiDMjL7H3Lqgf8vH0GqFOyMKUZX5eUrkkjrPmEwCFX+l7jYOFW8YmedjzSl2udvwyv7m1R9Nslo12BLs4yQEIBrVvXlZ1KlMGe6imFK5nzpTbY3S8PMI2hptwnbyhVO8tM5AadZxE/0EzYCKUvGjbScXIcArMX1beKMl3h8f2IS5CdoGNyvPQYQJp/V8DrDBu0WA2QEWTNZeUhOFTigl9grsWWH6yFf2F8mVtYI1HhIaNKGNIzmG1xKe1Rv5JuVh+Nny8h5J8451SdhayC2th6QuFsyrfy9WHlh86dxTZig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757568039; c=relaxed/relaxed;
	bh=WBaE2TltC7mA72J6gMwneq1NYf0Qmt+LOks0qvJ4+fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZrUy/qtGvt5mAM86uUSRlc0uc16jCUl0a705hd1wyrd+Bu6UlVDn+vcrrF4tfHzZs5ULnSDiL01MtrJSgMobQvEz1omu5f0DCW6CStPH+xJ2/BPaMIVROHFjzP/AGZTxb2zg04v0xkkUtltbdtKOVREFx26ljsc8TYjz4YQv3EiL3ZVpvYjS1kcOoERvtugoZKdAYUsULYTUIvArA96E62o+n9P2sXbE/JeJWicaIgY/nDS0f904gssuVm2qLm1Usg47gov+6ZRBe5ObxqwL1/PTO4hAIJQcjJQfrh8Rstrc2gKChfNjWt+IuAHKyBlYV5SHigOQhDEVstsfbL2i+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bsdio.com; dkim=pass (2048-bit key; unprotected) header.d=bsdio.com header.i=@bsdio.com header.a=rsa-sha256 header.s=fm2 header.b=l3cZCQnJ; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=KDHimhVW; dkim-atps=neutral; spf=pass (client-ip=202.12.124.150; helo=fout-b7-smtp.messagingengine.com; envelope-from=rebecca@bsdio.com; receiver=lists.ozlabs.org) smtp.mailfrom=bsdio.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bsdio.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bsdio.com header.i=@bsdio.com header.a=rsa-sha256 header.s=fm2 header.b=l3cZCQnJ;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=KDHimhVW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bsdio.com (client-ip=202.12.124.150; helo=fout-b7-smtp.messagingengine.com; envelope-from=rebecca@bsdio.com; receiver=lists.ozlabs.org)
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cMm9J7192z2yFJ
	for <linux-aspeed@lists.ozlabs.org>; Thu, 11 Sep 2025 15:20:36 +1000 (AEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id C7FC41D0010E;
	Thu, 11 Sep 2025 01:10:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 11 Sep 2025 01:10:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsdio.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1757567442; x=
	1757653842; bh=WBaE2TltC7mA72J6gMwneq1NYf0Qmt+LOks0qvJ4+fw=; b=l
	3cZCQnJ94JjneRwLaYbUWAABAUrKpfLIBdpcOwxw7/cODj8ag7DVbjmc+tgDsJxb
	vs0J8tiz7eRqUCR3WFZQdThwFU04qdKvp6JivByPrnz/X6WR0s3Ow5Jlf4kdqqKg
	df6YI3eUbxrg/4+j1AWe3w3MmY87pSc5bIdVUZnTBhZ9oQyQfX422DYIetfxfaIX
	7QklV1biRlv5DBYg2tTMvFPCv5uVX0fMZzioy65tpoS+Pr4qMZB5AQOLSt+b0rsv
	GoV//VlIq0scW5OYIysvVhbwJ//52CTTowOiougWZAMC9tP5TTvNgt1aw4MKf2nd
	6eoiQIcGXhakyEmCE26aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757567442; x=1757653842; bh=W
	BaE2TltC7mA72J6gMwneq1NYf0Qmt+LOks0qvJ4+fw=; b=KDHimhVWJVdHJRKaE
	LnBZcTtDuaso0rzIYMjrGZpGDQTEsyWVbGUBbmvxYJdz9DYSbeEEc1U1UfpyWR2Z
	6T4M/pFUq0UOxM028keE3RUm7CXX/ZmcG1PjCiNcTt76uayXwg/+B1D1QrPgkuQW
	xXQoKP+ldeuZARfMmGIixRi7WXO0ckrm4ipDKcQIvNJOvxBNUqPGcGczADexTdMr
	bvpyQYHh5DsuQWbnSSL3JpulWdZS0OkePM51Cwe28i7jwY3n16VLMy5L2IiuPByS
	cy6o8VgFXktBHs1UVF17J7tvltlivO/MBp4iMz0/EqvS6EpACWaKlYn5cPc9zee2
	9wRng==
X-ME-Sender: <xms:0lnCaPjRPzXf5EBX1bxuqx5HjrXgefM-L6lPi004Ut0MJ1hriwqNlQ>
    <xme:0lnCaLNRPHPpdXgurRXZDq8tT1s38sgAAlfjr9jlodWvgMAMSqWuKFb28Ioywy4F8
    sdx_d5HGuqkyZLBnfk>
X-ME-Received: <xmr:0lnCaBwGS4rzbvfmEU2gIFUxRN1I2fN0PiRDcr4Miokf091Vn5RhpBSg4zOf4wEMpFnaC5RN3U88>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftvggsvggttggr
    ucevrhgrnhcuoehrvggsvggttggrsegsshguihhordgtohhmqeenucggtffrrghtthgvrh
    hnpeegffeuueelvdeggfdvvdfgtedvudfhfeekudekieektddukeefteetieefvdelfeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrvggsvg
    gttggrsegsshguihhordgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodguthes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhovghlsehjmhhsrdhiugdrrghupdhrtg
    hpthhtoheprghnughrvgifsegtohguvggtohhnshhtrhhutghtrdgtohhmrdgruhdprhgt
    phhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggr
    ugdrohhrghdprhgtphhtthhopehlihhnuhigqdgrshhpvggvugeslhhishhtshdrohiilh
    grsghsrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:0lnCaFr7j_u5na1OT2wTptyGabL5KOU4wbTvdlfWQaPfOteFZlkkDw>
    <xmx:0lnCaJMex21zPSVvxOsQTuOn7AZmhl6-4OrlqB86-vkZ22Bg2TD6Gg>
    <xmx:0lnCaBetTpMan8O0rXiJ5Lk9Ab7NUfMvsrDHA87MvI8biGezcB_o4Q>
    <xmx:0lnCaHUuNRYaGJdBeEX3tFXGbev__8mgbqTmn0XtWTYsJOftoMbEMw>
    <xmx:0lnCaAyrB2gHa1wwsAnSTpwzt_7TZ8wEpX-JaVLG3jOK-Q9Kp-yo85DL>
Feedback-ID: i5b994698:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Sep 2025 01:10:41 -0400 (EDT)
From: Rebecca Cran <rebecca@bsdio.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Rebecca Cran <rebecca@bsdio.com>
Subject: [PATCH 2/2] ARM: dts: aspeed: add device tree for ASRock Rack ALTRAD8 BMC
Date: Wed, 10 Sep 2025 23:10:05 -0600
Message-ID: <20250911051009.4044609-3-rebecca@bsdio.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250911051009.4044609-1-rebecca@bsdio.com>
References: <20250911051009.4044609-1-rebecca@bsdio.com>
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
Content-Transfer-Encoding: 8bit

The ALTRAD8 BMC is an Aspeed AST2500-based BMC for the ASRock Rack
ALTRAD8UD-1L2T and ALTRAD8UD2-1L2Q boards.

Signed-off-by: Rebecca Cran <rebecca@bsdio.com>
---
 arch/arm/boot/dts/aspeed/Makefile                      |   1 +
 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dts | 647 ++++++++++++++++++++
 2 files changed, 648 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index aba7451ab749..6bffb7130839 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -9,6 +9,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-ampere-mtjefferson.dtb \
 	aspeed-bmc-ampere-mtmitchell.dtb \
 	aspeed-bmc-arm-stardragon4800-rep2.dtb \
+	aspeed-bmc-asrock-altrad8.dtb \
 	aspeed-bmc-asrock-e3c246d4i.dtb \
 	aspeed-bmc-asrock-e3c256d4i.dtb \
 	aspeed-bmc-asrock-romed8hm3.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dts
new file mode 100644
index 000000000000..61f6cf8018c0
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dts
@@ -0,0 +1,647 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+#include "aspeed-g5.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/i2c/i2c.h>
+
+/ {
+	model = "ASRock ALTRAD8 BMC";
+	compatible = "asrock,altrad8-bmc", "aspeed,ast2500";
+
+	aliases {
+		serial4 = &uart5;
+		i2c50 = &m2_2;
+		i2c51 = &pcie4;
+		i2c52 = &pcie5;
+		i2c53 = &pcie6;
+		i2c54 = &pcie7;
+		i2c55 = &ocu_2;
+		i2c56 = &ocu_1;
+		i2c57 = &m2_1;
+		i2c58 = &slim1_1;
+		i2c59 = &slim2_1;
+		i2c60 = &slim3_1;
+		i2c61 = &slim4_1;
+		i2c62 = &slim1_2;
+		i2c63 = &slim2_2;
+		i2c64 = &slim3_2;
+		i2c65 = &slim4_2;
+	};
+
+	chosen {
+		stdout-path = &uart5;
+		bootargs = "console=ttyS4,115200 earlycon";
+	};
+
+	memory@80000000 {
+		reg = <0x80000000 0x20000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		gfx_memory: framebuffer {
+			size = <0x01000000>;
+			alignment = <0x01000000>;
+			compatible = "shared-dma-pool";
+			reusable;
+		};
+
+		vga_memory: framebuffer@9f000000 {
+			no-map;
+			reg = <0x9f000000 0x01000000>; /* 16M */
+		};
+
+		video_engine_memory: jpegbuffer {
+			size = <0x02000000>;	/* 32M */
+			alignment = <0x01000000>;
+			compatible = "shared-dma-pool";
+			reusable;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		systemfault {
+			gpios = <&gpio ASPEED_GPIO(G,3) GPIO_ACTIVE_LOW>;
+			label = "platform:red:fault";
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_FAULT;
+		};
+
+		enclosure_identify {
+			gpios = <&gpio ASPEED_GPIO(G,0) GPIO_ACTIVE_LOW>;
+			label = "platform:green:indicator";
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_INDICATOR;
+		};
+	};
+
+	leds-fanfail {
+		compatible = "gpio-leds";
+
+		fan1 {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&pca0 0 GPIO_ACTIVE_LOW>;
+			label = "fan1:red:fault";
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_FAULT;
+		};
+
+		fan2 {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&pca0 1 GPIO_ACTIVE_LOW>;
+			label = "fan2:red:fault";
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_FAULT;
+		};
+
+		fan3 {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&pca0 2 GPIO_ACTIVE_LOW>;
+			label = "fan3:red:fault";
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_FAULT;
+		};
+
+		fan4 {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&pca0 3 GPIO_ACTIVE_LOW>;
+			label = "fan4:red:fault";
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_FAULT;
+		};
+
+		fan5{
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&pca0 4 GPIO_ACTIVE_LOW>;
+			label = "fan5:red:fault";
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_FAULT;
+		};
+	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels =	<&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>,
+				<&adc 4> ,<&adc 5>, <&adc 6>, <&adc 7>,
+				<&adc 8>, <&adc 9>, <&adc 10>, <&adc 11>,
+				<&adc 12>, <&adc 13>, <&adc 14>, <&adc 15>;
+	};
+};
+
+&fmc {
+	status = "okay";
+	flash@0 {
+		status = "okay";
+		label = "bmc";
+		m25p,fast-read;
+		spi-max-frequency = <50000000>;
+#include "openbmc-flash-layout-64.dtsi"
+	};
+};
+
+&spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default>;
+
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "pnor";
+		spi-max-frequency = <100000000>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			code@400000 {
+				reg = <0x400000 0x1C00000>;
+				label = "pnor-code";
+			};
+			tfa@400000 {
+				reg = <0x400000 0x200000>;
+				label = "pnor-tfa";
+			};
+			uefi@600000 {
+				reg = <0x600000 0x1A00000>;
+				label = "pnor-uefi";
+			};
+		};
+	};
+};
+
+&uart1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd1_default
+			 &pinctrl_rxd1_default
+			 &pinctrl_ncts1_default
+			 &pinctrl_nrts1_default>;
+};
+
+&uart2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd2_default
+			 &pinctrl_rxd2_default>;
+};
+
+&uart3 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd3_default
+			 &pinctrl_rxd3_default>;
+};
+
+&uart4 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd4_default
+			 &pinctrl_rxd4_default>;
+};
+
+/* The BMC's uart */
+&uart5 {
+	status = "okay";
+};
+
+&mac0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii1_default>;
+	clocks = <&syscon ASPEED_CLK_GATE_MAC1CLK>,
+		 <&syscon ASPEED_CLK_MAC1RCLK>;
+	clock-names = "MACCLK", "RCLK";
+	use-ncsi;
+
+	nvmem-cells = <&eth0_macaddress>;
+	nvmem-cell-names = "mac-address";
+};
+
+&mac1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii2_default &pinctrl_mdio2_default>;
+
+	nvmem-cells = <&eth1_macaddress>;
+	nvmem-cell-names = "mac-address";
+};
+
+&i2c0 {
+	status = "okay";
+	bus-frequency = <100000>;
+
+	ipmb0@10 {
+		compatible = "ipmb-dev";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		i2c-protocol;
+	};
+
+};
+
+&i2c1 {
+	status = "okay";
+	bus-frequency = <100000>;
+
+	pca9548@73 {
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x73>;
+		i2c-mux-idle-disconnect;
+
+		m2_2: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		pcie4: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		pcie5: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		pcie6: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+
+		pcie7: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+
+		ocu_2: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		ocu_1: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		m2_1: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
+	};
+
+	pca9548@75 {
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x75>;
+		i2c-mux-idle-disconnect;
+
+		slim1_1: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		slim2_1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		slim3_1: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		slim4_1: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+
+		slim1_2: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+
+		slim2_2: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		slim3_2: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		slim4_2: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
+	};
+};
+
+&i2c2 {
+	status = "okay";
+	bus-frequency = <100000>;
+
+	smpro@4f {
+		compatible = "ampere,smpro";
+		reg = <0x4f>;
+	};
+};
+
+&i2c3 {
+	status = "okay";
+
+	power-supply@3c {
+		compatible = "pmbus";
+		reg = <0x3c>;
+	};
+
+	/* PSU FRU */
+	eeprom@38 {
+		compatible = "atmel,24c02";
+		reg = <0x38>;
+	};
+};
+
+&i2c4 {
+	status = "okay";
+	bus-frequency = <100000>;
+
+	nct7802@29 {
+		compatible = "nuvoton,nct7802";
+		reg = <0x29>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		channel@0 { /* LTD */
+			reg = <0>;
+			status = "okay";
+		};
+
+		channel@1 { /* RTD1 */
+				reg = <1>;
+				sensor-type = "temperature";
+				temperature-mode = "thermistor";
+		};
+
+		channel@2 { /* RTD2 */
+				reg = <2>;
+				sensor-type = "temperature";
+				temperature-mode = "thermal-diode";
+		};
+	};
+
+	w83773g@4c {
+		compatible = "nuvoton,w83773g";
+		reg = <0x4c>;
+	};
+};
+
+&i2c5 {
+	status = "okay";
+};
+
+&i2c6 {
+	status = "okay";
+	bus-frequency = <100000>;
+
+	rtc@6f {
+		compatible = "isil,isl1208";
+		reg = <0x6f>;
+	};
+};
+
+&i2c7 {
+	status = "okay";
+	bus-frequency = <100000>;
+
+	/* BMC FRU */
+	eeprom@57 {
+		compatible = "atmel,24c128";
+		reg = <0x57>;
+
+		nvmem-layout {
+			compatible = "fixed-layout";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			eth0_macaddress: macaddress@3f88 {
+				reg = <0x3f88 6>;
+			};
+
+			eth1_macaddress: macaddress@3f80 {
+				reg = <0x3f80 6>;
+			};
+		};
+	};
+};
+
+&i2c8 {
+	status = "okay";
+	bus-frequency = <100000>;
+
+	pca0: pca9557@1c {
+		compatible = "nxp,pca9557";
+		reg = <0x1c>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio@0 {
+			reg = <0>;
+		};
+		gpio@1 {
+			reg = <1>;
+		};
+		gpio@2 {
+			reg = <2>;
+		};
+		gpio@3 {
+			reg = <3>;
+		};
+		gpio@4 {
+			reg = <4>;
+		};
+		gpio@5 {
+			reg = <5>;
+		};
+		gpio@6 {
+			reg = <6>;
+		};
+		gpio@7 {
+			reg = <7>;
+		};
+	};
+};
+
+&i2c9 {
+	status = "okay";
+};
+
+&i2c10 {
+	status = "okay";
+};
+
+&i2c11 {
+	status = "okay";
+};
+
+&i2c12 {
+	status = "okay";
+};
+
+&i2c13 {
+	status = "okay";
+	bus-frequency = <100000>;
+
+	ssif-bmc@10 {
+		compatible = "ssif-bmc";
+		reg = <0x10>;
+	};
+};
+
+&vhub {
+	status = "okay";
+};
+
+
+&gfx {
+	status = "okay";
+	memory-region = <&gfx_memory>;
+};
+
+&pinctrl {
+	aspeed,external-nodes = <&gfx &lhc>;
+};
+
+&adc {
+	status = "okay";
+};
+
+&pwm_tacho {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm0_default
+			&pinctrl_pwm1_default
+			&pinctrl_pwm2_default
+			&pinctrl_pwm3_default
+			&pinctrl_pwm4_default
+			&pinctrl_pwm5_default
+			&pinctrl_pwm6_default
+			&pinctrl_pwm7_default>;
+
+	fan@0 {
+		reg = <0x00>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x00 0x08>;
+	};
+	fan@1 {
+		reg = <0x01>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x01 0x09>;
+	};
+	fan@2 {
+		reg = <0x02>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x02 0x0a>;
+	};
+	fan@3 {
+		reg = <0x03>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x03 0x0b>;
+	};
+	fan@4 {
+		reg = <0x04>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x04 0x0c>;
+	};
+	fan@5 {
+		reg = <0x05>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x05 0x0d>;
+	};
+	fan@6 {
+		reg = <0x06>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x06 0x0e>;
+	};
+	fan@7 {
+		reg = <0x07>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x07 0x0f>;
+	};
+};
+
+&video {
+	status = "okay";
+	memory-region = <&video_engine_memory>;
+};
+
+
+&gpio {
+	status = "okay";
+	gpio-line-names =
+	/*A0-A7*/	"","","","BMC_READY","","","","",
+	/*B0-B7*/	"i2c-backup-sel","","","","","","","host0-shd-ack-n",
+	/*C0-C7*/	"","","","","","","","",
+	/*D0-D7*/	"POWER_BUTTON","POWER_OUT","RESET_BUTTON",
+			"host0-sysreset-n","","","SYS_PWR_GD","",
+	/*E0-E7*/	"","s0-vrd1-vddq0123-fault-l",
+			"s0-vrd1-vddq4567-fault-l","s0-vrd0-vddc-fault-l",
+			"s0-vrd3-p0v75-fault-l","","","",
+	/*F0-F7*/	"","","SYS_ATX_PSON_L","","","","","",
+	/*G0-G7*/	"id-led","id-button","","","UBOOT_READY",\
+			"BMC_SALT2_L","","",
+	/*H0-H7*/	"PS_PWROK","uart1-mode1","uart2-mode1","uart3-mode1",
+			"uart4-mode1","","BMC_HB_LED","",
+	/*I0-I7*/	"","","","","","","","",
+	/*J0-J7*/	"s0-hightemp-n","","","","","","","",
+	/*K0-K7*/	"","","","","","","","",
+	/*L0-L7*/	"","","","","","","","",
+	/*M0-M7*/	"","","","","","s0-spi-auth-fail-n","","",
+	/*N0-N7*/	"","","","","","","","",
+	/*O0-O7*/	"","","","","","","","",
+	/*P0-P7*/	"","","CPLD_DISABLE_BMC","","","","","",
+	/*Q0-Q7*/	"","","ext-hightemp-n","","","","",
+			"CHASSIS_INTRUSION",
+	/*R0-R7*/	"","","EXT_HIGHTEMP_L","spi0-program-sel","",
+			"HWM_BAT_EN","","",
+	/*S0-S7*/	"s0-vr-hot-n","","","BMC_SYSRESET_L","","","","",
+	/*T0-T7*/	"","","","","","","","",
+	/*U0-U7*/	"","","","","","","","",
+	/*V0-V7*/	"","","","","","","","",
+	/*W0-W7*/	"","","","","","","","",
+	/*X0-X7*/	"","","","","","","","",
+	/*Y0-Y7*/	"SIOS3","SIOS5","SIOPWREQ","SIOONCTRL","","","","",
+	/*Z0-Z7*/	"","SIOPWRGD","","s0-rtc-lock","","","","",
+	/*AA0-AA7*/	"RTC_INT","","","","","PMBUS_SEL_N","","",
+	/*AB0-AB7*/	"host0-reboot-ack-n","s0-sys-auth-failure-n",
+			"","","","","","",
+	/*AC0-AC7*/	"s0-fault-alert","host0-ready","s0-overtemp-n",
+			"","bmc-ok","host0-special-boot","presence-cpu0",
+			"host0-shd-req-n";
+};
-- 
2.47.3


