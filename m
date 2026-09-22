Return-Path: <linux-aspeed+bounces-5036-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87065C982FA
	for <linux-aspeed@archiver.kernel.org>; Tue, 22 Sep 2026 12:37:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hq03y6nsnz2ygX;
	Tue, 22 Sep 2026 22:37:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:3b::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790080654;
	cv=none; b=XFp0vtvtB5A309tPZ1DhnnejjIHYT+9Ei+mp3dqdsnrXrLl4voCkrgr77pAQpSy/8qEASfr1uSFlj4a9vMAfpoJq6F6QeOhIoBr5a70cvs7e0QeKztdWJxLdXGatCEfOhvzPhxthKyEllXw8irzaDoOR1qs1wQGjPA2TQwg6fVNv7gFDLPMq847oHik3w17f/YAl2mFqUbvANfK0F3AWDnHof8I5VYObbyeOcXWH8zloQTvX5XKvEbY0aqcv3rdjJc2J1ufPupyROOgMmW9zdiWzkO7jHwJeVs1SgSY/K/xrhjMhoGMpOeU4L3dgeSipfKeYNcFSAXYzZx+u7YrlZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790080654; c=relaxed/relaxed;
	bh=7irEIIBgzty36UKE5fbvUb/seFCiEiq/bxnIonis9JA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eyYDIb7gZ5me4k7uBZrPzMfbVVr14XoAqKT3zCAHkyUOy7XfaLrge4CArMX3jtw4ok+ONYgWGaZ8LH/Xwt8UNPqk6+H66jF2TN3gKkCc/Ne+I8PV58LHD1pgb5EDOVyAGBW05ZOsD5udWS3JwR0ZV8LpZIxOIuIw4Q7CGbZuixhecxCjgdPiMpMzefyjSjPFEj8HcioqaJQsqpNktIgF53RFdLSrV32XdKWNEosq+3BrYU74Lx1Ax8MEowdeAtFCnyEHNGHWtE4cxa5c3fTU5eeJ4UsfQyXebfKvND0Oli7FLB6Qg9HCmAIMKpwdDgvHr55emEcmiYXAEDJBiVjRbw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Jd/iJ/QE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Jd/iJ/QE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pz2-x10.google.com (mail-pz2-x10.google.com [IPv6:2607:f8b0:4864:3b::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hq03y1S3Kz2yHT
	for <linux-aspeed@lists.ozlabs.org>; Tue, 22 Sep 2026 22:37:34 +1000 (AEST)
Received: by mail-pz2-x10.google.com with SMTP id d2e1a72fcca58-8692a8568e9so3461970b3a.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 22 Sep 2026 05:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790080652; x=1790685452; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7irEIIBgzty36UKE5fbvUb/seFCiEiq/bxnIonis9JA=;
        b=Jd/iJ/QE7/4fPA6mNuCFWTRySW6U9tiaeh5/aD7blUkXy8RM77HLByQDAu9mak2OII
         sq8hzoEtrqJVQoEk61pnTEgXBpcyghu/4e7YQ2VTn8S4j0MVXzqs3FKGq7aLbuB/EOG/
         ccXA+dzzcjsEZIz/8YjmlF0wdO1X7zt2KFU97MciSfSbY5WlyKj6HEIUEQEPWVjxc4j1
         UmBY/k0biuzF6/xzi+L/pUd9ZSR963ME5e+oSFB2xf/ezfr5s+QTELeQvNNp6o1XSY/4
         fxPT9RqdPW61ccIglSkH+1wj7uQP71EQtpS495FH8Yps1IsybeS2ejbctojpEnC4jgXH
         asqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790080652; x=1790685452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7irEIIBgzty36UKE5fbvUb/seFCiEiq/bxnIonis9JA=;
        b=QlU92D24/r92nPxhjO5kicJfy5HyKjvzInL+sODjpeWdo1w9FpGjsd1PlUdSwxiPGJ
         ZhhGMOHMXRIe/AALHx9O0PH9P4BS8hGj972kUYTVzMaLraM8Dpfk2iFjJUhproPJvuLC
         nGIEDL7asTWXGSgEE6M3DLyTzxYBl+QjLrPs/7gNiy0XD5OjZEKZleZIneptN+aFkEqy
         ImERvTM76I+H7pYuiPVmwt08FATEPJdJW1rDE2T8LW+88Vr8UL/urIKm9BXO7r7xqtP4
         Hol6J2j159Ctcl478v1miVcTwxrBz3Kr3ik1y0qqif30er29EmcvwKw6KQCALaRFLC5d
         I2fw==
X-Forwarded-Encrypted: i=1; AKwUvBxq9+iTNdLqVTDuYzrxtKfGL6Q2E9qOezY+S25wYeoibQRyNqBBi1kAHR15+xbzHiVE2h4SbbdsHbdXFec=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kpeVdtUgONEonm7R/CpvhiC+kuj4fkzOOV4KChx9o7h4IcEGDJ
	9mQ7kaKWS/YRbmJrD9X1FO+YBza0/mGKotyr8KZkExjD25tboXAGfwJJ
X-Gm-Gg: AYBFou1pnWYBvZEuqakpCrtRfY+np/Vo0qZ90oc42UKILQrTAc746M6pXtnKg9J35c+
	B8TVYl9WgY8ObQgK9qVG6FPR/ebrb1sGHUQCQ7C+ou55NUQZti7WiZOICpB10yZqfa+sVswKmGk
	dXhsPcYr4OJbRmnBDf4sE/zsYEbMMwYzVafQfUnM8wpsyQwcuT4UqZx0mpRFHdT4GjZZdGU0SHD
	aynfmKqEoIlHkd97C3EHFryS35n1XAIgqI3DOOGiVg7CFk65ym0UH3yAHg5YF48vs/yeZtrQRZn
	gEE7DtnWIdgcHoZeT7ZcDTbiHWybHN07jnYp2Gm/Q6OWHqZmO+nO58tQr3FckqSU4PD/fopmc89
	NUldMFaPPRx9NA31DFWWxtZOrDA6EpcI6pM6YzYT+LvCN4aNXACBoqvRd/TS0yrS+5I/7iWgxSu
	HPQfSx4EiiOnxms/QefC8/MPFrGb5K+TQDQDTkAv/gFztfPwukXcFJrCgP4HZrhR4oQjC7VNLC1
	fiNtOcBY2eGG9AjYxwbe7ZxLng=
X-Received: by 2002:a05:6a20:e290:b0:3dd:a196:9076 with SMTP id adf61e73a8af0-3ddec87d5f9mr1250509637.64.1790080651785;
        Tue, 22 Sep 2026 05:37:31 -0700 (PDT)
Received: from debian.prasanth ([103.183.205.140])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e612ccd46sm6453922eec.18.2026.09.22.05.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 05:37:31 -0700 (PDT)
From: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
To: joel@jms.id.au
Cc: andrew@codeconstruct.com.au,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ryan_chen@aspeedtech.com,
	billy_tsai@aspeedtech.com,
	andrew@lunn.ch,
	tan.siewert@9elements.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Subject: [PATCH v7 2/2] ARM: dts: aspeed: Add ASRock Rack B650D4U BMC
Date: Tue, 22 Sep 2026 18:05:00 +0530
Message-ID: <cb05fc2f4158b03d312b94cd9361173fe92ac528.1790079398.git.prasanth.padarthi10@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790079398.git.prasanth.padarthi10@gmail.com>
References: <cover.1790079398.git.prasanth.padarthi10@gmail.com>
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

Add the device tree for the ASRock Rack B650D4U BMC, which is
based on the ASPEED AST2600 SoC.

Describe the BMC memory, SPI NOR flash layout, UART console,
GPIO line names, video framebuffer memory, I2C EEPROM, and MAC0
connected to an RTL8211F Ethernet PHY.

Use the EEPROM on I2C7 as the NVMEM provider for the MAC0 address.

Configure MAC0 to use the RTL8211F in RGMII-ID mode.

Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
---
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../dts/aspeed/aspeed-bmc-asrock-b650d4u.dts  | 135 ++++++++++++++++++
 2 files changed, 136 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index 6b68671f9379..b109491d5c8f 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -10,6 +10,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-ampere-mtmitchell.dtb \
 	aspeed-bmc-arm-stardragon4800-rep2.dtb \
 	aspeed-bmc-asrock-altrad8.dtb \
+	aspeed-bmc-asrock-b650d4u.dtb \
 	aspeed-bmc-asrock-e3c246d4i.dtb \
 	aspeed-bmc-asrock-e3c256d4i.dtb \
 	aspeed-bmc-asrock-paul-ipmi-card.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts
new file mode 100644
index 000000000000..a4e384588a54
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+
+/ {
+	compatible = "asrock,b650d4u-bmc", "aspeed,ast2600";
+	model = "ASRock Rack B650D4U BMC";
+
+	aliases {
+		serial0 = &uart5;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>;
+	};
+
+	reserved-memory {
+		ranges;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		gfx_memory: framebuffer {
+			compatible = "shared-dma-pool";
+			alignment = <0x01000000>;
+			reusable;
+			size = <0x01000000>;
+		};
+	};
+};
+
+&fmc {
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		label = "bmc";
+		spi-max-frequency = <50000000>;
+		spi-rx-bus-width = <4>;
+		m25p,fast-read;
+
+		status = "okay";
+
+#include "openbmc-flash-layout-64.dtsi"
+	};
+};
+
+&gfx {
+	memory-region = <&gfx_memory>;
+
+	status = "okay";
+};
+
+&gpio0 {
+	gpio-line-names =
+		/* A0-A7 */	"","","","","","","","",
+		/* B0-B7 */	"","","","","","","","",
+		/* C0-C7 */	"","","","","","","","",
+		/* D0-D7 */	"","","","","","","","",
+		/* E0-E7 */	"","","","","","","","",
+		/* F0-F7 */	"","","","","","","","",
+		/* G0-G7 */	"","","","","","","","",
+		/* H0-H7 */	"","","","","","","","",
+		/* I0-I7 */	"","","","","","","","",
+		/* J0-J7 */	"","","","","","","","",
+		/* K0-K7 */	"","","","","","","","",
+		/* L0-L7 */	"","","","","","","","",
+		/* M0-M7 */	"","","","","","","","",
+		/* N0-N7 */	"","","","","","","","",
+		/* O0-O7 */	"","","","","","","","",
+		/* P0-P7 */	"button-reset-n","control-reset-n",
+		"button-power-n","control-power-n",
+		"button-nmi-n","control-nmi-n",
+		"","",
+		/* Q0-Q7 */	"","","","","","","","",
+		/* R0-R7 */	"","","","","","","","",
+		/* S0-S7 */	"","","","","","","","",
+		/* T0-T7 */	"","","","","","","","",
+		/* U0-U7 */	"","","","","","","","",
+		/* V0-V7 */	"","","","","","","","",
+		/* W0-W7 */	"","","","","","","","",
+		/* X0-X7 */	"","","","","","","","",
+		/* Y0-Y7 */	"","","","","","","","",
+		/* Z0-Z7 */	"","","","","","","","";
+};
+
+&i2c7 {
+	status = "okay";
+
+	eeprom@57 {
+		compatible = "atmel,24c128";
+		reg = <0x57>;
+		pagesize = <16>;
+
+		nvmem-layout {
+			compatible = "fixed-layout";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			eth0_macaddress: macaddress@3f80 {
+				reg = <0x3f80 6>;
+			};
+		};
+	};
+};
+
+&mac0 {
+	nvmem-cells = <&eth0_macaddress>;
+	nvmem-cell-names = "mac-address";
+	phy-handle = <&ethphy0>;
+	phy-mode = "rgmii-id";
+	pinctrl-0 = <&pinctrl_rgmii1_default>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&mdio0 {
+	status = "okay";
+
+	ethphy0: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+	};
+};
+
+&uart5 {
+	status = "okay";
+};
-- 
2.47.3


