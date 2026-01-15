Return-Path: <linux-aspeed+bounces-3354-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBB1D46634
	for <linux-aspeed@archiver.kernel.org>; Thu, 15 Jan 2026 23:21:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsfB00RbDz2xqj;
	Fri, 16 Jan 2026 10:21:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1131"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768455097;
	cv=none; b=XAgiHulQoVFdZ6ze6drDImBfxE9i3CfBFZTgdAbzAW83Ct1PIrGC0zvF+Nzm9algm/DDxC5O7PsZVJ5qzJewX+uHxwMLmcSVaQpcvX63+Gyrn/RhSq/yN2FZLPX4o2U/zt+Cj9dQfXnpHRVBMCF5oX3VKTxy5c/HTm+6UuRDWcOsYgNyKeCC12ZBI0ERtb37cEuja96gtQ0DDMeKotziU2MhJ52Qk9vdpLA7/C7I7vty6UjX6uNZH0xswlZdL2l4kOhrnAv4HMs/A3eNYTdM1/fv7NmK9yLK8e5bR17JkPZWBC6oMO/upMbFqS08ob98KPjiqC8XKOgVXnRjtdG3Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768455097; c=relaxed/relaxed;
	bh=Q/7mz0mXjXA2DXkjO4TEuV+xqnNTQ2wbsC+8nrLSQPI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W/Y8wqh84b5pdyzNMk0Bd9AXMYgLCxtY0osJX+kxW5tw2e7c8dRZTNVYYAPBOdNH+5TL3XXbvXg+UiAUiqyySlHoktGwNqq0Mpf4ZHpFhCgEzwFJIp3eCUFb+d13ut05Rf4/KWfIug26kcwpXuLvVor5CuF/AS/pIjT3ZIimht1E4Kinep3sWpP85d6mcUNIl+DU+1wkHOh8qr+9lxarZO6yVoXtQ/6BL0zFdv2xcxcaMJ+AZHXqWSorntYdLAezCcmittRxy21BTgI5kgX89w9F1KDLMEbnEp8BSul8/dGfkresyzrYxM0aGq7tZOKTFW0Iiu2Kz6yLUqszW6fhEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=OjFuQc/d; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1131; helo=mail-yw1-x1131.google.com; envelope-from=anirudhsriniv@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=OjFuQc/d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1131; helo=mail-yw1-x1131.google.com; envelope-from=anirudhsriniv@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsBRr5YT1z2xHW
	for <linux-aspeed@lists.ozlabs.org>; Thu, 15 Jan 2026 16:31:36 +1100 (AEDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-78fb6c7874cso5325817b3.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Jan 2026 21:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768455094; x=1769059894; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q/7mz0mXjXA2DXkjO4TEuV+xqnNTQ2wbsC+8nrLSQPI=;
        b=OjFuQc/diRU3vskxolngjjJKCbb7eGQHE8UZY9XLIGMNtRNdh/LCnfiJ3rpMVSCy/T
         HIWoTZ3y6kVUBaDWQm6ao/wnNqhL3hf10BYFwewss6OyGkRuk8H2w1YLsZtFfhmJYskT
         cR4BgDR5aC+eMCESuIeC8ueFvoI8JE4UpRb74N83RnZUMVfkk1BiMv/qOYNkzPbi+yrD
         SdYmjHd3Q37gGlp5HOiD2RUFghF1/M5cxq3vqIC2+pYkKrIZ3N6kWken1jtLPmNul0cu
         jbFx+SPa8HRJFvGxb51deiJN6/BbjCQTrPXV/JFLgr9NytGbGfVXQg9thzJaM+24jzcy
         LCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768455094; x=1769059894;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q/7mz0mXjXA2DXkjO4TEuV+xqnNTQ2wbsC+8nrLSQPI=;
        b=IX9psmVhRN8fkQVIGQIvY+AFrhjNt1VRY+CntEnmqLNp4ArjDaj0YSadSp+Lwyai3H
         A89z95dNT+K6Hb+WN6RsQMzF7wsX+ePmnfabVuQ+9la52XxSrV4O4S5njyXZAkUtA4gY
         JAKJxnAFslaeHENEI6zOD0UfKqIZ7C2EzncOrYQI+9KD52TPdI6dnnc3qMfpxR0Pku1g
         a6p5Hlph0a4/mTZLCfPXHaAbBNTxGejpz3RRTE7M/kJWcy+sHYKgCvjvcxYJeSSEwl63
         mPt6h2yrrRnGkAmegNS0XTLS5NxP8ZSVspmzYtYbcb+Oq2B45UazLf/+f7gPx8EqKUUy
         BlLg==
X-Forwarded-Encrypted: i=1; AJvYcCX8M+EJAJQi4RzYpI4R7Cz5z5ZiRVaVHOEMzp9LF6c3yOazwbTqQv9VdIuFa0dAu/+ICPUzeyOEirc9584=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw2Ri2J2Xf3O08S4hfkI1behpslrHVll+yvezUJoflVUKDsvl6q
	LEICSyhfUhvIHsLyjQ5mIfSTsyX1ieXDNTrJcZoicFY8Lc9OnA29C0RO
X-Gm-Gg: AY/fxX65nWb6GB2zg7HPvJCsi/lDvpiQhSsdhnFGny8ysR+7hfQ6YYUbrgOk/dZsKsU
	y4InjaYS67thoC9ATbYs2QjMSlaaHaPsdmGchBwbyOH132P6Y3KayAnclIJU/vcCsgeMm3wU207
	5ayfWl87uPoxw84ogIARyxAnT/e173yQaNWWGdOyoUlEsbA3AoPwVPZ3tURhZf07rgrs7do+0xI
	u7opbbC7qbKKDUIMnSubwZvG4zJqwtBjCt6+/RnqIW7zxW5xazIm17NfSLwG0CT+euXrYrDSM3V
	yGeh11Q2zIAraLkn0PDRH0skqo0Dh9HFw9IL5mhk/SZTAsrp4kI5ru5de/ReFXcRsQ9SimyHNyN
	AX3boSi1upGIpker7FZCRFkdLi9RTWPfQHaVfrNKQyxvFD/tMdXh//XWqOPgd63ciJAvknlSxEd
	+f8l3e
X-Received: by 2002:a05:690e:1341:b0:645:5cb9:dbd2 with SMTP id 956f58d0204a3-64901b0fa1emr3887933d50.67.1768455094381;
        Wed, 14 Jan 2026 21:31:34 -0800 (PST)
Received: from [192.168.2.165] ([2600:1700:220:59e0::914])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-790aa553172sm99259437b3.11.2026.01.14.21.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 21:31:33 -0800 (PST)
From: Anirudh Srinivasan <anirudhsriniv@gmail.com>
Date: Wed, 14 Jan 2026 23:31:08 -0600
Subject: [PATCH v2 2/2] ARM: dts: aspeed: Add Asus Kommando IPMI card
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
Message-Id: <20260114-asus-ipmi-expansion-card-v2-2-12b72d20a9b9@gmail.com>
References: <20260114-asus-ipmi-expansion-card-v2-0-12b72d20a9b9@gmail.com>
In-Reply-To: <20260114-asus-ipmi-expansion-card-v2-0-12b72d20a9b9@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Anirudh Srinivasan <anirudhsriniv@gmail.com>
X-Mailer: b4 0.14.2

Add device tree for Asus Kommando IPMI Expansion card, an AST2600 based
PCIe BMC card.

Signed-off-by: Anirudh Srinivasan <anirudhsriniv@gmail.com>
---
 arch/arm/boot/dts/aspeed/Makefile                  |   1 +
 .../aspeed/aspeed-bmc-asus-kommando-ipmi-card.dts  | 117 +++++++++++++++++++++
 2 files changed, 118 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index 9adf9278dc94f84653775296c93150e61cc99328..f599a3e61dd1ae69a133f2b9ea3a90da699f2f18 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -14,6 +14,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-asrock-romed8hm3.dtb \
 	aspeed-bmc-asrock-spc621d8hm3.dtb \
 	aspeed-bmc-asrock-x570d4u.dtb \
+	aspeed-bmc-asus-kommando-ipmi-card.dtb \
 	aspeed-bmc-asus-x4tf.dtb \
 	aspeed-bmc-bytedance-g220a.dtb \
 	aspeed-bmc-delta-ahe50dc.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-kommando-ipmi-card.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-kommando-ipmi-card.dts
new file mode 100644
index 0000000000000000000000000000000000000000..ab7ad320067c1ddc0fea9ac386fd488c8ef28184
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-kommando-ipmi-card.dts
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright 2025 Anirudh Srinivasan
+
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+#include "aspeed-g6-pinctrl.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+
+/ {
+	model = "Asus Kommando IPMI Expansion Card";
+	compatible = "asus,ast2600-kommando-ipmi-card", "aspeed,ast2600";
+
+	aliases {
+		serial4 = &uart5;
+	};
+
+	chosen {
+		stdout-path = "serial4:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-fault {
+			gpios = <&gpio1 ASPEED_GPIO(C, 5) GPIO_ACTIVE_HIGH>;
+			label = "panic_amber";
+			panic-indicator;
+			default-state = "off";
+		};
+
+		led-heartbeat {
+			gpios = <&gpio0 ASPEED_GPIO(A, 7) GPIO_ACTIVE_LOW>;
+			label = "heartbeat_green";
+			linux,default-trigger = "timer";
+		};
+
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
+};
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


