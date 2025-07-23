Return-Path: <linux-aspeed+bounces-1803-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AE7C83F17
	for <linux-aspeed@archiver.kernel.org>; Wed, 23 Jul 2025 23:30:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bnVk20bbCz3blc;
	Thu, 24 Jul 2025 09:30:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753313434;
	cv=none; b=Dj/M3oqPvcH4MlqhjZT+m/RGYVCimNK1ugoN8L9dYxM+DAQXK2xDLT40Jjm8MG7oW0/WGumxKbxvLC/O7UKQBmIp3zoyUophAaB+tUcAc51uLDrfJvapSUET4aXaZgw+7dFdEudrW2FiYLNsHU5MLeOsZ6tzJjUtb7fOfVperZRYMsgUgTmP2mUXFh2Hf4Nt3Rz4+K7QwWG463BDxibhMBuTkbI0IwnoEDMGQ8FPw7AERTsiVTV246EUrt5ApVmU/KbE0hc7nW4NGsNRbYelyzf3uMaXpYFoRzUF9+VQ4JqbsDBs0xqntshTo1BXLeyEsAjQ15IwrDT7MRkTYDafTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753313434; c=relaxed/relaxed;
	bh=m3mfssyA9l0C4/iGFnvM8hKQQolb/yTcaAf4qrrXcGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GABWjregViMTQaFTHsH9wYGhKaIxMCWIrO56e0aP8/X4zH15liaDS5yrpfeFrH41hen982vO3E0Mf2MuJhu+8hqWxi3njccfDncIpfLsV8y/WbiYONvlZy2KUiU0PET0DZlNwk+CIU9DGLUn1LnOnf96ZvDrAQxjWcUOdrMKBHDUvm9jaknGqeN5tPBRMSrFHH7y26Z0aLCUaSZSC3e8S7NfzxsHbIXIVU3SxNVsUZil4gu8RRzziZxNJWtJhtz9IPCuuRGCCjJdfG+x4htR84pP4PWsY/NYmEJi7aj9YkSp1RlYaQqcTJn7Rs3HDSPPVUURK0EIFjH00cAqgXIbGw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ZF3o7jj7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ZF3o7jj7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bnVk13fd2z2xWc
	for <linux-aspeed@lists.ozlabs.org>; Thu, 24 Jul 2025 09:30:33 +1000 (AEST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-235f9e87f78so3705625ad.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 23 Jul 2025 16:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753313432; x=1753918232; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3mfssyA9l0C4/iGFnvM8hKQQolb/yTcaAf4qrrXcGs=;
        b=ZF3o7jj7rQrvhAtNiEM+b4GM/jWUTNm39/XoyvqK9RhZOW/0WodhdBQuKl38LsAm4I
         vkvwpoc3OJl5bb91qoeUjUT/pAXMfzHkgIbkG6D6vnUncPfHI+ee/ONPNCtJ55AkDOng
         t4OhA8gAw0Yb3w3grfGj1zOcElJuhxePU5NavM6qkfTYqE/dluUulaFj7UjyJkDUuKvn
         3QjbDBSEeH74UUnulVesbZhX0n19nDPBG7mlMGs6VXFGKs/uYqGlLtmj+7Wf4WNgT4F2
         Sd+vxTTbT40bPIipX3CVSeAcMNYGEK+poaPxhTL02dlCNB8h0qO/chvbmBX4yeRpfMRQ
         fNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753313432; x=1753918232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3mfssyA9l0C4/iGFnvM8hKQQolb/yTcaAf4qrrXcGs=;
        b=SJx/Nra2bSLnH3F9863WuqZqIibfiVJ71Ht4cYASWsZOXgX2mwCIsPpM4cOjpQrtIK
         50iWY6pYYLmWfcmwpDHbFX1oJ9JHrdQQO9QbQUEiKr3OIf5sDvbf32I4TvEVp74/WV9q
         RidPOhNQsZ3FeLMSbwwG1uNCh/vBoC4pvveJNepPKxQsMwn0L4Xb8+Garscg6GSOtxEU
         Kv0Y1k+uOOzr0CMtwc843PIT7wo+b5MOMYzI1LP240MskQMtxBFYuz0CS0JXtkI73MWa
         QIiCUchLJeowgO02MnXKXSnsd3IL4740B+lZbFioMRVAOkqaDM6q365YG5dx3AAGZq2C
         QMMg==
X-Forwarded-Encrypted: i=1; AJvYcCULi1DWm88xF7oPwjqpYc4a2u6nyq4VU1cgNZFkt4wE++M3v1ugM6aJs7Qze0d9HMGMk+VcIBKwaNpZYIA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzyG1YKOkGG5uvMLkhOR0yh7rBoAO8angRr+gU50MmwalVfDSV3
	Sa3wSNqiVJHn8CyOAwWP9HyMxHcjIeeQ5tKb9AxZr6EYKi/e8biT153F
X-Gm-Gg: ASbGncvwRNNh9P+HBH1+JYyXGaQrUaglFPcqz/kVaXeEskhOP0B39dVOl/4LeDeP4RR
	o610ZEGMqttw1cyAif32FzufFL/GhjGL47qmrWJHTx/9uyw63LNE1Sn4wBz9ElPxTl54ViWanc9
	wd9RdYWGz1NrU7qTc3EADWw646XRyxv5bvZeVSZ1O/FDZymSicvPVcpDir3MfrYPuQC0caNNIWk
	5805vkciVGCUOMjxDRaprBSuw7URJY3FkQ5Tx5TpCwCKcrjHKPXUoRmqoTjZELhaangvQKgm//s
	3V6X/YP5u9CEyPHa+0P657FfppET81sulA95Rvvvi/6dohUMV3E0k8kazl6P1WqNNcuEZhK6qpl
	xaNo5oZ36bkex1U5CfF0cV5MsPzX19vhRm8SF4FHr0fLoTNU+pJXJ4jRr1efT2wP4jkO6Ii4+B5
	zeFFqokRWebA==
X-Google-Smtp-Source: AGHT+IHgerWZl8WSYgEJrwJiKDedU1YTvFRBOUJRpz2obxy5mcxUEZF/C7p4IfnRVrHL4uiPcxOl1A==
X-Received: by 2002:a17:902:ce86:b0:23e:ea0:63c0 with SMTP id d9443c01a7336-23f981b6570mr65270225ad.41.1753313431554;
        Wed, 23 Jul 2025 16:30:31 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48bc6fbsm1260765ad.120.2025.07.23.16.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 16:30:31 -0700 (PDT)
From: rentao.bupt@gmail.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Tao Ren <taoren@meta.com>
Cc: Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v3 07/13] ARM: dts: aspeed: Add Facebook Wedge400-data64 (AST2500) BMC
Date: Wed, 23 Jul 2025 16:30:03 -0700
Message-ID: <20250723233013.142337-8-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250723233013.142337-1-rentao.bupt@gmail.com>
References: <20250723233013.142337-1-rentao.bupt@gmail.com>
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

