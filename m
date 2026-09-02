Return-Path: <linux-aspeed+bounces-4939-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4254C624D6
	for <linux-aspeed@archiver.kernel.org>; Thu,  3 Sep 2026 00:23:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hb0gG3VXdz2y2X;
	Thu, 03 Sep 2026 10:23:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c101::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788344561;
	cv=pass; b=cwgb2YVri7d+O1Lp8vxds2/60Pk1gDO0gLImI/M6gIhKJyUbAMWDbK/iWCjxFpLdlOEB8zmJLUX0lzSZBRo9FPetmduzlKJBfvo65jQ3jbgPHaZdHSEb8/JkccOC1DesxmjIeK5h0QWxfPl5GlBzJ2ncITykio2tkmWv5h+bGAuEKWbE6aeAnPiXDtj6yeQv5GcDdvt4kwiJOEDKVTiU2boe/5oWIWklx9z0MU/Ci11yLXo6MvrDAiUj7oL8UY/VGxukxzRe+2bYPXILIb5OiF8szLMRCQf6EdDoLk5gom4RGhqRYTkV0KxQ0V3FOqEboycfu7JKqaMMUd33/rlu4A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788344561; c=relaxed/relaxed;
	bh=PRsM2/3sL9e8tNNcBWDr2itQkbxIUJuX5JRNdJQai/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WdeJu4InW27YWHoMNl+uX08yK7ZBYCD6C4p9a4AW9K27RomeLGMP8PBw1xSBfoS9sORheWetH/ICXHCw/Fx1w2ZA8jT2h48Qom0dH24dHGtrWNHk88Fj/ZyLUdH2iGYF3YHk3DapDLX9ednCWbVpfxRLTOyMCBMVURSfn9Nz0DR9AE5+hBvaPyJ5XPf3HcD37TcmwPHfHdoufwLZVbrii6MNTFj0x+pT8KZ1cB0O2oo+EBWIYXzTA5vEykvD8MTQI7IhIZ89aNccP1eRDBVdxYCcAhMkKcBRu4Iu5+paKFE/S+BZofS2bnbs9k63xzNSRL+j13+Gi1RFJwCrdy5jeQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=TC+y0dBz; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c101::7; helo=bl0pr03cu003.outbound.protection.outlook.com; envelope-from=colin.huang2@amd.com; receiver=lists.ozlabs.org) smtp.mailfrom=amd.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=TC+y0dBz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=2a01:111:f403:c101::7; helo=bl0pr03cu003.outbound.protection.outlook.com; envelope-from=colin.huang2@amd.com; receiver=lists.ozlabs.org)
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazlp170120007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c101::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZf1X6lZKz2xlv
	for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 20:22:40 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HHU9Lvl52S/s9lnpWGljWSWeaQY25atXfng19Q9r8o6hi0asxrpFeD2aVbHjc4MtHWlABN1Orkctw2EEk73oU+yk9Y9L6685DEHQg2aMRZyGtglPj3ch9vYqPv7j9Vj9MfPlXtpWAPWvBzwkus8lh4lbY/keAeYOFTRcfsTmQHSSZCP80/QxPlAglya/aRhLlTcvkKSPOD9ptD06crXv/oFeeAIgTZFsmf5pNcioOmh5Df/xhjMiDVF3zvV316nbmMno3bAVlr20nYyFA888AGUa4iI2sKsYAd9a8ZLP1Q3rC2C3+W4FHoTlNOcRuzn5Ujgg7LPSuZBoIB+NQPafSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRsM2/3sL9e8tNNcBWDr2itQkbxIUJuX5JRNdJQai/A=;
 b=tEuI3oORYCDomRkl+5CZAZFMppgbC+VT/9zBQijGHQaORO9HYXjK2RNNQ/C7Pagk9VVCyPSwvPXa2x8Xdh+1cNR0f5Rvj9L+Ci5yUXL+Ihb/h9TBLZFIh0bJvW/+tb0jUvRj3dgkTP5va03i+4cMLWNuCMN2+edE0mO5D1klLE0axJh9wcODXcIzMUqLV8Os9WaYf1PDjK3pbEWzH/OqHE3LmJgqioZSFcNKj+A+iSsZseVJMo3k4tKTtZiz8rGnRrskchVWGByVJ5caWTh7q8PAXggmrNGX+tlU5qSthFkV0aSTWVXRTCrP8oIoAnomqIZcOnJezNqF4jfGVbGkyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=aspeedtech.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRsM2/3sL9e8tNNcBWDr2itQkbxIUJuX5JRNdJQai/A=;
 b=TC+y0dBzeyrajMAJgTscO9ZV+RuOcE9muRxGGxRlqSrFsZKgXlXYf+YvyPaPvdhuP2CGoXmHXbfRNWe5zJF7/U/WbwKZjqZUbm+VKM+HgX2r6ksnsZveL5o/OlW2070EppCrC31cB2cPRB0ENKXq7dbAVokBxAlazpGhsJv3uTw=
