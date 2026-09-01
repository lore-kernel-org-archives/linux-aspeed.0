Return-Path: <linux-aspeed+bounces-4917-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC6EC61DD6
	for <linux-aspeed@archiver.kernel.org>; Wed,  2 Sep 2026 00:16:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZNYw4sJbz2y71;
	Wed, 02 Sep 2026 10:16:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788264951;
	cv=none; b=abvRzBqQdBVGQ7eHLYg4Re1fUhuqXatUdFHU5J8e3qVVwP/7r4MsnjPE78f+ESGBS2swSKHofabT2KLQ1JQUZeTuNz9JnV5muyjEvVbmEU4GOy4Qzwm15y8MZ1ejyS2NFEmD47ujiqj3DxOpGl0A+8G+C7TjHbhwqGo4SKq8AtTsUhb0CWBqJJ9uvTH+c1K5OByTee9wKw0kw0xkgmCjSlFEqYYbfLv4JCkOFEzCGj0PTa2V8LD5544+7sgLGgqdUlrpzvpfnrYPOubbZOj9pELAkNEo5EdmQlWETfJGZwaNLdALAf0LPBHdJPMd0Z4xREoGqJJ75kRTI4KdY9vx+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788264951; c=relaxed/relaxed;
	bh=wQhcoC2nht/3a8yCqVypE4fO3O2Y73jajfjKQAzS5SY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l5xCI4oqq++w/7dwtH9koHrYk8Z2FVFPF3h6nZqvJZ062JC87HC1M46e24pzP2oEnt0z0o1o+m7BAGITZqkd2PDDdjQ/xlXRYSHKkNlmHRSiVKIrc8wblz8oJO0do0RweAI4HwMh9mk2EmBxXWA0nmrucryPxgcqhb2QXPaJXNkN8l3YcmOmO3N/nmIIN7n93ztj5vHrjCwEI49nEG2vTs6vGaSMZHd8pen2DJa9Dssc2Mgfafu9rivChPTFsB4z9rpEI/t5DRc/+KekNctX7fKEkuKsoMskaiorC8fqK0UxKGCZXILne0fe9bU1wG4mF1doJubsFRXSIewkdgjeQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fc4lO/Iq; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fc4lO/Iq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZ4ZZ0yJzz2y2B
	for <linux-aspeed@lists.ozlabs.org>; Tue, 01 Sep 2026 22:15:50 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A1BFA60AA2;
	Tue,  1 Sep 2026 12:15:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 549EBC4DDEE;
	Tue,  1 Sep 2026 12:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788264943;
	bh=mPXqrM8TVSfYFliy2MzwJrn53vceZBxZHt9eoeKdWpI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fc4lO/IqQ6e9uGzZgQG4gT2DyiX4qUdvvu/HhVTnvE1045+51kkOka731hajdu2tb
	 RoiJRS02pVXI8ykGqhBAyQgE7jdQ3dsruQy29WzfspcYaipD9skeZQHkhmUZ/UwDcn
	 DWhZJpbbSOm8eGPhsPS4Lm6taXQ1lP+iBt0kcF+/JZ+/HTw22Dpiiz8aGD6JTOK1C6
	 XKFSNlrKCGdz+RdU0jB+yfQVnHivsMUlbX+CNxEu8XIjFwDIbssjw/Sjc0ctrrZgZx
	 oVrD1coI+MKXgq+p9ZrmdDcVd9gyc14GDOTQpiw5D5ifILiLy/yDjxZLmoo4p19pNs
	 TcROpTNX/g7Sw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E75C61DD3;
	Tue,  1 Sep 2026 12:15:43 +0000 (UTC)
From: Colin Huang via B4 Relay <devnull+u8813345.gmail.com@kernel.org>
Date: Tue, 01 Sep 2026 20:15:26 +0800
Subject: [PATCH v7 11/11] ARM: dts: aspeed: anacapa: Add SPI flash VCC
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
Message-Id: <20260901-anacapa-devlop-phase-devicetree-v7-11-0bd71d2e0105@gmail.com>
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
 Rex Fu <rex.fu.amd@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788264931; l=1484;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=9gpVJ0rxiqE7qYFlpOIPmDWgZMRiE3A5HNXFZcYVMUg=;
 b=9J1LOfBjMbAp1VTrYffihABG/+4EhiCI8+ST60Oi8ipR58ZfyzTs6ZaAziKyHeLAAwoT1YTn1
 UcHwD9AU4dNACKtRWQT8IgNwWPVr10WI5FCM0SUlGkjkX2nQ0QoU43a
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
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dtsi b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dtsi
index 017700920cb1..03dbc9cfbb06 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dtsi
@@ -93,7 +93,7 @@ memory@80000000 {
 		device_type = "memory";
 	};
 
-	regulator-p3v3-bmc-aux {
+	p3v3_bmc_aux: regulator-p3v3-bmc-aux {
 		compatible = "regulator-fixed";
 		regulator-always-on;
 		regulator-max-microvolt = <3300000>;
@@ -171,6 +171,7 @@ &fmc {
 	flash@0 {
 		label = "bmc";
 		spi-max-frequency = <50000000>;
+		vcc-supply = <&p3v3_bmc_aux>;
 		m25p,fast-read;
 
 		status = "okay";
@@ -180,6 +181,7 @@ flash@0 {
 	flash@1 {
 		label = "alt-bmc";
 		spi-max-frequency = <50000000>;
+		vcc-supply = <&p3v3_bmc_aux>;
 		m25p,fast-read;
 
 		status = "okay";
@@ -1074,6 +1076,7 @@ flash@0 {
 		spi-max-frequency = <12000000>;
 		spi-rx-bus-width = <2>;
 		spi-tx-bus-width = <2>;
+		vcc-supply = <&p3v3_bmc_aux>;
 
 		status = "okay";
 	};

-- 
2.34.1



