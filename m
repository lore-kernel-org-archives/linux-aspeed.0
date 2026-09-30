Return-Path: <linux-aspeed+bounces-5079-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0601FCA5FAB
	for <linux-aspeed@archiver.kernel.org>; Wed, 30 Sep 2026 06:14:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvlBM4FZRz30DH;
	Wed, 30 Sep 2026 16:14:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c005::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790748875;
	cv=pass; b=QYdp2tlOvXht7GvP1DASPnj+FIl3xj2vl7gQse/XbmI2Ih3HOqpFbNolR2flCiuNptRQqbk/HliaUyGer/mcjrPabH3cI87y/Bdl78jwOfcpU1bHtoad+2E4pBNHE2/kmEF1ii7BtjdwfMif01w/NJjPsAJkqFz4hRQopboAWbjebH+E8mDbG5GtEdxNm17fBSAi560zrXgHIzZ0x1pdbaD7UqLC41LLAVuhDqrAUV5+luFKHo8WFqn7Hr5xeiDY0l/TNO8y6Mn2TXSpFqy9EecCiL1SjoIV5yCLpZxj2htsSRN8IBq8uPPEA6V+u0JDdXfqI5eqyU+A9u8y+0YnEw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790748875; c=relaxed/relaxed;
	bh=UC1UrUC5+1MFX+bsxPknCKB9Evo5iMJG+r1LPOuLMSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=MsaKyBB5fWsDwZrInTfPPENoyMP+/JRiJbZzOf+Uq4B3iFCaSQLKDVXBIIJpqSiygJ1cUz2C7p2Vnv0huhKJbGYOJUx0joPtwt28guWjZt12wbLQIx3ySHeXZvxBLn8NzPwgKG8jspxQV2u9haA6Ak310gSCHhtQiCpf/bnY1FsYIw4Q7KMkkLeso7VmIJ6cZxS5gSSx140LgfxwtmNCNgkpRczJqIkomvSASIk2Jo8vZ3dW8gtniVj3KUF7T99TbbNMaNfTHJEhxz55PhGoSXKvJgC5cEwYNq2J8cpWE6M2z3iACCNUQxhEU5usgscxvTGi37XUE+CCs2UbEtVyew==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=H997+ftk; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c005::5; helo=co1pr03cu002.outbound.protection.outlook.com; envelope-from=bounces+srs=ha9og=hw@amdcloud.onmicrosoft.com; receiver=lists.ozlabs.org) smtp.mailfrom=amdcloud.onmicrosoft.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=H997+ftk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amdcloud.onmicrosoft.com (client-ip=2a01:111:f403:c005::5; helo=co1pr03cu002.outbound.protection.outlook.com; envelope-from=bounces+srs=ha9og=hw@amdcloud.onmicrosoft.com; receiver=lists.ozlabs.org)
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azlp170100005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c005::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvlBL6gbZz2yqT
	for <linux-aspeed@lists.ozlabs.org>; Wed, 30 Sep 2026 16:14:34 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UAoc7C/sX6z1lLyE/Ysrxa1HvwNzfFHI/9BzZQ0mlLlV7JbRVVOKoDiRqRbBzAFYItTc1kTQ68fHD6xSpNeiyaWbQqd778kAM7HicYE3oQm9PXbONeIRy4z1ODsreWTBUhdSIqzTZvb/SYseV3DU9kcpjf7vCnIUmFNPfQ26jWxaXQWsrXdDOdB9XMik0tNHuhDdAI+EjqMWEwRmBJa0GklaZeip+XL+zU2epD4+mEd67+AbUJjLgtTLhyDZA1GssjOZtwy2hmyRzPwj28YNR11CugI0WKt3PmbX0LPG6i1ztpu6n2giNRCN8+5YykqyNh0gdoog+85gcpTwDmxvnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UC1UrUC5+1MFX+bsxPknCKB9Evo5iMJG+r1LPOuLMSU=;
 b=viGNb4xqBsE1AOFaqDbmcHGszaCnhhZk7LVV5lO+XhUDIvcNQ9A+wbRWruQf74YPmfRFitPLczXsqJak8GAP2AGpkrAPsKqx3WEcr8VUr4YhnZ1HLcwdgQssAa7YfPhlL6wTtAIp1J0L0miK16HtvVvmpk3Om20IMjEkrk1pZ+cJ60ctZ+niKzsTPSGcm3eXNNCPGKtYeNU71WpdxMWmOoPrNgftCPxj/GIrXlpWOGNTFbGK9UzR9bo4t4TCWGWGdFlBKsfDEJavHlIqNb9idxZbWAJGf2UmzdO12LG61WzYFK1UfV9YVQRrEHA/FBYDsNR8GR37bhSRiRNJA5jEqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=gmail.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UC1UrUC5+1MFX+bsxPknCKB9Evo5iMJG+r1LPOuLMSU=;
 b=H997+ftkuZLp5Q8ArmfNmKVsJtlxSCnZFOyFCjjAtxEmiIreBinPLunWSTvAIyebB7frYW5OuYW7VuzArRPJkojvJQ79QjJnwn+tbxiYCHPfSWnAqvo6a25zh5Cmx4QJDWv//p0ftxlGdwGDr1AKo8c6VdZithEaE1+gQ906TaglbTxpPR0DpGji3sYlge33lFDvTiFcWmqnDw0HlhBzjh4NW9liImJk6e/cqQ0K+KZ/78uzrLwypZ7rb14qLKDIxsfyhGHCCpcP+zwCcbtyg4A3jfFfcH2DCi1WEh1N+FDnXMXz4bpcyf2TU+KEsH0qProEGISz7Otd1AxsyswN2w==
