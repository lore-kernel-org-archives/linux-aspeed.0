Return-Path: <linux-aspeed+bounces-2312-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B687CAC5A7
	for <linux-aspeed@archiver.kernel.org>; Mon, 22 Sep 2025 06:35:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cVYJf5GfGz2yrr;
	Mon, 22 Sep 2025 16:35:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=71.19.156.171
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758522930;
	cv=none; b=bb9sVO85bPoyzayBRrST/3EyxZLnsdDNIyrMDQIhyFrvpEqpT/qOLxx/IVKRNs2cqzhlZ1+a5nE+aeAa+MUYr9PfO67Tvg2BPVVsEPQi8PkduHo2Ya8OEVr9KXCR45Lcdxrsy3MaUCKRJ2f9Cw8eVLdNDpN4qb88je+rtRvaBI+uoUIwVm9iJRXkcIf0qcngWyGk7Vh2l+FmvncLcM+NG/I4Il3bMWvA+q8ZLbv6EF68HYVWiD5ESLBc6cS1A7WzoQJ0DeOlXSZNuuCroQsj37EfFwF0nrc4UfsZGJQbvSAMUm2kWt4lLh0rG0nBuVQvzHFYKG8YtlpBS40mrRtjKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758522930; c=relaxed/relaxed;
	bh=8rkcGkkSHNbg3BRN1kDct5tF5NkukCIyzIEeS3WDl34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVSHRO7HV2l8HDSDbGZ6m2JGB3sZeUPk4gj4S1NzArtvZUbicADgU9+qEE5zLEOlQiqS829nBzbXH0Jlbcf3UDCMzehM/FY9DPywgpiYimCTl9tK8nXQWVZdMLFgNgvOd/bn7C+lJVX91zIGuREEonCJ6/W9AufsF5jhdhq1KZg7xPE7WRrz/U/2b2x8pMwUUAEHpgjA6+plTOU5zhmlSP29aX/uWl/g6rPHLrTGIQgFFmpWv/1idFNcDbQaAiL3wnnnOCTudcPEwR1+AltZOLA97NA17u7krM5XqeS04MTQ1FVEPW70jEGP+dIfZVrLKCHiHbONMxg8s1Uve/kNug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net; dkim=pass (1024-bit key; unprotected) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.a=rsa-sha256 header.s=thorn header.b=Qotb+mlR; dkim-atps=neutral; spf=pass (client-ip=71.19.156.171; helo=thorn.bewilderbeest.net; envelope-from=zev@bewilderbeest.net; receiver=lists.ozlabs.org) smtp.mailfrom=bewilderbeest.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=bewilderbeest.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=bewilderbeest.net header.i=@bewilderbeest.net header.a=rsa-sha256 header.s=thorn header.b=Qotb+mlR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bewilderbeest.net (client-ip=71.19.156.171; helo=thorn.bewilderbeest.net; envelope-from=zev@bewilderbeest.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 364 seconds by postgrey-1.37 at boromir; Mon, 22 Sep 2025 16:35:27 AEST
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cVYJb6QBXz2xcC
	for <linux-aspeed@lists.ozlabs.org>; Mon, 22 Sep 2025 16:35:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
	s=thorn; t=1758522558;
	bh=8rkcGkkSHNbg3BRN1kDct5tF5NkukCIyzIEeS3WDl34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qotb+mlRjdAlDEHIdNKxb3p8iUNutOfEqykG66Udy7+RBiMRR1PuxgXa4Q8+h2uYd
	 aExoCuxRP0lnBtaKjt8U+Y74Qy3Qkk6z2h92O5P48rNAKo9GffbmWYrrlWRr24nCC5
	 OJNZYFwsIQr7s48ui0KDryP2smVGGmoDv+43fwnk=
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:713c:eb00::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: zev)
	by thorn.bewilderbeest.net (Postfix) with ESMTPSA id B8FDD1BA;
	Sun, 21 Sep 2025 23:29:17 -0700 (PDT)
