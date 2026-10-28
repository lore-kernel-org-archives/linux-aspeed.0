Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C71606A31A
	for <linux-aspeed@archiver.kernel.org>; Wed, 28 Oct 2026 23:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pZ5dsDWT
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFNfX35zmz2xHG;
	Thu, 29 Oct 2026 10:21:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c105::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793209049;
	cv=pass; b=K/a7UWxEJdfq/RON9OjHQ4z7i5TTE8tGlaKaK5Fhkc1Lb2zaSxmLlycQxqDG9JKsUwDD2AUsHsHMpH+0KYmX7kwWcuTFpG51CSKDapMzXtemCS6H+HrPSOIdhN005mv1sjyycFaQ1zqeDzuanIbgB8Zixo7t1VZaF+FCQk1QyjaRaFQ/mE2kWDVs19vThKxFLdIHtlAQBZHhJuEHeliP6XbQRTPV2m0skaf7pAId0VrFsEuWJZZIXZoGa4bzqwUkMX4d443t43VzMd1WYWnCwf7vzU4cXjMSJfQo+tArjCLWCg7SRjYED1zWbRCk5reaf8WC20UTLNFbVSWUrwwl/Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793209049; c=relaxed/relaxed;
	bh=O/ANBHquPJzT0qjnhEl/ApZzQFwUp2IhZEW0Vv75qFc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=odNxUehIt6bQePJtf/svuO9Avf3oGHm3rmzWWPpuaUy5SEhuOugaei9oWb1R5sWQ+200O2kZNFs3TMM2DJKxKr+kFtlMgPZMtEZ62E+wMPij+T3o/E6WblYXw5cHcec3UohbHLR/oIOA+1fIKqx4yIzOgujqT39sv4pUSKVF7mIw353q0GpFWXsRz7laLhVqLGtOrsDYDL+84ltd1WJtaQ9FAVV+VlreeS2hhT3uYt8Sydl3XUwONXodvF/Hdt7cG6nHfY3uI0c2UhOD6F3bZlGPFgoUuTBvKfBIUddPyVYCSDwdGg0W6/FGMu1sEXDkLoPlcWDaQrKbzR1hwiTvRQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pZ5dsDWT; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c105::5; helo=ch5pr02cu005.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pZ5dsDWT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c105::5; helo=ch5pr02cu005.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org)
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c105::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFF1M4Shdz2ygg;
	Thu, 29 Oct 2026 04:37:27 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NqD7e9bflfl364P3d3krGRupQ+fywda1xuRUaDpdQbowBM8CuDG9d9zoFcKpu9K3dBtHh4Y6Mppeax/wE0uFykIT/MqquzRx4GeaEDGFCR2NYXyW5TZdAjLIcYn6piXV9i0sZlPIgBPjAwySFE7mcqLDpX9d4AY7gTzNgIzq0LV985Yka1vjq62L1dQqW7xd3fPshxe50pUauN+sczo96OqIskFUTUr+qo2fifETOpxvZboPeKa1+aNiVgOl/KO7jl3aAfTIHnc/M+AO3OoiloYvtjchIkWGaqR0mJy82F6krUfYaM3iHWZalPJy8Lp/BC5n9J+z7ynVRmMpecly+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/ANBHquPJzT0qjnhEl/ApZzQFwUp2IhZEW0Vv75qFc=;
 b=dtSTMCrtUqaC6EVrqeRNsVPTsn+vTKb5yDwqkGmZelkZiKjurSa95djrYl4q1h4u8v9zHQmVlgig+5NubDMQRe0JyhUSXDVcV6AYW1tkVTJF6IbS3+Sly0q6UH/501TYY84B8LDJpnIjSE21Pa/q1Pc0xmfoS/HLfxesVORsJelp5yWWHjwBmyANRwHnHzGDqZY+7LqrgmKwPf2LumLcy7Iup1NCCjqLEjxlFN4/ig1szG3LNt7RkEN5lmcsF/xUi8ofpSGXtRLp0qE66gVmN8MYhZtYe6jGILmwAcKiXjq7YB9yKOZYJZLibZZRoEQLZ/kt3+luhD6u15RIJN1E8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/ANBHquPJzT0qjnhEl/ApZzQFwUp2IhZEW0Vv75qFc=;
 b=pZ5dsDWTrwPwmb+dAtj4gY6HZc94dhY+LSM1nfBF/C2YhP2QovehGGp2LKa3l3Edgj3+Fqyv9xoXhN87UK7wfGtcg6G6g+WfSNG0zEMv+a5wBX7IODRc+TzvXZIpZTqGB4y+X8PGDGOZMtPr5/dPRGjdUrdZHclo8y1z8DvxLFbRZ1Uh/CEwQ4BL53cN+Rav/aVVTpg0M5O6gaa+YkP1HPZC+fsPkn8dBlaIKfHrhpfAAVZRIXLycoJJwhtyk7LM1QMY9jklTBw9knTmrHr/PV9+Ebjh9XjvE9XmEdQUcinsWdo2qvAz9O0CNimUd055W9AK/Rs/WUhAw0oFB+sMSg==
