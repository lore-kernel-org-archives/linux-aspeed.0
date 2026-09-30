Return-Path: <linux-aspeed+bounces-5077-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 112CACA5FAB
	for <linux-aspeed@archiver.kernel.org>; Wed, 30 Sep 2026 06:14:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvlBJ4Vm8z30C9;
	Wed, 30 Sep 2026 16:14:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c101::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790748872;
	cv=pass; b=T7eZUlcC4SmboOLw8umxp+bI7ZPUWUyGbbTOmwm9SX+Zekzth6dp2RbGlTJ4Xhyal+UiRW3rGyxF6k0EgZYfChNdcU8nU6pmmldqobwjAGyFs3xS6r4FGk7vSmi9vBTgZHVMV6Ud9TXwKY+uZiW0Y+WKyrxCgHv6DWfZknFsUPpHa02HYULt/mIiso3ItX5dxf6wSd+LTLNTevj7ZzaqS23hhA6OU5ckha/g/7EenN+PCyzQh8NeAbEIOivX8ZZsFoKXPm17zcrdTzHifUW/8SdCER7w/6C9+df91tvnjKGi8kje7M98ReZIWPLKY5U67HyzyRajbOSHF3wsV0eGDg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790748872; c=relaxed/relaxed;
	bh=EMgFVzONncenVzajSBplgoSS+5bazk53iesp/vegqe8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=MQaq/6/rjeI1r1q/VRV49Ds/11yOvhkZ1cVMyl6FxjIpWCQGojSFCwXelK1Uscu0pWeaEP4qU+TC2FyTfnIxrjWe4ykgDkEPdoBbLuQzqeJx/JjVQQpRP/c6tddNtCw9tilA0CxNcH/ENOFkHXGRRiM9gkV+G4U2T/UDIuzPlfLgd4bRUdnSe5aMsv0j27KiesIQp4UwOqQYt7Mc8RRmLa4jMdbUONeRtg657XfWV+8/tSVwaERxk/QhmX49+OIFAFn7mC8a0UEAOgv2GjoAKPRfcg4xwNPpUAfz4aQ0RSrW/CfKbDK0SpgpRo0EAhzokjttRuhRzio0rC1IdWxRog==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=ASExM7VN; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c101::7; helo=bl0pr03cu003.outbound.protection.outlook.com; envelope-from=bounces+srs=ha9og=hw@amdcloud.onmicrosoft.com; receiver=lists.ozlabs.org) smtp.mailfrom=amdcloud.onmicrosoft.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=ASExM7VN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amdcloud.onmicrosoft.com (client-ip=2a01:111:f403:c101::7; helo=bl0pr03cu003.outbound.protection.outlook.com; envelope-from=bounces+srs=ha9og=hw@amdcloud.onmicrosoft.com; receiver=lists.ozlabs.org)
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazlp170120007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c101::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvlBH6pMrz2yqT
	for <linux-aspeed@lists.ozlabs.org>; Wed, 30 Sep 2026 16:14:31 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HPTsdtSb5QWvUXdIXW4pZ/JgHy7CH7VJ6yeVqBAESqgsOTF++qP9MB8r8dw1Sm6Bx+VIrWy+FkeirLSxFQdD55GM5Hx/oZFv7mlqokVxgmZMMwDjKMN7Wy67OglmwSMX5N+x5xOUCsl8M9/4opG4oH39zt3lXE0jDPfDootsZkSch0QIGIf1GscgR43g6bbyVlTOzQKKAyZgQ9VQebGnDu4z8F0OsuaOsxN/6r0jyjmJsgGYVzyJNijlpliLQS2rov8kbtgxNy2X0nZXU0QW+Y5bupcR4qnCxm6xiMVcB2gszcT+75h7PYaRAYm/IDDyZNVLyZ69o2nqE0iwChmW7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMgFVzONncenVzajSBplgoSS+5bazk53iesp/vegqe8=;
 b=rIf283EvfXVONJF3xkJTH9wHq3yW0cbj3sjwXFI3SSCgO0/P/N4WKtghh/LPalZFpn5dYywg1xaFNTGmn2RJhd1wklNMJ73im3fiLPGLB6e5ufR9MeefkikQg9cRppPDNT9JfXdDfOHrm/mpsaXW5471S3PvdDWSl9LwYLn5fUHfjoUdyvSV9AK0wybWXMMzBN//zeM3lr0k+yQJpeN7NMeRJaVkkxfDhU/3i5eTg3x0f1thlJn8h5qPJuemqzvTvSsOW7WfyAKpb0GuL3LYIJZu3SAvnQomFBwGyMMPK6OpaNuC3uv0e/y5nrpj4OKQxlvpYOBr3tj0RJdGgX9JOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=gmail.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMgFVzONncenVzajSBplgoSS+5bazk53iesp/vegqe8=;
 b=ASExM7VNT2FPi6fxhVAEcfC909O74ssxsnkZ17q4YlfRR8T4W/bFPNasAU9vJR1exbpa/fG1SaVg9eCQdLbwRwbcbTP8Gdgb385MdxQcYl4HtJM51Bv+OXBLmdZostNkzChYxHDyAR6Pwr4M4rr6ofuLollmFfv9qnCBhMzVbKNfprHKRujg97JmU6yxLzWelsFcXfjGIVHDSc2PwTVj00jzqz+NlhjTiZQbBEWEyMbeOvtI2ygcS9gY9uLEqkmvsP04r655yMPZH+XeLhDd7xjDpRf20+ocWVM4FNMBe3fJqaVPSrTZrdMMuKBXfsfKKpQBsaFoVkRpg6P/gI24Pg==
