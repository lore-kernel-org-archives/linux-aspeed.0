Return-Path: <linux-aspeed+bounces-4472-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54119C44501
	for <linux-aspeed@archiver.kernel.org>; Tue, 14 Jul 2026 12:08:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzykk4l00z2yRl;
	Tue, 14 Jul 2026 22:08:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1032"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784030910;
	cv=none; b=lJ8qxGCrLkXS1pUNPwn0yvSfSVBpoX772oJbJZm3w5Tn5kc0XoWxYLKXFNH5QngyJp89coa3jigFnRoOUBNIm0huQfnbLEyTgudbC1AKijS1CTJuTq6aeXzHVu9D8hpFbE2ndzUA4bkg2aKNawgIU5JVdiW2sXEYcm1vc9Wym1buqHdML12XfT7FbBokFh6/oJiJx6vCQwz9JuUjXelPaeQBtyYm79IxFbrF1rfw69V5/5QVP5xDruCRdgVrXBrU50JNML9wOr8+iW8l5XdNzQaJx0NOCeh4edStVSUJL82t5yCe1RXe50uVmvPjphUyf8nkzTuBNOA/BbJCBi79bg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784030910; c=relaxed/relaxed;
	bh=m+sHQh7xsIPCcx3DDu2sbd8ZKJKkQ8GLklEL0hevIC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KjOXDnzA3JN5o6LTqR+ELbp8OCSYZF9VIxy3FIHzXdSS/ga8p/z9vj/mI2qEYKRK9Ei1ruUZ5APbryi8mfEKLmiKyRPRAEN0wHD5QnHNboNHZTJdwOWrggspDVmN07xyUL/UiNmYzBLNR9EiRvusi8znM6HQHL38EWHVmxREdAc547P+FN978tF6OfwszgOtkeBoN2zrBCR8tGxCcTe9Bd2EtGhFkgThlBOdZUAs7um437DaErHfk5OrQZARgx9R7EE+gdNmDvh0HPSoV2VAjCbR6l1Mk9mOejYAhMS8awhqEKBkvDgHW+w44fteoCZbfKc9bLSj3zoadAVWgApjeQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=b3a1OMvZ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=b3a1OMvZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzykj6Bzmz2xqn
	for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Jul 2026 22:08:29 +1000 (AEST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-381ed661712so4725819a91.2
        for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Jul 2026 05:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784030908; x=1784635708; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m+sHQh7xsIPCcx3DDu2sbd8ZKJKkQ8GLklEL0hevIC8=;
        b=b3a1OMvZ4tZ+qO3Ae4ub22X5efiW0Kdi2Mro7UPOXgCNK8rFTYn8ELkUkrKbtRriAB
         AqYjxgBOEDP1P0YAiyQlOKLlgZ6JOaMOBkeKnSV3jXbv9FSMOFrpYAbU/+OR9is/6UFH
         4GI5sZhrz0IB8rzQAi1NE08DqHQlV5z6uZ2C+LkEwOqKembxommp1nz8msDQesb8tzzZ
         SfciEDhpIxb7dQq/TkSXv97JtdYYLsRNwmKko60fGfwHo/w/RhdrkxpfYONCDUYXpRO9
         +209ine1uFgNAfCZl5rezD/ERXnu32vatnaYLb+Sr8+/7/Sqn1ubO8/h+uJekSyJjW1a
         esMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784030908; x=1784635708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m+sHQh7xsIPCcx3DDu2sbd8ZKJKkQ8GLklEL0hevIC8=;
        b=likSv0diKMYkUEGOI5fPEvC1IHInVQPFECKMmHWML6AK48V/rT+jGcEsFHgfSUbxbn
         cQ4eZ4V24KELkc1vumx/JrUvKmuyuyA+AqbkRziagfCQo4z+R7LUpSg6HNfhxL+CzF8C
         v1GSHBeGqdAeCtZX8g9pUVq6TJkEAUlhxRREMPMbrhOrHt47B81V5dmgPE031EqbudcF
         UBr253S4ZahNUh78OoGoI+HtlO6TohAY/odY0AnVzv5BE8sHPqeYyNfjFxbXMYJGis2G
         1r9F6E7q/tCRVy/3iGnSC5GIKuNcL6uj5/8lFVMgkOqk9ae4esRDRWoIFGlcKCztPi3I
         Yv8g==
X-Forwarded-Encrypted: i=1; AHgh+Rpy59S7HIk+dmlCp11/eIDNWBOYBg00z0bGSKlEVIqnevUvFmS/NWhuVj0fiZNs1YPBudTyW78HR+SfrqQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw9Khs51TbCYWL4brr+gFchaPeogjUbj4MtW+VpK4Vw7xJ6pW+c
	iIaVJkEuCf4N0CZRiuoVxu9PbkF0h6xFp4nCEcaEr20nMfGutRiLZQyM
X-Gm-Gg: AfdE7cmLow9HxIXJvM0uvwXa4cDwY4/OM8VLSFaxzcPzWpRWqgvhXHLtBSffS07dZuM
	KjMoSAW7i0PFUF54xceaPp2mhFVqzm18Zx2SOpsFvoHLp+lYWdoW2XWL2adIFk7uEucNdIpRhva
	t5ePyp67Jkdx+mFyGpsNikfijXyIMxl+5nRUJpbAxj1SbkfW6BqRmY5pVZUUuuLVRQdrNRiQfX1
	WK0W5X/m6/LLrmdZ5YXl0ouQe8CPpJqfjkGdRRSWHbjuoZmPSkVZPMKXyU+NVb8oCfEU6dVrH78
	HxnDdXbo01ZWAXmdg5ZGjMRTP9SXgBZCwNU6ep9kwRitQbuacWWo1AwO5RtOfC0oVXjPawWJUzE
	5Yo9qw1zvF/mjguTdve/vyGclb3kzWVhNyf/pqu+6dNKPEFw9Up1Mc7K+vebVj+GNyfSI6eDsOE
	nAP8it5XPGer1x84kPclxRs5HQtko9RnurHsXo2xKcl0bA425CVT7UcyaNwrY=
X-Received: by 2002:a17:90b:180d:b0:37f:9ce1:736a with SMTP id 98e67ed59e1d1-38e1af3481amr2454300a91.32.1784030907614;
        Tue, 14 Jul 2026 05:08:27 -0700 (PDT)
Received: from cosmo-ubuntu-2404.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e172dc530sm1384425a91.8.2026.07.14.05.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 05:08:27 -0700 (PDT)
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
Subject: [PATCH 2/2] ARM: dts: aspeed: bletchley: Add second source PCA9532 LED controllers
Date: Tue, 14 Jul 2026 20:08:16 +0800
Message-ID: <20260714120816.1504058-3-chou.cosmo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714120816.1504058-1-chou.cosmo@gmail.com>
References: <20260714120816.1504058-1-chou.cosmo@gmail.com>
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
 .../aspeed/aspeed-bmc-facebook-bletchley.dts  | 289 ++++++++++++++++++
 1 file changed, 289 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
index a966be69f..86e2b5aec 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
@@ -6,6 +6,7 @@
 #include <dt-bindings/gpio/aspeed-gpio.h>
 #include <dt-bindings/usb/pd.h>
 #include <dt-bindings/leds/leds-pca955x.h>
+#include <dt-bindings/leds/leds-pca9532.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/i2c/i2c.h>
 
@@ -113,6 +114,58 @@ led-7 {
 		};
 	};
 
