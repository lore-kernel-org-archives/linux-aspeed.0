Return-Path: <linux-aspeed+bounces-2280-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A33ECA1013
	for <linux-aspeed@archiver.kernel.org>; Thu, 18 Sep 2025 18:04:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cSNnQ3c93z30QJ;
	Fri, 19 Sep 2025 04:04:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758218666;
	cv=none; b=ZMf+rB5z9WkkjlQ33EtOv5i10eKWJ2jY694Xztcjud+co7F9kiuh74qOKBqj1TRQZ9737h1nvD00wciCvQnhbi1GdN2o2ZG95KjE0aNfvDmG6Hz2ttaOmDSI5rWzYdMKaYBTtvNgp4vuglTmPk9Q3QsK7UHFr1gOIgPMu7Sje/RcspqxzYWdRsN49uc3CWHFR4LcArDXqbBlb2r32BgZoDtsTKcfRLxh1C7Cru9phDXh5z651F4D7QC4ilaRACIFYMPhxtrEvA4gUlZFaLV2OkzUe/wiqoDZ1QtFfbdYx1nDSgAD/sSw1meXa73J9rH2SvVXnLWNwnc1oRzgHl4bEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758218666; c=relaxed/relaxed;
	bh=if6ALgMRVzMefm3OFF1RvCuqGOEDohplLCZi8aJwoE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcja/rq73YXBKvwX4ha5Vl9Cl+2TShk0TJFPSMEqK4ydU2tUAWGtMyDH3UKCn/bZSRYPY/3Lb3I0ZaEN/swPqQUhyB3kXEQxShqIGZJEN4u0BIY+sYepLPOnO8S8I/pA7PNmBYEjCWJLDWY8QJq9zzRgcIHNOXlQe7xLXxX8dXfHZkq5RJ0Ki3h6CNAvUFPIqa0MaCl7SL/enh0jjLdQfR4SMERtPcvh0P1A/+BJPVo1DB4ezxXQet2vmJdrwJ9XDlABwK6Er+HH4aAf2MRZdSkhnLNuZU+yUBTnmcGCbcAB2ygMk+7+1gHiaoiewR9Jo2fDGWRCX+GdTI6otmY7dg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Mn5kjUVb; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Mn5kjUVb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cSNnP0QcCz2xnh
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Sep 2025 04:04:24 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ICwIwx027055;
	Thu, 18 Sep 2025 18:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=if6ALgMRVzMefm3OF
	F1RvCuqGOEDohplLCZi8aJwoE0=; b=Mn5kjUVbjwcmT6dRAVBE/CkU74cttHEKo
	/z5GkWX+DvR1Jd7KF7EEHWDKHj87pmarAd7s8u/MMWSlwqvPPgbiwKkihPYAnCDq
	FpOatFgHhBuoxMpL4e2b+CbwpLb43ieAkCy1p7DUZbhJFaBL3tq4dkEegHuNIYGu
	aTnhrdgLYHfJb3AcBQWo8tX+Oo20t7ipacQoNqQC+Ac37wKZRWrgvx9CcGILNCFo
	hsKIXiKS+UcwauYSyklmUln/pEQ+BceNq/mI6KTnn6pZ4G0Pm1iXEq13ystFQXXz
	+1J/gxsOlwLn0NBP5JDqBfqYBJZR+UGsuTRuiCFLDNyYp3L6OcgqQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4pc327-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 18:04:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58II1Kwa019200;
	Thu, 18 Sep 2025 18:04:13 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 495n5mqvqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 18:04:12 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58II4CCQ21627486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 18:04:12 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D886358056;
	Thu, 18 Sep 2025 18:04:11 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A18EA5805A;
	Thu, 18 Sep 2025 18:04:11 +0000 (GMT)
Received: from slate16 (unknown [9.61.169.208])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Sep 2025 18:04:11 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-aspeed@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, andrew@codeconstruct.com.au,
        conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
        eajames@linux.ibm.com
Subject: [PATCH v6 6/7] ARM: dts: aspeed: Add Balcones system
Date: Thu, 18 Sep 2025 13:04:01 -0500
Message-ID: <20250918180402.199373-7-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918180402.199373-1-eajames@linux.ibm.com>
References: <20250918180402.199373-1-eajames@linux.ibm.com>
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
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX9rtnUGGqlBk0
 g2NbMkyI7sL4Nai2/1KqflCVuCejxJ6kCnR5tLKlSWVgcEGRHJqYNqNuT/Ty+VhBGGrXij9Mr0J
 ulEDoHl3ZBSzZYqvL0BYZ9sHzstcnZoE+J/6egrxTzG2miIL7xozFxZHslMevJCmZZuuBdCSmRZ
 TejFIs73cg+0EH1HrJXxBaHVr1QYR8io/wHeKXVPfUwO4r1Gua1maUuyR9O+k6S/uRHyO/sM3UY
 pruTGLLf6oTf7DgiPQ9QhqWWAH+6wOlnEJGrCigwdkCPap/vN14gWM4l7eZx86cyB3xRnLi4TGe
 AyAsPlccyssVDNOfnawpYUfmOegPzaUvsNs0Mu9M5DU5JOuCzO/eEo+jVFS4xVUgGZewVKZJNkQ
 X/mlMwcG
