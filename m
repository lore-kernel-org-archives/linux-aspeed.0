Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93021606A31A
	for <linux-aspeed@archiver.kernel.org>; Thu, 29 Oct 2026 22:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=skCID6vD
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFzWJ6zBbz2yrC;
	Fri, 30 Oct 2026 09:32:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c110::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793281315;
	cv=pass; b=SZC/F1QkteFVStEPtCjlg8J1Z73B8q+G2PMsO668dt+zZ3wkbg5YhmPs4lagEzbZ716tiLay9Oyis4jokY5nXmqWC9E9poRoioxUumR/G0dFN6nKQnpGAVj9P2HrQu0oH2fB9cYStpBAMdl7W+FHht4oNUoLyjOTGRyE5R2WsWJpPV2C8TDMmpeE+JP3P85WDObvy6Ms9QtCM2TazPMbcfR/xHX0gIFaAqgvH27dlITmJ+xbMgQJ0k2YWuVXlII2oF7gRZ6GZu0tQ+EFbXTazEMeWHQERmu5MZo097+4qhArWrEP6JRHaelbJHHH/JmnW2x+z1M++oJbhqEgtsuiVw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793281315; c=relaxed/relaxed;
	bh=9RyDa0A6WzUoK+rmtbBYIhb4g+dMi6Svc2oTWEWtxj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jr2CNIj9XQCzc2U7CgUd3D3Q5UZOxxY9C88x6FEyKJe4i+tcmCsIWStfBNasbf3WiFgPGTzD5/vpZa4hYYRQPJ6Lnj47iaLfFf6xphDpWSGc8dv58P2vXD4NI2UbCjA7HzCmzi6U0owduPRnBzZz2/wqAGT/0ZHlAmjn0srhjXh/Xzrsn1ZPmjQW0NbJAZP3xQoA1FD2DYVpwAd3swfu9hrBiJLEMJ1BiReUrDMGxx5U3U1FKRyOOJqP7PaKjj3v4Vm0bj9GOKUbMEaMdAde3ozfE2OQqow5rK1qykS92gYpG9DFqpfm3HEx0WjaKn8Rw7DqWDlF7+Vih081dyTaqA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=skCID6vD; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c110::1; helo=bn1pr04cu002.outbound.protection.outlook.com; envelope-from=bounces+srs=x2+gl=it@amdcloud.onmicrosoft.com; receiver=lists.ozlabs.org) smtp.mailfrom=amdcloud.onmicrosoft.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=skCID6vD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amdcloud.onmicrosoft.com (client-ip=2a01:111:f403:c110::1; helo=bn1pr04cu002.outbound.protection.outlook.com; envelope-from=bounces+srs=x2+gl=it@amdcloud.onmicrosoft.com; receiver=lists.ozlabs.org)
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c110::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFll608byz30Ng
	for <linux-aspeed@lists.ozlabs.org>; Fri, 30 Oct 2026 00:41:54 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TeOK+6M7dyMjPh7Gv+NmVTVSAwScQlCruq/ZB3+M9i3tvhoF5j9v2+37qZ08yyjsO/evwD5+dSVcZBBVc4ANw1fjPabVX0mTHPW7NkIJgy6YQLLa7VU48hfo+VcNLuwMG/K2qgfdAFuzQmbneK4AYJJc2K3bRZlGtIZeB70N4oFTTAFOoVfVTEwAhFUVLDOrlTN97XRBMz6gdPfJ3hvNrNao/9s5puOxG+5j2rDEIDQUMJGGquVpXvhjaxo6duIisbLWbYYHvEmMA0tTghvlGJrB/ISc46kr+Op5VuZWl56gBBmW+LcxDk5BCjs3zfT+g066F54HgCcz0z15EydyPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RyDa0A6WzUoK+rmtbBYIhb4g+dMi6Svc2oTWEWtxj0=;
 b=dxNo6uFEBs6u1HrkccdvAgD4DOGZpfyxpG8J3LlOE5y/DdxXUbLtxMoUzStLwsRSHshbVtzhuYdfEukHrJ5KR0m/WezMVlRxMonr7avw3BtCfLwgWyABvFOaUtpjGaKMmu6GfxdIyV0JBrS5Qi5rSFk8U+CgRSGIMXLDHeZrUOOznusiXJtygD8i9Pue6+O6/KYFn/vEV11GJ4ZAcpyPoTZbZzk1YXNezE7zHqq6LygBxTWL+hvnVf+h/XqMwSyOJvOI8IAr7Q3Y0GsttUj5mS+OI4/fouv5qyf47zzLH+GmkDqiKUoFr7BagKNVplbOwldHdXj+RhpHEo2H3GOVyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=aspeedtech.com smtp.mailfrom=gmail.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RyDa0A6WzUoK+rmtbBYIhb4g+dMi6Svc2oTWEWtxj0=;
 b=skCID6vDKv8SMbqo3u9SBAMl5+t34jxCaJ/qsyEAjmaDgsufiLSMzRGFBss6VFd7KX3t5XCciL2xusa7xG52YCf3nUouJL5ibxryp0XlgjqIUnvEgwnqj2FZ+Ty4e/ZbVpllxb+iHcb1elyg8yVKNfL8TMLCkPMTaTPB5qZE0HCeycPgJdnAAjqVqGoTLmVLGvn3EhROlHILJglrAxG+hQuQKe5C4Nz2pwA3WRkX8LeDn09ZZL4AuOfead0LRoNHkK8ByOcXETyh89boI/CtujU3oL77GV1ZnfSTvUFnS4iNJB4FBk4FxFvPvRcw/GBs4OOMCXuwRPsumAGXxxkwzg==
