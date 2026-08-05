Return-Path: <linux-aspeed+bounces-4629-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B32C56203
	for <linux-aspeed@archiver.kernel.org>; Wed,  5 Aug 2026 23:58:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFnRw4sWvz2yrQ;
	Thu, 06 Aug 2026 09:58:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785934994;
	cv=none; b=Ns4eNuOu60KiJRgX3Way7xjT1BHFb6sdoMA3f0LBpyekjJJlWYbd1xCzu3EpAX6e2WMywP2ehbWdWkgqKSDs26pCjIQ7UMi2Fk1+WVLWjuqWWtGJ2+NbqYJA8vasMaRcr9d/LqEu11YOxqW/KQT7g0JQ4I6CDTxbqP4vR/0eTJgZv0ERRhb+IjoxOEJaRhQY547ScIwOqe22Exa8hj617s7B4+CC1/rX2Jk9Ulm8a6qXtI0tPnnvjHNTzE3NHM237xgUP2eVKnyccSjEKXtnDr3bYzMq4BRsTUpyi8MAHeAC0Nwc5DoMGY+8KGGcmVgZZA9OZuEnPD7EiTELQA+jaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785934994; c=relaxed/relaxed;
	bh=f9a20wqiX5jfXMCYHkvvGz0w/Eo1PPQ8K/qd7EvdOyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fpz8DkNeMKaPt3LvfZnQDIoG4rdfGFKxDwnNgHz6omNdwXCz+1L9nOuTgX/VclwZRAVPRHcTt5fGWYc6DxCIUdHmrSTWvytpjivGWrjsyy7B8tZsmR8XmpYrhUdqV6FyUWwLBnPoNmMsgbVKxahjFVQzUeoKifrc/XXi4jioNc7wSZREYxrdkOVNcwY21X+P22Uonr3RTSFOReowkS4A3ffoX1tVTVnxaOx2v/dn5RMC2Bn41hFHwnFbbg9uEqJcl8FMXLgLTZ7hs8sbXNw2d3WRfzbx1u9+1FOrulzXmjt0MdBZ5bq36Lwrdm5dkOFm37+5noFLgZ4R7GqoQLNJgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Q7yZ8h2P; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Q7yZ8h2P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFVvk1W17z30B9
	for <linux-aspeed@lists.ozlabs.org>; Wed, 05 Aug 2026 23:03:14 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8A48A43B71;
	Wed,  5 Aug 2026 13:03:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DA45C2BCFF;
	Wed,  5 Aug 2026 13:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785934989;
	bh=TvfqYkcyVz8NemCQfEvCt2KSWTiyYhcCTYK5XdDbYxQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Q7yZ8h2P2ITxKAoa24C4wI5SGaKb4L1kncD6PiP9xZc9Fs88nwZw7ISE0a8dGKcYd
	 esusn6l2cF3tCWXwumVt6vjJAEgXKT0AvfXm0uzakjkRpRc9DFl4QCfZofKcGtI7iJ
	 u2cYFhhyEmnSw3hVeQB/aJTKZ7FbJBZX/DhCRQ59+BrlJ8xCBJX1I+ZwdTulZWhjU+
	 lnX8SbVvNkfxWStm3g+QlRf/H8FN/VVGobQuwu+bsZIQjyF3Iot5oUcxbfa+Sns9ki
	 A0A7TrYYeSPJTTfnEnVOVX0U/TOjV8AqlbEqWdR3i03hwOb1XI9UKvDHl8WWOICCFh
	 gTvmzNqz9gNyA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59786C56203;
	Wed,  5 Aug 2026 13:03:09 +0000 (UTC)
From: Colin Huang via B4 Relay <devnull+u8813345.gmail.com@kernel.org>
Date: Wed, 05 Aug 2026 21:02:37 +0800
Subject: [PATCH v4 09/12] ARM: dts: aspeed: anacapa: evt2: Add shunt
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
Message-Id: <20260805-anacapa-devlop-phase-devicetree-v4-9-5d67e0efa6c5@gmail.com>
References: <20260805-anacapa-devlop-phase-devicetree-v4-0-5d67e0efa6c5@gmail.com>
In-Reply-To: <20260805-anacapa-devlop-phase-devicetree-v4-0-5d67e0efa6c5@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 colin.huang2@amd.com, Colin Huang <u8813345@gmail.com>, 
 Peter Shen <peter.shen@amd.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785934963; l=2147;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=WNTfq2afBfA8+J3QozrER71+gm8MPJIV48F5xeH186s=;
 b=QLogMmJXmliinv4lrYX+5lFkN2Uhf9TjbCvPpr8Q7cqQCrkftYtW5bdPILzTkrAsJ4GjoaIkv
 9EkQqG8ds2UCEX8WWM0UoFv4B0a6wR90PQE4Vzz7YLzQkqQ7s47RCWx
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



