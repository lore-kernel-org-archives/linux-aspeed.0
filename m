Return-Path: <linux-aspeed+bounces-4718-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6561AC5CFCF
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Aug 2026 01:04:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLkXf5Zjkz2yrS;
	Fri, 14 Aug 2026 11:04:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c110::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786616639;
	cv=pass; b=cuwUF0MC2WKOlCTheiTdqqF6VONzct2nZNTb4XWm4gUhjdy/aJe1Ol3kZ8eW4daNKAeLrqa7PD4ojPP2HUfRd0CLbx2nnhP7+5biXXpcoBwGczOAxEi/JW7/OICwaogEPpoTI2GA79DuyoTNSENNB/PFeWJ82rGodLjqR09TG4th7+KAeDPkMpE9QVdvtoO/rnGErJwzypU1aoaEuYlkmcajVHBaFsyIoUE9+v8nD/ALX2OXJ0mLb3BLChYfYYcoiZtV98VjBroCO7Azal8msknPYemRsWJMw5UQ/sdl10DwdBRdKekAPYt6FJFlHlcRHJuX/DLkPvjl6yxHglRW6w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786616639; c=relaxed/relaxed;
	bh=uXdWApL8MxF2lSJTTeXjTk9M55j2kjBADSbZzVlhF6o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e+rYplE5pxwkNruAPLHuevY7Z4ZkOG2OiFQ8thnhEY4H7+VZwPl8JRGcM2PgupPhP/KHAbRMk2ddqJs1c3VisOfVOUCGbewSK48MdPybJCmMuJtk3MazDEZdMUu+UOo4C6m0T1TREGugzSYzHoSCIkW+hs81IZCEO5sNPYOQB63pk97vcTtTPX8wJYDA5Wj8fVTAqL8Hw/phlwKRRZgfETV1JTYdDLla0MrcVz3hRXAEu+MZZQgkfIbBdtadXU+saVqkRwYQr7KhXJlXxvuQ2V+QqNnTl9SZ85Nez9JjMb+CytvL7PxVciVAjVCCLKV3+3f2tPqYqXnYH0m8ywrGLA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=d5bxXZjD; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c110::1; helo=bn1pr04cu002.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=d5bxXZjD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c110::1; helo=bn1pr04cu002.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org)
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c110::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLM0G4lBHz2yvC;
	Thu, 13 Aug 2026 20:23:58 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ukLA68PyNZOwmyhC4+Mnq4Y/JAdPHnP0no8cSmidXLXmYRorSwLRt03iC6P81Kz/b5mSo5/lGRFitrkSW/vNJs6ujR0xOj40RH1zS7SEilrN81zX9A28y9nrwujHAcEm38kB0jtFjmEM7GRWDt8UA1Gl0wrKaIXUCsJKKs9VKLBGm6IdtizS7bVmYL5SlU9mwFNW19BeLsZTynVebe2rtiXVtEEDkR2Zgf87dx8Kct9T0jPYtDxLFQ6n5Te23fGEwuuufbpACiJCCw0xDMjySievSBcAT/tOdona7EI1eWPEo8LmNSSPTMM/8YRtfhF6Vfd6EBckKAJ+W3jhXfGfJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXdWApL8MxF2lSJTTeXjTk9M55j2kjBADSbZzVlhF6o=;
 b=flDDXe+QAmstDD25SP6sfjrvTM+HY9bmCIX9sApkaA4Ck6EanEBqKZOYzuZ5tDB5nsvOr/qdu0RJqQbKl587XpWlSdczEPWe55VYxGXTycUqObQx/lfHoWzC3d3WHkgytw40zeSOzxuDkmUcFL6ff7rLiNRk0yWPqNS3TNQdjoGjIlSS5oSzMzKiTBUTEQgm9B3kwZNcghTyDDjyRGGTL5vIXKZUcd7BzoKofZUkjurTJwsIpFG+B6+xmOuDOWB0WdlBn5Ghbq6h4RyMEpoMpy2J7akejuYpY7CVEngyWw0k8gPo1JB90MHLkDcCe2dFm1Okj1f9pfo1y/DYceIyUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXdWApL8MxF2lSJTTeXjTk9M55j2kjBADSbZzVlhF6o=;
 b=d5bxXZjDe3uCEp6kKtSwWO5cFHQFqhcnGgDSE/qVQxVnithqE6/GckzEvSFuX/LfOS3Xh3KGBOO7yAPT96viA/ulWcks+pV/ntkNpae/nhqLq5kf8HfyT4p/Cx3eTwW5YvbpeHq71wpQZ0GEBqyYH5/6IX7x43QrV2lrxrNOmJFkTz+9l8mUdvwnPscHR4/fpwLxpNiquzFfwoS+keTBDlOXnu7wV2SP3tPBeszbKlRNPHu1/J3wvtHdlklGwnur3TGaoq3r3zmaMQkm1KFP4F6icn5/ViM+aoeqLmP30nD/pz5owNhT6B7eUAwaVumjuJYxNL5Va1kNJ06LgCDojQ==
