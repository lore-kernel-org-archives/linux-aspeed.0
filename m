Return-Path: <linux-aspeed+bounces-784-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0025C021B0
	for <linux-aspeed@archiver.kernel.org>; Wed, 19 Feb 2025 21:27:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YyqHV3Z8wz2yYf;
	Thu, 20 Feb 2025 08:27:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740000470;
	cv=none; b=LG63DBoDpcWyOgntGUhxOBpwo49jEfXS+9he00N2GN5ODeVE/s8eI+lR0JUvJWPTP6ny7Y26Y1jz7Uv/MFFG/bCCBcFKgPiqpudYkZiCr8vVr+U0mYYyEDBSm+dJ/r+h4hJBsOOYrLQ7M6BEuDWVsPl2vXvrjb8aspz7um7kpCGus2987FnjteUJw7vMQfUo7jC81iT6+Jk/vh9zoTAS8qCbG+bkDTDcFnWZx+tdxsbnD/NFeo1MKVCSagbWZ7M68NKEzHw7KulvHjbKUKjfe3t+HOgy+XBLX0cEuxfuVe+wPYStYjdEQxxE3Y0GnFtCBeAzfla9L4a2NN/GUA99Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740000470; c=relaxed/relaxed;
	bh=PW+5Jx9bQdpCFdlNNVzRZt45GBtWrqwuN3OKN62Y/G4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IdmEvR7/R6prFUjXDwhzSXNHbQ+EeNKXZfntYetqPfkZgItYEXwo1R7CL5hrJB5O8VfdJwu8o3Djq+ZXnJ7ETHkyUchyuTVP+TOYHRzks+Phs3KHYnkhTdzjngzZQUzsgyQDXxY27UHo/oo6kbZ/VBlLT+rEqYU55QEnTHfeu501Og4sx+4YPXpjwTFgk7HHq4474KhfanEvWAMl8lSdvCscPFpOjf8bk3HLTKX81O6eMgSrfCALQd/TGLoIHdaqdYWNWsCeZBCEusZ3SqpGixk1TNzNayhx3unQQId9pscQ0wrx0rmfj7vcMWcZvTJX+h+r+NZhfibKiNE3O8smpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lIUB3NvL; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lIUB3NvL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YyqHT0YMxz2xs7
	for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Feb 2025 08:27:48 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JFoCme002821;
	Wed, 19 Feb 2025 21:27:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PW+5Jx9bQdpCFdlNN
	VzRZt45GBtWrqwuN3OKN62Y/G4=; b=lIUB3NvLLjHCMi79KUaikdubq37JRkSdS
	G0EYXEtrNUH4JVwVaiKsCMFe4e69tuazImWK0UsmLSRjCuZdvqFsAh1lKsl1wwaM
	M/Xoej1h56+jdLh9Ovrme4W0sWErFr31reJIEhCh3OnjjFejqWcSWRMJi1GeuAX6
	+NfiSPGa/7iH07w21hGD74llNQEW/4ACHoHg8piBsW10Rd8EWHdCdaN9nzr+4OJY
	HcbfoGjiIKojbberIMcp90N5kCzZUP3ohDS0CGxWuVxxPSfHUUXihIBjba2XUJ5U
	imwd+Ayt11nRwsHbfLlCPHCOuCt37quZWqVXn75uGzwJGiwScqbTw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wb0nv0fg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 21:27:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51JKH2jT009702;
	Wed, 19 Feb 2025 21:27:38 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w03y6ccq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 21:27:38 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51JLRb1w23265616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 21:27:37 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8D3D58051;
	Wed, 19 Feb 2025 21:27:36 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFA125805C;
	Wed, 19 Feb 2025 21:27:36 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.48.195])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Feb 2025 21:27:36 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-aspeed@lists.ozlabs.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andrew@codeconstruct.com.au, devicetree@vger.kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH 3/3] ARM: dts: aspeed: Add Balcones system
Date: Wed, 19 Feb 2025 15:27:35 -0600
Message-ID: <20250219212735.1365050-4-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250219212735.1365050-1-eajames@linux.ibm.com>
References: <20250219212735.1365050-1-eajames@linux.ibm.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YAMt7THN5Mzp4itltNG9H2OVxU8QkXjV
X-Proofpoint-GUID: YAMt7THN5Mzp4itltNG9H2OVxU8QkXjV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_09,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190158

The Balcones system is similar to Bonnell but with a POWER11 processor.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../dts/aspeed/aspeed-bmc-ibm-balcones.dts    | 594 +++++++++++++
 .../arm/boot/dts/aspeed/ibm-power11-dual.dtsi | 779 ++++++++++++++++++
 .../arm/boot/dts/aspeed/ibm-power11-quad.dtsi | 769 +----------------
 4 files changed, 1376 insertions(+), 767 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dts
 create mode 100644 arch/arm/boot/dts/aspeed/ibm-power11-dual.dtsi

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index 2e5f4833a073b..71b2d67fdbac8 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -34,6 +34,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-facebook-yamp.dtb \
 	aspeed-bmc-facebook-yosemitev2.dtb \
 	aspeed-bmc-facebook-yosemite4.dtb \
+	aspeed-bmc-ibm-balcones.dtb \
 	aspeed-bmc-ibm-blueridge.dtb \
 	aspeed-bmc-ibm-bonnell.dtb \
 	aspeed-bmc-ibm-everest.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dts
