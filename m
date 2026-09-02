Return-Path: <linux-aspeed+bounces-4934-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA89C624D6
	for <linux-aspeed@archiver.kernel.org>; Thu,  3 Sep 2026 00:22:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hb0fb1ypfz2y2X;
	Thu, 03 Sep 2026 10:22:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c10c::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788344584;
	cv=pass; b=jUFO+ZGeOcfqYl9vvewwLSJ6UOVtqbzzXUdn1u5RQiCWp805YplJXs8cHL5Vs7lCQxxS0R9NZMjcEW3r+W5v4npZ9TVeaG2Ttzb5CheLXSjKGZyrHKPDMc6I8q4iQ8ks/NBcQgqcrDmEI1p3GSKJZ8WpKsKMFjb7ZLZTdZR4x4Z8OfHzeU3ED3ZYQG2794oem+fP9mgSmnUmD+A46DQ+T9CYNHhY0tt0kDjs5WL9AWQ0p0gZjvzwoC60iDyIrTgX7LcgGPnn1s3BA3S1ZJOCD5xq0yQRxWldPV1wgvvft/yURFo1v2IgLbzBRkqWid362ZqulJ3qnyzPg6Cw/nln6A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788344584; c=relaxed/relaxed;
	bh=UC1UrUC5+1MFX+bsxPknCKB9Evo5iMJG+r1LPOuLMSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Q50HINnrRcp4N0K/+VrDskVIVH1VK2KbRIcuwwcuP4JUsysgitd/PsleRHGt3ZjCpbJfsIB0yoOcD+87EiDcV75HZQKf0kvz/MPMSEAidwULeLV92kuBP5HlwljNLk/ApQmI2CWSDUm8g+tmMwunwg9Ry8gNdq7vUIYZpJ1fuJnao2AQYF/6M8m9wU/DRazZDdEs7fizwGwKHiV1m0mfS/toXBqusHmB7igDS/enWSXf7wI0JuEznrRYACIag1QKf0f2hIvIeVUFW3EHHqkNrmkKjck2iw6IchwrJFvRB0ekM1/6XnFB15dA54g5Xkv0z+XDHlE0iYOy/ugW3hNK4Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ZiYfaNy2; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c10c::1; helo=sa9pr02cu001.outbound.protection.outlook.com; envelope-from=colin.huang2@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ZiYfaNy2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c10c::1; helo=sa9pr02cu001.outbound.protection.outlook.com; envelope-from=colin.huang2@amd.com; receiver=lists.ozlabs.org)
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazlp170130001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10c::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZf1z4S11z2xBK
	for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 20:23:03 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CbWkZeDFS23/fzCJBi1t8ST/i+lREpDyZeiZA2+xLLPBpgcRquJgY8geDCnhxPlmgE6KIZ0fbS7yH7E6HWzenHNys0DxkEVxLpl5WglSazLbxUy+6deGkhIgGwDo1AyHFDoGBvHxO9QbGdV+/X7tokZQS+R0NdF+aMORP5y1q+f33w8lZsWGMx6ftY8h0ZOwXN6WYueS2Le5PcQNLbCTlSHST0qsrPXmxMtZcqfLXXXb5hHx5eew1ppUG334IGZqMlVTqu71Vy2TNhDAgUD2goQWsBn9lNZ2wKbi7Q4hthljIS8eWCgp3F3+wB3yETZTI/Sh/GZjVp/JAy5DbiWr7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UC1UrUC5+1MFX+bsxPknCKB9Evo5iMJG+r1LPOuLMSU=;
 b=WERsuZr/Jkw1A7kK6wp03bTMTWjHkIMEzWp7STSbyc4m4TKy+L7IIjun3h3YHGg5tobrkRlosQoiBQYVB5BqtVnmAzL48RUHOycDoBF9wPkPH+brNuH1ZZB1BDsF5KPefD5rkINMZrMEfEKTtaCFocGZKMg6wJVKoY5e18xtYTFpZ6f9oOK3VfVtzn9FboiiioD4wkrj9riWSad9TWBP63pLPYOvGS28X5g+Zy+KIdrNwUp7XqD2SYBzPYYxJlrCR+JR08aXIiVIKGv+ElQXVRyWjIlVSLZKqrhc0JWJaGb3wWuYP/EyMaOgtMbF8pQuJ4cFKgQl7FQjSeywD/JAvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=aspeedtech.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UC1UrUC5+1MFX+bsxPknCKB9Evo5iMJG+r1LPOuLMSU=;
 b=ZiYfaNy2bFxr/RXAuF9oBRcV8csqxqxr4vOlcZ55Q5QKvw3ToIqstQmb4DTEfmsvX7FJDfaYn/zbTBgb4KYePAJ0JGAwqkWNT7pcGDlUig0zxazN5js8UL4aADqFvuO1IXF66uDrLgT2vfG35+KzDnMap7xKwtXrpuV7p+9ERzU=
