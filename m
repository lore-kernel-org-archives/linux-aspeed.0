Return-Path: <linux-aspeed+bounces-4030-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4902FCD4F39
	for <linux-aspeed@archiver.kernel.org>; Thu, 14 May 2026 23:44:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gGn3v752Yz2y8r;
	Fri, 15 May 2026 09:44:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1032"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778728604;
	cv=none; b=E7QoSu7n3IxFpozE7Pxavdjp9E0nuTbDbB/ytCw2NF+w3mbPj/jx2OABTjZzb6zB9v/Idt2rk3e3xmKBDLdtWIWQ2uHk43f3AtE0FxV4hIeft+flJgQcTpTcSTJNmgY+Qk+grVpMreOcjTbyaIdKoZRkCt4RSIlR6ADKkRnNYsWKKDbx+oR07ggwk5jiUMx1k5YlGvxpSg6yOv1avArlfoFJiH/ESJOTGePn9uk/7JTQGe7jkMbKszrE/9RKgMfeuGsYq8QNZuVgyGFglTgnqhHuz8tTtxwjpXPkf5vLYZFyxm7uzJzzzwVdkFVyH9A3cNM8HEA8gQVuFHbv51l/tA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778728604; c=relaxed/relaxed;
	bh=mhXaZyjR5wnfmrnw0I8RLf6r41iRHOPfxchv5M6XoP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ktyHAeZKP43pZFJGjGiX4IKlP1xpE6NJ1tF59gsg/zcaVCFUZXfuTuNYt/ty/ErMlBhLjlGsanhVETCVo4cbe+QmYMJCuHA1LRv5RT9wmRnPt9IKdyLHJxsOxgSrJjG+dqPoPD+naHVIGihzOrcyPkL1cQejR5sdgeU0zH8NXSrWaw4H0dQs9TG7d/BsQkh347Mdkw96+g5cQPZiaTNDIVQAMtR6muyxA2QizbiTrEnH+7QKtBPkEMxFPv31GSYcgXg5KmHOrKptjcpnbPUv1BsUpX+u9xeuu7UVN9hVTe4vHCeII6wKoKYv0LefyANLmxBPxUAfgOoUsUtbLYI0PQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U+6W3G6l; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U+6W3G6l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gGFqH68cnz2xdL
	for <linux-aspeed@lists.ozlabs.org>; Thu, 14 May 2026 13:16:43 +1000 (AEST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-3692bf38290so208911a91.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 13 May 2026 20:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778728602; x=1779333402; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhXaZyjR5wnfmrnw0I8RLf6r41iRHOPfxchv5M6XoP8=;
        b=U+6W3G6lT2Gi7HCDz3weTi+PJnWtLEsS9NGae9dJntfm4lUf2V+5mWYlbh9DWb3GO8
         atxcvltgah5G1qP4wL1fYMFk8aFb0fBWsKon2/n+5k9qffN9zqIIMh4wW2wxc3rQCXql
         HGWEuyESBzuD7Hp7uRXT+iBV1RTlIUb2SUvLWruZiVZv9moGN9aCM9q9GwzfNvYvM4dD
         NcKfkEz3Xz8SlnYZE+EW0o+wzvmuDkels6JqxGzuk9Jd+4SMpPAFGJAIzVu2sRuEheGr
         pwGBDjtprxpmwKaFsSHaHiXQfq+/brIKCl8eyK+8xASb3jYuEqy4rOVcVHN5/pRiibYA
         DeKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778728602; x=1779333402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mhXaZyjR5wnfmrnw0I8RLf6r41iRHOPfxchv5M6XoP8=;
        b=mCVSlKU1zHSzq7x3lyxkMV8voU8XpIGL199k+zXHavBBvxiZlBkG6tq3STem92AdyE
         dLIxcUmZALBUsW+ryeaHoiYivGtatDKOxwQPepIVEq19NSwJOqtoya96uVhqMrCghW0i
         JTm2Brv5Hm60XW0k12l1kyD7YW1Lhg3Od0offNQi5qDX1nd1NfSWZ7VGKf3DBSxuNbJD
         YiA3RH9uzWAIwGLV0c2dDHxiV1ZE8O6jqDshPC5ZxGKqzBU0RKX2AwzTwrBkTtRBTD7K
         oNjOmChFoPGdVARXzxOCSc68vXAug3vyJjRm5kLWb/+KC9o0d8x+0mdh0uXUZAj7dHnp
         o5nQ==
X-Forwarded-Encrypted: i=1; AFNElJ8wvCXleupoSYS4ArA/CvEqkETPkAXvLWQVQcepZCLNF3NiIK2vhU5rqZ6XBj8MAJWK9UQSRKaaDY9dpms=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxWECjeF6BGk95tXHOiU7N+sq1U/2ElnO6ZNKmObJTEK52CYsxo
	oorRqsGEJm1KHfCcDuybq91UnL24cR7Vx9wJ0vIKy7IhZSFcbBHTdYotq1uTVw==
X-Gm-Gg: Acq92OHa8uSGkyqRQN/Vag5ix3/WGn2srvFsvsfxj15Q8v1OSJ5hJHCW0NG0KdGDoNc
	AmfvyYx255ujsfw3QNQBvOk/CWW2BuSGtmRFJNpZ/VqC7rg7Bth4YNGsT2bBGeCsdhN52cXlAUs
	jtaYRMrtD+9hUN8fQ7o733rJcVnN4nq8avW5ws14xzhb9JpE1bQs4WJvsh1hyZxujoJybRH/GaR
	rRCYvw4P7lVUwORHRDxNuGgZdEKz2kCb92Y1p4+8ULwwQo7npnSvXPg0JQ/uf0W59GybXht51rP
	2h/VskxUJESK4Ku/BxfNAanesBf3VCKFrNBDs4vRnWTKOUit+aDon21gVQrNhZb5Qc7gnhaOfE+
	YjZ25PxFwZ2K+zcG8MXW1OJDLzFIXk7lbPE1sW6t5gbtyOeHjqSrXQ2pTWmqru++v5qft5czcrv
	ewNt9yitCqDGeuULrYRjhqWWNG0eXf4TTBdW6sRg/r
X-Received: by 2002:a17:90a:f946:b0:364:edd2:812 with SMTP id 98e67ed59e1d1-368f40a23dcmr6192258a91.25.1778728601594;
        Wed, 13 May 2026 20:16:41 -0700 (PDT)
Received: from debian.prasanth ([103.177.82.138])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3692a94205asm320047a91.7.2026.05.13.20.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 20:16:41 -0700 (PDT)
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
Subject: [PATCH v2 2/2] ARM: dts: aspeed: Add ASRock Rack B650D4U BMC
Date: Thu, 14 May 2026 08:46:22 +0530
Message-ID: <20260514031622.1416922-3-prasanth.padarthi10@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260514031622.1416922-1-prasanth.padarthi10@gmail.com>
References: <20260514031622.1416922-1-prasanth.padarthi10@gmail.com>
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
index 000000000..130b7f3e0
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
+&mdio0 {
+	status = "okay";
+
+	ethphy0: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
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


