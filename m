Return-Path: <linux-aspeed+bounces-4046-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253F6CD4F3C
	for <linux-aspeed@archiver.kernel.org>; Mon, 18 May 2026 03:46:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJkHm1wknz2y7Y;
	Mon, 18 May 2026 13:46:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::532"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779075303;
	cv=none; b=k5+BecM3VFZPTZTu8vg/s+VTP2EDQePu1PPJXZUVAQ+kqSctH5AbEFYnVpT/OiT7awEec4pgi3f6Na6FllVf3ZnKIl08qvCX0Qr17wkTWLDgDI3Le5BQKF1Dz4LJuNcP9gaXO9arg3WMFnzZEbeGiBhlAbmApAy0TI/cJWHwB4zXKKv/qSqUhzLc2elD/vGWfLU1Rg91yGqx9iLK2JkCfHSW9tiOdMMQ4P0iZJ39C49jL2Ns3YkRD0jnrn8j0jKi1dMDYM6x5sGp1bH8nLKkKi4HG+bP38o5+tWymEubpF0aD9jIr47ubMkiHI7zj30Z7deKCcewLiDmanVSKhm05w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779075303; c=relaxed/relaxed;
	bh=6jXpVG+8ZsYwGlksykpzEGGE3bxY9VynddkEfoK9K2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BSrBYmWI1+H06z+FGFkQ14AyrQX0AuavnYcPOnAqDzluulJVUxKWinCNgXz4PR5ax4Tgm/LTdgLttd59pCOMVf2tMUqfjR8b8ziV+8/jNPjKXallGLDJPE+NyhYq6kzUdwW4KnOTVLGbwFFZYjFZeWSLkpdSmmCKsl+uJBTCqHOFKnKh3ViF5KamqwLJhX5HjU0qIzQjW/udRyI7gfqNefkHqLdApvfmqQOQL+Wl9esUGTVffXgUjwoqYMjZeeisnBqkpuMU6/MAcbOMSHUCvHqbPKFWx4nUiezAw/QdhJdVWhCHQXFD4CjywPMd/0X+AjQhkUcz3KN7gJVcNbP5XA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Q2aPEv5v; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Q2aPEv5v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJk2b0Vflz2xRw
	for <linux-aspeed@lists.ozlabs.org>; Mon, 18 May 2026 13:35:02 +1000 (AEST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-c80170db7d6so661654a12.0
        for <linux-aspeed@lists.ozlabs.org>; Sun, 17 May 2026 20:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779075301; x=1779680101; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jXpVG+8ZsYwGlksykpzEGGE3bxY9VynddkEfoK9K2I=;
        b=Q2aPEv5vO5TT5hg8DIE2TsDP8J0Q4gSmUSv3xEofpPvoACFQG0qtRd2b9JhXu5idbw
         7T0fBEvNWSp3At9EDh4hy91VlomwTOr0aBKhPyGrUeTp7q9GB9O+uVoELxiPSFNY/gnk
         8hhXO60TUTrd21ECwa/9PuimgxvdfiY7l3Q0EabdQwY7OcY/sVwpC4kOnLYJz21EO3gg
         gps3VBmlry3mLT/Pl1zZAsS0MJxiq0Fh77x13ymHrhqcoEHRRTKSSkHxZnA50NcnntHP
         8OeSMdOdstVQqOQ287Fydm3NOdsUDokSnE3GtgJkV0iqkmryKzNXE7p+kWtyyzodCfXA
         O3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779075301; x=1779680101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6jXpVG+8ZsYwGlksykpzEGGE3bxY9VynddkEfoK9K2I=;
        b=b12pAlySw7HlkfNkeULX4uESXIWjmCn5ym2rGi70KDh6hPh243NU+Y/pAMOXlX4BJb
         MPTKoXoPCqwse19nbmXJQay8bzc2SBAwyCMeKY4odz6Zr39uyXuSS+pMWSqoIBkWRGde
         T+tAM0HhDnigfgwCF6Sd3rAuDn8TEfZs8GuUhvKwumpz2TIAznb8vQwTeYhAWgUNgeSL
         67mNy8vDwhcuxtMHbsEj5PwAq7txH1DK1DjWldq/IRgjrTQZHkB7EKDZnuKn8m165jbc
         QrK5SRmKOtwKfW2Ne/eKKnQaFhTQEqr+ClxSXJQR21GdQk0SJYtI2izzgMIQoVsbskoz
         JlBw==
X-Forwarded-Encrypted: i=1; AFNElJ/+QmW2smEfkBWxLVxwEOd+hvW5DLBQsQfSsspU9gVptz3aHPGbJA22fnN5PTfRMXmTwfOYe7VIBhBLdBM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyPmT65OJPwXxpomMatHKk3GMOP/4501GfL+gbSIZ42PaBVSYD5
	1JNR7Xc5Oh08PfBuVC8utxCyekka9ukHItI1NPo0dYMq8QmMa/lXolEc
X-Gm-Gg: Acq92OHRO40RsHr3oHN7CqWKrd9eZfehCwJNXRAC7WQj8MEa48CSDzQusaZluRnosFk
	BrkvY1PMobL2PX1Na/tpZR5YIiaGpRLCZXhXA4La7Y5pT69G+S5t4Sn1SWxj54JXbWYXWUzt+k9
	nZh/6wgiJj6AdIG0al6PS5jxxdkvhDTqz0Blj9JHBzpeMjUEXddlpLv2wo49UVBEUZe2nS5CjZ5
	ZPfNAzImpY5MSBrvVBCQ+gKmiUtRXw8ugxjKk1vnUFJCDIiUB/BivS5bvJSGB7/OhhNX6//0hGG
	IOdWyKB2fc4v3L9l0nWVzitADNNwg9ay46YI7wybPe1VoVmYSlQBhV5PAPKV5UHy5b2z2zr+906
	PoS5KlgtaAdv4pB1mrEcsRdO5v4EDterG+XN79zEHBy/ZZOaICoL4d3iT+05uq4bN499PAWn13E
	LwQh9XEWN7wPpUKyAY/YGSykNvhRLAvAdtQ3enHIgo
X-Received: by 2002:a05:6a20:7d9d:b0:3a2:ebfc:6bf5 with SMTP id adf61e73a8af0-3b22ecf95f5mr13854841637.52.1779075301001;
        Sun, 17 May 2026 20:35:01 -0700 (PDT)
Received: from debian.prasanth ([103.177.82.201])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82c4031662sm11183717a12.16.2026.05.17.20.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 20:35:00 -0700 (PDT)
From: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: andrew+netdev@lunn.ch,
	devicetree@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Subject: [PATCH v3 2/2] ARM: dts: aspeed: Add ASRock Rack B650D4U BMC
Date: Mon, 18 May 2026 09:04:40 +0530
Message-ID: <20260518033440.17569-3-prasanth.padarthi10@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260518033440.17569-1-prasanth.padarthi10@gmail.com>
References: <20260518033440.17569-1-prasanth.padarthi10@gmail.com>
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

Add initial device tree support for the ASRock Rack B650D4U BMC.
The B650D4U is a server motherboard utilizing the ASPEED AST2600
SoC for management.

Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
---
 arch/arm/boot/dts/aspeed/Makefile             |  1 +
 .../dts/aspeed/aspeed-bmc-asrock-b650d4u.dts  | 71 +++++++++++++++++++
 2 files changed, 72 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index c4f064e4b..124d4f8f8 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -13,6 +13,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-asrock-romed8hm3.dtb \
 	aspeed-bmc-asrock-spc621d8hm3.dtb \
 	aspeed-bmc-asrock-x570d4u.dtb \
+	aspeed-bmc-asrock-b650d4u.dtb \
 	aspeed-bmc-asus-x4tf.dtb \
 	aspeed-bmc-bytedance-g220a.dtb \
 	aspeed-bmc-delta-ahe50dc.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts
new file mode 100644
index 000000000..daa8b25e3
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts
@@ -0,0 +1,71 @@
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
+};
+
+/* SPI Flash Management */
+&fmc {
+	status = "okay";
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bmc";
+	};
+};
+
+/* I2C Bus for FRU/EEPROM Storage */
+&i2c7 {
+	status = "okay";
+	eeprom@57 {
+		compatible = "atmel,24c02";
+		reg = <0x57>;
+		pagesize = <16>;
+	};
+};
+
+&mac0 {
+	status = "okay";
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&ethphy0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii1_default &pinctrl_mdio1_default>;
+};
+
+/* Dedicated management LAN via on-board discrete PHY */
+&mdio0 {
+	status = "okay";
+
+	ethphy0: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+	};
+};
+
+/* BMC Console UART */
+&uart5 {
+	status = "okay";
+};
+
+/* System Watchdog */
+&wdt1 {
+	status = "okay";
+	aspeed,reset-type = "soc";
+};
-- 
2.47.3