X-Proofpoint-ORIG-GUID: 9_Ul9vaIbPcIqIHBrgDDiA99pckQGaiT
X-Proofpoint-GUID: 9_Ul9vaIbPcIqIHBrgDDiA99pckQGaiT
X-Authority-Analysis: v=2.4 cv=cNzgskeN c=1 sm=1 tr=0 ts=68cc49a0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=20HM6ubeVw3F5D9bI7gA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

The Balcones system is similar to Bonnell but with a POWER11 processor.
Like POWER10, the POWER11 is a dual-chip module, so a dual chip FSI
tree is needed. Therefore, split up the quad chip FSI tree.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../dts/aspeed/aspeed-bmc-ibm-balcones.dts    | 609 ++++++++++++++
 .../arm/boot/dts/aspeed/ibm-power11-dual.dtsi | 779 ++++++++++++++++++
 .../arm/boot/dts/aspeed/ibm-power11-quad.dtsi | 769 +----------------
 4 files changed, 1391 insertions(+), 767 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dts
 create mode 100644 arch/arm/boot/dts/aspeed/ibm-power11-dual.dtsi

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index 0f0b5b7076545..b56429777c7ef 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -39,6 +39,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-facebook-yamp.dtb \
 	aspeed-bmc-facebook-yosemitev2.dtb \
 	aspeed-bmc-facebook-yosemite4.dtb \
+	aspeed-bmc-ibm-balcones.dtb \
 	aspeed-bmc-ibm-blueridge.dtb \
 	aspeed-bmc-ibm-bonnell.dtb \
 	aspeed-bmc-ibm-everest.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dts
new file mode 100644
index 0000000000000..63fcb7a7619ab
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-balcones.dts
@@ -0,0 +1,609 @@
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
+};
+
+&adc1 {
+	aspeed,int-vref-microvolt = <2500000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default
+		&pinctrl_adc10_default &pinctrl_adc11_default
+		&pinctrl_adc12_default &pinctrl_adc13_default
+		&pinctrl_adc14_default &pinctrl_adc15_default>;
+	status = "okay";
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&emmc {
+	clk-phase-mmc-hs200 = <180>, <180>;
+	status = "okay";
+};
+
+&emmc_controller {
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
+		/*F0-F7*/	"","fan-ctlr-reset","rtc-battery-voltage-read-enable",
+				"reset-cause-pinhole","","","","",
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
+&i2c0 {
+	status = "okay";
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
+
+	eeprom@51 {
+		compatible = "atmel,24c64";
+		reg = <0x51>;
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
+	led-controller@62 {
+		compatible = "nxp,pca9551";
+		reg = <0x62>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		led@0 {
+			reg = <0>;
+			default-state = "keep";
+			label = "cablecard2-cxp-top";
+			retain-state-shutdown;
+			type = <PCA955X_TYPE_LED>;
+		};
+
+		led@1 {
+			reg = <1>;
+			default-state = "keep";
+			label = "cablecard2-cxp-bot";
+			retain-state-shutdown;
+			type = <PCA955X_TYPE_LED>;
+		};
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
+
+	led-controller@61 {
+		compatible = "nxp,pca9552";
+		reg = <0x61>;
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
+&ibt {
+	status = "okay";
+};
+
+&kcs2 {
+	aspeed,lpc-io-reg = <0xca8 0xcac>;
+	status = "okay";
+};
+
+&kcs3 {
+	aspeed,lpc-io-reg = <0xca2>;
+	aspeed,lpc-interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+	status = "okay";
+};
+
+&lpc_ctrl {
+	memory-region = <&flash_memory>;
+	status = "okay";
+};
+
+&mac2 {
+	clocks = <&syscon ASPEED_CLK_GATE_MAC3CLK>,
+		 <&syscon ASPEED_CLK_MAC3RCLK>;
+	clock-names = "MACCLK", "RCLK";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rmii3_default>;
+	use-ncsi;
+	status = "okay";
+};
+
+&pinctrl_emmc_default {
+	bias-disable;
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uhci {
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
diff --git a/arch/arm/boot/dts/aspeed/ibm-power11-dual.dtsi b/arch/arm/boot/dts/aspeed/ibm-power11-dual.dtsi
new file mode 100644
index 0000000000000..6db02d4753800
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
+	bus-frequency = <100000000>;
+	#address-cells = <2>;
+	#size-cells = <0>;
+	cfam-reset-gpios = <&gpio0 ASPEED_GPIO(Q, 0) GPIO_ACTIVE_HIGH>;
+	status = "okay";
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
2.51.0


