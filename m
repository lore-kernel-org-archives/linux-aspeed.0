Return-Path: <linux-aspeed+bounces-5093-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECAECA5FC4
	for <linux-aspeed@archiver.kernel.org>; Thu,  1 Oct 2026 01:02:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwDBx1hZhz308H;
	Thu, 01 Oct 2026 11:01:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c10d::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790748853;
	cv=pass; b=EzM37aJi8r8hFvZlEFs23uJmtnC3TUIBwRRL+UVKmkLSFdhSRL4TGoIS+GXCL5Cd2DSztX5FJ9zCrBoKknebWGZaS0f0GY7pDmvC4aa/3JJlpuxyzkUJYZX85M27faXwVbvPavA7zHvDQtRl144aP23olsjHpRbRnHOqCw0WYssyncPjiyuRAe3Tmc3/EzEP4LZrfMNMLiIavp8z/NzUjZ29P+GO4/sopH7mwzboi4kE+hFHrbCtpZSM1TUgtSY1W+FxL9EmfXTYUJaZFvvl/MLZ/jV1D9Fy57Thr2VSK/KZNI3DkZ2Gsym/76hMbhLPHlYBWpC0ywjb0W+RmtAVSg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790748853; c=relaxed/relaxed;
	bh=9RyDa0A6WzUoK+rmtbBYIhb4g+dMi6Svc2oTWEWtxj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BGR5MrgY8EXBK18XGoXDpN+P8dlZXTM+7ihM5nfz49QRBPw4UNIUSwh8S6+3fpvOLZGohOeV2yfzjsva3EGBP98UgwVGNAM+PHv0l2D4v9hjj77+/e5Ip4amOh8MxpACSJBpLR948V/p8fXSxKhLmOhE97emWmFwh2j8Om9z707/doDy5mxQwdkRAAfHgJXOQ47Wl8/HQffJd72zT1wSxjCrPxWEfGwnXpBpAe5x7947O4nQ+W7wpTz0xjyCjjc5MfqqNu0XqcYYroNjkbEvvNtNn0GQJqtBT3aU0L2SyacCwmPop6xchgzll2MA1aPNFwlpZx2fHf56aESobHJGVg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=DfswC/5M; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c10d::3; helo=sn4pr0501cu005.outbound.protection.outlook.com; envelope-from=bounces+srs=ha9og=hw@amdcloud.onmicrosoft.com; receiver=lists.ozlabs.org) smtp.mailfrom=amdcloud.onmicrosoft.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=DfswC/5M;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amdcloud.onmicrosoft.com (client-ip=2a01:111:f403:c10d::3; helo=sn4pr0501cu005.outbound.protection.outlook.com; envelope-from=bounces+srs=ha9og=hw@amdcloud.onmicrosoft.com; receiver=lists.ozlabs.org)
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10d::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvl9w34V2z2yps
	for <linux-aspeed@lists.ozlabs.org>; Wed, 30 Sep 2026 16:14:12 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJlSqBy6LYA9Ak+5vSDMQhO3H3Po9/ygvQtQwNdwvT5Rt+B3kewOj9nHvinaYuKtXDAWciomY5bgbrz+4X9mNJBuJiZj0VhZAiU7mmOjoXeqi+4iYIvxxCJulubFH+wf52QxBYojawrxupyjh3PHcy3qVgwaZC2JM+1/xyd9yQR5fDrHsxBWAkgaFEm5V5W2R2FKUv7QeLS4WyFXJr+m1NL2Dy+TVEXHj91hgWjmA4WdQDbtxphNxOOon+9g9Lk8psI/3Ng2Ys1nTG4Uoh4PKUclFXZTLVWsSrGaO9KnAZeGzWOBypPfZRImPyryN6HZ6hfG2uoo4KfoK/PU4MvAWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RyDa0A6WzUoK+rmtbBYIhb4g+dMi6Svc2oTWEWtxj0=;
 b=BtDKvBwmsZNBb7Y3M0Ur1CZb0aWaXcMisWjO4ZE/APzwWasQ33cRPhBm3FcMEga+zabAtCO/fypxqWYZkw7w9t4ikEbBojgsGJeKSj4qZHcZA0ZdRypUYw5rCymQB0dS788nWMxdFT15oPNrYJvGv7QS6dVbxc07xsuuYtdkGy1Fku/z/ZmJictwK8+rZAGJngk5IPQwNUoBfOv74we83ID08cOCiPKp277+qInElc1wBFZcI6QCrZIuSyWqv5kF8qxuKyrygqCVL0nTXMXF7gGlIImILtMVIH2zPS8RcMeC7NcjUQOUY6mGwjVBonOYZ0K2ks34HpXwPdPL5eanNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=gmail.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RyDa0A6WzUoK+rmtbBYIhb4g+dMi6Svc2oTWEWtxj0=;
 b=DfswC/5MK7Ep3cPR4lkwD9twWGeCgScyjpeTCoGgiXR05cRjlU9t/FzFTANtsC1uKvLxUYUekcu9f/15O+5WZnQ6OKPlmzLj+hfjUOdXgCZf5v58CZWlt2xG21+hW2USI+6am5KEYsCpONbHr00Bs1R+cFo53/mU9QTr+uwDqfCRBqCxUevcuG3JxCE7ntOdpmyjLFFzvNYZLISujznMZhFWCKODP9Kg8Dyoksy/5X0h9h21HrE+c6h1AmC5ubLYOpH1A0gjWURumcZGMBvt75yT5qO0c/nCcb7CNWE8hGXEfUvh3gx9E+iwXtXRDl+LPrB+LeYOk1mJ2RnOaMz2wQ==
