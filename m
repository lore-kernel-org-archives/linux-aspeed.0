Return-Path: <linux-aspeed+bounces-4543-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB602C44524
	for <linux-aspeed@archiver.kernel.org>; Thu, 23 Jul 2026 03:48:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5HD52lSxz2yfS;
	Thu, 23 Jul 2026 13:48:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784778533;
	cv=none; b=g7570rgC/nfdTIXZ86SEqsASN47hma2V27NPoJbojyJ2JOv4Cim7tXU4BMguX9Sbwh2VyrHGpxPEpXKoisU/7pSJtBH6Yge3B1TQyLzjGlBgeo1KXb2j7qqMbO9SZk4Lcf0yVw4HwHgCtyay/Ehz0YRSlb5yJfW6rbQfCI6nSBzRfvBbxONG8smjg3nPnhJwNe3XFt+5pAKwA0KB1HlHEOnLbDLPjzCA9IjvD/t7OXZXPwNwxEtl3Rm9Y4uUa2jYTmaxTu9SxfBF+1fzabVXymuZymr+ww8n9+JbJEa5cPQOjmLvJj1XZ8JdCTUpaKNxwc++786iWPYJH6WAfbsobA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784778533; c=relaxed/relaxed;
	bh=Ct6A69eIy8M8/F/aRHvQbC7tJPRJSKR5xYVgwqSRpk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=eTc3I2ce03oPeon5lpZSLaFqDu1RZTxJm0jDI49iO5JS6rzc5/WftPr3RN/0d/u1TMTBmgoDGtiGOc/86voDQ8PpZUjX89wv1bftUzP4ao434Biu2JGTFw+9re79EyJ6+XVcRJzSaalrHo9L/m3I/6Cvn1ZTKx9FDDQoTZ7fHUca5aJZZg8KKhIPfsjYZ/JLSebrFrcpagh2Lk+MXZ1t0jR9F6PCl3a++0uz/zCUbEMnV6/0SsvJrhvmG8AxOeaP4H8pwXvg9nF9VDkHq7HbLQ96Wglv9fz8/bdeGF5JVHLjUHn2KuBrWi8oPXdG1I/MMql8s0Ni8XRjSBWJG34Fdw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=jammy_huang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5HD43nbjz2xJT
	for <linux-aspeed@lists.ozlabs.org>; Thu, 23 Jul 2026 13:48:52 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 23 Jul
 2026 11:48:34 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 23 Jul 2026 11:48:34 +0800
From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Thu, 23 Jul 2026 11:48:34 +0800
Subject: [PATCH v2] ARM: dts: aspeed: g6: Add missing uart nodes
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
Message-ID: <20260723-upstream_g6_dts_uart-v2-1-4951ae6b4ac4@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIABGPYWoC/4WNQQ6CMBBFr0JmbQ0MStGV9zCElDJCF9BmphAN4
 e5WLuDyveS/v4EQOxK4ZxswrU6cnxPgKQM7mnkg5frEgDlWeYlaLUEik5naoWr7KO1iOCpdm6u
 lssNal5Cmgenl3kf22SQenUTPn+NlLX72T3AtVKGwIo3dRXf2ph9GAlEfyY5n6ydo9n3/AnZeV
 L69AAAA
X-Change-ID: 20260327-upstream_g6_dts_uart-78a5ce3b2873
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Jammy Huang
	<jammy_huang@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784778514; l=2543;
 i=jammy_huang@aspeedtech.com; s=20251124; h=from:subject:message-id;
 bh=q9hDcLVgLxrUGo37KNtSJnNiFCPmBGY9FhkK/ChAGFM=;
 b=NT1RKytf/ZW/AuqE/8pQQxHdslunNiGhDK3q1vJvWwxdFiVn7tP/ID/jZhF6pk309F+Gtd7jp
 CWEaT9YAsAQD8TYQlJXvr2xeKwyolAR5ZjxrpR8Ci1nCXt5wqFVvelj
X-Developer-Key: i=jammy_huang@aspeedtech.com; a=ed25519;
 pk=E5YwijeJZZcuDR6srvwNlXrNHvLxwipUg3Mb/xxUF9o=

Add nodes for uart10/11/12/13.

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
Changes in v2:
- rebase on bmc/linux.git aspeed/arm/dt, no functional changes
- Link to v1: https://lore.kernel.org/r/20260327-upstream_g6_dts_uart-v1-1-26e72b47bc97@aspeedtech.com
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 56 +++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index edf4b74f5ab..fb21e353005 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -844,6 +844,62 @@ uart9: serial@1e790300 {
 				status = "disabled";
 			};
 
+			uart10: serial@1e790400 {
+				compatible = "ns16550a";
+				reg = <0x1e790400 0x20>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART10CLK>;
+				no-loopback-test;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_uart10_default>;
+
+				status = "disabled";
+			};
+
+			uart11: serial@1e790500 {
+				compatible = "ns16550a";
+				reg = <0x1e790500 0x20>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART11CLK>;
+				no-loopback-test;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_uart11_default>;
+
+				status = "disabled";
+			};
+
+			uart12: serial@1e790600 {
+				compatible = "ns16550a";
+				reg = <0x1e790600 0x20>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART12CLK>;
+				no-loopback-test;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_uart12g1_default>;
+
+				status = "disabled";
+			};
+
+			uart13: serial@1e790700 {
+				compatible = "ns16550a";
+				reg = <0x1e790700 0x20>;
+				reg-shift = <2>;
+				reg-io-width = <4>;
+				interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&syscon ASPEED_CLK_GATE_UART13CLK>;
+				no-loopback-test;
+				pinctrl-names = "default";
+				pinctrl-0 = <&pinctrl_uart13g1_default>;
+
+				status = "disabled";
+			};
+
 			bus@1e78a000 {
 				compatible = "simple-bus";
 				#address-cells = <1>;

---
base-commit: 749c34389679f8d56cb200a69b62f9a64670034f
change-id: 20260327-upstream_g6_dts_uart-78a5ce3b2873

Best regards,
-- 
Jammy Huang <jammy_huang@aspeedtech.com>


