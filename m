Return-Path: <linux-aspeed+bounces-2414-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA08CCD187
	for <linux-aspeed@archiver.kernel.org>; Fri, 10 Oct 2025 08:03:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cjfPv5llZz2xQD;
	Fri, 10 Oct 2025 19:03:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760083411;
	cv=none; b=YZAM+hf+WHQtCd5PAqS2jxduLnqZZdvYoyDrOn7tok4W3abF67wBWiM4L4CZr5oCyWMPU4x0oE2yh4eK4UIWQ7fqHwKzgQ+g5pUz86tiWZY1hq5kFyfF1IuZ4UepTpZMNwpNsvp5Jjy2gKkJ4l63MPZHjQUi39icUQqAig3d+nw9uS0PK6sxL67ur/SJwsv7sjoYgieBN4vom/fUlhLaKLzGuoblVpD89+aK4F/32ifIwVBumCawBXxqrUMZh9yrL85ktLwwP6nTcU0380+90V9kXM6jyXKds2qwgZXJe7HymDrvcQQtITUXvcJ2sRFyT5gIdvk+McX1bvD6JFMCVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760083411; c=relaxed/relaxed;
	bh=lKuC1nMohDpFkB4CjC9A9DV5ddl9xx1ziWy3pYSldxY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VqAweQBpigCaRrFx+stVi7HMkPXkU93fXVipMt//+mAs5lPbJAMgyysoOb0nAakHOJlbMrjRtFrZPuQgcTpw7z2dFwOE74zIECLN+hJLyXNOFkmkjJbovGRhUrSS72n1UZoSdGO1tCKYBx5uWiYXBDILgLSk0uqrBFR38AF0lQDiagXLnpqbGOSSLcgwOH6DqmERGsDYX02IxvC2mPzGOFUI3Py0hpWtX/ofyW8SWK9DM6hSR0Fn/vmwGSn/bXrNkPav3ZwxTasEmjv3KuXC87S0MW2vAaAuyoxp9ppiCq6h0B2CPcAayb8gC/p8JRwuA3MPpihvsP16xeiNWV1NpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=chin-ting_kuo@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cjfPv0zjCz2xK1
	for <linux-aspeed@lists.ozlabs.org>; Fri, 10 Oct 2025 19:03:31 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 10 Oct
 2025 16:03:16 +0800
Received: from aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 10 Oct 2025 16:03:16 +0800
From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To: <wim@linux-watchdog.org>, <linux@roeck-us.net>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <linux-watchdog@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<BMC-SW@aspeedtech.com>
Subject: [PATCH v2 1/3] dt-bindings: watchdog: aspeed,ast2400-wdt: Add support for AST2700
Date: Fri, 10 Oct 2025 16:03:13 +0800
Message-ID: <20251010080315.816628-2-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251010080315.816628-1-chin-ting_kuo@aspeedtech.com>
References: <20251010080315.816628-1-chin-ting_kuo@aspeedtech.com>
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support for the AST2700 SoC in the ASPEED watchdog device tree
bindings. This includes:

- Adding "aspeed,ast2700-wdt" to the compatible string list.
- Extending the "aspeed,reset-mask" property description for AST2700.
- Defining AST2700-specific reset mask bits in aspeed-wdt.h,
  covering RESET1 to RESET5.

Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
---
 .../bindings/watchdog/aspeed,ast2400-wdt.yaml |   8 +-
 include/dt-bindings/watchdog/aspeed-wdt.h     | 138 ++++++++++++++++++
 2 files changed, 144 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yaml b/Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yaml
index be78a9865584..9322cb5b462a 100644
--- a/Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/aspeed,ast2400-wdt.yaml
@@ -15,6 +15,7 @@ properties:
       - aspeed,ast2400-wdt
       - aspeed,ast2500-wdt
       - aspeed,ast2600-wdt
+      - aspeed,ast2700-wdt
 
   reg:
     maxItems: 1