Received: from CH5PR05CA0014.namprd05.prod.outlook.com (2603:10b6:610:1f0::24)
 by IA1PR12MB6603.namprd12.prod.outlook.com (2603:10b6:208:3a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 06:13:47 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::a0) by CH5PR05CA0014.outlook.office365.com
 (2603:10b6:610:1f0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 06:13:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 165.204.84.17) smtp.mailfrom=gmail.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 165.204.84.17 as permitted sender)
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 06:13:46 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 01:13:46 -0500
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 30 Sep 2026 01:13:43 -0500
From: Colin Huang <u8813345@gmail.com>
Date: Wed, 30 Sep 2026 14:10:11 +0800
Subject: [PATCH v9 03/15] ARM: dts: aspeed: anacapa: Add DVT devicetree
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
Message-ID: <20260930-anacapa-devlop-phase-devicetree-v9-3-f08aa0d7182d@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790748641; l=5821;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=AQ5iLkgP6NLAtcRqZ6tcsMzjF1xEYDqVB0kQ/nuplqc=;
 b=DrbEi4HVhuPyIirL32Trs975eR4BCo289ycgauPT4tFiE3H7yP8pnANP796fudDsbTGrZYvzP
 KOVBXbazVIdAsalnCeuF8n6l5XuSgqdwD/Jw5bHUj/RUSq1Hr52CKTI
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|IA1PR12MB6603:EE_
X-MS-Office365-Filtering-Correlation-Id: 8594033e-d0a6-4e57-a3f4-08df1eb9fcd8
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35950700016|61400799027|7416014|376014|7093399015|48200799018|82310400026|22082099003|18002099003|16102099003|4128699003|6133799003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	B7IVjAQ9kI+1OWp5bQKc5Zq3Z0SiPxtLjfwwUXc2v/I0EoUUmrakvgc9xb3ZhWps7u9c4GbbrmKqRvayIYmNWY4fXMpNn4XNNIBKgtKeHl9YRVxyTuzYvCFgWdDV1/e8JGM0OCv6bk4rrQimWhhLOrDK5oSvlOXxiGkEqDnnaZLQ/rMCV8Fy1ZwSeB4rVkUIzs/XpUwVhu6MXPKkIwDAk8KkGF6rEyg/7/2+jv1UhE+SEOcWnFc2uKh9PZ0yOCDvdVvyskDEn/scVZhJXHaK2AmJFu/Sx+1hiIkoEyq6fGfejtPggDuTdY5gRod6YmGuePWQ7yCHhnjP2l1ISDeWmpHvX4RwAdxgqZ+pPeRhGJGspxfTn5oGg3Ol3Cadxguclwts0e/6yZNltn2zap71XvQTGLvOy/LJiAkuERCIlopFcSQxnUVqv+z2yrXTgMOnFiq5FLcFokyuex5JB/aPYCa7Dgfdn4l8nJhrfoT8WPwQopWtmiFL2Hr0gM2iP6Cz+WGClRozJTQVfPSRX+RlN8rKTqakWbmFCB3dA75DHItAiop926GKUK+L2KSUXPwtlkncVRZayvGsKXLV59S3hh4QlFUagALsOaHVmSyhPy2iu0Waml6K8iV6uhXrK0T9D0zvE2epAoKCuX9rdoD0dYutVbvAa/w/F89LfysGr6p7DE2/9vSJzucGcHQz37nL
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35950700016)(61400799027)(7416014)(376014)(7093399015)(48200799018)(82310400026)(22082099003)(18002099003)(16102099003)(4128699003)(6133799003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iohZnSYd1Zsh9YNNpn2o/AXszg9d05Uy+jT2UMUNaFCbJJFUq6O3zwrXt/a74mO5A300mbwHSG6hJIDoLfeA2HgB5Ya7kfhUpgrZdeEJL5M+BvQU16L6rlN/dHBrEYv7tY9cpnCcvBXhPbe5viep98HsLnMn0OW10a7w4VKqLIrzcj/RchWZxxQPD/2+gZRq591qtsBy13iAWEuO6N6wg4H3pQj254eskjFD1fxvQK6FtuGzoIOud2/uLTh/ebk7TsfbxA0JXWqG1hMMuGI/DFHg9GRJa2krQHcqllhRCefP/muT3KDxVuXr1UkKulwkfiGkwkC7hL15SEZ70qlMUhUPKEAPmn+8bdELqFz5A37srgdn0XaLemHVuVAvNB8eV3wSZVWDKYDyD2K/K1V/HdqRCjC7w0FbriFt9P7vAuTwyRxUIgwyKQ1rjKz2178B
X-OriginatorOrg: amdcloud.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 06:13:46.9305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8594033e-d0a6-4e57-a3f4-08df1eb9fcd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6603

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


