Return-Path: <linux-aspeed+bounces-4234-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72601CD98CC
	for <linux-aspeed@archiver.kernel.org>; Thu, 11 Jun 2026 06:50:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbYDy5Ddqz2xl6;
	Thu, 11 Jun 2026 16:50:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781160626;
	cv=none; b=e+liFWJmtxnMAqCqtEkR7xR3UHh6wVJM20212boin/V8Sw+Z4voNm8xUtcrx40Lf3hM/UMvXVo5MC0guYApkxstMqMNM0F21LxHA5GPLUa8v1vOTWEaGZwuhnl1YrMX3eK5ciQ9YfXWmzVOMGzJ+QFGTnqxGe4G7M+81KaJFilT4xULxq+3VDe6P6Wk0jmy5lpF8EMmUDPbJU8tkPCo4vjhjnllj2tGW1KINAM7tsdCarT3Hakt8T90hSZsM3FQ2saXyxnDlVfwNmYT2SfS5gAb4vY6IuS20//3738AqVlbVKXaoFiPhT0lAwLYBT2lc8peA1jZ3nmRCRw2kAd/jSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781160626; c=relaxed/relaxed;
	bh=d/3KW645kadoWYBkkkiV3R/cBByrtaM6iiRuO1ZY31c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=II9qy4qW2ayUYnIqAGslwQOA+Rz8Pvf6NcdnKYfiK5Ec+/8SMNQWkS9fSVBPNpzVrftaspvQfgyPa1PRAmo0erp9dK4Lf2NFizAwulJRA0K1sKLFIiviVGN833IL3o1FN3i13XAwh8Jt1Mm/AAFuf6sPH3PwIK6MsJbvUt/tSkJIP9D/OfygOw45Ku849S2dR63PepjkkdPlprBPc8PcCQ1VsB+RPDwsAKiyKIPfBH80E27DljgmWSgDsxN33Y3ATswXYCcE3e3Suvnfb+QcPNemri47ta3rHRpwR6t5hoj68vj1UEQP3utEGFO1uwoa3sDY5mloTye0UTqPUzbZ1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbYDx4qwQz2xLq
	for <linux-aspeed@lists.ozlabs.org>; Thu, 11 Jun 2026 16:50:24 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 11 Jun
 2026 14:50:09 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 11 Jun 2026 14:50:09 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Thu, 11 Jun 2026 14:50:08 +0800
Subject: [PATCH] arm64: dts: aspeed: Fix duplicate pinctrl labels and
 address scheme
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
Message-ID: <20260611-dtsi_fix-v1-1-ef2b7cd86d6d@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIAKBaKmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDM0ND3ZSS4sz4tMwKXQNLyyRDw0RjI8MkUyWg8oKiVKAw2Kjo2NpaAKY
 AXaBaAAAA
X-Change-ID: 20260611-dtsi_fix-099b11a321b5
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Arnd Bergmann <arnd@arndb.de>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Ryan Chen
	<ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781160609; l=5765;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=8U6jz7rXtYL1MwCZPqGDf5fZs+4y+xyGRhjMMf47rOU=;
 b=O9wmMN7nZjWZ4LiaBz1UQB8K5FQiwQQye3VsCY92aIsBDGfBlwhNQ68rdmVUnuq1MT8XhoL1R
 byIXjsGNhUgDIjxeCHG6e77/P2X8uyQom931Pc1kK32Q0cXBpJexTUJ
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Fix duplicate pinctrl_tach{0-15} and pinctrl_n{cts,dcd,dsr,ri}5 labels
in aspeed-g7-soc1-pinctrl.dtsi.

Drop the cpu-index from secondary/tertiary container nodes: reduce the
"#address-cells" from 2 to 1 and update ssp_nvic/tsp_nvic unit-address
and reg accordingly. Also remove URL comments from the DTS.

Suggested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Fixes: e77bb5dc5759 ("arm64: dts: aspeed: Add initial AST27xx SoC device tree")
Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
This series contains follow-up fixes for the AST27xx DTS support that
was merged into linux-next (e77bb5dc5759).

Two issues were identified after merge by Andrew Jeffery during review
of the pending v11 series:

1. Duplicate pinctrl state labels in aspeed-g7-soc1-pinctrl.dtsi caused
   dtc to abort with fatal label-redefinition errors.

2. The synthetic container nodes (secondary, tertiary) for sub-processor
   interrupt controllers used a 2-cell address scheme to encode a
   <cpu-index reg-base> tuple.  Since the cpu-index adds no value for
   nodes that are purely phandle anchors, Andrew requested we drop it
   and use the bare register address instead.
---
 arch/arm64/boot/dts/aspeed/aspeed-g7-a35.dtsi      |  14 ++-
 .../boot/dts/aspeed/aspeed-g7-soc1-pinctrl.dtsi    | 102 ---------------------
 2 files changed, 6 insertions(+), 110 deletions(-)