@@ -87,13 +88,15 @@ properties:
   aspeed,reset-mask:
     $ref: /schemas/types.yaml#/definitions/uint32-array
     minItems: 1
-    maxItems: 2
+    maxItems: 5
     description: >
       A bitmask indicating which peripherals will be reset if the watchdog
       timer expires. On AST2500 SoCs this should be a single word defined using
       the AST2500_WDT_RESET_* macros; on AST2600 SoCs this should be a two-word
       array with the first word defined using the AST2600_WDT_RESET1_* macros,
-      and the second word defined using the AST2600_WDT_RESET2_* macros.
+      and the second word defined using the AST2600_WDT_RESET2_* macros; on
+      AST2700 SoCs, this should be five-word array from AST2700_WDT_RESET1_*
+      macros to AST2700_WDT_RESET5_* macros.
 
 required:
   - compatible
@@ -114,6 +117,7 @@ allOf:
           enum:
             - aspeed,ast2500-wdt
             - aspeed,ast2600-wdt
+            - aspeed,ast2700-wdt
   - if:
       required:
         - aspeed,ext-active-high
diff --git a/include/dt-bindings/watchdog/aspeed-wdt.h b/include/dt-bindings/watchdog/aspeed-wdt.h
index 7ae6d84b2bd9..89fa31ffce2d 100644
--- a/include/dt-bindings/watchdog/aspeed-wdt.h
+++ b/include/dt-bindings/watchdog/aspeed-wdt.h
@@ -89,4 +89,142 @@
 
 #define AST2600_WDT_RESET2_DEFAULT 0x03fffff1
 