Received: from BN0PR02CA0047.namprd02.prod.outlook.com (2603:10b6:408:e5::22)
 by SJ0PR12MB6687.namprd12.prod.outlook.com (2603:10b6:a03:47a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 10:22:16 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:e5:cafe::a5) by BN0PR02CA0047.outlook.office365.com
 (2603:10b6:408:e5::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 10:22:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 10:22:15 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 05:22:14 -0500
Received: from [127.0.1.1] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 05:22:11 -0500
From: Colin Huang <colin.huang2@amd.com>
Date: Wed, 2 Sep 2026 18:21:16 +0800
Subject: [PATCH v8 04/11] ARM: dts: aspeed: anacapa: Add additional EEPROM
 node for SCM
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
Message-ID: <20260902-anacapa-devlop-phase-devicetree-v8-4-69c8eb2a7cda@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788344509; l=1225;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=dS+Ny01+XQ5n7Md3LPea05VV+V4r9WTNjxB4lZM1dm8=;
 b=agq+V6GAWDcaaKSoxza91nWBrpFn58LL6/AYZxpxvcxkxXoZHVExrwqVnBiajCgNu3SRWXglJ
 1SrCBpeuquzCL1TTxvozdK1SBhZPfE1utXMB6cyl8KHJ18mLYO5TS2T
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|SJ0PR12MB6687:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c7a31c1-2bbd-4e26-25c8-08df08dc0f6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|7416014|376014|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	ciCiQ7ubZyv2lZyMCBiNYYM0D41Q/4IHvgr3y/A+fNzhmkKNEJwV6Gqjzk2qvFY59Bem0uFx77S5BjBF4IuX5uH4aikw7sURZ9QNHybsFs3ggr+ppf8OdimRcXklPW9/6aMugPTeIonyQ9qoEGoxOBXlqqvL56Bovewyw02Ujdftrd9GSduZeVzX820DMkPtStVuRjY3NaZrEYS4p3/yZZ7+YR74uVZZ9pK0/6y6tB+ali0y3Cp38GWatAe23B1pQvL1jynJ6I0JC1nZj/Ye6nmyUTqRrH2khMUL0N9MXdoG5GbWDoel657Q4jaXEn/e/wvsafACWkQP/lV4ZwZ5qC15rW04ka12WSieTIG4meCqLIPKAEqHyaskP5NEiBQKnrC/Ve+fNNtP8I0SWkvtCUQMb4pLQWHK+7hsNWMibxFGKBb6KpIb44vqRHOmMCzX+LAncWsDjKWmFUkU0el7wxtarbS9fAlAJS1ZQ+3SldO1+EGKAxzhwRbY4So6puZ5RHlzDUCGHX0gh+prislARMmXWm7HQqirCW720fjry/GxwRd3hcCuG4vREgc24MLggEF4lx6B59qap/w5iz6bu8DzfAKcGlvdH666IQvLxTED/SoDht3YH/yEArbG8Xs555gVlGxFS2G4X8+X338CEbUHMVWbRXWilczIy41oeghV/Ro6TMI+SrDsku1HouJqTcpVuxejWMoQNpzoMW3hwQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TOdz+zjLkqSKbS/CwEWjWevnbPxzvPUa0DCr0iTmaFq9rJe1WFZnghJULCKQgBTveDsNrr2jOnXf8O3Ez4dn9BcNA28gACrcv29s9vsdzVPMiYNVKUYRVz6KmrBWORLIrKlJtLji9YkaiQFsCGY7oWy5tTVgZhL3oPbx9p8NQb6wxFRhoWdnm2C9v21M66+ObolstY3E3fmVBJ4F7QXakap6GVCwvtmSoslUeHZ5QWfCnnUY5C2j+Ldlgv0sJ5W+9XmBV+AF6S6Bdcir4ouGU3H6DWYEOPlaC9GE/QI68uBURcij5zRsP5s0HzePTSJNesgrdFfIhbA6jYueTg+QRlMVZPBQSG1zp1gok+bw2S9aXB4qMN3x2AVxSDO86RqaDX2Aiui3FOTdilXnkecyFsywUWXCik+Oretva/fLxb2ZAWUFT6Obu3kzsINoZ0AC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 10:22:15.4069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7a31c1-2bbd-4e26-25c8-08df08dc0f6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6687

From: Colin Huang <u8813345@gmail.com>

The SCM FRU EEPROM I2C address differs between SCM revisions:
- Rev B uses address 0x50
- Rev C/D/E/F and later use address 0x51

Add an additional AT24C128 EEPROM node at 0x51 on i2c9 so the same
device tree can support multiple SCM revisions.

Signed-off-by: Colin Huang <u8813345@gmail.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi  | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
index c43090618c4a..8c4a03a82d44 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
@@ -2,6 +2,20 @@
 
 #include "aspeed-bmc-facebook-anacapa-evt1.dtsi"
 
+// SCM
+&i2c9 {
+	// SCM FRU
+	// | DC-SCM Rev        | Slave address of eeprom  |
+	// |-------------------|--------------------------|
+	// | Rev B             | 0x50                     |
+	// | Rev C/D/E/F/above | 0x51                     |
+
+	eeprom@51 {
+		compatible = "atmel,24c128";
+		reg = <0x51>;
+	};
+};
+
 &sgpiom0 {
 	gpio-line-names =
 	/*in - out */

-- 
2.34.1