Received: from CH0PR03CA0232.namprd03.prod.outlook.com (2603:10b6:610:e7::27)
 by IA1PR12MB6236.namprd12.prod.outlook.com (2603:10b6:208:3e4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 10:23:32 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::8d) by CH0PR03CA0232.outlook.office365.com
 (2603:10b6:610:e7::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Thu,
 13 Aug 2026 10:23:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 10:23:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 03:23:16 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Aug
 2026 03:23:13 -0700
From: Jacky Huang <jackyhuang@nvidia.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley
	<joel@jms.id.au>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>, <devicetree@vger.kernel.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>, Jacky Huang
	<jackyhuang@nvidia.com>
Subject: [PATCH 5/8] ARM: dts: aspeed: asus: Declare SPI NOR flashes on boards
Date: Thu, 13 Aug 2026 19:22:30 +0900
Message-ID: <20260813102233.3088939-6-jackyhuang@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813102233.3088939-1-jackyhuang@nvidia.com>
References: <20260813102233.3088939-1-jackyhuang@nvidia.com>
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|IA1PR12MB6236:EE_
X-MS-Office365-Filtering-Correlation-Id: 84256a91-20d0-4388-2820-08def924ed02
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|36860700016|7416014|1800799024|23010399003|82310400026|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 ylGA/cQ9K5Rl1RMimwW+FRSID6rLyWYHkXk0F7BH7tiEcy5TSlfbJJw5nIBECK0X08Ca7nNtUVQTWO3PtZEMjisEhpSPyq5tlGEJsl+T+2NxNzticc5toTpumrpj4T5TGrU/G3Xl1+dG0+t38xhYP3JbSz2OeVhYyjuThAPAIrEIAcxLw24NTU7+m/tdH1sbHSpc7SpImA9MkGEhsOyvXA2TXfEEPrrGDpkX+1Ceaq1H+4mKL5oqc+gG2V2G/9CmARx38VYkTTbK86RmM6ymS/oS54IMKy95Lj+G1N6e48ma4LSUzkKFHW6lDkKnUkYRvNKUC5dcloQ3uN+OvChmwWvtnsozaXY8K07z/dUH6pWoD/PCsnKHmBh34Aw6RBdzEYbHhNNEciKOxKtml/EbFJlUX2BVl+37I0JS//TWkqSZsslml2QBItTbrHU2XYMHt3uNvOVf3PyFpjDfM4bsL9zIiVm5gLttsltypn3qSgSqeU5eU6c9wCdmKpd84sVCRwC/G4uMF5gnoYEqOHY6smc12bS/DVAdQFuUPE+HEbJhuVMsRsLWzzPH/ahFEvM4Ma3PEpsFTOE7GJN3MuBWdvMlidvEZSExMVf3PjBA5tWDs+w9R+iuTqoKbEVNKsbYg2ILO8vrCpy2kwg5HXFkfUCkk/A6NJ0zOi4u42lgYyqnqxFCB4HUY9OBd6TlLKYQ9Z/yksFnCNNDBAZFdorx9A==
X-Forefront-Antispam-Report:
 CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(7416014)(1800799024)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 r151nwHTzwCmwysyScz5l8HL/bV6z4tf1hBRp1UhEKNDZg2HCs0UOjjE5Ei0TD51Z2Rri/9cE2H6/o08+JeAcqclYhVzKagw9saF3BHDkKbk2O+BSyI5V5MQV4k3CkF2GpGQ3qxdDuTGycuQ0TsYbQ/OtM/j+yVMidW/sUg5L+Q2KXaW+PnA7fC8gP3Sp+aMMRu+Gm1MQgpGk9liPYMU4rYYK+MSuH1z66VE9dmE2OEQxJYUqVv/DsQoNmazZ30SIP6ksiuSpMVE2xKnPaprf18GefH7alc8ykHZMhYzgesnhjzq56YCGQ0MnhYy+C+8E1K2lgE7v5dAetQBJxyCe9cUMZ3kcB0mR/LZAOuid1lKxYs5uMZ6T+WEMS73jheuNyV764ptpctuCiigoYlQa8o/J04thKfa+mMlOE6clArLESssiB5RaOdr/vfoHUug
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 10:23:32.2048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84256a91-20d0-4388-2820-08def924ed02
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6236

Declare jedec,spi-nor flash nodes with the properties previously
inherited from aspeed-g6.dtsi stubs. Keep status = "okay" so these
boards stay enabled while the SoC stubs still exist.

Signed-off-by: Jacky Huang <jackyhuang@nvidia.com>
---
 .../boot/dts/aspeed/aspeed-bmc-asus-kommando-ipmi-card.dts  | 3 +++
 arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts           | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-kommando-ipmi-card.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-kommando-ipmi-card.dts
index e0f7d92efa18..8e45e3928467 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-kommando-ipmi-card.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-kommando-ipmi-card.dts
@@ -60,10 +60,13 @@ &fmc {
 	status = "okay";
 
 	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc";
 		spi-max-frequency = <50000000>;
+		spi-rx-bus-width = <2>;
 #include "openbmc-flash-layout-64.dtsi"
 	};
 };
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts
index 64f4ed07c7d2..e024391a0dcb 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts
@@ -120,10 +120,13 @@ &fmc {
 	status = "okay";
 
 	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc";
 		spi-max-frequency = <50000000>;
+		spi-rx-bus-width = <2>;
 #include "openbmc-flash-layout-64.dtsi"
 	};
 };
@@ -134,9 +137,12 @@ &spi1 {
 	pinctrl-0 = <&pinctrl_spi1_default>;
 
 	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
 		status = "okay";
 		label = "bios";
 		spi-max-frequency = <50000000>;
+		spi-rx-bus-width = <2>;
 	};
 };
 
-- 
2.43.0


