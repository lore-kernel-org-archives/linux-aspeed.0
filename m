Return-Path: <linux-aspeed+bounces-4861-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD56C61DBD
	for <linux-aspeed@archiver.kernel.org>; Wed, 26 Aug 2026 00:16:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hV4tk432sz2ygK;
	Wed, 26 Aug 2026 10:15:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787654926;
	cv=none; b=fI/psRtuK3Z2bwLfPWpjtKhdzipk5qCoC33O+GuTFJK0KnTTYwNKzUePyClI7FuySS/Mr6PcQfdTOyiMgebxSzCY7M9tzCpe7fRwZ+WksKRB402PDs337I75O574uWayzsdg2hszPXuuIa+nodIHXHBQ9JM2g16ElzpfydpxSRl0nC5KBZPQZfyw2H1MQcnPHMy2hPT/LeL+e4fyFwWX4Vmnv7VdDiZc8POnP1ORtr85S65u2pAzOvxBUWnGtj4n40PrFQU4ny20LbDnNBk73NxInMrSm08f+IuAfWRMGBWg5ZoTnxZiKLR9bGTR3r6a4+yakvl2Eix5gBD60rEItw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787654926; c=relaxed/relaxed;
	bh=g4GD5tAd+3DQUnSfDKDsU0BWThEq3BCJxjpI8lKaAr0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TqWFb+WWBH8vIekWGdt8Tke0YbJpjQKzitkZ70trQg9516vetTMU55EHcLghUF/fpmDGCrUFCE1SstWEnE9ITWNa2D9tjWUL5h/1ceC1GtxSiQj98nMBihcCG3641XcDIRNU/IzeprAAP1B1M6g88Vy89PjSx0ArK/jmu4Deoa+91WOV5O66UqjP94Nk0U8NKy1Eroq61gP0QNDcJ0dWVyPuQZacisM9Q+c3d/+ibG1+KV7CN0+R9JlJpI2R85ugvRbLscVyY1GrT6zs4frLFOY+LwO2W1xbsNScEhxe2Z+uveLQIWqqiGWAU6I9Fm4qzfaQU4lionM1E1Ktw5kdnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OSFvEz5o; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OSFvEz5o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hTkzJ1W1wz2y1F
	for <linux-aspeed@lists.ozlabs.org>; Tue, 25 Aug 2026 20:48:43 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 86F2244EBA;
	Tue, 25 Aug 2026 10:48:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 667DEC32781;
	Tue, 25 Aug 2026 10:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787654920;
	bh=hOPf1LjDT4s/OsOzZ2OJtL3XdwwW4MxYaI4DYi2V2sU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OSFvEz5oV8Y3l/1TyLawkleLuvr2nBr89ZNKh22mbjevlimUgbpVaJyT6pqqVsLJd
	 M01Q9d0g71TSoK8dSsPJM1jPbb0OAuajb3uGsRZeWTcvqGeYAnOH5TWMw7uvgmJDob
	 Vt3CuHgZhSZ8+YYhYiRBl1jOik/3OZFxe2XsVTfI4aRcrgSqC1TQl1YfHXYdeiw3Ly
	 cE9octPQldmxLD+Oi42p1gQGBVJsgYPZonl24wGEtTaAQhnKdD1hp4rp3Z5z1fP+mI
	 byYu3FV16JO1ObHhH0asIs71U9+sm/tX+zF9dKwasqFsztlAfA7ncLrnmMVRdhF40O
	 QV05thF2EWRtg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F5BC61DB6;
	Tue, 25 Aug 2026 10:48:40 +0000 (UTC)
From: Colin Huang via B4 Relay <devnull+u8813345.gmail.com@kernel.org>
Date: Tue, 25 Aug 2026 18:47:47 +0800
Subject: [PATCH v6 06/12] ARM: dts: aspeed: anacapa: Add eeprom device node
 for NFC adaptor board
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
Message-Id: <20260825-anacapa-devlop-phase-devicetree-v6-6-9059a2a279ce@gmail.com>
References: <20260825-anacapa-devlop-phase-devicetree-v6-0-9059a2a279ce@gmail.com>
In-Reply-To: <20260825-anacapa-devlop-phase-devicetree-v6-0-9059a2a279ce@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 colin.huang2@amd.com, Colin Huang <u8813345@gmail.com>, 
 Carl Lee <carl.lee@amd.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787654905; l=842;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=W3IShAyxygRLxWChQBNmztwL/6A+5D13GAPOb/9nyvI=;
 b=5x1Obe8eZXfIFVi/XcjUmqoHbfzWEKr0Q2Ht3cV/i6rI0oARG/5URdCp987sJGxoggp4J2waU
 Fy/L2QvVoLqCe/2IXYU1hvkPrEWLB4L3HvsOWWn5V0E56PpgZEwEYKk
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-Endpoint-Received: by B4 Relay for u8813345@gmail.com/20260202 with
 auth_id=761
X-Original-From: Colin Huang <u8813345@gmail.com>
Reply-To: u8813345@gmail.com

From: Carl Lee <carl.lee@amd.com>

Add eeprom device node for NFC adaptor board FRU.

Signed-off-by: Carl Lee <carl.lee@amd.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts    | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts
index d2b4855ff1ad..22f79a2c2639 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts
@@ -22,6 +22,19 @@ eeprom@51 {
 	};
 };
 
+// MB
+&i2c13 {
+	i2c-mux@70 {
+		i2c@7 {
+			// NFC adaptor board FRU
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+		};
+	};
+};
+
 &sgpiom0 {
 	bus-frequency = <2000000>;
 	gpio-line-names =

-- 
2.34.1



