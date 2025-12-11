Return-Path: <linux-aspeed+bounces-3092-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B08D41C37
	for <linux-aspeed@archiver.kernel.org>; Thu, 11 Dec 2025 13:46:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dRv4g661Hz2xPB;
	Fri, 12 Dec 2025 00:46:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765460771;
	cv=none; b=UbzyggCFHn0V3+4roeB5icBhoZRhx+jOHWo0Z8zWDzY4/l4MfCxe+M4ND+fFZ8+3zI2hnxynoGrzXNChH/Y3fJ2vq2CJwYYV0RNUdeHTvx4evbBa4R6mE1pGIQsVRBtJdBD7wzjKpAhA17cFJoS7ysa4Kt/OQsoG1hZaiyBx96jDRpheId3syD7vgJt5dDYwTQSvb/U5nSMApn5u2wEfvhLuizbBY8LnO9Cm39vYga8V5blkNhf4r9dmID9wuVZ8f60GjqLr5UVbPdTE7v5nqs2RCXMGqDYdzW0OC8Ul4P9zRTL8rwG/8ghR/NC0zLR3JX/HcLxQi8bocZTvc35paA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765460771; c=relaxed/relaxed;
	bh=YDceBH4BViHEy/78S001Ju24tMF2FgRpdav14uUzDD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ilr+pLcrqYQTh+T+9dIx+CTZ/quZbanXwWVBJg821lIrL9n8LU6cU5FJpKjXSTIw7w3QHVcbRgmLaxlzUUoNZ2IQXSnFvr4IxNEIqyyTkRdI1Vc5txHdFUrIZMtYCbDAPoNITvt0SDr2TUjDY6QQvYnvxcs2SmT3lSh3n8ezoowAkwd3ZU1pi54aO5angEk8syUpl5LMFKTyIY2zojphZNG5z/vdJHFeSIukaT/Ya+LQXZyZDx8Zwg8WwXe7Gp/8H6dHkHRkuq2o8M0aIxngSCSROb5nCV/GjRgelxWyHWICFUPWWuXsYmnAlhQdypxvK+PdEAsh3BMA28Cje5m/6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bsdio.com; dkim=pass (2048-bit key; unprotected) header.d=bsdio.com header.i=@bsdio.com header.a=rsa-sha256 header.s=fm2 header.b=rrpUVZIY; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=ZS66n9XF; dkim-atps=neutral; spf=pass (client-ip=202.12.124.147; helo=fout-b4-smtp.messagingengine.com; envelope-from=rebecca@bsdio.com; receiver=lists.ozlabs.org) smtp.mailfrom=bsdio.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bsdio.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bsdio.com header.i=@bsdio.com header.a=rsa-sha256 header.s=fm2 header.b=rrpUVZIY;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=ZS66n9XF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bsdio.com (client-ip=202.12.124.147; helo=fout-b4-smtp.messagingengine.com; envelope-from=rebecca@bsdio.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 505 seconds by postgrey-1.37 at boromir; Fri, 12 Dec 2025 00:46:08 AEDT
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dRv4c6Lf3z2xNk
	for <linux-aspeed@lists.ozlabs.org>; Fri, 12 Dec 2025 00:46:08 +1100 (AEDT)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id E58CA1D000D0;
	Thu, 11 Dec 2025 08:37:43 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 11 Dec 2025 08:37:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsdio.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1765460263; x=
	1765546663; bh=YDceBH4BViHEy/78S001Ju24tMF2FgRpdav14uUzDD4=; b=r
	rpUVZIY6ui6gWcdjeNDPklKyZfS+2Qk1qFYUslXhvDoLzVN9F+hlWqJKa1Z5wouO
	tJCcB7oOhEle/NXX2l/LhWN7doC26QGACbmz1P9yIoH/71ZbFmjISttbx77SevBU
	+dkA/ykm887L7XKiz+Z4x3CISWTgFaaHm6TkxMISkAmJd2Oc4i5beQdIMd0htrpQ
	datkB2J+AEqLuLltjy9omaAi8G3kyZo6NRVBeuXgI3Cksm+uLkXEIIAlZitUlq3F
	LLe4tEHaheaTWTlz8WVjW5+dka6NZaM+KEs8m8J64DmXPJpGYQ6wlsmFafJ3oswB
	C4tmaSXXaV0nIeqmcQP3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1765460263; x=1765546663; bh=Y
	DceBH4BViHEy/78S001Ju24tMF2FgRpdav14uUzDD4=; b=ZS66n9XFKkVoZZTa0
	DGvLdueOYiwcuFjNKsSxvGcLeHHH2yVr1Ac4QaPeBo5zez6F9F68icO1j/6Q1urA
	uLM8kmB9mOrAi6pZal+4GUFXCXpAgRUk4UewGQU/EHLc9cuds87vLQGuo3lCSll/
	2ss3VqRrLjgUIpvWgtIKIb0MwzDqoy97dqt88zHyYD+NYgak3n7muM9qbPVYQU6G
	AEnrri1WeXrx3IEApEWyYW0mKoS1ES+h+Mak/6zD9rRhxBb5jvUvy94pS7eKixmi
	HSjNnUeJP4WG6Iuddm3ILrx1Sv/1zCeJdTm1Fe4LyDeemdE9LSrOxocNoyCZShNH
	Vz4tA==
X-ME-Sender: <xms:J8k6aTnoOLZ2mxe9K0fTok_Ct-aw2BypA5eYm7oSCz4PtZQpHPaFog>
    <xme:J8k6ae_naGTrvomC6Zt2br9sahTceBOQWQCZpv_JZB7TvYzEjvPaVkkXjFf7GONfN
    GHqZ6JH0NbCKrZuFJ_0bykqYG3ci-glRVY6xPrXZ8CAVBSVwCsUushd>
X-ME-Received: <xmr:J8k6aZKI-NzgYirDCW2n4kpo496Yw3o_7zKKSBmjSYfqebbkqPwimVRt3Ce_DlcVgtkq8NAQrBJ6ZsUq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftvggsvggttggr
    ucevrhgrnhcuoehrvggsvggttggrsegsshguihhordgtohhmqeenucggtffrrghtthgvrh
    hnpeegffeuueelvdeggfdvvdfgtedvudfhfeekudekieektddukeefteetieefvdelfeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrvggsvg
    gttggrsegsshguihhordgtohhmpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodguthes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhovghlsehjmhhsrdhiugdrrghupdhrtg
    hpthhtoheprghnughrvgifsegtohguvggtohhnshhtrhhutghtrdgtohhmrdgruhdprhgt
    phhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggr
    ugdrohhrghdprhgtphhtthhopehlihhnuhigqdgrshhpvggvugeslhhishhtshdrohiilh
    grsghsrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:J8k6abjQhzVZukqwFxts_6yroMGDFpswMnxLNraZ4niMl9Rl0OXu8g>
    <xmx:J8k6ad9P6UbaEMKgJrVuOFIG8l56MvgmYle2rGxuap7Fsetf2-eXQQ>
    <xmx:J8k6aYP7GjhETDZhO2exQiSOmioVUHaUGo-O1TbP5f4G3ps0kF7prg>
    <xmx:J8k6aZDTIjH7nnnl3cvxvsTRQUEnVdjQFiBu4wFLfucRCAHmZsZzJg>
    <xmx:J8k6aYUizkN3ETVLPUis1klZsk2RwnTJiynEcAsgTzRsQcJvGOnFgcOl>
Feedback-ID: i5b994698:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Dec 2025 08:37:42 -0500 (EST)
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
Cc: Rebecca Cran <rebecca@bsdio.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>
Subject: [PATCH v4 2/2] ARM: dts: aspeed: add device tree for ASRock Rack ALTRAD8 BMC
Date: Thu, 11 Dec 2025 06:37:19 -0700
Message-ID: <20251211133721.18269-3-rebecca@bsdio.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251211133721.18269-1-rebecca@bsdio.com>
References: <20251211133721.18269-1-rebecca@bsdio.com>
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
 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dts | 625 ++++++++++++++++++++
 2 files changed, 626 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index 9adf9278dc94..f073f126ddac 100644
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
index 000000000000..b60046fd214b
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dts
@@ -0,0 +1,625 @@
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
+		led-heartbeat {
+			gpios = <&gpio ASPEED_GPIO(G,0) GPIO_ACTIVE_LOW>;
+			label = "platform:green:heartbeat";
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_INDICATOR;
+			linux,default-trigger = "timer";
+		};
+
+		led-fan1-fault {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&io_expander0 0 GPIO_ACTIVE_LOW>;
+			label = "fan1:red:fault";
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_FAULT;
+		};
+
+		led-fan2-fault {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&io_expander0 1 GPIO_ACTIVE_LOW>;
+			label = "fan2:red:fault";
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_FAULT;
+		};
+
+		led-fan3-fault {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&io_expander0 2 GPIO_ACTIVE_LOW>;
+			label = "fan3:red:fault";
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_FAULT;
+		};
+
+		led-fan4-fault {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&io_expander0 3 GPIO_ACTIVE_LOW>;
+			label = "fan4:red:fault";
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_FAULT;
+		};
+
+		led-fan5-fault {
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&io_expander0 4 GPIO_ACTIVE_LOW>;
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
+	status = "okay";
+
+	flash@0 {
+		label = "bmc";
+		m25p,fast-read;
+		spi-max-frequency = <50000000>;
+		status = "okay";
+#include "openbmc-flash-layout-64.dtsi"
+	};
+};
+
+&gfx {
+	memory-region = <&gfx_memory>;
+	status = "okay";
+};
+
+&gpio {
+	gpio-line-names =
+	/*A0-A7*/	"","","","bmc-ready","","","","",
+	/*B0-B7*/	"i2c-backup-sel","","","","","","","host0-shd-ack-n",
+	/*C0-C7*/	"","","","","","","","",
+	/*D0-D7*/	"power-button-n","control-power-n","button-reset-n",
+			"host0-sysreset-n","","","power-chassis-good","",
+	/*E0-E7*/	"","s0-vrd1-vddq0123-fault-n",
+			"s0-vrd1-vddq4567-fault-n","s0-vrd0-vddc-fault-n",
+			"s0-vrd3-p0v75-fault-n","","","",
+	/*F0-F7*/	"","","ps-atx-on-n","","","","","",
+	/*G0-G7*/	"led-bmc-heartbeat-n","button-identify-n","",\
+			"led-system-fault-n","uboot-ready","bmc-salt2-n","","",
+	/*H0-H7*/	"ps-pwr-ok","uart1-mode1","uart2-mode1","uart3-mode1",
+			"uart4-mode1","","led-bmc-heartbeat","",
+	/*I0-I7*/	"","","","","","","","",
+	/*J0-J7*/	"s0-hightemp-n","","","","","","","",
+	/*K0-K7*/	"","","","","","","","",
+	/*L0-L7*/	"","","","","","","","",
+	/*M0-M7*/	"cpld-disable-bmc-n","","","","","s0-spi-auth-fail-n","","",
+	/*N0-N7*/	"","","","","","","","",
+	/*O0-O7*/	"","","","","","","","",
+	/*P0-P7*/	"","","","","","","","",
+	/*Q0-Q7*/	"","","","","","","led-identify-n",
+			"chassis-intrusion-n",
+	/*R0-R7*/	"","","ext-hightemp-n","spi0-program-sel","",
+			"output-hwm-bat-en","","",
+	/*S0-S7*/	"s0-vr-hot-n","","input-salt2-n","bmc-sysreset-n","","","","",
+	/*T0-T7*/	"","","","","","","","",
+	/*U0-U7*/	"","","","","","","","",
+	/*V0-V7*/	"","","","","","","","",
+	/*W0-W7*/	"","","","","","","","",
+	/*X0-X7*/	"","","","","","","","",
+	/*Y0-Y7*/	"","","","","","","","",
+	/*Z0-Z7*/	"","","","s0-rtc-lock","","","","",
+	/*AA0-AA7*/	"s0-rtc-int-n","","","","","pmbus-sel-n","","",
+	/*AB0-AB7*/	"host0-reboot-ack-n","s0-sys-auth-failure-n",
+			"","","","","","",
+	/*AC0-AC7*/	"s0-fault-alert","host0-ready","s0-overtemp-n",
+			"","bmc-ok","host0-special-boot","presence-cpu0",
+			"host0-shd-req-n";
+
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
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
+	status = "okay";
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
+	status = "okay";
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
+	// PSU FRU
+	eeprom@38 {
+		compatible = "atmel,24c02";
+		reg = <0x38>;
+	};
+};
+
+&i2c4 {
+	status = "okay";
+
+	temperature-sensor@29 {
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
+			reg = <1>;
+			sensor-type = "temperature";
+			temperature-mode = "thermistor";
+		};
+
+		channel@2 { /* RTD2 */
+			reg = <2>;
+			sensor-type = "temperature";
+			temperature-mode = "thermal-diode";
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
+	status = "okay";
+
+	rtc@6f {
+		compatible = "isil,isl1208";
+		reg = <0x6f>;
+	};
+};
+
+&i2c7 {
+	status = "okay";
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
+			eth1_macaddress: macaddress@3f80 {
+				reg = <0x3f80 6>;
+			};
+
+			// The offset for eth0 really is at 0x3f88.
+			// eth0 and eth1 are swapped from what might be
+			// expected.
+			eth0_macaddress: macaddress@3f88 {
+				reg = <0x3f88 6>;
+			};
+		};
+	};
+};
+
+&i2c8 {
+	status = "okay";
+
+	io_expander0: gpio@1c {
+		compatible = "nxp,pca9557";
+		reg = <0x1c>;
+		gpio-controller;
+		#gpio-cells = <2>;
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
+// Bus for accessing the SCP EEPROM
+&i2c12 {
+	status = "okay";
+};
+
+&i2c13 {
+	status = "okay";
+
+	ssif-bmc@10 {
+		compatible = "ssif-bmc";
+		reg = <0x10>;
+	};
+};
+
+// Connected to host Intel X550 (ALTRAD8UD-1L2T) or
+// Broadcom BCM57414 (ALTRAD8UD2-1L2Q) interface.
+// Unconnected on ALTRAD8UD-1L
+&mac0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii1_default>;
+	clocks = <&syscon ASPEED_CLK_GATE_MAC1CLK>,
+		 <&syscon ASPEED_CLK_MAC1RCLK>;
+	clock-names = "MACCLK", "RCLK";
+	use-ncsi;
+	nvmem-cells = <&eth0_macaddress>;
+	nvmem-cell-names = "mac-address";
+
+	status = "okay";
+};
+
+// Connected to Realtek RTL8211E
+&mac1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii2_default &pinctrl_mdio2_default>;
+
+	nvmem-cells = <&eth1_macaddress>;
+	nvmem-cell-names = "mac-address";
+
+	status = "okay";
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
+	status = "okay";
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
+	status = "okay";
+
+	// Host BIOS/UEFI EEPROM
+	flash@0 {
+		m25p,fast-read;
+		label = "pnor";
+		spi-max-frequency = <100000000>;
+		status = "okay";
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
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
+
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd2_default
+			&pinctrl_rxd2_default>;
+
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd3_default
+			&pinctrl_rxd3_default>;
+
+	status = "okay";
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd4_default
+			&pinctrl_rxd4_default>;
+
+	status = "okay";
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
+
+	status = "okay";
+};
-- 
2.47.3


