Return-Path: <linux-aspeed+bounces-4993-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1453C88E75
	for <linux-aspeed@archiver.kernel.org>; Tue, 15 Sep 2026 01:31:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkPcj0W9pz2y8d;
	Tue, 15 Sep 2026 11:31:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::c33"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789435893;
	cv=none; b=FOUyLbG63gRoaNm0I0Sb6DuFpQbecghFPgBmLOrlhTAzdA0e5VR6c9yKCchtCjfc7Bbi9JhWivwwJCtfOc/TN03dXPv9IPdv8aGu/O2wSraMwK8oOOJ4ODRJH7sJBxTMI10V0DgXS06nH/nSd6O03Rg2QR7VoKaQSIGLr7Sdy4wKvwuGj4+9VhJRvmFqN7i1OZk86YRo3pwGTAsUmr3HfFS7KoHyC+Na+6d8NN86NImhbFuqhDjRApMb1drZtskfD9+CZFRdygHY1yBDJkXb19+gSswbjj5SOfNkIzMZLv5hgUNMnE7Ohumog3zBeq3a/nwTGuqA1PDugK5zhAHksQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789435893; c=relaxed/relaxed;
	bh=mca1uOiT/+sfyymmOrDVbqr5tpDJZhJUUk2kbexgAZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2tgoKDfUBw0dJGoteBR+3jKCrjsI5zOLwfqRVnVNtb260LxDTqdXePoFmEKv1duXB2EdmtRxeW6X+/y0zYhT9oXjLSbfT8El/ZzvWts2gD5s/JktDne9C+1l3dTuxKoIwvgURfnrAL1gJSdPw15QwC2rDuzY5MQafaaBzSmQ/zW3MCL+TzoVbipMXGFLAp0b1IbYQtwxNTgB+ooMfylXeU5E1OYvvAGsE8BIFChfSYXUbwLEhqITb0V73zeAe1+Zkh80lcTpGHjDZCDR2mc/bIrlclMl2F99si3yZ+/N4AJ/14yEb9C8YUQBC/tq394nqmiz+Z2P/I/WWWJLRwDmg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fmKwUcHK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::c33; helo=mail-oo1-xc33.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fmKwUcHK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::c33; helo=mail-oo1-xc33.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkPch11HVz2y7p
	for <linux-aspeed@lists.ozlabs.org>; Tue, 15 Sep 2026 11:31:31 +1000 (AEST)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-6b1334a3b16so2794369eaf.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 14 Sep 2026 18:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789435889; x=1790040689; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mca1uOiT/+sfyymmOrDVbqr5tpDJZhJUUk2kbexgAZI=;
        b=fmKwUcHKDdqa82DcdLPvpOI5y95GU1q+M3ieTRceJfuDM5E6jhZ1AZg6su7tnybSti
         66mVeCueFnaD09Qtkywt528/Fkn+M3XdMQ3ETx/yGHvYoZLEi+TiUIzzHhoOWHaOfbty
         9hjKDd8ZE7qYKC2jzA5jrTa3nuyNyQSHB4EOW/CK/TBDlIl+Rc6STmiAJuXqMuxxmGpv
         maI/8dT60LlMtJt1Wu957haLZCC9L9cj0JX5/iyWnGCPdiYL0yILjV4FcSDVFWCtxXar
         6egvCfuQ8ztensgiP3pXrd5DpuLZT4V2gSlPIBt41x7UXDar+CtA1H3gaTgkiuzAxvG5
         q25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789435889; x=1790040689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mca1uOiT/+sfyymmOrDVbqr5tpDJZhJUUk2kbexgAZI=;
        b=P9fZG7OMLRN1nt+bSy5ZmFK+mbjO++Kr0vwWTR86ewJqlbrJyD/yfRrZwzPcPNcWOc
         ZD8YQO94XVyjcl/8RESSiit7rQVhFo3C9DXvPKVDr6duaX+M/0TZPBkkrb+q4niNeiZl
         JBZB+BeI5DZs+GEico1S5LCo+MR42medIZFEg1eFbAS0Mmu4jeEG89dhbmmhfocbjKkq
         +VdDF1VGe/Kqi3AuQA+VuKBKWBb03APa4nHkNNsAys9/TlcSi0KO13ant0K1e3ELS+z/
         lEgE2uI51CbUWJR5tFQp0mylulTsQg94VDkjfX1O4sHC6SHKw/z/Lnt7RU4yolHTpUh8
         Rn3w==