Received: from CH0PR04CA0041.namprd04.prod.outlook.com (2603:10b6:610:77::16)
 by DS7PR12MB9551.namprd12.prod.outlook.com (2603:10b6:8:24f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 06:14:07 +0000
Received: from BN2PEPF0000A7FF.namprd02.prod.outlook.com
 (2603:10b6:610:77:cafe::9e) by CH0PR04CA0041.outlook.office365.com
 (2603:10b6:610:77::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 06:14:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 165.204.84.17) smtp.mailfrom=gmail.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 165.204.84.17 as permitted sender)
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A7FF.mail.protection.outlook.com (10.167.245.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 06:14:06 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 01:14:05 -0500
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 30 Sep 2026 01:14:02 -0500
From: Colin Huang <u8813345@gmail.com>
Date: Wed, 30 Sep 2026 14:10:17 +0800
Subject: [PATCH v9 09/15] ARM: dts: aspeed: anacapa: Add LPDB fuse monitor
 GPIO expander
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
Message-ID: <20260930-anacapa-devlop-phase-devicetree-v9-9-f08aa0d7182d@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790748641; l=3698;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=8kEAvGR4wHD+buKRoFqsooBUH7WFB3+NHrtadmWVUT0=;
 b=2c3HR+pBxx+/kYY9AEv5W7vieikGLEJmTk/SKV8LmxjSAyomf4zuqveWQhLtqF6IvGZFgdAce
 7g408LhQ4SDB34VUseNQ6+Jve1ZH5TaTn802aoZOZ12W4zYZqJaR0R/
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A7FF:EE_|DS7PR12MB9551:EE_
X-MS-Office365-Filtering-Correlation-Id: b43921ac-4022-4dd8-c0c5-08df1eba0837
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7093399015|7416014|376014|61400799027|48200799018|82310400026|35950700016|10067099003|56012099006|11063799006|4128699003|22082099003|16102099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qWvyVCBi8nuIPeYZMFxOSZYFW0EJQTSd7lGShYI5ZLAidcMdqpanXrty5fWOf+KBK2WfIhHMTf7ACNPHZdkHNu55OgzTMvsWTSPyRr6JkAleiHbC0sroyHetkJ84Ab4I4ckIPWMFppxXqmepk43jJo1zvBswMJ8Ooj8jShgDpgqHBE827/WBPsM5sc/aQGeLOwoIBjlLXQxJU8S24kIydghirbctO8KB3VRkPH/Z+df1VZkUFDq2c2rJ8WZCM86CIoASp0nwYZp4AfRjT60Yy8zW7s5BOu0kELBtI36vAwkvtip5uNOQxsDC04MttJv1PVS6TMqdowVjZN6xHCenTtuXcrvkaylektvcfXUGFEh9q5SV12Tgg6nTfKT9L0SdKSpAvmrfgvleD6LonA5WbpVmcwafkO7qvr5F9SmY0URSRA2skSXTVp4Y9EOLYB6qI6npcpC9gpntihuC5TkH5NMu81L8BH1sKd/Y4dsQNBiX1Mrkwsd3RGO18IlTWd6E9T/9QNju4hLlwGEjyBfov6jh2nOTdejeDW8/9FV92Z9i+ufQ08NJtYCPHph00rj3ygsE1Nyy3X/m4lXX2hdOXb8c+8RPaikjkoOSaU/RGREioFnj5ek2TqEX0LEofY+4PysPyCqjYTGv6KksMCV7D7uu+NTEdd7WtwZf0+E5//+HIPBtpWM2IfYRvJx4Eh7NUEzQ2L/VBgf4ZK1fkc/hwQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7093399015)(7416014)(376014)(61400799027)(48200799018)(82310400026)(35950700016)(10067099003)(56012099006)(11063799006)(4128699003)(22082099003)(16102099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	P1Dnt3hNWewIwYyX5ALpoOXFaaFwnGBFj6BW6uxG3O8sTVrLenau1H+z/zPLUTW9IQzDAqxryWzHK8L0Dc7/5BWNSUnnEtHfMFhZRhdLsU4qxC6xXrLv1qiKhZ6ISrZSERL9SiMfGB+1KfhCeMHFnGhtXZYO9TNA4mKcL0uGd/NlQ8jHoWnooZY6hMPbVcXcb2wXw8q2w5cBPOndAnuO+ZZ5+GYvBCWITN9lDWrc4PX1mJ2Ll83qTBUuGPri/DBDHSFgxVhQSPLz3IJUx4sXx4ZOrY+nv+6/CU5f2kLt+sQa0t7+WzqSV6K+cjjWlcUfJ3g4WHF/Om/LDpbNpsWTY43Fd63825sjGjCMpuKFbv1QXpUGV11PGDWgnlMgGLuj0Cu2mAZtLhvtXL9BCR1M2sWLeIzAG6khN7cs86IIRKJj7zzZaeqCItlPgYWSo5ev
X-OriginatorOrg: amdcloud.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 06:14:06.0126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b43921ac-4022-4dd8-c0c5-08df1eba0837
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A7FF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9551

From: Rex Fu <rex.fu.amd@gmail.com>

Add PCA9554 GPIO expanders for PDB fuse monitor signals on the
Anacapa DVT board.

The patch adds GPIO expander definitions for both the left and
right PDBs under the i2c8 multiplexer and updates the associated
gpio-line-names to reflect the final signal assignments.

Signed-off-by: Rex Fu <rex.fu.amd@gmail.com>
---
 .../aspeed/aspeed-bmc-facebook-anacapa-dvt.dtsi    | 92 ++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dtsi b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dtsi
index 0509bc8bb9cd..2fd7e46daa63 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-dvt.dtsi
@@ -2,6 +2,98 @@
 
 #include "aspeed-bmc-facebook-anacapa-evt2.dtsi"
 
+// MB - PDB
+&i2c8 {
+	i2c-mux@72 {
+		i2c@0 {
+			gpio@22 {
+				gpio-line-names =
+					"RPDB_FAN_FULL_SPEED_R_N", "RPDB_I2C_TMP432_U8_ALERT_R_N",
+					"RPDB_I2C_TMP432_U29_ALERT_R_N", "RPDB_GLOBAL_WP",
+					"RPDB_FAN_CT_FAN_FAIL_R_N", "RPDB_VERID_A0",
+					"RPDB_VERID_A1", "RPDB_VERID_A2",
+					"RPDB_ALERT_P50V_HSC2_R_N", "RPDB_ALERT_P50V_HSC3_R_N",
+					"RPDB_ALERT_P50V_HSC4_R_N", "RPDB_ALERT_P50V_STBY_R_N",
+					"RPDB_P12V_MB_VRM_ALERT_R_N",
+					"RPDB_P12V_STBY_VRM_ALERT_R_N",
+					"RPDB_PGD_P3V3_STBY_PWRGD_R",
+					"RPDB_P12V_STBY_VRM_PWRGD_BUF_R";
+			};
+
+			gpio@24 {
+				gpio-line-names =
+					"RPDB_EAM2_PRSNT_MOS_N_R", "RPDB_EAM3_PRSNT_MOS_N_R",
+					"RPDB_PWRGD_P50V_HSC4_SYS_R",
+					"RPDB_PWRGD_P50V_STBY_SYS_BUF_R",
+					"RPDB_P50V_FAN5_R2_PG", "RPDB_P50V_FAN6_R2_PG",
+					"RPDB_P50V_FAN7_R2_PG", "RPDB_P50V_FAN8_R2_PG",
+					"RPDB_SKU_ID0", "RPDB_FAN5_PRSNT_N_R",
+					"", "RPDB_FAN6_PRSNT_N_R",
+					"RPDB_FAN7_PRSNT_N_R", "RPDB_FAN8_PRSNT_N_R",
+					"", "";
+			};
+
+			gpio@38 {
+				compatible = "nxp,pca9554";
+				reg = <0x38>;
+				#gpio-cells = <2>;
+				gpio-controller;
+
+				gpio-line-names =
+					"RPDB_P50V_FUSE2_TVS1", "RPDB_P50V_FUSE2_TVS2",
+					"RPDB_P50V_FUSE3_TVS1", "RPDB_P50V_FUSE3_TVS2",
+					"RPDB_P50V_FUSE4_TVS1", "",
+					"", "";
+
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
+			};
+		};
+
+		i2c@1 {
+			gpio@22 {
+				gpio-line-names =
+					"LPDB_FAN_FULL_SPEED_R_N", "LPDB_I2C_TEMP75_U8_ALERT_R_N",
+					"LPDB_I2C_TMP432_U29_ALERT_R_N", "LPDB_GLOBAL_WP",
+					"LPDB_FAN_CT_FAN_FAIL_R_N", "LPDB_VERID_A0",
+					"LPDB_VERID_A1", "LPDB_VERID_A2",
+					"LPDB_ALERT_P50V_HSC0_R_N", "LPDB_ALERT_P50V_HSC1_R_N",
+					"LPDB_ALERT_P50V_HSC5_R_N", "LPDB_I2C_P12V_SW_VRM_ALERT_R_N",
+					"LPDB_EAM0_PRSNT_MOS_N_R", "LPDB_EAM1_PRSNT_MOS_N_R",
+					"LPDB_PWRGD_P50V_HSC5_SYS_R", "BARKLIP_PRSNT_N_R3";
+			};
+
+			gpio@24 {
+				gpio-line-names =
+					"LPDB_P50V_FAN0_R2_PG", "LPDB_P50V_FAN1_R2_PG",
+					"LPDB_P50V_FAN2_R2_PG", "LPDB_P50V_FAN3_R2_PG",
+					"LPDB_P50V_FAN4_R2_PG", "LPDB_FAN0_PRSNT_N_R",
+					"LPDB_FAN1_PRSNT_N_R", "LPDB_FAN2_PRSNT_N_R",
+					"LPDB_FAN3_PRSNT_N_R", "LPDB_FAN4_PRSNT_N_R",
+					"LPDB_SKU_ID0", "",
+					"", "",
+					"", "LPDB_PG_P3V3_R";
+			};
+
+			gpio@38 {
+				compatible = "nxp,pca9554";
+				reg = <0x38>;
+				#gpio-cells = <2>;
+				gpio-controller;
+
+				gpio-line-names =
+					"LPDB_P50V_FUSE0_TVS1", "LPDB_P50V_FUSE0_TVS2",
+					"LPDB_P50V_FUSE1_TVS1", "LPDB_P50V_FUSE1_TVS2",
+					"LPDB_P50V_FUSE5_TVS1", "",
+					"", "";
+
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
+			};
+		};
+	};
+};
+
 &sgpiom0 {
 	gpio-line-names =
 	/*in - out */

-- 
2.34.1


