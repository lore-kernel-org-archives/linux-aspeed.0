Return-Path: <linux-aspeed+bounces-2265-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D5B4CAC59A
	for <linux-aspeed@archiver.kernel.org>; Thu, 18 Sep 2025 00:02:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cRwnM09Lhz302b;
	Thu, 18 Sep 2025 10:02:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758132283;
	cv=none; b=BNDOpBvceniR/XuCmCYkQfvIQEC+aBAtOymqnNjNlj0d3Kcg+GW6ixF0eq06kcd57ORhVabqAjZSJPRmQ7zBQ6BAOPyuV9tm57sZJj+WRidV5IfylG9T+OOv5XLrhG9qGI27vhhg58ijbrvfCIQeRh1NfK9AHolCdAibYuIgZUyEcpQLk1UmA0VEGQHahUrq8M6E0AxzJwZqGbQmBKpBYjA1PbeHYUYx3lB0YOaIUU8Q5AWPNRE/CM90qBxODbv+5kPgd6bIN329zlIAfTcr9uwiu2R7FVMdmAkUs1GOKoRh4eCi307prjBK0hjsZfpvQQnWfTH/XFwHZfjFImKJfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758132283; c=relaxed/relaxed;
	bh=WHdjN7iBFNd95rgW8CjggDWZQNqH0UFSGTpH0h/SiDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/VLEvWDBlO6OPr8KOCayg8OFEIM1+4vS9lwxjZkGMzYvvolEkhnP+ie6selfojCZ21c8tNa6S9QwkeP5kA16XsITd2pUaulIcE8Qzy4YoTrEYr0jAB3/6xpRVzB02hNuJ7SUBUCtbWWuKqkG3KjW7/MxX7dhb/vfCF2aawfwCtRkr20uV7jBP2ngcg0kHZaazDzE5hIiC6FSS6lCK5i5xAH2Jrl5nNpVC+7ywiLbIyB2s00m5915oI30BE3EtrlVBjuEkLIVn547ynht9+FeC+HVQi9f5zjV9Ncin3uyBqB1WGMRJ76aLyg+RoitW9i6cBBwz+PlN2Ul78+gzLmXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bsdio.com; dkim=pass (2048-bit key; unprotected) header.d=bsdio.com header.i=@bsdio.com header.a=rsa-sha256 header.s=fm2 header.b=wDSB89Zm; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=EkXS4VR2; dkim-atps=neutral; spf=pass (client-ip=103.168.172.153; helo=fhigh-a2-smtp.messagingengine.com; envelope-from=rebecca@bsdio.com; receiver=lists.ozlabs.org) smtp.mailfrom=bsdio.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bsdio.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bsdio.com header.i=@bsdio.com header.a=rsa-sha256 header.s=fm2 header.b=wDSB89Zm;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=EkXS4VR2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bsdio.com (client-ip=103.168.172.153; helo=fhigh-a2-smtp.messagingengine.com; envelope-from=rebecca@bsdio.com; receiver=lists.ozlabs.org)
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cRmr86skdz2yMh
	for <linux-aspeed@lists.ozlabs.org>; Thu, 18 Sep 2025 04:04:40 +1000 (AEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A886A1400074;
	Wed, 17 Sep 2025 14:04:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 17 Sep 2025 14:04:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsdio.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1758132278; x=
	1758218678; bh=WHdjN7iBFNd95rgW8CjggDWZQNqH0UFSGTpH0h/SiDE=; b=w
	DSB89Zm+0XXO/IOUpvCnwEk228XNx6cr8TxFH5lGbb+WfKt2n5lmYNSim27DzjEJ
	3Ui2Ej5CjU06SavdHxS/EEwKX54/1/xgzxzFauxvXICMzCpL7PTBRKekjYObxTYL
	rSiCGkLxTCcw7XLUFr2jaqTartHtnrPN86KaoeH8gRmL5Ou699oIiylxHxNLs3VT
	tkLQyA1jDKGAv35xoZqHbAfKzUi54JD2ltqFV/isqzWbLhZpJuViVaAp1l4YjfJH
	1GVbCpIJR32qX6LIjoC16uJja6zBG5d8kTf+4Fv+6dVpVj880g0dnaINLJ6FXmiF
	nU8LMn6BW2z7W2iUkHJfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758132278; x=1758218678; bh=W
	HdjN7iBFNd95rgW8CjggDWZQNqH0UFSGTpH0h/SiDE=; b=EkXS4VR2yLjQnpf+0
	bUi+MnN7/q3hel46TliZuX+wFtAlFNFUdBvBS8b3KKaFZkGeUvtD7y8QRkLh37n6
	ng9zXDjkyHo0yS2y5YnftJiqOc2w18aqEdcyM+suBgZN610ZxgNE8zYlMbicLl/K
	PPHP8ft/uycA26hcvbcfTd4yuR+ST4TZ0QBn2MGmWzFx7bmdgY/FMNorErL7pZuI
	EsGIMcw1tgzpPwQK8mOXaWOJ9Yyl7px0aEqwoXFFOKX8i6gy+k1Lysm08HhnBXaZ
	hFOAf/jgsMAiPI1OOpzL2S8X5Lidu7V5GAymU13Q/m8yK0LmuzAQedoSYZ9dmpiF
	5NaMQ==
X-ME-Sender: <xms:NvjKaCROVSmEPNLiwhN4qXXU4Bn9Ejc_8t16tv7MBJOux95hUShbjw>
    <xme:NvjKaG-4gU6ityPW4H4keAJ1ubseotd8HTX_tXwsgo6NWKHfw5eCWuPvemDr7C-Gz
    co7UXkeR9_uJi5Ol6M>
X-ME-Received: <xmr:NvjKaCisdP4dNez45gv63okIGE_kC6nCY-P2rSWncwc5Lm05anuQZI08YF9lbejz2A3PQnK2Qdbf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeggeduvdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:NvjKaHZ2ildcYLzHmpniTT0GsTe4W94TInTIZssRTZlbiv1gsVRzSw>
    <xmx:NvjKaH-x2Gc1iIUMOIPuQO9y1cqXwKFFVCtsu11TKyV7H-AWuG93jg>
    <xmx:NvjKaJNDWvDjYO7x8-yBZJ4QNwXKwrPefK-1sLgwiYgBSmPogybDaw>
    <xmx:NvjKaEGpp1_9Ho8l8ZGIRPmVlY3ZXu6fObagB5bGWO36nE5PPaANkA>
    <xmx:NvjKaNgnNwgJRqLmyJQWA4iUxUwoYyImv48zxY_SlveeDn6a0sumol3H>
Feedback-ID: i5b994698:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 14:04:37 -0400 (EDT)
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
Subject: [PATCH v2 2/2] ARM: dts: aspeed: add device tree for ASRock Rack ALTRAD8 BMC
Date: Wed, 17 Sep 2025 12:04:26 -0600
Message-ID: <20250917180428.810751-3-rebecca@bsdio.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250917180428.810751-1-rebecca@bsdio.com>
References: <20250917180428.810751-1-rebecca@bsdio.com>
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
 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dts | 633 ++++++++++++++++++++
 2 files changed, 634 insertions(+)

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
index 000000000000..ae3ddf5f6eb7
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dts
@@ -0,0 +1,633 @@
+// SPDX-License-Identifier: GPL-2.0+
+/dts-v1/;
+
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
+		i2c50 = &nvme1;
+		i2c51 = &pcie4;
+		i2c52 = &pcie5;
+		i2c53 = &pcie6;
+		i2c54 = &pcie7;
+		i2c55 = &nvme3;
+		i2c56 = &nvme2;
+		i2c57 = &nvme0;
+		i2c58 = &nvme4;
+		i2c59 = &nvme5;
+		i2c60 = &nvme6;
+		i2c61 = &nvme7;
+		i2c62 = &nvme8;
+		i2c63 = &nvme9;
+		i2c64 = &nvme10;
+		i2c65 = &nvme11;
+	};
+
+	chosen {
+		stdout-path = "uart5:115200n8";
+	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels =	<&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>,
+				<&adc 4> ,<&adc 5>, <&adc 6>, <&adc 7>,
+				<&adc 8>, <&adc 9>, <&adc 10>, <&adc 11>,
+				<&adc 12>, <&adc 13>, <&adc 14>, <&adc 15>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-system-fault {
+			gpios = <&gpio ASPEED_GPIO(G,3) GPIO_ACTIVE_LOW>;
+			label = "platform:red:fault";
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_FAULT;
+		};
+
+		led-enclosure-identify {
+			gpios = <&gpio ASPEED_GPIO(G,0) GPIO_ACTIVE_LOW>;
+			label = "platform:green:indicator";
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_INDICATOR;
+		};
+
+		led-fan1-fault {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&pca0 0 GPIO_ACTIVE_LOW>;
+			label = "fan1:red:fault";
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_FAULT;
+		};
+
+		led-fan2-fault {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&pca0 1 GPIO_ACTIVE_LOW>;
+			label = "fan2:red:fault";
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_FAULT;
+		};
+
+		led-fan3-fault {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&pca0 2 GPIO_ACTIVE_LOW>;
+			label = "fan3:red:fault";
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_FAULT;
+		};
+
+		led-fan4-fault {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&pca0 3 GPIO_ACTIVE_LOW>;
+			label = "fan4:red:fault";
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_FAULT;
+		};
+
+		led-fan5-fault {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&pca0 4 GPIO_ACTIVE_LOW>;
+			label = "fan5:red:fault";
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_FAULT;
+		};
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
+			compatible = "shared-dma-pool";
+			size = <0x01000000>;
+			alignment = <0x01000000>;
+			reusable;
+		};
+
+		vga_memory: framebuffer@9f000000 {
+			no-map;
+			reg = <0x9f000000 0x01000000>; /* 16M */
+		};
+
+		video_engine_memory: jpegbuffer {
+			compatible = "shared-dma-pool";
+			size = <0x02000000>;	/* 32M */
+			alignment = <0x01000000>;
+			reusable;
+		};
+	};
+};
+
+&adc {
+	status = "okay";
+};
+
+&fmc {
+	flash@0 {
+		label = "bmc";
+		m25p,fast-read;
+		spi-max-frequency = <50000000>;
+#include "openbmc-flash-layout-64.dtsi"
+	};
+};
+
+&gfx {
+	memory-region = <&gfx_memory>;
+};
+
+&gpio {
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
+
+&i2c0 {
+	bus-frequency = <100000>;
+
+	ipmb@10 {
+		compatible = "ipmb-dev";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+		i2c-protocol;
+	};
+
+};
+
+&i2c1 {
+	bus-frequency = <100000>;
+
+	i2c-mux1@73 {
+		compatible = "nxp,pca9548";
+		reg = <0x73>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		nvme1: i2c@0 {
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
+		nvme3: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		nvme2: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		nvme0: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
+	};
+
+	i2c-mux2@75 {
+		compatible = "nxp,pca9548";
+		reg = <0x75>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		nvme4: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		nvme5: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		nvme6: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		nvme7: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+
+		nvme8: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+
+		nvme9: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		nvme10: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		nvme11: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
+	};
+};
+
+&i2c2 {
+	bus-frequency = <100000>;
+
+	smpro@4f {
+		compatible = "ampere,smpro";
+		reg = <0x4f>;
+	};
+};
+
+&i2c3 {
+	// PSU FRU
+	eeprom@38 {
+		compatible = "atmel,24c02";
+		reg = <0x38>;
+	};
+};
+
+&i2c4 {
+	bus-frequency = <100000>;
+
+	hardware-monitor@29 {
+		compatible = "nuvoton,nct7802";
+		reg = <0x29>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		channel@0 { /* LTD */
+			reg = <0>;
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
+	temperature-sensor@4c {
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
+	bus-frequency = <100000>;
+
+	rtc@6f {
+		compatible = "isil,isl1208";
+		reg = <0x6f>;
+	};
+};
+
+&i2c7 {
+	bus-frequency = <100000>;
+
+	// BMC FRU
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
+	bus-frequency = <100000>;
+
+	pca0: gpio@1c {
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
+
+		gpio@1 {
+			reg = <1>;
+		};
+
+		gpio@2 {
+			reg = <2>;
+		};
+
+		gpio@3 {
+			reg = <3>;
+		};
+
+		gpio@4 {
+			reg = <4>;
+		};
+
+		gpio@5 {
+			reg = <5>;
+		};
+
+		gpio@6 {
+			reg = <6>;
+		};
+
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
+	bus-frequency = <100000>;
+
+	ssif-bmc@10 {
+		compatible = "ssif-bmc";
+		reg = <0x10>;
+	};
+};
+
+// Connected to host Intel X550 (ALTRAD8UD-1L2T) or
+// Broadcom BCM57414 (ALTRAD8UD2-1L2Q) interface
+&mac0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii1_default>;
+
+	clocks = <&syscon ASPEED_CLK_GATE_MAC1CLK>,
+		 <&syscon ASPEED_CLK_MAC1RCLK>;
+	clock-names = "MACCLK", "RCLK";
+
+	use-ncsi;
+
+	nvmem-cells = <&eth0_macaddress>;
+	nvmem-cell-names = "mac-address";
+};
+
+// Connected to Realtek RTL8211E
+&mac1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii2_default &pinctrl_mdio2_default>;
+
+	nvmem-cells = <&eth1_macaddress>;
+	nvmem-cell-names = "mac-address";
+};
+
+&pinctrl {
+	aspeed,external-nodes = <&gfx &lhc>;
+};
+
+&pwm_tacho {
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
+
+	fan@1 {
+		reg = <0x01>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x01 0x09>;
+	};
+
+	fan@2 {
+		reg = <0x02>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x02 0x0a>;
+	};
+
+	fan@3 {
+		reg = <0x03>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x03 0x0b>;
+	};
+
+	fan@4 {
+		reg = <0x04>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x04 0x0c>;
+	};
+
+	fan@5 {
+		reg = <0x05>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x05 0x0d>;
+	};
+
+	fan@6 {
+		reg = <0x06>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x06 0x0e>;
+	};
+
+	fan@7 {
+		reg = <0x07>;
+		aspeed,fan-tach-ch = /bits/ 8 <0x07 0x0f>;
+	};
+};
+
+&spi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default>;
+
+	flash@0 {
+		m25p,fast-read;
+		label = "pnor";
+		spi-max-frequency = <100000000>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			code@400000 {
+				reg = <0x400000 0x1C00000>;
+				label = "pnor-code";
+			};
+
+			tfa@400000 {
+				reg = <0x400000 0x200000>;
+				label = "pnor-tfa";
+			};
+
+			uefi@600000 {
+				reg = <0x600000 0x1A00000>;
+				label = "pnor-uefi";
+			};
+		};
+	};
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd1_default
+			 &pinctrl_rxd1_default
+			 &pinctrl_ncts1_default
+			 &pinctrl_nrts1_default>;
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd2_default
+			 &pinctrl_rxd2_default>;
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd3_default
+			 &pinctrl_rxd3_default>;
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd4_default
+			 &pinctrl_rxd4_default>;
+};
+
+// The BMC's uart
+&uart5 {
+	status = "okay";
+};
+
+&vhub {
+	status = "okay";
+};
+
+&video {
+	memory-region = <&video_engine_memory>;
+};
-- 
2.47.3


