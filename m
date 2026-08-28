Return-Path: <linux-aspeed+bounces-4880-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 102C2C61DE2
	for <linux-aspeed@archiver.kernel.org>; Sun, 30 Aug 2026 23:49:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hY83m3By2z2y2f;
	Mon, 31 Aug 2026 09:49:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787902557;
	cv=none; b=MI0LIlDBDgxR+HLG0hLUHZlDmiIaLHBKUH7cGDqXu4epA8EvdMMnqmJy0nJ1Vw6oCyS1qeqYw+c3T6+RERvEHM3v1BOVApC9I/i78tV//B/48uONjiAm+iR2RTK5eom3vfBZOyQ6X+tV52xROyochzAZZwZpHp/iI9vPmMWoiTmeH0NcwKRD4RCFQfgJyHmwHaa+d38aq4APPdg5TY+SFmmeX/qT+KWFW2Y4blLL0hhdq+KrDG3cE1hRc1EQDvyKMpzna/E+YOEKGaa+5DZJFhEofx6+C+9oypjj9sUQfBJYrjyyA+LK1yvMYnrBpw4xBGAxYV0fuiF16mac6pHYJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787902557; c=relaxed/relaxed;
	bh=+l02QjJZPgdNDkG0wt7GBmzVqxHnEVWXGF3do2KaOC4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bajJoGKIEYS1hE9LHHI/sq7FF3Cc20NFAkDhK5TC7oir7lP0hspW8p7EqCybwqxE4n54KuRcUHp00BE3Se8t61V6BGl+8hEddx7wVTgqE1NLopLNYlDPr5TUlxO5foj/R3tPRvVBIPY8XEUOVyt+qSmvt3KlX8N1/tUr9m20jmjDgK5IFCg3+RUcgeDmU7nG+R0UupHhWvxErmUhLJ+EHwTsolRXVi8Xn0xrOWL6SH+MA8/ZOns3T/O765XZsfLnN8HPwk1pQBM73zwQm2VAFX5gKgPiJSPA47WDCxuU5Gx1+R2nhWGGJFZTqniSV8GwiXQd6NyK+h6qGcxgC7Wo9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=P6fcJnYB; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+dirkchen.amd.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=P6fcJnYB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+dirkchen.amd.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hWVYS2Zqyz2xLg
	for <linux-aspeed@lists.ozlabs.org>; Fri, 28 Aug 2026 17:35:56 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E78C143502;
	Fri, 28 Aug 2026 07:35:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBA88C2BCC7;
	Fri, 28 Aug 2026 07:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787902552;
	bh=ZOBCA19VLQ1IKCeBijN70gbTvNCwCmZyIOxmk5n/RS0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=P6fcJnYBFAFPNb+rLD734AKtJZcm1UY1AB47GGgxYNn4IbpsJSChO+h5+D5yJlZse
	 RIAWAI0xYunON7sNE00ky5MVvuK7wJyfEXeJ3CbLzjCBZPUD2Mu5AR1bsFLW6ufFRV
	 x0jdeRZhGN+f5/AGL3NDJxAvma3nYOG27SN9zo3gpV3u0b3yk8CQUw1s341F9rg1TP
	 cYkWPTlHp9qGMcritB4wmWw4wupiVMVckfHJKgeSGekD4TOnrRWmXBDzHaLUlYMl2E
	 mV+rkDDq1qMiKYU2bhuB8hCatrtWC8wApefGpj3/C0YQkP+P4M3c2+lMG4PstWkZTE
	 lrZU0yfETzXEQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99041C61DCD;
	Fri, 28 Aug 2026 07:35:52 +0000 (UTC)
From: Dirk Chen via B4 Relay <devnull+dirkchen.amd.com@kernel.org>
Date: Fri, 28 Aug 2026 15:35:38 +0800
Subject: [PATCH] ARM: dts: aspeed: anacapa: Add MCTP I2C controller node
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
Message-Id: <20260828-anacapa-dts-amc-v1-1-463eb4e6a6a2@amd.com>
X-B4-Tracking: v=1; b=H4sIAEk6kWoC/x3MPQqAMAxA4atIZgO2hfpzFXEINWoGa2lEBPHuF
 sdveO8B5SysMFQPZL5E5YgFpq4gbBRXRpmLwTbWN53tkCIFSoTzqUh7QN8aG9reO14clCplXuT
 +j+P0vh9XFmTzYQAAAA==
X-Change-ID: 20260828-anacapa-dts-amc-6712c7963ef3
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Billy Tsai <billy_tsai@aspeedtech.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Dirk Chen <dirkchen@amd.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787902540; l=1212;
 i=dirkchen@amd.com; s=20260202; h=from:subject:message-id;
 bh=rEGeEm+ATZyoe3HxKSYL2gspIoEHBpWwgs2ytKBM6Z4=;
 b=Z63sFH/O7K+hj/ourvWsfKtVprO2gAFZc2jSHH6Tbxnbat8MpVQlRfpYi3XVYZFUWaSrvasBs
 +1b7UiNVonCDvhTqDRb4Ig/k6pcCe5oU0prhRBDgXib5zdgVH7BKUkW
X-Developer-Key: i=dirkchen@amd.com; a=ed25519;
 pk=NBIyLsVg/YYtGLruq9XLdLWx2PP/1MH4jDDQ1V+7wes=
X-Endpoint-Received: by B4 Relay for dirkchen@amd.com/20260202 with
 auth_id=622
X-Original-From: Dirk Chen <dirkchen@amd.com>
Reply-To: dirkchen@amd.com

From: Dirk Chen <dirkchen@amd.com>

The Facebook Anacapa BMC uses I2C5 as an MCTP (Management Component
Transport Protocol) bus. This patch enables the controller by
adding the mctp-i2c-controller node under I2C5, with multi-master
support.

Signed-off-by: Dirk Chen <dirkchen@amd.com>
---
The Facebook Anacapa platform uses I2C5 as an MCTP (Management
Component Transport Protocol) bus for communication with the AMC.
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
index 1fddf3a5d138..6073a643ea80 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
@@ -433,6 +433,14 @@ i2c4mux0ch7: i2c@7 {
 // AMC
 &i2c5 {
 	status = "okay";
+
+	mctp-controller;
+	multi-master;
+
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
 };
 
 // MB

---
base-commit: 3d83758432b5e6ed9507500a57efb0f3af41ee7d
change-id: 20260828-anacapa-dts-amc-6712c7963ef3

Best regards,
-- 
Dirk Chen <dirkchen@amd.com>



