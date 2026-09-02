Return-Path: <linux-aspeed+bounces-4953-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514EBC624DA
	for <linux-aspeed@archiver.kernel.org>; Thu,  3 Sep 2026 00:29:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hb0pK3y6lz2yrw;
	Thu, 03 Sep 2026 10:29:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c101::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788344563;
	cv=pass; b=guc9qpx8EsS3olW/yPmirsaYwuZMICgkTmg6Dba2yCy1S/S5extCs9THXoLDk7mXcKAfK0R3s1eTZIK1n4sbQMLH72rkZhT9ZtJqzu6KHjX71L9o1GkVXTMwgwnduh/uHwULyAeW7BkuajZhF1L01xIB128kwI7pJNrL2zeYvLd+zySLmLqSKC+AkECoprNLmYaN3djvM0dm5MxoOAo6v/6Q5yhVLZpdpnJ+jQmuQU1add0CzGD5Kig99qnzo9IHMrlCgL6yAfVOrRUP6WC9p98UFv1fChXZms1xn7dz2u+5B2grkLAGl1LO63HOUmiuUeFdqzzSNpHCMofLWJqP9Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788344563; c=relaxed/relaxed;
	bh=ncn6nEjTd/VSMpTYs+agV/Z974c9d5sxAMfBOFW/qiU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=K+U3NM25dYcD6urwLlyUzk5cEYdG4oVpXdp/6Dvx5L1dN9n3g06whZG45SnbD9xlBynW2XAqvVyq+B8CwwgkRweBxKkZhum9J928UnvNrA1Phx0kh9QjYQWWR8wh8Rhy9Wihj+yOfObfcuBOPdJmBkWFirhsuIA4O0Un9UTcCI+lflq3azd0ub61nrkET0vcHv2iLtJjVtj7Ukun2MsM4HTcizdihY68RAHleVu5tVOII5/q7t2B1hF6tehBwbjqaPr1wfQ4ZAy+PUPI1V5IDzaCyzkdfTc02DaAzkDMKoVXxSXggfc8wChjppxtr0epcF/6Ct946rKEXD7Wr5nWFg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=A8NhcyhL; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c101::7; helo=bl0pr03cu003.outbound.protection.outlook.com; envelope-from=colin.huang2@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=A8NhcyhL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c101::7; helo=bl0pr03cu003.outbound.protection.outlook.com; envelope-from=colin.huang2@amd.com; receiver=lists.ozlabs.org)
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazlp170120007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c101::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZf1Z2rNKz2y22
	for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 20:22:42 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hkd32MqBRaloeESLwBAxkbxTa+KOx/ycZRWzBwdfSQBIKhxsMDthmu5HK33xLC/wkKAhnpIaq0TDdlPiqIQ+fJ9RNgLBRNdTx9/FSRpNjmfDHOthN4Zkm9rZdsNmD0OhVwoBEYR6Ki461MkJ4PoZFZejFytLl8vfdLc499aW3Ta0Wq3JsAk12wcUouCJPmKresLC7Ekx9g7+8PF/ncTsGA7SBmGTuDcjVcpKlHZB9Kgs0SU2cdhzYgIIoEfLnLcQMIvy6Z54qauO9p9ElDe77B4voyELrdsVDzEgmvED2sfZggAY7r91YLEm4qvJOKdGao0MGcCnjWKqBJt5Iv0zKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncn6nEjTd/VSMpTYs+agV/Z974c9d5sxAMfBOFW/qiU=;
 b=Lt3hq3Nu/ipdDnN47UEg937h1gDogdgY0hB+g7fdcKfckap2TvRLSU8/SqdTRi/9LRdt41VC9ZMaqvZiz3/KoxVbohHB2udfASm6o45k77Mbk1JT2tVFJptuH673XilI8X6/7TKkROTXlU304NZU6ZTey8O+KAG5mnewA7RRmyqyTTjn3a30pwzAZecgdEgt/H7TfbwzbAd46Swp6VXVzpPidndpaZMwmQQhHp6sb1ZrSLdqAcewnHrHIyfzPj245cj3UKGvyFyZGOJlKehE6wot/6iN3gGhwle+2oDgiR80xiELA0iy7dJHkXXs8P4X20ls3BBxryzs4Mi2+HE1rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=aspeedtech.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncn6nEjTd/VSMpTYs+agV/Z974c9d5sxAMfBOFW/qiU=;
 b=A8NhcyhLHSAUl6FgBOIpdcefyRitQe94pUcAEfqgUjjB35EdgMhc8AZxZRC1xDuOfuu/rSm7Xn1kM0WTenXg73OOPayZLHotIAXgGjav34S4qsO1Lo4in05CMlOvOcfph5oi1TGwUcsa5fp+dL6cDvbdNWYXSeVuvn50pc5GSTY=
