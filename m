Return-Path: <linux-aspeed+bounces-1804-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FECC87FC5
	for <linux-aspeed@archiver.kernel.org>; Wed, 23 Jul 2025 23:30:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bnVk35FvCz3blv;
	Thu, 24 Jul 2025 09:30:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753313435;
	cv=none; b=EYd0c+2MP/sosqmdKXE0gCF1aVg732RCrvBS9WNwY1fFUTDUstiT0jvU+JXpTFcx7NoZS/OlRn7CmYdOeF4ChZLJ/vivOK+WfpOrajtqiXYrNqtc84QyCq00DPlghTyx7bXhqjGjNF2Dg0aee1ebzKd8hQ7BqrxuqsbRWXBKN1F9VEbaxJDafG6pUwoo3OM7qzKdYhJdMJIehM7YYpuKs5ybGQHVzGJr9cJKo5ktjEuh/w+gdnDn+39jsmz6od266LICHkJIhAsB8x0mx6lpqoZjAMRuRbCQe0XpsyrI8FZs0kk1WIfZAdbBZlvzbPl3HvP3AJSaiQIp/LaEvCxeQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753313435; c=relaxed/relaxed;
	bh=MpuI4weQQaay/ttiq5NTjlywcepu4aZ90xK0F7mRywY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NAuTCeSQJvbZDtNWhuHSfdjZuIZpXTnl0zbh8DsPOxMLn4Y3CCv0MwwpganMTAswwC0Fmpk/WjWkiUh50Ckvs3AE77gaSpvW8T51AS27F8YrieI7MosJ4tK9iS8GfYhQcZPSxGhatYE+dcgKkxeyoikp4JBiVuHqVW9VILtnLqqic9n3Z7pt97SEsRHHSBwFA5g+e7u4Pk8s6jyY7sAQE3fqScU3DdjzPja0g3ElQso+MGUx+8blFC7qUIsoxhh2y56Lprbwn3iojgt++Iq5hLsmM1wjMvEpbUhrVM2CHe+fBprLhVCyxOFS/j6vrOsdOhRMfQl4zPEQk+XnXuIJlA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=O7a0oJXE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=O7a0oJXE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bnVk30t54z2xWc
	for <linux-aspeed@lists.ozlabs.org>; Thu, 24 Jul 2025 09:30:35 +1000 (AEST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-234fcadde3eso4728775ad.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 23 Jul 2025 16:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753313433; x=1753918233; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpuI4weQQaay/ttiq5NTjlywcepu4aZ90xK0F7mRywY=;
        b=O7a0oJXECobaNVJ5u8CV5nzlb5vqHCJPR+H8O20LjOsPz8ZwIRb9fiE/ScAszobSMq
         GOnfRa/bq0iudOqWmmnye59MUKd2SMkg7IUaZbxD3afmhqNxrx1Igyca+2BxiTkh61ZB
         4j+xr2u0YlLpuJefGSaJ/VkCuRIpZgDplF7E02Zvuu/tyf33DczMZM54hzfBgnxnuV9+
         y4rNn8eHaiTjInT8ukLNtbKAIrYeGXRdPpuKKaXsyBm0XHX7tatMI9tYbYhSxHx9qhIr
         0hM6dA2otEtPABKsvfXN0tcFGB3My1Yz3U/ZkOUr3EKJjlPFCutMb+HkivXWEnoXrWge
         Q+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753313433; x=1753918233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MpuI4weQQaay/ttiq5NTjlywcepu4aZ90xK0F7mRywY=;
        b=I+wKjuEM2se6zzxa9yts7Hj+zdZjfB6iumSmqqAjHxioGB46Wt/GwFqjFtPvD544Zj
         RMRutTmJl8iUed4CjdNy6n82PGgUAb5xs3Jb0+a7kzQGoqwyBr1XPxqvufpc2sOyZITn
         r3EERXQcds13LRNv3JicVtE51ZlTcZNxOv+zPtjeBQSSr+AhM2UK5z0+HffVuss6V0Zx
         ML4bKKkrvhpgu/E3ftyLctaXpTHlq0COIh5HrpgCB7/yxjfMxZvXW44V5/ZI/W8VjTNk
         wquTlcoSoff3Mx2wEo2obqOzJbgGGVKmbD/VI3en4eZxppEq71mv5AwQIvd6sZ2qyukv
         //9g==
X-Forwarded-Encrypted: i=1; AJvYcCXvOjAOU0z/gv2am3OU+fCaBedUBEfC5RxDXAT3PmaeJHetbYH3sJ2z5nQqzgVZ1HWppS2O7o1+stIIUVU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzCSGkJ0aqWjtJSrM/wXoyb3f7jCC8+5GbZTEEZ4U6lRN5EmvsW
	vlUnezgYUW5NT2Q6OOKsSV5U6C+ydazCb/+3QdGhJKuDzcBAe/mJXV+M
X-Gm-Gg: ASbGnctpTxK+SrGtvp/HC6PJyHx3/hSfSh5Zpd/ZRuYuE+kIWqtxEhxadNWSyXHROMR
	NIhCBcJU/D5dS54Vp1dkE+jfQ1QD+ypTUeK1foSMy9iObj/L8UIIvd/AddKzEvi+JcOfgL4jGPT
	h6PMJn7Ds7miSZESZ7k4kzsMdevhfYLLn7c+/bZiDyxOC04J43hyGhefz4YoS281co8z9c+my39
	V7cWPBsxPA7eXZnL948KQp4c28HurmrICJdVDtGnSl7iypg+ebQ9j9dv+t+I8QFZ0jtf5xXqZKg
	UtL2syrzY7QE4AhVQfe+loIaM7SGgC9HO8yNOtktsdR9XXn4opRX9uswvIu+M5tGOSGWJPWjnlm
	gUqwNvfYAVJHV3sTnrIxRAIDkWWQDk9BtFcetqpUFnp6xAnHAhJiqnSIyRDae7h+yTesoPTXJyu
	8=
X-Google-Smtp-Source: AGHT+IHuSACp56R7JFjqqbbVOFl8naZeaEXMeCAJrwdR3oTcvhmsICZkUtW81MHhki1qJ/awwU9oug==
X-Received: by 2002:a17:903:198c:b0:234:d292:be83 with SMTP id d9443c01a7336-23f9812b3ddmr68861005ad.10.1753313433180;
        Wed, 23 Jul 2025 16:30:33 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48bc6fbsm1260765ad.120.2025.07.23.16.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 16:30:32 -0700 (PDT)
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
Subject: [PATCH v3 08/13] ARM: dts: aspeed: wedge400: Include wedge400-data64.dts
Date: Wed, 23 Jul 2025 16:30:04 -0700
Message-ID: <20250723233013.142337-9-rentao.bupt@gmail.com>
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

Include "wedge400-data64.dts" in wedge400 dts to avoid duplicated code.

Wedge400-data64 and Wedge400 are identical except the BMC flash layout.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
Changes in v3:
  - None (the patch is introduced in v3).

 .../aspeed/aspeed-bmc-facebook-wedge400.dts   | 366 +-----------------
 1 file changed, 2 insertions(+), 364 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
index 3e4d30f0884d..ef0cfc51cda4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
@@ -1,376 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0+
 // Copyright (c) 2019 Facebook Inc.
-/dts-v1/;
 
-#include <dt-bindings/gpio/aspeed-gpio.h>
-#include "ast2500-facebook-netbmc-common.dtsi"
+#include "aspeed-bmc-facebook-wedge400-data64.dts"
 
 / {
 	model = "Facebook Wedge 400 BMC";
 	compatible = "facebook,wedge400-bmc", "aspeed,ast2500";
-
-	aliases {
-		/*
-		 * PCA9548 (2-0070) provides 8 channels connecting to
-		 * SCM (System Controller Module).
-		 */
-		i2c16 = &imux16;
-		i2c17 = &imux17;
-		i2c18 = &imux18;
-		i2c19 = &imux19;
-		i2c20 = &imux20;
-		i2c21 = &imux21;
-		i2c22 = &imux22;
-		i2c23 = &imux23;
-
-		/*
-		 * PCA9548 (8-0070) provides 8 channels connecting to
-		 * SMB (Switch Main Board).
-		 */
-		i2c24 = &imux24;
-		i2c25 = &imux25;
-		i2c26 = &imux26;
-		i2c27 = &imux27;
-		i2c28 = &imux28;
-		i2c29 = &imux29;
-		i2c30 = &imux30;
-		i2c31 = &imux31;
-
-		/*
-		 * PCA9548 (11-0076) provides 8 channels connecting to
-		 * FCM (Fan Controller Module).
-		 */
-		i2c32 = &imux32;
-		i2c33 = &imux33;
-		i2c34 = &imux34;
-		i2c35 = &imux35;
-		i2c36 = &imux36;
-		i2c37 = &imux37;
-		i2c38 = &imux38;
-		i2c39 = &imux39;
-
-		spi2 = &spi_gpio;
-	};
-
-	chosen {
-		stdout-path = &uart1;
-		bootargs = "console=ttyS0,9600n8 root=/dev/ram rw";
-	};
-
-	ast-adc-hwmon {
-		compatible = "iio-hwmon";
-		io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>, <&adc 4>,
-			      <&adc 5>, <&adc 6>, <&adc 7>, <&adc 8>;
-	};
-
-	/*
-	 * GPIO-based SPI Master is required to access SPI TPM, because
-	 * full-duplex SPI transactions are not supported by ASPEED SPI
-	 * Controllers.
-	 */
-	spi_gpio: spi {
-		status = "okay";
-		compatible = "spi-gpio";
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cs-gpios = <&gpio ASPEED_GPIO(R, 2) GPIO_ACTIVE_LOW>;
-		sck-gpios = <&gpio ASPEED_GPIO(R, 3) GPIO_ACTIVE_HIGH>;
-		mosi-gpios = <&gpio ASPEED_GPIO(R, 4) GPIO_ACTIVE_HIGH>;
-		miso-gpios = <&gpio ASPEED_GPIO(R, 5) GPIO_ACTIVE_HIGH>;
-		num-chipselects = <1>;
-
-		tpm@0 {
-			compatible = "infineon,slb9670", "tcg,tpm_tis-spi";
-			spi-max-frequency = <33000000>;
-			reg = <0>;
-		};
-	};
 };
 
-/*
- * Both firmware flashes are 128MB on Wedge400 BMC.
- */
 &fmc_flash0 {
+	/delete-node/partitions;
 #include "facebook-bmc-flash-layout-128.dtsi"
 };
-
-&fmc_flash1 {
-	partitions {
-		compatible = "fixed-partitions";
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		flash1@0 {
-			reg = <0x0 0x8000000>;
-			label = "flash1";
-		};
-	};
-};
-
-&uart2 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_txd2_default
-		     &pinctrl_rxd2_default>;
-};
-
-&uart4 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_txd4_default
-		     &pinctrl_rxd4_default>;
-};
-
-/*
- * I2C bus #0 is multi-master environment dedicated for BMC and Bridge IC
- * communication.
- */
-&i2c0 {
-	status = "okay";
-	multi-master;
-	bus-frequency = <1000000>;
-};
-
-&i2c1 {
-	status = "okay";
-};
-
-&i2c2 {
-	status = "okay";
-
-	i2c-mux@70 {
-		compatible = "nxp,pca9548";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x70>;
-		i2c-mux-idle-disconnect;
-
-		imux16: i2c@0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0>;
-		};
-
-		imux17: i2c@1 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <1>;
-		};
-
-		imux18: i2c@2 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <2>;
-		};
-
-		imux19: i2c@3 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <3>;
-		};
-
-		imux20: i2c@4 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <4>;
-		};
-
-		imux21: i2c@5 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <5>;
-		};
-
-		imux22: i2c@6 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <6>;
-		};
-
-		imux23: i2c@7 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <7>;
-		};
-	};
-};
-
-&i2c3 {
-	status = "okay";
-};
-
-&i2c4 {
-	status = "okay";
-};
-
-&i2c5 {
-	status = "okay";
-};
-
-&i2c6 {
-	status = "okay";
-};
-
-&i2c7 {
-	status = "okay";
-};
-
-&i2c8 {
-	status = "okay";
-
-	i2c-mux@70 {
-		compatible = "nxp,pca9548";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x70>;
-		i2c-mux-idle-disconnect;
-
-		imux24: i2c@0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0>;
-		};
-
-		imux25: i2c@1 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <1>;
-		};
-
-		imux26: i2c@2 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <2>;
-		};
-
-		imux27: i2c@3 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <3>;
-		};
-
-		imux28: i2c@4 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <4>;
-		};
-
-		imux29: i2c@5 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <5>;
-		};
-
-		imux30: i2c@6 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <6>;
-		};
-
-		imux31: i2c@7 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <7>;
-		};
-
-	};
-};
-
-&i2c9 {
-	status = "okay";
-};
-
-&i2c10 {
-	status = "okay";
-};
-
-&i2c11 {
-	status = "okay";
-
-	i2c-mux@76 {
-		compatible = "nxp,pca9548";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x76>;
-		i2c-mux-idle-disconnect;
-
-		imux32: i2c@0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0>;
-		};
-
-		imux33: i2c@1 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <1>;
-		};
-
-		imux34: i2c@2 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <2>;
-		};
-
-		imux35: i2c@3 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <3>;
-		};
-
-		imux36: i2c@4 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <4>;
-		};
-
-		imux37: i2c@5 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <5>;
-		};
-
-		imux38: i2c@6 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <6>;
-		};
-
-		imux39: i2c@7 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <7>;
-		};
-
-	};
-};
-
-&i2c12 {
-	status = "okay";
-};
-
-&i2c13 {
-	status = "okay";
-};
-
-&adc {
-	status = "okay";
-};
-
-&ehci1 {
-	status = "okay";
-};
-
-&uhci {
-	status = "okay";
-};
-
-&sdhci1 {
-	max-frequency = <25000000>;
-	/*
-	 * DMA mode needs to be disabled to avoid conflicts with UHCI
-	 * Controller in AST2500 SoC.
-	 */
-	sdhci-caps-mask = <0x0 0x580000>;
-};
-- 
2.47.3