+#define AST2700_WDT_RESET1_CPU		(1 << 0)
+#define AST2700_WDT_RESET1_DRAM		(1 << 1)
+#define AST2700_WDT_RESET1_SLI0		(1 << 2)
+#define AST2700_WDT_RESET1_EHCI		(1 << 3)
+#define AST2700_WDT_RESET1_HACE		(1 << 4)
+#define AST2700_WDT_RESET1_SOC_MISC0	(1 << 5)
+#define AST2700_WDT_RESET1_VIDEO	(1 << 6)
+#define AST2700_WDT_RESET1_2D_GRAPHIC	(1 << 7)
+#define AST2700_WDT_RESET1_RAVS0	(1 << 8)
+#define AST2700_WDT_RESET1_RAVS1	(1 << 9)
+#define AST2700_WDT_RESET1_GPIO0	(1 << 10)
+#define AST2700_WDT_RESET1_SSP		(1 << 11)
+#define AST2700_WDT_RESET1_TSP		(1 << 12)
+#define AST2700_WDT_RESET1_CRT		(1 << 13)
+#define AST2700_WDT_RESET1_USB20_HOST	(1 << 14)
+#define AST2700_WDT_RESET1_USB11_HOST	(1 << 15)
+#define AST2700_WDT_RESET1_UFS		(1 << 16)
+#define AST2700_WDT_RESET1_EMMC		(1 << 17)
+#define AST2700_WDT_RESET1_AHB_TO_PCIE1	(1 << 18)
+#define AST2700_WDT_RESET1_XDMA0	(1 << 22)
+#define AST2700_WDT_RESET1_MCTP1	(1 << 23)
+#define AST2700_WDT_RESET1_MCTP0	(1 << 24)
+#define AST2700_WDT_RESET1_JTAG0	(1 << 25)
+#define AST2700_WDT_RESET1_ECC		(1 << 26)
+#define AST2700_WDT_RESET1_XDMA1	(1 << 27)
+#define AST2700_WDT_RESET1_DP		(1 << 28)
+#define AST2700_WDT_RESET1_DP_MCU	(1 << 29)
+#define AST2700_WDT_RESET1_AHB_TO_PCIE0	(1 << 31)
+
+#define AST2700_WDT_RESET1_DEFAULT 0x8207ff71
+
+#define AST2700_WDT_RESET2_USB3_A_HOST	(1 << 0)
+#define AST2700_WDT_RESET2_USB3_A_VHUB3	(1 << 1)
+#define AST2700_WDT_RESET2_USB3_A_VHUB2	(1 << 2)
+#define AST2700_WDT_RESET2_USB3_B_HOST	(1 << 3)
+#define AST2700_WDT_RESET2_USB3_B_VHUB3	(1 << 4)
+#define AST2700_WDT_RESET2_USB3_B_VHUB2	(1 << 5)
+#define AST2700_WDT_RESET2_SM3		(1 << 6)
+#define AST2700_WDT_RESET2_SM4		(1 << 7)
+#define AST2700_WDT_RESET2_SHA3		(1 << 8)
+#define AST2700_WDT_RESET2_RSA		(1 << 9)
+
+#define AST2700_WDT_RESET2_DEFAULT 0x000003f6
+
+#define AST2700_WDT_RESET3_LPC0		(1 << 0)
+#define AST2700_WDT_RESET3_LPC1		(1 << 1)
+#define AST2700_WDT_RESET3_MDIO		(1 << 2)
+#define AST2700_WDT_RESET3_PECI		(1 << 3)
+#define AST2700_WDT_RESET3_PWM		(1 << 4)
+#define AST2700_WDT_RESET3_MAC0		(1 << 5)
+#define AST2700_WDT_RESET3_MAC1		(1 << 6)
+#define AST2700_WDT_RESET3_MAC2		(1 << 7)
+#define AST2700_WDT_RESET3_ADC		(1 << 8)
+#define AST2700_WDT_RESET3_SDC		(1 << 9)
+#define AST2700_WDT_RESET3_ESPI0	(1 << 10)
+#define AST2700_WDT_RESET3_ESPI1	(1 << 11)
+#define AST2700_WDT_RESET3_JTAG1	(1 << 12)
+#define AST2700_WDT_RESET3_SPI0		(1 << 13)
+#define AST2700_WDT_RESET3_SPI1		(1 << 14)
+#define AST2700_WDT_RESET3_SPI2		(1 << 15)
+#define AST2700_WDT_RESET3_I3C0		(1 << 16)
+#define AST2700_WDT_RESET3_I3C1		(1 << 17)
+#define AST2700_WDT_RESET3_I3C2		(1 << 18)
+#define AST2700_WDT_RESET3_I3C3		(1 << 19)
+#define AST2700_WDT_RESET3_I3C4		(1 << 20)
+#define AST2700_WDT_RESET3_I3C5		(1 << 21)
+#define AST2700_WDT_RESET3_I3C6		(1 << 22)
+#define AST2700_WDT_RESET3_I3C7		(1 << 23)
+#define AST2700_WDT_RESET3_I3C8		(1 << 24)
+#define AST2700_WDT_RESET3_I3C9		(1 << 25)
+#define AST2700_WDT_RESET3_I3C10	(1 << 26)
+#define AST2700_WDT_RESET3_I3C11	(1 << 27)
+#define AST2700_WDT_RESET3_I3C12	(1 << 28)
+#define AST2700_WDT_RESET3_I3C13	(1 << 29)
+#define AST2700_WDT_RESET3_I3C14	(1 << 30)
+#define AST2700_WDT_RESET3_I3C15	(1 << 31)
+
+#define AST2700_WDT_RESET3_DEFAULT 0x000093ec
+
+#define AST2700_WDT_RESET4_FMC		(1 << 0)
+#define AST2700_WDT_RESET4_SOC_MISC1	(1 << 1)
+#define AST2700_WDT_RESET4_AHB		(1 << 2)
+#define AST2700_WDT_RESET4_SLI1		(1 << 3)
+#define AST2700_WDT_RESET4_UART0	(1 << 4)
+#define AST2700_WDT_RESET4_UART1	(1 << 5)
+#define AST2700_WDT_RESET4_UART2	(1 << 6)
+#define AST2700_WDT_RESET4_UART3	(1 << 7)
+#define AST2700_WDT_RESET4_I2C_MONITOR	(1 << 8)
+#define AST2700_WDT_RESET4_HOST_TO_SPI1	(1 << 9)
+#define AST2700_WDT_RESET4_HOST_TO_SPI2	(1 << 10)
+#define AST2700_WDT_RESET4_GPIO1	(1 << 11)
+#define AST2700_WDT_RESET4_FSI		(1 << 12)
+#define AST2700_WDT_RESET4_CANBUS	(1 << 13)
+#define AST2700_WDT_RESET4_MCTP		(1 << 14)
+#define AST2700_WDT_RESET4_XDMA		(1 << 15)
+#define AST2700_WDT_RESET4_UART5	(1 << 16)
+#define AST2700_WDT_RESET4_UART6	(1 << 17)
+#define AST2700_WDT_RESET4_UART7	(1 << 18)
+#define AST2700_WDT_RESET4_UART8	(1 << 19)
+#define AST2700_WDT_RESET4_BOOT_MCU	(1 << 20)
+#define AST2700_WDT_RESET4_IO_MCU	(1 << 21)
+#define AST2700_WDT_RESET4_LTPI0	(1 << 22)
+#define AST2700_WDT_RESET4_VGA_LINK	(1 << 23)
+#define AST2700_WDT_RESET4_LTPI1	(1 << 24)
+#define AST2700_WDT_RESET4_LTPI_PHY	(1 << 25)
+#define AST2700_WDT_RESET4_ACE		(1 << 26)
+#define AST2700_WDT_RESET4_LTPI_GPIO0	(1 << 28)
+#define AST2700_WDT_RESET4_LTPI_GPIO1	(1 << 29)
+#define AST2700_WDT_RESET4_AHB_TO_PCIE1	(1 << 30)
+#define AST2700_WDT_RESET4_I3C_DMA	(1 << 31)
+
+#define AST2700_WDT_RESET4_DEFAULT 0x40303803
+
+#define AST2700_WDT_RESET5_I2C_GLOBAL	(1 << 0)
+#define AST2700_WDT_RESET5_I2C0		(1 << 1)
+#define AST2700_WDT_RESET5_I2C1		(1 << 2)
+#define AST2700_WDT_RESET5_I2C2		(1 << 3)
+#define AST2700_WDT_RESET5_I2C3		(1 << 4)
+#define AST2700_WDT_RESET5_I2C4		(1 << 5)
+#define AST2700_WDT_RESET5_I2C5		(1 << 6)
+#define AST2700_WDT_RESET5_I2C6		(1 << 7)
+#define AST2700_WDT_RESET5_I2C7		(1 << 8)
+#define AST2700_WDT_RESET5_I2C8		(1 << 9)
+#define AST2700_WDT_RESET5_I2C9		(1 << 10)
+#define AST2700_WDT_RESET5_I2C10	(1 << 11)
+#define AST2700_WDT_RESET5_I2C11	(1 << 12)
+#define AST2700_WDT_RESET5_I2C12	(1 << 13)
+#define AST2700_WDT_RESET5_I2C13	(1 << 14)
+#define AST2700_WDT_RESET5_I2C14	(1 << 15)
+#define AST2700_WDT_RESET5_I2C15	(1 << 16)
+#define AST2700_WDT_RESET5_UHCI		(1 << 17)
+#define AST2700_WDT_RESET5_USB2_C_UART	(1 << 18)
+#define AST2700_WDT_RESET5_USB2_C	(1 << 19)
+#define AST2700_WDT_RESET5_USB2_D_UART	(1 << 20)
+#define AST2700_WDT_RESET5_USB2_D	(1 << 21)
+
+#define AST2700_WDT_RESET5_DEFAULT 0x00320000
+
 #endif
-- 
2.34.1