Received: from CH0PR04CA0022.namprd04.prod.outlook.com (2603:10b6:610:76::27)
 by MN2PR12MB4341.namprd12.prod.outlook.com (2603:10b6:208:262::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 13:41:29 +0000
Received: from DS2PEPF00006E26.namprd05.prod.outlook.com
 (2603:10b6:610:76:cafe::5f) by CH0PR04CA0022.outlook.office365.com
 (2603:10b6:610:76::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.7 via Frontend Transport; Thu, 29
 Oct 2026 13:41:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 165.204.84.17) smtp.mailfrom=gmail.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 165.204.84.17 as permitted sender)
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00006E26.mail.protection.outlook.com (10.167.23.219) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 13:41:28 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 08:41:27 -0500
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 29 Oct 2026 08:41:25 -0500
From: Colin Huang <u8813345@gmail.com>
Date: Thu, 29 Oct 2026 21:38:32 +0800
Subject: [PATCH v10 03/16] ARM: dts: aspeed: anacapa: Add DVT devicetree
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261029-anacapa-devlop-phase-devicetree-v10-3-26ee3cf9d9d0@gmail.com>
References: <20261029-anacapa-devlop-phase-devicetree-v10-0-26ee3cf9d9d0@gmail.com>
In-Reply-To: <20261029-anacapa-devlop-phase-devicetree-v10-0-26ee3cf9d9d0@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<colin.huang2@amd.com>, Colin Huang <u8813345@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793281119; l=5821;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=AQ5iLkgP6NLAtcRqZ6tcsMzjF1xEYDqVB0kQ/nuplqc=;
 b=2ZZb5/Hxjkc0tlcgMqU0sf5A0vG2PA7ulmvGPPEztdPRlIP4TH7KJu4eodNjUzLaptYocC0hI
 2rlGW4jpRa6D0uWXAEolCWhooJaMVj5/vJ78cU2xyEBTuX5K/XkGN3x
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00006E26:EE_|MN2PR12MB4341:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d857f60-fd76-4010-7ec5-08df35c25577
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|48200799018|376014|7416014|61400799027|35950700016|82310400026|7093399015|11063799006|56012099006|261009223027099003|261026140227099003|261028144727099003|261022105027099003|261021121427099003|261021123027099003|261021135927099003|10067099003|22082099003|16102099003|18002099003|4128699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	l+o9Gdmr5UEC4l3+7n1j1NL88qlUjiNpjci8avuY9qQk4x3VftpHtASJ64gDXlNNeXtqvVRpWQAhGQc0XQ5g4ZzAdYQXzx0kxruj15mMvy8DauCtcStdCQPSYnQx5/8BSjJi0kcGBfy1R+EgD+Xmr92HzMlifv+XgwdaRCoEJFupuH/CG+4GNE3m+6ic0pPjqXbXn/pzYove9jH9SaNnl1ao1unUDR8BZsAYAdOW5yMTU/tuyblojxBwhwSMpusBhOKfY7RZexoygYULerQnzlzxhtHR6AkWJvrM5j/I8UgqNVu02kjTVS7fmq/BfjD28zgIW9NtZ/1kYrT4IMJ4WqVPpU/4lQKVdm5FdxmNoviahm/awywiZs4GFdoekRRege7gwDZS0kQkzPJ2yub6FS1HdbuQORu53IX95BtaKDBRns2e7UAq1dmddYZZ1ef/kMSGMVyy7V/srGwh2kp06ggJm3sCDmaLTNcpgwXPY6rRyOE6tYpv74DYGMNe/Wnck8EknT4eb3oriucXhgT06Lde1Yq7Um0j5SYlwMq3clqd/JL3mG5fPYhe1MlurfC8u+H4FX9cgeZ1GHiWdGg94EpY5sCJpGSq68xNef4Q+iC0o4PdqwdnZjvb69x9LeBa3D81Qq9Emt8VvxfwFc+/Uh/GSWcAlcPdbymAqtazke2Zdjx+E/f5ezstfHqFP8TR
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(48200799018)(376014)(7416014)(61400799027)(35950700016)(82310400026)(7093399015)(11063799006)(56012099006)(261009223027099003)(261026140227099003)(261028144727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261021135927099003)(10067099003)(22082099003)(16102099003)(18002099003)(4128699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	E3wkH8uwEH7FceMTrF+kalNTCgN+tdIEO1NgvgHCW4Jvpy0jw03P/KC4tzTTlqIaFgVxiNN6Zd+ZIxU9sfjV08BUhjg4Hvn1YwmNe2GMbW2xzW3U7hOi/eVixzfjndqN0geE4I3l4cJwg+tEGmgaT0DkwTP7jN82f/RHN8MckSX+4/EGscCGY0GS4AP/K4Qw31ZquTUOUnFP3Mav0Hg6hdneJQBBFpTk5sWzuyM55U5ty9zkMzNwXncMyM3lUwFubjUxlDiBFwtKeBrYTTeXLpTCmha0rGuYwIrV3WEfe9EKVSUSe+WzVRBHUC4DKQTWd/jwF+DUoSsn7MZMXtqctrmzZCSgx8h8qPMfZQ3eVbbWMdwGl6msFvvqQld+6kxW/Ocb9JU7EuzNdGJryhKQ9M1ik8Galq4vdty1tUPyV6AaKLLEPdJstFBHqcJqjUWd
X-OriginatorOrg: amdcloud.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 13:41:28.2906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d857f60-fd76-4010-7ec5-08df35c25577
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00006E26.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4341
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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


