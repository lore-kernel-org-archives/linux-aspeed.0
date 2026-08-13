Return-Path: <linux-aspeed+bounces-4715-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BAE5C5CFCF
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Aug 2026 00:46:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLk7G4w7Dz2yrW;
	Fri, 14 Aug 2026 10:46:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786622412;
	cv=none; b=AlExLT5htxABcbb/BBOjvJ4s2hCfSkOLfXby3evVPE1G7Yy07C9Ev9f8b2La5EKg4RTtmCHR9d/vA0aLwb75+3HZPzVXRiNzczHiXV6z2v5iJcyUBILt2+eCxX9mg7e8H0PmZymUNcBKxChE2GnAqktTeF6+tUwcp7H6GgPVESVG1jgQDS/3mDoN/ToUBBQ4erVc2jvRMqyrZvnwVUOXC/bRpg8NqF/S8rE5EBf0IWCl4EFPxJzekj5cAY/4o/vCPcqlWBa57XEdbvAfW3YWR1oHQLBNHVW2puT+B8e+zoWFzxPRnizbMSJeE0tKG4sZn5vxi/cAjBJOd5Jnkc8b0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786622412; c=relaxed/relaxed;
	bh=Ipqn7Dkd6CQ99AEunlwYOOZkU1ZAQ0f7JeV7E9wEu4A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eaZgxmtUP6jVjf6XaNavjS17w6TfS67cuRaZJL79k8nyIkfgc/fMzD7fhDHrQcMnFWGHCI8mF8cyUiNaC6jTlpUV8/B53dYhdkGrkvzlt/QobpeziPU0ECGjmGk5j/XDzmRyqsDNIpGNT9WtHY/TYC0BTD8KV6XSx0uG/cT3eGh3/Gb77A5+V6YtANPUbjL7coSGAkXqFdNJQnUa6uZ3Wa1AFluajcZfaGDMtcfzItnLsOXNyhNHqsJqF0oNssynTFYWDAHyyFAJICk6/+MNUAOx6MNAuo4LwzojqzZE0nplZALY9ZH6dN7wjP+qUoWeWbIyzmtNLrBpyJ1AlvN50A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=X1uc+8cd; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=X1uc+8cd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLP7C0s6kz2ynC
	for <linux-aspeed@lists.ozlabs.org>; Thu, 13 Aug 2026 22:00:06 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 10733440AC;
	Thu, 13 Aug 2026 12:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A85C3C2BCF5;
	Thu, 13 Aug 2026 12:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786622400;
	bh=kfI0Lvv3OwSnYPZPBSODtwSdZEIQUSBsFrxfbb800Jk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=X1uc+8cdPbdvc2WbuKjlbEDHN4k91baSr2pI8AOPVd6nOA8mFgyrOsfNBEobAr9/b
	 0Xvyf937vkfGoxTcbk62mSiIg04U7hHTkGBraXCNw08tnBdcVMyijaOy5b6llaN5Gm
	 th4LqGs1Lq+iK1Lcy5OcJOKDYf3SrkNNoONb1VQaRac1pcguC546Dm3xU7SbTSatEZ
	 jOmMyfLnrwaPyhDRwXZo1YfGVGVCAE12uz6G7ZoYXxotpHW/6Q8m7o+nIfu++i5v+k
	 uC+oI2EmYZsu2paXdOgbMlv2aCnQMLbwzbf4S5v99q+kh8nQmobGqrhoFcBMQDn2mb
	 gx5W3vsz5MqWQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D861C5DF70;
	Thu, 13 Aug 2026 12:00:00 +0000 (UTC)
From: Colin Huang via B4 Relay <devnull+u8813345.gmail.com@kernel.org>
Date: Thu, 13 Aug 2026 19:59:43 +0800
Subject: [PATCH v5 13/15] ARM: dts: aspeed: anacapa: fix dt-check-style
 strict violations
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
Message-Id: <20260813-anacapa-devlop-phase-devicetree-v5-13-c7058f63dc67@gmail.com>
References: <20260813-anacapa-devlop-phase-devicetree-v5-0-c7058f63dc67@gmail.com>
In-Reply-To: <20260813-anacapa-devlop-phase-devicetree-v5-0-c7058f63dc67@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 colin.huang2@amd.com, Colin Huang <u8813345@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786622378; l=27217;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=9caKRgfNZf0Q4hB3JVLKUxfesytPJFOG/3lCSi3lw6E=;
 b=jURynCfVVIrHtCYGVcEvex+UT4750m5a3pSQXZu5oXxq+yPoBghHXqg6aDDHDW/O1Pn7dREOa
 RC5B7uKBOB5A+nWKW1SAUaBfM2ekxjDgU9udglCO+U6khL2doxEImnF
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-Endpoint-Received: by B4 Relay for u8813345@gmail.com/20260202 with
 auth_id=761
X-Original-From: Colin Huang <u8813345@gmail.com>
Reply-To: u8813345@gmail.com

