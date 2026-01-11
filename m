Return-Path: <linux-aspeed+bounces-3278-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24979D25031
	for <linux-aspeed@archiver.kernel.org>; Sun, 11 Jan 2026 23:11:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dqB8w2Gfnz2yk6;
	Mon, 12 Jan 2026 10:11:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.128.182
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768162341;
	cv=none; b=Krh987435EU/cXgJhg9twAqIlJuWS4XynImKg5+e1Dv/HUd5RTARPlB5nGtWV0NFKa2iucFNWOTNnLJ9z5VEeJ76hSdO1RRAS8t9NLyxav8SN/nEaQeRMDvEzkOG6xfi3vZ1mrx3tRmeBJTWtqLRJHC/qJZGGqAimj+AU7Z5Hx+jMVvZvTNFZMzJuzZnA1HTRThgt1wqXrP4jT8h4l7cmq83ZFhZhXaiWyF0IcQbhmfEtedAuEEp+NLu/3Fnlf5+4SLt5a0MIM6FRKQu/nXBAIMXR7Fwk+e0h2Wu6W8kWueidQWWS80mTNgphFk26wauYPuCkucS3E/H7RC+VHMXuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768162341; c=relaxed/relaxed;
	bh=MI+UfjdZ4KBl70/kcazNDAuL61XOS5jgfeZZ52BwtA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xqan2hifJZDmNds4YfnkjvN1JkDpsXERiTW4s8IbTdZsJw1rriyZ2vl4eu1XP67JOXorf6QF4BoCI5U8F8uP0qVd/C9Mz9oSdUTRLsOasEBorEXKRY7Blda+IZbGtyDirTxdoLQL9WzAzWKiA/2hDkXOERows7pKfgQwYKx0dN9v0pNkCQnHw6XkkYYeHnid/PT5QPRPTI78j7sDYAHAupZcr1XUmbu/1Igq9o/YxMa9duYo3rFeTRoifpIRfc8fTbKKagtLb+W3vHMFhHy1G4pteRNPwhlq6R7fptPsigI2znbd8oMDZQtCVbiY+noY9FeMA/IOXf9sY7ggoR0sEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Fl8EbRjD; dkim-atps=neutral; spf=pass (client-ip=209.85.128.182; helo=mail-yw1-f182.google.com; envelope-from=anirudhsriniv@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Fl8EbRjD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.128.182; helo=mail-yw1-f182.google.com; envelope-from=anirudhsriniv@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dq69w73Z1z2yKp
	for <linux-aspeed@lists.ozlabs.org>; Mon, 12 Jan 2026 07:12:20 +1100 (AEDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7927541abfaso9300957b3.3
        for <linux-aspeed@lists.ozlabs.org>; Sun, 11 Jan 2026 12:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768162279; x=1768767079; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MI+UfjdZ4KBl70/kcazNDAuL61XOS5jgfeZZ52BwtA0=;
        b=Fl8EbRjDYWdyNQ7wvR0Ck1KqslBdgPwVkU/jaops9PsKStL7zI24t/Jm/UFHQ15j8Y
         BcokWcTbDYJYP8ppETVxIGV6nr4rUe+TEVViXq+vWY/UPO5sSzyWdeXS9CtlulbsDXzY
         wZzZTqImrJBeV5WQFYuhZ08R6WBgoA0iu9lmjS9RhIPkpohMn0fmSMTJQJm+v4RbBgb9
         gL5rY5mnZCRLoCRKGt/2LizPwPhA/bD9yFcsc25OzGQxjDxdGDzAK/n6kqWrK0j+tTTR
         kdv2zWCh4uJcciVr208n4sd6KvuAm43JvszibjH2sQKx6/egQNgSqoklsYcE9xQ7DzoN
         2H8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768162279; x=1768767079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MI+UfjdZ4KBl70/kcazNDAuL61XOS5jgfeZZ52BwtA0=;
        b=U8jSkHTWcIf6wBFfZpHEMQBETMT+h3tpv3nElOSuPzp/nHB/qG4wgmxsD1LhdIqmUF
         0p7yUKBrab8C4ignPFExB1rkzV/Jog8NuKxxu8oG45WQEGGHiT3bB3bWezedY2pV7BcH
         MmppHIKwIDYodeMoGylp9zqT+znHwjx/63DppVfr7ZV24VmRHHdvrY0flfZpHWQxIFmL
         +bK3VSU1JSx116kj3S/Lm/aFXyepJpz++gGCsoM7qqWklYG64dJmkObUbfr56gYePRCb
         gHwEaCkGM1Lhtck2briV/pLqtCUKkQFOdJ3IPQILhDzhQ4+NmcACQ6o539FmiRN3SOde
         FoUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAcrvJ17KQp/RH79VKYGHJ87sGAnqhIisUmKw50bHQ2AecL0UU35pBR4jouUqcGk7yOHQAQekF/9z+Fng=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwRIsCOq6V7pTkTw1PCgvKCTnqUUBT8plGlmgE/qEoI+oR3sEzx
	zgDriLxhgwW8jwaXYw1+ZM1+I7rl5Qtn5/2l1TnkNO7q+3ftqFCaZxPx
X-Gm-Gg: AY/fxX62qdILJfkWVeA5woAZT5uFCwg/LBchVQZyhSHLfvmT4wtZSiHVB55vRsaPGTb
	UbpgPx3rbyMzBQlVkjxHe/AI+FahdOMlpOjX1RWglJIfFi22n2wbkhpOqMUGCsUusgBVtFJy9DZ
	ts/J01QYqzVImrRWGLAV/f2XUOFNG9WNxJIpyHCLmdxMGQGVsN6G8/ZYJh8g6h40wp88QqMOiCn
	MKYzCZMzP55huTgriY4ycpmKp0DExcKVLBNt9ZQ95ep2YOf1EW/Z/ThdFGGchoQMBf/I2072Kqb
	MzWxrM1ghXO7aeqj/7JwvjjOq8sS2XII7mRTEWf+fu5oZXD0MY2XVkgQpy/G7tdunVx+/rUDKRu
	V/n4N+LbExj/3iJIkoIUQ+pQHn9G39lC9ukYheTJF0qam0O20kmDr1PxsBe0UKt7kcPqn
X-Google-Smtp-Source: AGHT+IHgokj+1DLIRRT5f41nJ6r1E0Go/K7YSYrys1I9AtjEk7wX5wSAvv1S4isYPAgdLHvOV/iVBg==
X-Received: by 2002:a05:690c:5:b0:786:45ce:9bd3 with SMTP id 00721157ae682-790b57942f1mr140423197b3.34.1768162278890;
        Sun, 11 Jan 2026 12:11:18 -0800 (PST)
Received: from toolbx ([2600:1700:220:59e0::914])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-790aa5762f6sm62175717b3.15.2026.01.11.12.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 12:11:18 -0800 (PST)
From: Anirudh Srinivasan <anirudhsriniv@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: anirudhsriniv@gmail.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: aspeed: Add Asus IPMI card
Date: Sun, 11 Jan 2026 14:10:32 -0600
Message-ID: <20260111201040.162880-3-anirudhsriniv@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260111201040.162880-1-anirudhsriniv@gmail.com>
References: <20260111201040.162880-1-anirudhsriniv@gmail.com>
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

Add device tree for Asus IPMI card, an AST2600 BMC PCIe card

Signed-off-by: Anirudh Srinivasan <anirudhsriniv@gmail.com>
---
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../dts/aspeed/aspeed-bmc-asus-ipmi-card.dts  | 136 ++++++++++++++++++
 2 files changed, 137 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asus-ipmi-card.dts

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index 9adf9278dc94..ff40d9ab88b7 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -15,6 +15,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-asrock-spc621d8hm3.dtb \
 	aspeed-bmc-asrock-x570d4u.dtb \
 	aspeed-bmc-asus-x4tf.dtb \
+	aspeed-bmc-asus-ipmi-card.dtb \
 	aspeed-bmc-bytedance-g220a.dtb \
 	aspeed-bmc-delta-ahe50dc.dtb \
 	aspeed-bmc-facebook-bletchley.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-ipmi-card.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-ipmi-card.dts
new file mode 100644
index 000000000000..fea94360245c
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-ipmi-card.dts
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright 2025 Anirudh Srinivasan
+
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+#include "aspeed-g6-pinctrl.dtsi"
+#include <dt-bindings/i2c/i2c.h>
+#include <dt-bindings/gpio/aspeed-gpio.h>
+
+/ {
+	model = "ASUS IPMI Card BMC";
+	compatible = "asus,ipmi-card-bmc", "aspeed,ast2600";
+
+	aliases {
+		serial4 = &uart5;
+	};
+
+	chosen {
+		stdout-path = "serial4:115200n8";
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
+		video_engine_memory: video {
+			size = <0x04000000>;
+			alignment = <0x01000000>;
+			compatible = "shared-dma-pool";
+			reusable;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-fault {
+			gpios = <&gpio1 ASPEED_GPIO(C, 5) GPIO_ACTIVE_HIGH>;
+			panic-indicator;
+			default-state = "off";
+		};
+
+		led-heartbeat {
+			gpios = <&gpio0 ASPEED_GPIO(A, 7) GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "timer";
+		};
+
+	};
+};
+
+&mdio2 {
+	status = "okay";
+
+	ethphy2: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+	};
+};
+
+&mac2 {
+	status = "okay";
+
+	/* Bootloader sets up the MAC to insert delay */
+	phy-mode = "rgmii";
+	phy-handle = <&ethphy2>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii3_default>;
+};
+
+
+&fmc {
+	status = "okay";
+
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc";
+		spi-max-frequency = <50000000>;
+#include "openbmc-flash-layout-64.dtsi"
+	};
+};
+
+&video {
+	status = "okay";
+	memory-region = <&video_engine_memory>;
+};
+
+&vhub {
+	status = "okay";
+};
+
+&gpio0 {
+	gpio-line-names =
+	/*A0 0*/	"", "", "", "", "", "", "", "BMC_HBLED",
+	/*B0 8*/	"", "", "", "", "", "", "", "",
+	/*C0 16*/	"", "", "", "", "", "", "", "",
+	/*D0 24*/	"", "", "", "", "", "", "", "",
+	/*E0 32*/	"", "", "", "", "", "", "", "",
+	/*F0 40*/	"", "", "", "", "", "", "", "",
+	/*G0 48*/	"", "", "", "", "", "", "", "",
+	/*H0 56*/	"", "", "", "", "", "", "", "",
+	/*I0 64*/	"", "", "", "BMC_RSTBTN", "", "", "", "",
+	/*J0 72*/	"", "", "", "", "", "", "", "",
+	/*K0 80*/	"", "", "", "", "", "", "", "",
+	/*L0 88*/	"", "", "", "", "", "", "", "",
+	/*M0 96*/	"", "", "", "", "", "", "", "",
+	/*N0 104*/	"", "", "", "", "", "", "", "",
+	/*O0 112*/	"", "", "", "", "", "", "", "",
+	/*P0 120*/	"", "", "", "", "", "", "", "",
+	/*Q0 128*/	"", "", "", "", "", "", "", "",
+	/*R0 136*/	"", "", "", "", "", "", "", "",
+	/*S0 144*/	"", "", "", "", "", "", "", "",
+	/*T0 152*/	"", "", "", "", "", "", "", "",
+	/*U0 160*/	"", "", "", "", "", "", "", "",
+	/*V0 168*/	"", "", "", "", "BMC_PWRBTN", "", "MB_S0_DETECT", "",
+	/*W0 176*/	"", "", "", "", "", "", "", "",
+	/*X0 184*/	"", "", "", "", "", "", "", "",
+	/*Y0 192*/	"", "", "", "", "", "", "", "",
+	/*Z0 200*/	"", "", "", "", "", "", "", "";
+};
+
+&gpio1 {
+	gpio-line-names =
+	/*18A0 0*/  "","","","","","","","",
+	/*18B0 8*/  "","","","","","","","",
+	/*18C0 16*/ "","","","","","BMC_MLED","","",
+	/*18D0 24*/ "","","","","","","","",
+	/*18E0 32*/ "","","","","","","","";
+};
-- 
2.52.0


