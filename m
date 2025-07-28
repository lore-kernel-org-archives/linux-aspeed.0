Return-Path: <linux-aspeed+bounces-1849-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F69C87FCE
	for <linux-aspeed@archiver.kernel.org>; Mon, 28 Jul 2025 05:56:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4br75d0yTGz30Lt;
	Mon, 28 Jul 2025 15:56:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753682197;
	cv=none; b=MWaRxPBeDNbV180JhLNn83L8bH2FaivuFmXQRcJO/bHByiTWx638b794QYOGXmvQyi5tH6p5fy2KEKYe0JtFUj1JnX6an6maiDgrggmKyaPC9DS/mVq0rK+l/7odOGkAawq5cuR6CfYEsci8lWzw8Scrvr3Oka2uYpBHpfMU6vVGEyUbWpAXbuboCGeof0mzulMcLimU6hjE4YyeQrtJ9OloL8La036Bxwp8Xp8b09V2ondMVHcnQtgTREK+Au7PTs1V2Yqbq5+JtY3W578Cz2INDigwZtGysBNRRM0OVvzWmXMpCoVpxB4oe85QYyAx8iYWunfxq3SDGgSq8KFJdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753682197; c=relaxed/relaxed;
	bh=t/YAuK9Y0oHVDDTSHah83w1CX27+EsYJX9fr2DChXv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HU3nweGdU4awB/pnJqF5YeViq6JPArMLrzPffHDTSh3t+ezjlLDzCYWcP/hHoJe56C0p9bJs2hB/f6AvA5Qf7L1pB+pc5gRGq1CXHXdCRGzeswASAJq+dkBebaTjlzXfx0xWDigJ8zsMCJLAZEdnTAv/M8Pql7YTzwX9tMMHW/Tuo9gzThPqYlaAukMpWET+ma29y4+/CCd/7l9XIc9eLp1dquTt84V3oB3doVNGKJ+cHFXyIXKKhZ7i40C1otUjU2YWWoKQ/Df5Rt7UYEz4LQBG6Y1wm0eaCCnMX4ZSr5kbCLsChpzM+34PtBBYwRs+b4bDTGC0CH68TST3CzQNDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dCrvN1q1; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dCrvN1q1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4br75c38Lrz307K
	for <linux-aspeed@lists.ozlabs.org>; Mon, 28 Jul 2025 15:56:36 +1000 (AEST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-b34a6d0c9a3so5037620a12.3
        for <linux-aspeed@lists.ozlabs.org>; Sun, 27 Jul 2025 22:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753682194; x=1754286994; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/YAuK9Y0oHVDDTSHah83w1CX27+EsYJX9fr2DChXv0=;
        b=dCrvN1q1l4ju1nl2bkrEPAmeTEaWYl5zwXizGVDNPn+aOma/eQqFQ8JPOz79mc6tPs
         eKXdM/CaAMZRqAQ6pAFDtbG5PHy9f1XRDCK0jNSruLerS3/oFZjbLdfTcoejlcPg0t8J
         AOhuz0oQ3JRPd9StSVMWiMGdEFUjkNeTjHk5ZorPb1LNzBjWVzwYGfvuF/5aH7ZqaydR
         1B2A/70Vo1XrZUWsiFXtbd51aOQZPJUIDVtHEJaaeSiTQNKgXhpGv/hDqVKqqxYvaXyN
         ZK6q6ASX5C0Erc1YnUNFer9GSsYTwb/PgSJ045GkAutdcuHytpgO6w7tK1SHTSuf1/hT
         Q9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753682194; x=1754286994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/YAuK9Y0oHVDDTSHah83w1CX27+EsYJX9fr2DChXv0=;
        b=YxWCAlIDT9uXYf9sQ4eGS7S96SW2Xt3KlGwfbcKl1YaU9cY+F0fsBRvnRXr5tFyMgS
         mlF5Dthv1mBczjBRzwfQDto3NlYGIxvHCJRdUBVAD1Y3qN0Rp2Ty2l//ruTWoEQLJFR1
         4ms+91mWx6wN7KD3IvqhWXb/c3Iypj/FzIiWPIGjRMuU6dIbr99HfIVjwBVvsMgXhsZO
         PTVZCw3/O33qtGXHuBPkiZ7xxzBoQ/ObzzPdWiaETWbcyTZE77wYcYs9j+w4L7/G4E8N
         knSassDIgyhifKL1np3Z+zmnHfgKMDFTGAei2eVh7iJOacnp+C1zr+/RzJnZGJ+PK/7v
         V7Ng==
X-Forwarded-Encrypted: i=1; AJvYcCW5GlmUEz3tUhhXHsKjXSM0m2DvAIXIHt+nfay0RYOF/05SoUe5dL9XT2M+nFUHOl8flQunum0zFQSzMjA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzO/LS1nJGXlTP+FQJlcgF5OAggDXteAAYDYC7X+CJKpIVTMsNb
	xcBD2EGJtl5i8nhI2TMymlkQ6mxlrPu7rQgTabLf3J3S4kfc2TW+jZKq
X-Gm-Gg: ASbGncszNp7wOuqPcy6Z+sTI8SEDJ3fzLHI3BerP9NR5c2r02KCIeTxWHkI1hCqFE8n
	vYHBwjZzaJtvSdvX5OdGz2qNEXBpnF+Z797RFx8UEP3x17Q4RJzjrXf8q02pNmSyoQmeUIAmD7z
	CbBB8Glm2+oHSbb029E9KzXWGXPLB4cSc5sp6vROxOcgOAKbg0V7PqLZ7e5Bb2QZKIn2MwiJK6/
	q64S/SmlKaFLcGH54zrR1UQ7o5KrwaVAUdNpw+h0QdhAxav2QGncbGpXn+lz2oKNFkhOLIwHrw0
	Od/vzKDoae+w++Zr1vt6MdBAsbZzjiiymeZP/GPY2M2bvN/k5e1X8ggQZiSEoETRHS/xWyGKScg
	xUJuPBwf2o/Imd6G3VmyVjBocb9WsHXUtpOqzg9yLzSPPJjZneXplsiSrkd4LnXwq6LaFrKc0p2
	xz9JT7MJgItw==
X-Google-Smtp-Source: AGHT+IGckpl416r7tKZtEvLi84N6rVIZtXh8LmHNCYPgTxJOPIcTlDmrV6zCnV/8M+iaGU2K9uCPpA==
X-Received: by 2002:a17:902:d414:b0:23f:df36:5f17 with SMTP id d9443c01a7336-23fdf3662b3mr66552915ad.22.1753682194123;
        Sun, 27 Jul 2025 22:56:34 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe514b59sm45091795ad.128.2025.07.27.22.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 22:56:33 -0700 (PDT)
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
Subject: [PATCH v4 07/13] ARM: dts: aspeed: Add Facebook Wedge400-data64 (AST2500) BMC
Date: Sun, 27 Jul 2025 22:56:09 -0700
Message-ID: <20250728055618.61616-8-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250728055618.61616-1-rentao.bupt@gmail.com>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
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
  - updating flash0 partition.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
Changes in v4:
  - Removed redundant bootargs from dts.
Changes in v3:
  - None (the patch is introduced in v3).

 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../aspeed-bmc-facebook-wedge400-data64.dts   | 375 ++++++++++++++++++
 2 files changed, 376 insertions(+)
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
index 000000000000..1d46eaee8656
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400-data64.dts
@@ -0,0 +1,375 @@
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