X-Forwarded-Encrypted: i=1; AKwUvBx4OtXvLceTNX1muzfxBzPoXQBRuSZfOBq9ZK4FhsLEKF3PnLvzivq/bRUBi/SxNc1Hvqck+4Le8Sy/gEo=@lists.ozlabs.org
X-Gm-Message-State: AFuF++k1ogYl+F9JNWwke6z08kLBKGnLVr0QJeapzCIXRvK8hIDcV4zK
	ls0pL5O0zYDV41wigDM8w0Io9xNO6MU0kFecPp3Re12z226qKtreMege
X-Gm-Gg: AYBFou0Zh0SATrgY7LSeAx9z5m5DoYiJByWq5VGROqpKWasjHMOwRK+5IN6PzvSFsbs
	r6tAh1O1zqAaujRrLD+wc6bLkMKlX57makJbr+ocPXA1bVa/3+gmfkVJeFTjjOcE1lDZuIGSHUW
	VHQ4CHmdRDHdKb/E0H+WSkn37uzcZnPoMWN+oEHIm9AueqcWqcubcIEDpOly8XRsZQgcP3MY7m/
	zZYWiATp95XdZewnEHl4cElMehNsyuDrM8ZKTbKvmMFu1qag9LR6Yvz8KMKaLQ+uck5iPCOhiE3
	x/5HEVC09pYWrRJTRDSTfxe7sTVRfTYo/VfT3OmOhgvkBMKQJ68RDGS7nq5xUjc08gzl+ENxVPe
	YABTsOZtQ+gLOiGWb2t9WFA0DMf953oTQr1Dfe8e9Sh2JpYKRVgjVjqXLNB+p/9fxhSOl9bTI3J
	4zoNvd5jBovDIMmd1N1aX0JeWHpSkMY/hZtb2pzdu+ipl5MlBOzV9V8Q7vhoYtj2LGS5/+97+R6
	j7QG3c65nGUCgk2
X-Received: by 2002:a05:6820:1694:b0:6b7:83d6:2920 with SMTP id 006d021491bc7-6c542342bffmr3288896eaf.35.1789435889379;
        Mon, 14 Sep 2026 18:31:29 -0700 (PDT)
Received: from debian.prasanth ([103.183.205.11])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365a59b18sm27111575c88.2.2026.09.14.18.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 18:31:28 -0700 (PDT)
From: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
To: Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Subject: [PATCH v5 2/2] ARM: dts: aspeed: Add ASRock Rack B650D4U BMC
Date: Tue, 15 Sep 2026 07:01:10 +0530
Message-ID: <20260915013110.4780-3-prasanth.padarthi10@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915013110.4780-1-prasanth.padarthi10@gmail.com>
References: <20260830182036.284736-1-prasanth.padarthi10@gmail.com>
 <20260915013110.4780-1-prasanth.padarthi10@gmail.com>
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
 .../dts/aspeed/aspeed-bmc-asrock-b650d4u.dts  | 120 ++++++++++++++++++
 2 files changed, 121 insertions(+)
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
index 000000000000..6585bda56a4c
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+
+/ {
+	model = "ASRock Rack B650D4U BMC";
+	compatible = "asrock,b650d4u-bmc", "aspeed,ast2600";
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
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		gfx_memory: framebuffer {
+			size = <0x01000000>;
+			alignment = <0x01000000>;
+			compatible = "shared-dma-pool";
+			reusable;
+		};
+	};
+};
+
+&gfx {
+	status = "okay";
+	memory-region = <&gfx_memory>;
+};
+
+&gpio0 {
+	gpio-line-names =
+		/* A0-A7 */	"","","","","","","","",
+		/* B0-B7 */	"","","","","","","","",
+		/* C0-C7 */	"","","","","","","","",
+		/* D0-D7 */	"","","","","","","","",
+		/* E0-E7 */	"","","","","","","","",
+		/* F0-F7 */	"","","","","","button-reset-n","","",
+		/* G0-G7 */	"","","","","","","","",
+		/* H0-H7 */	"","","","","","","","",
+		/* I0-I7 */	"","","","","","","","",
+		/* J0-J7 */	"","","","","","","","",
+		/* K0-K7 */	"","","","","","","","",
+		/* L0-L7 */	"","","","","","","","",
+		/* M0-M7 */	"","","","","","","","",
+		/* N0-N7 */	"","","","","","","","",
+		/* O0-O7 */	"","","","","","","","",
+		/* P0-P3 */	"","","","control-power-n";
+};
+
+&fmc {
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		label = "bmc";
+		m25p,fast-read;
+		spi-max-frequency = <50000000>;
+		spi-rx-bus-width = <4>;
+		status = "okay";
+
+#include "openbmc-flash-layout-64.dtsi"
+	};
+};
+
+&mac0 {
+	status = "okay";
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii1_default>;
+
+	nvmem-cells = <&eth0_macaddress>;
+	nvmem-cell-names = "mac-address";
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
-- 
2.47.3


