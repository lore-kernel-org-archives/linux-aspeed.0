Return-Path: <linux-aspeed+bounces-4721-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47D4C5DF66
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Aug 2026 01:05:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLkXw5z1mz2yrd;
	Fri, 14 Aug 2026 11:05:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c111::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786616635;
	cv=pass; b=IOl1c5Hoej3eCMDtDRa9SmOJozxYhGR8jUcbFDIa2QbuwUfv60UzEljbNdPQiXc1Axsp6vM+rz4z2V5YCyoWjnoazymGQjhacJgl23ccvCd3tnIaOvfPTXu9BTbfBzALutYSnHy8i5I/+ecHSMRBbExmVrvqi5G34V9z43ir811JjkuybKv3b4aeUW4eGoJioaGKHUD2ZTw9wIcS4WlF/68Do6hZwHEXsW0yUWIVq8mOeln0E9tzCcknqZWyzSIf1yZUQ4l6E1iuJ3glXzVoRh5YyYvq41/loAzhMNb0+TLxTRMezgd/4gGf/QiHog7q8TyQTikianHD+yObQnUdLw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786616635; c=relaxed/relaxed;
	bh=04cXYLRJ4kD0BXV+N19EfarZadNTZMNe2eQxiQ5cnkE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lkuGSB6Ba0E3GYInjdvyZR4aHldNtCZ9zioVvV9cqyTNOlaHQTR5JQJt0W/JAcPjJ+oKzto4RRXZgNCU3CwjTp/XqoE8Ti2AdnRXbxHUf5Phg10mQsRO8yRpcFwf16rbGtYxR2Mw1fNpoIV8wrOtrTrzaNVlkZuA+SEqMx4FXQtY1ScIsMi9V996PNnO3LiSN841esg4NgdkB9UgfNdpe171mt2J5GAHogPGrWqQ+ZT1NDjIDWuYAHwHWs9FBUI4tYmDTKHsK/tM/nnQdx41Ioz3B4ofoHtPjD+0E+mkEaHBrZhAZSqE5unqohnlrpk4zd2LAzsjhC74G7RdT3PR8g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JqiKP+7S; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c111::5; helo=dm1pr04cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=JqiKP+7S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c111::5; helo=dm1pr04cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org)
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazlp170100005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c111::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLM0C2Ckkz2ypm;
	Thu, 13 Aug 2026 20:23:55 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p7tlT+n4R7NGL1HMC0fMt8QoFTjBPIlkzcf8g1dOb99hXUldOziJkXoVnVkKA0qnO0sw2ZfQDPgYZc87n264gQj1lZnY4c0fKyRHnPyabttV5e+ZmrB1GqJJqj+JgrVAeb5nCh5U6ydnYRRlKKVVLY1N2g3DsykjADMhuvC0zOfMTlGFhb7AfwjwPi5JVGTKoEwTcbxU9kLUe/ciHhoQRVFdLDTx7OAROtjfRm26zfJLzMAVSGOYBO4apa4+U6zM3VXnnOtd6NdiBdgwM/y25Z6YrongHVMKANdGU9P5VVuuifEwXjb8M5O9/7uIGuWblJkceWGnssOhWg7uAz8Jqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04cXYLRJ4kD0BXV+N19EfarZadNTZMNe2eQxiQ5cnkE=;
 b=V0w4Aechgqo2mrRDOnt9NvvvsA2JKft5u2sjI1IuIp3iuDkGP1ilSrI1rH1BX4qS5bntZO0Utvd7tmMp5SJlZDE0o92Y6oa9NX6R1YSfgUlVnZV5bNHK4DHFYjdkTHzcTi6nVunzCefyqIc3O+WtMjSoiuP2kPr/RJPtXYvTy5wmlmnFIY5UjzDSTHyDV2l159eRyoZ7+KOL8j86vQIy+9AeLUeTK6MXh+3TuVJxFbv33MrCRKoSNANSF2bQ2e0IIqWmnDhKon+miGNkLmW1PRTFIa91abveQG+JYgJ+7UqufZ/mJ5aSjFkWH5hL5WU+2EkT4l54ykn4ppw4A0hJTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04cXYLRJ4kD0BXV+N19EfarZadNTZMNe2eQxiQ5cnkE=;
 b=JqiKP+7SvRsVlE33s45yD+JaMIx8ScelOkwr+OrQCymiKiUotWr/qHk6jE+SP0R1QaFPhSXkLKoHJFW5QpePwbZjCnDkLwAfaKisD0YClbyZkwkQqodjgaDzmrZB0iYuslv8ZGqtWVBEX5SxOaQDd/MERxZPoyoNS7DeX7hoYVfWM9UEMtWIE4DG1H1cogbwdreRC1/hYYsDhWanduRbEeSymczQ0U9BfWyjMhEc8lH2QC10zjgzZxzGgOjSVNG8xbM2GfnzGym5oU8U+nPIy2iO6D+0e5jlwiYaCcPwj67YO8eVmcgKb/S26uAKLIrItE/mnDVr6fBo1j9ozIjlyA==
