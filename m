Return-Path: <linux-aspeed+bounces-5091-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9032CA5FC4
	for <linux-aspeed@archiver.kernel.org>; Thu,  1 Oct 2026 01:01:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwDBt5lsCz304x;
	Thu, 01 Oct 2026 11:01:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c007::2" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790748859;
	cv=pass; b=fE/AkSb4XTNUvQTQThpDEfybkh1Zbaq+OHqLQbaR007x84hEkBos7OHpUUswOfbVC2bjMQeBiIF9+m0rGyCdXDFYriUY/atQmIK9sm4UbOltsylvEAxi+J6acC40O79r+3+qGM8OITwU0tBG2K/uLF0NDDkhVEfIAf/gUfv2++1hGmitjYd/TIq9JPTJpTfHhYHN/oTjIyVcx5WuxN85u8HAGnLmMpJJtbg5z7YiVdSvD9lc4pgrBaGvga3aGD6XDfP4c8RVtkEcN1GEd6uX/6MpOgaoO/SbOOT15+wMdv4+5Mu5HQJCb6JIvsmfluvgWCYexptZOgGa8Ep68ir44g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790748859; c=relaxed/relaxed;
	bh=eVazMF8Xy/35jI1/xVBN45nsZ6yUKZkMIwWRaoAJcww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=YHBuG3WRQwJfiB0vOG6h7l5qCFeEchXJlUm1MmR7F5Zvh6mCd2KiPViAXcPV1KnC2z9acKUw7tRY9M5ff1a0fmchPe5gcRI+/R5jmvWeR0r1kFY+z1UlrhfJi6GDxhipjSw79Yumll8H5EPlElYwaVBrKrZwBYvQx2HTxz980hTjZGt8pkV8xDgorjrJWnlPgnE1UCvCPAdC9I6ixHvAMwcycigXanskkZaxt/l5o7eeJoo9qEm957rObIGcedoXY2vsaF10QYY0nOs55leJxjebg8PlVS64qjerZxMe89AyOmkrBtvSAyAKwOmsyLOUdPLMNQpjO7vzQ1QoMm011A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=O59/FR+0; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c007::2; helo=mw6pr02cu001.outbound.protection.outlook.com; envelope-from=bounces+srs=ha9og=hw@amdcloud.onmicrosoft.com; receiver=lists.ozlabs.org) smtp.mailfrom=amdcloud.onmicrosoft.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=O59/FR+0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amdcloud.onmicrosoft.com (client-ip=2a01:111:f403:c007::2; helo=mw6pr02cu001.outbound.protection.outlook.com; envelope-from=bounces+srs=ha9og=hw@amdcloud.onmicrosoft.com; receiver=lists.ozlabs.org)
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azlp170120002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c007::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvlB26P1Qz2yps
	for <linux-aspeed@lists.ozlabs.org>; Wed, 30 Sep 2026 16:14:18 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mfAIws2HxnKf58Gr4cfYsECw/jqlPTnFY49Zo+jKGxXwCG/4+p5RcEVgDyW6uV8QzqCxCeBEQTPzu0zajZhGHjwZOw1a58OJoPzKSGlyEQF9aP82+X965OF9Hu17qWSxX8yIJjpzcTqF7SGySJ+Q/vHPXaSgJq8rX/LXhpN91jOAtwJlFttqT9/dGF5LCX6+Went7D1kgH0tjzwt5wboFc7a3NcrRupewPcKb3E2nsrqbQ9CVXeoEa4EwasEFdMlhMkRd/LbPTtKAOson4XVbTGX4/po9G+HB6Wo7GgBGPPgr6LcG5M8iOj+dqEJ7aSSMn/P6EAkiE6xQUQX4lBpSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVazMF8Xy/35jI1/xVBN45nsZ6yUKZkMIwWRaoAJcww=;
 b=cXNsah4f2ZOErVey2gJRbx4c2u7tb+swb1gFBNqmlmsFyH+6Ug4j2pMc3ojtoEjtzDyDwGlUKFJCQemf0IKFHm0TcTJcAsFDYUfKhuGgzC2gXJ/7qqByY+i0naCTOg+oq/lUfXssvGHZGEPhMe4ht+4SkiRacNTtFBScod46O/SAvqMDFQ0+QDlgfc7c02CrEIyrFgTw6mNND60sP/V2ylXZIQaRo9Ziz6FHdAU4V1cGHC11b+oILCQ90KuRK2jI8mXkFFVwjTH/xH5qq02lXfeGxGdO+V+15rqWgkE/bcjmvBRxXBo1FJ146UejMAbwCiSCmI1Ng00xxZC2wTwxIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=gmail.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVazMF8Xy/35jI1/xVBN45nsZ6yUKZkMIwWRaoAJcww=;
 b=O59/FR+0AcBlmi4/+hgGnrm0IzbhHFQ05ETzMs5lyPvmoj0cmI6lhg9NgLCqKrdty1eM9hkPsb+51ubPvj14rMo3SFO8dkHtbrxrwxkMLLSvnOMk3ACSjToortiVfI7he4UWDxfZ5TQSbm2j7fKTH6H5rmIbOKF9yDSrR7Vj9UwGns4jB4MADyHyibGaU6GWNTzzHIZS12loVKmAMEa40EG90y8OmRRxpdfbzG3w9KK1dl1UQEeO8F+3r03i4TDhw3xQgYk/0SN90zd3sgxpUlOnVZbsGa0Wc/Yb6D6ZdMxurigsV9+Le4Dd4ADNSWKcFFC5Flra51DdP4FTaBU/WA==
