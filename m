Return-Path: <linux-aspeed+bounces-5075-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286C6CA5FAB
	for <linux-aspeed@archiver.kernel.org>; Wed, 30 Sep 2026 06:14:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvlB54vgfz2yps;
	Wed, 30 Sep 2026 16:14:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c10d::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790748861;
	cv=pass; b=LBGFqDKNnPYmedUVewYeIJtLa4KA1XeDGAtLH1Fw3ezLsH1likYQ8JboILcN5nJuetuF84gUi8d5gicYomsX2TeRhnnA2bPHyVmQu0oU4AQAJRDzQgzOOORqAkN8dx4z8/OYtTlWuT/HmVga4Cx2EeLlUFqJHbeb6TfrqJsIlhaeFJyf6H1SWAGFF3VRM/CMQ9Qq1l7KHppCCRwowLyZfwqfb9qiDjylRXeMjLuIjiV4qLD0NRjlFZb1J3c0CT8OHwNHJw4JnnKHh3uFiX8xryJlW7daa/quzk6jvKyn7wsgFdX9wcLRHywm7LfRmNxbh4peNyQZF8oMGsYKDudy2g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790748861; c=relaxed/relaxed;
	bh=8JHpVGvvc0BxDXqHE+ko9RQSlW/vc4sxkXIPPE0SgRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=HKM2BW2ICSncxuk/zYH8dnnHyNDbPs261Q+bhLjtjRR2jS7qjkJ4qPmf0t0YZiycA/9rzaW58Sk6n/SJbUzBUZQLFhGDYfsK4F5QwpO3k9jctmk0+ph8P6PmiLvDwLlQ35LkPEQEkKHvKgQCt2pwoHcoq03ECBnhqCcr6v8PxcgjOsYRiulmUCEnm0aqjZTTu9B3simjKleSJeekPJb9e4N6mkmJDVhKOFOFYN+K8aC6yKT/tFYNcrE/aBeT6G9qTpce3Frxst5Se04HR7wrvghY2UteJAPpnxRfyZnFAhmX/q4KED/vkRZNQBB4qQKNcxXbjHWZyszRrAIgAr4s4w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=rHq/mgfF; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c10d::3; helo=sn4pr0501cu005.outbound.protection.outlook.com; envelope-from=bounces+srs=ha9og=hw@amdcloud.onmicrosoft.com; receiver=lists.ozlabs.org) smtp.mailfrom=amdcloud.onmicrosoft.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=rHq/mgfF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amdcloud.onmicrosoft.com (client-ip=2a01:111:f403:c10d::3; helo=sn4pr0501cu005.outbound.protection.outlook.com; envelope-from=bounces+srs=ha9og=hw@amdcloud.onmicrosoft.com; receiver=lists.ozlabs.org)
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10d::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvlB50YT2z2yn2
	for <linux-aspeed@lists.ozlabs.org>; Wed, 30 Sep 2026 16:14:21 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lgr/fgJQfLPldPeT+2cAd4b5aVDAkMpczpTavmBwPQL1jSdimDkhnrpVWgPlammaxfrgu6syEI3U9mpskswZVjehswZB6BbZMuB+ztP8t0hhHEFHHbZKhcE+vALqn1mxmjY7xqGAH69d8wffj7vHyC1yvSBoF25VnNSAEp7qSx1qvU3oYni+fziMqzMSh8L9f3yjydG93RBTZdMHHAyE7oOK0nLGcv3GhXpGh+fXdACkDwXGfUyXtsmWnlwz5e5aawcor64m/HK8NuoDRxEYFyXek05F7FELxborl5jFEEqJxdHLy6xXaH8rS8iTPM9VgQk2VcVilD0LNrN3xE+NQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JHpVGvvc0BxDXqHE+ko9RQSlW/vc4sxkXIPPE0SgRE=;
 b=ujgGFdyc4S6mWvzn+3gs0B2sSI57YLLArpNf450roElu2PrUKaOA5dtSk7UPggjgQ5vff9XzfddhFEPGFDds8AS5mErscpZfY/FjHggMM6hSjP6MgasX0OfLDMS7P2E3ZngYt58Du1MCUD7G7OyT8Suf1HbwEX0fjYpnL/NPY7wCBbHXZQc0jIf+o1FIal6niTUYGOt1PbW7TFh+ROeNvCNL3E3rVVWkyIh7UPZLjrS9Rhl30OhoyA4Oq9yuxs8XeAR40ktbjpFlxOfugVMwypm2LtH5SArZNWWHvNSTev9IBIKKlOg+vQ7BJ1/V25i2/jqAUqf70Sa24Dvt0XQOqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=gmail.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JHpVGvvc0BxDXqHE+ko9RQSlW/vc4sxkXIPPE0SgRE=;
 b=rHq/mgfFXNNPArwV0/xCaRgrcqCoqdzzXikKfZF9j2QyU03m9jElOK8MbVqKPCxH+Dr6nUtfbLxL2sYVPtXAT5IYa+h3+byJoNg+fYTPA9CZhZATpA6z/Dyd+uiOgHurmOQ4K3ThGLUIOm77c7ybhHjSweS1NeA0RJBxYGUIyLF2ZoBNQ0k1k0ULn3VzPmXUBs4QRQ7r+X4W4gO/w+i0cnOYTDsy1NgjlJGUc/vP4LRGOf3A5GT01/9izPdsHIGiNYhodW0xs6gyDNXj4c+oWW1UE2iVKVzhicU7iWU6szXi1+qOh5riRkSc8Pq0TJt+Zhp3IwrCXykVpDL8CUZolA==
