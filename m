Return-Path: <linux-aspeed+bounces-4703-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93340C5DF66
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Aug 2026 00:40:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLk060jK8z2yrS;
	Fri, 14 Aug 2026 10:40:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786622407;
	cv=none; b=eArxqzQPbOIprqvKIiIUXYQIOR24/LFVjjztftvGDyhcyiElFKwICeWgVJUS5BwIFF/gDOP1sRD6IciDO7XHYI9K6y+Nwjg26bsL1ecxqPzXXEKcoDJ/swdzvNGDZq5s85T4ZcXBOEjAt3UJa1pTHtT6tNMjZnQiUZKjho49VM0tnXwaqzaZwJ9u+HQodX1dqoMiQvAmnqPVzy9AG6utCXKLLONb82EGGhXxlqyVe+TwYtWJqkhBsgqpHmbFLAoXmC3Piihn42W9VNa7MoD/tUrjWjQVwi07E4Tg4qv4FfnqXZcl83aEEQPXhn5Xj9BnQs0cxKFgVwIHytXs6ongKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786622407; c=relaxed/relaxed;
	bh=f9a20wqiX5jfXMCYHkvvGz0w/Eo1PPQ8K/qd7EvdOyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W0dTWdMZ2nXtRUD+AviaLAcDtC3V99XtM8MJ0SxdapuqOhu2QS0hGFk8O20qcEpZGbQnv/XmOFDugxXI6lGLBc/wHZiMTbYJbNDuBRfhLYotwiZ61XO8f6VYQIxfANZjaVgoqiSi2WRS9bqjqZOi5K66Ckz4odXlYHluKWmKdB/rZxtjmIDSk6Qs8Wlt6tCbybo6cGOe32PzL1I6aKJNnIYcwmmFDodbIRKGedyxOJXa25tki8kJdkOUgexiHurgXYn59ZSwGf33pTvzypmXb58eWW3vS/TdP0CbaXJJLaKR+f1+1866Oy3eUaOP7XIXt3U9FATzI6JaFKJUxdoJ+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SF43Wt9G; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SF43Wt9G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLP785q8cz2yfp
	for <linux-aspeed@lists.ozlabs.org>; Thu, 13 Aug 2026 22:00:04 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CBD4744071;
	Thu, 13 Aug 2026 12:00:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49E14C2BCFF;
	Thu, 13 Aug 2026 12:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786622400;
	bh=TvfqYkcyVz8NemCQfEvCt2KSWTiyYhcCTYK5XdDbYxQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SF43Wt9G2vaW2ve2VLnIaF5m8AW+4vSzryi+v3cC0t67AFTR8BGLRs9b1Njobq1Pl
	 5LyJ3KgwcC5mXxQVpyjzuTagF+Nb4IzZMT8USznNZLuTGiEBWWTuUuA0kHre2FK/t8
	 /JrQYZwW/ktDHphHvlTdQOPb/WG3w/BBCZcTwk2mtCWVqYVTubpN1e5rFQDqKodd0T
	 ZLcuKkQYtH2iBVYIEwrrq4X9cvEIdOGGcibAXMip/J1bPLUpTgbWD9DycG369+SzsM
	 z1OWewdfg3Di9NbsbSjfyceP8Irp8PNweRxNjbQCfga274dMFnaDlsJzUQtKiybbe+
	 MrsjkZ6tstlGw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25ECAC5DF66;
	Thu, 13 Aug 2026 12:00:00 +0000 (UTC)
From: Colin Huang via B4 Relay <devnull+u8813345.gmail.com@kernel.org>
Date: Thu, 13 Aug 2026 19:59:39 +0800
Subject: [PATCH v5 09/15] ARM: dts: aspeed: anacapa: evt2: Add shunt
 resistor values for HSC monitors
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
Message-Id: <20260813-anacapa-devlop-phase-devicetree-v5-9-c7058f63dc67@gmail.com>
References: <20260813-anacapa-devlop-phase-devicetree-v5-0-c7058f63dc67@gmail.com>
In-Reply-To: <20260813-anacapa-devlop-phase-devicetree-v5-0-c7058f63dc67@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 colin.huang2@amd.com, Colin Huang <u8813345@gmail.com>, 
 Peter Shen <peter.shen@amd.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786622378; l=2147;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=WNTfq2afBfA8+J3QozrER71+gm8MPJIV48F5xeH186s=;
 b=523oHOdDWNNkRW7XTPHdzWMnEQ5tIse+VNgOaa8eWqFLogKrRThVuWdrld7oCDY3L8NeG0j/J
 3HRRLnhQlH8AQcnA3yfPRny/BtFO39kPcKvvyRdhbeRq0QuOKvauhYy
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-Endpoint-Received: by B4 Relay for u8813345@gmail.com/20260202 with
 auth_id=761
X-Original-From: Colin Huang <u8813345@gmail.com>
Reply-To: u8813345@gmail.com

From: Colin Huang <u8813345@gmail.com>

Add shunt resistor configuration for LTC4287 hot-swap controllers on
Anacapa EVT2 platform.

The resistor values are required for accurate current and power
measurement by the driver. These settings reflect the actual BOM used
on EVT2, where different sense resistor values (150 uOhm and 250 uOhm)
are populated across rails.

Without this configuration, the reported readings would be incorrect.

Signed-off-by: Peter Shen <peter.shen@amd.com>
---
 .../aspeed/aspeed-bmc-facebook-anacapa-evt2.dts    | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts
index 703284721224..f913fa3f622d 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts
@@ -31,6 +31,26 @@ / {
 &i2c8 {
 	i2c-mux@72 {
 		i2c8mux0ch0: i2c@0 {
+			power-monitor@42 {
+				compatible = "lltc,ltc4287";
+				reg = <0x42>;
+				shunt-resistor-micro-ohms = <150>;
+			};
+			power-monitor@43 {
+				compatible = "lltc,ltc4287";
+				reg = <0x43>;
+				shunt-resistor-micro-ohms = <150>;
+			};
+			power-monitor@44 {
+				compatible = "lltc,ltc4287";
+				reg = <0x44>;
+				shunt-resistor-micro-ohms = <250>;
+			};
+			power-monitor@45 {
+				compatible = "lltc,ltc4287";
+				reg = <0x45>;
+				shunt-resistor-micro-ohms = <250>;
+			};
 			gpio@24 {
 				gpio-line-names =
 					"RPDB_EAM2_PRSNT_MOS_N_R", "RPDB_EAM3_PRSNT_MOS_N_R",
@@ -45,6 +65,21 @@ gpio@24 {
 			};
 		};
 		i2c8mux0ch1: i2c@1 {
+			power-monitor@40 {
+				compatible = "lltc,ltc4287";
+				reg = <0x40>;
+				shunt-resistor-micro-ohms = <150>;
+			};
+			power-monitor@41 {
+				compatible = "lltc,ltc4287";
+				reg = <0x41>;
+				shunt-resistor-micro-ohms = <150>;
+			};
+			power-monitor@45 {
+				compatible = "lltc,ltc4287";
+				reg = <0x45>;
+				shunt-resistor-micro-ohms = <250>;
+			};
 			gpio@24 {
 				gpio-line-names =
 					"LPDB_P50V_FAN0_R2_PG","LPDB_P50V_FAN1_R2_PG",

-- 
2.34.1



