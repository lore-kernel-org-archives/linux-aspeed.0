Return-Path: <linux-aspeed+bounces-4874-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F709C61DE2
	for <linux-aspeed@archiver.kernel.org>; Sun, 30 Aug 2026 23:44:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hY7xd4pVMz2y2f;
	Mon, 31 Aug 2026 09:44:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788114066;
	cv=none; b=gsfDsctlElraoRfhjlFn1ju2arMD4Lkxygq0FabqyoC3wlXtUP45buit4NGNtwuDjINc2TsmM5LztOpBk9Q4WGTftU0SebGVjahGYbTP8je8E1cl3LbL8Y+muLKCFg5jE+IksjaYPN/yrDPOkyvuVn93uyArDetOuHpNv+v2zGgjrpkR9Onp88dZuamKVbYwIwzFUY6D/9EB9vmTKYIzp4WPuj/EOAzvohQSppi4a7nyGnxVil5tQeBtmwOAuQKMxj2mOlt8XLgZTo3NGyGzbxMcQTCEXYT1QtYojGe7qQL8LOPhU8gkTmmt3l4Lj9TqITO3IZNy1zJl8+HU0PVLIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788114066; c=relaxed/relaxed;
	bh=c4U0BNDYU2UB4eOhplmVYpzX07XscyKMmjV+K/BC4jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=akpIAN3ijaORab5l+I+sdr4W4aVDoS04YLCb620xPREpObYVpHyTpVWaYyHA7dweHHxEsDCsfe440CtJpukal54OA6s9SQN2nNtAdvOhuRyrAdVVctsq54tXA2QEJkc4jLNci046dGSW+ONEibMg6pNrQnypw60H9t5tb4stcBeDPpgdaoTGRABjAQ+PQpZlV9xXQMqaQbrDkFVo2OVZi0XqdYA2frzvDxP2URtVWHABlAVa4EeyxfNd1s+XGknjHPRjG66rEXAUK7SbmpOOmCFlYvoxcArJsgxB6aLRtJRZBXN1lTdGgFLx1X+zL6kAlParZgzzROZR4J4EGZdzKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WWEKD+tL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WWEKD+tL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hY0mx2W1Zz2xT6
	for <linux-aspeed@lists.ozlabs.org>; Mon, 31 Aug 2026 04:21:05 +1000 (AEST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-cbee846deecso3639914a12.1
        for <linux-aspeed@lists.ozlabs.org>; Sun, 30 Aug 2026 11:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788114063; x=1788718863; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c4U0BNDYU2UB4eOhplmVYpzX07XscyKMmjV+K/BC4jg=;
        b=WWEKD+tLvLmL/FuZWBmD+V7OKrs373OFLeCix6+ovycHbVv/jKU0ozeIcOC0Y9HSpW
         KhNsZZRA15zVghQC4/MhoGoaEZJvYJqc2hpe0wz/Ou1E4gyybm6fBfiHR3BhMgz4Vvmd
         F6kghAh57mgQD23p0LnLGywRUylewWXY9PKTxSyy53RxtND6p7kTyocdWzbw09vxFrv6
         mneE/ADI5INaLXy5rNVMwlogX2+fYnlLMxNo/ORQcZrsLs/wBXUjhpTVAT9pbF7ZrGqG
         /FAA/EGSE9lt3RaPOcsTASPlSES43oewjKPss9wAP40p/QdC4HgkLgA/WrcIFiAiXWli
         02Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788114063; x=1788718863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c4U0BNDYU2UB4eOhplmVYpzX07XscyKMmjV+K/BC4jg=;
        b=Zm2rusHf+QKdauE4aURA19D+fomTz03Dl1LGF2/5idqPyWdync7MFaSsdcBa2XTVZn
         hxjf/1uxur7ClUqjOIusCHwvFHMOi0S6udRMAf0tZSLheACACv0eIoZh2+bEr+qfiOTa
         A4EsLRaIu3/CdQXStGSuhIf+ZiuAbGVpWuTy7oWt1L5TE/aiCQQovADG/P4NB/DKjbPf
         dNmSujjYAjoZ4jx3ZJrUZquuP/uMkkj5V8axTaQyDNgEd0TqkUE0B6alYwHDBqmrANLM
         kuOg547R1U873KYc/DOn3ctTX0//lf7YAAJUdOm/8Ptg7qJP+KmEdgnaDXVEnBhALQvN
         kKug==
X-Forwarded-Encrypted: i=1; AHgh+RpRDf0L90pV/Uh4Lf05Ntel+oALk8tXZ4uaGDk5MaX7ePN40O3MOU/3dCoJOctzdXZrY4swIwm46K0li+8=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lagG3fisZV8pau759rPA7cDZdksLWOf+FfeEflC97LNmemY/Lr
	B8061rjbJiqi7dHJ9ypQx7FFeozwaxLV50W5LgdFphNbXlwTb/DL0nor
X-Gm-Gg: AR+sD11Y3oGsRm0EelfQL5GYwteD+rQp9+UpvHw02tFsCwBkD3hgTo/fdCihePrPDQv
	6wwlhPA667F+fXjl+1mn491nsXqqm3j5plJki9HWhYfVbHzHz7DrRiGTpY7Nh6kcYnKZhixfOpG
	L6R1JYOV0oRCEexif20lWfY+mB+f6tTowaCVEQt0L3mmi9xz06FisjL8i3xTcnfi3XMOjySNvgQ
	UGiTWeG2D0FkIGJozSVniIhc8aXBR+aQ7WpVOq4rlZcMJ1T6bBim4IYvxD3ZZv/GNAtjH8h8FbN
	8lcLukBXHDIMKa98o2jxWHPelGMQ6YoQfXkOB+ejYeRs1yMlE2o/jcpWJ3eJ5F6BZ+P47txgLJo
	JzVacuehg5Yv9DVhmTR49sbuvd9RBmHyHiOKmgxMGd0AqUPWKaQy4L7BqM+ZN4vocQbB5Tnaln+
	4SYVc7xvgJMip4EpCEri6/voYbtZXl2wQMMyCOrbNq0uUlYfSEcluHA9MKBEUaTqjhzfqNKO+WD
	AzxZU49KaZe7m/CSg==
X-Received: by 2002:a05:6a21:4784:b0:3d3:ae50:97c8 with SMTP id adf61e73a8af0-3d3ae509971mr20102216637.21.1788114063191;
        Sun, 30 Aug 2026 11:21:03 -0700 (PDT)
Received: from debian.prasanth ([103.177.82.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f95a847sm21619480eec.17.2026.08.30.11.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 11:21:02 -0700 (PDT)
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
Subject: [PATCH v4 2/2] ARM: dts: aspeed: Add ASRock Rack B650D4U BMC
Date: Sun, 30 Aug 2026 23:50:36 +0530
Message-ID: <20260830182036.284736-3-prasanth.padarthi10@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260830182036.284736-1-prasanth.padarthi10@gmail.com>
References: <20260830182036.284736-1-prasanth.padarthi10@gmail.com>
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

Describe the BMC memory, SPI NOR flash layout, UART console, and
MAC0 connected to an RTL8211F Ethernet PHY.

The MAC0 RGMII RX delay configuration was validated on hardware.
The RTL8211F requires its internal RX delay for reliable operation,
while an additional TX delay is not required.

Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
---
 arch/arm/boot/dts/aspeed/Makefile             |  1 +
 .../dts/aspeed/aspeed-bmc-asrock-b650d4u.dts  | 95 +++++++++++++++++++
 2 files changed, 96 insertions(+)
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
index 000000000000..aa623f0ca36c
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts
@@ -0,0 +1,95 @@
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
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			u-boot@0 {
+				reg = <0x00000000 0x000e0000>;
+				label = "u-boot";
+				read-only;
+			};
+
+			u-boot-env@e0000 {
+				reg = <0x000e0000 0x00020000>;
+				label = "u-boot-env";
+			};
+
+			kernel@200000 {
+				reg = <0x00200000 0x00800000>;
+				label = "kernel";
+			};
+
+			rofs@a00000 {
+				reg = <0x00a00000 0x02000000>;
+				label = "rofs";
+				read-only;
+			};
+
+			rwfs@2a00000 {
+				reg = <0x02a00000 0x01600000>;
+				label = "rwfs";
+			};
+		};
+	};
+};
+
+&mac0 {
+	status = "okay";
+
+	/*
+	 * The RTL8211F provides the required RGMII RX delay. No additional
+	 * TX delay is required for this board.
+	 */
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&ethphy0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii1_default>;
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


