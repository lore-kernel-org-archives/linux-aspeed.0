Return-Path: <linux-aspeed+bounces-4724-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4823FC5DF66
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Aug 2026 01:11:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLkh344FLz2yv9;
	Fri, 14 Aug 2026 11:11:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c111::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786616638;
	cv=pass; b=mqYWa7O84lzWsM/skfGEKAhdSLF25lVqg2f4KpSmQKJfQH5mz+GmGhbCyiw4/+Of36ZIcWKkau1rPQKszR3vd6dg7feIgglNYOGAFUua7CDhw/7Jm2IoYQUPXAr972uUjNqf/AZn1Bq2LZs9YYSBvmc/C6Nt1btlqC+X1kJc3SliQWpqg9MrnbVch2+ToKo+z6kDyCV0RFFln2oOkgoUflJBGy8oUNIRGt8X4YvPEWv1y1VWYsMXitTbpYY9uB4W1P2vtIaqucYxGcnXsPTHCJ2wSuDeUXjuhrLmSCffg4AosM2PSzS1J8Btava8YiuuNAMMh9GlwbydidYNIcjdwQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786616638; c=relaxed/relaxed;
	bh=9xpKNG39N3jAZecGP7ZuL7mxROaAadT+M/fQJ75UjpM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N2XVDKJfdcJ2ydsIjCeeD53aAE29QCMRGkgX/ebPYOnY3n03OI8Ewt7GXqkaR7lBSwMq43zgxhocCiKAPXAgg48TZ14qrtd2GX9OHfxlc7cWaJoBB/WGTu9o7Nfr/5GnHb9Z2p/NXwQoF/O9+WhQ3QRiBoyoQtUgkDsRiS33P/PSGv3UFoK6n6C9zf5BlYGuMQjTFs0icacBWOoKstdjtD02oSWgayVrcRMJzqOcSFjSCxC4L5sI54YWQkEuHp//K2woUBlOPiTEOfPxQD8QqSuc/LFfsq6lWv3Zhtt3/mb0kR/NjWFbIEzJi3Flx2t20ty3dgsS/DdfjYe5Jo+Z7Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qwPBd4jI; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c111::5; helo=dm1pr04cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qwPBd4jI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c111::5; helo=dm1pr04cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org)
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazlp170100005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c111::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLM0F3RHdz2yKD;
	Thu, 13 Aug 2026 20:23:57 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ffLqsR1T9+SIp9lfSzdSh07bQVrXtHlVJwume0T7lDZLge/TCC6PLihLndgRiogu+sRIkkM0R0arwVNvqCuAcOITJePalX5JhxEPctv6XFsMtgvN6ButuNHaT//K72of+nKDS3gTOG2ixWAQS6y/c2ve3Z8aFpjbj3lvrOlJ9NBP+LdQF5JczckzxdL94KmATgR7dls/h4I89mQddfetBFmagYodTfxb/GF3o1Ae2SqCadsc33DXvn0WU3vIHAN5j2YIgtIJrqc+PWrDuI2/HZ9IpH2E8seoFKMQG6wMIqvBGvfFXlLFRrS69cvpc6qT554PssU9OX15TMjPOJ5Feg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xpKNG39N3jAZecGP7ZuL7mxROaAadT+M/fQJ75UjpM=;
 b=W+FyvCUhQywTNVVAmWkvN94YZttdS1ScO8B0EBabEsh5tv8dlr2R6F80ibUh2TqeMiDMUjxq0nKonE7Yao7ZpSrsAb6WjRCuSHFhIedbjoTRlgkXApnDEjPOVLrhqZ2Di1rVVgYyPSLXS/Slsr3Wk6FVA5EiiYsr0cB+jichMKchlk01sbu2HnfQOHivhGh0UbslpDyE9ahd5lTo2HGaTfJOsdl4xvRKhI8M7OQDf27tfvtAVjj0zGdSnVP+NNZk+LrWwDAvyOBlgR9dYVg0o9lKNzBvvPfoBn2FiSGVXfV9K1kDPpNa6yYickXUC3mjuv4+qk3F8WhGEY7/JYtYhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xpKNG39N3jAZecGP7ZuL7mxROaAadT+M/fQJ75UjpM=;
 b=qwPBd4jIYuZ8cgF47+G8nAhlHL2ATJ+gK5dwOaTHkkfT34AB7OVjW23v8gZsUpJb/eNkQkwq1bx6ilsGZbIyxIex7kXIZvUX+eS58GXuG42ktMryrR7Z87OIdoYR4ItHx69f5FDBPbu9aG8SQ4hEQmLHOnEcESw7NO2QhEmpUFHazXxU9jTmL0lApcOPe0KQoxxVjdFFyLTxbvPLPTomzWta3EEyYngWq2GdLevs2Z50/rZDFPpXHM+4fV9b47z1JJPj5oxA+H97FOhDbCDzKJmvxw5082vwENR5hJ1VEZaV/ti3p6z3kH6RuL62gQgvirYeCrykxtZGmoTQdCKpIA==
