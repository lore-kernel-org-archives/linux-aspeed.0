Return-Path: <linux-aspeed+bounces-3788-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3D0109C038
	for <linux-aspeed@archiver.kernel.org>; Thu, 26 Mar 2026 10:29:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhKld60vhz2xlM;
	Thu, 26 Mar 2026 21:29:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774520989;
	cv=none; b=EtqOArjDn7DpecfLQtcAZHVYNe55uyIF9iWaupSzFIlVz/yPnFHK4wsbDptIYE7v2m4w8VGkK3+WurCOv3JdqciEJRbGhdom5qvz01W+42yUeJbSgUstV97i5VzoceqB/lKoW/s/xWk7vHwEJ7nD+ZNkrFI7JrcKrpdx8nZf4CBDsXJK91W5Zz92Fvk3ta6ms/Nc7T6lcaWwa+Vz8fwVACk6s1ruCRhfbKJkbC/nBj1qUx8DBHs21d/9OW/lli8LpZUGlXRuZUuJOOh7rykWdlhYB4SDPMZ1PXRQOjvUiTHDjgPT0wYIh4LqFQPV9D0ybkHO23Kdu3BMmrKMqrK3eg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774520989; c=relaxed/relaxed;
	bh=RQV5YgPwjVWKQKtPAfMfDAcJfJwQuNLBuqyUqk5nGbA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=IZU6Dz6k0qKE2o2OJ8qGUUNUe0XM/lCgumUhH4tN143cpfF5CgpSOiUcTgo5XToEz6zblIRME8q3ufw9g9dhWKCpuoYcDAyUVXbmVv2xIgNWPmInbJRLrvkhKD1vxFmi2T3X5EJZX+Qe2W8k1WICloZ0a35Lenr0Rriv6LveMScX3IkRD78Z/VudvhAR+qDtkgFUN/8noqEWN3ElJ94pS9akJUbsi5y+oYOw1OWRUV0BnN8GZNeuHG+tcOe7bXxxHD83F4SMvYYNtaml/tP0RJ/F34TXtHklI2d+Jim7N9NjROCcCWXX4MhDhcrpgNtOM7nHMyrkmGESh7dMdVWVWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhKlc4XNmz2yS4
	for <linux-aspeed@lists.ozlabs.org>; Thu, 26 Mar 2026 21:29:47 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 26 Mar
 2026 18:29:31 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 26 Mar 2026 18:29:31 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Thu, 26 Mar 2026 18:29:22 +0800
Subject: [PATCH] ARM: dts: aspeed: g6: Add PWM/Tach controller node
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
Message-ID: <20260326-g6-dtsi-v1-1-348e7a0661c2@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIAIEKxWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYyMz3XQz3ZSS4kxdy9RU4xRLI4OkZINkJaDqgqLUtMwKsEnRsbW1ABG
 wlgRZAAAA
X-Change-ID: 20260326-g6-dtsi-9ee3d920bc0c
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Billy Tsai
	<billy_tsai@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774520971; l=1258;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=VdlCgfKxytsoAxz1ceuN+oZF1N/0ydu9279KC7M2B6Q=;
 b=6LQIfCPgwe2WTbwtFBzk67e1rmbGs8rZ2uOnqh+PSZ9DXZv9Rn4tKkJdjKheF3/+gY9bieilX
 qUclh29h+NiAF6R789GZKqv2U8efedQl54cShepZyIWqe9JFI5NhGEb
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=

Introduce a device tree node for the AST2600 PWM/Tach controller.
Describe register range, clock, reset, and cell configuration.
Set status to "disabled" by default.

Prepares for enabling PWM and tachometer support on platforms
utilizing this SoC.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 189bc3bbb47c..818d486b94ac 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -102,6 +102,15 @@ ahbc: bus@1e600000 {
 			reg = <0x1e600000 0x100>;
 		};
 
+		pwm_tach: pwm-tach-controller@1e610000 {
+			compatible = "aspeed,ast2600-pwm-tach";
+			reg = <0x1e610000 0x100>;
+			clocks = <&syscon ASPEED_CLK_AHB>;
+			resets = <&syscon ASPEED_RESET_PWM>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		fmc: spi@1e620000 {
 			reg = <0x1e620000 0xc4>, <0x20000000 0x10000000>;
 			#address-cells = <1>;

---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260326-g6-dtsi-9ee3d920bc0c

Best regards,
-- 
Billy Tsai <billy_tsai@aspeedtech.com>


