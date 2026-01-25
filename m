Return-Path: <linux-aspeed+bounces-3429-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6512FD19520
	for <linux-aspeed@archiver.kernel.org>; Mon, 26 Jan 2026 22:56:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f0P6J32R1z309C;
	Tue, 27 Jan 2026 09:56:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1134"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769374854;
	cv=none; b=EQuOy8Zzl639Oc5HT5yf4oVhZmNrETJZOdzHlT1PsP5zarIeHagvvYDwIAtZesfj6CVYJhOdcInM17vhvRH+InkqpqHJNUoAmf/M4sF9pR1HSATkvNkCepdoX/cwjaTKx6Afw2w7Gk9XaiROfZkfd7CHqrwmthC5WMPHSAQSlIqHbvegFTYxtKol40cwUFQPzQyqktikCjZQh3lxXN8Uo04KE/lp9LPaCMzirJUe8aThSyrx30OBz6YZxa48XPv9vdOzRzrPuRKj2ujllwRnvXIEnLzYlWEVDA1EOoChO0pd9luuq9KiFfDBlKN7fABccAEEKSh4e1s0szLa4Q3QDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769374854; c=relaxed/relaxed;
	bh=zNMUkIoLTalpAd3ZRQES5uiVuV25MXRQWddLJpJTYAY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M6G4To/EFxc1MXYPE+DLrf17nW+X8/iBjULY0a1jXP3+ejMjxRVV7Qe1DEfsKmH2BbxjPEbgJ/iU8teSnVDPIHB1/XDOGN210i50KhX6HjwyjMhrnlRKON5y7UQPW4WF2Sle4mwyfKobLVO2T75u4J6BtLVkzVpTWM1hGp5pvc6n0fhpY+3sRtbbIAnXzgtf6jLeRtbLavn5uUHRtImt7JZE/rhv/S18flR3xhYhe1H82bibD4zCKBPunACdlg+jvwuNkXQosgU4aH05DemManN/lAd9sFn3U6CTT5YOcx+hX7MwhZX2VQiiFvIh8O1I7HGuphhgZmfoBQRtNFTnpg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dWLhNqRQ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1134; helo=mail-yw1-x1134.google.com; envelope-from=anirudhsriniv@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dWLhNqRQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1134; helo=mail-yw1-x1134.google.com; envelope-from=anirudhsriniv@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dzkbS4vkFz2xQD
	for <linux-aspeed@lists.ozlabs.org>; Mon, 26 Jan 2026 08:00:52 +1100 (AEDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-790ac42fd00so38614987b3.3
        for <linux-aspeed@lists.ozlabs.org>; Sun, 25 Jan 2026 13:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769374850; x=1769979650; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zNMUkIoLTalpAd3ZRQES5uiVuV25MXRQWddLJpJTYAY=;
        b=dWLhNqRQ2+y0klMOYlZdJivedocnzN0HzUE6FLh/ZF3ZVgvP2xHHS+1U7ldlPnDwMw
         oJf4HMIWdmodxQmpDn2JAfG6epWoC96UcW8qyidhs5mATR07oJmjg1Zn1kXzT9tZXgsk
         uvAETb4+3tKfPFjkdhVd184FMW2JFDyPUMs4u4caJm5tnmCkB68GpHH1oPQzoyS/+T4j
         js0UHhazQI2PaAx4aZdC+fOxNtxpU+YylFrG5vZPDc9SnRciF+LV2R7Dw4dezoaGgSOt
         6WFqfiYVo0XB7cUPEbinVRRIVDLLwz10AbfIscBZA19JB8cokOsdfvDRGHTuO1BKRcpf
         ijRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769374850; x=1769979650;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zNMUkIoLTalpAd3ZRQES5uiVuV25MXRQWddLJpJTYAY=;
        b=hpMyT/wg4tLA4xBzZRjEjh/2zqH9K7L027aHmXnRe0GkcdvzU3J27H54BAgTpwP5yL
         UsIAFJ0xBaasfeY+u4buY7I23b8uN8+F5U6HgXyU0uTDaG57YsGmtVQ8T0jj4Ppn5UUQ
         pSLXFcjVApNHdR3m2rqh3BpKtfyl2LPLea2iI1lagvf1lb5jvid5vYYucy+ZglO0ACsT
         elg7XNklJGPqNE231LNmrEr7FrPLlvTmMSVqkt4C5FxJFTfC/2fBR3v24upQI58ayGQo
         +EoWqpmvuN+/i7bd6VQkmparKQaIY6tkVMqpKGlChRR0YMEjmHadB77322Lq2zPU8xNH
         jY0g==
X-Forwarded-Encrypted: i=1; AJvYcCVQIE+7b3Y1RfL1kqIh5cfD5UQzo9sbR4wwkHXMcHqw+jTjn9MWWojlHq5S9mBuwYEEDOWJBI/4S53WBF4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YytFz5cwLbZHaXxeV/D14zsruyJ6xTSY8WwClcH4IMGfEXBxepN
	2uyZh8Fl5907YjEgdpNuPigg10IEsQSZItaIExJE+Okol8HafDnvqHHe
X-Gm-Gg: AZuq6aLLmsT3D87rNwjCpws8xHKg4GjwOqYelZGMOJ1JuZmZVFUovZTIlM8opa1v+Ib
	XhNrNDfX+H/zq44vJOqdEHAo742ignbXtNMHbocwPppmGElbsA3KAl0JQBdbXUqX/QnEj/K6Ymg
	WjbnCBbuNe+zuiKIvnQ/yCqWJkxDrJVANXiakFoYBqCTTzLUlAq8+2zQ6l4I1KEh17nyloom/Qu
	d+GNukjueL7OtMwIR1teChBY8fxEJNNIsWngxUOH23QP18kxcvyMeyl1YTANJkVm5yOvmGug9Er
	EqcX5OI6X9sOObyRruVlle4Dg2awRsQTtR5ggTQwkL5qfrJrCMhfzjc4r5+9Hmer9NgsBB276fV
	U4ZXtCP5ac+XFvFBrzMv7AwcGcKOndwbvbDoZDuYfxQKs273CZ8QUl/Xk01x8gm+sSqxc4YtCXP
	cJw9Iw
X-Received: by 2002:a05:690c:e3ce:b0:794:35b:af5e with SMTP id 00721157ae682-7945a86ee06mr44305837b3.5.1769374849589;
        Sun, 25 Jan 2026 13:00:49 -0800 (PST)
Received: from [192.168.2.165] ([2600:1700:220:59e0::914])
        by smtp.googlemail.com with ESMTPSA id 956f58d0204a3-6496855d65esm2518183d50.12.2026.01.25.13.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 13:00:49 -0800 (PST)
From: Anirudh Srinivasan <anirudhsriniv@gmail.com>
Date: Sun, 25 Jan 2026 15:00:39 -0600
Subject: [PATCH 2/2] ARM: dts: aspeed: Add Asrock Paul IPMI card
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260125-asrock-paul-v1-2-956085a4bd06@gmail.com>
References: <20260125-asrock-paul-v1-0-956085a4bd06@gmail.com>
In-Reply-To: <20260125-asrock-paul-v1-0-956085a4bd06@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Zev Weiss <zev@bewilderbeest.net>, Renze Nicolai <renze@rnplus.nl>, 
 Anirudh Srinivasan <anirudhsriniv@gmail.com>
X-Mailer: b4 0.14.2

Add device tree for Asrock Paul IPMI card, an AST2500 based PCIe BMC
card.

Signed-off-by: Anirudh Srinivasan <anirudhsriniv@gmail.com>
---
 arch/arm/boot/dts/aspeed/Makefile                  |   1 +
 .../aspeed/aspeed-bmc-asrock-paul-ipmi-card.dts    | 131 +++++++++++++++++++++
 2 files changed, 132 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index 9adf9278dc94f84653775296c93150e61cc99328..be3c84a8462353996e0503cd95326ed88f6b8723 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -11,6 +11,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-arm-stardragon4800-rep2.dtb \
 	aspeed-bmc-asrock-e3c246d4i.dtb \
 	aspeed-bmc-asrock-e3c256d4i.dtb \
+	aspeed-bmc-asrock-paul-ipmi-card.dtb \
 	aspeed-bmc-asrock-romed8hm3.dtb \
 	aspeed-bmc-asrock-spc621d8hm3.dtb \
 	aspeed-bmc-asrock-x570d4u.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-paul-ipmi-card.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-paul-ipmi-card.dts
new file mode 100644
index 0000000000000000000000000000000000000000..f74f8fee9e1edb6cc1c0a0aef1268bdf91fc03f7
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-paul-ipmi-card.dts
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright 2025 Anirudh Srinivasan
+
+/dts-v1/;
+
+#include "aspeed-g5.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+
+/{
+	model = "ASRock Paul IPMI Card";
+	compatible = "asrock,ast2500-paul-ipmi-card", "aspeed,ast2500";
+
+	aliases {
+		serial4 = &uart5;
+	};
+
+	chosen {
+		stdout-path = &uart5;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-fan-1 {
+			gpios = <&gpio ASPEED_GPIO(AA, 0) GPIO_ACTIVE_LOW>;
+			label = "fan1_red";
+			default-state = "off";
+		};
+
+		led-fan-2 {
+			gpios = <&gpio ASPEED_GPIO(AA, 1) GPIO_ACTIVE_LOW>;
+			label = "fan2_red";
+			default-state = "off";
+		};
+
+		led-fault {
+			gpios = <&gpio ASPEED_GPIO(Y, 3) GPIO_ACTIVE_LOW>;
+			label = "panic_red";
+			panic-indicator;
+			default-state = "off";
+		};
+
+		led-heartbeat {
+			gpios = <&gpio ASPEED_GPIO(H, 6) GPIO_ACTIVE_LOW>;
+			label = "heartbeat_green";
+			linux,default-trigger = "timer";
+		};
+	};
+
+	memory@80000000 {
+		reg = <0x80000000 0x20000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		video_engine_memory: video {
+			size = <0x02000000>;
+			alignment = <0x01000000>;
+			compatible = "shared-dma-pool";
+			reusable;
+		};
+	};
+};
+
+&fmc {
+	status = "okay";
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc";
+		spi-max-frequency = <50000000>; /* 50 MHz */
+#include "openbmc-flash-layout.dtsi"
+	};
+};
+
+&gpio {
+	status = "okay";
+	gpio-line-names =
+		/*  A */ "", "", "", "", "", "", "", "",
+		/*  B */ "", "", "", "", "", "", "", "",
+		/*  C */ "", "", "", "", "", "", "", "",
+		/*  D */ "", "BMC_PWRBTN", "", "BMC_RESETCON", "", "", "", "",
+		/*  E */ "", "", "", "", "", "", "", "",
+		/*  F */ "", "", "", "", "", "", "", "",
+		/*  G */ "", "", "", "", "", "", "", "",
+		/*  H */ "", "", "", "", "", "", "BMC_LED1", "",
+		/*  I */ "", "", "", "", "", "", "", "",
+		/*  J */ "", "", "", "", "", "", "", "",
+		/*  K */ "", "", "", "", "", "", "", "",
+		/*  L */ "", "", "", "", "", "", "", "",
+		/*  M */ "", "", "", "", "", "", "", "",
+		/*  N */ "", "", "", "", "", "", "", "",
+		/*  O */ "", "", "", "", "", "", "", "",
+		/*  P */ "", "", "", "", "", "", "", "",
+		/*  Q */ "", "", "", "", "", "", "", "",
+		/*  R */ "", "", "", "", "", "", "", "",
+		/*  S */ "", "", "", "", "", "", "", "",
+		/*  T */ "", "", "", "", "", "", "", "",
+		/*  U */ "", "", "", "", "", "", "", "",
+		/*  V */ "", "", "", "", "", "", "", "",
+		/*  W */ "", "", "", "", "", "", "", "",
+		/*  X */ "", "", "", "", "", "PCIE_STNDBY", "", "",
+		/*  Y */ "", "", "", "SYSTEM_ERR_LED", "", "", "", "",
+		/*  Z */ "", "", "", "", "", "", "", "",
+		/* AA */ "FAN_1_LED", "FAN_2_LED", "", "", "", "", "", "",
+		/* AB */ "", "", "", "", "", "", "", "",
+		/* AC */ "", "", "", "", "", "", "", "";
+};
+
+&mac0 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii1_default &pinctrl_mdio1_default>;
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&vhub {
+	status = "okay";
+};
+
+&video {
+	status = "okay";
+	memory-region = <&video_engine_memory>;
+};

-- 
2.52.0


