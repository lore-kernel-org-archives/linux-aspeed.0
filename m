Return-Path: <linux-aspeed+bounces-4459-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FABC43458
	for <linux-aspeed@archiver.kernel.org>; Sun, 12 Jul 2026 01:01:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gyS240Mkvz2yYf;
	Sun, 12 Jul 2026 11:01:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c107::9" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783662630;
	cv=pass; b=iyNEtfSzLOBLU3jvhTY2gyYoTn52T6zX39BwvT4eleWZ07Ukrn9lp+jrnyRb9BImVePXRotxzgEM9MZGFdch/+3dHBs0nD/IfvrTaq9Fqdv35uOC0O77KFHfzhmeuAIrwM75OFLGI/77MTzXBj+7vEvrQAHmz7/k3CNpyJR2gCF8hB78cfTHQ9gxspzoJIBIL7gp1/uvPGdRrJKAwQvn/pB+Y8jZ5LLFVlyYwK1SDmaulF3ipSVvF8RPkNSURcXMR1YMPOh5gH+pNDIawNdG/VNC0Y8nYONjomVx3UiDjMJdASEJOAurGKsu1aWDxuVS2/PA2z7cXKbpswhzKLLocA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783662630; c=relaxed/relaxed;
	bh=HB5m/p7iSwhmm5reInIR98Q9qv8vwwv0Oz0FNCDet/A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N6J9JxkPvzFnlol5TwZw7NRUkrn7eKiTmuTdJJ74PtM82I60WmkHcWsySJH7QXjwV8BIyrCUhhOP71VI4up6tb8ZrAIXK3VxFpRs8mrCHIJBtN1AzOHQkolYgM8i+LLXRX2FtQSthVeVLYKAXKs4G0NHtwMP4XOE3I5ka9p6wGFs93yTTRXY5YHqhqqPF0GqRqs3ah4TkSFmbCdZUzz1TKyOhEQ26Nv3jC+1Bp/MYXW9ayWYL/VaMXLGRczow4QUX6OXqboIM70nalrvSKmAyV3F4hdj5YeE8xfUaaQm9+URY65LxglfoOpQeHyWnPxCqlIob6VOZeh/1Do1k0DXKA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TRM31SOI; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c107::9; helo=ph7pr06cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TRM31SOI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c107::9; helo=ph7pr06cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org)
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azlp170100009.outbound.protection.outlook.com [IPv6:2a01:111:f403:c107::9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxLXP2r86z2yRF;
	Fri, 10 Jul 2026 15:50:29 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SRksKs36vko018DHVXKnRxTMOig1mc0jm0bevL3Q7o+UwBXAztp+rkIJtiuPMWrfFV1p8Au6EVVCizf86raYbFt4Di+2Sw5kkTaJmpvsagntIKZwTyc6P1ZU3t0lhMRBLRpCp9xGhnuwKNfCmYDGON26rVr3kRicaVwXM70ee5ENmsaFUzFHf+X6UgBtgxXc0IUBGRTdNUYMrqnHfkk/e/G/itknhn21bCJVxzx8FHXIckW8SkatuCSBeFltmzY8q2FBcrofaedzwlncJpp+ikP5DvlhYc+57wYkd9VnXKrvhzcyUaqwFElEEAOmh5pdBNTnKGGFt6Mn5C4AOrDjHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HB5m/p7iSwhmm5reInIR98Q9qv8vwwv0Oz0FNCDet/A=;
 b=NvZIkx41HXle55JyDyV4wiv12PxfslVg2+w17Z8uxi9fgvo0Sco2NBvNY+M11yXwj/9DSunCwb8DYJ5GpbpF3ZaJkXnYpWZ5Nn0OuI/XFtC4VNkF+hr392tQK+GNC9QZTsJY6jfpgO09AbhHWDSd9xlBFx+FR6NbQkcWbH+XSgWdxIni6Xn9Y0QATs0xEsJ4GG54wk23OOTIWY0Y5q+u+lpwDKEfTTtHUFgFYqm3aypB2vh06a8WXyocNY/FUNhUf/8orRulEanjk6GAKYm1/r81O6kf2Qp+Di9SRXpaLT48B4WwIWgIFSasyS3nXrc2OxlN8v+0HLfIiaSDp9/Ydw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HB5m/p7iSwhmm5reInIR98Q9qv8vwwv0Oz0FNCDet/A=;
 b=TRM31SOIwJdRI2Mbw9vRHQHUenD0BCzkAF2xO0N2FNEP83i/Vn/vaPDMJkb+Lq+cACNbRFpjpBiHzpXzVDIBEFtWUd0M3dXozfbX+ZxUvt/WptCCljP8kOWn1QiFJJQYcuXBmqgGd9XvHVXVhce90heCV4s4yqlXpEZzyZFcZ0G3ltxBcMfa/zlUxOtO7vhreocdO50osjUfBVAQbvhIwBIWf0WR8O4kR8dcPoRBPI+din4mQGm4ZalsnURiflafeZ3M/6S9+T4RgtQ3Z4cZ2IVbTrwsBYI8Cmt8MOIKPcYxx7Q9xoYrVeQVC7CHqkBDexYD4P3K+Zaw4ZCtQy/GLA==
Received: from CH0PR03CA0279.namprd03.prod.outlook.com (2603:10b6:610:e6::14)
 by SA1PR12MB7221.namprd12.prod.outlook.com (2603:10b6:806:2bd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 10 Jul
 2026 05:49:56 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:e6:cafe::1) by CH0PR03CA0279.outlook.office365.com
 (2603:10b6:610:e6::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.12 via Frontend Transport; Fri,
 10 Jul 2026 05:49:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.0 via Frontend Transport; Fri, 10 Jul 2026 05:49:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Jul
 2026 22:49:41 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Jul
 2026 22:49:39 -0700
From: Jacky Huang <jackyhuang@nvidia.com>
To: <andrew@codeconstruct.com.au>, <joel@jms.id.au>, <robh@kernel.org>,
	<krzysztof.kozlowski@oss.qualcomm.com>, <conor+dt@kernel.org>,
	<andrew@lunn.ch>
CC: <devicetree@vger.kernel.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<openbmc@lists.ozlabs.org>, Jacky Huang <jackyhuang@nvidia.com>
Subject: [PATCH v3 2/2] ARM: dts: aspeed: Add NVIDIA VR-NVL BMC
Date: Fri, 10 Jul 2026 14:46:56 +0900
Message-ID: <20260710054849.3178747-3-jackyhuang@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710054849.3178747-1-jackyhuang@nvidia.com>
References: <20260710054849.3178747-1-jackyhuang@nvidia.com>
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
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|SA1PR12MB7221:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b49e450-d564-4373-aa3a-08dede471216
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|23010399003|82310400026|1800799024|11063799006|6133799003|56012099006|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	NMA0kinlAqM31+RzDDUO8qvPYIfeBBuIJaOPdqj8cclPouRfVqeol3M+JVPLEcRuIL+7apRIsAMJi42XXWz6r2Gqu0F2jHq8QYqhRM7FZa9LPKocTiQgqGOt5hZvVOnIWjd4gjOQeKgh1ZVcETCQ8Uq5iMPlq+FoaPxCyn025qKydAoxh0ivXBQiv41XNZ0H/eosFRumtyDIS8lhL8wFfCnvTt78emN5z1lrVxotITy8+iDX72jgEpJQrJNMgd2UmVmCwZoUByL01oslkz5cTMvzAUejHv/uyy4iOrHkOvva7Uk+ouL8v3ovLsBuMk8/Zowp07ErD4kpc+lRaSbuD2Fd6s58bOSfiDaHyR+rGz8UCJ8v3W+SZlyBpjh6BqCZwlN7IktamiE2I0grPsP1NfvVxLfAucq5VF9YilFkisaraLiI9jHQa9Kr9muc8HPBfggBOyMRHI0kbrY+l7imrC31Kaks7LwX4X+buGCJ2gTfvW2uwibvu+ZTVFYUTi6lXs2isZdL4lmNx9srtwpJbekSoKFI68ta/P1dTV71209PufRMHAq0SU9WekPAoy6X73LuRgUTyEBIWrBXL4QZUcmM1/tKqkO4PIcrDfBhg1vmNR56kTlPT4c3dF7y/tqOSeijKQBH3Jh0VtHVKHLPbHD8zOAIXs03Prvl7nBK7ZndEYoNJt+87iN7+H6HgC+DAa81Y39Tc4TaWGIyOklkGQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(23010399003)(82310400026)(1800799024)(11063799006)(6133799003)(56012099006)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	khP5cGNvwGGB+aiqAsPsdY9HDTK0w6L6Pj6RB/vhpKWtggdPSTyk7ldzPI2K3YMx86SVR/TUwAoetry6tHQVH1Ivm++Ffo6at0nG21E2IzKpw8rM0p6lH1j7zWQXVDFdBFPX4k9MVn+/uRA8EcopyOOO7V+IgFfpwTPGfZH01J5KiVLFBK/ZBVLW6Q/f97H7HzK7wvQAS0CzGNzByn8yDhvN6a62o6BinhHbhWGXYwL4F0Xqpyy8YUTdGtZ1MM3Ppt4zQYmaGisgjIi1AOUtOYrCb+ShHxRdMqSB0lKyyIDkF1Vsb/5+tcxO5e4n1wsO/OFvsoaJPzN7Wg4zad/rBzD7N+AtdWzSyLEQiZiOOJWYEBgWhDTx8j62rmPbQ4tkv25F53KZpNrDTdqlD2a04bEPk/5z1rVrA2vY0F/MYJZ0ovTEDEM4+IED/CB4rTcK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 05:49:55.9062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b49e450-d564-4373-aa3a-08dede471216
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7221

Add the device tree for the Aspeed AST2600 BMC for NVIDIA's Vera
Rubin NVL compute platform.

MAC0 uses phy-mode = "rgmii-id" because the on-board PHY supplies
both RGMII internal delays.  The matching U-Boot device tree does not
enable SoC-side MAC clock delays, leaving the MAC internal delay at
zero so the PHY-provided delay is not doubled by the MAC controller.

The corresponding U-Boot change has been submitted to openbmc/u-boot:
Link: https://lore.kernel.org/all/20260629105202.1417679-1-jackyhuang@nvidia.com/

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jacky Huang <jackyhuang@nvidia.com>
---
v3: reword the &mac0 comment per Andrew Lunn's feedback.

 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../aspeed/aspeed-bmc-nvidia-vr-nvl-bmc.dts   | 901 ++++++++++++++++++
 2 files changed, 902 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-vr-nvl-bmc.dts

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/Makefile
index 6b68671f9379..07e10083a8bd 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -65,6 +65,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-microsoft-olympus.dtb \
 	aspeed-bmc-nvidia-gb200nvl-bmc.dtb \
 	aspeed-bmc-nvidia-msx4-bmc.dtb \
+	aspeed-bmc-nvidia-vr-nvl-bmc.dtb \
 	aspeed-bmc-opp-lanyang.dtb \
 	aspeed-bmc-opp-mowgli.dtb \
 	aspeed-bmc-opp-nicole.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-vr-nvl-bmc.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-vr-nvl-bmc.dts
new file mode 100644
index 000000000000..197f6c5a95fe
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-vr-nvl-bmc.dts
@@ -0,0 +1,901 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2026 NVIDIA Corporation
+
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+#include <dt-bindings/gpio/aspeed-gpio.h>
+#include <dt-bindings/i2c/i2c.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "AST2600 VR NVL BMC";
+	compatible = "nvidia,vr-nvl-bmc", "aspeed,ast2600";
+
+	aliases {
+		i2c16 = &i2c_usbhub;
+		i2c17 = &i2c_tpm;
+		i2c18 = &i2c_dp;
+		serial2 = &uart3;
+		serial4 = &uart5;
+	};
+
+	chosen {
+		stdout-path = &uart5;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		vga_memory: framebuffer@9f000000 {
+			no-map;
+			reg = <0x9f000000 0x01000000>;	/* 16 MiB */
+		};
+
+		ramoops@a0000000 {
+			compatible = "ramoops";
+			reg = <0xa0000000 0x100000>;	/* 1 MiB */
+			record-size = <0x10000>;	/* 64 KiB */
+			max-reason = <2>;		/* KMSG_DUMP_OOPS */
+		};
+
+		gfx_memory: framebuffer {
+			compatible = "shared-dma-pool";
+			size = <0x01000000>;
+			alignment = <0x01000000>;
+			reusable;
+		};
+
+		video_engine_memory: jpegbuffer {
+			compatible = "shared-dma-pool";
+			size = <0x02000000>;		/* 32 MiB */
+			alignment = <0x01000000>;
+			reusable;
+		};
+	};
+
+	standby_power_regulator: regulator-standby-power {
+		compatible = "regulator-fixed";
+		regulator-name = "standby_power";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpios = <&gpio0 ASPEED_GPIO(M, 3) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			label = "uid_led";
+			gpios = <&exp4 10 GPIO_ACTIVE_LOW>;
+		};
+
+		led-1 {
+			label = "fault_led";
+			gpios = <&exp4 12 GPIO_ACTIVE_LOW>;
+		};
+
+		led-2 {
+			label = "power_led";
+			gpios = <&exp4 8 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&ehci1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	hub@1 {
+		reg = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		hub@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			hub@4 {
+				reg = <4>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				/* port 1: BlueField-4 SMA management interface */
+				device@1 {
+					reg = <1>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					interface@1 {
+						reg = <1 1>;
+					};
+				};
+
+				cp2112g: device@2 {
+					reg = <2>;
+					gpio-controller;
+					#gpio-cells = <2>;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					gpio-line-names =
+						"BF4_USB_MCU_RECOVERY_L",
+						"BF4_USB_MCU_RST_L",
+						"BF4_USB_FORCE_FNP_L",
+						"BF4_GLOBAL_WP",
+						"BF4_FORCE_POR_L",
+						"BF4_BMC_EROT_RST_L",
+						"BF4_BMC_EROT_RECOVERY_L",
+						"BF4_THERM_SHUTDOWN";
+				};
+			};
+		};
+
+		hub@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			hub@1 {
+				reg = <1>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				hub@3 {
+					reg = <3>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					device@1 {
+						reg = <1>;
+						#address-cells = <2>;
+						#size-cells = <0>;
+
+						iob1_sma: interface@1 {
+							reg = <1 1>;
+
+							gpio-controller;
+							#gpio-cells = <2>;
+							interrupt-controller;
+							#interrupt-cells = <2>;
+						};
+					};
+
+					cp2112c: device@2 {
+						reg = <2>;
+						gpio-controller;
+						#gpio-cells = <2>;
+						interrupt-controller;
+						#interrupt-cells = <2>;
+						gpio-line-names =
+							"IOB1_MCP_P0_2-B",
+							"IOB1_MCU_RST_L-O",
+							"IOB1_MCU_RECOVERY_L-O",
+							"IOB1_GLOBAL_WP-O",
+							"IOB1_GLOBAL_ADDR_L_R-O",
+							"IOB1_GLOBAL_ADDR_U_D-O",
+							"IOB1_PWR_EN-O",
+							"IOB1_MCU_READY_STATUS-I";
+					};
+				};
+
+				hub@4 {
+					reg = <4>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					device@1 {
+						reg = <1>;
+						#address-cells = <2>;
+						#size-cells = <0>;
+
+						iob0_sma: interface@1 {
+							reg = <1 1>;
+
+							gpio-controller;
+							#gpio-cells = <2>;
+							interrupt-controller;
+							#interrupt-cells = <2>;
+						};
+					};
+
+					cp2112d: device@2 {
+						reg = <2>;
+						gpio-controller;
+						#gpio-cells = <2>;
+						interrupt-controller;
+						#interrupt-cells = <2>;
+						gpio-line-names =
+							"IOB0_MCP_P0_2-B",
+							"IOB0_MCU_RST_L-O",
+							"IOB0_MCU_RECOVERY_L-O",
+							"IOB0_GLOBAL_WP-O",
+							"IOB0_GLOBAL_ADDR_L_R-O",
+							"IOB0_GLOBAL_ADDR_U_D-O",
+							"IOB0_PWR_EN-O",
+							"IOB0_MCU_READY_STATUS-I";
+					};
+				};
+
+				device@1 {
+					reg = <1>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cp2112a: interface@1 {
+						reg = <1 1>;
+						gpio-controller;
+						#gpio-cells = <2>;
+						interrupt-controller;
+						#interrupt-cells = <2>;
+					};
+				};
+			};
+
+			hub@2 {
+				reg = <2>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				hub@3 {
+					reg = <3>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					device@1 {
+						reg = <1>;
+						#address-cells = <2>;
+						#size-cells = <0>;
+
+						iob2_sma: interface@1 {
+							reg = <1 1>;
+
+							gpio-controller;
+							#gpio-cells = <2>;
+							interrupt-controller;
+							#interrupt-cells = <2>;
+						};
+					};
+
+					cp2112e: device@2 {
+						reg = <2>;
+						gpio-controller;
+						#gpio-cells = <2>;
+						interrupt-controller;
+						#interrupt-cells = <2>;
+						gpio-line-names =
+							"IOB2_MCP_P0_2-B",
+							"IOB2_MCU_RST_L-O",
+							"IOB2_MCU_RECOVERY_L-O",
+							"IOB2_GLOBAL_WP-O",
+							"IOB2_GLOBAL_ADDR_L_R-O",
+							"IOB2_GLOBAL_ADDR_U_D-O",
+							"IOB2_PWR_EN-O",
+							"IOB2_MCU_READY_STATUS-I";
+					};
+				};
+
+				hub@4 {
+					reg = <4>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					device@1 {
+						reg = <1>;
+						#address-cells = <2>;
+						#size-cells = <0>;
+
+						iob3_sma: interface@1 {
+							reg = <1 1>;
+
+							gpio-controller;
+							#gpio-cells = <2>;
+							interrupt-controller;
+							#interrupt-cells = <2>;
+						};
+					};
+
+					cp2112f: device@2 {
+						reg = <2>;
+						gpio-controller;
+						#gpio-cells = <2>;
+						interrupt-controller;
+						#interrupt-cells = <2>;
+						gpio-line-names =
+							"IOB3_MCP_P0_2-B",
+							"IOB3_MCU_RST_L-O",
+							"IOB3_MCU_RECOVERY_L-O",
+							"IOB3_GLOBAL_WP-O",
+							"IOB3_GLOBAL_ADDR_L_R-O",
+							"IOB3_GLOBAL_ADDR_U_D-O",
+							"IOB3_PWR_EN-O",
+							"IOB3_MCU_READY_STATUS-I";
+					};
+				};
+
+				device@1 {
+					reg = <1>;
+					#address-cells = <2>;
+					#size-cells = <0>;
+
+					cp2112b: interface@1 {
+						reg = <1 1>;
+						gpio-controller;
+						#gpio-cells = <2>;
+						interrupt-controller;
+						#interrupt-cells = <2>;
+					};
+				};
+			};
+		};
+	};
+};
+
+&fmc {
+	status = "okay";
+
+	flash@0 {
+		label = "bmc";
+		status = "okay";
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				reg = <0x0 0xe0000>;		/* 896 KiB */
+				label = "u-boot";
+			};
+
+			partition@100000 {
+				reg = <0x100000 0x900000>;	/* 9 MiB */
+				label = "kernel";
+			};
+
+			partition@a00000 {
+				/*
+				 * extends to end of 64 MiB - 4 KiB; last
+				 * 4 KiB reserved for EROT image
+				 */
+				reg = <0xa00000 0x35ff000>;
+				label = "rofs";
+			};
+		};
+	};
+};
+
+&gpio0 {
+	gpio-line-names =
+		/* A0-A7 */ "", "", "", "", "", "", "", "",
+		/* B0-B7 */ "", "", "", "", "", "", "", "",
+		/* C0-C7 */ "", "BF4_USB_RST_L-O", "", "", "", "", "", "",
+		/* D0-D7 */ "", "", "", "", "", "FPGA_PEX_RST_L", "", "",
+		/* E0-E7 */ "RTL8221_PHY_RST_L-O", "RTL8211_PHY_INT_L-I",
+			    "", "", "", "", "", "MUX_SGPIO_SEL-O",
+		/* F0-F7 */ "", "", "", "", "", "", "", "",
+		/* G0-G7 */ "", "", "", "", "", "", "", "",
+		/* H0-H7 */ "", "", "", "", "", "", "", "",
+		/* I0-I7 */ "", "", "", "", "", "QSPI2_RST_L-O",
+			    "GLOBAL_WP_BMC-I", "BMC_DDR4_TEN-O",
+		/* J0-J7 */ "", "", "", "", "", "", "", "",
+		/* K0-K7 */ "", "", "", "", "", "", "", "",
+		/* L0-L7 */ "", "", "", "", "", "", "", "",
+		/* M0-M7 */ "USB_HUB_RST_N-O", "BMC_FRU_WP-O",
+			    "", "HMC_STBY_POWER_EN-O", "STBY_POWER_PG-I",
+			    "PCIE_EP_RST_L-O", "", "",
+		/* N0-N7 */ "", "", "", "", "", "", "", "",
+		/* O0-O7 */ "", "", "", "", "", "", "", "",
+		/* P0-P7 */ "", "", "", "", "", "", "", "",
+		/* Q0-Q7 */ "", "", "", "", "", "", "", "",
+		/* R0-R7 */ "", "SP0_AP_INTR_N-I", "", "", "", "", "", "",
+		/* S0-S7 */ "", "", "", "", "", "", "", "",
+		/* T0-T7 */ "", "", "", "", "", "", "", "",
+		/* U0-U7 */ "", "", "", "", "", "", "", "",
+		/* V0-V7 */ "", "", "", "", "",
+			    "PCB_TEMP_ALERT-I", "", "",
+		/* W0-W7 */ "", "", "", "", "", "", "", "CPU_RST_L-I",
+		/* X0-X7 */ "", "", "", "", "", "", "", "",
+		/* Y0-Y7 */ "", "", "", "EMMC_RST-O", "", "", "", "",
+		/* Z0-Z7 */ "HMC_EROT_SPI_INT_L-I",
+			    "", "", "", "", "", "", "";
+};
+
+&gpio1 {
+	gpio-line-names =
+		/* A0-A7 */ "", "", "", "", "", "", "", "",
+		/* B0-B7 */ "", "", "", "", "AP_EROT_REQ-O",
+			    "EROT_AP_GNT-I", "IO_EXPANDER_INT_L-I", "",
+		/* C0-C7 */ "", "", "", "", "", "", "", "",
+		/* D0-D7 */ "", "", "", "", "", "", "",
+			    "I2C_SSIF_ALERT_L-I",
+		/* E0-E7 */ "", "", "", "", "", "", "", "";
+};
+
+/* SSIF (CPU0 host IPMI) */
+&i2c0 {
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+/* BMC <-> HMC management (FRU proxy) */
+&i2c1 {
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	exp0: gpio@20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		vcc-supply = <&standby_power_regulator>;
+		gpio-line-names =
+			"B0_M0_SHDN_FORCE_L-O",
+			"B0_M0_STBY_POWER_PG-I",
+			"B0_M0_THERM_OVERT_L-I",
+			"B0_M0_THERM_WARN_L-I",
+			"B0_M0_GLOBAL_WP-O",
+			"B0_M0_USB_HUB0_RST_L-O",
+			"B0_M0_PRE_SYS_RST_L-O",
+			"B0_M0_LEAK_DETECT_ALERT_L-I",
+			"B0_M0_RUN_POWER_EN-O",
+			"B0_M0_RUN_POWER_PG-I",
+			"B0_M0_CPU_CHIPTHROT_L-O",
+			"B0_M0_SHDN_REQ_L-O",
+			"B0_M0_CPU_SHDN_OK_L-I",
+			"B0_M0_CPLD_READY-I",
+			"B0_M0_PWR_BRAKE_L-O",
+			"B0_M0_PWR_BRAKE_STATUS_L-I";
+	};
+
+	exp1: gpio@21 {
+		compatible = "nxp,pca9555";
+		reg = <0x21>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		vcc-supply = <&standby_power_regulator>;
+		gpio-line-names =
+			"B0_M0_I2C_BUS_MUX_RESET_L-O",
+			"B0_M0_HPM_MCU_OK-I",
+			"B0_M0_CPU_L0_RST_IND_L-O",
+			"B0_M0_C0_SOCAMM_DAC_SEL0-O",
+			"B0_M0_C1_SOCAMM_DAC_SEL1-O",
+			"B0_M0_C0_SOCAMM_I2C_SEL_R-O",
+			"B0_M0_C1_SOCAMM_I2C_SEL_R-O",
+			"B0_M0_EEPROM_POWER_DISABLE-O",
+			"B0_M0_L0L1_RST_L-I",
+			"B0_M0_L2_RST_L-I",
+			"B0_M0_BRD_ID_0-I",
+			"B0_M0_BRD_ID_1-I",
+			"B0_M0_BMC_LEAK_TEST_L-O",
+			"B0_M0_MCU_BMC_ALERT_L-I",
+			"B0_M0_CPU_BOOT_COMPLETE_3V3-I",
+			"B0_M0_BMC_TO_GPU_MCU_I2C_EN-O";
+	};
+};
+
+/* HMC virtual EEPROM / sensor proxy */
+&i2c3 {
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+/* MCIO expansion connector (HPM board 0) */
+&i2c4 {
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&i2c5 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	exp4: gpio@20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names =
+			"HMC_RST_R_L-O",
+			"HMC_RECOVERY_R-O",
+			"HMC_SPI_MUX_R_SEL-O",
+			"GLOBAL_WP-O",
+			"HMC_READY-I",
+			"HMC_PRSNT_R-I",
+			"BMC_SELF_PWR_CYCLE-O",
+			"EEDO_LED2-O",
+			"PWR_LED_L-O",
+			"PWR_BTN_L-I",
+			"UID_LED_L-O",
+			"UID_BTN_L-I",
+			"FAULT_LED_L-O",
+			"USB2_HUB_RST_L-O",
+			"IOX_GPIO_P16_TP",
+			"WARN_LED_L-O";
+	};
+
+	exp5: gpio@21 {
+		compatible = "nxp,pca9555";
+		reg = <0x21>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names =
+			"BMC_HMC_MUX_SEL-O",
+			"BMC_TPM_MUX_SEL-O",
+			"BMC_USB2_MUX_SEL-O",
+			"HMC_PGOOD_3V3-I",
+			"BF3_AOC_NCSI_PRSNT_L-I",
+			"HDR_SPI_PRSNT_L-I",
+			"SW_NRESET_R_L-O",
+			"MUX_I2C_ESPI_SEL-O",
+			"I2C_BUS_MUX_RESET_L-O",
+			"USB_MUX_EN-O",
+			"PDB_TRAY_RST-O",
+			"USB_PWR_EN-O",
+			"RTC_CLR_L-O",
+			"I2C_RTC_ALERT_L-I",
+			"X86_TPM_RST_SEL_L-O",
+			"BMC_MUX_PI3DP_SEL-O";
+	};
+};
+
+&i2c6 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	exp19: gpio@20 {
+		compatible = "ti,tca6408";
+		reg = <0x20>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names =
+			"", "",
+			"HMC_EROT_FATAL_ERROR_L-I", "",
+			"", "HMC_EROT_RECOVERY_L-O",
+			"HMC_EROT_RESET_L-O", "";
+	};
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9546";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		/* USB hub sideband */
+		i2c_usbhub: i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		/* optional TPM mux (unused; primary TPM is SPI) */
+		i2c_tpm: i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		/* DisplayPort/USB-C crossbar */
+		i2c_dp: i2c@2 {
+			reg = <2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+&i2c7 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	exp2: gpio@20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		vcc-supply = <&standby_power_regulator>;
+		gpio-line-names =
+			"B1_M0_SHDN_FORCE_L-O",
+			"B1_M0_STBY_POWER_PG-I",
+			"B1_M0_THERM_OVERT_L-I",
+			"B1_M0_THERM_WARN_L-I",
+			"B1_M0_GLOBAL_WP-O",
+			"B1_M0_USB_HUB0_RST_L-O",
+			"B1_M0_PRE_SYS_RST_L-O",
+			"B1_M0_LEAK_DETECT_ALERT_L-I",
+			"B1_M0_RUN_POWER_EN-O",
+			"B1_M0_RUN_POWER_PG-I",
+			"B1_M0_CPU_CHIPTHROT_L-O",
+			"B1_M0_SHDN_REQ_L-O",
+			"B1_M0_CPU_SHDN_OK_L-I",
+			"B1_M0_CPLD_READY-I",
+			"B1_M0_PWR_BRAKE_L-O",
+			"B1_M0_PWR_BRAKE_STATUS_L-I";
+	};
+
+	exp3: gpio@21 {
+		compatible = "nxp,pca9555";
+		reg = <0x21>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		vcc-supply = <&standby_power_regulator>;
+		gpio-line-names =
+			"B1_M0_I2C_BUS_MUX_RESET_L-O",
+			"B1_M0_HPM_MCU_OK-I",
+			"B1_M0_CPU_L0_RST_IND_L-O",
+			"B1_M0_C0_SOCAMM_DAC_SEL0-O",
+			"B1_M0_C1_SOCAMM_DAC_SEL1-O",
+			"B1_M0_C0_SOCAMM_I2C_SEL_R-O",
+			"B1_M0_C1_SOCAMM_I2C_SEL_R-O",
+			"B1_M0_EEPROM_POWER_DISABLE-O",
+			"B1_M0_L0L1_RST_L-I",
+			"B1_M0_L2_RST_L-I",
+			"B1_M0_BRD_ID_0-I",
+			"B1_M0_BRD_ID_1-I",
+			"B1_M0_BMC_LEAK_TEST_L-O",
+			"B1_M0_MCU_BMC_ALERT_L-I",
+			"B1_M0_CPU_BOOT_COMPLETE_3V3-I",
+			"B1_M0_BMC_TO_GPU_MCU_I2C_EN-O";
+	};
+};
+
+/* SSIF (CPU1 host IPMI) */
+&i2c8 {
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&i2c9 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	exp6: gpio@20 {
+		compatible = "nxp,pca9555";
+		reg = <0x20>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names =
+			"PDB_STRAP-I",
+			"STBY_POWER_EN-O",
+			"STBY_PWR_OK-I",
+			"", "",
+			"MAIN_PWR_EN-O",
+			"MAIN_PWR_OK-I",
+			"PDB_GLB_WP-O",
+			"PDB_PWR_BRK_L-I",
+			"FAN_PRSNT-I",
+			"", "",
+			"HSC4_S5_OR_S0_N-O",
+			"", "", "";
+	};
+
+	eeprom@50 {
+		compatible = "atmel,24c02";
+		reg = <0x50>;
+		pagesize = <8>;
+	};
+
+	exp7: gpio@75 {
+		compatible = "nxp,pca9539";
+		reg = <0x75>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names =
+			"SNN_PDB_RUN_IO0_A_R_PG-I",
+			"RST_STBY_R_L-O",
+			"SNN_PDB_RUN_IO0_B_R_EN-O",
+			"PSU1_PRSNT_R_N-O",
+			"PSU2_PRSNT_R_N-O",
+			"PSU3_PRSNT_R_N-O",
+			"PSU4_PRSNT_R_N-O",
+			"PDB_12V_PG_R-I",
+			"PDB_12V_2_PG_R-I",
+			"PDB_12V_2_EN_R-O",
+			"PDB_12V_EN_N_R-O",
+			"",
+			"HSC_PG_VIN_PG_R-I",
+			"PDB_PSU_SMB_ALERT_L_R-O",
+			"SNN_JSB2_17_R-I",
+			"TRAY_RST_L_R-I";
+	};
+};
+
+&i2c10 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	eeprom@50 {
+		compatible = "atmel,24c02";
+		reg = <0x50>;
+		pagesize = <8>;
+	};
+};
+
+/* Realtek Ethernet switch config EEPROM */
+&i2c11 {
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+/* BMC EROT */
+&i2c12 {
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&i2c13 {
+	clock-frequency = <400000>;
+	multi-master;
+	mctp-controller;
+	status = "okay";
+
+	mctp-controller@18 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x18 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
+
+	exp18: gpio@38 {
+		compatible = "nxp,pca9554";
+		reg = <0x38>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <ASPEED_GPIO(B, 6) IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-line-names =
+			"SSD0_PRSNT_L-I",
+			"E1S_PWR_EN-O",
+			"SSD0_PWRDIS-O",
+			"I2C_PDB_ALERT_L-I",
+			"BMC_SSD0_RST_L-O",
+			"GLOBAL_WP_E1S-O",
+			"12V_SSD0_PGD-I",
+			"SSD0_LED-O";
+	};
+};
+
+/* MCIO expansion connector (HPM board 1) */
+&i2c14 {
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+/* USB-C PD controller */
+&i2c15 {
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&mac0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_rgmii1_default>;
+	/*
+	 * The on-board PHY uses both the RX and TX RGMII internal
+	 * delays. Declare "rgmii-id" so the MAC does not add
+	 * additional delay. The same setting is applied in the
+	 * matching u-boot DTS to keep early-boot networking working.
+	 */
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy0>;
+	status = "okay";
+};
+
+&mdio0 {
+	status = "okay";
+
+	ethphy0: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+	};
+};
+
+&spi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi2_default>;
+	status = "okay";
+
+	flash@0 {
+		label = "config";
+		status = "okay";
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				reg = <0x0 0x40000>;	/* 256 KiB */
+				label = "u-boot-env";
+			};
+
+			partition@40000 {
+				reg = <0x40000 0x1000000>;	/* 16 MiB */
+				label = "rwfs";
+			};
+
+			partition@1040000 {
+				reg = <0x1040000 0x2800000>;	/* 40 MiB */
+				label = "log";
+			};
+		};
+	};
+};
+
+/* BMC <-> host CPU UART */
+&uart1 {
+	status = "okay";
+};
+
+/* Serial-over-LAN */
+&uart3 {
+	status = "okay";
+};
+
+/* BMC debug console */
+&uart5 {
+	status = "okay";
+};
+
+&uart_routing {
+	status = "okay";
+};
+
+&vhub {
+	status = "okay";
+};
+
+&video {
+	memory-region = <&video_engine_memory>;
+	status = "okay";
+};
-- 
2.43.0


