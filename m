Return-Path: <linux-aspeed+bounces-4717-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92EB1C5CFCF
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Aug 2026 01:04:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLkXV0ScSz2yrL;
	Fri, 14 Aug 2026 11:04:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c105::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786616640;
	cv=pass; b=abLmL27YBmzJ3kpWosTJCkrk/gReKVm9JxFXfi0qlRQ7+ryqN3CTbFjYEcnliwyNjBtiPqYCA9rK+rCkhJdvBiP02iO4UhwgBOoWqgkVyBXHbSZE52IjwjijlwcJkTXFefAbkplTl6K8PYT1cZz2MWuNNkpme4IwCdsFlvNURZw1VF/BLRdFKxNSaVMgmYRojZrA/IKa7BZ1KkBIbC7FrtqBUPdly+z1ooswIgsME6r9biVvo0Y7oJpRczwHN9OcU7zrznR7lCCKvYFdEDRrTzqCQOuuCisWscUBdyYR5aMJKDzTJOQmrInraUh5692xjZjn48vebpkD3WhgHESO5Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786616640; c=relaxed/relaxed;
	bh=v0yXVRhwFXOnIIim8O8d/rmvnD8oZrbiiu074W2Rt8c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oTYL3eDyT3ch10f4Z6BBEMQduBun0WDRQU5JpLdF6+c12D5TSEYTVNoexrgXOeBDyOwjNagtXh+/4VuQeaxeFXeGWYHsppuBluIvokiyLo6W8KIvS4TCj6p+gk481DKl+CXwMh9xgK9plnpbq9hUPls1V8eSXSENxHEH27n63k7yE2+nDKxPC8tA8UV6hrL0BboNdfGKW5x4nkOhKcqPcqBP+owk3Yf/ZoCOXyLDen532d75DVMcFnqtbVIR78AEYlQ1jvWEr5IleuBq5xnWSsJLSFVImeWU9MU5vcpt1nnkFUh2VPDkIEP2CrzD2L/4yUBZcsV0mvuYAjH3I3A0TA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=tC1NEKKl; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c105::5; helo=ch5pr02cu005.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=tC1NEKKl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c105::5; helo=ch5pr02cu005.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org)
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c105::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLM0H10Xtz2yvQ;
	Thu, 13 Aug 2026 20:23:58 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wPouUkvq1ZdPrJf/G0s9T0mIRdC7CYJSiN/IPxr6cFE5nuenfUDCktBSiKImAfkiaBSAV53XwVrAnsKqXLmB2wyv8em4J424ugVFtoACj+ooGR8gTNVYMQ22uqkZTyS95/DCloI1TNahUIJNLRnvA6NwpYT7YmXjIwOmKLh+zE347sA6CqrTwkz6cULrKKlKtCBl4K9nAiRzIUX4M3g9iifOyZdxIhSc0su2Fognh5ho+r33VnJXbc0s9kRgDMb3+05SO9RJjEGITrJfl5GAyV01cLLuXq9BU3buX1H/RrU3jEiKMwkNZ0UOtpKpsJ9TMZx9hucJ1rdZY1tEiTE2Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0yXVRhwFXOnIIim8O8d/rmvnD8oZrbiiu074W2Rt8c=;
 b=D4HKKcDMEuc5rh8RwqUGr1yTnYIZd/qowBFQE5UhA5lEqO1i+8kwHH4L/CIF6a1zTjn30Y+BN/fNcjSoRbwVxxcVbsFdSEXlZLVrNak9m3YvBmWOLfz+r91g9dyDGmKIokl7bQhocVyx4EfsvMYmVz2TiqUspgLKAaxA1pZLPzSwX1PsjBpEXiu4lH+cg5CM3QfWL91iI4aEAKdcsU4k7KPhIUwqrVL5PMX5ao8wc5ICVS3vRk2n4H7k627/UNF1aWt/qCoobTGpmN1fW2Dkav44+SUC1RhW6AqQ/yVTm/3f1lU7ILWzE4JMvSSEmDv5fTKknecPpaO7DxDfIn7xQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0yXVRhwFXOnIIim8O8d/rmvnD8oZrbiiu074W2Rt8c=;
 b=tC1NEKKljWjLPTp/FA86BU8QV13Bc19ZNhwrW1gYYsSPxma0EQnkZac3D31fehpX52ps08CChiMLtLYRSKauVXwaJeo/p7RbXF9Hp+52tSGNZvFA8+LhS14yxF4S4ZSQAcKONPiuaIipQwLLq6ouJ673xcHYucte4LaBQMrZDYGEDCRVK9nQr2ADwON6+2buPMf0YV2E7I59husWJIxDawoSUIFvdqf6SugO/NVctDXnzsxg2o3Bru+0YN3HSVHCRoRshUcmZBLtoIm/qzQgNvKP7yH5JJPcdRvS6pElzupEgMc2asYyBsPSypAtHqW9QoQXTghtyNlK5qrd+knf6Q==