From: Colin Huang <u8813345@gmail.com>

Run scripts/dtc/dt-check-style --mode strict against the Facebook
Anacapa board device trees and fix the reported violations:

 - aspeed-bmc-facebook-anacapa.dts: drop a duplicate trailing blank
   line at end of file.
 - aspeed-bmc-facebook-anacapa-dvt.dts,
   aspeed-bmc-facebook-anacapa-evt2.dts,
   aspeed-bmc-facebook-anacapa-evt1.dts:
   - reorder compatible/model so compatible comes first
   - add required blank lines before child nodes and before the
     status property
   - sort properties into the tool's canonical bucket order (e.g.
     bus-frequency before gpio-line-names before ngpios before
     status in the &sgpiom0 override, m25p,fast-read/label ordering
     in flash@0, #gpio-cells/gpio-controller/gpio-line-names
     ordering in gpio@24 and gpio@38)
   - align multi-line property continuations (io-channels,
     pinctrl-0) under the opening '<' column
   - fix child-name-order and child-address-order violations
     (framebuffer before video in reserved-memory, gpio@24 before
     power-monitor@N, regulator-p3v3-bmc-aux before reserved-memory)
   - remove redundant node labels that were never &-referenced
     anywhere in the tree (i2c8mux0ch0, i2c8mux0ch1, i2c13mux0ch7,
     spi_gpio); these labels only existed for node-merge overrides
     via #include and are not needed since nodes merge by name and
     unit address

One unused-labels warning remains in evt1.dts for the p3v3_bmc_aux
label: it is genuinely referenced via "&p3v3_bmc_aux" in
aspeed-bmc-facebook-anacapa-evt2.dts, which #include's evt1.dts.
dt-check-style only tracks same-file references for non-.dtsi
files, so this is a known false positive of the per-file checker
given this board family's #include-based override architecture,
and is not fixed here to avoid breaking the regulator reference.

All four files pass "dt-check-style --mode strict" except for that
documented false positive.

Signed-off-by: Colin Huang <u8813345@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dts |  31 +--
 .../aspeed/aspeed-bmc-facebook-anacapa-evt1.dts    | 222 +++++++++++++--------
 .../aspeed/aspeed-bmc-facebook-anacapa-evt2.dts    |  83 +++++---
 .../dts/aspeed/aspeed-bmc-facebook-anacapa.dts     |   1 -
 4 files changed, 210 insertions(+), 127 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dts