new file mode 100644
index 0000000000000..0fe99a748b63b
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dts
@@ -0,0 +1,594 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright 2025 IBM Corp.
+/dts-v1/;
+
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/i2c/i2c.h>
+#include <dt-bindings/leds/leds-pca955x.h>
+#include "aspeed-g6.dtsi"
+#include "ibm-power11-dual.dtsi"
+
+/ {
+	model = "Balcones";
+	compatible = "ibm,balcones-bmc", "aspeed,ast2600";
+
+	aliases {
+		serial4 = &uart5;
+		i2c16 = &i2c11mux0chn0;
+		i2c17 = &i2c11mux0chn1;
+		i2c18 = &i2c11mux0chn2;
+		i2c19 = &i2c11mux0chn3;
+	};
+
+	chosen {
+		stdout-path = &uart5;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x40000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		event_log: region@b3d00000 {
+			reg = <0xb3d00000 0x100000>;
+			no-map;
+		};
+
+		ramoops@b3e00000 {
+			compatible = "ramoops";
+			reg = <0xb3e00000 0x200000>; /* 16 * (4 * 0x8000) */
+			record-size = <0x8000>;
+			console-size = <0x8000>;
+			ftrace-size = <0x8000>;
+			pmsg-size = <0x8000>;
+			max-reason = <3>; /* KMSG_DUMP_EMERG */
+		};
+
+		/* LPC FW cycle bridge region requires natural alignment */
+		flash_memory: region@b4000000 {
+			reg = <0xb4000000 0x04000000>; /* 64M */
+			no-map;
+		};
+
+		/* VGA region is dictated by hardware strapping */
+		vga_memory: region@bf000000 {
+			compatible = "shared-dma-pool";
+			reg = <0xbf000000 0x01000000>;  /* 16M */
+			no-map;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-fan0 {
+			gpios = <&gpio0 ASPEED_GPIO(G, 0) GPIO_ACTIVE_LOW>;
+		};
+
+		led-fan1 {
+			gpios = <&gpio0 ASPEED_GPIO(G, 1) GPIO_ACTIVE_LOW>;
+		};
+
+		led-rear-enc-id0 {
+			gpios = <&gpio0 ASPEED_GPIO(H, 2) GPIO_ACTIVE_LOW>;
+		};
+
+		led-rear-enc-fault0 {
+			gpios = <&gpio0 ASPEED_GPIO(H, 3) GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	gpio-keys-polled {
+		compatible = "gpio-keys-polled";
+		poll-interval = <1000>;
+
+		event-fan0-presence {
+			gpios = <&gpio0 ASPEED_GPIO(F, 4) GPIO_ACTIVE_LOW>;
+			label = "fan0-presence";
+			linux,code = <6>;
+		};
+
+		event-fan1-presence {
+			gpios = <&gpio0 ASPEED_GPIO(F, 5) GPIO_ACTIVE_LOW>;
+			label = "fan1-presence";
+			linux,code = <7>;
+		};
+	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc1 7>;
+	};
+};
+
+&adc1 {
+	status = "okay";
+	aspeed,int-vref-microvolt = <2500000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default
+		&pinctrl_adc10_default &pinctrl_adc11_default
+		&pinctrl_adc12_default &pinctrl_adc13_default
+		&pinctrl_adc14_default &pinctrl_adc15_default>;
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&uhci {
+	status = "okay";
+};
+
+&gpio0 {
+	gpio-line-names =
+		/*A0-A7*/	"","","","","","","","",
+		/*B0-B7*/	"","","","","","","checkstop","",
+		/*C0-C7*/	"","","","","","","","",
+		/*D0-D7*/	"","","","","","","","",
+		/*E0-E7*/	"","","","","","","","",
+		/*F0-F7*/	"","","rtc-battery-voltage-read-enable","reset-cause-pinhole","",
+				"","","",
+		/*G0-G7*/	"fan0","fan1","","","","","","",
+		/*H0-H7*/	"","","rear-enc-id0","rear-enc-fault0","","","","",
+		/*I0-I7*/	"","","","","","","bmc-secure-boot","",
+		/*J0-J7*/	"","","","","","","","",
+		/*K0-K7*/	"","","","","","","","",
+		/*L0-L7*/	"","","","","","","","",
+		/*M0-M7*/	"","","","","","","","",
+		/*N0-N7*/	"","","","","","","","",
+		/*O0-O7*/	"","","","usb-power","","","","",
+		/*P0-P7*/	"","","","","","","","",
+		/*Q0-Q7*/	"cfam-reset","","regulator-standby-faulted","","","","","",
+		/*R0-R7*/	"bmc-tpm-reset","power-chassis-control","power-chassis-good","","",
+				"","","",
+		/*S0-S7*/	"presence-ps0","presence-ps1","","","power-ffs-sync-history","","",
+				"",
+		/*T0-T7*/	"","","","","","","","",
+		/*U0-U7*/	"","","","","","","","",
+		/*V0-V7*/	"","","","","","","","",
+		/*W0-W7*/	"","","","","","","","",
+		/*X0-X7*/	"","","","","","","","",
+		/*Y0-Y7*/	"","","","","","","","",
+		/*Z0-Z7*/	"","","","","","","","";
+
+	usb-power-hog {
+		gpio-hog;
+		gpios = <ASPEED_GPIO(O, 3) GPIO_ACTIVE_LOW>;
+		output-high;
+	};
+};
+
+&emmc_controller {
+	status = "okay";
+};
+
+&pinctrl_emmc_default {
+	bias-disable;
+};
+
+&emmc {
+	status = "okay";
+	clk-phase-mmc-hs200 = <180>, <180>;
+};
+
+&ibt {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+
+	eeprom@51 {
+		compatible = "atmel,24c64";
+		reg = <0x51>;
+	};
+
+	gpio@20 {
+		compatible = "ti,tca9554";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+			"",
+			"RUSSEL_FW_I2C_ENABLE_N",
+			"RUSSEL_OPPANEL_PRESENCE_N",
+			"BLYTH_OPPANEL_PRESENCE_N",
+			"CPU_TPM_CARD_PRESENT_N",
+			"",
+			"",
+			"DASD_BP_PRESENT_N";
+	};
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+
+	pmic@64 {
+		compatible = "ti,ucd90160";
+		reg = <0x64>;
+	};
+};
+
+&i2c3 {
+	status = "okay";
+
+	power-supply@5a {
+		compatible = "acbel,fsg032";
+		reg = <0x5a>;
+	};
+
+	power-supply@5b {
+		compatible = "acbel,fsg032";
+		reg = <0x5b>;
+	};
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+&i2c5 {
+	status = "okay";
+
+	eeprom@52 {
+		compatible = "atmel,24c64";
+		reg = <0x52>;
+	};
+
+	temperature-sensor@4e {
+		compatible = "ti,tmp435";
+		reg = <0x4e>;
+	};
+};
+
+&i2c6 {
+	status = "okay";
+};
+
+&i2c7 {
+	multi-master;
+	status = "okay";
+
+	humidity-sensor@40 {
+		compatible = "silabs,si7020";
+		reg = <0x40>;
+	};
+
+	temperature-sensor@48 {
+		compatible = "ti,tmp275";
+		reg = <0x48>;
+	};
+
+	eeprom@50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+	};
+
+	eeprom@51 {
+		compatible = "atmel,24c64";
+		reg = <0x51>;
+	};
+
+	pwm@53 {
+		compatible = "maxim,max31785a";
+		reg = <0x53>;
+	};
+
+	led-controller@60 {
+		compatible = "nxp,pca9551";
+		reg = <0x60>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		led@0 {
+			reg = <0>;
+			default-state = "keep";
+			label = "front-sys-id0";
+			retain-state-shutdown;
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@1 {
+			reg = <1>;
+			default-state = "keep";
+			label = "front-check-log0";
+			retain-state-shutdown;
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@2 {
+			reg = <2>;
+			default-state = "keep";
+			label = "front-enc-fault1";
+			retain-state-shutdown;
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@3 {
+			reg = <3>;
+			default-state = "keep";
+			label = "front-sys-pwron0";
+			retain-state-shutdown;
+			type = <PCA955X_TYPE_LED>;
+		};
+	};
+
+	lcd-controller@62 {
+		compatible = "ibm,op-panel";
+		reg = <(0x62 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
+
+	pressure-sensor@76 {
+		compatible = "infineon,dps310";
+		reg = <0x76>;
+		#io-channel-cells = <0>;
+	};
+};
+
+&i2c8 {
+	status = "okay";
+
+	rtc@32 {
+		compatible = "epson,rx8900";
+		reg = <0x32>;
+	};
+
+	eeprom@50 {
+		compatible = "atmel,24c128";
+		reg = <0x50>;
+	};
+
+	led-controller@51 {
+		compatible = "nxp,pca9552";
+		reg = <0x51>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+			"",
+			"",
+			"SLOT2_PRSNT_EN_RSVD",
+			"",
+			"",
+			"",
+			"",
+			"SLOT2_EXPANDER_PRSNT_N",
+			"",
+			"",
+			"",
+			"",
+			"",
+			"",
+			"",
+			"";
+	};
+
+	led-controller@60 {
+		compatible = "nxp,pca9551";
+		reg = <0x60>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+			"",
+			"APSS_RESET_N",
+			"",
+			"N_MODE_CPU_N",
+			"",
+			"",
+			"P10_DCM_PRESENT",
+			"";
+	};
+};
+
+&i2c9 {
+	status = "okay";
+
+	temperature-sensor@4c {
+		compatible = "ti,tmp423";
+		reg = <0x4c>;
+	};
+};
+
+&i2c10 {
+	status = "okay";
+};
+
+&i2c11 {
+	status = "okay";
+
+	gpio@20 {
+		compatible = "ti,tca9554";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+			"BOOT_RCVRY_TWI",
+			"BOOT_RCVRY_UART",
+			"",
+			"",
+			"",
+			"",
+			"",
+			"PE_SWITCH_RSTB_N";
+	};
+
+	temperature-sensor@4c {
+		compatible = "ti,tmp435";
+		reg = <0x4c>;
+	};
+
+	i2c-mux@75 {
+		compatible = "nxp,pca9849";
+		reg = <0x75>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c11mux0chn0: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c11mux0chn1: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c11mux0chn2: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		i2c11mux0chn3: i2c@3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+&i2c12 {
+	status = "okay";
+
+	tpm@2e {
+		compatible = "nuvoton,npct75x", "tcg,tpm-tis-i2c";
+		reg = <0x2e>;
+		memory-region = <&event_log>;
+	};
+
+	eeprom@50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+	};
+};
+
+&i2c13 {
+	status = "okay";
+
+	eeprom@50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+	};
+
+	led-controller@60 {
+		compatible = "nxp,pca9551";
+		reg = <0x60>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		led@0 {
+			reg = <0>;
+			default-state = "keep";
+			label = "nvme3";
+			retain-state-shutdown;
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@1 {
+			reg = <1>;
+			default-state = "keep";
+			label = "nvme2";
+			retain-state-shutdown;
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@2 {
+			reg = <2>;
+			default-state = "keep";
+			label = "nvme1";
+			retain-state-shutdown;
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@3 {
+			reg = <3>;
+			default-state = "keep";
+			label = "nvme0";
+			retain-state-shutdown;
+			type = <PCA955X_TYPE_LED>;
+		};
+	};
+};
+
+&i2c14 {
+	status = "okay";
+};
+
+&i2c15 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&vuart1 {
+	status = "okay";
+};
+
+&vuart2 {
+	status = "okay";
+};
+
+&lpc_ctrl {
+	status = "okay";
+	memory-region = <&flash_memory>;
+};
+
+&mac2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii3_default>;
+	clocks = <&syscon ASPEED_CLK_GATE_MAC3CLK>,
+		 <&syscon ASPEED_CLK_MAC3RCLK>;
+	clock-names = "MACCLK", "RCLK";
+	use-ncsi;
+};
+
+&wdt1 {
+	aspeed,reset-type = "none";
+	aspeed,external-signal;
+	aspeed,ext-push-pull;
+	aspeed,ext-active-high;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdtrst1_default>;
+};
+
+&wdt2 {
+	status = "okay";
+};
+
+&kcs2 {
+	status = "okay";
+	aspeed,lpc-io-reg = <0xca8 0xcac>;
+};
+
+&kcs3 {
+	status = "okay";
+	aspeed,lpc-io-reg = <0xca2>;
+	aspeed,lpc-interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+};
diff --git a/arch/arm/boot/dts/aspeed/ibm-power11-dual.dtsi b/arch/arm/boot/dts/aspeed/ibm-power11-dual.dtsi
new file mode 100644
index 0000000000000..e5f65258e082f
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/ibm-power11-dual.dtsi
@@ -0,0 +1,779 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright 2025 IBM Corp.
+
+/ {
+	aliases {
+		i2c100 = &cfam0_i2c0;
+		i2c101 = &cfam0_i2c1;
+		i2c110 = &cfam0_i2c10;
+		i2c111 = &cfam0_i2c11;
+		i2c112 = &cfam0_i2c12;
+		i2c113 = &cfam0_i2c13;
+		i2c114 = &cfam0_i2c14;
+		i2c115 = &cfam0_i2c15;
+		i2c202 = &cfam1_i2c2;
+		i2c203 = &cfam1_i2c3;
+		i2c210 = &cfam1_i2c10;
+		i2c211 = &cfam1_i2c11;
+		i2c214 = &cfam1_i2c14;
+		i2c215 = &cfam1_i2c15;
+		i2c216 = &cfam1_i2c16;
+		i2c217 = &cfam1_i2c17;
+
+		sbefifo100 = &sbefifo100;
+		sbefifo101 = &sbefifo101;
+		sbefifo110 = &sbefifo110;
+		sbefifo111 = &sbefifo111;
+		sbefifo112 = &sbefifo112;
+		sbefifo113 = &sbefifo113;
+		sbefifo114 = &sbefifo114;
+		sbefifo115 = &sbefifo115;
+		sbefifo202 = &sbefifo202;
+		sbefifo203 = &sbefifo203;
+		sbefifo210 = &sbefifo210;
+		sbefifo211 = &sbefifo211;
+		sbefifo214 = &sbefifo214;
+		sbefifo215 = &sbefifo215;
+		sbefifo216 = &sbefifo216;
+		sbefifo217 = &sbefifo217;
+
+		scom100 = &scom100;
+		scom101 = &scom101;
+		scom110 = &scom110;
+		scom111 = &scom111;
+		scom112 = &scom112;
+		scom113 = &scom113;
+		scom114 = &scom114;
+		scom115 = &scom115;
+		scom202 = &scom202;
+		scom203 = &scom203;
+		scom210 = &scom210;
+		scom211 = &scom211;
+		scom214 = &scom214;
+		scom215 = &scom215;
+		scom216 = &scom216;
+		scom217 = &scom217;
+
+		spi10 = &cfam0_spi0;
+		spi11 = &cfam0_spi1;
+		spi12 = &cfam0_spi2;
+		spi13 = &cfam0_spi3;
+		spi20 = &cfam1_spi0;
+		spi21 = &cfam1_spi1;
+		spi22 = &cfam1_spi2;
+		spi23 = &cfam1_spi3;
+	};
+};
+
+&fsim0 {
+	#address-cells = <2>;
+	#size-cells = <0>;
+	status = "okay";
+	bus-frequency = <100000000>;
+	cfam-reset-gpios = <&gpio0 ASPEED_GPIO(Q, 0) GPIO_ACTIVE_HIGH>;
+
+	cfam@0,0 {
+		reg = <0 0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		chip-id = <0>;
+
+		scom@1000 {
+			compatible = "ibm,p9-scom";
+			reg = <0x1000 0x400>;
+		};
+
+		i2c@1800 {
+			compatible = "ibm,i2c-fsi";
+			reg = <0x1800 0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			cfam0_i2c0: i2c-bus@0 {
+				reg = <0>;	/* OMI01 */
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				fsi@20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam@0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom100: scom@1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo100: sbefifo@2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+						};
+					};
+				};
+			};
+
+			cfam0_i2c1: i2c-bus@1 {
+				reg = <1>;	/* OMI23 */
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				fsi@20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam@0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom101: scom@1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo101: sbefifo@2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+						};
+					};
+				};
+			};
+
+			cfam0_i2c10: i2c-bus@a {
+				reg = <10>;	/* OP3A */
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				fsi@20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam@0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom110: scom@1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo110: sbefifo@2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+						};
+					};
+				};
+			};
+
+			cfam0_i2c11: i2c-bus@b {
+				reg = <11>;	/* OP3B */
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				fsi@20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam@0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom111: scom@1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo111: sbefifo@2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+						};
+					};
+				};
+			};
+
+			cfam0_i2c12: i2c-bus@c {
+				reg = <12>;	/* OP4A */
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				fsi@20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam@0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom112: scom@1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo112: sbefifo@2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+						};
+					};
+				};
+			};
+
+			cfam0_i2c13: i2c-bus@d {
+				reg = <13>;	/* OP4B */
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				fsi@20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam@0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom113: scom@1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo113: sbefifo@2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+						};
+					};
+				};
+			};
+
+			cfam0_i2c14: i2c-bus@e {
+				reg = <14>;	/* OP5A */
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				fsi@20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam@0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom114: scom@1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo114: sbefifo@2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+						};
+					};
+				};
+			};
+
+			cfam0_i2c15: i2c-bus@f {
+				reg = <15>;	/* OP5B */
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				fsi@20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam@0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom115: scom@1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo115: sbefifo@2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+						};
+					};
+				};
+			};
+		};
+
+		fsi2spi@1c00 {
+			compatible = "ibm,fsi2spi";
+			reg = <0x1c00 0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			cfam0_spi0: spi@0 {
+				compatible = "ibm,spi-fsi";
+				reg = <0x0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eeprom@0 {
+					compatible = "atmel,at25";
+					reg = <0>;
+					address-width = <24>;
+					pagesize = <256>;
+					size = <0x80000>;
+					spi-max-frequency = <10000000>;
+				};
+			};
+
+			cfam0_spi1: spi@20 {
+				compatible = "ibm,spi-fsi";
+				reg = <0x20>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eeprom@0 {
+					compatible = "atmel,at25";
+					reg = <0>;
+					address-width = <24>;
+					pagesize = <256>;
+					size = <0x80000>;
+					spi-max-frequency = <10000000>;
+				};
+			};
+
+			cfam0_spi2: spi@40 {
+				compatible = "ibm,spi-fsi";
+				reg = <0x40>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eeprom@0 {
+					compatible = "atmel,at25";
+					reg = <0>;
+					address-width = <24>;
+					pagesize = <256>;
+					size = <0x80000>;
+					spi-max-frequency = <10000000>;
+				};
+			};
+
+			cfam0_spi3: spi@60 {
+				compatible = "ibm,spi-fsi";
+				reg = <0x60>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eeprom@0 {
+					compatible = "atmel,at25";
+					reg = <0>;
+					address-width = <24>;
+					pagesize = <256>;
+					size = <0x80000>;
+					spi-max-frequency = <10000000>;
+				};
+			};
+		};
+
+		sbefifo@2400 {
+			compatible = "ibm,p9-sbefifo";
+			reg = <0x2400 0x400>;
+
+			occ {
+				compatible = "ibm,p10-occ";
+
+				hwmon {
+					compatible = "ibm,p10-occ-hwmon";
+					ibm,no-poll-on-init;
+				};
+			};
+		};
+
+		fsi_hub0: fsi@3400 {
+			compatible = "ibm,p9-fsi-controller";
+			reg = <0x3400 0x400>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+&fsi_hub0 {
+	cfam@1,0 {
+		reg = <1 0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		chip-id = <1>;
+
+		scom@1000 {
+			compatible = "ibm,p9-scom";
+			reg = <0x1000 0x400>;
+		};
+
+		i2c@1800 {
+			compatible = "ibm,i2c-fsi";
+			reg = <0x1800 0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			cfam1_i2c2: i2c-bus@2 {
+				reg = <2>;	/* OMI45 */
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				fsi@20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam@0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom202: scom@1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo202: sbefifo@2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+						};
+					};
+				};
+			};
+
+			cfam1_i2c3: i2c-bus@3 {
+				reg = <3>;	/* OMI67 */
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				fsi@20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam@0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom203: scom@1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo203: sbefifo@2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+						};
+					};
+				};
+			};
+
+			cfam1_i2c10: i2c-bus@a {
+				reg = <10>;	/* OP3A */
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				fsi@20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam@0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom210: scom@1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo210: sbefifo@2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+						};
+					};
+				};
+			};
+
+			cfam1_i2c11: i2c-bus@b {
+				reg = <11>;	/* OP3B */
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				fsi@20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam@0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom211: scom@1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo211: sbefifo@2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+						};
+					};
+				};
+			};
+
+			cfam1_i2c14: i2c-bus@e {
+				reg = <14>;	/* OP5A */
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				fsi@20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam@0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom214: scom@1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo214: sbefifo@2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+						};
+					};
+				};
+			};
+
+			cfam1_i2c15: i2c-bus@f {
+				reg = <15>;	/* OP5B */
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				fsi@20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam@0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom215: scom@1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo215: sbefifo@2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+						};
+					};
+				};
+			};
+
+			cfam1_i2c16: i2c-bus@10 {
+				reg = <16>;	/* OP6A */
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				fsi@20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam@0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom216: scom@1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo216: sbefifo@2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+						};
+					};
+				};
+			};
+
+			cfam1_i2c17: i2c-bus@11 {
+				reg = <17>;	/* OP6B */
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				fsi@20 {
+					compatible = "ibm,i2cr-fsi-master";
+					reg = <0x20>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cfam@0,0 {
+						reg = <0 0>;
+						#address-cells = <1>;
+						#size-cells = <1>;
+						chip-id = <0>;
+
+						scom217: scom@1000 {
+							compatible = "ibm,i2cr-scom";
+							reg = <0x1000 0x400>;
+						};
+
+						sbefifo217: sbefifo@2400 {
+							compatible = "ibm,odyssey-sbefifo";
+							reg = <0x2400 0x400>;
+						};
+					};
+				};
+			};
+		};
+
+		fsi2spi@1c00 {
+			compatible = "ibm,fsi2spi";
+			reg = <0x1c00 0x400>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			cfam1_spi0: spi@0 {
+				compatible = "ibm,spi-fsi";
+				reg = <0x0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eeprom@0 {
+					compatible = "atmel,at25";
+					reg = <0>;
+					address-width = <24>;
+					pagesize = <256>;
+					size = <0x80000>;
+					spi-max-frequency = <10000000>;
+				};
+			};
+
+			cfam1_spi1: spi@20 {
+				compatible = "ibm,spi-fsi";
+				reg = <0x20>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eeprom@0 {
+					compatible = "atmel,at25";
+					reg = <0>;
+					address-width = <24>;
+					pagesize = <256>;
+					size = <0x80000>;
+					spi-max-frequency = <10000000>;
+				};
+			};
+
+			cfam1_spi2: spi@40 {
+				compatible = "ibm,spi-fsi";
+				reg = <0x40>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eeprom@0 {
+					compatible = "atmel,at25";
+					reg = <0>;
+					address-width = <24>;
+					pagesize = <256>;
+					size = <0x80000>;
+					spi-max-frequency = <10000000>;
+				};
+			};
+
+			cfam1_spi3: spi@60 {
+				compatible = "ibm,spi-fsi";
+				reg = <0x60>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				eeprom@0 {
+					compatible = "atmel,at25";
+					reg = <0>;
+					address-width = <24>;
+					pagesize = <256>;
+					size = <0x80000>;
+					spi-max-frequency = <10000000>;
+				};
+			};
+		};
+
+		sbefifo@2400 {
+			compatible = "ibm,p9-sbefifo";
+			reg = <0x2400 0x400>;
+
+			occ {
+				compatible = "ibm,p10-occ";
+
+				hwmon {
+					compatible = "ibm,p10-occ-hwmon";
+					ibm,no-poll-on-init;
+				};
+			};
+		};
+
+		fsi@3400 {
+			compatible = "ibm,p9-fsi-controller";
+			reg = <0x3400 0x400>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+			no-scan-on-init;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/aspeed/ibm-power11-quad.dtsi b/arch/arm/boot/dts/aspeed/ibm-power11-quad.dtsi
index 68c941a194b64..7aa4113d30263 100644
--- a/arch/arm/boot/dts/aspeed/ibm-power11-quad.dtsi
+++ b/arch/arm/boot/dts/aspeed/ibm-power11-quad.dtsi
@@ -1,24 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 // Copyright 2024 IBM Corp.
 
+#include "ibm-power11-dual.dtsi"
+
 / {
 	aliases {
-		i2c100 = &cfam0_i2c0;
-		i2c101 = &cfam0_i2c1;
-		i2c110 = &cfam0_i2c10;
-		i2c111 = &cfam0_i2c11;
-		i2c112 = &cfam0_i2c12;
-		i2c113 = &cfam0_i2c13;
-		i2c114 = &cfam0_i2c14;
-		i2c115 = &cfam0_i2c15;
-		i2c202 = &cfam1_i2c2;
-		i2c203 = &cfam1_i2c3;
-		i2c210 = &cfam1_i2c10;
-		i2c211 = &cfam1_i2c11;
-		i2c214 = &cfam1_i2c14;
-		i2c215 = &cfam1_i2c15;
-		i2c216 = &cfam1_i2c16;
-		i2c217 = &cfam1_i2c17;
 		i2c300 = &cfam2_i2c0;
 		i2c301 = &cfam2_i2c1;
 		i2c310 = &cfam2_i2c10;
@@ -36,22 +22,6 @@ aliases {
 		i2c416 = &cfam3_i2c16;
 		i2c417 = &cfam3_i2c17;
 
-		sbefifo100 = &sbefifo100;
-		sbefifo101 = &sbefifo101;
-		sbefifo110 = &sbefifo110;
-		sbefifo111 = &sbefifo111;
-		sbefifo112 = &sbefifo112;
-		sbefifo113 = &sbefifo113;
-		sbefifo114 = &sbefifo114;
-		sbefifo115 = &sbefifo115;
-		sbefifo202 = &sbefifo202;
-		sbefifo203 = &sbefifo203;
-		sbefifo210 = &sbefifo210;
-		sbefifo211 = &sbefifo211;
-		sbefifo214 = &sbefifo214;
-		sbefifo215 = &sbefifo215;
-		sbefifo216 = &sbefifo216;
-		sbefifo217 = &sbefifo217;
 		sbefifo300 = &sbefifo300;
 		sbefifo301 = &sbefifo301;
 		sbefifo310 = &sbefifo310;
@@ -69,22 +39,6 @@ aliases {
 		sbefifo416 = &sbefifo416;
 		sbefifo417 = &sbefifo417;
 
-		scom100 = &scom100;
-		scom101 = &scom101;
-		scom110 = &scom110;
-		scom111 = &scom111;
-		scom112 = &scom112;
-		scom113 = &scom113;
-		scom114 = &scom114;
-		scom115 = &scom115;
-		scom202 = &scom202;
-		scom203 = &scom203;
-		scom210 = &scom210;
-		scom211 = &scom211;
-		scom214 = &scom214;
-		scom215 = &scom215;
-		scom216 = &scom216;
-		scom217 = &scom217;
 		scom300 = &scom300;
 		scom301 = &scom301;
 		scom310 = &scom310;
@@ -102,14 +56,6 @@ aliases {
 		scom416 = &scom416;
 		scom417 = &scom417;
 
-		spi10 = &cfam0_spi0;
-		spi11 = &cfam0_spi1;
-		spi12 = &cfam0_spi2;
-		spi13 = &cfam0_spi3;
-		spi20 = &cfam1_spi0;
-		spi21 = &cfam1_spi1;
-		spi22 = &cfam1_spi2;
-		spi23 = &cfam1_spi3;
 		spi30 = &cfam2_spi0;
 		spi31 = &cfam2_spi1;
 		spi32 = &cfam2_spi2;
@@ -121,718 +67,7 @@ aliases {
 	};
 };
 
-&fsim0 {
-	#address-cells = <2>;
-	#size-cells = <0>;
-	status = "okay";
-	bus-frequency = <100000000>;
-	cfam-reset-gpios = <&gpio0 ASPEED_GPIO(Q, 0) GPIO_ACTIVE_HIGH>;
-
-	cfam@0,0 {
-		reg = <0 0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		chip-id = <0>;
-
-		scom@1000 {
-			compatible = "ibm,p9-scom";
-			reg = <0x1000 0x400>;
-		};
-
-		i2c@1800 {
-			compatible = "ibm,i2c-fsi";
-			reg = <0x1800 0x400>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			cfam0_i2c0: i2c-bus@0 {
-				reg = <0>;	/* OMI01 */
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				fsi@20 {
-					compatible = "ibm,i2cr-fsi-master";
-					reg = <0x20>;
-					#address-cells = <2>;
-					#size-cells = <0>;
-
-					cfam@0,0 {
-						reg = <0 0>;
-						#address-cells = <1>;
-						#size-cells = <1>;
-						chip-id = <0>;
-
-						scom100: scom@1000 {
-							compatible = "ibm,i2cr-scom";
-							reg = <0x1000 0x400>;
-						};
-
-						sbefifo100: sbefifo@2400 {
-							compatible = "ibm,odyssey-sbefifo";
-							reg = <0x2400 0x400>;
-						};
-					};
-				};
-			};
-
-			cfam0_i2c1: i2c-bus@1 {
-				reg = <1>;	/* OMI23 */
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				fsi@20 {
-					compatible = "ibm,i2cr-fsi-master";
-					reg = <0x20>;
-					#address-cells = <2>;
-					#size-cells = <0>;
-
-					cfam@0,0 {
-						reg = <0 0>;
-						#address-cells = <1>;
-						#size-cells = <1>;
-						chip-id = <0>;
-
-						scom101: scom@1000 {
-							compatible = "ibm,i2cr-scom";
-							reg = <0x1000 0x400>;
-						};
-
-						sbefifo101: sbefifo@2400 {
-							compatible = "ibm,odyssey-sbefifo";
-							reg = <0x2400 0x400>;
-						};
-					};
-				};
-			};
-
-			cfam0_i2c10: i2c-bus@a {
-				reg = <10>;	/* OP3A */
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				fsi@20 {
-					compatible = "ibm,i2cr-fsi-master";
-					reg = <0x20>;
-					#address-cells = <2>;
-					#size-cells = <0>;
-
-					cfam@0,0 {
-						reg = <0 0>;
-						#address-cells = <1>;
-						#size-cells = <1>;
-						chip-id = <0>;
-
-						scom110: scom@1000 {
-							compatible = "ibm,i2cr-scom";
-							reg = <0x1000 0x400>;
-						};
-
-						sbefifo110: sbefifo@2400 {
-							compatible = "ibm,odyssey-sbefifo";
-							reg = <0x2400 0x400>;
-						};
-					};
-				};
-			};
-
-			cfam0_i2c11: i2c-bus@b {
-				reg = <11>;	/* OP3B */
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				fsi@20 {
-					compatible = "ibm,i2cr-fsi-master";
-					reg = <0x20>;
-					#address-cells = <2>;
-					#size-cells = <0>;
-
-					cfam@0,0 {
-						reg = <0 0>;
-						#address-cells = <1>;
-						#size-cells = <1>;
-						chip-id = <0>;
-
-						scom111: scom@1000 {
-							compatible = "ibm,i2cr-scom";
-							reg = <0x1000 0x400>;
-						};
-
-						sbefifo111: sbefifo@2400 {
-							compatible = "ibm,odyssey-sbefifo";
-							reg = <0x2400 0x400>;
-						};
-					};
-				};
-			};
-
-			cfam0_i2c12: i2c-bus@c {
-				reg = <12>;	/* OP4A */
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				fsi@20 {
-					compatible = "ibm,i2cr-fsi-master";
-					reg = <0x20>;
-					#address-cells = <2>;
-					#size-cells = <0>;
-
-					cfam@0,0 {
-						reg = <0 0>;
-						#address-cells = <1>;
-						#size-cells = <1>;
-						chip-id = <0>;
-
-						scom112: scom@1000 {
-							compatible = "ibm,i2cr-scom";
-							reg = <0x1000 0x400>;
-						};
-
-						sbefifo112: sbefifo@2400 {
-							compatible = "ibm,odyssey-sbefifo";
-							reg = <0x2400 0x400>;
-						};
-					};
-				};
-			};
-
-			cfam0_i2c13: i2c-bus@d {
-				reg = <13>;	/* OP4B */
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				fsi@20 {
-					compatible = "ibm,i2cr-fsi-master";
-					reg = <0x20>;
-					#address-cells = <2>;
-					#size-cells = <0>;
-
-					cfam@0,0 {
-						reg = <0 0>;
-						#address-cells = <1>;
-						#size-cells = <1>;
-						chip-id = <0>;
-
-						scom113: scom@1000 {
-							compatible = "ibm,i2cr-scom";
-							reg = <0x1000 0x400>;
-						};
-
-						sbefifo113: sbefifo@2400 {
-							compatible = "ibm,odyssey-sbefifo";
-							reg = <0x2400 0x400>;
-						};
-					};
-				};
-			};
-
-			cfam0_i2c14: i2c-bus@e {
-				reg = <14>;	/* OP5A */
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				fsi@20 {
-					compatible = "ibm,i2cr-fsi-master";
-					reg = <0x20>;
-					#address-cells = <2>;
-					#size-cells = <0>;
-
-					cfam@0,0 {
-						reg = <0 0>;
-						#address-cells = <1>;
-						#size-cells = <1>;
-						chip-id = <0>;
-
-						scom114: scom@1000 {
-							compatible = "ibm,i2cr-scom";
-							reg = <0x1000 0x400>;
-						};
-
-						sbefifo114: sbefifo@2400 {
-							compatible = "ibm,odyssey-sbefifo";
-							reg = <0x2400 0x400>;
-						};
-					};
-				};
-			};
-
-			cfam0_i2c15: i2c-bus@f {
-				reg = <15>;	/* OP5B */
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				fsi@20 {
-					compatible = "ibm,i2cr-fsi-master";
-					reg = <0x20>;
-					#address-cells = <2>;
-					#size-cells = <0>;
-
-					cfam@0,0 {
-						reg = <0 0>;
-						#address-cells = <1>;
-						#size-cells = <1>;
-						chip-id = <0>;
-
-						scom115: scom@1000 {
-							compatible = "ibm,i2cr-scom";
-							reg = <0x1000 0x400>;
-						};
-
-						sbefifo115: sbefifo@2400 {
-							compatible = "ibm,odyssey-sbefifo";
-							reg = <0x2400 0x400>;
-						};
-					};
-				};
-			};
-		};
-
-		fsi2spi@1c00 {
-			compatible = "ibm,fsi2spi";
-			reg = <0x1c00 0x400>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			cfam0_spi0: spi@0 {
-				compatible = "ibm,spi-fsi";
-				reg = <0x0>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				eeprom@0 {
-					compatible = "atmel,at25";
-					reg = <0>;
-					address-width = <24>;
-					pagesize = <256>;
-					size = <0x80000>;
-					spi-max-frequency = <10000000>;
-				};
-			};
-
-			cfam0_spi1: spi@20 {
-				compatible = "ibm,spi-fsi";
-				reg = <0x20>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				eeprom@0 {
-					compatible = "atmel,at25";
-					reg = <0>;
-					address-width = <24>;
-					pagesize = <256>;
-					size = <0x80000>;
-					spi-max-frequency = <10000000>;
-				};
-			};
-
-			cfam0_spi2: spi@40 {
-				compatible = "ibm,spi-fsi";
-				reg = <0x40>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				eeprom@0 {
-					compatible = "atmel,at25";
-					reg = <0>;
-					address-width = <24>;
-					pagesize = <256>;
-					size = <0x80000>;
-					spi-max-frequency = <10000000>;
-				};
-			};
-
-			cfam0_spi3: spi@60 {
-				compatible = "ibm,spi-fsi";
-				reg = <0x60>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				eeprom@0 {
-					compatible = "atmel,at25";
-					reg = <0>;
-					address-width = <24>;
-					pagesize = <256>;
-					size = <0x80000>;
-					spi-max-frequency = <10000000>;
-				};
-			};
-		};
-
-		sbefifo@2400 {
-			compatible = "ibm,p9-sbefifo";
-			reg = <0x2400 0x400>;
-
-			occ {
-				compatible = "ibm,p10-occ";
-
-				hwmon {
-					compatible = "ibm,p10-occ-hwmon";
-					ibm,no-poll-on-init;
-				};
-			};
-		};
-
-		fsi_hub0: fsi@3400 {
-			compatible = "ibm,p9-fsi-controller";
-			reg = <0x3400 0x400>;
-			#address-cells = <2>;
-			#size-cells = <0>;
-		};
-	};
-};
-
 &fsi_hub0 {
-	cfam@1,0 {
-		reg = <1 0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		chip-id = <1>;
-
-		scom@1000 {
-			compatible = "ibm,p9-scom";
-			reg = <0x1000 0x400>;
-		};
-
-		i2c@1800 {
-			compatible = "ibm,i2c-fsi";
-			reg = <0x1800 0x400>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			cfam1_i2c2: i2c-bus@2 {
-				reg = <2>;	/* OMI45 */
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				fsi@20 {
-					compatible = "ibm,i2cr-fsi-master";
-					reg = <0x20>;
-					#address-cells = <2>;
-					#size-cells = <0>;
-
-					cfam@0,0 {
-						reg = <0 0>;
-						#address-cells = <1>;
-						#size-cells = <1>;
-						chip-id = <0>;
-
-						scom202: scom@1000 {
-							compatible = "ibm,i2cr-scom";
-							reg = <0x1000 0x400>;
-						};
-
-						sbefifo202: sbefifo@2400 {
-							compatible = "ibm,odyssey-sbefifo";
-							reg = <0x2400 0x400>;
-						};
-					};
-				};
-			};
-
-			cfam1_i2c3: i2c-bus@3 {
-				reg = <3>;	/* OMI67 */
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				fsi@20 {
-					compatible = "ibm,i2cr-fsi-master";
-					reg = <0x20>;
-					#address-cells = <2>;
-					#size-cells = <0>;
-
-					cfam@0,0 {
-						reg = <0 0>;
-						#address-cells = <1>;
-						#size-cells = <1>;
-						chip-id = <0>;
-
-						scom203: scom@1000 {
-							compatible = "ibm,i2cr-scom";
-							reg = <0x1000 0x400>;
-						};
-
-						sbefifo203: sbefifo@2400 {
-							compatible = "ibm,odyssey-sbefifo";
-							reg = <0x2400 0x400>;
-						};
-					};
-				};
-			};
-
-			cfam1_i2c10: i2c-bus@a {
-				reg = <10>;	/* OP3A */
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				fsi@20 {
-					compatible = "ibm,i2cr-fsi-master";
-					reg = <0x20>;
-					#address-cells = <2>;
-					#size-cells = <0>;
-
-					cfam@0,0 {
-						reg = <0 0>;
-						#address-cells = <1>;
-						#size-cells = <1>;
-						chip-id = <0>;
-
-						scom210: scom@1000 {
-							compatible = "ibm,i2cr-scom";
-							reg = <0x1000 0x400>;
-						};
-
-						sbefifo210: sbefifo@2400 {
-							compatible = "ibm,odyssey-sbefifo";
-							reg = <0x2400 0x400>;
-						};
-					};
-				};
-			};
-
-			cfam1_i2c11: i2c-bus@b {
-				reg = <11>;	/* OP3B */
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				fsi@20 {
-					compatible = "ibm,i2cr-fsi-master";
-					reg = <0x20>;
-					#address-cells = <2>;
-					#size-cells = <0>;
-
-					cfam@0,0 {
-						reg = <0 0>;
-						#address-cells = <1>;
-						#size-cells = <1>;
-						chip-id = <0>;
-
-						scom211: scom@1000 {
-							compatible = "ibm,i2cr-scom";
-							reg = <0x1000 0x400>;
-						};
-
-						sbefifo211: sbefifo@2400 {
-							compatible = "ibm,odyssey-sbefifo";
-							reg = <0x2400 0x400>;
-						};
-					};
-				};
-			};
-
-			cfam1_i2c14: i2c-bus@e {
-				reg = <14>;	/* OP5A */
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				fsi@20 {
-					compatible = "ibm,i2cr-fsi-master";
-					reg = <0x20>;
-					#address-cells = <2>;
-					#size-cells = <0>;
-
-					cfam@0,0 {
-						reg = <0 0>;
-						#address-cells = <1>;
-						#size-cells = <1>;
-						chip-id = <0>;
-
-						scom214: scom@1000 {
-							compatible = "ibm,i2cr-scom";
-							reg = <0x1000 0x400>;
-						};
-
-						sbefifo214: sbefifo@2400 {
-							compatible = "ibm,odyssey-sbefifo";
-							reg = <0x2400 0x400>;
-						};
-					};
-				};
-			};
-
-			cfam1_i2c15: i2c-bus@f {
-				reg = <15>;	/* OP5B */
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				fsi@20 {
-					compatible = "ibm,i2cr-fsi-master";
-					reg = <0x20>;
-					#address-cells = <2>;
-					#size-cells = <0>;
-
-					cfam@0,0 {
-						reg = <0 0>;
-						#address-cells = <1>;
-						#size-cells = <1>;
-						chip-id = <0>;
-
-						scom215: scom@1000 {
-							compatible = "ibm,i2cr-scom";
-							reg = <0x1000 0x400>;
-						};
-
-						sbefifo215: sbefifo@2400 {
-							compatible = "ibm,odyssey-sbefifo";
-							reg = <0x2400 0x400>;
-						};
-					};
-				};
-			};
-
-			cfam1_i2c16: i2c-bus@10 {
-				reg = <16>;	/* OP6A */
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				fsi@20 {
-					compatible = "ibm,i2cr-fsi-master";
-					reg = <0x20>;
-					#address-cells = <2>;
-					#size-cells = <0>;
-
-					cfam@0,0 {
-						reg = <0 0>;
-						#address-cells = <1>;
-						#size-cells = <1>;
-						chip-id = <0>;
-
-						scom216: scom@1000 {
-							compatible = "ibm,i2cr-scom";
-							reg = <0x1000 0x400>;
-						};
-
-						sbefifo216: sbefifo@2400 {
-							compatible = "ibm,odyssey-sbefifo";
-							reg = <0x2400 0x400>;
-						};
-					};
-				};
-			};
-
-			cfam1_i2c17: i2c-bus@11 {
-				reg = <17>;	/* OP6B */
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				fsi@20 {
-					compatible = "ibm,i2cr-fsi-master";
-					reg = <0x20>;
-					#address-cells = <2>;
-					#size-cells = <0>;
-
-					cfam@0,0 {
-						reg = <0 0>;
-						#address-cells = <1>;
-						#size-cells = <1>;
-						chip-id = <0>;
-
-						scom217: scom@1000 {
-							compatible = "ibm,i2cr-scom";
-							reg = <0x1000 0x400>;
-						};
-
-						sbefifo217: sbefifo@2400 {
-							compatible = "ibm,odyssey-sbefifo";
-							reg = <0x2400 0x400>;
-						};
-					};
-				};
-			};
-		};
-
-		fsi2spi@1c00 {
-			compatible = "ibm,fsi2spi";
-			reg = <0x1c00 0x400>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			cfam1_spi0: spi@0 {
-				compatible = "ibm,spi-fsi";
-				reg = <0x0>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				eeprom@0 {
-					compatible = "atmel,at25";
-					reg = <0>;
-					address-width = <24>;
-					pagesize = <256>;
-					size = <0x80000>;
-					spi-max-frequency = <10000000>;
-				};
-			};
-
-			cfam1_spi1: spi@20 {
-				compatible = "ibm,spi-fsi";
-				reg = <0x20>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				eeprom@0 {
-					compatible = "atmel,at25";
-					reg = <0>;
-					address-width = <24>;
-					pagesize = <256>;
-					size = <0x80000>;
-					spi-max-frequency = <10000000>;
-				};
-			};
-
-			cfam1_spi2: spi@40 {
-				compatible = "ibm,spi-fsi";
-				reg = <0x40>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				eeprom@0 {
-					compatible = "atmel,at25";
-					reg = <0>;
-					address-width = <24>;
-					pagesize = <256>;
-					size = <0x80000>;
-					spi-max-frequency = <10000000>;
-				};
-			};
-
-			cfam1_spi3: spi@60 {
-				compatible = "ibm,spi-fsi";
-				reg = <0x60>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				eeprom@0 {
-					compatible = "atmel,at25";
-					reg = <0>;
-					address-width = <24>;
-					pagesize = <256>;
-					size = <0x80000>;
-					spi-max-frequency = <10000000>;
-				};
-			};
-		};
-
-		sbefifo@2400 {
-			compatible = "ibm,p9-sbefifo";
-			reg = <0x2400 0x400>;
-
-			occ {
-				compatible = "ibm,p10-occ";
-
-				hwmon {
-					compatible = "ibm,p10-occ-hwmon";
-					ibm,no-poll-on-init;
-				};
-			};
-		};
-
-		fsi@3400 {
-			compatible = "ibm,p9-fsi-controller";
-			reg = <0x3400 0x400>;
-			#address-cells = <2>;
-			#size-cells = <0>;
-			no-scan-on-init;
-		};
-	};
-
 	cfam@2,0 {
 		reg = <2 0>;
 		#address-cells = <1>;
-- 
2.43.5


