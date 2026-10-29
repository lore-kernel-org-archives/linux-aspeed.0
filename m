Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2301606A31A
	for <linux-aspeed@archiver.kernel.org>; Thu, 29 Oct 2026 13:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=sWY/2Xfl
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFllP3xjnz30T8;
	Fri, 30 Oct 2026 00:42:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c100::f" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793281329;
	cv=pass; b=ZtmIeBF7FhUjDSP1D1CyTQEKwW7ficYSA+uhDqzyJO5VPofQh4yAkeTnUdUWqIORbd+t9VaPPuj17pWCKXoe1SPZ+EHyGY5neRvwJ+voCrMDOlKAb6mSPRQH83bONN5HevEFWPWM+xB/xwtVXwkOIt+6wkp9r2pp0SrIXVuta8yGyzigCNbgBX0K4OXmMZSVPqlY+BEWizrdUo0my5MVU255uU+lcjv6t4WPDOwXj3F/VEk7GPrryYuRbFlU7ZdJfOWUYo1pqAjfP5dSX9T0kef4Duv5QORxUfaurOVHeFARVynIgndRkflKb2GP524VzlPY2u2wCWCBSqs7ldJLlQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793281329; c=relaxed/relaxed;
	bh=UC1UrUC5+1MFX+bsxPknCKB9Evo5iMJG+r1LPOuLMSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=JH3ZDwMAXKG7wy7aV+IgNGrV7tjXOTxK417jyvsChX+wkSTXgmcmkWXcijiBnLo6ayooOOz8RETwf66WUPXzfo1bZXoYgWwAZFF9x3aKNj9Jng2jSNjXd7J9zGAzNKgDas8jS1QhYZ6icM0QAkUGuLrMRtWo2FEUM9KfpdI1U/CM7YXvQJmkR0qa8gR/dN0CepawqvW+2o2XnplW0C5oAbg2xemtFnWL9Lk6mTP3J0gnGn6IXo0nDRd+M5tMuCIw7lvII/IuGUW78VpFKwcAXd4gV2Md6DlxuWJhUSVFxscAMICOeLmY3JKVmcsXmaveP0TPb3t5ePJlTNCt+Ee5hQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=sWY/2Xfl; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c100::f; helo=bl2pr02cu003.outbound.protection.outlook.com; envelope-from=bounces+srs=x2+gl=it@amdcloud.onmicrosoft.com; receiver=lists.ozlabs.org) smtp.mailfrom=amdcloud.onmicrosoft.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=sWY/2Xfl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amdcloud.onmicrosoft.com (client-ip=2a01:111:f403:c100::f; helo=bl2pr02cu003.outbound.protection.outlook.com; envelope-from=bounces+srs=x2+gl=it@amdcloud.onmicrosoft.com; receiver=lists.ozlabs.org)
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazlp17011000f.outbound.protection.outlook.com [IPv6:2a01:111:f403:c100::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFllN6T8gz30RN
	for <linux-aspeed@lists.ozlabs.org>; Fri, 30 Oct 2026 00:42:08 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2D9FPjKbzAqd6Me9viomhKa/JLxIkXJBSiSXSHX9bIujgJHzbvvs26hx7QcICTYfXv7L7JtCpmN/KtEY7ZGhKcbm3eIbdFbzv3VeU8/IrWG+pEodDoOOA0u2/qS1cVILA3R8E+lIqLJzAqAwvwqig4FaUCCVFDwWxIf8K6DcKrBJ4zUny5QcKeB+97bwImeMSYdZXDrKYuYvqE2liFBb4ksrOu4WOijm8qSWeVBBaBVd4AWBbJWUh/gX4WU79856xEVwBb8l7oIoXiy614phM7frLCnZrzKXkhPMCsu5T8ICsYyp38XKL2GQcBeBGhiHJ2SmkGMXAV1U/aKdSVQDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UC1UrUC5+1MFX+bsxPknCKB9Evo5iMJG+r1LPOuLMSU=;
 b=fZDNTF5RHfOYIr9n7id0mxdbLm6E8a/xfqs9fKp+Pp/7/Fml5a4vhFHLQ02ruUh05d8wb+4uNKJWFUqC0rStcp2KD7jyLcsy4X0vPAdJkG81kzNkphn7inGlAWlOFONqQZs8HjJzRXOuaDifmAiRVzyR69/qUm9qz9L6zixoa/EVG4tr0+Qifa+PUs4/xyMXP4Hv+o4jfLlJWGU5pMTgrhCDvRJJwnQjgiasmCtG8jpoIA5DSAI96hQsraJlgTeU9hn1UD89WqKb3OoSgodCvO2KdFohwzmYc8mmLpQ1sWonSp1S83XmYQ7j9gtVq6IXTOEDwZD8w2NXTi1xXgE0PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=aspeedtech.com smtp.mailfrom=gmail.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UC1UrUC5+1MFX+bsxPknCKB9Evo5iMJG+r1LPOuLMSU=;
 b=sWY/2XflHFAJGgiuIdaOhgcmqHr5ka2cAGvhEoou6eSPV2U4Id20q21AbnSDIOEEbyD0Hj+Dur6jLaqcglfmMJTMAUSGzVhbVP8qsXzpBlrjOsBadL0c7z6ixFQg9JMXKCQ0J7aYkG1+Kb+Bb8DT3dlEgyGFelTEhVBsBtyzkC2Yp4J0Jjg+REbYCDgGW7IxWtHvBO9+1mnj4NeB9GPY8ij9Wc4ybwj9jg1xQmnMBFMeSQnaV6/Bqggu2025VQYUqV4CfBROfeRy9r/C/ofJ1e8O7QcRZi0QnRzJS5dVywzY6IKbe1BCvCFhhUacUgnO8grKBms6ufrNOrK77LybUg==
Received: from DSZP220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::9) by
 DM3PR12MB9327.namprd12.prod.outlook.com (2603:10b6:0:42::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.9; Thu, 29 Oct 2026 13:41:50 +0000
Received: from DS2PEPF00006E25.namprd05.prod.outlook.com
 (2603:10b6:5:280:cafe::1b) by DSZP220CA0008.outlook.office365.com
 (2603:10b6:5:280::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.9 via Frontend Transport; Thu, 29
 Oct 2026 13:41:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 165.204.84.17) smtp.mailfrom=gmail.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 165.204.84.17 as permitted sender)
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00006E25.mail.protection.outlook.com (10.167.23.218) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Thu, 29 Oct 2026 13:41:50 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 08:41:50 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 29 Oct
 2026 08:41:49 -0500
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 29 Oct 2026 08:41:47 -0500
From: Colin Huang <u8813345@gmail.com>
Date: Thu, 29 Oct 2026 21:38:39 +0800
Subject: [PATCH v10 10/16] ARM: dts: aspeed: anacapa: Simplify leakage GPIO
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261029-anacapa-devlop-phase-devicetree-v10-10-26ee3cf9d9d0@gmail.com>
References: <20261029-anacapa-devlop-phase-devicetree-v10-0-26ee3cf9d9d0@gmail.com>
In-Reply-To: <20261029-anacapa-devlop-phase-devicetree-v10-0-26ee3cf9d9d0@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<colin.huang2@amd.com>, Colin Huang <u8813345@gmail.com>, Rex Fu
	<rex.fu.amd@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793281119; l=2443;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=4zjP23mepqtMKnSPss2kOpsZaw5ldaNVS3sb8oAIS2E=;
 b=aC6It2SvQiGlKBMy/Bq4bGfjWVOxCATojWhPPvTxkm1j+9vcOnMA1AZq2YppMqcA+65UF6Qmc
 jNwzK7lZqPbDq1qAQdl8hb/kGP2D8/sfvPYgUJxHvH2GHObRXeY2ELV
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00006E25:EE_|DM3PR12MB9327:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b10b8ca-9a92-424e-5d9b-08df35c262bc
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|48200799018|61400799027|35950700016|82310400026|7093399015|11063799006|56012099006|261009223027099003|261026140227099003|261028144727099003|261022105027099003|261021121427099003|261021123027099003|261021135927099003|10067099003|16102099003|22082099003|18002099003|4128699003;
X-Microsoft-Antispam-Message-Info:
	3H6awgfKGT8mEYQIgWOKHOBFt1IF5io9XqOIJ4KoCK3XJkTyCTdsl1SSyhi8E6QDJJjz+l3kW8t2tCw20BKfit9uhHQknKwyUODiYxYGzKXIy7cOUEXGTDUbIOlerN2U6zXWTnzhK988SH/KGR6BJFBWMIO6jnTxllHT+UspkRJzen4CS28gg6JIszWju6gDwuHSEK9wem9eEoxP9wrsMmiwj7RxEzyAxDPRRrg11bIwVP0MnfRO6maPWOuVlJeCZ8+ElUguUT+0nkjeFWQazxTgGXskY0Wppa9abP7pg+5eVUAdAEiw+zxAGvG+uUU6Xwl9EMxJ8AC4xSdQAOn2BzDSLC2OUPsz43UD5v13cCO0o/O+x0tyxZDEW3R0jfoWjYfj2Fdjq5/BSZ5YGYWUi2fGHpYuC4ilht6gTT48n4KX3KlMJ9QG1DA0LPjePnVvsWU8EtsOLwOLTH9lzM702lqIWFNtOxNcx7OiWM/1bcOKtYmHT3xST5kmgPMBSCqREnmMOeFuHnXgTYqeB+stMDr9dgJWdg0Nn0l3gX+uLTwPJlpsNingYMFMgb1Dtr5O9WiN1LsDDNB3SUc917BKpl6lf+IRfC39zdO791tvZUgsF6sMpm2pWbtZ60fv+X93iadiZWEP8z2U/xQ5Wl3L5lsDU6G4G/rzhYolacbsezc/MOcXg5dSCxjpJpwTN3nGTWOu9mNwTK04/5X+4KlDWg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(48200799018)(61400799027)(35950700016)(82310400026)(7093399015)(11063799006)(56012099006)(261009223027099003)(261026140227099003)(261028144727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261021135927099003)(10067099003)(16102099003)(22082099003)(18002099003)(4128699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pUucGqd3aPTai0bZz5o3jr0ACJPKe6agTXjzu5qfwsXrMSUYluSAfgpb3L+metyg2ZAIICmqe9Sh/v2nhLLb3ke5pxUFujzCgv1U9OsTvl/cV/8UR7QrLVBtGYjIK6LzJPrFao5IGvgMwqXi5nmqlmNvtwA4gF1Z84VBEJbUR6T/5jBn0fPh/6lkmmViNglvlH+3SY5JZOM+o8m2NT3OsTbSl1uf9qA34B1bWb8bM0/t2snpqBmk/iPqdZLfX83BYQGKIMbp2ec78n1QsXJyZkQCth+9BjfnncAJ/mM/kuH60Uo5evB57rPrHe/57eX59zUqxN+Uv5dTcbd3cVaqfMHkWFzL3Cyz6Pe3BdrJoyy4ofoEVXcXE/qx4ngX5dDG9xfZSM4sQBQnJQexRc5WSHY3uOAqZOwYS5cdeJqaMlXxFd9VPXxLijMuAuoiYu+u
X-OriginatorOrg: amdcloud.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 13:41:50.5557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b10b8ca-9a92-424e-5d9b-08df35c262bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00006E25.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9327
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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