Received: from CH5PR05CA0018.namprd05.prod.outlook.com (2603:10b6:610:1f0::28)
 by SA3PR12MB9158.namprd12.prod.outlook.com (2603:10b6:806:380::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 06:14:09 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::82) by CH5PR05CA0018.outlook.office365.com
 (2603:10b6:610:1f0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 06:14:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 165.204.84.17) smtp.mailfrom=gmail.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 165.204.84.17 as permitted sender)
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 06:14:09 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 01:14:08 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 01:14:08 -0500
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 30 Sep 2026 01:14:05 -0500
From: Colin Huang <u8813345@gmail.com>
Date: Wed, 30 Sep 2026 14:10:18 +0800
Subject: [PATCH v9 10/15] ARM: dts: aspeed: anacapa: Simplify leakage GPIO
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
Message-ID: <20260930-anacapa-devlop-phase-devicetree-v9-10-f08aa0d7182d@gmail.com>
References: <20260930-anacapa-devlop-phase-devicetree-v9-0-f08aa0d7182d@gmail.com>
In-Reply-To: <20260930-anacapa-devlop-phase-devicetree-v9-0-f08aa0d7182d@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<colin.huang2@amd.com>, Colin Huang <u8813345@gmail.com>, Rex Fu
	<rex.fu.amd@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790748641; l=2443;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=4zjP23mepqtMKnSPss2kOpsZaw5ldaNVS3sb8oAIS2E=;
 b=LvjA9+AOsFLr/TkFhgir73ax2bY7L5/ATK8FEEBnKg1lu8XoSBRy4wjz7+zZIHsNXgDDiIJ49
 /QwaeE8CnlfDvcbmYX3/GZ0xs00FbMKKfiNeRy9J+Hu08oimYrDU1r6
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|SA3PR12MB9158:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ab93c99-b01c-41fd-a2c6-08df1eba0a5f
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|48200799018|376014|35950700016|82310400026|61400799027|7093399015|7416014|4128699003|22082099003|16102099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	QhKeojsVn9/P3v6fA5ptI06s05LFUOl0xl8scQnaxPtTotOebuL02lPjLl2fftGv+UIHDbw1HMkn+gwTJjiQI5hk9ttvYs8JnQ1XD6LI4KumeMBtGZeFMlF2/nPRCOND4DlHd1/8q2o5VnvkxVk1wGfLAU2kABteEZgKjlOhmJkjAZRInQ5urcchvEqUMmVG3BG+zK4hLEypj9X5lwd6S42dxKT5pcMU/5UyeHYKDjcTMrrg3/rD1XQ/8Xd7e8EH64CUHhGzGkIlyd7z7fP1cXicneR0Pl4QsgVu8HwnZ3ehIbyqmUzV5fEOEl53hcaPoruzMvBfbvpg/v4eMee5iNP1Qa2JGxibJA1h9ZOqpU/kfVCEtWNWiGLpRuUdbF+auLkRg7yGA6AAil233Jg7B0FFiaEScI2laXmy7qzVS9MUzaQeyS1Z3iDqavd76uQu4p1w/QPJpRn8ekc9StuJaXiNdORgOXd25bW1i+uNC1P/yZc1nnv+w6y7DLBD4k2UeNcHA1l6Iu1h0No2whCqIzpIgXybdXaCCPyWLoFI3DnDhpLWGUT/fwRrzyUpTRoGp4K+A0qq9RUT35ex+pVc5JRTk1cgmSgnj9Wx2OROUFNJhyrKvFk4scBD3pD2aBxRWrkYeIZTuy25e7D+Nn8IGCyd1dydntnEEoASXYxwQb8tS+wGVCqc4pYNBmlSpF1rl1+DhiBrjjSk7YXqRpmNLw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(48200799018)(376014)(35950700016)(82310400026)(61400799027)(7093399015)(7416014)(4128699003)(22082099003)(16102099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	J0BqzyNe3vMqs2r7mNFVpMty1QkgEgt9AL32JOkwTpcAzchpd9i6rTPfM6t9uOVM9swgLSfKyl6p9qFPAShQejJ+e++EFf4elO1E4gFUXjD9fW6+xvtiPDtfN+40AKvF5252p/h9yeXPyyL2J7OGjOSEf5PebZoSs8JSum5XGDjhwAS1DfGhj3epbSZ2h19elHWVHyAPVvT5Qq7pEM/WY9H3j2A+/iH76Hd9FlH1VEvx0Xmh8O0ds2ERyg6XC2Rd1U/A9npQ+ty95SYd2zugNIpXau7B4nwTMv9e+31MqPQo6D20ZmCWfq7plq24Kq/pI/zoQ0KvkYbQYC99Z4X4EPa8UnyMbzhMNnUqcKZkG4ypng2ZeEuP9rKPcAqEi7JX3a9Q46dqPR8Z1OPXml8YgXMOGhWcZd2HMlOLFTYBf3jXO9gDlngWaG4zipBpq4oT
X-OriginatorOrg: amdcloud.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 06:14:09.6261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab93c99-b01c-41fd-a2c6-08df1eba0a5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9158

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


