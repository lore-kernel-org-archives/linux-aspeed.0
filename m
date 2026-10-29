Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D231B606A31C
	for <linux-aspeed@archiver.kernel.org>; Thu, 29 Oct 2026 23:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bxkqMRVf
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jG0RT56qvz30Ng;
	Fri, 30 Oct 2026 10:14:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1333"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793315653;
	cv=none; b=Z96bpg0oPJTgos8jo2f41DcyvLRLI9PV6y4LLXrhJssv6pDBuTfcmdMMN2rTv/vLVp6n/8Z1yTOBRABwJc7YTbeTDNwXuhtP7Fr06NaiobZbqGVGpGMNlHlWss1sl//uCtE/jwtJ2O+rhuElydB/0uu76FZiKp5XfRD0mkVxmRAjeGjlRkT6cexjJuRILbYOAXLAzwUB6pUiw3DxpxsuV6KyVKG+0TKGC8x2wtnXyA5TpNOdu1+31wK0Ng8QOdRpESS6OvMMl/luHPZD8XR3NEXBIbAK8W4OVja7X5q6Kn5ytSvz6pxgplyH9b6bQcNh7WUDbGb7D1bIg+WqlQt4iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793315653; c=relaxed/relaxed;
	bh=LYtNSjgV58xGbyTo5mnS9fU4iYF6Ei0AnGKD6L+FOdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVGWaYqS8BMLQfMsbsB2mSVoWn7a1C1rQf5p6zRC0oNGIMCbV7aUSY+LwmYkuuw24euXYtHPFvsZSZd5/qSzHoId/+HXiyOQfE1Rhgd2wfMcvj2OIKmqXYnloU2jVe+cQlwCCsk87W0AoxtRUC8LFCdyFi/+do6vT/EUXwJ3UNlLIDsBXs4jYWJOiESPTwszQM8nY62PlTb0upELs8BlYCxjuX1YVnrVqzAI7Djpw96ooVD+1XYSeHRpiK7OtQjGU8a5GYH3EH+MIYBYrJnAkIfeGw1cItwrdixUMRKcTDGrf2T3qjxZPoOi2quHi5JVjCmsLEAj6Xp7hkiHUpDOww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bxkqMRVf; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bxkqMRVf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1333.google.com (mail-dy1-x1333.google.com [IPv6:2607:f8b0:4864:20::1333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jG0RS4mvKz2yql
	for <linux-aspeed@lists.ozlabs.org>; Fri, 30 Oct 2026 10:14:12 +1100 (AEDT)
Received: by mail-dy1-x1333.google.com with SMTP id 5a478bee46e88-35c76e9614aso285799eec.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 29 Oct 2026 16:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793315651; x=1793920451; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LYtNSjgV58xGbyTo5mnS9fU4iYF6Ei0AnGKD6L+FOdI=;
        b=bxkqMRVf0PXA+CBGTOKmiQCpXKOgatNMesHAo7LPxXGBA7S3Pg4YChbFLNjouJbbf4
         QDRkrIwz/96hR5s7SIPfwJWPYvdQ4r24og+r75SvaohsjM/lcIibF4Llpvf710occmxR
         h8ED/251HwVdO8ieHEthTJNWGp/jQSSCFIHkx1rwOWXDoqPsbFHOuU1aA77HFkgt+puk
         9mIp0/W1ZJqiAsiTZBS/RQyG2cfxlFpE+pkFi9xZ7F81QYDHHlvhyNMzCyqrm0OJ2cyH
         zHZ9d5aiECqEf1mOP/yBbSJIl0LOg2b5ByUavLus1wEThwhaTUI4gn/gi+Br1By/8wiU
         f2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793315651; x=1793920451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LYtNSjgV58xGbyTo5mnS9fU4iYF6Ei0AnGKD6L+FOdI=;
        b=B5uICm4oeCMBK0dFAXzJv2TbgErhl5MNsm+ExU29JiBEzjrfQ0W1Dj9gQdBdnjN4NT
         SEYLBLCHe0G1PcTbfKlqHLERROBWliBOkZFw336jaj52naM+r5RUnu/uvRLkSeA4aGvc
         TYKaXqwSYLgI98zH5iGvaaBntml9OZDAIe6DxKB6oBQxjEM34s5nAPpSn3s6s8q3XoPk
         RhCY1Nqv3pm4skrMyiRngyceNKe0fDDIZoSNQ8y2wrPCol9DpLNqWSpjzzf8TfFuLD6P
         cVd9qXno0wQ9oXU1G8FKPSO+pe+DNpQDNoIUfHjPZJZm4Dj2oTT/rpa9uIGIdJvKmyOE
         wKnQ==
X-Forwarded-Encrypted: i=1; AKwUvBzBfjXwhwzYyAdP0GL8200bZSIGM3BOP+ByQlng9mgU1BPF0D7XdbN1TZbUJQLK1UbrXskDIUPj4/ZOCjg=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYI++FsweW8x9Nap9ginqvTC//zPq0Pk+HVBuzlxJVOgBgauYnbH
	EUUmQXHGUms/HdNlOrY0PTeEg9Lf4yam1YoHbyafa8KsilGHg4Flya/z
X-Gm-Gg: AYBFou1b213U00EhBtvkgbRhU6lTFumLcdHkFAH+hXPw85S1f/iXaquY0D9igJxh5MD
	6WwjenNt3sTdh+X9gPlzTs4t7BF8w/BGjdGjPL+wQSIxfdb6VFgHcmCC8ocqLLwz+DmwIFvgXWO
	zNy2IWJVKzKGlA9VfQFQn4aPOWRFwMIFpNk94c4xGUg4M8CClXvxeiV+jH05KvnBP6lw4uHTD47
	l9+OboMQgUJTn/7JiMMSL9dW+hhQWc9F/qlzvnwoQaxOSCPfCpv8wfsEMkv1x7NrUXK2qbNFy57
	iNaEhHCX30kc+VimuVe2uF/gnjaX96teupI8Evhe8W9fVddGGwoUiZwLASRx9NAaRFlqbqQeaXH
	RyUOAsvkK11VFyewxwh1vtBqv1IQfJ3wJ/hW6FhPqTGQsGaEMXEUHJ4dOm0gztDgcz7Jd/s4N7d
	i9ohoW44W/vsQsNQUk5pagaM/elEHEHiSEyykEVD6afrgZRdi6fX02XjyqQdbTb8gh0NCDMgMXO
	d402xjSOEM3CpXSB16UZCblW+eSLZPJ5oJwgp9RV2bh4ThvAzcROL1BqYTwwb3mY/0egKFsvykD
	g+0eWkVMq3lOJxiS59yl8j3Tplwr0FGRtdpAE43mGgOXQA==
X-Received: by 2002:a05:693c:41c8:10b0:367:185e:867a with SMTP id 5a478bee46e88-36a4242366fmr1174193eec.38.1793315650617;
        Thu, 29 Oct 2026 16:14:10 -0700 (PDT)
Received: from debian.prasanth ([103.177.82.12])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af1dfsm1662742eec.7.2026.10.29.16.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 16:14:10 -0700 (PDT)
From: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ryan_chen@aspeedtech.com,
	billy_tsai@aspeedtech.com,
	tan.siewert@9elements.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	andrew@lunn.ch,
	Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Subject: [PATCH v10 2/2] ARM: dts: aspeed: Add ASRock Rack B650D4U BMC
Date: Fri, 30 Oct 2026 04:43:39 +0530
Message-ID: <20261029231339.9497-3-prasanth.padarthi10@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261029231339.9497-1-prasanth.padarthi10@gmail.com>
References: <20261029231339.9497-1-prasanth.padarthi10@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the device tree for the ASRock Rack B650D4U BMC, based on the
ASPEED AST2600 SoC.

Describe the BMC memory, SPI NOR flash layout, UART5 console, GPIO
line names, graphics memory, and the EEPROM on I2C7. Use the EEPROM
as the NVMEM provider for the MAC0 address and configure MAC0 with
an RTL8211F PHY in RGMII-ID mode.

Enable both ADC engines with 2.5 V internal references and expose
the sixteen channels through an IIO-to-hwmon bridge for board
voltage monitoring.

Retain the SoC's serial4 alias for UART5 and select it as stdout,
without adding a second serial alias for the same UART.

Reviewed-by: Andrew Lunn <andrew@lunn.ch> # MAC0 and MDIO nodes only
Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
---
Changes in v10:
- Use the inherited serial4/UART5 alias instead of duplicating it as serial0.
- Consolidate root nodes and fix peripheral/ADC property ordering.
- Keep ADC settings and MAC0/MDIO semantics unchanged.
Changes in v9: enable ADC0/ADC1 and add the ordered IIO-to-hwmon bridge.
Earlier history and testing limitations: see the cover letter.
Previous series:
https://lore.kernel.org/all/20261027034911.99482-1-prasanth.padarthi10@gmail.com/

 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../dts/aspeed/aspeed-bmc-asrock-b650d4u.dts  | 169 ++++++++++++++++++
 2 files changed, 170 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index 6874b621d..fcb94e62c 100644
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
index 000000000..522c4d53e
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+
+/ {
+	compatible = "asrock,b650d4u-bmc", "aspeed,ast2600";
+	model = "ASRock Rack B650D4U BMC";
+
+	chosen {
+		stdout-path = "serial4:115200n8";
+	};
+
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
+			      <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
+			      <&adc1 0>, <&adc1 1>, <&adc1 2>, <&adc1 3>,
+			      <&adc1 4>, <&adc1 5>, <&adc1 6>, <&adc1 7>;
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
+&adc0 {
+	pinctrl-0 = <&pinctrl_adc0_default>,
+		    <&pinctrl_adc1_default>,
+		    <&pinctrl_adc2_default>,
+		    <&pinctrl_adc3_default>,
+		    <&pinctrl_adc4_default>,
+		    <&pinctrl_adc5_default>,
+		    <&pinctrl_adc6_default>,
+		    <&pinctrl_adc7_default>;
+	pinctrl-names = "default";
+	aspeed,int-vref-microvolt = <2500000>;
+
+	status = "okay";
+};
+
+&adc1 {
+	pinctrl-0 = <&pinctrl_adc8_default>,
+		    <&pinctrl_adc9_default>,
+		    <&pinctrl_adc10_default>,
+		    <&pinctrl_adc11_default>,
+		    <&pinctrl_adc12_default>,
+		    <&pinctrl_adc13_default>,
+		    <&pinctrl_adc14_default>,
+		    <&pinctrl_adc15_default>;
+	pinctrl-names = "default";
+	aspeed,int-vref-microvolt = <2500000>;
+
+	status = "okay";
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
+		/* A0-A7 */     "", "", "", "", "", "", "", "",
+		/* B0-B7 */     "", "", "", "", "", "", "", "",
+		/* C0-C7 */     "", "", "", "", "", "", "", "",
+		/* D0-D7 */     "", "", "", "", "", "", "", "",
+		/* E0-E7 */     "", "", "", "", "", "", "", "",
+		/* F0-F7 */     "", "", "", "", "", "", "", "",
+		/* G0-G7 */     "", "", "", "", "", "", "", "",
+		/* H0-H7 */     "", "", "", "", "", "", "", "",
+		/* I0-I7 */     "", "", "", "", "", "", "", "",
+		/* J0-J7 */     "", "", "", "", "", "", "", "",
+		/* K0-K7 */     "", "", "", "", "", "", "", "",
+		/* L0-L7 */     "", "", "", "", "", "", "", "",
+		/* M0-M7 */     "", "", "", "", "", "", "", "",
+		/* N0-N7 */     "", "", "", "", "", "", "", "",
+		/* O0-O7 */     "", "", "", "", "", "", "", "",
+		/* P0-P7 */     "button-reset-n", "control-reset-n",
+				"button-power-n", "control-power-n",
+				"button-nmi-n", "control-nmi-n",
+				"", "",
+		/* Q0-Q7 */     "", "", "", "", "", "", "", "",
+		/* R0-R7 */     "", "", "", "", "", "", "", "",
+		/* S0-S7 */     "", "", "", "", "", "", "", "",
+		/* T0-T7 */     "", "", "", "", "", "", "", "",
+		/* U0-U7 */     "", "", "", "", "", "", "", "",
+		/* V0-V7 */     "", "", "", "", "", "", "", "",
+		/* W0-W7 */     "", "", "", "", "", "", "", "",
+		/* X0-X7 */     "", "", "", "", "", "", "", "",
+		/* Y0-Y7 */     "", "", "", "", "", "", "", "",
+		/* Z0-Z7 */     "", "", "", "", "", "", "", "";
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