Received: from CH5PR05CA0012.namprd05.prod.outlook.com (2603:10b6:610:1f0::10)
 by DS0PR12MB7704.namprd12.prod.outlook.com (2603:10b6:8:138::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 06:13:59 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::61) by CH5PR05CA0012.outlook.office365.com
 (2603:10b6:610:1f0::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 06:13:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 165.204.84.17) smtp.mailfrom=gmail.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 165.204.84.17 as permitted sender)
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 06:13:59 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 01:13:58 -0500
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 30 Sep 2026 01:13:55 -0500
From: Colin Huang <u8813345@gmail.com>
Date: Wed, 30 Sep 2026 14:10:15 +0800
Subject: [PATCH v9 07/15] ARM: dts: aspeed: anacapa: Enable MCTP and FRU
 for NIC
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
Message-ID: <20260930-anacapa-devlop-phase-devicetree-v9-7-f08aa0d7182d@gmail.com>
References: <20260930-anacapa-devlop-phase-devicetree-v9-0-f08aa0d7182d@gmail.com>
In-Reply-To: <20260930-anacapa-devlop-phase-devicetree-v9-0-f08aa0d7182d@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<colin.huang2@amd.com>, Colin Huang <u8813345@gmail.com>, Andy Chung
	<Andy.Chung@amd.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790748641; l=3254;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=xSybis4WnZ0wCCi5yNlS7U3ZxSjvjItq7krEUM0miaU=;
 b=iqYCebzbVOrsbMqhLQIXSXleFW0jMCj9ofppclxzNnC7wvw2uJcT8G7SjDgCVIzRmjc/yx4pY
 1HqEoB2S4d7CU0iHP3hSxeU24uF6jF5BlgvvRdhGEkh+3d8EcjbVFD5
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|DS0PR12MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: 0531ea58-fbf3-4ae5-dc87-08df1eba0441
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|61400799027|82310400026|376014|35950700016|7093399015|48200799018|4128699003|11063799006|10067099003|56012099006|22082099003|16102099003|18002099003|20046099003;
X-Microsoft-Antispam-Message-Info:
	THc5GKVnfIjBbQuNpW4Hjc0hCb9tb0CSf3sa+b3Ne4Lcrxy1pfq/0unfZm37uf3DGGKWEUP9xrTEJSCfflJLQcqRS0LUx4vsZ5wqwOw8Ps6Vd+Nm263/hxuB9eFCzx7YmS6jdmrM82FeTkh/d8/ZN3uIr2eCZeQzpXBbEhGFlEwKg/ZNoFhWP0yRPSbVVskGskr9LpJX4/sp0dZBSS8kAAL6rB5Y0UsUydyZlnqBUdUcNOnDxKVZgbMrTwWiNkOcvXO7UqSWac3RFK6OeMjzCQXCzAnHH1qiYkSBBYec7k6Yr2VjjsctVRTHijjlf1a8niA8PDNyqpYZzC9IJaO6j1bhfdM1YW3t4RIl2wIF08KRaLtflgHUmHBI9XM847hbAM48wPnBDj/DhD+eA0eV5JhFu6mu0VcVi4svyVy+GDufsqxhdtvE0nYzkxLMQz2VT3k63R7pF86w/idO2W7ifJ59JZcmv4+8w+wO7xNawS0rteEqOFkP/ToOvbIZIJ08u1bdR3BZlRW0/xa7bitgaaWXYNvJBJ41M5Y4sMKmadtQjS20EQdPwSQipoVAyx7j2aD2kdjo0QvKOJJ9/Ly22DBG4CNNjCfC5i61he0eQzASKuW3W5rNSDkDbUHwpKMwBE+zBvOmHocjKLf0pIM1J8/EEHfw2lFLPzaccX4coIc6kcuAHgqS+znQQ82vhgEkZMdJrb+9T0Trj8wtQuQoog==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(61400799027)(82310400026)(376014)(35950700016)(7093399015)(48200799018)(4128699003)(11063799006)(10067099003)(56012099006)(22082099003)(16102099003)(18002099003)(20046099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GMR8mOOwWVaPxq9NQLAl+IzQA5wz7ws3lWHhT6OdxMyxMeCmA8A2Sn3UIKpODZoBjScuUoH2xB6qBx2f3BAXvQ6qHXJb5J4i20d1XQa7FyHVyMPFGlb+lUXOSrWzLTqmqwG26PFfBEUFWJXFXg1fin7wlKpbwUM4WdZHD5uCZx6COhsXw1Mgu2N6FT/eyBMiGIPrYiH9wU0DQwDhFe1AwnAWzOhilmg/rlLIgaWz2hLTSsFYy6+6yRpZ7U2XI+c8qCvf92pS8lIgQnjsqzE4cnJkBhchcAno5rXGW6juYUiICPe8RI+bgPyPNNprgb3b31XQAulHaL6HXLn9xg+1l2lXteySFoKZjySWUU1xA5XzVpVBzRfUdZuxi+dae5p52mfoTJBi6+1O7N1PTm7npaNd4Qs/yAsGghZ1VWnPEAeKMOJDEFy3cOPUZZjE2XsC
X-OriginatorOrg: amdcloud.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 06:13:59.3623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0531ea58-fbf3-4ae5-dc87-08df1eba0441
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7704

From: Andy Chung <Andy.Chung@amd.com>

Add the mctp-controller property to enable frontend NIC management
via PLDM over MCTP.
Also add EEPROM device for NIC FRU and reorder the I2C virtual bus
index accroding to the system silkscreen index.

Signed-off-by: Andy Chung <Andy.Chung@amd.com>
---
 .../aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi   | 137 +++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
index 3ea5d67865d4..ab16e5ad5871 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
@@ -2,6 +2,25 @@
 
 #include "aspeed-bmc-facebook-anacapa-evt1.dtsi"
 
+&{/aliases} {
+	i2c36 = &i2c11mux0ch5;
+	i2c37 = &i2c11mux0ch6;
+	i2c38 = &i2c11mux0ch7;
+	i2c39 = &i2c11mux0ch0;
+	i2c40 = &i2c11mux0ch1;
+	i2c41 = &i2c11mux0ch2;
+	i2c42 = &i2c11mux0ch3;
+	i2c43 = &i2c11mux0ch4;
+	i2c44 = &i2c10mux0ch1;
+	i2c45 = &i2c10mux0ch2;
+	i2c46 = &i2c10mux0ch3;
+	i2c47 = &i2c10mux0ch4;
+	i2c48 = &i2c10mux0ch5;
+	i2c49 = &i2c10mux0ch6;
+	i2c50 = &i2c10mux0ch7;
+	i2c51 = &i2c10mux0ch0;
+};
+
 // MB - PDB
 &i2c8 {
 	i2c-mux@72 {
@@ -50,6 +69,124 @@ eeprom@51 {
 	};
 };
 
+// R Bridge Board
+&i2c10 {
+	multi-master;
+
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
+
+	i2c-mux@71 {
+		/delete-property/ i2c-mux-idle-disconnect;
+
+		i2c10mux0ch1: i2c@1 {
+			mctp-controller;
+			// BE NIC FRU
+
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+
+		i2c10mux0ch2: i2c@2 {
+			mctp-controller;
+			// BE NIC FRU
+
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+
+		i2c10mux0ch3: i2c@3 {
+			mctp-controller;
+			// BE NIC FRU
+
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+
+		i2c10mux0ch4: i2c@4 {
+			mctp-controller;
+			// BE NIC FRU
+
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+	};
+};
+
+// L Bridge Board
+&i2c11 {
+	multi-master;
+
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
+
+	i2c-mux@71 {
+		/delete-property/ i2c-mux-idle-disconnect;
+
+		i2c11mux0ch0: i2c@0 {
+			mctp-controller;
+			// FE NIC FRU
+
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+
+		i2c11mux0ch1: i2c@1 {
+			mctp-controller;
+			// BE NIC FRU
+
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+
+		i2c11mux0ch2: i2c@2 {
+			mctp-controller;
+			// BE NIC FRU
+
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+
+		i2c11mux0ch3: i2c@3 {
+			mctp-controller;
+			// BE NIC FRU
+
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+
+		i2c11mux0ch4: i2c@4 {
+			mctp-controller;
+			// BE NIC FRU
+
+			eeprom@50 {
+				compatible = "atmel,24c32";
+				reg = <0x50>;
+			};
+		};
+	};
+};
+
 // MB
 &i2c13 {
 	i2c-mux@70 {

-- 
2.34.1


