Return-Path: <linux-aspeed+bounces-4017-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF80CD343F
	for <linux-aspeed@archiver.kernel.org>; Wed, 13 May 2026 00:04:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFYcK6c77z2xrC;
	Wed, 13 May 2026 10:04:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778608243;
	cv=none; b=fa0v67snwJAFqSEX1q6EprHLhUaNYRONewQ0FDjdMy7o/fSvFOJIky2dsQkUONCHud4V7QSrRN8s3tzMwv30829jbcAJi+g4ZD1eepbi9VAY6mU9BDs/CiIxK6yK640/A8xFl6UdLsuRUYh9tKMt3aT7Oxob8jnQAbyRd2x5qTRnItvz66Zr4zmuOZFWn4+1vbiNQwu7RLDTJJsnftuOXWIYU2mCANeJhxhdymFX9GpgC2UKtSwnzpb0s2914Qdt/C87Sj3Qk0eU6iGuNgMsFjA8rRofHeibUFWKqVbCJYlzDnYnd84MrEgK9aOYz+ZQxlNCvrX07j+vTkpat437kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778608243; c=relaxed/relaxed;
	bh=mwNscldXuAtscs8D5M0IBqKy8TvTXmFs8KiInOYeroc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ao2Cq04Rbbv2H5hZe4yg6uBEAoPThg1EVnzIKB9vdL/cxtQHSoIkpJQH1WBndbUqTUlfV3jusLjjHZZUoe/HX51W7os/TwNMyEmMFME7hb+9DYGiX7n4Vc3FrxXEc2gv9NWdmBdck5X5QAoo8U3XNNirPA73eI/fe135ul+Cgpfn7Rt71s2ZoJD1ruwYEpjFpkQ1QKrmOMqzEPWBIkWlVGC0wBMDC5xv4oqeR7TfXEck5FoUAVgBuPZUoEl7tkrbgC2jjFLVLKlR8il3ebRzSSw5NbRBDSP4t1k3nUl3yfVwOvfpZ1gymFDB06bUOObOKTsQeLE7hR9AUFQWreQP6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c8sUcPyS; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=c8sUcPyS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFPJf2qQlz2xb3
	for <linux-aspeed@lists.ozlabs.org>; Wed, 13 May 2026 03:50:42 +1000 (AEST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-c82a6278a4cso625373a12.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 12 May 2026 10:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778608240; x=1779213040; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwNscldXuAtscs8D5M0IBqKy8TvTXmFs8KiInOYeroc=;
        b=c8sUcPySPYT2Ogh+x9iDArrd7YKPwnM1BfhvECnfN85M9MaQ/KNbu82OeQ4o5OhnUy
         b+dMIAAXcxEDrOWAuMPi3F5ptFNOYlH1mc5heSpyYQebGZ/H0bwXN4dXmVfT0USRj5Xu
         3OscNi87G9cbjllLToeQtN64BwjPnk7H6hfB4FSWcD20lu4Ghu6e2m79oKBZUWYlltK+
         1NUxaJZWF1Ydi7zl7U67+CkF0buZ7yyPRHYtMW9B/BWMkQ1dbPdEItYgXEopp+zPUHSK
         pDVMwhmMRStJVvl6RRZ7Gwq2AsMw2VdqbJfE+5RUvRlFnIze3pZLPuETcZ/1epPYO7ZH
         PqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778608240; x=1779213040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mwNscldXuAtscs8D5M0IBqKy8TvTXmFs8KiInOYeroc=;
        b=ShzTeAofBzmSbfxNm1z9zX8Po6wF74mZ8wx6pp6OImihiBpmrBzSlnhK9LvP/jXPCd
         scxzI9V0QEtMZwbtq4Q9d4z6D2pE9RjHLz3QJoEbf3YDUVrO/MmLStBAoXosnjudsmSi
         G2WbWrVNSET5W/mIAHU49etoBmG5Sd96thkIHUGhu3uggIwISb0mai/QT9r5dPDBnHvc
         Oz9Civ9GJZ0MSDhZUqx1bH2TGbC+954LUfTzu6+GT5xq/LBt5rOYrJ/o1TJYWNERJlbc
         M6+4sdYajsieMyb7AZeE9PH0OMyrfV0cK7+x0fHHKjNw4SH36n5tImY+/xOhm239oSzL
         hOOQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ehmUA9sVD5QNvuREvc58pvOCqgpDox6CNcWvCgCn1a0oMRcg0figLMkmvFz6JXv98pwdPyNFab0jT64U=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyNrCterPh+l7E8vpclHFWyNCr8cxf2xN1EdaqExSvdrTCS58Y3
	LTnoyk0qG/IvmCZkK9sDzh+E6P2r43DXYbm5ZegP0PzFNdGWr7tLVHJB
X-Gm-Gg: Acq92OGJL/bJyhm4oVcYSWPnN4XX6oevwa16rLuSu5wKnvl/DDl15x+ZNzGaXOCSnTI
	jQvr7c1SOVNxoU1qebtEKcpObIe/RMxXePehPKAW+nyu4K7xuJw8MoB+GvWjhzHjIPe374jk1Rx
	1oYBqZ9bvv3Kwi3XJUUczKkxrhFiKrkPwthKBTTJkCckKzJGYsE+CPeO/kxCrCkruvRfCfu3Ba4
	cSaNB/N1UMFqYIl8HHSYAOky9nylJNyKtN+/0Z1Uneyuclg7kEGnw3yUMivoeA66mmSGuqJhj8P
	KiVN2zwPWr8in4adipgLTIPq+I3lFvkOLkEGko83i7hLx/dqTVl5eJd31DBG5/Qq3MGX59VJaIC
	7xTIA42qhmGbKAxve9nkvhVu3FNy63K0l6wutdhuC+BsTM1CGJiepdf/KQkvQG3oFhGnyuK2EAy
	rfl0umzIStAxUsUskS0bbMGS9lQJ1RK49QTHYFdqZJ
X-Received: by 2002:a05:6a20:748a:b0:38b:eadd:449a with SMTP id adf61e73a8af0-3aa5ab66e31mr33083918637.38.1778608240549;
        Tue, 12 May 2026 10:50:40 -0700 (PDT)
Received: from debian.prasanth ([103.177.82.138])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839682a20ebsm24838732b3a.53.2026.05.12.10.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 10:50:40 -0700 (PDT)
From: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Subject: [PATCH 2/2] ARM: dts: aspeed: Add ASRock Rack B650D4U BMC
Date: Tue, 12 May 2026 23:20:19 +0530
Message-ID: <20260512175019.47548-3-prasanth.padarthi10@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260512175019.47548-1-prasanth.padarthi10@gmail.com>
References: <20260512175019.47548-1-prasanth.padarthi10@gmail.com>
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
 .../dts/aspeed/aspeed-bmc-asrock-b650d4u.dts  | 61 +++++++++++++++++++
 2 files changed, 62 insertions(+)
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
index 000000000..d0b9c1e1f
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h> // Recommended for GPIO mapping
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
+/* BMC Console UART */
+&uart5 {
+	status = "okay";
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
+/* Dedicated Management LAN */
+&mac0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii1_default &pinctrl_mdio1_default>;
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
+/* System Watchdog */
+&wdt1 {
+	status = "okay";
+	aspeed,reset-type = "soc";
+};
-- 
2.47.3


