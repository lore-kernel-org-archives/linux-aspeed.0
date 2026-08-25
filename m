Return-Path: <linux-aspeed+bounces-4854-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8D6C61DB9
	for <linux-aspeed@archiver.kernel.org>; Wed, 26 Aug 2026 00:10:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hV4mx13wRz2yYd;
	Wed, 26 Aug 2026 10:10:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787654929;
	cv=none; b=jrL9rVj8BuWX6wUjeS4cZKv3zOjPh3FEchIvvpq8qmtBUSJf5rj+4D9A2iqCxqgB5tCleKnLrGUCxGO1Q+3/sY4oEKG4a116XvCtzCDyrcWrYTMgQSzUtfC8VmiCq70/DHMobhj9qvOAANgEtm/OxdqXbzcsDY0LeRMeqkehhVPL/zqIFmXOeI+nmTW0oJc2Er96fDhJsPByOHCinO+oBoBO1rD5W0Vj5veiLbw0i0DSbN1TbbTgyJDup6CWyqDZW2ltiEouYh6Z++Rs1WK+G44YI4ZobZUSx7ubg7BA7CiYlgKg129H9EFfr7Tyqk7b94io1Jpxv61aEqKSxNvwQA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787654929; c=relaxed/relaxed;
	bh=BTBOy9XW2gZktm9n25oDf5QpxmvNxqSjG7PPGIT1nP0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QYfi/y19jHBLqQXRmwp7n8COkmS9hZroq27v++zwHfCOX6lTxNX73GuAGRPTZsk1XpkjsGjxGxTaB6rzSzvCZNAe9/8XbKppn4O/mYFVjWP7i1cXyVvgiGePnWd70MjMrpp6eViEcN5gTUuU4/q1gMCcW1L2L2Qvw09GRz+IRsY9NojKkuw8Z1YmGVXmHVIeY/llycOPA9gB9sML37WPLEz7E06clh/9Jw/ItCTEZYihyDCXdiENDpZ1b6INWzAsU8OqHnXh1ZGi4e6cyHJv0xWj01iXKXrYITTYtSUENrXKSNDIVMgXq4m6K12O9lnmXpm/tDEvYMSrDewn1VgiDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ir5hUKw8; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ir5hUKw8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hTkzN6GX2z2yDD
	for <linux-aspeed@lists.ozlabs.org>; Tue, 25 Aug 2026 20:48:48 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3DEF944FDB;
	Tue, 25 Aug 2026 10:48:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 112B3C4AF12;
	Tue, 25 Aug 2026 10:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787654921;
	bh=16Ku8dX3mO/gcbNRdCYEkNsA7bUoTUoknNALDTnAIUM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ir5hUKw896BzQ5HWKZv1sLJSBbsgEQPbUkb0A4gDm3R8WoxYOMbf1XrwiCgCW+e2/
	 DlztZnWWaa+W+NmOQz9CqHT4JO/ixxs8JOAqJTlbrsP9pMH2AKP1PI3NiA3pRbj104
	 t2y82J/hUhKFcp+ydhnsIUDBpWOelBugr/gimbCdhreR5Zh2hvDT+kg3tWe9HaBrHP
	 4mUO4OpL/Vc4r2p4fxx5cnBj5hSSLLd9abO2Apc9H6N7KsoL8c7BoZBQUMKcNL/i12
	 +9LFfzfTh8daApDKwET9oC+vTNoRwFlVJw9AJQop+GWisbmOk+nhQC5zpVQq7L9koo
	 SQMLgIR2fg7RA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAA1C61DC2;
	Tue, 25 Aug 2026 10:48:40 +0000 (UTC)
From: Colin Huang via B4 Relay <devnull+u8813345.gmail.com@kernel.org>
Date: Tue, 25 Aug 2026 18:47:53 +0800
Subject: [PATCH v6 12/12] ARM: dts: aspeed: anacapa: Add SPI flash VCC
 supply
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
Message-Id: <20260825-anacapa-devlop-phase-devicetree-v6-12-9059a2a279ce@gmail.com>
References: <20260825-anacapa-devlop-phase-devicetree-v6-0-9059a2a279ce@gmail.com>
In-Reply-To: <20260825-anacapa-devlop-phase-devicetree-v6-0-9059a2a279ce@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 colin.huang2@amd.com, Colin Huang <u8813345@gmail.com>, 
 Rex Fu <rex.fu.amd@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787654905; l=1370;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=LtEnhYtDTDdaFJ8Tq5vy4icjC937RP4+reqqmwZJfEY=;
 b=tPqM9x7iBx4Q7kaW/I2LUyeTaNwihkP+gBdmjQ9uMV+pvqC+B1zq5uUw2RQ4umZ7N8hhJCHjl
 rfrrsJmtiDxA1XkeI9iLyhclx/ysdHZhAwGTk2LJj6kxjjDlz53EkQH
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-Endpoint-Received: by B4 Relay for u8813345@gmail.com/20260202 with
 auth_id=761
X-Original-From: Colin Huang <u8813345@gmail.com>
Reply-To: u8813345@gmail.com

From: Rex Fu <rex.fu.amd@gmail.com>

Specify the 3.3 V auxiliary rail as the SPI flash VCC supply to
avoid using the dummy regulator during device initialization.

Signed-off-by: Rex Fu <rex.fu.amd@gmail.com>
Signed-off-by: Colin Huang <u8813345@gmail.com>
---
 .../aspeed/aspeed-bmc-facebook-anacapa-evt2.dts    | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts
index c36519a601a9..ecb1c86f9e90 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts
@@ -6,6 +6,14 @@
 / {
 	compatible = "facebook,anacapa-bmc-evt2", "aspeed,ast2600";
 	model = "Facebook Anacapa BMC";
+
+	p3v3_bmc_aux: regulator-p3v3-bmc-aux {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "p3v3_bmc_aux";
+	};
 };
 
 &{/aliases} {
@@ -27,6 +35,23 @@ / {
 	i2c51 = &i2c10mux0ch0;
 };
 
+&fmc {
+	flash@0 {
+		vcc-supply = <&p3v3_bmc_aux>;
+	};
+
+	flash@1 {
+		vcc-supply = <&p3v3_bmc_aux>;
+	};
+};
+
+// BIOS Flash
+&spi2 {
+	flash@0 {
+		vcc-supply = <&p3v3_bmc_aux>;
+	};
+};
+
 // MB - PDB
 &i2c8 {
 	i2c-mux@72 {

-- 
2.34.1