+	fan_gpio_leds_alt {
+		compatible = "gpio-leds";
+		led-0 {
+			label = "fan0_blue";
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&fan_leds_alt 8 GPIO_ACTIVE_HIGH>;
+		};
+		led-1 {
+			label = "fan1_blue";
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&fan_leds_alt 9 GPIO_ACTIVE_HIGH>;
+		};
+		led-2 {
+			label = "fan2_blue";
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&fan_leds_alt 10 GPIO_ACTIVE_HIGH>;
+		};
+		led-3 {
+			label = "fan3_blue";
+			retain-state-shutdown;
+			default-state = "on";
+			gpios = <&fan_leds_alt 11 GPIO_ACTIVE_HIGH>;
+		};
+		led-4 {
+			label = "fan0_amber";
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&fan_leds_alt 12 GPIO_ACTIVE_HIGH>;
+		};
+		led-5 {
+			label = "fan1_amber";
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&fan_leds_alt 13 GPIO_ACTIVE_HIGH>;
+		};
+		led-6 {
+			label = "fan2_amber";
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&fan_leds_alt 14 GPIO_ACTIVE_HIGH>;
+		};
+		led-7 {
+			label = "fan3_amber";
+			retain-state-shutdown;
+			default-state = "off";
+			gpios = <&fan_leds_alt 15 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
 	sled1_gpio_leds {
 		compatible = "gpio-leds";
 		led-0 {
@@ -129,6 +182,22 @@ led-1 {
 		};
 	};
 
+	sled1_gpio_leds_alt {
+		compatible = "gpio-leds";
+		led-0 {
+			label = "sled1_amber";
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&sled1_leds_alt 0 GPIO_ACTIVE_LOW>;
+		};
+		led-1 {
+			label = "sled1_blue";
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&sled1_leds_alt 1 GPIO_ACTIVE_LOW>;
+		};
+	};
+
 	sled2_gpio_leds {
 		compatible = "gpio-leds";
 		led-0 {
@@ -145,6 +214,22 @@ led-1 {
 		};
 	};
 
+	sled2_gpio_leds_alt {
+		compatible = "gpio-leds";
+		led-0 {
+			label = "sled2_amber";
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&sled2_leds_alt 0 GPIO_ACTIVE_LOW>;
+		};
+		led-1 {
+			label = "sled2_blue";
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&sled2_leds_alt 1 GPIO_ACTIVE_LOW>;
+		};
+	};
+
 	sled3_gpio_leds {
 		compatible = "gpio-leds";
 		led-0 {
@@ -161,6 +246,22 @@ led-1 {
 		};
 	};
 
+	sled3_gpio_leds_alt {
+		compatible = "gpio-leds";
+		led-0 {
+			label = "sled3_amber";
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&sled3_leds_alt 0 GPIO_ACTIVE_LOW>;
+		};
+		led-1 {
+			label = "sled3_blue";
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&sled3_leds_alt 1 GPIO_ACTIVE_LOW>;
+		};
+	};
+
 	sled4_gpio_leds {
 		compatible = "gpio-leds";
 		led-0 {
@@ -177,6 +278,22 @@ led-1 {
 		};
 	};
 
+	sled4_gpio_leds_alt {
+		compatible = "gpio-leds";
+		led-0 {
+			label = "sled4_amber";
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&sled4_leds_alt 0 GPIO_ACTIVE_LOW>;
+		};
+		led-1 {
+			label = "sled4_blue";
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&sled4_leds_alt 1 GPIO_ACTIVE_LOW>;
+		};
+	};
+
 	sled5_gpio_leds {
 		compatible = "gpio-leds";
 		led-0 {
@@ -193,6 +310,22 @@ led-1 {
 		};
 	};
 
+	sled5_gpio_leds_alt {
+		compatible = "gpio-leds";
+		led-0 {
+			label = "sled5_amber";
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&sled5_leds_alt 0 GPIO_ACTIVE_LOW>;
+		};
+		led-1 {
+			label = "sled5_blue";
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&sled5_leds_alt 1 GPIO_ACTIVE_LOW>;
+		};
+	};
+
 	sled6_gpio_leds {
 		compatible = "gpio-leds";
 		led-0 {
@@ -209,6 +342,22 @@ led-1 {
 		};
 	};
 
+	sled6_gpio_leds_alt {
+		compatible = "gpio-leds";
+		led-0 {
+			label = "sled6_amber";
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&sled6_leds_alt 0 GPIO_ACTIVE_LOW>;
+		};
+		led-1 {
+			label = "sled6_blue";
+			retain-state-shutdown;
+			default-state = "keep";
+			gpios = <&sled6_leds_alt 1 GPIO_ACTIVE_LOW>;
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 
@@ -401,6 +550,24 @@ sled1_leds: pca9552@67 {
 		"","","","";
 	};
 
+	sled1_leds_alt: pca9532@66 {
+		compatible = "nxp,pca9532";
+		reg = <0x66>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+		"led-sled1-amber","led-sled1-blue","SLED1_RST_IOEXP","SLED1_MD_REF_PWM",
+		"","","","",
+		"","","","",
+		"","","","";
+
+		led-0 { type = <PCA9532_TYPE_GPIO>; };
+		led-1 { type = <PCA9532_TYPE_GPIO>; };
+		led-2 { type = <PCA9532_TYPE_GPIO>; };
+		led-3 { type = <PCA9532_TYPE_GPIO>; };
+	};
+
 	sled1_fusb302: typec-portc@22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
@@ -487,6 +654,24 @@ sled2_leds: pca9552@67 {
 		"","","","";
 	};
 
+	sled2_leds_alt: pca9532@66 {
+		compatible = "nxp,pca9532";
+		reg = <0x66>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+		"led-sled2-amber","led-sled2-blue","SLED2_RST_IOEXP","SLED2_MD_REF_PWM",
+		"","","","",
+		"","","","",
+		"","","","";
+
+		led-0 { type = <PCA9532_TYPE_GPIO>; };
+		led-1 { type = <PCA9532_TYPE_GPIO>; };
+		led-2 { type = <PCA9532_TYPE_GPIO>; };
+		led-3 { type = <PCA9532_TYPE_GPIO>; };
+	};
+
 	sled2_fusb302: typec-portc@22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
@@ -573,6 +758,24 @@ sled3_leds: pca9552@67 {
 		"","","","";
 	};
 
+	sled3_leds_alt: pca9532@66 {
+		compatible = "nxp,pca9532";
+		reg = <0x66>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+		"led-sled3-amber","led-sled3-blue","SLED3_RST_IOEXP","SLED3_MD_REF_PWM",
+		"","","","",
+		"","","","",
+		"","","","";
+
+		led-0 { type = <PCA9532_TYPE_GPIO>; };
+		led-1 { type = <PCA9532_TYPE_GPIO>; };
+		led-2 { type = <PCA9532_TYPE_GPIO>; };
+		led-3 { type = <PCA9532_TYPE_GPIO>; };
+	};
+
 	sled3_fusb302: typec-portc@22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
@@ -659,6 +862,24 @@ sled4_leds: pca9552@67 {
 		"","","","";
 	};
 
+	sled4_leds_alt: pca9532@66 {
+		compatible = "nxp,pca9532";
+		reg = <0x66>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+		"led-sled4-amber","led-sled4-blue","SLED4_RST_IOEXP","SLED4_MD_REF_PWM",
+		"","","","",
+		"","","","",
+		"","","","";
+
+		led-0 { type = <PCA9532_TYPE_GPIO>; };
+		led-1 { type = <PCA9532_TYPE_GPIO>; };
+		led-2 { type = <PCA9532_TYPE_GPIO>; };
+		led-3 { type = <PCA9532_TYPE_GPIO>; };
+	};
+
 	sled4_fusb302: typec-portc@22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
@@ -745,6 +966,24 @@ sled5_leds: pca9552@67 {
 		"","","","";
 	};
 
+	sled5_leds_alt: pca9532@66 {
+		compatible = "nxp,pca9532";
+		reg = <0x66>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+		"led-sled5-amber","led-sled5-blue","SLED5_RST_IOEXP","SLED5_MD_REF_PWM",
+		"","","","",
+		"","","","",
+		"","","","";
+
+		led-0 { type = <PCA9532_TYPE_GPIO>; };
+		led-1 { type = <PCA9532_TYPE_GPIO>; };
+		led-2 { type = <PCA9532_TYPE_GPIO>; };
+		led-3 { type = <PCA9532_TYPE_GPIO>; };
+	};
+
 	sled5_fusb302: typec-portc@22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
@@ -831,6 +1070,24 @@ sled6_leds: pca9552@67 {
 		"","","","";
 	};
 
+	sled6_leds_alt: pca9532@66 {
+		compatible = "nxp,pca9532";
+		reg = <0x66>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+		"led-sled6-amber","led-sled6-blue","SLED6_RST_IOEXP","SLED6_MD_REF_PWM",
+		"","","","",
+		"","","","",
+		"","","","";
+
+		led-0 { type = <PCA9532_TYPE_GPIO>; };
+		led-1 { type = <PCA9532_TYPE_GPIO>; };
+		led-2 { type = <PCA9532_TYPE_GPIO>; };
+		led-3 { type = <PCA9532_TYPE_GPIO>; };
+	};
+
 	sled6_fusb302: typec-portc@22 {
 		compatible = "fcs,fusb302";
 		reg = <0x22>;
@@ -957,6 +1214,38 @@ fan_leds: pca9552@67 {
 		"","","","",
 		"","","","";
 	};
+
+	fan_leds_alt: pca9532@66 {
+		compatible = "nxp,pca9532";
+		reg = <0x66>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		gpio-line-names =
+		"presence-fan0","presence-fan1",
+		"presence-fan2","presence-fan3",
+		"power-fan0-good","power-fan1-good",
+		"power-fan2-good","power-fan3-good",
+		"","","","",
+		"","","","";
+
+		led-0 { type = <PCA9532_TYPE_GPIO>; };
+		led-1 { type = <PCA9532_TYPE_GPIO>; };
+		led-2 { type = <PCA9532_TYPE_GPIO>; };
+		led-3 { type = <PCA9532_TYPE_GPIO>; };
+		led-4 { type = <PCA9532_TYPE_GPIO>; };
+		led-5 { type = <PCA9532_TYPE_GPIO>; };
+		led-6 { type = <PCA9532_TYPE_GPIO>; };
+		led-7 { type = <PCA9532_TYPE_GPIO>; };
+		led-8 { type = <PCA9532_TYPE_GPIO>; };
+		led-9 { type = <PCA9532_TYPE_GPIO>; };
+		led-10 { type = <PCA9532_TYPE_GPIO>; };
+		led-11 { type = <PCA9532_TYPE_GPIO>; };
+		led-12 { type = <PCA9532_TYPE_GPIO>; };
+		led-13 { type = <PCA9532_TYPE_GPIO>; };
+		led-14 { type = <PCA9532_TYPE_GPIO>; };
+		led-15 { type = <PCA9532_TYPE_GPIO>; };
+	};
 };
 
 &i2c13 {
-- 
2.53.0