Received: from PH8PR07CA0047.namprd07.prod.outlook.com (2603:10b6:510:2cf::10)
 by PH7PR12MB8155.namprd12.prod.outlook.com (2603:10b6:510:2b2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 17:37:05 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::84) by PH8PR07CA0047.outlook.office365.com
 (2603:10b6:510:2cf::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 17:37:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 17:37:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 28 Oct
 2026 10:36:41 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 28 Oct
 2026 10:36:39 -0700
From: Jacky Huang <jackyhuang@nvidia.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley
	<joel@jms.id.au>
CC: <devicetree@vger.kernel.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<openbmc@lists.ozlabs.org>, Jacky Huang <jackyhuang@nvidia.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai
	<billy_tsai@aspeedtech.com>
Subject: [PATCH v2 2/8] ARM: dts: aspeed: ibm: Declare SPI NOR flashes on boards
Date: Thu, 29 Oct 2026 02:36:09 +0900
Message-ID: <52c863fb87b9e8656d7f2cf63c6b36e66b947d38.1793179064.git.jackyhuang@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793179064.git.jackyhuang@nvidia.com>
References: <cover.1793179064.git.jackyhuang@nvidia.com>
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|PH7PR12MB8155:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f46afcc-76c5-47c8-4e78-08df351a14e3
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|82310400026|36860700016|11063799006|56012099006|261009223027099003|261021121427099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 0qoq+9a0f+roknY7eRF1qtHYT5nOz2WKtqgBM2RHMP3ax8FZrfdE/MSqoZi7EqPLpNs/yZgeH5y+etweh83SG4X+Bw48havoRgkRpCbYNu/83goGeHHiZAWGOI18MvpnTMllA6BQoZpZA9DkaFx2p4r8Xsl86UXLd5IZZtrUV/4BHSC7CsWQRsdrln5in/pTRD0tzGSkmyVvyG/34fFzMCRzn6I5LkobzAaKkcsrEwkzAQ8C9MocYcE0jvQhPzPI4L8T9SZNFYGaCQ/OpK/e8PoKXkrzY6u+D0ZoC+9BcCNTzEnh5sT40fBSi2xij6puEnASIZIvuRsc1zfvMaOCdiR1o0SIxDAW8NsGS+dEaBLcJMFh6t911BMCvWNsTZ7TLoTbZQGwzx6UbiDIGhsoTblFU0KlxsMIJUVE8Grv6jifaKtLJY8sMgsBIpKORkPA4UclXAeyRwPtcj4R6QS6rQSeLm6tNlmG5ztqZjFbHaX16TOG4ha90u/IKHxbUTRW/Mw0zCVpqJaVtFPUXThckry4zFLpz8s4r3us+JHF4w9CBozxDvexEJXsdYmPRrPmIXYV/9NpNd9ktkWGCAG7CL/ZLlRsaZNJdw50zMpPtXGG76eTeBXzW9anoMvK+Ry7yOvpJ24xn3ofa55xCUBcyJ2xdiubAU0sO6Bv7C7myLzCCag9Uv7+drp9M04zILL3euSXtso+yzAD0/N31iBAQQ==
X-Forefront-Antispam-Report:
 CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(82310400026)(36860700016)(11063799006)(56012099006)(261009223027099003)(261021121427099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 94wBklRSnbs+LX1feMHy5e512xe/LsB2UcHLY0lcQXyUg9TdDQEl8/lPGSi5BNOdtcU7m4DbdSPTiZMjroej/y39DzkRULgxDU81iZ3YpxX5AIyVd0M29NPEk+a6ab180LKs9oj0zFY8bNyZ4FPWgON9OqRLK98f8xBo+18iOFvqyOGNPJ0GeEi7RG1Y6KaU2l+2ekSBG2nHa9m2dxwIAKZLVRUU9bkKBcBymBwoCL7Sn0C6sgiHIG8rMULUvPCDyEkuAhYgNC4bH0A0ic/WFvUBGCjW7CRPJCn07TI2pTFJ4Twe07BUYD+yiGWvNw9nZsnworIIwugMnQzaYHDpsFuHieV+O4jw/VJOuZdxvD2+wLSsVmPMI9pfDElDuFNHqGwSxjAoSDYu9VxKdw9G0PURQxoxH4ydjx+FfiGTTf4Og1jXkk1wBcqT8gVZ7qzB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 17:37:04.4331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f46afcc-76c5-47c8-4e78-08df351a14e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8155
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Declare jedec,spi-nor flash nodes with the properties previously
inherited from aspeed-g6.dtsi stubs. Keep status = "okay" so these
boards stay enabled while the SoC stubs still exist.

Signed-off-by: Jacky Huang <jackyhuang@nvidia.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts   | 6 ++++++
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts | 9 +++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts
index dbadba8eb..df45f6192 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts
@@ -1551,20 +1551,26 @@ &lpc_snoop {
 &fmc {
 	status = "okay";
 	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc";
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <4>;
+		spi-max-frequency = <50000000>;
 #include "openbmc-flash-layout-64.dtsi"
 	};
 
 	flash@1 {
+		compatible = "jedec,spi-nor";
+		reg = <1>;
 		status = "okay";
 		m25p,fast-read;
 		label = "alt-bmc";
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <4>;
+		spi-max-frequency = <50000000>;
 #include "openbmc-flash-layout-64-alt.dtsi"
 	};
 };
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts
index 6fe702359..d886f2478 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts
@@ -140,18 +140,24 @@ &gpio0 {
 &fmc {
 	status = "okay";
 	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc";
 		spi-max-frequency = <50000000>;
+		spi-rx-bus-width = <2>;
 #include "openbmc-flash-layout-128.dtsi"
 	};
 
 	flash@1 {
+		compatible = "jedec,spi-nor";
+		reg = <1>;
 		status = "okay";
 		m25p,fast-read;
 		label = "alt-bmc";
 		spi-max-frequency = <50000000>;
+		spi-rx-bus-width = <2>;
 	};
 };
 
@@ -161,10 +167,13 @@ &spi1 {
 	pinctrl-0 = <&pinctrl_spi1_default>;
 
 	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
 		status = "okay";
 		m25p,fast-read;
 		label = "pnor";
 		spi-max-frequency = <100000000>;
+		spi-rx-bus-width = <2>;
 	};
 };
 
-- 
2.43.0


