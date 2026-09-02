Return-Path: <linux-aspeed+bounces-4935-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6EAC624D6
	for <linux-aspeed@archiver.kernel.org>; Thu,  3 Sep 2026 00:22:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hb0fg1TH2z2y8F;
	Thu, 03 Sep 2026 10:22:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c100::f" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788344576;
	cv=pass; b=m7P/ZyQ9h2/8gNl8wJW1G8li9RFzXC2Dw22SvG0Y4veqfE6Y8Bp/Nr7lJhSsrpSXzEoIpWWo++/+A9FNLwDsonPReSBd9u6yq90t6fGiJHHymvV7bCv9k7QLJIbqf/Tkz+vvUXJWynuoI3JdiFieTNitGlZne46aG8u2yhXDCY2UFEj5MgT91HwVsVGwK0/N44/D5T4I2A/TNRCnWOwZ+fVIkmoulQg47v1t/iwwn2yGQQqE99i2QF5Zry+0VaCk3hgUTOWh5g0tIY8RW4QP44Ktztfr8pjt0hv3pFjkRtDpguzeilDFnCmE2f+dMfxV09ViSBwj5HdVqEIt3sMA7g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788344576; c=relaxed/relaxed;
	bh=eovo9E3TkWEKqlfEpGfcreWTGJtPYIimMj2M7HliDLk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Rco5RxH4GKu8THZuh9DT+l3eKcj4IE0LaeEt0ejm2BzoiymMCkJtfkJpR1LoLGcR4YsWbqis33/nq7oPPS7f+dNAWXvm1htfUBFOYruDEIJNFfRHSlllH083dW6SjnvBmpmeSJE+l6vCjLKrA51QFqxZmUUmmpsnDVBfxvJdgaE9YhK8j0hnvVxomtUuN75XJfZwC6HUbOgva/R0yHy3wt+v5sc5INlJkRyGe9WqwHBfEa1GuL18cA8i/Xfx10xTqU5iZqmHk9h1kA8+bP4J7sbYArJqmURzoJumBbiiFBEqIzqgcE9tuV31W/AO4e2mN0aYCvn8nmcd3XagPj9A6g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rHAaLgEp; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c100::f; helo=bl2pr02cu003.outbound.protection.outlook.com; envelope-from=colin.huang2@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rHAaLgEp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c100::f; helo=bl2pr02cu003.outbound.protection.outlook.com; envelope-from=colin.huang2@amd.com; receiver=lists.ozlabs.org)
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazlp17011000f.outbound.protection.outlook.com [IPv6:2a01:111:f403:c100::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZf1q71Phz2xlv
	for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 20:22:55 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wT1JoVi4a4CvCCLVlx16LX2If86NDCblYQukJpzhMefk1b+oSif4wMk8RMGhnyMDsBdSkLydl/Rfp5kJC3lFkS9HbX9+uqWLSxiehFvHv/kF600EY9gaujhdQJzxsPiafdZjp4DSGc5q9Ie/gLxNEQ0f8T/+TBm+7e+fugSIwqmBHDx8pTJEjnFTrCSw4C+lc8VuSJ9jeTHzRgqi6bgtsGPrbvzjfqmShFLzqaGHR9PCdbaWWAIvRM/zgto2JFuXJb7LnSHi7YW8XZBm7yP1hf0Q1HrODhmrV1DAfsM0Y+EQlAIEwHc5UT4eRYILxvme2bHm4xN5weGY5nghoT+3BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eovo9E3TkWEKqlfEpGfcreWTGJtPYIimMj2M7HliDLk=;
 b=tu5CQOdE+vongemicYCe70bvkMKPe95lrO9w/V6xU/pw3eL/qkQMhp+jss2PzPinJZFVmdfb28Jbsi+FZwjMDWWknBSBSJwX60swOKEkykxHx5+DXsz6nz954jIrByGw1CemmdQbowW3/ms4LweR7rW4/fw1aQ2J/4b8DyMTWKnLSibYRiPT/YNKQ5sAweqfLypC96tHaW9SgsGW3hLBiQgs2gnlbeAyKs3dPL+7pxtIS/ABdjLVgp1UZzMdm6ybR4vx7hVq2IqM5PEBgsfN58S31t/lcrU9aJFe5pI+5/n8QETyNtJzUcqzQt7xq0q/wpigH0x6j9Lv6wbr0AHznA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=aspeedtech.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eovo9E3TkWEKqlfEpGfcreWTGJtPYIimMj2M7HliDLk=;
 b=rHAaLgEpmdQqvHtPyglXXvoSJCI35WLFbukQEoIWqXBuLQnAmPOU1eroaykVxxt40WsRwnqSqtyBVCf9mLUWextx3QJAMoWGp8+rqMQ5bJV8ciyxWopLO4Uy8G532vv88mS8kZCzO35jaqx2m7LVRJBY4Q+zeYXwrWpCgKXHh9c=
Received: from BY3PR05CA0041.namprd05.prod.outlook.com (2603:10b6:a03:39b::16)
 by DM4PR12MB6591.namprd12.prod.outlook.com (2603:10b6:8:8e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 10:22:29 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:a03:39b:cafe::71) by BY3PR05CA0041.outlook.office365.com
 (2603:10b6:a03:39b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Wed, 2
 Sep 2026 10:22:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 10:22:29 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 05:22:27 -0500
Received: from [127.0.1.1] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 05:22:24 -0500
From: Colin Huang <colin.huang2@amd.com>
Date: Wed, 2 Sep 2026 18:21:20 +0800
Subject: [PATCH v8 08/11] ARM: dts: aspeed: anacapa: evt2: Add shunt
 resistor values for HSC monitors
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
Message-ID: <20260902-anacapa-devlop-phase-devicetree-v8-8-69c8eb2a7cda@gmail.com>
References: <20260902-anacapa-devlop-phase-devicetree-v8-0-69c8eb2a7cda@gmail.com>
In-Reply-To: <20260902-anacapa-devlop-phase-devicetree-v8-0-69c8eb2a7cda@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<colin.huang2@amd.com>, Colin Huang <u8813345@gmail.com>, Peter Shen
	<peter.shen@amd.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788344509; l=2046;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=2hNvv3dzcGY7YC5SlE8BBJWHSA7m9aG/DD9F7WuX2b0=;
 b=Y79tb/PAIfLC/ieD3cPHHxQx+CRnqwGuDiabk4IusHMxnWmD6Piq/FekHd51fT3M1DOJhMbt8
 awdgdCiVPjtCx39GYNfgiq81eWrZ2sQshWT97FZ0fq82LMkQJclSfH8
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|DM4PR12MB6591:EE_
X-MS-Office365-Filtering-Correlation-Id: 52453438-c249-4c4d-4f04-08df08dc17ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|376014|7416014|1800799024|6133799003|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	mu5fMOSC55BE0FVjwsjk6Ann9xMK4Md7nSCsx+q3rAzHPreJkyGsipNA204Lm3JjQODFPOlT/78/9kc6Jxmj+ojnkda5DupdZOt9xOmlcjfpiCKMot8yLaVU4NwU3ywVFBP5L5HH059QW7FHyVSeydzJbWUjuIuHrjZlUKO5lt2kwrcXmysL4gJRz5mOx2iH+NigKCN9xl4+4IOMwbfR67l+P8NSWn+u/K66jZS6fFQihYG4wxHm90ilK6AZaoCw9s3EFNLStiKe8WZI1JLwvmGHKgl5JmX08CWG6HfMkeaNtXxHWaTIEAyCrlDXg9ThIZeV3vsZWWhS9LEHPZCERyqMBGz+rQ38dHapTN9M1Tb/Qijcff37a3tO5R9tk2S2SEXtglhWhnYspSAgyPlrcKjiOWAePQUp9vEDwHE+qpyaQpX85JDraWtk+BSe3JmYiWyAlEx5pzmHEhQ6o00MHgLcTKUajWOewD88s54W3BnLe2T9zulqevuM60WBDYFOTMW8VHJxlhzHnqiNUL7RkSly7ogVIfvD/FdxcU9ABk1xelaue9sTpGTbdSy4koUv9iKZsAsdPn2BQR0FesS6LDS5DuVeZYSGr26QWAUR91sCGayr2WdRyIc7oanoN4x0yemL1eeub9DBNJYjH9ZFI9zCT4g5DVD9L1wmSrkGAi3q8iPPFN6qjnfHVg/UcXcTkWD+KshX1V8RwAWBzl6lRA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(7416014)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	G+ZHvfZN+i+jx9e5BYF1ycvhCYfChTdVtp1qElbZqSEQ1IjDvbzFpGqXaSev+ou3t4qeyAVpQzli4/2XXZxUSqTzlV52vnY4TCOJT4kkdlIA5Qp3E6VcCSRXR78rhytg5SBE74Z40eS7HKmHLXgwLc0V0fZHe7fGaX9CDyYkjc7DZYyAb7mx2MtfMsPwP4g5M3ziKCadAJrpbdzNZl3Bv6t0jggow6VbucikLZnwhCfhionSA7ckMOWu9IcC+B6Fds44NzjVsi5uUszUPT9xAfYrOm1YcVMjSPZQMcxyJYle4q+gB70eMvQxO7Lq3H1qjK8l3SrQRl0xiJZ+vunlzfnfyHJx/Xeg86sRCQTEWasRJ1xCcg5Z5KEn2/lGBT2ZMc1hzP8YFSoo5AxF7LvjJhTIMEDGn0fIudAo4k3bwAmMQnfYHEYdNyYU6GPulYPc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 10:22:29.4098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52453438-c249-4c4d-4f04-08df08dc17ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6591

From: Peter Shen <peter.shen@amd.com>

Add shunt resistor configuration for LTC4287 hot-swap controllers on
Anacapa EVT2 platform.

The resistor values are required for accurate current and power
measurement by the driver. These settings reflect the actual BOM used
on EVT2, where different sense resistor values (150 uOhm and 250 uOhm)
are populated across rails.

Without this configuration, the reported readings would be incorrect.

Signed-off-by: Peter Shen <peter.shen@amd.com>
---
 .../aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi   | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
index ab16e5ad5871..5f849bd21fe0 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
@@ -37,6 +37,30 @@ gpio@24 {
 					"RPDB_FAN7_PRSNT_N_R", "RPDB_FAN8_PRSNT_N_R",
 					"", "";
 			};
+
+			power-monitor@42 {
+				compatible = "lltc,ltc4287";
+				reg = <0x42>;
+				shunt-resistor-micro-ohms = <150>;
+			};
+
+			power-monitor@43 {
+				compatible = "lltc,ltc4287";
+				reg = <0x43>;
+				shunt-resistor-micro-ohms = <150>;
+			};
+
+			power-monitor@44 {
+				compatible = "lltc,ltc4287";
+				reg = <0x44>;
+				shunt-resistor-micro-ohms = <250>;
+			};
+
+			power-monitor@45 {
+				compatible = "lltc,ltc4287";
+				reg = <0x45>;
+				shunt-resistor-micro-ohms = <250>;
+			};
 		};
 
 		i2c@1 {
@@ -51,6 +75,24 @@ gpio@24 {
 					"","",
 					"","";
 			};
+
+			power-monitor@40 {
+				compatible = "lltc,ltc4287";
+				reg = <0x40>;
+				shunt-resistor-micro-ohms = <150>;
+			};
+
+			power-monitor@41 {
+				compatible = "lltc,ltc4287";
+				reg = <0x41>;
+				shunt-resistor-micro-ohms = <150>;
+			};
+
+			power-monitor@45 {
+				compatible = "lltc,ltc4287";
+				reg = <0x45>;
+				shunt-resistor-micro-ohms = <250>;
+			};
 		};
 	};
 };

-- 
2.34.1


