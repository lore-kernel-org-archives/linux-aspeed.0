Return-Path: <linux-aspeed+bounces-4940-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17A5C61DD6
	for <linux-aspeed@archiver.kernel.org>; Thu,  3 Sep 2026 00:23:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hb0gK372jz2y8F;
	Thu, 03 Sep 2026 10:23:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c000::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788344561;
	cv=pass; b=PucDg2ocsFhrco5AcyRg0c1JzW9mGjeTlzhSLns3v3RjXeyetHd11wiEjpJqPdIFzw9RVRuhsMNogBhbiNHIyKau4pBgdL865ThRFHSuIT+FIzUDoSsCnm/lfbCPAord8T2AJsuQrWI09osClXDe0Ge6AhQ2RHCPM1P7E4qZXtZFWeaNjO0m9cMGeyTwIFbkp8m86FPiGTgmylvWoBkNuB4oda6QlgOspqFeAFpehMjej5nQ6nwpeVL6444y93xKDzUNhe54XN9SBVlTU8ZMEWQ+Er1DjQQWTzM5R2lG+Ig+4lAkjeGUbVcGuxqUT/Oiozyaf373id2OD+KYNMwpzw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788344561; c=relaxed/relaxed;
	bh=XbSCKyMrT/ZOGH8aRRGRqVX/VKc3j/kguw6SGXo0EDk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=L7iCo5N9bHGdhz8UtxZeb2Iq2z9yeaI91aNC/pmSKAnTLFvs8We0vUJL0qUS+dGE17n7yOviMzji2Ticp1Ef+KBxFQwtWiAmbNgjIlIgJ1gXRb3cm1XGDN0zXNRzQT4MNqHy1oiAHKncpGpZxopootHFdqlXJPcsSEBRvfvxu3NJze2WeMFLOI0fowUtifdsDoINfdQYkaU75kC5NGfetOU3oAjyHfB8un/1xVZNhyZTf703eASte+a/3/aIIXoCWW9tWi69pNloAGTX3B5p5KhyKiRMkMFg66zejsC1nd1JlVWEDjmkhycorMo7rBh3haiGtFpuk+d22Lvj1j2kWg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4dFDzOpR; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c000::1; helo=byapr05cu005.outbound.protection.outlook.com; envelope-from=colin.huang2@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4dFDzOpR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c000::1; helo=byapr05cu005.outbound.protection.outlook.com; envelope-from=colin.huang2@amd.com; receiver=lists.ozlabs.org)
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c000::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZf1X1ZC5z2xBK
	for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 20:22:40 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V0Xj/zMiKlpPPlVc1pNkpgf52FDo62327NbSK5LHjAaLH6W1pLMb+s8CF19FTUhnoqKThDwzMSDU3snuWBc+Ru5wNKd15h5FciW3jKEMNTK6dvvCvLD54erPjjF7jwIZTYeqpmNxU3EsFuhttm01m79dfuBjmNdQ0XNBG0Zq9lbzWYXRJRyuKJ2+eKm6ESyeJ4qu2ws/ppDFYnWwLNf8+BQqPpNfXiUaXxA5CYEA0aU72X4IL5VpzNP3clg8VmDVou7IoTu58ox02ai/RBm07+wKyvJXdRcEwGuQHQb8F9GOokHPnJS/yIOXF3WPJ3FE6l7Xurq18XjtddO47iVhWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbSCKyMrT/ZOGH8aRRGRqVX/VKc3j/kguw6SGXo0EDk=;
 b=HQkzCCWPW7ae56mnzWkMaGoGzqgTRdu+pNWZ/SdEmfzNxn5JIHtuxU+1CYKALHIUUf3M+8qoKm/VR68RefgqHPzaFN1kUwS7/fNg+fbIwZt9YcfHMcT+1bXYM/g/oXIRrAqkfjq2YrBJNH+DXmRPSXkQBuTVBPxfEEQvNw3F398jRFDdrCxAkBhsCJAl17ojGz3/05xULSqRh9uqM16N39U4ATmfbdR7Zy+JAmH918R39ixZ8ojhcOISug/bRUsc/8AqiooTuxsfq0FhV3UBZKkLZ54dkYF3GzkF6kLnV+EJQi51m1Ra72FCL1O2lcPMXUk+6mxAWocREw2Jdp1S5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=aspeedtech.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbSCKyMrT/ZOGH8aRRGRqVX/VKc3j/kguw6SGXo0EDk=;
 b=4dFDzOpRqE7yB0zZRpzRM8SSOxXo2ld7nc3B5QhCC/KsIM1HI4dhCyuxJE4ryoSvi98ixnCKS0FxvNW8flxShCtmgR/TesVCMe0tvlk9crSfjbqcw5IhSVcspxtGfWIUcGL/jlnpG0gbOji0WnmmfKer8ut8reSBuWgWTccAC5M=