Received: from PH1PEPF000132E7.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::27)
 by SA5PPFDC35F96D4.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 10:22:34 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2a01:111:f403:c902::b) by PH1PEPF000132E7.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 10:22:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 10:22:34 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 05:22:33 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 05:22:33 -0500
Received: from [127.0.1.1] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 05:22:30 -0500
From: Colin Huang <colin.huang2@amd.com>
Date: Wed, 2 Sep 2026 18:21:22 +0800
Subject: [PATCH v8 10/11] ARM: dts: aspeed: anacapa: Simplify leakage GPIO
 line names
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
Message-ID: <20260902-anacapa-devlop-phase-devicetree-v8-10-69c8eb2a7cda@gmail.com>
References: <20260902-anacapa-devlop-phase-devicetree-v8-0-69c8eb2a7cda@gmail.com>
In-Reply-To: <20260902-anacapa-devlop-phase-devicetree-v8-0-69c8eb2a7cda@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<colin.huang2@amd.com>, Colin Huang <u8813345@gmail.com>, Rex Fu
	<rex.fu.amd@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788344509; l=2443;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=4zjP23mepqtMKnSPss2kOpsZaw5ldaNVS3sb8oAIS2E=;
 b=rDvv1p4FhN8XKUe0et8CjukhE538+jnjYel4I+VUhd3SKZaOi0ZPxuhkMKXrk8GWAno9hhFaE
 QfHO8EOdnUqB/y11iO7gKeEwwLDPifuqt1/jhDQ5sx+dYZ8+y/hOU+z
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|SA5PPFDC35F96D4:EE_
X-MS-Office365-Filtering-Correlation-Id: 002a4aa9-6fe9-406d-e297-08df08dc1ad9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|376014|7416014|1800799024|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	ODakl+rhEQMOs0fyOcbxnuUc/A+UsfMpLJ6/l3COZsrlmbe6hV4mXiRw+YQ5OrHbQWQlZHyoINr7HYmBITsCUoXlEjcPML4WdpBRabGoKx5ppvU1xGSzr+00O0HBdz3JRgekWZjYSqcT/+Ug5o1LlG452TT9qCvr8EoKR9F8OagfpZZNvS1018cjXxV9tGKik0uGYFSyVECLsanziljkS39g1OmvNhMBonywdbWLSzE/85pJ/oRhUVEPbteTHejsG6T0D8+r1ahN1mhmMnoILzXePc/7yhE7RjWIKk567IhoHqOSWCkO4JV94SFYU1Xx1WZ4HEw3Fnh5kI86jaUSk5N2oic8iaOjKf4qkM4STUHzt4swtWZQv/85fyelG4Pfu6WBZ+IjnCWqcJ4MmEoKgeMhue0RSfSbqjHEmwen5ujR9UDU/r3cp29ZmGkHcaa9NZmjer1lRATwrSW1/5dVm2xRZHkHkPF3XcATOn6hvonaE7iZdSZXIVqPXUtluj/WSstnJjetsmLPvncuZBdaSqxXuTvLwV4TJxRxmltrcDuXqu/edhdkSbrmj5i7F/jRE6RggaVnv8yuvOFK1nPdfg7ffzhe8TMX3v/b27WVS3Lguh+MNhbTkSVQpkMFrBjCNJV42N0m5tB/ejIzNRsmeYyX6GVkcXCMHlWHrZLvZJmdmvigXl8I8JqQ1JwmRWedmBoNSVN46IC9oZ7RrFx6WA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vSPzwMKA3BPyE6wj7RmHhlAP5w70OJB/6yG3c7qRNNll8KDJFWthv+ihRBHaKTZI5vkxv3mrV2aURRxWuDqSgR9ipeYkyCBL+BiMwr/ql/MSfMU1mdYLpG4sGsSiWnMgNDdWG0EhEYH87S0Kzz4G7/FBjxcLmxuuGfTF+3/6cQSeyY/LoqaSsHAAPWKk07rvrDGgLp3DmynvVawx07kDEfWRRlgki37vMA4YFnyUmPPKLUwxg2xAEhraLrh/HPymvztuDp6A1CpKsZKnI+EW4RKIfu8SjUbX7wftekZVo99iPzrCJ+V3ZhNv+TYfjsFK93rDG5ujKHZN0VjpUIq06WxJYw3C3qSwMk5+ed2VhyouMv0vrm4HbHp0mYummlWL0RGGE0wS45xCx47pTVHWPeMnXbNmAMXLGyydGM2rwd8qb2Z2BVXksNM8+/oskjJQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 10:22:34.5181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 002a4aa9-6fe9-406d-e297-08df08dc1ad9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFDC35F96D4