index f710046f79bc..ce5aecc984c8 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dts
@@ -4,14 +4,14 @@
 #include "aspeed-bmc-facebook-anacapa-evt2.dts"
 
 / {
-	model = "Facebook Anacapa BMC";
 	compatible = "facebook,anacapa-bmc-dvt", "aspeed,ast2600";
+	model = "Facebook Anacapa BMC";
 };
 
 // MB - PDB
 &i2c8 {
 	i2c-mux@72 {
-		i2c8mux0ch0: i2c@0 {
+		i2c@0 {
 			gpio@22 {
 				gpio-line-names =
 					"RPDB_FAN_FULL_SPEED_R_N", "RPDB_I2C_TMP432_U8_ALERT_R_N",
@@ -25,6 +25,7 @@ gpio@22 {
 					"RPDB_PGD_P3V3_STBY_PWRGD_R",
 					"RPDB_P12V_STBY_VRM_PWRGD_BUF_R";
 			};
+
 			gpio@24 {
 				gpio-line-names =
 					"RPDB_EAM2_PRSNT_MOS_N_R", "RPDB_EAM3_PRSNT_MOS_N_R",
@@ -37,23 +38,25 @@ gpio@24 {
 					"RPDB_FAN7_PRSNT_N_R", "RPDB_FAN8_PRSNT_N_R",
 					"", "";
 			};
+
 			gpio@38 {
 				compatible = "nxp,pca9554";
 				reg = <0x38>;
-				gpio-controller;
 				#gpio-cells = <2>;
-
-				interrupt-parent = <&sgpiom0>;
-				interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
+				gpio-controller;
 
 				gpio-line-names =
 					"RPDB_P50V_FUSE2_TVS1", "RPDB_P50V_FUSE2_TVS2",
 					"RPDB_P50V_FUSE3_TVS1", "RPDB_P50V_FUSE3_TVS2",
 					"RPDB_P50V_FUSE4_TVS1", "",
 					"", "";
+
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
 			};
 		};
-		i2c8mux0ch1: i2c@1 {
+
+		i2c@1 {
 			gpio@22 {
 				gpio-line-names =
 					"LPDB_FAN_FULL_SPEED_R_N", "LPDB_I2C_TEMP75_U8_ALERT_R_N",
@@ -65,6 +68,7 @@ gpio@22 {
 					"LPDB_EAM0_PRSNT_MOS_N_R", "LPDB_EAM1_PRSNT_MOS_N_R",
 					"LPDB_PWRGD_P50V_HSC5_SYS_R", "BARKLIP_PRSNT_N_R3";
 			};
+
 			gpio@24 {
 				gpio-line-names =
 					"LPDB_P50V_FAN0_R2_PG", "LPDB_P50V_FAN1_R2_PG",
@@ -76,27 +80,27 @@ gpio@24 {
 					"", "",
 					"", "LPDB_PG_P3V3_R";
 			};
+
 			gpio@38 {
 				compatible = "nxp,pca9554";
 				reg = <0x38>;
-				gpio-controller;
 				#gpio-cells = <2>;
-
-				interrupt-parent = <&sgpiom0>;
-				interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
+				gpio-controller;
 
 				gpio-line-names =
 					"LPDB_P50V_FUSE0_TVS1", "LPDB_P50V_FUSE0_TVS2",
 					"LPDB_P50V_FUSE1_TVS1", "LPDB_P50V_FUSE1_TVS2",
 					"LPDB_P50V_FUSE5_TVS1", "",
 					"", "";
+
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
 			};
 		};
 	};
 };
 
 &sgpiom0 {
-	ngpios = <128>;
 	bus-frequency = <2000000>;
 	gpio-line-names =
 	/*in - out */
@@ -260,6 +264,7 @@ &sgpiom0 {
 	"AMC_FAIL", "HPM_CPLD_RISCV_RST",
 	"S0_ON", "";
 
+	ngpios = <128>;
+
 	status = "okay";
 };
-
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts
index a095be48a3fe..f27ec52f9d56 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dts
@@ -6,15 +6,10 @@
 #include <dt-bindings/i2c/i2c.h>
 
 / {
-	model = "Facebook Anacapa BMC";
 	compatible = "facebook,anacapa-bmc-evt1", "aspeed,ast2600";
+	model = "Facebook Anacapa BMC";
 
 	aliases {
-		serial0 = &uart1;
-		serial1 = &uart2;
-		serial2 = &uart3;
-		serial3 = &uart4;
-		serial4 = &uart5;
 		i2c16 = &i2c0mux0ch0;
 		i2c17 = &i2c0mux0ch1;
 		i2c18 = &i2c0mux0ch2;
@@ -59,6 +54,11 @@ aliases {
 		i2c57 = &i2c13mux0ch5;
 		i2c58 = &i2c13mux0ch6;
 		i2c59 = &i2c13mux0ch7;
+		serial0 = &uart1;
+		serial1 = &uart2;
+		serial2 = &uart3;
+		serial3 = &uart4;
+		serial4 = &uart5;
 	};
 
 	chosen {
@@ -68,93 +68,96 @@ chosen {
 	iio-hwmon {
 		compatible = "iio-hwmon";
 		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
-				  <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
-				  <&adc1 2>;
+			      <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
+			      <&adc1 2>;
 	};
 
 	leds {
 		compatible = "gpio-leds";
 
 		led-0 {
-			label = "bmc_heartbeat_amber";
 			gpios = <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW>;
+			label = "bmc_heartbeat_amber";
 			linux,default-trigger = "heartbeat";
 		};
 
 		led-1 {
-			label = "fp_id_amber";
 			default-state = "off";
 			gpios = <&gpio0 ASPEED_GPIO(B, 5) GPIO_ACTIVE_HIGH>;
+			label = "fp_id_amber";
 		};
 	};
 
 	memory@80000000 {
-		device_type = "memory";
 		reg = <0x80000000 0x80000000>;
+		device_type = "memory";
+	};
+
+	p3v3_bmc_aux: regulator-p3v3-bmc-aux {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "p3v3_bmc_aux";
 	};
 
 	reserved-memory {
+		ranges;
 		#address-cells = <1>;
 		#size-cells = <1>;
-		ranges;
 
-		video_engine_memory: video {
-			size = <0x02c00000>;
-			alignment = <0x00100000>;
+		gfx_memory: framebuffer {
 			compatible = "shared-dma-pool";
+			alignment = <0x01000000>;
 			reusable;
+			size = <0x01000000>;
 		};
 
-		gfx_memory: framebuffer {
-			size = <0x01000000>;
-			alignment = <0x01000000>;
+		video_engine_memory: video {
 			compatible = "shared-dma-pool";
+			alignment = <0x00100000>;
 			reusable;
+			size = <0x02c00000>;
 		};
 	};
 
-	p3v3_bmc_aux: regulator-p3v3-bmc-aux {
-		compatible = "regulator-fixed";
-		regulator-name = "p3v3_bmc_aux";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
-	};
-
-	spi_gpio: spi {
+	spi {
 		compatible = "spi-gpio";
 		#address-cells = <1>;
-		#size-cells = <0>;
+		cs-gpios = <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
 
-		sck-gpios = <&gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
-		mosi-gpios = <&gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
 		miso-gpios = <&gpio0 ASPEED_GPIO(Z, 5) GPIO_ACTIVE_HIGH>;
-		cs-gpios = <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
+		mosi-gpios = <&gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
 		num-chipselects = <1>;
+		sck-gpios = <&gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
+		#size-cells = <0>;
+
 		status = "okay";
 
 		tpm@0 {
 			compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
-			spi-max-frequency = <33000000>;
 			reg = <0>;
+			spi-max-frequency = <33000000>;
 		};
 	};
 };
 
 &adc0 {
-	aspeed,int-vref-microvolt = <2500000>;
-	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_adc0_default &pinctrl_adc1_default
-		&pinctrl_adc2_default &pinctrl_adc3_default
-		&pinctrl_adc4_default &pinctrl_adc5_default
-		&pinctrl_adc6_default &pinctrl_adc7_default>;
+		    &pinctrl_adc2_default &pinctrl_adc3_default
+		    &pinctrl_adc4_default &pinctrl_adc5_default
+		    &pinctrl_adc6_default &pinctrl_adc7_default>;
+	pinctrl-names = "default";
+	aspeed,int-vref-microvolt = <2500000>;
+
 	status = "okay";
 };
 
 &adc1 {
-	aspeed,int-vref-microvolt = <2500000>;
-	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_adc10_default>;
+	pinctrl-names = "default";
+	aspeed,int-vref-microvolt = <2500000>;
+
 	status = "okay";
 };
 
@@ -166,24 +169,27 @@ &fmc {
 	status = "okay";
 
 	flash@0 {
-		status = "okay";
-		m25p,fast-read;
 		label = "bmc";
 		spi-max-frequency = <50000000>;
+		m25p,fast-read;
+
+		status = "okay";
 #include "openbmc-flash-layout-128.dtsi"
 	};
 
 	flash@1 {
-		status = "okay";
-		m25p,fast-read;
 		label = "alt-bmc";
 		spi-max-frequency = <50000000>;
+		m25p,fast-read;
+
+		status = "okay";
 	};
 };
 
 &gfx {
-	status = "okay";
 	memory-region = <&gfx_memory>;
+
+	status = "okay";
 };
 
 &gpio0 {
@@ -310,24 +316,27 @@ i2c-mux@70 {
 		compatible = "nxp,pca9546";
 		reg = <0x70>;
 		#address-cells = <1>;
-		#size-cells = <0>;
 		i2c-mux-idle-disconnect;
+		#size-cells = <0>;
 
 		i2c0mux0ch0: i2c@0 {
 			reg = <0>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c0mux0ch1: i2c@1 {
 			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c0mux0ch2: i2c@2 {
 			reg = <2>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c0mux0ch3: i2c@3 {
 			reg = <3>;
 			#address-cells = <1>;
@@ -350,24 +359,27 @@ i2c-mux@70 {
 		compatible = "nxp,pca9546";
 		reg = <0x70>;
 		#address-cells = <1>;
-		#size-cells = <0>;
 		i2c-mux-idle-disconnect;
+		#size-cells = <0>;
 
 		i2c1mux0ch0: i2c@0 {
 			reg = <0>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c1mux0ch1: i2c@1 {
 			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c1mux0ch2: i2c@2 {
 			reg = <2>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c1mux0ch3: i2c@3 {
 			reg = <3>;
 			#address-cells = <1>;
@@ -384,44 +396,51 @@ i2c-mux@70 {
 		compatible = "nxp,pca9548";
 		reg = <0x70>;
 		#address-cells = <1>;
-		#size-cells = <0>;
 		i2c-mux-idle-disconnect;
+		#size-cells = <0>;
 
 		i2c4mux0ch0: i2c@0 {
 			reg = <0>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c4mux0ch1: i2c@1 {
 			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c4mux0ch2: i2c@2 {
 			reg = <2>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c4mux0ch3: i2c@3 {
 			reg = <3>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c4mux0ch4: i2c@4 {
 			reg = <4>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c4mux0ch5: i2c@5 {
 			reg = <5>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c4mux0ch6: i2c@6 {
 			reg = <6>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c4mux0ch7: i2c@7 {
 			reg = <7>;
 			#address-cells = <1>;
@@ -449,8 +468,6 @@ eeprom@50 {
 // SCM
 &i2c7 {
 	status = "okay";
-
-
 };
 
 // MB - PDB
@@ -461,8 +478,8 @@ i2c-mux@72 {
 		compatible = "nxp,pca9546";
 		reg = <0x72>;
 		#address-cells = <1>;
-		#size-cells = <0>;
 		i2c-mux-idle-disconnect;
+		#size-cells = <0>;
 
 		i2c8mux0ch0: i2c@0 {
 			reg = <0>;
@@ -478,11 +495,8 @@ adc@1f {
 			gpio@22 {
 				compatible = "nxp,pca9555";
 				reg = <0x22>;
-				gpio-controller;
 				#gpio-cells = <2>;
-
-				interrupt-parent = <&sgpiom0>;
-				interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
+				gpio-controller;
 
 				gpio-line-names =
 					"RPDB_FAN_FULL_SPEED_R_N", "RPDB_I2C_TEMP75_U8_ALERT_R_N",
@@ -495,16 +509,16 @@ gpio@22 {
 					"RPDB_I2C_P12V_STBY_VRM_ALERT_R_N",
 					"RPDB_PGD_P3V3_STBY_PWRGD_R",
 					"RPDB_P12V_STBY_VRM_PWRGD_BUF_R";
+				interrupt-parent = <&sgpiom0>;
+
+				interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
 			};
 
 			gpio@24 {
 				compatible = "nxp,pca9555";
 				reg = <0x24>;
-				gpio-controller;
 				#gpio-cells = <2>;
-
-				interrupt-parent = <&sgpiom0>;
-				interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
+				gpio-controller;
 
 				gpio-line-names =
 					"RPDB_EAM2_PRSNT_MOS_N_R", "RPDB_EAM3_PRSNT_MOS_N_R",
@@ -516,6 +530,9 @@ gpio@24 {
 					"", "RPDB_FAN2_PRSNT_N_R",
 					"RPDB_FAN3_PRSNT_N_R", "RPDB_FAN4_PRSNT_N_R",
 					"", "";
+				interrupt-parent = <&sgpiom0>;
+
+				interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
 			};
 
 			// R-PDB FRU
@@ -524,6 +541,7 @@ eeprom@50 {
 				reg = <0x50>;
 			};
 		};
+
 		i2c8mux0ch1: i2c@1 {
 			reg = <1>;
 			#address-cells = <1>;
@@ -532,11 +550,8 @@ i2c8mux0ch1: i2c@1 {
 			gpio@22 {
 				compatible = "nxp,pca9555";
 				reg = <0x22>;
-				gpio-controller;
 				#gpio-cells = <2>;
-
-				interrupt-parent = <&sgpiom0>;
-				interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
+				gpio-controller;
 
 				gpio-line-names =
 					"LPDB_FAN_FULL_SPEED_R_N","LPDB_I2C_TEMP75_U8_ALERT_R_N",
@@ -547,16 +562,16 @@ gpio@22 {
 					"LPDB_ALERT_P50V_HSC5_R_N","LPDB_I2C_P12V_SW_VRM_ALERT_R_N",
 					"LPDB_EAM0_PRSNT_MOS_N_R","LPDB_EAM1_PRSNT_MOS_N_R",
 					"LPDB_PWRGD_P50V_HSC5_SYS_R","";
+				interrupt-parent = <&sgpiom0>;
+
+				interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
 			};
 
 			gpio@24 {
 				compatible = "nxp,pca9555";
 				reg = <0x24>;
-				gpio-controller;
 				#gpio-cells = <2>;
-
-				interrupt-parent = <&sgpiom0>;
-				interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
+				gpio-controller;
 
 				gpio-line-names =
 					"LPDB_P50V_FAN1_R2_PG","LPDB_P50V_FAN2_R2_PG",
@@ -567,6 +582,9 @@ gpio@24 {
 					"","",
 					"","",
 					"","";
+				interrupt-parent = <&sgpiom0>;
+
+				interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
 			};
 
 			// L-PDB FRU
@@ -575,11 +593,13 @@ eeprom@50 {
 				reg = <0x50>;
 			};
 		};
+
 		i2c8mux0ch2: i2c@2 {
 			reg = <2>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c8mux0ch3: i2c@3 {
 			reg = <3>;
 			#address-cells = <1>;
@@ -613,34 +633,39 @@ i2c-mux@71 {
 		compatible = "nxp,pca9548";
 		reg = <0x71>;
 		#address-cells = <1>;
-		#size-cells = <0>;
 		i2c-mux-idle-disconnect;
+		#size-cells = <0>;
 
 		i2c10mux0ch0: i2c@0 {
 			reg = <0>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c10mux0ch1: i2c@1 {
 			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c10mux0ch2: i2c@2 {
 			reg = <2>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c10mux0ch3: i2c@3 {
 			reg = <3>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c10mux0ch4: i2c@4 {
 			reg = <4>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c10mux0ch5: i2c@5 {
 			reg = <5>;
 			#address-cells = <1>;
@@ -649,8 +674,8 @@ i2c10mux0ch5: i2c@5 {
 			gpio@22 {
 				compatible = "nxp,pca9555";
 				reg = <0x22>;
-				gpio-controller;
 				#gpio-cells = <2>;
+				gpio-controller;
 
 				gpio-line-names =
 					"","",
@@ -669,11 +694,13 @@ eeprom@52 {
 				reg = <0x52>;
 			};
 		};
+
 		i2c10mux0ch6: i2c@6 {
 			reg = <6>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c10mux0ch7: i2c@7 {
 			reg = <7>;
 			#address-cells = <1>;
@@ -690,34 +717,39 @@ i2c-mux@71 {
 		compatible = "nxp,pca9548";
 		reg = <0x71>;
 		#address-cells = <1>;
-		#size-cells = <0>;
 		i2c-mux-idle-disconnect;
+		#size-cells = <0>;
 
 		i2c11mux0ch0: i2c@0 {
 			reg = <0>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c11mux0ch1: i2c@1 {
 			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c11mux0ch2: i2c@2 {
 			reg = <2>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c11mux0ch3: i2c@3 {
 			reg = <3>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c11mux0ch4: i2c@4 {
 			reg = <4>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c11mux0ch5: i2c@5 {
 			reg = <5>;
 			#address-cells = <1>;
@@ -726,8 +758,8 @@ i2c11mux0ch5: i2c@5 {
 			gpio@22 {
 				compatible = "nxp,pca9555";
 				reg = <0x22>;
-				gpio-controller;
 				#gpio-cells = <2>;
+				gpio-controller;
 
 				gpio-line-names =
 					"","",
@@ -746,11 +778,13 @@ eeprom@52 {
 				reg = <0x52>;
 			};
 		};
+
 		i2c11mux0ch6: i2c@6 {
 			reg = <6>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c11mux0ch7: i2c@7 {
 			reg = <7>;
 			#address-cells = <1>;
@@ -772,24 +806,27 @@ i2c-mux@70 {
 		compatible = "nxp,pca9548";
 		reg = <0x70>;
 		#address-cells = <1>;
-		#size-cells = <0>;
 		i2c-mux-idle-disconnect;
+		#size-cells = <0>;
 
 		i2c13mux0ch0: i2c@0 {
 			reg = <0>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c13mux0ch1: i2c@1 {
 			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c13mux0ch2: i2c@2 {
 			reg = <2>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c13mux0ch3: i2c@3 {
 			reg = <3>;
 			#address-cells = <1>;
@@ -801,6 +838,7 @@ adc@1f {
 				ti,mode = /bits/ 8 <1>;
 			};
 		};
+
 		i2c13mux0ch4: i2c@4 {
 			reg = <4>;
 			#address-cells = <1>;
@@ -812,16 +850,19 @@ eeprom@51 {
 				reg = <0x51>;
 			};
 		};
+
 		i2c13mux0ch5: i2c@5 {
 			reg = <5>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c13mux0ch6: i2c@6 {
 			reg = <6>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c13mux0ch7: i2c@7 {
 			reg = <7>;
 			#address-cells = <1>;
@@ -831,10 +872,10 @@ nfc@28 {
 				compatible = "nxp,nxp-nci-i2c";
 				reg = <0x28>;
 
+				enable-gpios = <&sgpiom0 241 GPIO_ACTIVE_HIGH>;
 				interrupt-parent = <&sgpiom0>;
-				interrupts = <156 IRQ_TYPE_LEVEL_HIGH>;
 
-				enable-gpios = <&sgpiom0 241 GPIO_ACTIVE_HIGH>;
+				interrupts = <156 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
 	};
@@ -851,11 +892,13 @@ &i2c15 {
 
 &kcs2 {
 	aspeed,lpc-io-reg = <0xca8>;
+
 	status = "okay";
 };
 
 &kcs3 {
 	aspeed,lpc-io-reg = <0xca2>;
+
 	status = "okay";
 };
 
@@ -864,14 +907,14 @@ &lpc_ctrl {
 };
 
 &mac2 {
-	status = "okay";
-	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ncsi3_default>;
+	pinctrl-names = "default";
 	use-ncsi;
+
+	status = "okay";
 };
 
 &sgpiom0 {
-	ngpios = <128>;
 	bus-frequency = <2000000>;
 	gpio-line-names =
 	/*in - out - in - out */
@@ -1011,22 +1054,28 @@ &sgpiom0 {
 	"FM_PWRGD_CPU0_PWROK", "",
 	"wS5_PWR_Ready", "",
 	"wS0_ON_N", "PWRGD_P1V0_AUX";
+
+	ngpios = <128>;
+
 	status = "okay";
 };
 
 // BIOS Flash
 &spi2 {
-	pinctrl-names = "default";
+	reg = <0x1e631000 0xc4>, <0x50000000 0x8000000>;
 	pinctrl-0 = <&pinctrl_spi2_default>;
+
+	pinctrl-names = "default";
+
 	status = "okay";
-	reg = <0x1e631000 0xc4>, <0x50000000 0x8000000>;
 
 	flash@0 {
 		compatible = "jedec,spi-nor";
 		label = "pnor";
 		spi-max-frequency = <12000000>;
-		spi-tx-bus-width = <2>;
 		spi-rx-bus-width = <2>;
+		spi-tx-bus-width = <2>;
+
 		status = "okay";
 	};
 };
@@ -1058,22 +1107,25 @@ &uhci {
 };
 
 &vhub {
-	status = "okay";
 	pinctrl-names = "default";
+
+	status = "okay";
 };
 
 &video {
-	status = "okay";
 	memory-region = <&video_engine_memory>;
+
+	status = "okay";
 };
 
 &wdt1 {
-	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_wdtrst1_default>;
-	aspeed,reset-type = "soc";
-	aspeed,external-signal;
-	aspeed,ext-push-pull;
+	pinctrl-names = "default";
 	aspeed,ext-active-high;
 	aspeed,ext-pulse-duration = <256>;
+	aspeed,ext-push-pull;
+	aspeed,external-signal;
+	aspeed,reset-type = "soc";
+
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts
index cb4b815f1803..482ba3f161ed 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts
@@ -4,8 +4,8 @@
 #include "aspeed-bmc-facebook-anacapa-evt1.dts"
 
 / {
-	model = "Facebook Anacapa BMC";
 	compatible = "facebook,anacapa-bmc-evt2", "aspeed,ast2600";
+	model = "Facebook Anacapa BMC";
 };
 
 &{/aliases} {
@@ -31,6 +31,7 @@ &fmc {
 	flash@0 {
 		vcc-supply = <&p3v3_bmc_aux>;
 	};
+
 	flash@1 {
 		vcc-supply = <&p3v3_bmc_aux>;
 	};
@@ -46,79 +47,87 @@ flash@0 {
 // MB - PDB
 &i2c8 {
 	i2c-mux@72 {
-		i2c8mux0ch0: i2c@0 {
+		i2c@0 {
+			gpio@24 {
+				gpio-line-names =
+					"RPDB_EAM2_PRSNT_MOS_N_R", "RPDB_EAM3_PRSNT_MOS_N_R",
+					"RPDB_PWRGD_P50V_HSC4_SYS_R",
+					"RPDB_PWRGD_P50V_STBY_SYS_BUF_R",
+					"RPDB_P50V_FAN5_R2_PG", "RPDB_P50V_FAN6_R2_PG",
+					"RPDB_P50V_FAN7_R2_PG", "RPDB_P50V_FAN8_R2_PG",
+					"", "RPDB_FAN5_PRSNT_N_R",
+					"", "RPDB_FAN6_PRSNT_N_R",
+					"RPDB_FAN7_PRSNT_N_R", "RPDB_FAN8_PRSNT_N_R",
+					"", "";
+			};
+
 			power-monitor@42 {
 				compatible = "lltc,ltc4287";
 				reg = <0x42>;
 				shunt-resistor-micro-ohms = <150>;
 			};
+
 			power-monitor@43 {
 				compatible = "lltc,ltc4287";
 				reg = <0x43>;
 				shunt-resistor-micro-ohms = <150>;
 			};
+
 			power-monitor@44 {
 				compatible = "lltc,ltc4287";
 				reg = <0x44>;
 				shunt-resistor-micro-ohms = <250>;
 			};
+
 			power-monitor@45 {
 				compatible = "lltc,ltc4287";
 				reg = <0x45>;
 				shunt-resistor-micro-ohms = <250>;
 			};
+		};
+
+		i2c@1 {
 			gpio@24 {
 				gpio-line-names =
-					"RPDB_EAM2_PRSNT_MOS_N_R", "RPDB_EAM3_PRSNT_MOS_N_R",
-					"RPDB_PWRGD_P50V_HSC4_SYS_R",
-					"RPDB_PWRGD_P50V_STBY_SYS_BUF_R",
-					"RPDB_P50V_FAN5_R2_PG", "RPDB_P50V_FAN6_R2_PG",
-					"RPDB_P50V_FAN7_R2_PG", "RPDB_P50V_FAN8_R2_PG",
-					"", "RPDB_FAN5_PRSNT_N_R",
-					"", "RPDB_FAN6_PRSNT_N_R",
-					"RPDB_FAN7_PRSNT_N_R", "RPDB_FAN8_PRSNT_N_R",
-					"", "";
+					"LPDB_P50V_FAN0_R2_PG","LPDB_P50V_FAN1_R2_PG",
+					"LPDB_P50V_FAN2_R2_PG","LPDB_P50V_FAN3_R2_PG",
+					"LPDB_P50V_FAN4_R2_PG","LPDB_FAN0_PRSNT_N_R",
+					"LPDB_FAN1_PRSNT_N_R","LPDB_FAN2_PRSNT_N_R",
+					"LPDB_FAN3_PRSNT_N_R","LPDB_FAN4_PRSNT_N_R",
+					"","",
+					"","",
+					"","";
 			};
-		};
-		i2c8mux0ch1: i2c@1 {
+
 			power-monitor@40 {
 				compatible = "lltc,ltc4287";
 				reg = <0x40>;
 				shunt-resistor-micro-ohms = <150>;
 			};
+
 			power-monitor@41 {
 				compatible = "lltc,ltc4287";
 				reg = <0x41>;
 				shunt-resistor-micro-ohms = <150>;
 			};
+
 			power-monitor@45 {
 				compatible = "lltc,ltc4287";
 				reg = <0x45>;
 				shunt-resistor-micro-ohms = <250>;
 			};
-			gpio@24 {
-				gpio-line-names =
-					"LPDB_P50V_FAN0_R2_PG","LPDB_P50V_FAN1_R2_PG",
-					"LPDB_P50V_FAN2_R2_PG","LPDB_P50V_FAN3_R2_PG",
-					"LPDB_P50V_FAN4_R2_PG","LPDB_FAN0_PRSNT_N_R",
-					"LPDB_FAN1_PRSNT_N_R","LPDB_FAN2_PRSNT_N_R",
-					"LPDB_FAN3_PRSNT_N_R","LPDB_FAN4_PRSNT_N_R",
-					"","",
-					"","",
-					"","";
-			};
 		};
 	};
 };
 
 // SCM
 &i2c9 {
-
 	// SCM FRU
 	// | DC-SCM Rev        | Slave address of eeprom  |
 	// |-------------------|--------------------------|
 	// | Rev B             | 0x50                     |
 	// | Rev C/D/E/F/above | 0x51                     |
+
 	eeprom@51 {
 		compatible = "atmel,24c128";
 		reg = <0x51>;
@@ -128,6 +137,7 @@ eeprom@51 {
 // R Bridge Board
 &i2c10 {
 	multi-master;
+
 	mctp@10 {
 		compatible = "mctp-i2c-controller";
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
@@ -139,30 +149,37 @@ i2c-mux@71 {
 		i2c10mux0ch1: i2c@1 {
 			mctp-controller;
 			// BE NIC FRU
+
 			eeprom@50 {
 				compatible = "atmel,24c32";
 				reg = <0x50>;
 			};
 		};
+
 		i2c10mux0ch2: i2c@2 {
 			mctp-controller;
 			// BE NIC FRU
+
 			eeprom@50 {
 				compatible = "atmel,24c32";
 				reg = <0x50>;
 			};
 		};
+
 		i2c10mux0ch3: i2c@3 {
 			mctp-controller;
 			// BE NIC FRU
+
 			eeprom@50 {
 				compatible = "atmel,24c32";
 				reg = <0x50>;
 			};
 		};
+
 		i2c10mux0ch4: i2c@4 {
 			mctp-controller;
 			// BE NIC FRU
+
 			eeprom@50 {
 				compatible = "atmel,24c32";
 				reg = <0x50>;
@@ -174,6 +191,7 @@ eeprom@50 {
 // L Bridge Board
 &i2c11 {
 	multi-master;
+
 	mctp@10 {
 		compatible = "mctp-i2c-controller";
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
@@ -185,38 +203,47 @@ i2c-mux@71 {
 		i2c11mux0ch0: i2c@0 {
 			mctp-controller;
 			// FE NIC FRU
+
 			eeprom@50 {
 				compatible = "atmel,24c32";
 				reg = <0x50>;
 			};
 		};
+
 		i2c11mux0ch1: i2c@1 {
 			mctp-controller;
 			// BE NIC FRU
+
 			eeprom@50 {
 				compatible = "atmel,24c32";
 				reg = <0x50>;
 			};
 		};
+
 		i2c11mux0ch2: i2c@2 {
 			mctp-controller;
 			// BE NIC FRU
+
 			eeprom@50 {
 				compatible = "atmel,24c32";
 				reg = <0x50>;
 			};
 		};
+
 		i2c11mux0ch3: i2c@3 {
 			mctp-controller;
 			// BE NIC FRU
+
 			eeprom@50 {
 				compatible = "atmel,24c32";
 				reg = <0x50>;
 			};
 		};
+
 		i2c11mux0ch4: i2c@4 {
 			mctp-controller;
 			// BE NIC FRU
+
 			eeprom@50 {
 				compatible = "atmel,24c32";
 				reg = <0x50>;
@@ -228,7 +255,7 @@ eeprom@50 {
 // MB
 &i2c13 {
 	i2c-mux@70 {
-		i2c13mux0ch7: i2c@7 {
+		i2c@7 {
 			// NFC adaptor board FRU
 			eeprom@50 {
 				compatible = "atmel,24c128";
@@ -239,7 +266,6 @@ eeprom@50 {
 };
 
 &sgpiom0 {
-	ngpios = <128>;
 	bus-frequency = <2000000>;
 	gpio-line-names =
 	/*in - out */
@@ -403,6 +429,7 @@ &sgpiom0 {
 	"AMC_FAIL", "HPM_CPLD_RISCV_RST",
 	"S0_ON", "";
 
+	ngpios = <128>;
+
 	status = "okay";
 };
-
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
index c74b211c42e6..a9512ea771e3 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
@@ -1,4 +1,3 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 #include "aspeed-bmc-facebook-anacapa-dvt.dts"
-

-- 
2.34.1



