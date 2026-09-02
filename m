Return-Path: <linux-aspeed+bounces-4955-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB09C61DD6
	for <linux-aspeed@archiver.kernel.org>; Thu,  3 Sep 2026 00:39:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hb11p6r95z2yqP;
	Thu, 03 Sep 2026 10:39:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c007::2" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788344569;
	cv=pass; b=KPXGrVCsm2ErlctfbE89vPtXxkXwDmYyfjeDcOXqmP9j80JsoFKtU9YU57l03Soxulo1MnlzehwrvGPzwqiUaHr2bkuX++tWSfm0Ai67w8MDvyXuKORcYckjHL4Ni9K3ccueO+91RtKsPbUwONsaydrozX1AOpJB5F2vhmOhLaS8BUXCZHHYOidsrSmVFlipczD6UCfze4iLxdcxR3JIchKBEwO+XzSNcZEDZH3fbAmhuzKgTn9atNXeUNJo4Q3gl758q0trd7cI5KPfFyaLHla/siPTTq+UmqXaVWX/3PivR/cupUj2fwFy16ZvuSsif1ww19X/wu2b+2hLo7kcXA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788344569; c=relaxed/relaxed;
	bh=4/s6FlFwAKjgFLjZDZcFhJiBB4O4U8XepmrU/CXy4uk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=GZMl0zesW5luL2pEwkck9f+fa/fLWreuMSYrafWYJD9WPWM0BtFFOTl2Lj7npl2FOEhHXxaQxX3577Gh9BCxAi48nrmMOSsJrKSMwUMWKLVzlslDrhoa8el+Kr9iqDIXolnaBae8Jg/18f8EWVX3Z9X500rtDeo9XZ6rKRk6681z4yGNgOyBnQr8Q2QD1dASzMuCJV7iq5J5iaucwm9rDoqL2k0rl4vEnUtU5/0zVvm37fsANJe8bALn8KEAVIuID7kAP7l8NtefttULqP6H9a+oA6gY2k5aZhQPolJjnjX0wr/Y7C/MKFRmcC84MgmlrSVGZx/nOSffHy5YuMNnOQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=M4PEEerx; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c007::2; helo=mw6pr02cu001.outbound.protection.outlook.com; envelope-from=colin.huang2@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=M4PEEerx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c007::2; helo=mw6pr02cu001.outbound.protection.outlook.com; envelope-from=colin.huang2@amd.com; receiver=lists.ozlabs.org)
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azlp170120002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c007::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZf1h3g1nz2xBK
	for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 20:22:48 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gq80M/wzXUrXS6mJiA4ijHjKHDfpIrWIHeVisrflyFbcdb3vZgEM5JsGDtRdhf0rTyJYPO1SSRqWIeopgOSux2UcXDaYl4z3fSNk2mH53X/UcVwrD2wJcNss9U8eEM7re8aBvGo+OkaAZ/sFhmAAzBgFNFyTVGFX3XuRAkBPCWiQmMoehLd4xKAnnSNKtSvxez9tGkhiNxtYV7V4RCI+Br4jz9zW/OCDhlYcO3F+ujA+Ag9i4toyA4yeScMD0SXqred6dYyGeQQoZEjIqfQTHgub6eL7mAZiDn79iYSBwqzU68AIbYc5HyHwsTpNWoi4EuCfT5gtfgkRUQl0iZZ8QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/s6FlFwAKjgFLjZDZcFhJiBB4O4U8XepmrU/CXy4uk=;
 b=rcv/SuqRzUKuaLNE0772mVJbsFuTKnU+KM86gp9IHMBvytEbyv7WUUmDAfSqZg9yvBWnxFTISXGyKoXkkJPxrOaBfNcj2N4e3MZUuAkceHcstv+LS7rEKz3m9tBTD5ilwpy8rO7YmQ0RrqlSHXQR8bEsEz7Q8n5KARqfoRFIFHQmCG4GdVXbF5uoOUncJDTgkzSzpm1Jumk/8LBQDFHfvdMdlRJB1fopTjnb1tGOEztvrQCiqBp36pTSk+3HobQUAIgqHWsUkYTmKZthCbIfY4vPdoFhtk9H2hGqHYCCXmeB6hrT5N0CedgW4KvqaAWCBY1Tw9+Iy5DDUITVoQxNTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=aspeedtech.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/s6FlFwAKjgFLjZDZcFhJiBB4O4U8XepmrU/CXy4uk=;
 b=M4PEEerxm2s0WhAFnyU51aIqnJcCwmRBueiUrty6zFgrlf3SxIq4xIZpU9Y2JqR25I8I5tKwSeGvFqFkUvyu8nbGql78G5AqkYVvXBIrAjbrZFt1zmO1XUj9IThOBt521RUBs/gzuBQktof2Mqq9ggfP9uOiTS8/k/E1r3t9F9I=
