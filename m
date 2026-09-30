Return-Path: <linux-aspeed+bounces-5088-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F04CA5FC1
	for <linux-aspeed@archiver.kernel.org>; Wed, 30 Sep 2026 11:19:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvsxq1wCrz30C0;
	Wed, 30 Sep 2026 21:19:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790767151;
	cv=none; b=RBptro3gySaYl+4Ok4OBOPzG3NvPYo00sjl55NPDpmzs7YRBM2rlTR6W0JtqvhoUtw2/gH1h3lH2nuR2GmhCoClCFUmA9OPOY7TfSqKQZY8c16jWdm0GgTuMGC7EthwfVmpBYScvasm7gJEvGDCBt36+CAKBumlF/mTefOFkaNYuFUpzPPsb2ZJQbCG6rRM4q42fOkF4S4HP9x9p6ouK9yZydstoDv6mXK9r5hwnLNXYs+wph/xyUHHdd/+41BtQjyBkp1FBlDEdvowQrHmRvsR18m9JwiLPzbjPL0Fh1M8W7JxDUkKBjj//P3jmR4Z1/3AF3f1IvDszlJuqQyKD8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790767151; c=relaxed/relaxed;
	bh=+egFjTMnPYoDlT9Bcryc5S9/HI1Lw9q9oWEv1D5Tzbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ig2u/T+hHd33Xax1055grpEgmVNjSoT6Czakt81C8Q4sq687Dd6zeqk4Ae9X1i815lCKAMDgDdRsdus0Pi+R1dUodyuDEZ8MypClm7J3I3HgKeTd2GwRecrlzHCq/nn7c6AtK99PWf5pWo5oD3gSQGehUQp6cS+rLAMBT7wWswnj+hfq8TRp+CIDJETG3ZuyskpmO6riuaQTt8GK0KnvxvrQZm4GIgV0DHi2pgIesSpgSKSxjvW8JTidYdnocIG7V43N3qqngI5k6lrJU5x2LR8Gb8Q2kmQ096HBWsea53ujSH4ZTIg9M85a3JNkSpcKh0Lafr5Kh9S/scbS5zUN2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sMVaKnk5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sMVaKnk5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x10.google.com (mail-pz2-x10.google.com [IPv6:2607:f8b0:4864:3b::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvsxp23qqz2yjN
	for <linux-aspeed@lists.ozlabs.org>; Wed, 30 Sep 2026 21:19:10 +1000 (AEST)
Received: by mail-pz2-x10.google.com with SMTP id d2e1a72fcca58-86b90133ae8so2461884b3a.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 30 Sep 2026 04:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790767148; x=1791371948; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+egFjTMnPYoDlT9Bcryc5S9/HI1Lw9q9oWEv1D5Tzbs=;
        b=sMVaKnk5cYsl4ro8b2qBUsUw7ZiZwIcWwdv8WXlhYLyTFwQLsfLg8LNtJ0kYyHqFMt
         H5I5rQEfaMaB3ccWKH7e2CToD6f+np2BNbnTX588ad2RybQbeVEWIKXu2LauxaaeWqRn
         40PY/BzabH64CkR9oPfGu+si1NPxjli8TgeHAsmHN5chHrGO+ixAjYcDKCizC80hsqbJ
         N4LcEgCrbQhsyM8dJ4Ig/nM90k32IKaSjmkfpyU/opNkLKAPeLGPxvd/WV0av40tA8RO
         7BWix3J1gKLqG6CIo2zSCyQKM/2tSW6pbyEJWpA4o/5rvnoelpAMvqFr0PAHP6Xvvsxm
         fQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790767148; x=1791371948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+egFjTMnPYoDlT9Bcryc5S9/HI1Lw9q9oWEv1D5Tzbs=;
        b=O9tUR5e75ocN0tarYAS0S8DfFdMFj7XWFtiuWufbN3B6RBhLTE7JvJM16tTDD1oW+g
         PzjxTDuVdC7rU/HketxSU48HxhphIdWMXn+4zZA41Ved7YYl4Oc7tQWaTuIjhLOeVS5h
         ak1sf7IX2dzJe73c9ZnJ0W1i3zhZQd11HnsHlJZPYXO0i83+jVd0dDTUEP6kWSWmOhR8
         ZHjKhUP6v+8H2VqPZzC4FQaOzQsDqzZPWvbcmwkdvRh7epwFoRxWYZnQuz68/Plwsz25
         AtJziR3q9aC4qbKl0kXSVMJfqqAKVu0ut76xyGLrx6gqaQBCnUblX38MIfWKI0wYjL+w
         gsnQ==
X-Forwarded-Encrypted: i=1; AKwUvBy2UbqNlDGgUCZZS2pUJycbKlVmv3H4aPV1ZsPbKUqM514cRKaY0W5vyVHCxZKdgDQN4dxLRhHM9SfNyDM=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYICo6HsiUo5Dp6bQwIT5pRZ1ggVAoseiQnB0PwV36FaNAfXIRKy
	/Tv0IyMEEsFw6iQVWHsryB2A2VhUxR8DXKSIrZOJIev8+/WlMRrZJjX9
X-Gm-Gg: AYBFou2u6D9i+oWkCoMCkqDD6P726ulFSJPozojBwikVq1DqrgNKeaKloPBB57lAsxB
	KgKxNKW2Ly3Wu3wBY+VzZFTxeWCoku6oWyD9hWS7is74HHHHPGkA41NbWaUBizIzJm/BJipHjoI
	2NX5ggBOmjTMaQCNjhgmoKEVWfc6iSIpGFKGZSle1gI7uy5NWhLCwxoz4TqtEeV2MJfvEFpMlqu
	6p6NwkonT+ARpiAGT/gfxOtZrx5z2dICp7N7dSkWK8PS9cqr5Mtbkynd6Xvq9Fv7kRIntOlTmyd
	0/q+Izm4Zw98rYR7JEjWm4AzEYzijZmfWoArbThnkhKUvb248KsfU+l/4BMcumzWKZ13IKKZHTQ
	aiiiPVviMTAgA/vwAJlFf15jKLt3TgSLUivmCGiaFACXt5J/PC6I4709aPdIrvhf6ZuEBLYCq3p
	jAqt1zLwTkzbyZgR3fHsHwSisnbEYtIiRvfsrkMA8PMVBs8ZUzmwtXod4QKDNrnl99riRbxx74B
	XlPb5LuOmGn1ZAwOZgds2HzZz5ts2V6BAqKyfXRekS4
X-Received: by 2002:a05:6a00:b81:b0:874:705d:f649 with SMTP id d2e1a72fcca58-8874bffa3dfmr702163b3a.43.1790767148462;
        Wed, 30 Sep 2026 04:19:08 -0700 (PDT)
Received: from cosmo-ubuntu-2404.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-887253992a9sm650257b3a.17.2026.09.30.04.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 04:19:07 -0700 (PDT)
From: Cosmo Chou <chou.cosmo@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	cosmo.chou@quantatw.com,
	Cosmo Chou <chou.cosmo@gmail.com>
Subject: [PATCH v3 3/4] ARM: dts: aspeed: bletchley: Add second source PCA9532 LED controllers
Date: Wed, 30 Sep 2026 19:18:12 +0800
Message-ID: <20260930111813.52396-4-chou.cosmo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930111813.52396-1-chou.cosmo@gmail.com>
References: <20260930111813.52396-1-chou.cosmo@gmail.com>
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

Add alternative PCA9532 LED controllers at address 0x66 to support boards
populated with the PCA9532 instead of the primary PCA9552 at 0x67.

Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
---
 .../aspeed/aspeed-bmc-facebook-bletchley.dts  | 422 ++++++++++++++++++
 1 file changed, 422 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
index 4bc436ef3562..1883bfb850fb 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
@@ -6,6 +6,7 @@
 #include <dt-bindings/gpio/aspeed-gpio.h>
 #include <dt-bindings/usb/pd.h>
 #include <dt-bindings/leds/leds-pca955x.h>
+#include <dt-bindings/leds/leds-pca9532.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/i2c/i2c.h>
 
@@ -86,6 +87,66 @@ led-7 {
 		};
 	};
 
+	fan_gpio_leds_alt {
+		compatible = "gpio-leds";
+
+		led-0 {
+			default-state = "on";
+			gpios = <&fan_leds_alt 8 GPIO_ACTIVE_HIGH>;
+			label = "fan0_blue";
+			retain-state-shutdown;
+		};
+
+		led-1 {
+			default-state = "on";
+			gpios = <&fan_leds_alt 9 GPIO_ACTIVE_HIGH>;
+			label = "fan1_blue";
+			retain-state-shutdown;
+		};
+
+		led-2 {
+			default-state = "on";
+			gpios = <&fan_leds_alt 10 GPIO_ACTIVE_HIGH>;
+			label = "fan2_blue";
+			retain-state-shutdown;
+		};
+
+		led-3 {
+			default-state = "on";
+			gpios = <&fan_leds_alt 11 GPIO_ACTIVE_HIGH>;
+			label = "fan3_blue";
+			retain-state-shutdown;
+		};
+
+		led-4 {
+			default-state = "off";
+			gpios = <&fan_leds_alt 12 GPIO_ACTIVE_HIGH>;
+			label = "fan0_amber";
+			retain-state-shutdown;
+		};
+
+		led-5 {
+			default-state = "off";
+			gpios = <&fan_leds_alt 13 GPIO_ACTIVE_HIGH>;
+			label = "fan1_amber";
+			retain-state-shutdown;
+		};
+
+		led-6 {
+			default-state = "off";
+			gpios = <&fan_leds_alt 14 GPIO_ACTIVE_HIGH>;
+			label = "fan2_amber";
+			retain-state-shutdown;
+		};
+
+		led-7 {
+			default-state = "off";
+			gpios = <&fan_leds_alt 15 GPIO_ACTIVE_HIGH>;
+			label = "fan3_amber";
+			retain-state-shutdown;
+		};
+	};
+
 	front_gpio_leds {
 		compatible = "gpio-leds";
 
@@ -162,6 +223,24 @@ led-1 {
 		};
 	};
 
+	sled1_gpio_leds_alt {
+		compatible = "gpio-leds";
+
+		led-0 {
+			default-state = "keep";
+			gpios = <&sled1_leds_alt 0 GPIO_ACTIVE_LOW>;
+			label = "sled1_amber";
+			retain-state-shutdown;
+		};
+
+		led-1 {
+			default-state = "keep";
+			gpios = <&sled1_leds_alt 1 GPIO_ACTIVE_LOW>;
+			label = "sled1_blue";
+			retain-state-shutdown;
+		};
+	};
+
 	sled2_gpio_leds {
 		compatible = "gpio-leds";
 
@@ -180,6 +259,24 @@ led-1 {
 		};
 	};
 
+	sled2_gpio_leds_alt {
+		compatible = "gpio-leds";
+
+		led-0 {
+			default-state = "keep";
+			gpios = <&sled2_leds_alt 0 GPIO_ACTIVE_LOW>;
+			label = "sled2_amber";
+			retain-state-shutdown;
+		};
+
+		led-1 {
+			default-state = "keep";
+			gpios = <&sled2_leds_alt 1 GPIO_ACTIVE_LOW>;
+			label = "sled2_blue";
+			retain-state-shutdown;
+		};
+	};
+
 	sled3_gpio_leds {
 		compatible = "gpio-leds";
 
@@ -198,6 +295,24 @@ led-1 {
 		};
 	};
 
+	sled3_gpio_leds_alt {
+		compatible = "gpio-leds";
+
+		led-0 {
+			default-state = "keep";
+			gpios = <&sled3_leds_alt 0 GPIO_ACTIVE_LOW>;
+			label = "sled3_amber";
+			retain-state-shutdown;
+		};
+
+		led-1 {
+			default-state = "keep";
+			gpios = <&sled3_leds_alt 1 GPIO_ACTIVE_LOW>;
+			label = "sled3_blue";
+			retain-state-shutdown;
+		};
+	};
+
 	sled4_gpio_leds {
 		compatible = "gpio-leds";
 
@@ -216,6 +331,24 @@ led-1 {
 		};
 	};
 
+	sled4_gpio_leds_alt {
+		compatible = "gpio-leds";
+
+		led-0 {
+			default-state = "keep";
+			gpios = <&sled4_leds_alt 0 GPIO_ACTIVE_LOW>;
+			label = "sled4_amber";
+			retain-state-shutdown;
+		};
+
+		led-1 {
+			default-state = "keep";
+			gpios = <&sled4_leds_alt 1 GPIO_ACTIVE_LOW>;
+			label = "sled4_blue";
+			retain-state-shutdown;
+		};
+	};
+
 	sled5_gpio_leds {
 		compatible = "gpio-leds";
 
@@ -234,6 +367,24 @@ led-1 {
 		};
 	};
 
+	sled5_gpio_leds_alt {
+		compatible = "gpio-leds";
+
+		led-0 {
+			default-state = "keep";
+			gpios = <&sled5_leds_alt 0 GPIO_ACTIVE_LOW>;
+			label = "sled5_amber";
+			retain-state-shutdown;
+		};
+
+		led-1 {
+			default-state = "keep";
+			gpios = <&sled5_leds_alt 1 GPIO_ACTIVE_LOW>;
+			label = "sled5_blue";
+			retain-state-shutdown;
+		};
+	};
+
 	sled6_gpio_leds {
 		compatible = "gpio-leds";
 
@@ -252,6 +403,24 @@ led-1 {
 		};
 	};
 
+	sled6_gpio_leds_alt {
+		compatible = "gpio-leds";
+
+		led-0 {
+			default-state = "keep";
+			gpios = <&sled6_leds_alt 0 GPIO_ACTIVE_LOW>;
+			label = "sled6_amber";
+			retain-state-shutdown;
+		};
+
+		led-1 {
+			default-state = "keep";
+			gpios = <&sled6_leds_alt 1 GPIO_ACTIVE_LOW>;
+			label = "sled6_blue";
+			retain-state-shutdown;
+		};
+	};
+
 	spi {
 		compatible = "spi-gpio";
 		#address-cells = <1>;
@@ -430,6 +599,35 @@ eeprom@54 {
 		reg = <0x54>;
 	};
 
+	sled1_leds_alt: pca9532@66 {
+		compatible = "nxp,pca9532";
+		reg = <0x66>;
+		#gpio-cells = <2>;
+		gpio-controller;
+
+		gpio-line-names =
+		"led-sled1-amber","led-sled1-blue","SLED1_RST_IOEXP","SLED1_MD_REF_PWM",
+		"","","","",
+		"","","","",
+		"","","","";
+
+		led-0 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-1 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-2 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-3 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+	};
+
 	sled1_leds: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
@@ -520,6 +718,35 @@ eeprom@54 {
 		reg = <0x54>;
 	};
 
+	sled2_leds_alt: pca9532@66 {
+		compatible = "nxp,pca9532";
+		reg = <0x66>;
+		#gpio-cells = <2>;
+		gpio-controller;
+
+		gpio-line-names =
+		"led-sled2-amber","led-sled2-blue","SLED2_RST_IOEXP","SLED2_MD_REF_PWM",
+		"","","","",
+		"","","","",
+		"","","","";
+
+		led-0 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-1 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-2 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-3 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+	};
+
 	sled2_leds: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
@@ -610,6 +837,35 @@ eeprom@54 {
 		reg = <0x54>;
 	};
 
+	sled3_leds_alt: pca9532@66 {
+		compatible = "nxp,pca9532";
+		reg = <0x66>;
+		#gpio-cells = <2>;
+		gpio-controller;
+
+		gpio-line-names =
+		"led-sled3-amber","led-sled3-blue","SLED3_RST_IOEXP","SLED3_MD_REF_PWM",
+		"","","","",
+		"","","","",
+		"","","","";
+
+		led-0 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-1 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-2 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-3 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+	};
+
 	sled3_leds: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
@@ -700,6 +956,35 @@ eeprom@54 {
 		reg = <0x54>;
 	};
 
+	sled4_leds_alt: pca9532@66 {
+		compatible = "nxp,pca9532";
+		reg = <0x66>;
+		#gpio-cells = <2>;
+		gpio-controller;
+
+		gpio-line-names =
+		"led-sled4-amber","led-sled4-blue","SLED4_RST_IOEXP","SLED4_MD_REF_PWM",
+		"","","","",
+		"","","","",
+		"","","","";
+
+		led-0 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-1 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-2 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-3 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+	};
+
 	sled4_leds: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
@@ -790,6 +1075,35 @@ eeprom@54 {
 		reg = <0x54>;
 	};
 
+	sled5_leds_alt: pca9532@66 {
+		compatible = "nxp,pca9532";
+		reg = <0x66>;
+		#gpio-cells = <2>;
+		gpio-controller;
+
+		gpio-line-names =
+		"led-sled5-amber","led-sled5-blue","SLED5_RST_IOEXP","SLED5_MD_REF_PWM",
+		"","","","",
+		"","","","",
+		"","","","";
+
+		led-0 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-1 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-2 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-3 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+	};
+
 	sled5_leds: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
@@ -880,6 +1194,35 @@ eeprom@54 {
 		reg = <0x54>;
 	};
 
+	sled6_leds_alt: pca9532@66 {
+		compatible = "nxp,pca9532";
+		reg = <0x66>;
+		#gpio-cells = <2>;
+		gpio-controller;
+
+		gpio-line-names =
+		"led-sled6-amber","led-sled6-blue","SLED6_RST_IOEXP","SLED6_MD_REF_PWM",
+		"","","","",
+		"","","","",
+		"","","","";
+
+		led-0 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-1 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-2 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-3 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+	};
+
 	sled6_leds: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
@@ -993,6 +1336,85 @@ tmp421@4d {
 		reg = <0x4d>;
 	};
 
+	fan_leds_alt: pca9532@66 {
+		compatible = "nxp,pca9532";
+		reg = <0x66>;
+		#gpio-cells = <2>;
+		gpio-controller;
+
+		gpio-line-names =
+		"presence-fan0","presence-fan1",
+		"presence-fan2","presence-fan3",
+		"power-fan0-good","power-fan1-good",
+		"power-fan2-good","power-fan3-good",
+		"","","","",
+		"","","","";
+
+		led-0 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-1 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-2 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-3 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-4 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-5 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-6 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-7 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-8 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-9 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-10 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-11 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-12 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-13 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-14 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+
+		led-15 {
+			type = <PCA9532_TYPE_GPIO>;
+		};
+	};
+
 	fan_leds: pca9552@67 {
 		compatible = "nxp,pca9552";
 		reg = <0x67>;
-- 
2.43.0