Received: from CH2PR08CA0009.namprd08.prod.outlook.com (2603:10b6:610:5a::19)
 by CY1PR12MB9675.namprd12.prod.outlook.com (2603:10b6:930:105::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 10:23:34 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::17) by CH2PR08CA0009.outlook.office365.com
 (2603:10b6:610:5a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Thu,
 13 Aug 2026 10:23:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 10:23:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 03:23:21 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Aug
 2026 03:23:18 -0700
From: Jacky Huang <jackyhuang@nvidia.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley
	<joel@jms.id.au>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>, <devicetree@vger.kernel.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>, Jacky Huang
	<jackyhuang@nvidia.com>
Subject: [PATCH 7/8] ARM: dts: aspeed: Declare SPI NOR flashes on remaining boards
Date: Thu, 13 Aug 2026 19:22:32 +0900
Message-ID: <20260813102233.3088939-8-jackyhuang@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|CY1PR12MB9675:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e834940-36d9-4e99-a7ad-08def924edd2
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|36860700016|23010399003|376014|7416014|82310400026|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 RAVmijGytNnNHyiG9JE2H1OZl1qGjTn18qeVTVlf42XcbUhmsm5AAYUXWzBD359l747qsY0snK6gx+EmKuRjv5pDxS/ultT/HovrKLxQGhtfqVArWt204Nu/VvwWBvQijBqCCT3UkZri9qP5NXNuZcEdbdMcd346eqUE55GwFEWOQpGVcKaoZX2K7nl0JpYWRDdWT8TKUuNlIP67Plc9pe0dSqf/1rO3aFap2wsx/kW1kpi5G3mH+g0HCzsixm6lmVU5fjjpWCdwRh5suLFF+DcLdA16GH0tGqRkxVuMelwB8O5dDfaqCR8RMEMlTBxBiW6c1XBhcO11ypTx/1ixJQ8/JwTULxx0NKDQdTNw3tx7XtalRQeFaS8p1WWwKkY+3y9LFJEgqRKVyt2XKI9tJG3Go1olmwUNm/YVUvmdREyXkSnbShHoCKB3xL01jmOx/CrN3ZJjEI2JrYvHSeV1mnpA0c4IO/vFs98IfFnlVnhhzgoNoXdbVk5DTSZXZjPTs05dLPtVOpl9pxx7NLPWGVzQYfIsD3nrAhbtCPqRFZ2OJs7EuTzur8+Z29BwW4s38BYO3xnMAzhRKbeTl0nRQxuVY7kJ63pyu501p9v7xtDJWU33R1Sr5Zm/a0mJm0QlG5SRzIEpQvAsZZY+yRJ0i308fXI2tuMdys+tG7+BHNeVNq9hCn1qr/E1cNDWxvFlWEnAnItKy4OSq4/MxMtGjQ==
X-Forefront-Antispam-Report:
 CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(7416014)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 31ntoej5A8sgfNntuUt/4/+l0bQOpqmp5B+UP3/DROOhibZjQ5CSmPJC0iNr655iGebQTiyV8+q991JEdgwdKknaLYuhyPRQSo43PIIWkIDyB9T5hUyGPaQyrZeJXa2NS6MUV8sayashFUMaFnPgZiUeWBLlPn6tNVrrwQJITzugQVsquq73OWIRYdpY5rQ+zPwCneI6WhIyQzOglFrDBapWBTdyNh+QkBaodNKiXJCHD1ttLgrgcMsz7jLwsEGhtQ1zDyDKGONWe5URFwujUTzFQLQlEfoPNdfjqoBndSJdJwAlT+0OAwuPObd/vveDm2JBOv57sBHqXFAhdZW9DhFSku+ySRBbxdqEWIgjKW8QIz0UMoTdlp6MICMdCVeNOTrfH9isOuZ7HcLDs2+TbrMSWLP8Gi534l06mI7MovX6SzPtRTHE97i+1RWdfL0E
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 10:23:33.5317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e834940-36d9-4e99-a7ad-08def924edd2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9675

Declare jedec,spi-nor flash nodes on the AST2600 EVB, Qualcomm
DC-SCM, Quanta S6Q, and UfiSpace NCPlite boards with the properties
previously inherited from aspeed-g6.dtsi stubs. Keep status = "okay"
so these boards stay enabled while the SoC stubs still exist.

Signed-off-by: Jacky Huang <jackyhuang@nvidia.com>
---
 arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts          | 4 ++++
 arch/arm/boot/dts/aspeed/aspeed-bmc-qcom-dc-scm-v1.dts   | 9 +++++++++
 arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dts       | 6 ++++++
 arch/arm/boot/dts/aspeed/aspeed-bmc-ufispace-ncplite.dts | 6 ++++++
 4 files changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
index 3f2ca9da0be2..38f8d7c03d16 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
@@ -179,6 +179,8 @@ &rtc {
 &fmc {
 	status = "okay";
 	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc";
@@ -194,6 +196,8 @@ &spi1 {
 	pinctrl-0 = <&pinctrl_spi1_default>;
 
 	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
 		status = "okay";
 		m25p,fast-read;
 		label = "pnor";
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-qcom-dc-scm-v1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-qcom-dc-scm-v1.dts
index 259ef3f54c5c..882b68248e14 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-qcom-dc-scm-v1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-qcom-dc-scm-v1.dts
@@ -61,18 +61,24 @@ &fmc {
 	status = "okay";
 
 	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc";
 		spi-max-frequency = <133000000>;
+		spi-rx-bus-width = <2>;
 #include "openbmc-flash-layout-64.dtsi"
 	};
 
 	flash@1 {
+		compatible = "jedec,spi-nor";
+		reg = <1>;
 		status = "okay";
 		m25p,fast-read;
 		label = "alt-bmc";
 		spi-max-frequency = <133000000>;
+		spi-rx-bus-width = <2>;
 #include "openbmc-flash-layout-64-alt.dtsi"
 	};
 };
@@ -83,10 +89,13 @@ &spi1 {
 	pinctrl-0 = <&pinctrl_spi1_default>;
 
 	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
 		status = "okay";
 		m25p,fast-read;
 		label = "bios";
 		spi-max-frequency = <133000000>;
+		spi-rx-bus-width = <2>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dts
index 86451227847b..70791b3c0989 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dts
@@ -196,10 +196,13 @@ &fmc {
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
@@ -211,10 +214,13 @@ &spi2 {
 	status = "okay";
 
 	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
 		status = "okay";
 		m25p,fast-read;
 		label = "spi2:0";
 		spi-max-frequency = <50000000>;
+		spi-rx-bus-width = <2>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ufispace-ncplite.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ufispace-ncplite.dts
index 7ab29129d1e4..d8f7939abf8b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ufispace-ncplite.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ufispace-ncplite.dts
@@ -148,18 +148,24 @@ &mac2 {
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
 #include "openbmc-flash-layout-64.dtsi"
 	};
 
 	flash@1 {
+		compatible = "jedec,spi-nor";
+		reg = <1>;
 		status = "okay";
 		m25p,fast-read;
 		label = "alt-bmc";
 		spi-max-frequency = <50000000>;
+		spi-rx-bus-width = <2>;
 #include "openbmc-flash-layout-64-alt.dtsi"
 	};
 };
-- 
2.43.0