Received: from CH5PR05CA0005.namprd05.prod.outlook.com (2603:10b6:610:1f0::6)
 by MN2PR12MB4141.namprd12.prod.outlook.com (2603:10b6:208:1d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Thu, 13 Aug
 2026 10:23:33 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::d) by CH5PR05CA0005.outlook.office365.com
 (2603:10b6:610:1f0::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.4 via Frontend Transport; Thu, 13
 Aug 2026 10:23:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 10:23:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 03:23:18 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Aug
 2026 03:23:16 -0700
From: Jacky Huang <jackyhuang@nvidia.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley
	<joel@jms.id.au>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>, <devicetree@vger.kernel.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>, Jacky Huang
	<jackyhuang@nvidia.com>
Subject: [PATCH 6/8] ARM: dts: aspeed: inventec: Declare SPI NOR flashes on boards
Date: Thu, 13 Aug 2026 19:22:31 +0900
Message-ID: <20260813102233.3088939-7-jackyhuang@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|MN2PR12MB4141:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b474cc4-d3d3-4c8a-b2bd-08def924ed96
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|7416014|376014|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
 ksqq4L5apFuJbyCRPmg0fS+kwoAI5WRJ+IovQJjjEQOCxHEOaPZ15qH7vccfpCgslyBxpk8LV+RU0J8QqExQgq7ehlaRgAnNaZwy4kA1HUZJFvX6LIMB6MSMKnzLsj4w8KWQYaeApFkmwA6MvDeVa0xJf5HUgggzrQTbFIsqdRKmWl4Ccgn9E0k/iMEwui1XJSGv2+aYq7UBsmQqs9bu4DtXQRVj3yuf6GqOqak65UxeT7kaz9ZQHB84UhcoGPq5EHx4WTacQg2Okxl0rPsjkZqMblPPs+QFCdcoMtt+sR7SZTmtRTfuXFdbkGP7m0VrvQuc/5uNAsrMrgGru4GveECf5zsq8mB3bE45pE3S6D7M+EcbkIzaNkFpcEGw9WpMQ0OsAtewNUrYlek7Jv2xhaz+hQ1xW1kf3jPRlaQmGuuQEOTKkHEA2UA/avZMFoTP2c642vCL/422W1yL5tnrxuV/jpfvR9R90926CQy0o0nI9P0J7rPnmYvmhftmqcKsequR1zWrKF/fSYTz6NHTMdxwcrp1dwRwLLpNkwqcJVpq7/QrgN2lCzJ+oQ0butQLz7sGPFeZRUAjlLV9szkqeoPSOCls/R1NeC2tVCI3xt1flAXOq5yvfXjEsAmpoWLxxbnDYRwcQOYRjq41ii/Gf7tyx/tyhh0ZRFwyVXfByZnJW5oIa8qu7P9gk6iBwJxPKgG/jK4Auqjg5mEF4uSHXA==
X-Forefront-Antispam-Report:
 CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(7416014)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 NWehZodm7bdgEZ+9dLLziHz4HKIAMyswGh3077xVy1o636mabCQY/d53AkwOsD8r8oanRrv0OpfUPzuzERFgGUjo2nSNlXXtOuafr3PN7+uUz2Vz5lKy7xo0qr5M/1lECS6CZPbTtWs/Nf8A/ZFusb0defB58SZi0/7HbrnXOSRo+v/2ZStqvasnml3YZM9tn/RR2wWp5wnznmAEIlBvtaupSF94bx/+CHwmsLPlIM4jcXPfo1/WMAASUzUzqG2rDWaniUZlY02oWwSQlVH862tNnsYvsiaGSJM5V3WAv3c3vp+EOIGoUu4WI9a0hUZ3mMzGmolYUHeTMJFVyMdpmhvyLTRF5dbmqqRpRwuEBNgfJq7R3m+Bic7CTl5qjDUfFnVnEcfk3OXIcV1faY7v3YS9YaWMw1meJI0tPohc8zmJseeUuO4bRj0VSHbo/dB4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 10:23:33.1807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b474cc4-d3d3-4c8a-b2bd-08def924ed96
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4141

Declare jedec,spi-nor flash nodes with the properties previously
inherited from aspeed-g6.dtsi stubs. Keep status = "okay" so these
boards stay enabled while the SoC stubs still exist.

Signed-off-by: Jacky Huang <jackyhuang@nvidia.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-starscream.dts | 6 ++++++
 .../boot/dts/aspeed/aspeed-bmc-inventec-transformers.dts    | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-starscream.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-starscream.dts
index ec82af94e1fb..0bb3c6ab7a1d 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-starscream.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-starscream.dts
@@ -81,6 +81,8 @@ &mac3 {
 &fmc {
 	status = "okay";
 	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc";
@@ -91,6 +93,8 @@ flash@0 {
 	};
 
 	flash@1 {
+		compatible = "jedec,spi-nor";
+		reg = <1>;
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc2";
@@ -106,6 +110,8 @@ &spi1 {
 	pinctrl-0 = <&pinctrl_spi1_default>;
 
 	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
 		status = "okay";
 		m25p,fast-read;
 		label = "bios";
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-transformers.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-transformers.dts
index 45ee0f2cc2bb..35f28799fdf7 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-transformers.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-transformers.dts
@@ -64,6 +64,8 @@ &fmc {
 	status = "okay";
 
 	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc";
@@ -74,6 +76,8 @@ flash@0 {
 	};
 
 	flash@1 {
+		compatible = "jedec,spi-nor";
+		reg = <1>;
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc2";
@@ -89,6 +93,8 @@ &spi1 {
 	pinctrl-0 = <&pinctrl_spi1_default>;
 
 	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
 		status = "okay";
 		m25p,fast-read;
 		label = "bios";
-- 
2.43.0