Date: Sun, 21 Sep 2025 23:29:16 -0700
From: Zev Weiss <zev@bewilderbeest.net>
To: Rebecca Cran <rebecca@bsdio.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ARM: dts: aspeed: add device tree for ASRock Rack
 ALTRAD8 BMC
Message-ID: <66c5bf80-a3ef-4984-82ce-6d1720b15d38@hatter.bewilderbeest.net>
References: <20250917180428.810751-1-rebecca@bsdio.com>
 <20250917180428.810751-3-rebecca@bsdio.com>
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
In-Reply-To: <20250917180428.810751-3-rebecca@bsdio.com>

Hi Rebecca,

Thanks for posting this -- a handful of small comments below...


Zev

On Wed, Sep 17, 2025 at 11:04:26AM PDT, Rebecca Cran wrote:
>The ALTRAD8 BMC is an Aspeed AST2500-based BMC for the ASRock Rack
>ALTRAD8UD-1L2T and ALTRAD8UD2-1L2Q boards.
>
>Signed-off-by: Rebecca Cran <rebecca@bsdio.com>
>---
> arch/arm/boot/dts/aspeed/Makefile                      |   1 +
> arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dts | 633 ++++++++++++++++++++
> 2 files changed, 634 insertions(+)
>
>diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
>index aba7451ab749..6bffb7130839 100644
>--- a/arch/arm/boot/dts/aspeed/Makefile
>+++ b/arch/arm/boot/dts/aspeed/Makefile
>@@ -9,6 +9,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
> 	aspeed-bmc-ampere-mtjefferson.dtb \
> 	aspeed-bmc-ampere-mtmitchell.dtb \
> 	aspeed-bmc-arm-stardragon4800-rep2.dtb \
>+	aspeed-bmc-asrock-altrad8.dtb \
> 	aspeed-bmc-asrock-e3c246d4i.dtb \
> 	aspeed-bmc-asrock-e3c256d4i.dtb \
> 	aspeed-bmc-asrock-romed8hm3.dtb \
>diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dts
>new file mode 100644
>index 000000000000..ae3ddf5f6eb7
>--- /dev/null
>+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dts
>@@ -0,0 +1,633 @@
>+// SPDX-License-Identifier: GPL-2.0+
>+/dts-v1/;
>+
>+#include "aspeed-g5.dtsi"
>+#include <dt-bindings/gpio/aspeed-gpio.h>
>+#include <dt-bindings/leds/common.h>
>+#include <dt-bindings/i2c/i2c.h>
>+
>+/ {
>+	model = "ASRock ALTRAD8 BMC";
>+	compatible = "asrock,altrad8-bmc", "aspeed,ast2500";
>+
>+	aliases {
>+		serial4 = &uart5;
>+		i2c50 = &nvme1;
>+		i2c51 = &pcie4;
>+		i2c52 = &pcie5;
>+		i2c53 = &pcie6;
>+		i2c54 = &pcie7;
>+		i2c55 = &nvme3;
>+		i2c56 = &nvme2;
>+		i2c57 = &nvme0;
>+		i2c58 = &nvme4;
>+		i2c59 = &nvme5;
>+		i2c60 = &nvme6;
>+		i2c61 = &nvme7;
>+		i2c62 = &nvme8;
>+		i2c63 = &nvme9;
>+		i2c64 = &nvme10;
>+		i2c65 = &nvme11;
>+	};
>+
>+	chosen {
>+		stdout-path = "uart5:115200n8";
>+	};
>+
>+	iio-hwmon {
>+		compatible = "iio-hwmon";
>+		io-channels =	<&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>,
>+				<&adc 4> ,<&adc 5>, <&adc 6>, <&adc 7>,
>+				<&adc 8>, <&adc 9>, <&adc 10>, <&adc 11>,
>+				<&adc 12>, <&adc 13>, <&adc 14>, <&adc 15>;
>+	};
>+
>+	leds {
>+		compatible = "gpio-leds";
>+
>+		led-system-fault {
>+			gpios = <&gpio ASPEED_GPIO(G,3) GPIO_ACTIVE_LOW>;
>+			label = "platform:red:fault";
>+			color = <LED_COLOR_ID_RED>;
>+			function = LED_FUNCTION_FAULT;
>+		};
>+
>+		led-enclosure-identify {
>+			gpios = <&gpio ASPEED_GPIO(G,0) GPIO_ACTIVE_LOW>;
>+			label = "platform:green:indicator";
>+			color = <LED_COLOR_ID_GREEN>;
>+			function = LED_FUNCTION_INDICATOR;
>+		};
>+
>+		led-fan1-fault {
>+			retain-state-shutdown;
>+			default-state = "off";
>+			gpios = <&pca0 0 GPIO_ACTIVE_LOW>;
>+			label = "fan1:red:fault";
>+			color = <LED_COLOR_ID_RED>;
>+			function = LED_FUNCTION_FAULT;
>+		};
>+
>+		led-fan2-fault {
>+			retain-state-shutdown;
>+			default-state = "off";
>+			gpios = <&pca0 1 GPIO_ACTIVE_LOW>;
>+			label = "fan2:red:fault";
>+			color = <LED_COLOR_ID_RED>;
>+			function = LED_FUNCTION_FAULT;
>+		};
>+
>+		led-fan3-fault {
>+			retain-state-shutdown;
>+			default-state = "off";
>+			gpios = <&pca0 2 GPIO_ACTIVE_LOW>;
>+			label = "fan3:red:fault";
>+			color = <LED_COLOR_ID_RED>;
>+			function = LED_FUNCTION_FAULT;
>+		};
>+
>+		led-fan4-fault {
>+			retain-state-shutdown;
>+			default-state = "off";
>+			gpios = <&pca0 3 GPIO_ACTIVE_LOW>;
>+			label = "fan4:red:fault";
>+			color = <LED_COLOR_ID_RED>;
>+			function = LED_FUNCTION_FAULT;
>+		};
>+
>+		led-fan5-fault {
>+			retain-state-shutdown;
>+			default-state = "off";
>+			gpios = <&pca0 4 GPIO_ACTIVE_LOW>;
>+			label = "fan5:red:fault";
>+			color = <LED_COLOR_ID_RED>;
>+			function = LED_FUNCTION_FAULT;
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
>+		gfx_memory: framebuffer {
>+			compatible = "shared-dma-pool";
>+			size = <0x01000000>;
>+			alignment = <0x01000000>;
>+			reusable;
>+		};
>+
>+		vga_memory: framebuffer@9f000000 {
>+			no-map;
>+			reg = <0x9f000000 0x01000000>; /* 16M */
>+		};
>+
>+		video_engine_memory: jpegbuffer {
>+			compatible = "shared-dma-pool";
>+			size = <0x02000000>;	/* 32M */
>+			alignment = <0x01000000>;
>+			reusable;
>+		};
>+	};
>+};
>+
>+&adc {
>+	status = "okay";
>+};
>+
>+&fmc {
>+	flash@0 {
>+		label = "bmc";
>+		m25p,fast-read;
>+		spi-max-frequency = <50000000>;
>+#include "openbmc-flash-layout-64.dtsi"
>+	};
>+};
>+
>+&gfx {
>+	memory-region = <&gfx_memory>;
>+};
>+
>+&gpio {
>+	gpio-line-names =
>+	/*A0-A7*/	"","","","BMC_READY","","","","",
>+	/*B0-B7*/	"i2c-backup-sel","","","","","","","host0-shd-ack-n",
>+	/*C0-C7*/	"","","","","","","","",
>+	/*D0-D7*/	"POWER_BUTTON","POWER_OUT","RESET_BUTTON",
>+			"host0-sysreset-n","","","SYS_PWR_GD","",
>+	/*E0-E7*/	"","s0-vrd1-vddq0123-fault-l",
>+			"s0-vrd1-vddq4567-fault-l","s0-vrd0-vddc-fault-l",
>+			"s0-vrd3-p0v75-fault-l","","","",
>+	/*F0-F7*/	"","","SYS_ATX_PSON_L","","","","","",
>+	/*G0-G7*/	"id-led","id-button","","","UBOOT_READY",\
>+			"BMC_SALT2_L","","",
>+	/*H0-H7*/	"PS_PWROK","uart1-mode1","uart2-mode1","uart3-mode1",
>+			"uart4-mode1","","BMC_HB_LED","",
>+	/*I0-I7*/	"","","","","","","","",
>+	/*J0-J7*/	"s0-hightemp-n","","","","","","","",
>+	/*K0-K7*/	"","","","","","","","",
>+	/*L0-L7*/	"","","","","","","","",
>+	/*M0-M7*/	"","","","","","s0-spi-auth-fail-n","","",
>+	/*N0-N7*/	"","","","","","","","",
>+	/*O0-O7*/	"","","","","","","","",
>+	/*P0-P7*/	"","","CPLD_DISABLE_BMC","","","","","",
>+	/*Q0-Q7*/	"","","ext-hightemp-n","","","","",
>+			"CHASSIS_INTRUSION",
>+	/*R0-R7*/	"","","EXT_HIGHTEMP_L","spi0-program-sel","",
>+			"HWM_BAT_EN","","",
>+	/*S0-S7*/	"s0-vr-hot-n","","","BMC_SYSRESET_L","","","","",
>+	/*T0-T7*/	"","","","","","","","",
>+	/*U0-U7*/	"","","","","","","","",
>+	/*V0-V7*/	"","","","","","","","",
>+	/*W0-W7*/	"","","","","","","","",
>+	/*X0-X7*/	"","","","","","","","",
>+	/*Y0-Y7*/	"SIOS3","SIOS5","SIOPWREQ","SIOONCTRL","","","","",
>+	/*Z0-Z7*/	"","SIOPWRGD","","s0-rtc-lock","","","","",
>+	/*AA0-AA7*/	"RTC_INT","","","","","PMBUS_SEL_N","","",
>+	/*AB0-AB7*/	"host0-reboot-ack-n","s0-sys-auth-failure-n",
>+			"","","","","","",
>+	/*AC0-AC7*/	"s0-fault-alert","host0-ready","s0-overtemp-n",
>+			"","bmc-ok","host0-special-boot","presence-cpu0",
>+			"host0-shd-req-n";
>+};
>+
>+&i2c0 {
>+	bus-frequency = <100000>;

Here and on most of the other i2c busses, is there a particular reason 
we want this bus-frequency explicitly specified?  100kHz is the default 
according to Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml (and 
the other existing aspeed-bmc-asrock-*.dts files leave it at that 
implicit default, FWIW).

>+
>+	ipmb@10 {
>+		compatible = "ipmb-dev";
>+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
>+		i2c-protocol;
>+	};
>+
>+};
>+
>+&i2c1 {
>+	bus-frequency = <100000>;
>+
>+	i2c-mux1@73 {
>+		compatible = "nxp,pca9548";
>+		reg = <0x73>;
>+		#address-cells = <1>;
>+		#size-cells = <0>;
>+		i2c-mux-idle-disconnect;
>+
>+		nvme1: i2c@0 {
>+			#address-cells = <1>;
>+			#size-cells = <0>;
>+			reg = <0>;
>+		};
>+
>+		pcie4: i2c@1 {
>+			#address-cells = <1>;
>+			#size-cells = <0>;
>+			reg = <1>;
>+		};
>+
>+		pcie5: i2c@2 {
>+			#address-cells = <1>;
>+			#size-cells = <0>;
>+			reg = <2>;
>+		};
>+
>+		pcie6: i2c@3 {
>+			#address-cells = <1>;
>+			#size-cells = <0>;
>+			reg = <3>;
>+		};
>+
>+		pcie7: i2c@4 {
>+			#address-cells = <1>;
>+			#size-cells = <0>;
>+			reg = <4>;
>+		};
>+
>+		nvme3: i2c@5 {
>+			#address-cells = <1>;
>+			#size-cells = <0>;
>+			reg = <5>;
>+		};
>+
>+		nvme2: i2c@6 {
>+			#address-cells = <1>;
>+			#size-cells = <0>;
>+			reg = <6>;
>+		};
>+
>+		nvme0: i2c@7 {
>+			#address-cells = <1>;
>+			#size-cells = <0>;
>+			reg = <7>;
>+		};
>+	};
>+
>+	i2c-mux2@75 {
>+		compatible = "nxp,pca9548";
>+		reg = <0x75>;
>+		#address-cells = <1>;
>+		#size-cells = <0>;
>+		i2c-mux-idle-disconnect;
>+
>+		nvme4: i2c@0 {
>+			#address-cells = <1>;
>+			#size-cells = <0>;
>+			reg = <0>;
>+		};
>+
>+		nvme5: i2c@1 {
>+			#address-cells = <1>;
>+			#size-cells = <0>;
>+			reg = <1>;
>+		};
>+
>+		nvme6: i2c@2 {
>+			#address-cells = <1>;
>+			#size-cells = <0>;
>+			reg = <2>;
>+		};
>+
>+		nvme7: i2c@3 {
>+			#address-cells = <1>;
>+			#size-cells = <0>;
>+			reg = <3>;
>+		};
>+
>+		nvme8: i2c@4 {
>+			#address-cells = <1>;
>+			#size-cells = <0>;
>+			reg = <4>;
>+		};
>+
>+		nvme9: i2c@5 {
>+			#address-cells = <1>;
>+			#size-cells = <0>;
>+			reg = <5>;
>+		};
>+
>+		nvme10: i2c@6 {
>+			#address-cells = <1>;
>+			#size-cells = <0>;
>+			reg = <6>;
>+		};
>+
>+		nvme11: i2c@7 {
>+			#address-cells = <1>;
>+			#size-cells = <0>;
>+			reg = <7>;
>+		};
>+	};
>+};
>+
>+&i2c2 {
>+	bus-frequency = <100000>;
>+
>+	smpro@4f {
>+		compatible = "ampere,smpro";
>+		reg = <0x4f>;
>+	};
>+};
>+
>+&i2c3 {
>+	// PSU FRU
>+	eeprom@38 {
>+		compatible = "atmel,24c02";
>+		reg = <0x38>;
>+	};
>+};
>+
>+&i2c4 {
>+	bus-frequency = <100000>;
>+
>+	hardware-monitor@29 {

It looks like this device only monitors temperatures?  If so, perhaps 
temperature-sensor@29 would be a slightly more appropriate node name.

>+		compatible = "nuvoton,nct7802";
>+		reg = <0x29>;
>+
>+		#address-cells = <1>;
>+		#size-cells = <0>;
>+
>+		channel@0 { /* LTD */
>+			reg = <0>;
>+		};
>+
>+		channel@1 { /* RTD1 */
>+				reg = <1>;
>+				sensor-type = "temperature";
>+				temperature-mode = "thermistor";
>+		};
>+
>+		channel@2 { /* RTD2 */
>+				reg = <2>;
>+				sensor-type = "temperature";
>+				temperature-mode = "thermal-diode";
>+		};

channel@1 and channel@2 block bodies look over-indented by one level 
here.

>+	};
>+
>+	temperature-sensor@4c {
>+		compatible = "nuvoton,w83773g";
>+		reg = <0x4c>;
>+	};
>+};
>+
>+&i2c5 {
>+	status = "okay";
>+};
>+
>+&i2c6 {
>+	bus-frequency = <100000>;
>+
>+	rtc@6f {
>+		compatible = "isil,isl1208";
>+		reg = <0x6f>;
>+	};
>+};
>+
>+&i2c7 {
>+	bus-frequency = <100000>;
>+
>+	// BMC FRU
>+	eeprom@57 {
>+		compatible = "atmel,24c128";
>+		reg = <0x57>;
>+
>+		nvmem-layout {
>+			compatible = "fixed-layout";
>+			#address-cells = <1>;
>+			#size-cells = <1>;
>+
>+			eth0_macaddress: macaddress@3f88 {
>+				reg = <0x3f88 6>;
>+			};
>+
>+			eth1_macaddress: macaddress@3f80 {
>+				reg = <0x3f80 6>;
>+			};

Are these correct?  On every other ASRock board I've dealt with, the 
eth0 address is at 0x3f80 and eth1 is at 0x3f88.

If so and they are really for some reason swapped on this platform, as a 
slight nitpick I might suggest swapping the order the nodes are listed 
in so they go in order of increasing addresses.

>+		};
>+	};
>+};
>+
>+&i2c8 {
>+	bus-frequency = <100000>;
>+
>+	pca0: gpio@1c {
>+		compatible = "nxp,pca9557";
>+		reg = <0x1c>;
>+		#address-cells = <1>;
>+		#size-cells = <0>;
>+
>+		gpio-controller;
>+		#gpio-cells = <2>;
>+
>+		gpio@0 {
>+			reg = <0>;
>+		};
>+
>+		gpio@1 {
>+			reg = <1>;
>+		};
>+
>+		gpio@2 {
>+			reg = <2>;
>+		};
>+
>+		gpio@3 {
>+			reg = <3>;
>+		};
>+
>+		gpio@4 {
>+			reg = <4>;
>+		};
>+
>+		gpio@5 {
>+			reg = <5>;
>+		};
>+
>+		gpio@6 {
>+			reg = <6>;
>+		};
>+
>+		gpio@7 {
>+			reg = <7>;
>+		};
>+	};
>+};
>+
>+&i2c9 {
>+	status = "okay";
>+};
>+
>+&i2c10 {
>+	status = "okay";
>+};
>+
>+&i2c11 {
>+	status = "okay";
>+};
>+
>+&i2c12 {
>+	status = "okay";
>+};
>+
>+&i2c13 {
>+	bus-frequency = <100000>;
>+
>+	ssif-bmc@10 {
>+		compatible = "ssif-bmc";
>+		reg = <0x10>;
>+	};
>+};
>+
>+// Connected to host Intel X550 (ALTRAD8UD-1L2T) or
>+// Broadcom BCM57414 (ALTRAD8UD2-1L2Q) interface
>+&mac0 {
>+	pinctrl-names = "default";
>+	pinctrl-0 = <&pinctrl_rmii1_default>;
>+
>+	clocks = <&syscon ASPEED_CLK_GATE_MAC1CLK>,
>+		 <&syscon ASPEED_CLK_MAC1RCLK>;
>+	clock-names = "MACCLK", "RCLK";
>+
>+	use-ncsi;
>+
>+	nvmem-cells = <&eth0_macaddress>;
>+	nvmem-cell-names = "mac-address";
>+};
>+
>+// Connected to Realtek RTL8211E
>+&mac1 {
>+	pinctrl-names = "default";
>+	pinctrl-0 = <&pinctrl_rgmii2_default &pinctrl_mdio2_default>;
>+
>+	nvmem-cells = <&eth1_macaddress>;
>+	nvmem-cell-names = "mac-address";
>+};
>+
>+&pinctrl {
>+	aspeed,external-nodes = <&gfx &lhc>;
>+};
>+
>+&pwm_tacho {
>+	pinctrl-names = "default";
>+	pinctrl-0 = <&pinctrl_pwm0_default
>+			&pinctrl_pwm1_default
>+			&pinctrl_pwm2_default
>+			&pinctrl_pwm3_default
>+			&pinctrl_pwm4_default
>+			&pinctrl_pwm5_default
>+			&pinctrl_pwm6_default
>+			&pinctrl_pwm7_default>;
>+
>+	fan@0 {
>+		reg = <0x00>;
>+		aspeed,fan-tach-ch = /bits/ 8 <0x00 0x08>;
>+	};
>+
>+	fan@1 {
>+		reg = <0x01>;
>+		aspeed,fan-tach-ch = /bits/ 8 <0x01 0x09>;
>+	};
>+
>+	fan@2 {
>+		reg = <0x02>;
>+		aspeed,fan-tach-ch = /bits/ 8 <0x02 0x0a>;
>+	};
>+
>+	fan@3 {
>+		reg = <0x03>;
>+		aspeed,fan-tach-ch = /bits/ 8 <0x03 0x0b>;
>+	};
>+
>+	fan@4 {
>+		reg = <0x04>;
>+		aspeed,fan-tach-ch = /bits/ 8 <0x04 0x0c>;
>+	};
>+
>+	fan@5 {
>+		reg = <0x05>;
>+		aspeed,fan-tach-ch = /bits/ 8 <0x05 0x0d>;
>+	};
>+
>+	fan@6 {
>+		reg = <0x06>;
>+		aspeed,fan-tach-ch = /bits/ 8 <0x06 0x0e>;
>+	};
>+
>+	fan@7 {
>+		reg = <0x07>;
>+		aspeed,fan-tach-ch = /bits/ 8 <0x07 0x0f>;
>+	};
>+};
>+
>+&spi1 {
>+	pinctrl-names = "default";
>+	pinctrl-0 = <&pinctrl_spi1_default>;
>+
>+	flash@0 {
>+		m25p,fast-read;
>+		label = "pnor";
>+		spi-max-frequency = <100000000>;
>+
>+		partitions {
>+			compatible = "fixed-partitions";
>+			#address-cells = <1>;
>+			#size-cells = <1>;
>+
>+			code@400000 {
>+				reg = <0x400000 0x1C00000>;
>+				label = "pnor-code";
>+			};
>+
>+			tfa@400000 {
>+				reg = <0x400000 0x200000>;
>+				label = "pnor-tfa";
>+			};

As the DTBS_CHECK lint reported and Andrew Jeffery commented on, these 
two partitions overlapping is a bit surprising -- is that intentional?

>+
>+			uefi@600000 {
>+				reg = <0x600000 0x1A00000>;
>+				label = "pnor-uefi";
>+			};
>+		};
>+	};
>+};
>+
>+&uart1 {
>+	pinctrl-names = "default";
>+	pinctrl-0 = <&pinctrl_txd1_default
>+			 &pinctrl_rxd1_default
>+			 &pinctrl_ncts1_default
>+			 &pinctrl_nrts1_default>;
>+};
>+
>+&uart2 {
>+	pinctrl-names = "default";
>+	pinctrl-0 = <&pinctrl_txd2_default
>+			 &pinctrl_rxd2_default>;
>+};
>+
>+&uart3 {
>+	pinctrl-names = "default";
>+	pinctrl-0 = <&pinctrl_txd3_default
>+			 &pinctrl_rxd3_default>;
>+};
>+
>+&uart4 {
>+	pinctrl-names = "default";
>+	pinctrl-0 = <&pinctrl_txd4_default
>+			 &pinctrl_rxd4_default>;
>+};
>+
>+// The BMC's uart
>+&uart5 {
>+	status = "okay";
>+};
>+
>+&vhub {
>+	status = "okay";
>+};
>+
>+&video {
>+	memory-region = <&video_engine_memory>;
>+};
>-- 
>2.47.3
>
>