Received: from BN0PR02CA0038.namprd02.prod.outlook.com (2603:10b6:408:e5::13)
 by DM3PR12MB9287.namprd12.prod.outlook.com (2603:10b6:8:1ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 10:22:14 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:e5:cafe::e) by BN0PR02CA0038.outlook.office365.com
 (2603:10b6:408:e5::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 10:22:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 10:22:14 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 05:22:11 -0500
Received: from [127.0.1.1] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 05:22:08 -0500
From: Colin Huang <colin.huang2@amd.com>
Date: Wed, 2 Sep 2026 18:21:15 +0800
Subject: [PATCH v8 03/11] ARM: dts: aspeed: anacapa: Add DVT devicetree
 inheriting EVT2
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
Message-ID: <20260902-anacapa-devlop-phase-devicetree-v8-3-69c8eb2a7cda@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788344509; l=5821;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=AQ5iLkgP6NLAtcRqZ6tcsMzjF1xEYDqVB0kQ/nuplqc=;
 b=0cFc2zWeed6lqE3bWnjKswhvjdrE3pAqWHtwmDPmup3bUHwZ+IV4CG71VVhLXiMXOA+GkW4oK
 Z8G4TbThBV3ChkPo77GgvRZED6hECQgZSNPJj4WDJUD9+wJslGDjLSa
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|DM3PR12MB9287:EE_
X-MS-Office365-Filtering-Correlation-Id: f0c15d0b-f8f2-4e18-14f5-08df08dc0ede
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|7416014|6133799003|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	ALzAp8TQbfyZkXllYzanNZ8xv/H8mSe4PDi7NteCCnn9V+FLPRmOFINSJFmw0efs/UnFlduO/p/ldvlJTwkNZzNYPaetW1zNjiZ7C1OmZXqlfEOC3FJAUMpnNoKrg3vA5KlZvpjzRwlh2oJtA8YPW9AFVnrn22ynjCJuUK39RFV2Pfnl2JSfFQ8BiExBw8asGenaIwVfJ65y1kBoe4+E7r/xGGQwHtmkDfOYuSP7p+487nTlNMzGoGW6V/B847KL+FZ9JKRdFPPlXZ67RU/lUXA8O+LeoYImtlZkk1v67opodlFA0VqOIoX941esUHLXSMV1uB9YbUVfxihkJvC2DjQbknejIMeUNwVGrbMnjbMbyItTyLvquAP7NsZT0PcIgnGEkrBZoY2BP2lbWJTiYpktbOYk+1jEUMTeeDugk9K7mckKSrpy3HBL6uNFtFm6E+sEDiCTttoHWRx8BfVSNkNWQP+UyYg1jDD8QrBgyMWRxRRvVvuNSJKTWzOwYorlEqIlxmtiAJExquGhNkuEXLh+9bvy7kngPsSJNfcf3E+6mK9/xlg7QRJ3LhtSlXn/FVtGZaW78iZDFJQWQQ7spdIrS9RpxQg1luDyXy/lwoTW5HKzBmCYoPxaw8V099w+1PQ9JohMapZG6gPG6BUi/9AHDELa6pVdkfD5f9fz23M8sNeAdjvxWrjhM27Hr98zihDF5SGF0ZBXqWKRUVYzFw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(7416014)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Dk36W93pWtW7drv4KCEQj0c6GSnMoSDYMTJ8usTYXwiYqjE1CymMQT1WkJNSHevvBW2uN+6PQx+Pfoeo9RrDpOhfqibZ1fb+8fpappyCFjyvO700JheJEQ+neYzIlb7cI3SDiGOeG8+nnYo+1zrqyz46zwOjtdbSsAKzvqhKxMHQ116iXPiaUlUkiCKLYsdF4fHGFKwail9qbfi1naqFJ4YVHECI8h1L1HoENzXStVs8EAkg7PEY0N4WuX667TN218pKpLD62pbSBRx3iXz33634EjC0/PKX2F08V/ukb+AmpLXIIyRiQbTeCkgTRS285QdT92PTT3Wt51suMX0o/t7aYndgBiUs+l8My3d6yc7FuUpY4M4AW3Yy6XjxYN8f6CD9AVuFnGo4nev2rgq1oUePp/8w2eA8XPMU45jmvqZy/cryCwk0mQqC9looZ5U6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 10:22:14.4753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c15d0b-f8f2-4e18-14f5-08df08dc0ede
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9287

From: Colin Huang <u8813345@gmail.com>

Add a development-phase devicetree for the Facebook Anacapa BMC DVT
hardware revision and update the Anacapa wrapper DTS to reference
it.

Signed-off-by: Colin Huang <u8813345@gmail.com>
---
 .../aspeed/aspeed-bmc-facebook-anacapa-dvt.dtsi    | 167 +++++++++++++++++++++
 .../dts/aspeed/aspeed-bmc-facebook-anacapa.dts     |   2 +-
 2 files changed, 168 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dtsi b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dtsi
new file mode 100644
index 000000000000..0509bc8bb9cd
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dtsi
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include "aspeed-bmc-facebook-anacapa-evt2.dtsi"
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
+	"R_EAM0_NIC_CBL_PRSNT_L", "JTAG_CPLD_TRST_R_N",
+	"R_EAM1_NIC_CBL_PRSNT_L", "",
+	"L_EAM0_NIC_CBL_PRSNT_L", "",
+	"L_EAM1_NIC_CBL_PRSNT_L", "",
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
+	"P12V_PWR_CABLE_PRSNT_L_R", "FM_BMC_READY_PLD",
+	"PRSNT_NFC_BOARD_R", "",
+
+	/* H0-H7 line 112-127 */
+	"R_FNIC_FLT", "",
+	"R_BNIC0_FLT", "",
+	"R_BNIC1_FLT", "",
+	"R_BNIC2_FLT", "",
+	"R_BNIC3_FLT", "",
+	"R_RTM_SW_FLT", "",
+	"RBB_Cable_Present", "",
+	"LBB_Cable_Present", "",
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
index 606dacb605c5..1eee0d84c0a8 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
@@ -1,4 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 /dts-v1/;
-#include "aspeed-bmc-facebook-anacapa-evt2.dtsi"
+#include "aspeed-bmc-facebook-anacapa-dvt.dtsi"

-- 
2.34.1