From: Tao Ren <rentao.bupt@gmail.com>

Add wedge400-data64.dts to extend wedge400's data0 partition from 8MB to
64MB smoothly.

wedge400-data64.dts is copied from wedge400.dts with below changes:
  - updating model/compatible strings.
  - updating BMC flash layout.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
Changes in v3:
  - None (the patch is introduced in v3).

 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../aspeed-bmc-facebook-wedge400-data64.dts   | 376 ++++++++++++++++++
 2 files changed, 377 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400-data64.dts

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index 2e5f4833a073..55be25acfc80 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -30,6 +30,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-facebook-tiogapass.dtb \
 	aspeed-bmc-facebook-wedge40.dtb \
 	aspeed-bmc-facebook-wedge100.dtb \
+	aspeed-bmc-facebook-wedge400-data64.dtb \
 	aspeed-bmc-facebook-wedge400.dtb \
 	aspeed-bmc-facebook-yamp.dtb \
 	aspeed-bmc-facebook-yosemitev2.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400-data64.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400-data64.dts
new file mode 100644
index 000000000000..5b23842f26a3
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400-data64.dts
@@ -0,0 +1,376 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2019 Facebook Inc.
+/dts-v1/;
+
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include "ast2500-facebook-netbmc-common.dtsi"
+
+/ {
+	model = "Facebook Wedge 400 BMC (64MB Datastore)";
+	compatible = "facebook,wedge400-data64-bmc", "aspeed,ast2500";
+
+	aliases {
+		/*
+		 * PCA9548 (2-0070) provides 8 channels connecting to
+		 * SCM (System Controller Module).
+		 */
+		i2c16 = &imux16;
+		i2c17 = &imux17;
+		i2c18 = &imux18;
+		i2c19 = &imux19;
+		i2c20 = &imux20;
+		i2c21 = &imux21;
+		i2c22 = &imux22;
+		i2c23 = &imux23;
+
+		/*
+		 * PCA9548 (8-0070) provides 8 channels connecting to
+		 * SMB (Switch Main Board).
+		 */
+		i2c24 = &imux24;
+		i2c25 = &imux25;
+		i2c26 = &imux26;
+		i2c27 = &imux27;
+		i2c28 = &imux28;
+		i2c29 = &imux29;
+		i2c30 = &imux30;
+		i2c31 = &imux31;
+
+		/*
+		 * PCA9548 (11-0076) provides 8 channels connecting to
+		 * FCM (Fan Controller Module).
+		 */
+		i2c32 = &imux32;
+		i2c33 = &imux33;
+		i2c34 = &imux34;
+		i2c35 = &imux35;
+		i2c36 = &imux36;
+		i2c37 = &imux37;
+		i2c38 = &imux38;
+		i2c39 = &imux39;
+
+		spi2 = &spi_gpio;
+	};
+
+	chosen {
+		stdout-path = &uart1;
+		bootargs = "console=ttyS0,9600n8 root=/dev/ram rw";
+	};
+
+	ast-adc-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>, <&adc 4>,
+			      <&adc 5>, <&adc 6>, <&adc 7>, <&adc 8>;
+	};
+
+	/*
+	 * GPIO-based SPI Master is required to access SPI TPM, because
+	 * full-duplex SPI transactions are not supported by ASPEED SPI
+	 * Controllers.
+	 */
+	spi_gpio: spi {
+		status = "okay";
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cs-gpios = <&gpio ASPEED_GPIO(R, 2) GPIO_ACTIVE_LOW>;
+		sck-gpios = <&gpio ASPEED_GPIO(R, 3) GPIO_ACTIVE_HIGH>;
+		mosi-gpios = <&gpio ASPEED_GPIO(R, 4) GPIO_ACTIVE_HIGH>;
+		miso-gpios = <&gpio ASPEED_GPIO(R, 5) GPIO_ACTIVE_HIGH>;
+		num-chipselects = <1>;
+
+		tpm@0 {
+			compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
+			spi-max-frequency = <33000000>;
+			reg = <0>;
+		};
+	};
+};
+
+/*
+ * Both firmware flashes are 128MB on Wedge400 BMC.
+ */
+&fmc_flash0 {
+#include "facebook-bmc-flash-layout-128-data64.dtsi"
+};
+
+&fmc_flash1 {
+	partitions {
+		compatible = "fixed-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		flash1@0 {
+			reg = <0x0 0x8000000>;
+			label = "flash1";
+		};
+	};
+};
+
+&uart2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd2_default
+		     &pinctrl_rxd2_default>;
+};
+
+&uart4 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_txd4_default
+		     &pinctrl_rxd4_default>;
+};
+
+/*
+ * I2C bus #0 is multi-master environment dedicated for BMC and Bridge IC
+ * communication.
+ */
+&i2c0 {
+	status = "okay";
+	multi-master;
+	bus-frequency = <1000000>;
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x70>;
+		i2c-mux-idle-disconnect;
+
+		imux16: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		imux17: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		imux18: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		imux19: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+
+		imux20: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+
+		imux21: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		imux22: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		imux23: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
+	};
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&i2c4 {
+	status = "okay";
+};
+
+&i2c5 {
+	status = "okay";
+};
+
+&i2c6 {
+	status = "okay";
+};
+
+&i2c7 {
+	status = "okay";
+};
+
+&i2c8 {
+	status = "okay";
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x70>;
+		i2c-mux-idle-disconnect;
+
+		imux24: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		imux25: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		imux26: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		imux27: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+
+		imux28: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+
+		imux29: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		imux30: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		imux31: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
+
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
+
+	i2c-mux@76 {
+		compatible = "nxp,pca9548";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x76>;
+		i2c-mux-idle-disconnect;
+
+		imux32: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+
+		imux33: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		imux34: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		imux35: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+
+		imux36: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+
+		imux37: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+
+		imux38: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+		};
+
+		imux39: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+		};
+
+	};
+};
+
+&i2c12 {
+	status = "okay";
+};
+
+&i2c13 {
+	status = "okay";
+};
+
+&adc {
+	status = "okay";
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
+&sdhci1 {
+	max-frequency = <25000000>;
+	/*
+	 * DMA mode needs to be disabled to avoid conflicts with UHCI
+	 * Controller in AST2500 SoC.
+	 */
+	sdhci-caps-mask = <0x0 0x580000>;
+};
-- 
2.47.3


