Return-Path: <linux-aspeed+bounces-1853-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93EBEC83F17
	for <linux-aspeed@archiver.kernel.org>; Mon, 28 Jul 2025 05:56:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4br75m2LXPz30WF;
	Mon, 28 Jul 2025 15:56:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753682204;
	cv=none; b=EvwBU+8rHw1CJV0aZ4ge1yjqntfsMmdaqjDtqp3ealtRaRhfQcSiaFTqp5Ku+1iYN+PgaE0dLMv5WRY1sdVesflhV8RVH5P8Fabb8ToIEP/UJ7c2xscN7jAMe+7xGgLxRjtSRW8tgBbkPNVjcNDzEXrQrzUpEI0+IQG/mK0Qma/hqhK+xpkpdiHAcFyXPh+w6BtfIudW6XFhCUBJQSyh2O2JGDZxmctv04wDcRFvZ+l9lzHbHegXnZwLKX2sVN4IasvXwnVqk3Bfi+TzZ1yG3qutsJ+e1R6q36751U4MqOYwVGEhRI4A0JU1JirQBX8eAxqle435w2IbWfzda5+2ng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753682204; c=relaxed/relaxed;
	bh=ZElVV0LR61vFRou/4QGyHqbGC1WySEH8A190BlUdXsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TDb3Ujjnb2+2pns4CSuQtuufzXjjBJVOdfwmNPIDq2+9V8PKf+uLZk7qehltPDUEkLtUYO43fmDYp7xr6ZlFP/AvCpIvnq4JPQzRyVYIHESv85dm4cDaZRoSYiJdAGyr7/rJSOmBAvAYt8wWFGJgi8ZOJZ+2rSycBnm5D+/4JYGtZ0VyYXdy7wFG+FAZXLJ4Oc0DKkUO1lQY7VPBsnsZuir1JogWKgBs4NWiNNwMLogNSZOf6IZYQSVE3HfgKwqUOsqvDlMrKiyUWmJwFDVUNqaAnv6ONROiTUFjFoxrHEslSa5J/1cWTGrEGK9soQiY1OxDm+teY0nUCEOBIG+gug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RsaAUhPL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RsaAUhPL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4br75l1tpmz307K
	for <linux-aspeed@lists.ozlabs.org>; Mon, 28 Jul 2025 15:56:43 +1000 (AEST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-234f17910d8so34402395ad.3
        for <linux-aspeed@lists.ozlabs.org>; Sun, 27 Jul 2025 22:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753682201; x=1754287001; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZElVV0LR61vFRou/4QGyHqbGC1WySEH8A190BlUdXsU=;
        b=RsaAUhPLXYSNSp6DGBVvyrF9AsV5vxYLLgZjzgW/zjFOmqIaQZ+mpVQnY+9lv6N7SU
         mRWfqbFEftmaSZrpVXNMwVPT9osbT6+/Aw5UeMTAHZR/mNKEhNKC91O7ZD1FG3kz9ybP
         pEvVcYSGrL+hKt0iiJyhRWI9rgX48YA74Ma6Eawh3b3TZNkpfUsxNHClhvY4RT1f73QV
         OUAU/6lyJLhZLjoMRcVa1QUOsMYYoT0zS8iddHOxsAweSkQ2IlY7HTeWOa/D7Dulc6vP
         9y6CEfDiU2kZ/GqNsvG56dqi7Wq0yAOJFjZ9HiBxUNRc3y6ahCJ/wj1eZpkOx3smv1dV
         CW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753682201; x=1754287001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZElVV0LR61vFRou/4QGyHqbGC1WySEH8A190BlUdXsU=;
        b=eN231TKUOlNslrnLHir7B65fVMgNjqCCP8jKtONqb7vC5hY+Kkz5nXeeQn8rYa90Te
         XuyfxubLBDgjkU/gMVzhNobWb+DVpoic/Z5x5lhEnzOIuEbC9fpQu/PttcnYOoNuJv4j
         Xue9DRt/anCQvZd3bVOqDN89JBuRC71GEdOyl2sjs/NUweUbLCCnzJR7OJyZShZm/j5i
         jvsdHER5027vtffKW+2Q0QTyQxvyXxAVtjPx/Njs0UaFRbL4BnN4D5oSKljYOjDeSTqc
         Ok367GSL7X8c8ayp2FBGHZYNbchnMq6zLxhC0D0BpES9psYVr7lPWC1ZBieEi6wltVNp
         Xhvg==
X-Forwarded-Encrypted: i=1; AJvYcCWtVhWbHCQb1coaxBwhxH27yegyIxZmHdDYu2tjc/jQZ1v/ZSwIG9SwvL557gHuMn8OZTJNu4RTIWtGuE4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywm0+cgp+YdtLVFGOCE+vz1cvGCXyYSU/3xrM0NaUzdfXGPneMH
	eJy9Goo0tZoa8QZEp79Q8BrcuKKZ4Fzzp1ZMI3nm02RqYAkNtcdNTj35
X-Gm-Gg: ASbGnctMeOS1JOvqvKOm7iPnMWdQFriOmgLlKKvlqOBE7N/cgkvFdsme1wEjNx0zUSQ
	v5g8fWlSwmIbI2FFDnfsxWfTv4zHQkL++x8AGrUs4eMuxDujpxyb05wqjAJeM1ULghBX2fFE1Ll
	UokeWoe7B72auAyhoCO9LaTWgttMsTmg3FkMhkrzAiZbqQRCsxrQHQN9wN5g5j17kXqAJeMmKFl
	XvLO0TJxS0YAy6Zxh8WK9A/WA8O1NiirYUKNQfyAavZVxE1MyvwcsGwWqS4OEJ6oJIWgrDBpkWL
	lcYilD2qf5OuCRWH1GZU+T5XIrPvbR2WBmPIj4/4UwAtRWh4zg7EB8Mfk50aXoWAYI+HOwfKmWK
	+A3R2D8FgfjwKUu0yxIeReguO6p1yHeEjVCzZjG9ZjRElipv33opdkbLos7KWAlt59WfzIhNTOa
	dQShXh8+0PSg==
X-Google-Smtp-Source: AGHT+IGz2szEe+QUGFeKrT4Rv07EGBmjb5b0l1N4TwMDYWvAcY6GsO7Zhbb07NmI4/uy/W+iY8K8tw==
X-Received: by 2002:a17:902:f70c:b0:240:3e41:57bf with SMTP id d9443c01a7336-2403e415954mr11682715ad.13.1753682201044;
        Sun, 27 Jul 2025 22:56:41 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe514b59sm45091795ad.128.2025.07.27.22.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 22:56:40 -0700 (PDT)
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
Subject: [PATCH v4 11/13] ARM: dts: aspeed: facebook-fuji: Include facebook-fuji-data64.dts
Date: Sun, 27 Jul 2025 22:56:13 -0700
Message-ID: <20250728055618.61616-12-rentao.bupt@gmail.com>
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

Include "facebook-fuji-data64.dts" in facebook-fuji dts to avoid
duplicated code.

Fuji-data64 and Fuji are identical except the BMC flash layout.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
Changes in v4:
  - None.
Changes in v3:
  - None (the patch is introduced in v3).

 .../dts/aspeed/aspeed-bmc-facebook-fuji.dts   | 1251 +----------------
 1 file changed, 5 insertions(+), 1246 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
index d0331980d082..5dc2a165e441 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
@@ -1,1257 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0+
 // Copyright (c) 2020 Facebook Inc.
 
-/dts-v1/;
-
-#include <dt-bindings/leds/common.h>
-#include "ast2600-facebook-netbmc-common.dtsi"
+#include "aspeed-bmc-facebook-fuji-data64.dts"
 
 / {
 	model = "Facebook Fuji BMC";
 	compatible = "facebook,fuji-bmc", "aspeed,ast2600";
-
-	aliases {
-		/*
-		 * PCA9548 (2-0070) provides 8 channels connecting to
-		 * SCM (System Controller Module).
-		 */
-		i2c16 = &imux16;
-		i2c17 = &imux17;
-		i2c18 = &imux18;
-		i2c19 = &imux19;
-		i2c20 = &imux20;
-		i2c21 = &imux21;
-		i2c22 = &imux22;
-		i2c23 = &imux23;
-
-		/*
-		 * PCA9548 (8-0070) provides 8 channels connecting to
-		 * SMB (Switch Main Board).
-		 */
-		i2c24 = &imux24;
-		i2c25 = &imux25;
-		i2c26 = &imux26;
-		i2c27 = &imux27;
-		i2c28 = &imux28;
-		i2c29 = &imux29;
-		i2c30 = &imux30;
-		i2c31 = &imux31;
-
-		/*
-		 * PCA9548 (11-0077) provides 8 channels connecting to
-		 * SMB (Switch Main Board).
-		 */
-		i2c40 = &imux40;
-		i2c41 = &imux41;
-		i2c42 = &imux42;
-		i2c43 = &imux43;
-		i2c44 = &imux44;
-		i2c45 = &imux45;
-		i2c46 = &imux46;
-		i2c47 = &imux47;
-
-		/*
-		 * PCA9548 (24-0071) provides 8 channels connecting to
-		 * PDB-Left.
-		 */
-		i2c48 = &imux48;
-		i2c49 = &imux49;
-		i2c50 = &imux50;
-		i2c51 = &imux51;
-		i2c52 = &imux52;
-		i2c53 = &imux53;
-		i2c54 = &imux54;
-		i2c55 = &imux55;
-
-		/*
-		 * PCA9548 (25-0072) provides 8 channels connecting to
-		 * PDB-Right.
-		 */
-		i2c56 = &imux56;
-		i2c57 = &imux57;
-		i2c58 = &imux58;
-		i2c59 = &imux59;
-		i2c60 = &imux60;
-		i2c61 = &imux61;
-		i2c62 = &imux62;
-		i2c63 = &imux63;
-
-		/*
-		 * PCA9548 (26-0076) provides 8 channels connecting to
-		 * FCM1.
-		 */
-		i2c64 = &imux64;
-		i2c65 = &imux65;
-		i2c66 = &imux66;
-		i2c67 = &imux67;
-		i2c68 = &imux68;
-		i2c69 = &imux69;
-		i2c70 = &imux70;
-		i2c71 = &imux71;
-
-		/*
-		 * PCA9548 (27-0076) provides 8 channels connecting to
-		 * FCM2.
-		 */
-		i2c72 = &imux72;
-		i2c73 = &imux73;
-		i2c74 = &imux74;
-		i2c75 = &imux75;
-		i2c76 = &imux76;
-		i2c77 = &imux77;
-		i2c78 = &imux78;
-		i2c79 = &imux79;
-
-		/*
-		 * PCA9548 (40-0076) provides 8 channels connecting to
-		 * PIM1.
-		 */
-		i2c80 = &imux80;
-		i2c81 = &imux81;
-		i2c82 = &imux82;
-		i2c83 = &imux83;
-		i2c84 = &imux84;
-		i2c85 = &imux85;
-		i2c86 = &imux86;
-		i2c87 = &imux87;
-
-		/*
-		 * PCA9548 (41-0076) provides 8 channels connecting to
-		 * PIM2.
-		 */
-		i2c88 = &imux88;
-		i2c89 = &imux89;
-		i2c90 = &imux90;
-		i2c91 = &imux91;
-		i2c92 = &imux92;
-		i2c93 = &imux93;
-		i2c94 = &imux94;
-		i2c95 = &imux95;
-
-		/*
-		 * PCA9548 (42-0076) provides 8 channels connecting to
-		 * PIM3.
-		 */
-		i2c96 = &imux96;
-		i2c97 = &imux97;
-		i2c98 = &imux98;
-		i2c99 = &imux99;
-		i2c100 = &imux100;
-		i2c101 = &imux101;
-		i2c102 = &imux102;
-		i2c103 = &imux103;
-
-		/*
-		 * PCA9548 (43-0076) provides 8 channels connecting to
-		 * PIM4.
-		 */
-		i2c104 = &imux104;
-		i2c105 = &imux105;
-		i2c106 = &imux106;
-		i2c107 = &imux107;
-		i2c108 = &imux108;
-		i2c109 = &imux109;
-		i2c110 = &imux110;
-		i2c111 = &imux111;
-
-		/*
-		 * PCA9548 (44-0076) provides 8 channels connecting to
-		 * PIM5.
-		 */
-		i2c112 = &imux112;
-		i2c113 = &imux113;
-		i2c114 = &imux114;
-		i2c115 = &imux115;
-		i2c116 = &imux116;
-		i2c117 = &imux117;
-		i2c118 = &imux118;
-		i2c119 = &imux119;
-
-		/*
-		 * PCA9548 (45-0076) provides 8 channels connecting to
-		 * PIM6.
-		 */
-		i2c120 = &imux120;
-		i2c121 = &imux121;
-		i2c122 = &imux122;
-		i2c123 = &imux123;
-		i2c124 = &imux124;
-		i2c125 = &imux125;
-		i2c126 = &imux126;
-		i2c127 = &imux127;
-
-		/*
-		 * PCA9548 (46-0076) provides 8 channels connecting to
-		 * PIM7.
-		 */
-		i2c128 = &imux128;
-		i2c129 = &imux129;
-		i2c130 = &imux130;
-		i2c131 = &imux131;
-		i2c132 = &imux132;
-		i2c133 = &imux133;
-		i2c134 = &imux134;
-		i2c135 = &imux135;
-
-		/*
-		 * PCA9548 (47-0076) provides 8 channels connecting to
-		 * PIM8.
-		 */
-		i2c136 = &imux136;
-		i2c137 = &imux137;
-		i2c138 = &imux138;
-		i2c139 = &imux139;
-		i2c140 = &imux140;
-		i2c141 = &imux141;
-		i2c142 = &imux142;
-		i2c143 = &imux143;
-	};
-
-	spi_gpio: spi {
-		num-chipselects = <3>;
-		cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>,
-			   <0>,	/* device reg=<1> does not exist */
-			   <&gpio0 ASPEED_GPIO(X, 2) GPIO_ACTIVE_HIGH>;
-
-		eeprom@2 {
-			compatible = "atmel,at93c46d";
-			spi-max-frequency = <250000>;
-			data-size = <16>;
-			spi-cs-high;
-			reg = <2>;
-		};
-	};
-};
-
-&i2c0 {
-	multi-master;
-	bus-frequency = <1000000>;
-};
-
-&i2c2 {
-	/*
-	 * PCA9548 (2-0070) provides 8 channels connecting to SCM (System
-	 * Controller Module).
-	 */
-	i2c-mux@70 {
-		compatible = "nxp,pca9548";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x70>;
-		i2c-mux-idle-disconnect;
-
-		imux16: i2c@0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0>;
-
-			adm1278@10 {
-				compatible = "adi,adm1278";
-				reg = <0x10>;
-				shunt-resistor-micro-ohms = <1500>;
-			};
-		};
-
-		imux17: i2c@1 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <1>;
-		};
-
-		imux18: i2c@2 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <2>;
-		};
-
-		imux19: i2c@3 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <3>;
-		};
-
-		imux20: i2c@4 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <4>;
-		};
-
-		imux21: i2c@5 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <5>;
-		};
-
-		imux22: i2c@6 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <6>;
-		};
-
-		imux23: i2c@7 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <7>;
-		};
-	};
-};
-
-&i2c8 {
-	/*
-	 * PCA9548 (8-0070) provides 8 channels connecting to SMB (Switch
-	 * Main Board).
-	 */
-	i2c-mux@70 {
-		compatible = "nxp,pca9548";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x70>;
-		i2c-mux-idle-disconnect;
-
-		imux24: i2c@0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0>;
-
-			i2c-mux@71 {
-				compatible = "nxp,pca9548";
-				#address-cells = <1>;
-				#size-cells = <0>;
-				reg = <0x71>;
-				i2c-mux-idle-disconnect;
-
-				imux48: i2c@0 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <0>;
-				};
-
-				imux49: i2c@1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <1>;
-				};
-
-				imux50: i2c@2 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <2>;
-
-					lp5012@14 {
-						compatible = "ti,lp5012";
-						reg = <0x14>;
-						#address-cells = <1>;
-						#size-cells = <0>;
-
-						multi-led@0 {
-							#address-cells = <1>;
-							#size-cells = <0>;
-							reg = <0>;
-							color = <LED_COLOR_ID_MULTI>;
-							function = LED_FUNCTION_ACTIVITY;
-							label = "sys";
-
-							led@0 {
-								reg = <0>;
-								color = <LED_COLOR_ID_RED>;
-							};
-
-							led@1 {
-								reg = <1>;
-								color = <LED_COLOR_ID_BLUE>;
-							};
-
-							led@2 {
-								reg = <2>;
-								color = <LED_COLOR_ID_GREEN>;
-							};
-						};
-
-						multi-led@1 {
-							#address-cells = <1>;
-							#size-cells = <0>;
-							reg = <1>;
-							color = <LED_COLOR_ID_MULTI>;
-							function = LED_FUNCTION_ACTIVITY;
-							label = "fan";
-
-							led@0 {
-								reg = <0>;
-								color = <LED_COLOR_ID_RED>;
-							};
-
-							led@1 {
-								reg = <1>;
-								color = <LED_COLOR_ID_BLUE>;
-							};
-
-							led@2 {
-								reg = <2>;
-								color = <LED_COLOR_ID_GREEN>;
-							};
-						};
-
-						multi-led@2 {
-							#address-cells = <1>;
-							#size-cells = <0>;
-							reg = <2>;
-							color = <LED_COLOR_ID_MULTI>;
-							function = LED_FUNCTION_ACTIVITY;
-							label = "psu";
-
-							led@0 {
-								reg = <0>;
-								color = <LED_COLOR_ID_RED>;
-							};
-
-							led@1 {
-								reg = <1>;
-								color = <LED_COLOR_ID_BLUE>;
-							};
-
-							led@2 {
-								reg = <2>;
-								color = <LED_COLOR_ID_GREEN>;
-							};
-						};
-
-						multi-led@3 {
-							#address-cells = <1>;
-							#size-cells = <0>;
-							reg = <3>;
-							color = <LED_COLOR_ID_MULTI>;
-							function = LED_FUNCTION_ACTIVITY;
-							label = "smb";
-
-							led@0 {
-								reg = <0>;
-								color = <LED_COLOR_ID_RED>;
-							};
-
-							led@1 {
-								reg = <1>;
-								color = <LED_COLOR_ID_BLUE>;
-							};
-
-							led@2 {
-								reg = <2>;
-								color = <LED_COLOR_ID_GREEN>;
-							};
-						};
-					};
-				};
-
-				imux51: i2c@3 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <3>;
-				};
-
-				imux52: i2c@4 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <4>;
-				};
-
-				imux53: i2c@5 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <5>;
-				};
-
-				imux54: i2c@6 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <6>;
-				};
-
-				imux55: i2c@7 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <7>;
-				};
-			};
-
-		};
-
-		imux25: i2c@1 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <1>;
-
-			i2c-mux@72 {
-				compatible = "nxp,pca9548";
-				#address-cells = <1>;
-				#size-cells = <0>;
-				reg = <0x72>;
-				i2c-mux-idle-disconnect;
-
-				imux56: i2c@0 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <0>;
-				};
-
-				imux57: i2c@1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <1>;
-				};
-
-				imux58: i2c@2 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <2>;
-				};
-
-				imux59: i2c@3 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <3>;
-				};
-
-				imux60: i2c@4 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <4>;
-				};
-
-				imux61: i2c@5 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <5>;
-				};
-
-				imux62: i2c@6 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <6>;
-				};
-
-				imux63: i2c@7 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <7>;
-				};
-			};
-
-		};
-
-		imux26: i2c@2 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <2>;
-
-			i2c-mux@76 {
-				compatible = "nxp,pca9548";
-				#address-cells = <1>;
-				#size-cells = <0>;
-				reg = <0x76>;
-				i2c-mux-idle-disconnect;
-
-				imux64: i2c@0 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <0>;
-				};
-
-				imux65: i2c@1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <1>;
-				};
-
-				imux66: i2c@2 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <2>;
-				};
-
-				imux67: i2c@3 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <3>;
-
-					adm1278@10 {
-						compatible = "adi,adm1278";
-						reg = <0x10>;
-						shunt-resistor-micro-ohms = <250>;
-					};
-				};
-
-				imux68: i2c@4 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <4>;
-				};
-
-				imux69: i2c@5 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <5>;
-				};
-
-				imux70: i2c@6 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <6>;
-				};
-
-				imux71: i2c@7 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <7>;
-				};
-			};
-
-		};
-
-		imux27: i2c@3 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <3>;
-
-			i2c-mux@76 {
-				compatible = "nxp,pca9548";
-				#address-cells = <1>;
-				#size-cells = <0>;
-				reg = <0x76>;
-				i2c-mux-idle-disconnect;
-
-				imux72: i2c@0 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <0>;
-				};
-
-				imux73: i2c@1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <1>;
-				};
-
-				imux74: i2c@2 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <2>;
-				};
-
-				imux75: i2c@3 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <3>;
-
-					adm1278@10 {
-						compatible = "adi,adm1278";
-						reg = <0x10>;
-						shunt-resistor-micro-ohms = <250>;
-					};
-				};
-
-				imux76: i2c@4 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <4>;
-				};
-
-				imux77: i2c@5 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <5>;
-				};
-
-				imux78: i2c@6 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <6>;
-				};
-
-				imux79: i2c@7 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <7>;
-				};
-			};
-
-		};
-
-		imux28: i2c@4 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <4>;
-		};
-
-		imux29: i2c@5 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <5>;
-		};
-
-		imux30: i2c@6 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <6>;
-		};
-
-		imux31: i2c@7 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <7>;
-		};
-
-	};
-};
-
-&i2c11 {
-	status = "okay";
-
-	/*
-	 * PCA9548 (11-0077) provides 8 channels connecting to SMB (Switch
-	 * Main Board).
-	 */
-	i2c-mux@77 {
-		compatible = "nxp,pca9548";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x77>;
-		i2c-mux-idle-disconnect;
-
-		imux40: i2c@0 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <0>;
-
-			i2c-mux@76 {
-				compatible = "nxp,pca9548";
-				#address-cells = <1>;
-				#size-cells = <0>;
-				reg = <0x76>;
-				i2c-mux-idle-disconnect;
-
-				imux80: i2c@0 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <0>;
-				};
-
-				imux81: i2c@1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <1>;
-				};
-
-				imux82: i2c@2 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <2>;
-				};
-
-				imux83: i2c@3 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <3>;
-				};
-
-				imux84: i2c@4 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <4>;
-				};
-
-				imux85: i2c@5 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <5>;
-				};
-
-				imux86: i2c@6 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <6>;
-				};
-
-				imux87: i2c@7 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <7>;
-				};
-			};
-
-		};
-
-		imux41: i2c@1 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <1>;
-
-			i2c-mux@76 {
-				compatible = "nxp,pca9548";
-				#address-cells = <1>;
-				#size-cells = <0>;
-				reg = <0x76>;
-				i2c-mux-idle-disconnect;
-
-				imux88: i2c@0 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <0>;
-				};
-
-				imux89: i2c@1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <1>;
-				};
-
-				imux90: i2c@2 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <2>;
-				};
-
-				imux91: i2c@3 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <3>;
-				};
-
-				imux92: i2c@4 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <4>;
-				};
-
-				imux93: i2c@5 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <5>;
-				};
-
-				imux94: i2c@6 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <6>;
-				};
-
-				imux95: i2c@7 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <7>;
-				};
-			};
-
-		};
-
-		imux42: i2c@2 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <2>;
-
-			i2c-mux@76 {
-				compatible = "nxp,pca9548";
-				#address-cells = <1>;
-				#size-cells = <0>;
-				reg = <0x76>;
-				i2c-mux-idle-disconnect;
-
-				imux96: i2c@0 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <0>;
-				};
-
-				imux97: i2c@1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <1>;
-				};
-
-				imux98: i2c@2 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <2>;
-				};
-
-				imux99: i2c@3 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <3>;
-				};
-
-				imux100: i2c@4 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <4>;
-				};
-
-				imux101: i2c@5 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <5>;
-				};
-
-				imux102: i2c@6 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <6>;
-				};
-
-				imux103: i2c@7 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <7>;
-				};
-			};
-
-		};
-
-		imux43: i2c@3 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <3>;
-
-			i2c-mux@76 {
-				compatible = "nxp,pca9548";
-				#address-cells = <1>;
-				#size-cells = <0>;
-				reg = <0x76>;
-				i2c-mux-idle-disconnect;
-
-				imux104: i2c@0 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <0>;
-				};
-
-				imux105: i2c@1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <1>;
-				};
-
-				imux106: i2c@2 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <2>;
-				};
-
-				imux107: i2c@3 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <3>;
-				};
-
-				imux108: i2c@4 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <4>;
-				};
-
-				imux109: i2c@5 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <5>;
-				};
-
-				imux110: i2c@6 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <6>;
-				};
-
-				imux111: i2c@7 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <7>;
-				};
-			};
-
-		};
-
-		imux44: i2c@4 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <4>;
-
-			i2c-mux@76 {
-				compatible = "nxp,pca9548";
-				#address-cells = <1>;
-				#size-cells = <0>;
-				reg = <0x76>;
-				i2c-mux-idle-disconnect;
-
-				imux112: i2c@0 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <0>;
-				};
-
-				imux113: i2c@1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <1>;
-				};
-
-				imux114: i2c@2 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <2>;
-				};
-
-				imux115: i2c@3 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <3>;
-				};
-
-				imux116: i2c@4 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <4>;
-				};
-
-				imux117: i2c@5 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <5>;
-				};
-
-				imux118: i2c@6 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <6>;
-				};
-
-				imux119: i2c@7 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <7>;
-				};
-			};
-
-		};
-
-		imux45: i2c@5 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <5>;
-
-			i2c-mux@76 {
-				compatible = "nxp,pca9548";
-				#address-cells = <1>;
-				#size-cells = <0>;
-				reg = <0x76>;
-				i2c-mux-idle-disconnect;
-
-				imux120: i2c@0 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <0>;
-				};
-
-				imux121: i2c@1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <1>;
-				};
-
-				imux122: i2c@2 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <2>;
-				};
-
-				imux123: i2c@3 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <3>;
-				};
-
-				imux124: i2c@4 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <4>;
-				};
-
-				imux125: i2c@5 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <5>;
-				};
-
-				imux126: i2c@6 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <6>;
-				};
-
-				imux127: i2c@7 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <7>;
-				};
-			};
-
-		};
-
-		imux46: i2c@6 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <6>;
-
-			i2c-mux@76 {
-				compatible = "nxp,pca9548";
-				#address-cells = <1>;
-				#size-cells = <0>;
-				reg = <0x76>;
-				i2c-mux-idle-disconnect;
-
-				imux128: i2c@0 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <0>;
-				};
-
-				imux129: i2c@1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <1>;
-				};
-
-				imux130: i2c@2 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <2>;
-				};
-
-				imux131: i2c@3 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <3>;
-				};
-
-				imux132: i2c@4 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <4>;
-				};
-
-				imux133: i2c@5 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <5>;
-				};
-
-				imux134: i2c@6 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <6>;
-				};
-
-				imux135: i2c@7 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <7>;
-				};
-			};
-
-		};
-
-		imux47: i2c@7 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			reg = <7>;
-
-			i2c-mux@76 {
-				compatible = "nxp,pca9548";
-				#address-cells = <1>;
-				#size-cells = <0>;
-				reg = <0x76>;
-				i2c-mux-idle-disconnect;
-
-				imux136: i2c@0 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <0>;
-				};
-
-				imux137: i2c@1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <1>;
-				};
-
-				imux138: i2c@2 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <2>;
-				};
-
-				imux139: i2c@3 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <3>;
-				};
-
-				imux140: i2c@4 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <4>;
-				};
-
-				imux141: i2c@5 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <5>;
-				};
-
-				imux142: i2c@6 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <6>;
-				};
-
-				imux143: i2c@7 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <7>;
-				};
-			};
-
-		};
-
-	};
 };
 
-&ehci1 {
-	status = "okay";
-};
-
-&mdio1 {
-	status = "okay";
-
-	ethphy3: ethernet-phy@13 {
-		compatible = "ethernet-phy-ieee802.3-c22";
-		reg = <0x0d>;
+&fmc {
+	flash@0 {
+		/delete-node/partitions;
+#include "facebook-bmc-flash-layout-128.dtsi"
 	};
 };
-
-&mac3 {
-	status = "okay";
-	phy-mode = "rgmii";
-	phy-handle = <&ethphy3>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_rgmii4_default>;
-};
-
-&emmc_controller {
-	status = "okay";
-};
-
-&emmc {
-	status = "okay";
-
-	non-removable;
-	max-frequency = <25000000>;
-	bus-width = <4>;
-};
-- 
2.47.3


