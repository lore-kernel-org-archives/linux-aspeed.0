Return-Path: <linux-aspeed+bounces-2585-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B159CCD1BF
	for <linux-aspeed@archiver.kernel.org>; Thu, 23 Oct 2025 22:52:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ct1W24Frqz3bW7;
	Fri, 24 Oct 2025 09:51:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761215253;
	cv=none; b=OPw72crD+N2hW73tdj6zThYvFlwF6h32aO+5k3ZYH+SRKMSmbsbyJyGqct5NJKD3vgapFcqVhPCe7cy7TsiJdvaiFnD9EZ/5q7JA6k5DiO4mKs1sFjtA2EF0R43/awu866VE4dhRaU+M6YLzJAvkx3SoedSkyP1k+COa5c0ij7e/gEI3CkNkwWRTLqWwaG+Mr/xK/HqC7JcFEoOaBo6VuJ8uZbzioOQXHFgD/Y9DqRxektgDDerr5hOu3wG9zN3fTHaBUNmXPvTIbUzokYsluN5EPJZ9vt6WBPvKFfwzmLx7AhI1PQ+0/DiboGEysvCYPU7TZ7P0Y//J/va+Jp6X/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761215253; c=relaxed/relaxed;
	bh=rDaarJu+1lMV7xrBDAmTOi1odQwoiS3QEl1ot3QDFr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OXj47vT0OBNenkJ3MMf4le9xXARQh3q/E6CEPiB0jvcwMzrYkFFRuFJiSGi6oA4R/4IHP6mGi/8S/kO88G2UWpwZcUyPGZ3GOCtpYcLsn5YyrsVdl1XC+BW+eCtOn0mv4tBk0qZnu2KsPhEoTGay3BPK01RU5YvNYkEz7VJmMCeLaMKIAhWfujTeZz79s08DJeZWZCrZ6tK8N4wb46MIGmvW4tevadakqZpXO5kfyg8Nyb4TncFXsNsU6FWx7X5VE9zHCZJm2amTqRDv7xj6h4BZyvp/eJ5jIZglT4Tq/Xi/3qiYodL2Tb9e05D3QK68w+yUaHR3QBPquDIKajT8Uw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KtZzY7+K; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+alex.ts.wang.fii-foxconn.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KtZzY7+K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+alex.ts.wang.fii-foxconn.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4csj0440M8z304l
	for <linux-aspeed@lists.ozlabs.org>; Thu, 23 Oct 2025 21:27:32 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E2C10440B8;
	Thu, 23 Oct 2025 10:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5F0BC4CEFB;
	Thu, 23 Oct 2025 10:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761215248;
	bh=9moM1zvWggM59ECkKTAgJYY6tGFpdNeypAAeKDaTrsc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=KtZzY7+KK5fh0BsjWRQXOLlZcL8+4/Wrjg8izY1b9HxLlZtAtlFMrx2GPoFESdEgh
	 ETw77KIaAUcLP1EqRIK5RGJuBUxJOwoHFTEhlzFj+E4UJYILRJiGsQsqh5Grt24xH+
	 L8Qzrjx1SDCoHVqUWTc8WMU+dCPdS7nULcZoIHPbpYI6U1vJaw2Tw4V1mEqoUaKt42
	 tXGDcoDYlBF3HriqpoZEpQbqP97SNUYpHUv1YUn6tzH3Jexv4G9rTOCz8MUbplUqY9
	 kXSujti/0bFNyxLk3m5QlGnLr4W7mVB+a2Zze+Qx1guUCQE1srfgcIUdAK/Ebg1M4F
	 GGhnds9rbNdrw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BF8CCD1BE;
	Thu, 23 Oct 2025 10:27:28 +0000 (UTC)
From: Alex Wang via B4 Relay <devnull+alex.ts.wang.fii-foxconn.com@kernel.org>
Date: Thu, 23 Oct 2025 18:26:56 +0800
Subject: [PATCH] dt: aspeed: clemente: move hdd_led to its own gpio-leds
 group
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
Message-Id: <20251023-leo-dts-add-shunt-resistor-v1-1-5d9980aba308@fii-foxconn.com>
X-B4-Tracking: v=1; b=H4sIAO8C+mgC/x3MQQqEMAxA0atI1gZqpYN4FXFRTEYDQytJFUG8u
 2WWDz7/BmMVNhibG5RPMcmpomsbWLaYVkahavDOh875Hn+ckYphJELbjlRQ2cRKVvRDLdwnBoo
 MdbArf+X6z6f5eV6VPZlpbAAAAA==
X-Change-ID: 20251023-leo-dts-add-shunt-resistor-2810206a5dae
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 george.kw.lee@fii-foxconn.com, Alex Wang <alex.ts.wang@fii-foxconn.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761215247; l=1426;
 i=alex.ts.wang@fii-foxconn.com; s=20251023; h=from:subject:message-id;
 bh=nhjdaQhGONa6qRe6C17O9kT3BPIniN47qBnafl7NHt8=;
 b=un87bQXpomsn/0FLsOCFLiEpZ+BJAggKp/q9MiS5J3KjRJmifLf7SQcSV3kCAhfv3Qyd3/5/9
 gX5dDcKJ9s/AEHQk5fY+7RY7xwxkO6/DDYnjudaSMejQr96SpfDXuRx
X-Developer-Key: i=alex.ts.wang@fii-foxconn.com; a=ed25519;
 pk=m/IrKXb14uSdDm4KGXemjNIxgL6TrqXCc9NX09SUJp0=
X-Endpoint-Received: by B4 Relay for alex.ts.wang@fii-foxconn.com/20251023
 with auth_id=551
X-Original-From: Alex Wang <alex.ts.wang@fii-foxconn.com>
Reply-To: alex.ts.wang@fii-foxconn.com

From: Alex Wang <alex.ts.wang@fii-foxconn.com>

The gpio-leds driver requires all GPIOs in a group to be available;
if any GPIO in the group is missing the whole group will not be
created. The hdd_led GPIO is only present after standby power is
enabled, which can prevent other LEDs in the same group from being
created and blocks properly setting 'bmc_ready_noled'.

Move the 'hdd_led' node into a separate gpio-leds group so that other
LEDs are not blocked and the 'bmc_ready_noled' flag can be set
correctly.

Signed-off-by: Alex Wang <alex.ts.wang@fii-foxconn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
index 450446913e36..c58922695f46 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
@@ -96,7 +96,12 @@ led-3 {
 			gpios = <&gpio0 ASPEED_GPIO(P, 5) (GPIO_ACTIVE_HIGH|GPIO_TRANSITORY)>;
 		};
 
-		led-hdd {
+	};
+
+	hdd-leds {
+		compatible = "gpio-leds";
+
+		led-0 {
 			label = "hdd_led";
 			gpios = <&io_expander13 1 GPIO_ACTIVE_LOW>;
 		};

---
base-commit: b5dd162282164dc202541ce6551cf705d345820e
change-id: 20251023-leo-dts-add-shunt-resistor-2810206a5dae

Best regards,
-- 
Alex Wang <alex.ts.wang@fii-foxconn.com>