Received: from CH0P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::18)
 by DS4PR12MB9636.namprd12.prod.outlook.com (2603:10b6:8:27f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 10:23:29 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::7b) by CH0P220CA0012.outlook.office365.com
 (2603:10b6:610:ef::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Thu,
 13 Aug 2026 10:23:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 10:23:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 03:23:11 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Aug
 2026 03:23:08 -0700
From: Jacky Huang <jackyhuang@nvidia.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley
	<joel@jms.id.au>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>, <devicetree@vger.kernel.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>, Jacky Huang
	<jackyhuang@nvidia.com>
Subject: [PATCH 3/8] ARM: dts: aspeed: nvidia: Declare SPI NOR flashes on boards
Date: Thu, 13 Aug 2026 19:22:28 +0900
Message-ID: <20260813102233.3088939-4-jackyhuang@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|DS4PR12MB9636:EE_
X-MS-Office365-Filtering-Correlation-Id: 76dc69c8-5082-43ae-6af9-08def924eaac
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|7416014|23010399003|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
 e+PhBof/eutx2yiMMavwrv1qCXwLWh7ndCYp0/+Y32MG1/6x5OZRV3aBki4cKs5I6pM8N4LKYklr5PieoNZSj8Qo+XBhq9dpw3DkeaDJJEFkplvhcm6k5gavLoH89uRw5BCt88AcERQeEYzkiq7TDm29DkQyeHsbF2XcJ5ZHfI5+ms9t5bAp1M0f0EZ2mGyeoONLvcQFDJw9YUQpA4tIczjgen7rgzN9WI0m8PHpHnB2w9LQbFdfFKQk7uln3gR6IKAcml69PVt05t7EQmmlLRQLzXzBBjHhn7EVCSdPTNcqT2MlgppzprhDfW37BL5lXu6HrZ4GybwYaJRzlN8oX8GRHtniFfA+H6wLcoilSOki/ZMu5Gwe6XQYSAenkoQju7wL4Rzh0RwkvzYnTR40TYlTJcG1n7ZcV0WDXMnb87UU6m7CBlKCqvFFZPuhmYrDSZbMHJk+aeGfT3yb9UFPLER1dBXxPS8FEf+apVrqWyExjeEe5b+hdJY+hVQtlzj8houMjrm8a4yeLwEhS3EHEmIgiBWlQf3UpgK/PqI1HzlWTpgNHr0Pd/zmW380yuhFUtMML3VOm1NYx7ZcwX+WsK7XpGukqNlGbW+5o+bI4YBJFn0M7tsKL6Wa5IkzOWqnUQSgtcefdfJCBUeeddSeDJqJmPOg7j9gK8EK0RARWuGEuqC1QuEtygPHY2pc0fEO5TJxHYHnAT2T7xfwWqmuTw==
X-Forefront-Antispam-Report:
 CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(7416014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 5jr0TR2zo2vCmBE2T4dsBQVZ/udVcLUDoYAQPubLybmVPy2jd6HxZVS2bPVJXAjyAmeoD277l2PV0/LnbjqIZZnmKxTcw0iY9zDyodldQjppLVTD+AE35ezRnjFRQOf8RvfDiV4MeLwz0lAkSZ9qITf42EcEgXXjacx/gxOXx5rsxRN5q/HIA2lqnF3gsvnOWzxqqdYwmvdqTUXz2+nfADXK9kxxZ/yhGtiBK3deXi5lW1bAUTDyu95LibY+1EX7A4ggKcBcrpi7AH5hqtscnPxQtVlg2E4nf/sK34Iz1ejaiRFzJ0hrjSJXWLOSykMik8IsVZy4z/3GrExBzCxMZtm+tMykIEmp1QbxotH3ulmk7l5SgZObIgbGi+wPDlWodGu44YURa7/oAm9Fl+lLa8ZD6FIXoKnD/COde9b3aw1UzF5i1szvsoBtqL0Yz9Gj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 10:23:28.3237
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76dc69c8-5082-43ae-6af9-08def924eaac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9636

Declare jedec,spi-nor flash nodes with the properties previously
inherited from aspeed-g6.dtsi stubs. Keep status = "okay" so these
boards stay enabled while the SoC stubs still exist.

Signed-off-by: Jacky Huang <jackyhuang@nvidia.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts | 5 +++++
 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts     | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts
index 4de38613b0ea..c8788c67ddec 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts
@@ -145,8 +145,10 @@ &fmc {
 	flash@0 {
 		status = "okay";
 		compatible = "jedec,spi-nor";
+		reg = <0>;
 		label = "bmc";
 		spi-max-frequency = <50000000>;
+		spi-rx-bus-width = <2>;
 		partitions {
 			compatible = "fixed-partitions";
 			#address-cells = <1>;
@@ -180,9 +182,12 @@ &spi2 {
 
 	// Data SPI is 64MB in size
 	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
 		status = "okay";
 		label = "config";
 		spi-max-frequency = <50000000>;
+		spi-rx-bus-width = <2>;
 		partitions {
 			compatible = "fixed-partitions";
 			#address-cells = <1>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts
index 29f56176e2ca..0228764721bf 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts
@@ -56,17 +56,22 @@ &fmc {
 
 	flash@0 {
 		compatible = "jedec,spi-nor";
+		reg = <0>;
 		label = "bmc";
 		status = "okay";
+		spi-max-frequency = <50000000>;
+		spi-rx-bus-width = <2>;
 		#include "openbmc-flash-layout-128.dtsi"
 	};
 
 	flash@1 {
 		compatible = "jedec,spi-nor";
+		reg = <1>;
 		label = "alt-bmc";
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <1>;
 		status = "okay";
+		spi-max-frequency = <50000000>;
 		#include "openbmc-flash-layout-128-alt.dtsi"
 	};
 };
-- 
2.43.0