Received: from SJ0PR13CA0176.namprd13.prod.outlook.com (2603:10b6:a03:2c7::31)
 by SJ0PR12MB6806.namprd12.prod.outlook.com (2603:10b6:a03:478::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 10:22:24 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::1a) by SJ0PR13CA0176.outlook.office365.com
 (2603:10b6:a03:2c7::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 10:22:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 10:22:24 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 05:22:20 -0500
Received: from [127.0.1.1] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 05:22:17 -0500
From: Colin Huang <colin.huang2@amd.com>
Date: Wed, 2 Sep 2026 18:21:18 +0800
Subject: [PATCH v8 06/11] ARM: dts: aspeed: anacapa: Align PDB fan GPIO
 numbering
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
Message-ID: <20260902-anacapa-devlop-phase-devicetree-v8-6-69c8eb2a7cda@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788344509; l=1800;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=BVJMmVa6hiP62Rq3KeFZsYo9O8NS8epFWSmQDw7StNA=;
 b=19KYW+tb7Jq/1yW828rKliESHo1QaZ/D5vkF4+OrPLVxZWwhMZLY7rYQKlMKUYwvyDbyGFAXY
 UsceVNxW7rYCeh3Ym2m/IW9g3z106ACKxFRKzkos8+4P8cSmIXz5K09
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|SJ0PR12MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: ad17f012-4c90-4e3a-355f-08df08dc14eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|23010399003|376014|36860700016|1800799024|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	opAVIFQhL0D+YBhQ5cj5rEC83+wtYNM0rTNDl9XeWM8Dv6aTrXyVkpyxc64ZFlhY5kU/kPXIl55a1yq9xJvulbHwWN/kZ1jIiEYS91mLbrjn8cXXUZzMs06OdXDVDv2XZnffPLhDja1VUAuBZUzAxef5d3Uqrj4ty2R6cXBu2ocPFQ1aqP3smmYC9s8/832IYedJ5IU+6GYzDolDxmtJWNL1nUXNQ8eYH4axrbgVpf0aXyHgtQCuwleUXLxl0a+hBfGDBzZs1dtpEQcGLc8DgmQbjHoJR9WcaEhD0YIl/LTf1AAwfvC49r263uyScu4wYjWryOcsFFkzcmS8HM5gxZmGnBKyDLfaWwoZTWLCJl+tp1dCtT/Yg4DTZAvQiG6b/leXtigHiGEsxLK7j7lI/X8HOq/ALpIpO7FNPD+FdoOfHj/2woQApJgY6ztAhxPgFkDkxv4YMEwD0YoLKqvwbemyr1ArTTgK1XyYg/BVBUy22oJbPiFgxj5XadjxlEvQVLbbzB3Tml86IEQDcmUZ92iS8VbjXSOoaZ0ajnm+6Qw2SY30VRZLGn7UhQLJ9F2l3mr6ZGdyLMsLaCJ2jP4YkcRf0WeUIOEqtkk5yR4/CMwAi/fx1NBhfIX9lu45r4ULeSa6d2QOtyeXD07vawPIH5zW4FdZ0Ffg8DaCKb9Hp0GEtHnQBGImOcvYBLs//uPYCNbPvMOIeyJn/vPn52mzEA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sjzXCbgxUx5GIfuVY5ecDH4r+hpqvONP9eEoz0MIa9+l8ndOEpjpBEfpJmr3z33MFKZOynO7bP/nc1YLCmAMixqO1hZeQfMLIOywo3SpCR5PdHTJMU+JVEjm3tCB+0/1YzaxINUanSxM3cnIxOwnZ9OCbIzAfW4Fyi8BskLtmywQJl1UypXxXxbYHHSC950oKrvbfV5RDftIBuaMsCGGRurkoTDiHOam3GCyVl14Fo4YrNNMObRLUtIvbQSG1BZNSHXDdQPloEHnLIqV7A9x8EScHKJr/FNtHCeM6DWUZ37rtsVwWfTGVdXcFonwattb6uxeun7P7sJibRXweDsVHlDNJPupNUY5ku8voERP0AQQZJkl+7vWAprLOxGe7Fm7xzOciEcTx5Oa9vxWskh69+EFNtgvMTMrN7u9e8nHzT4Cz0XObBhTu1ELfNtSNcPt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 10:22:24.5939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad17f012-4c90-4e3a-355f-08df08dc14eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6806

From: Rex Fu <rex.fu.amd@gmail.com>

Update the LPDB and RPDB fan GPIO line names to align with the platform
fan numbering scheme.

The LPDB fan GPIOs are named FAN0 through FAN4, while the RPDB fan GPIOs
are named FAN5 through FAN8. This keeps the GPIO line names consistent
with the fan inventory and platform-level fan numbering.

Signed-off-by: Rex Fu <rex.fu.amd@gmail.com>
---
 .../aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi   | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
index a2392f684b80..3ea5d67865d4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
@@ -2,6 +2,40 @@
 
 #include "aspeed-bmc-facebook-anacapa-evt1.dtsi"
 
+// MB - PDB
+&i2c8 {
+	i2c-mux@72 {
+		i2c@0 {
+			gpio@24 {
+				gpio-line-names =
+					"RPDB_EAM2_PRSNT_MOS_N_R", "RPDB_EAM3_PRSNT_MOS_N_R",
+					"RPDB_PWRGD_P50V_HSC4_SYS_R",
+					"RPDB_PWRGD_P50V_STBY_SYS_BUF_R",
+					"RPDB_P50V_FAN5_R2_PG", "RPDB_P50V_FAN6_R2_PG",
+					"RPDB_P50V_FAN7_R2_PG", "RPDB_P50V_FAN8_R2_PG",
+					"", "RPDB_FAN5_PRSNT_N_R",
+					"", "RPDB_FAN6_PRSNT_N_R",
+					"RPDB_FAN7_PRSNT_N_R", "RPDB_FAN8_PRSNT_N_R",
+					"", "";
+			};
+		};
+
+		i2c@1 {
+			gpio@24 {
+				gpio-line-names =
+					"LPDB_P50V_FAN0_R2_PG","LPDB_P50V_FAN1_R2_PG",
+					"LPDB_P50V_FAN2_R2_PG","LPDB_P50V_FAN3_R2_PG",
+					"LPDB_P50V_FAN4_R2_PG","LPDB_FAN0_PRSNT_N_R",
+					"LPDB_FAN1_PRSNT_N_R","LPDB_FAN2_PRSNT_N_R",
+					"LPDB_FAN3_PRSNT_N_R","LPDB_FAN4_PRSNT_N_R",
+					"","",
+					"","",
+					"","";
+			};
+		};
+	};
+};
+
 // SCM
 &i2c9 {
 	// SCM FRU

-- 
2.34.1