From: Rex Fu <rex.fu.amd@gmail.com>

Remove the board location suffixes from the leakage present GPIO line
names. The channel number is enough to identify each leakage present
signal.

Signed-off-by: Rex Fu <rex.fu.amd@gmail.com>
---
 .../aspeed/aspeed-bmc-facebook-anacapa-dvt.dtsi    | 28 +++++++++++-----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dtsi b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dtsi
index 2fd7e46daa63..3b3967b47980 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dtsi
@@ -108,32 +108,32 @@ &sgpiom0 {
 	"", "",
 
 	/* B0-B7 line 16-31 */
-	"Channel0_leakage_EAM3", "FM_CPU_FPGA_JTAG_MUX_SEL",
-	"Channel1_leakage_EAM0", "FM_SCM_JTAG_MUX_SEL",
-	"Channel2_leakage_Manifold1", "FM_BRIDGE_JTAG_MUX_SEL",
-	"Channel5_leakage_present_EAM1", "FM_CPU0_NMI_SYNC_FLOOD_N",
-	"Channel4_leakage_Manifold2", "BMC_AINIC0_WP_R2_L",
-	"Channel5_leakage_EAM1", "BMC_AINIC1_WP_R2_L",
-	"Channel6_leakage_CPU_DIMM", "CPLD_BUF_R_AGPIO330",
-	"Channel7_leakage_EAM2", "CPLD_BUF_R_AGPIO331",
+	"Channel0_leakage", "FM_CPU_FPGA_JTAG_MUX_SEL",
+	"Channel1_leakage", "FM_SCM_JTAG_MUX_SEL",
+	"Channel2_leakage", "FM_BRIDGE_JTAG_MUX_SEL",
+	"Channel5_leakage_present", "FM_CPU0_NMI_SYNC_FLOOD_N",
+	"Channel4_leakage", "BMC_AINIC0_WP_R2_L",
+	"Channel5_leakage", "BMC_AINIC1_WP_R2_L",
+	"Channel6_leakage", "CPLD_BUF_R_AGPIO330",
+	"Channel7_leakage", "CPLD_BUF_R_AGPIO331",
 
 	/* C0-C7 line 32-47 */
 	"RSVD_RMC_GPIO3", "RTM_MUX_L",
 	"LEAK_DETECT_RMC_N", "RTM_MUX_R",
 	"HDR_P0_NMI_BTN_BUF_R_N", "FPGA_JTAG_SCM_DBREQ_N",
-	"Channel6_leakage_present_CPU_DIMM", "whdt_sel",
+	"Channel6_leakage_present", "whdt_sel",
 	"R_EAM0_NIC_CBL_PRSNT_L", "JTAG_CPLD_TRST_R_N",
 	"R_EAM1_NIC_CBL_PRSNT_L", "",
 	"L_EAM0_NIC_CBL_PRSNT_L", "",
 	"L_EAM1_NIC_CBL_PRSNT_L", "",
 
 	/* D0-D7 line 48-63 */
-	"Channel0_leakage_present_EAM3", "",
-	"Channel1_leakage_present_EAM0", "",
-	"Channel2_leakage_present_Manifold1", "",
-	"Channel4_leakage_present_Manifold2", "",
+	"Channel0_leakage_present", "",
+	"Channel1_leakage_present", "",
+	"Channel2_leakage_present", "",
+	"Channel4_leakage_present", "",
 	"AMC_BRD_PRSNT_CPLD_L", "",
-	"Channel7_leakage_present_EAM2", "",
+	"Channel7_leakage_present", "",
 	"", "",
 	"", "",
 

-- 
2.34.1