Received: from PH7P220CA0132.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::24)
 by CY8PR12MB7315.namprd12.prod.outlook.com (2603:10b6:930:51::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 10:22:11 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:510:327:cafe::76) by PH7P220CA0132.outlook.office365.com
 (2603:10b6:510:327::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Wed, 2
 Sep 2026 10:22:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 10:22:10 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 05:22:08 -0500
Received: from [127.0.1.1] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 05:22:05 -0500
From: Colin Huang <colin.huang2@amd.com>
Date: Wed, 2 Sep 2026 18:21:14 +0800
Subject: [PATCH v8 02/11] ARM: dts: aspeed: anacapa: Add EVT2 devicetree
 inheriting EVT1
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
Message-ID: <20260902-anacapa-devlop-phase-devicetree-v8-2-69c8eb2a7cda@gmail.com>
References: <20260902-anacapa-devlop-phase-devicetree-v8-0-69c8eb2a7cda@gmail.com>
In-Reply-To: <20260902-anacapa-devlop-phase-devicetree-v8-0-69c8eb2a7cda@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<colin.huang2@amd.com>, Colin Huang <u8813345@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788344509; l=5680;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=bE1xb1OaXR8eZ6VfDKZkB+HVFJAwxHzocx20tKXED/U=;
 b=t26EH8IjsujkPLPvkqndq9fFqxAvFANJ1MHlUQQPN4+kzGiX5VdPaIqjW8qGngCQBa4ADDC8B
 MiwGAEGgKbeDXEhg0HS8AucPw9ZBHDFBIEQGw/3OBUn4YCv2gEVgfB3
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|CY8PR12MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: 8661880e-0abb-400f-244d-08df08dc0c85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700016|23010399003|10067099003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MIZ/8woL4cZjygYT50vVPsUBE+LAmcFCZlfBgmXwK/d1laeoVkBTqgiH2R7E4kO0HCuyWn1WE0NXosUMa0OXjvJAAGfWEYdjXxIKJEAVNmTsiXIMm8yU4uriEYx8t7UTdDslwBieW1ud7s4TTMMdDP9aA+yDBecAn1IE4dl284POqRwkbMtfAyIaH91vxR4U/tB1ybEXJWSM83O1SctM/zebuc3GcyDyDGFnn/2JsS7wKaE4gtNOWiRWNxsRYN5ZxbQiabYyObfPI+0jKHDEGcG8TKQ7Di1yFF512w6D6+f2OI/XOFmjAOYFrlEQkAH6wDOhFptn+AySQVa5pFFDV5W0mF0YXY2ulW0D8Ktrpg078KfckMzWBiGDT9/KWE8Y/qOU372vSQMkZYQILF31r2M9SW7tZpPvEGO90VkMsEuQax/fP4eWs4POwxdoj84NNnqS/2DX/zU48ulaTWGDl8hHHVOXgQbHGVDyzh/8zHQAY48l8j9v++MxY/+y79uxm9MsmD7XIl6Sfluv82ZPrDwXSaK0MGsA7A+jDaIV1r/taNRDwUyYENqEQ540ed90bZZD+LtgMGMg7csHtN85UA2PJkF7kmZiDE6Ew2NDQepCAYuNUSsYOQn+zAXKdKZNO2F/adnG4ItBkbi/LonsHoBRVwrZobisRrMlF/htE2pz5OCuNG1cIks1TT1s3KHscDSqJIgQXjiK9Q2Fx0nWSQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700016)(23010399003)(10067099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OAxo7rlFNSGs5r7Jyc5vLck+j16tJaiiP4mAlZ9c/78QebaDcoJO+4wkMAXNbzEJHaiPnkeexVkk7b6PWUmN4jN767c1C0RNw8AjPeA10omC46e5yxu9+D04e7rgRA12zkqmQI2KPzc1v3m6CHoVfsQQeY1MIfGaElYeYRc/IhJCaSW05BY0xmmF3k2G4XaedjWbipX5+fnzzQn/OABnbMBeGMDhoBpopSWIbvkfLvXO7kxrvZCoCEiWmPsc8rABCGO2yrXjrREovlY7zGWH8JjMahixDZXtpEGrCnF7HgAORu4vWROYlDg9bx6nviE0S4VMeDA9Ed2kBZHdMf2ypmFdfLsKQTEboXmNw295S/ZfKtBmjtj3c8NMk6HG3VU3JtjiDn/cdcM+4UFFlKKD0Bn+lrbLd1tMEkk3FeqFWiFr0VzaJg56CDlAYpyVSpUX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 10:22:10.4471
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8661880e-0abb-400f-244d-08df08dc0c85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7315

From: Colin Huang <u8813345@gmail.com>

Add a development-phase devicetree for the Facebook Anacapa BMC EVT2
hardware revision and update the Anacapa wrapper DTS to reference
it.

Signed-off-by: Colin Huang <u8813345@gmail.com>
---
 .../aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi   | 167 +++++++++++++++++++++
 .../dts/aspeed/aspeed-bmc-facebook-anacapa.dts     |   2 +-
 2 files changed, 168 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
new file mode 100644
index 000000000000..c43090618c4a
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include "aspeed-bmc-facebook-anacapa-evt1.dtsi"
+
+&sgpiom0 {
+	gpio-line-names =
+	/*in - out */
+	/* A0-A7 line 0-15 */
+	"L_FNIC_FLT", "FM_CPU0_SYS_RESET_N",
+	"L_BNIC0_FLT", "CPU0_KBRST_N",
+	"L_BNIC1_FLT", "FM_CPU0_PROCHOT_trigger_N",
+	"L_BNIC2_FLT", "FM_CLR_CMOS_R_P0",
+	"L_BNIC3_FLT", "Force_I3C_SEL",
+	"L_RTM_SW_FLT", "SYSTEM_Force_Run_AC_Cycle",
+	"", "",
+	"", "",
+
+	/* B0-B7 line 16-31 */
+	"Channel0_leakage_EAM3", "FM_CPU_FPGA_JTAG_MUX_SEL",
+	"Channel1_leakage_EAM0", "FM_SCM_JTAG_MUX_SEL",
+	"Channel2_leakage_Manifold1", "FM_BRIDGE_JTAG_MUX_SEL",
+	"Channel5_leakage_present_EAM1", "FM_CPU0_NMI_SYNC_FLOOD_N",
+	"Channel4_leakage_Manifold2", "BMC_AINIC0_WP_R2_L",
+	"Channel5_leakage_EAM1", "BMC_AINIC1_WP_R2_L",
+	"Channel6_leakage_CPU_DIMM", "CPLD_BUF_R_AGPIO330",
+	"Channel7_leakage_EAM2", "CPLD_BUF_R_AGPIO331",
+
+	/* C0-C7 line 32-47 */
+	"RSVD_RMC_GPIO3", "RTM_MUX_L",
+	"LEAK_DETECT_RMC_N", "RTM_MUX_R",
+	"HDR_P0_NMI_BTN_BUF_R_N", "FPGA_JTAG_SCM_DBREQ_N",
+	"Channel6_leakage_present_CPU_DIMM", "whdt_sel",
+	"", "JTAG_CPLD_TRST_R_N",
+	"", "",
+	"", "",
+	"", "",
+
+	/* D0-D7 line 48-63 */
+	"Channel0_leakage_present_EAM3", "",
+	"Channel1_leakage_present_EAM0", "",
+	"Channel2_leakage_present_Manifold1", "",
+	"Channel4_leakage_present_Manifold2", "",
+	"AMC_BRD_PRSNT_CPLD_L", "",
+	"Channel7_leakage_present_EAM2", "",
+	"", "",
+	"", "",
+
+	/* E0-E7 line 64-79 */
+	"L_PRSNT_B_FENIC_R2_N", "",
+	"L_PRSNT_B_BENIC0_R2_N", "",
+	"L_PRSNT_B_BENIC1_R2_N", "",
+	"L_PRSNT_B_BENIC2_R2_N", "",
+	"L_PRSNT_B_BENIC3_R2_N", "",
+	"", "",
+	"", "",
+	"", "",
+
+	/* F0-F7 line 80-95 */
+	"R_PRSNT_B_FENIC_R2_N", "SGPIO_READY",
+	"R_PRSNT_B_BENIC0_R2_N", "",
+	"R_PRSNT_B_BENIC1_R2_N", "",
+	"R_PRSNT_B_BENIC2_R2_N", "",
+	"R_PRSNT_B_BENIC3_R2_N", "",
+	"", "",
+	"", "",
+	"", "",
+
+	/* G0-G7 line 96-111 */
+	"L_PRSNT_EDSFF0_N", "",
+	"L_PRSNT_EDSFF1_N", "",
+	"R_PRSNT_EDSFF2_N", "",
+	"R_PRSNT_EDSFF3_N", "",
+	"HPM_EDSFF_PG", "",
+	"", "",
+	"", "FM_BMC_READY_PLD",
+	"PRSNT_NFC_BOARD_R", "",
+
+	/* H0-H7 line 112-127 */
+	"R_FNIC_FLT", "",
+	"R_BNIC0_FLT", "",
+	"R_BNIC1_FLT", "",
+	"R_BNIC2_FLT", "",
+	"R_BNIC3_FLT", "",
+	"R_RTM_SW_FLT", "",
+	"", "",
+	"", "",
+
+	/* I0-I7 line 128-143 */
+	"EAM0_BRD_PRSNT_R_L", "",
+	"EAM1_BRD_PRSNT_R_L", "",
+	"EAM2_BRD_PRSNT_R_L", "",
+	"EAM3_BRD_PRSNT_R_L", "",
+	"FM_TPM_PRSNT_R_N", "",
+	"PDB_L_PRSNT_R_N", "",
+	"PRSNT_EDSFF_BOOT_N", "",
+	"PRSNT_CPU0_N", "",
+
+	/* J0-J7 line 144-159 */
+	"PRSNT_L_BRIDGE_R", "",
+	"PRSNT_R_BRIDGE_R", "",
+	"BRIDGE_L_MAIN_PG_R", "",
+	"BRIDGE_R_MAIN_PG_R", "",
+	"BRIDGE_L_STBY_PG_R", "",
+	"BRIDGE_R_STBY_PG_R", "",
+	"IRQ_NFC_BOARD_R", "",
+	"RSMRST_N", "",
+
+	/* K0-K7 line 160-175 */
+	"ADC_I2C_ALERT_N", "",
+	"TEMP_I2C_ALERT_R_L", "",
+	"CPU0_VR_SMB_ALERT_CPLD_N", "",
+	"COVER_INTRUDER_R_N", "",
+	"HANDLE_INTRUDER_CPLD_N", "",
+	"IRQ_MCIO_CPLD_WAKE_R_N", "",
+	"APML_CPU0_ALERT_R_N", "",
+	"PDB_ALERT_R_N", "",
+
+	/* L0-L7 line 176-191 */
+	"L_EDSFF0_PG", "",
+	"L_EDSFF1_PG", "",
+	"R_EDSFF2_PG", "",
+	"R_EDSFF3_PG", "",
+	"HPM_CPLD_HEART_BIT", "",
+	"RBB_CPLD_HEART_BIT", "",
+	"LBB_CPLD_HEART_BIT", "",
+	"FM_BIOS_POST_CMPLT_R_N", "",
+
+	/* M0-M7 line 192-207 */
+	"EAM0_SMERR_CPLD_R_L", "",
+	"EAM1_SMERR_CPLD_R_L", "",
+	"EAM2_SMERR_CPLD_R_L", "",
+	"EAM3_SMERR_CPLD_R_L", "",
+	"CPU0_SMERR_N_R", "",
+	"CPU0_NV_SAVE_N_R", "",
+	"PDB_PWR_LOSS_CPLD_N", "",
+	"IRQ_BMC_SMI_ACTIVE_R_N", "",
+
+	/* N0-N7 line 208-223 */
+	"AMCROT_BMC_S5_RDY_R", "",
+	"AMC_RDY_R", "",
+	"AMC_STBY_PGOOD_R", "",
+	"CPU_AMC_SLP_S5_R_L", "",
+	"AMC_CPU_EAMPG_R", "",
+	"DIMM_PMIC_PG_TIMEOUT", "",
+	"EAM_MOD_PWR_GD_TIMEOUT", "",
+	"CPLD_AMC_STBY_PWR_EN", "",
+
+	/* O0-O7 line 224-239 */
+	"HPM_PWR_FAIL", "Port80_b0",
+	"FM_DIMM_IP_FAIL", "Port80_b1",
+	"FM_DIMM_AH_FAIL", "Port80_b2",
+	"AMC_THERMTRIP_ASSERT", "Port80_b3",
+	"CPU_THERMTRIP_ASSERT", "Port80_b4",
+	"PVDDCR_SOC_P0_OCP_L", "Port80_b5",
+	"CPLD_SGPIO_RDY", "Port80_b6",
+	"FM_MAIN_PWREN_RMC_EN_ISO", "Port80_b7",
+
+	/* P0-P7 line 240-255 */
+	"CPU0_SLP_S5_N_R", "NFC_VEN",
+	"CPU0_SLP_S3_N_R", "",
+	"FM_CPU0_PWRGD", "",
+	"PWRGD_RMC", "",
+	"FM_RST_CPU0_RESET_N", "RBB_CPLD_RISCV_RST",
+	"FM_PWRGD_CPU0_PWROK", "LBB_CPLD_RISCV_RST",
+	"AMC_FAIL", "HPM_CPLD_RISCV_RST",
+	"S0_ON", "";
+};
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
index 5e76076bdcd4..606dacb605c5 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
@@ -1,4 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 /dts-v1/;
-#include "aspeed-bmc-facebook-anacapa-evt1.dtsi"
+#include "aspeed-bmc-facebook-anacapa-evt2.dtsi"

-- 
2.34.1


