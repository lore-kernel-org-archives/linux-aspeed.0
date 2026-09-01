Return-Path: <linux-aspeed+bounces-4912-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC03C61DD6
	for <linux-aspeed@archiver.kernel.org>; Wed,  2 Sep 2026 00:07:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZNNC2p1Kz2y8d;
	Wed, 02 Sep 2026 10:07:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788264950;
	cv=none; b=OCSXeEmG3sofkStQUpVTEEkJNYq4YwRFzWGqnoMwxe2Uk36DAz5t1h9xcGFrRoN4zqY95buji9n+7GruUcvI2RWscPBp1te/RQu+h11+h8njPygkg6Lg1IjCtG6985F1L243muK7XDx6PLrxYZVPqhEtL+mrtz+uL1LMQ7nL2Q+auC7t1J7VX5pxedKpS6fkUTpsHtEQTRDCYSwqbGAEllEvvETV6zHNVF7BBIXpkihS/Lw/k88eSGsd6aYEfHwPBBxWTm0TudgKd5PTt+Ke9NyZbwzSh7QczaVenbF4DSZ6ufYyyz06g/HVJwEtGqzkmrApcNmGSchm3KqXbvQ01g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788264950; c=relaxed/relaxed;
	bh=G15OLlb8BNxHhKtxBYPBZO5Y8Xgs6zR8B1vnSey/Pds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DEQQXW5ene5uYHrDAzzHdl+qQ6iHMrJtqNBIJE//B2mXUpmvPNZBgY1rV6mKozRNEzkUFXPPzfBW8WTDKvXEKJbG7ACnQpxnGYCAbPvk03rJ4AqmXI/RvyU0BjFj4zvdkZofF8igIiYbpxJ2NLErKUylAy3liKRSR4Ci4IHWD/NrRpWPkRzqwThCbAwuoz1L41IDmpHfvWq1Ba2huSb7CysHG3riJ8YCquEAsPPNDch28oiERS4Havtjzj9t2jikPY4smqU/I843YJXKPoXj3aXxpJec1RyH+y3VJrO/Eo3QNyofdwTeRGp81Oscux9Y/ZKrYATMC7ZnDPA8vY826w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mSE4ZrSI; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mSE4ZrSI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZ4ZY04mtz2xpn
	for <linux-aspeed@lists.ozlabs.org>; Tue, 01 Sep 2026 22:15:48 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6A79B60A82;
	Tue,  1 Sep 2026 12:15:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1EAE2C4AF52;
	Tue,  1 Sep 2026 12:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788264943;
	bh=U0nlzt3GQrEhW9lHsZWaloQdOHudVOamVF/QIb8C8ms=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mSE4ZrSIbBufXBA82eLDZL+kdH09S4hm8kyLadSDY8ekMVE4jZC1vuMlQzqFVyHXN
	 xUFDI/5l60iCpTUIi2USEEYPzeHRWaHw+2cKdd6yWiGJjFdwvCbVaaQKIRr6Q9WrtZ
	 sUKOhCFmAG5U2bSqiV+uCbuUFKaAVc0MzXEz1Y6DJWGfTy/WTPg9x7q+CI9kMvvwQy
	 YJhFYzVi05yTZ1eR8n0Xb2TDbhtjOJJMx3iyOZsIVHCMjziduINj3hNo9hBGY+Fo4v
	 l6JYw1k3rB0CBEWOTGrA7DM7MFE3F/y5gjUg8O91VuSWvXg0H2mddPy+aHBo/s+ODM
	 sR1sLgWO3dSJw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2F3C624D3;
	Tue,  1 Sep 2026 12:15:43 +0000 (UTC)
From: Colin Huang via B4 Relay <devnull+u8813345.gmail.com@kernel.org>
Date: Tue, 01 Sep 2026 20:15:23 +0800
Subject: [PATCH v7 08/11] ARM: dts: aspeed: anacapa: evt2: Add shunt
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
Message-Id: <20260901-anacapa-devlop-phase-devicetree-v7-8-0bd71d2e0105@gmail.com>
References: <20260901-anacapa-devlop-phase-devicetree-v7-0-0bd71d2e0105@gmail.com>
In-Reply-To: <20260901-anacapa-devlop-phase-devicetree-v7-0-0bd71d2e0105@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Billy Tsai <billy_tsai@aspeedtech.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 colin.huang2@amd.com, Colin Huang <u8813345@gmail.com>, 
 Peter Shen <peter.shen@amd.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788264931; l=2046;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=3PJIko2HxXfn3+qbGJ71r5pZFx7EAq9CZKMxe8Oqcys=;
 b=VdT2ZY1Sy1/ZuhfWeDB3NI57vohjfLLT5uykMW0yx5Npe3R4lMpPLOXY2tNdVrgwOthCKpaIa
 tB+X8TmroJHBpF2J4GktUGvER/5UHdxuqJ7QqVqEAU6Il7fq8aojxxJ
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-Endpoint-Received: by B4 Relay for u8813345@gmail.com/20260202 with
 auth_id=761
X-Original-From: Colin Huang <u8813345@gmail.com>
Reply-To: u8813345@gmail.com

From: Peter Shen <peter.shen@amd.com>

Add shunt resistor configuration for LTC4287 hot-swap controllers on
Anacapa EVT2 platform.

The resistor values are required for accurate current and power
measurement by the driver. These settings reflect the actual BOM used
on EVT2, where different sense resistor values (150 uOhm and 250 uOhm)
are populated across rails.

Without this configuration, the reported readings would be incorrect.

Signed-off-by: Peter Shen <peter.shen@amd.com>
---
 .../aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi   | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
index c0b2976ad9e9..92be113463de 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
@@ -38,6 +38,30 @@ gpio@24 {
 					"RPDB_FAN7_PRSNT_N_R", "RPDB_FAN8_PRSNT_N_R",
 					"", "";
 			};
+
+			power-monitor@42 {
+				compatible = "lltc,ltc4287";
+				reg = <0x42>;
+				shunt-resistor-micro-ohms = <150>;
+			};
+
+			power-monitor@43 {
+				compatible = "lltc,ltc4287";
+				reg = <0x43>;
+				shunt-resistor-micro-ohms = <150>;
+			};
+
+			power-monitor@44 {
+				compatible = "lltc,ltc4287";
+				reg = <0x44>;
+				shunt-resistor-micro-ohms = <250>;
+			};
+
+			power-monitor@45 {
+				compatible = "lltc,ltc4287";
+				reg = <0x45>;
+				shunt-resistor-micro-ohms = <250>;
+			};
 		};
 
 		i2c@1 {
@@ -52,6 +76,24 @@ gpio@24 {
 					"","",
 					"","";
 			};
+
+			power-monitor@40 {
+				compatible = "lltc,ltc4287";
+				reg = <0x40>;
+				shunt-resistor-micro-ohms = <150>;
+			};
+
+			power-monitor@41 {
+				compatible = "lltc,ltc4287";
+				reg = <0x41>;
+				shunt-resistor-micro-ohms = <150>;
+			};
+
+			power-monitor@45 {
+				compatible = "lltc,ltc4287";
+				reg = <0x45>;
+				shunt-resistor-micro-ohms = <250>;
+			};
 		};
 	};
 };

-- 
2.34.1