diff --git a/arch/arm64/boot/dts/aspeed/aspeed-g7-a35.dtsi b/arch/arm64/boot/dts/aspeed/aspeed-g7-a35.dtsi
index ef283d95649a..58193c3c3696 100644
--- a/arch/arm64/boot/dts/aspeed/aspeed-g7-a35.dtsi
+++ b/arch/arm64/boot/dts/aspeed/aspeed-g7-a35.dtsi
@@ -84,32 +84,30 @@ l2: l2-cache0 {
 	};
 
 	secondary {
-		#address-cells = <2>;
-		/* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/of/address.c?h=v6.16#n491 */
+		#address-cells = <1>;
 		#size-cells = <0>;
-		/* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/of/address.c?h=v6.16#n430 */
 
-		ssp_nvic: interrupt-controller@1,e000e100 {
+		ssp_nvic: interrupt-controller@e000e100 {
 			compatible = "arm,v7m-nvic";
 			#interrupt-cells = <2>;
 			#address-cells = <0>;
 			interrupt-controller;
-			reg = <1 0xe000e100>;
+			reg = <0xe000e100>;
 			arm,num-irq-priority-bits = <3>;
 			status = "disabled";
 		};
 	};
 
 	tertiary {
-		#address-cells = <2>;
+		#address-cells = <1>;
 		#size-cells = <0>;
 
-		tsp_nvic: interrupt-controller@2,e000e100 {
+		tsp_nvic: interrupt-controller@e000e100 {
 			compatible = "arm,v7m-nvic";
 			#interrupt-cells = <2>;
 			#address-cells = <0>;
 			interrupt-controller;
-			reg = <2 0xe000e100>;
+			reg = <0xe000e100>;
 			arm,num-irq-priority-bits = <3>;
 			status = "disabled";
 		};
diff --git a/arch/arm64/boot/dts/aspeed/aspeed-g7-soc1-pinctrl.dtsi b/arch/arm64/boot/dts/aspeed/aspeed-g7-soc1-pinctrl.dtsi
index 72d93323593d..6edf14617b09 100644
--- a/arch/arm64/boot/dts/aspeed/aspeed-g7-soc1-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/aspeed/aspeed-g7-soc1-pinctrl.dtsi
@@ -496,87 +496,6 @@ pinctrl_hvi3c15_default: hvi3c15-default-state {
 		function = "I3C15";
 		groups = "HVI3C15";
 	};
-
-	pinctrl_tach0_default: tach0-default-state {
-		function = "TACH0";
-		groups = "TACH0";
-	};
-
-	pinctrl_tach1_default: tach1-default-state {
-		function = "TACH1";
-		groups = "TACH1";
-	};
-
-	pinctrl_tach2_default: tach2-default-state {
-		function = "TACH2";
-		groups = "TACH2";
-	};
-
-	pinctrl_tach3_default: tach3-default-state {
-		function = "TACH3";
-		groups = "TACH3";
-	};
-
-	pinctrl_tach4_default: tach4-default-state {
-		function = "TACH4";
-		groups = "TACH4";
-	};
-
-	pinctrl_tach5_default: tach5-default-state {
-		function = "TACH5";
-		groups = "TACH5";
-	};
-
-	pinctrl_tach6_default: tach6-default-state {
-		function = "TACH6";
-		groups = "TACH6";
-	};
-
-	pinctrl_tach7_default: tach7-default-state {
-		function = "TACH7";
-		groups = "TACH7";
-	};
-
-	pinctrl_tach8_default: tach8-default-state {
-		function = "TACH8";
-		groups = "TACH8";
-	};
-
-	pinctrl_tach9_default: tach9-default-state {
-		function = "TACH9";
-		groups = "TACH9";
-	};
-
-	pinctrl_tach10_default: tach10-default-state {
-		function = "TACH10";
-		groups = "TACH10";
-	};
-
-	pinctrl_tach11_default: tach11-default-state {
-		function = "TACH11";
-		groups = "TACH11";
-	};
-
-	pinctrl_tach12_default: tach12-default-state {
-		function = "TACH12";
-		groups = "TACH12";
-	};
-
-	pinctrl_tach13_default: tach13-default-state {
-		function = "TACH13";
-		groups = "TACH13";
-	};
-
-	pinctrl_tach14_default: tach14-default-state {
-		function = "TACH14";
-		groups = "TACH14";
-	};
-
-	pinctrl_tach15_default: tach15-default-state {
-		function = "TACH15";
-		groups = "TACH15";
-	};
-
 	pinctrl_thru0_default: thru0-default-state {
 		function = "THRU0";
 		groups = "THRU0";
@@ -940,27 +859,6 @@ pinctrl_uart3_default: uart3-default-state {
 		function = "UART3";
 		groups = "UART3";
 	};
-
-	pinctrl_ncts5_default: ncts5-default-state {
-		function = "NCTS5";
-		groups = "NCTS5";
-	};
-
-	pinctrl_ndcd5_default: ndcd5-default-state {
-		function = "NDCD5";
-		groups = "NDCD5";
-	};
-
-	pinctrl_ndsr5_default: ndsr5-default-state {
-		function = "NDSR5";
-		groups = "NDSR5";
-	};
-
-	pinctrl_nri5_default: nri5-default-state {
-		function = "NRI5";
-		groups = "NRI5";
-	};
-
 	pinctrl_ndtr5_default: ndtr5-default-state {
 		function = "NDTR5";
 		groups = "NDTR5";

---
base-commit: abe651837cb394f76d738a7a747322fca3bf17ba
change-id: 20260611-dtsi_fix-099b11a321b5

Best regards,
-- 
Ryan Chen <ryan_chen@aspeedtech.com>