Received: from BN0PR02CA0052.namprd02.prod.outlook.com (2603:10b6:408:e5::27)
 by SA1PR12MB7149.namprd12.prod.outlook.com (2603:10b6:806:29c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 06:13:44 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:408:e5:cafe::1f) by BN0PR02CA0052.outlook.office365.com
 (2603:10b6:408:e5::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Wed,
 30 Sep 2026 06:13:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 165.204.84.17) smtp.mailfrom=gmail.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 165.204.84.17 as permitted sender)
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 30 Sep 2026 06:13:44 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 01:13:43 -0500
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 30 Sep 2026 01:13:40 -0500
From: Colin Huang <u8813345@gmail.com>
Date: Wed, 30 Sep 2026 14:10:10 +0800
Subject: [PATCH v9 02/15] ARM: dts: aspeed: anacapa: Add EVT2 devicetree
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
Message-ID: <20260930-anacapa-devlop-phase-devicetree-v9-2-f08aa0d7182d@gmail.com>
References: <20260930-anacapa-devlop-phase-devicetree-v9-0-f08aa0d7182d@gmail.com>
In-Reply-To: <20260930-anacapa-devlop-phase-devicetree-v9-0-f08aa0d7182d@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<colin.huang2@amd.com>, Colin Huang <u8813345@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790748641; l=5680;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=bE1xb1OaXR8eZ6VfDKZkB+HVFJAwxHzocx20tKXED/U=;
 b=AkATOu+lyweaH/e28rI8aNILIkARnygHOA7A48BBiKDK0z27iXOwa4m709pjYft1Y8rPminqH
 9lg7iDloP1nA4vEGVmaPhIoaFRtG7Z8DMItYl3Q8YQLyLh1rf8vzvTt
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|SA1PR12MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: b7904159-b94e-4097-79cf-08df1eb9fb39
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7093399015|48200799018|61400799027|376014|35950700016|7416014|10067099003|4128699003|6133799003|16102099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	zkBysSFJHOBYfekSYR4jKSfijqGF8/rH4aA1CojJUz7V/XEPvc5SEhDHN5aePP2/uNOe6p+HHsn5epNhIpJf30WkXpYH02dl4hh4RX0vtbO/+jPVBGTsKC1Gh8mR2ZH/7nIXBB34T8PFSt1vxq0z7XUF9EL8DsWyhe2Z1emUIH/EWbsv05UlBTTbUlhz0/nqo7sUFdC7EmhnfWeEn3GemO2/8bIgMJovlyOJUjq5qu8MRY2RwhHaOUGnWwtbGDQbdgOy5iYjZ2ZS5Xub/SAsCZ7W3Z0mpRpbzdM5zjyXlrk8P3ysxuxv8ONXicvtoLsly7Yw4zDC2dHlKzJKwVxwOqMGqtAd22qlW8UGACAvw1YWY04jrCXY4PpjEPcpdaZUvy1cF2UxUMVZa69qW6+rpjjLL24DFda3znHKXuBLj43BzBzJhQ2IYbR5QDClrWo6uDdk4EGR/g/759bJ06rI5DTma7BUKSRDkn4prxV3ubB+WH1GQfsCEwxQXe+7IlWcQ08rNPCCfJ/BBHXl9SVNPJcM8nU7rjgymvBBlz10SdWLK61q8dkqYxrSejVA8XfQzj6CRLcoP+98OWMFVd6MdHHvp5PvG4eS1p7QJ20I8aylBgxn1FQjUogB5IY8umH7m/uckhau5vercB0zpgnvKFYCfoDuRFrkESqcsJ2EkaIVqy4D/mSvZDe/rtla/DQG
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7093399015)(48200799018)(61400799027)(376014)(35950700016)(7416014)(10067099003)(4128699003)(6133799003)(16102099003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	C8gmybWGPJqjlaOLG8fB+p7MccktKcT+k8tOojb5mcZy4TybI55ZaOwdsGRPfj2/Sj1V8nil5lTkLA4o4xzhzvM0o2We3lHLlkC7pkgwUJE5kl4OznSc3cL6Zm41k8r+d4ajYd2uxm0P4dZGQeB9swx4umBhy/X41PG/3sH6imaHsKvXtCRsUVoZUWFAKYi9iWf5Ljgski1nrQJ198M/r3exd3FEx0xFozCGrBMpwXY0gieQx8G8Dtf3mSn3Ud6wJlGcymOhvzGABGIq+Q9uEoBKwdv2dKiHxE6GoKSEUmop2E+SowJueAWELEstQH/DBEOOncL/MsXqGnlPUypk2YTvBeYXhEIL5XBKQZOTkg8aoB02fpHDowMOd5TybAuZ9etMjG27Vj5+7h0Q+JYAjyK9eHl1c7piHj8ez6u/BzfCiLsHX0RgPZbwpZJPdsXY
X-OriginatorOrg: amdcloud.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 06:13:44.2081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7904159-b94e-4097-79cf-08df1eb9fb39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7149

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


