Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C68606A31C
	for <linux-aspeed@archiver.kernel.org>; Wed, 28 Oct 2026 23:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=onujBjQi
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFNR75D8zz2yqF;
	Thu, 29 Oct 2026 10:11:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c110::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793209062;
	cv=pass; b=XoNA67Xgg5xkAbEe7nh7hUi7E9gOnavFqWcAgUiIHgbqt5B9udeO0PbQpY5RQ6rdUtHD+EKw2LDZ+fnQ+z3C2mJKXWdz08ve1yGQsHU8L5PojhWN3PSshsrcJjq0z21kImV5/eJ6NAYpVid+AxKFZ7uSUuFaXZYzlmZs2p1eNj+0RyDLqMgohXddS7pqJHmQCHGsiUcobCCWrg3cpX8HEkVR1Op8R8qpTcJW5eTp7GaBlE3wQmBVe69AxkksPDWAierZJgIcRQ4HfGLipRaRrJFzhWtQFu22TXk7n0WBzi8oT5dfbzimErns7X5LpFO1ZMQks0gtk1bVb8J680WuaA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793209062; c=relaxed/relaxed;
	bh=QqXBocueU53kS/+TXcMDUKhPIuL4LBUwssRUBVr6z48=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SrAsfyM8r35dKDY1wEr5ulHfFjCQ5g6O7H6A87FXnvUa2rK7FvhXeVht/uB35QlE2YH4gEMl6DhB7SOR2IrSgkXf4wzOshI1OyZ2XFBjki4QRLtKq0DMmMH2AsUUyEXurpYNYc9r6HtZngzgfeX9QW6Ty5r2zu/CqPbVYKaibt9xCnr/xdrEnktIRvwyfhDXjY4S6tMD1QBbNuHRrWepyeg7s/D46C57lwVfVTlPoELRbWs7bIudy0MC95JZdK1ZDXec524/q+90uP79xkbSsOtdgHfpRqvEzyK29NmXBDAw2wfYIcdK2gnnQJ6ToHZQChawTEv3t2sytwmu2BwCIQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=onujBjQi; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c110::1; helo=bn1pr04cu002.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=onujBjQi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c110::1; helo=bn1pr04cu002.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org)
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c110::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFF1d47Vjz2yY0;
	Thu, 29 Oct 2026 04:37:41 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LUPhHXuQrAI6e8pBspC9WIBbTEf02HHZyDfhhi36dOzAHnBI3ZKzRblVVsavC0wn12sKGm1qvhSWemkN2G9WCf0ecSi7gGh9xtL/rD9owLCJCqDwT1W/DOXATmlP0N/NI5xp2O0H3L87ClLsRuoQN2n8M59Q5VUWrY6yr7gnijPb4K1biCqqjXPtPF92SISD/IzKEzKJNZldfR8k+b4z85HcG8ajStCuC/HFPy5c6hKgFg96NpeDYsFuICoMj3Nb0jP9YAb2SAx3DWk4RjmWza99Xuxq9pK5mlmHPpXrbe0041/yzbTXUTgpbJGifwDEk039WV/MOLJooR8urG54Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QqXBocueU53kS/+TXcMDUKhPIuL4LBUwssRUBVr6z48=;
 b=P39lfNGIMhEL/HrPKHula67Uhn1sch0s/LDIlusnJMHua64frqf68TTKJeXR06B7/INEJX9BK1wmW/xfwF9JVuXNzWVxl6rqQynaKs0BedYs3dUJkhgTchUJnDOI98STe1njtBY6/7ELxbSevqvRU3hbruGr3OPWzqVFqbg3U+ueFwTuSXR0WAyx4sYxTEDcOSJHmaaQ2Mo882PyqFbvtV1jhpJPaq7as+Vei/LFSwByn8quilUMNR9y5F7AvhTckvEaksU3ztPPaBVc/tKc99dfuP5EeR3uM93mfvnaOCaQ0n50zMlTNKYrHTfmfAt79ibFLfS7+cDRP0Rbzept+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqXBocueU53kS/+TXcMDUKhPIuL4LBUwssRUBVr6z48=;
 b=onujBjQiMe4dIzg69BXZoNOD6jmeZjylDeSCpPZ6iVXnSd612xpwKRi7sbTLrdGgwMiVfGciTHPbWL/+0jQkx6001+1/UkH/wqhahOOJ9K57PXCDVT1x10v0IivjQmVsOeN6rPEp+rVYr8NwOffEug/ZEgR+r8YYCrH1S2O3RLCvSMFLvxuaivdYenJiWkvtwFOQNJBNGKTbIwv5HiZGi+5keOlJnwCKkpTViboNufh2IpuOZgwO+o7aemkNgAjlwEJgO2ZvukD+UVI/Bd+Ktx1c3TEBowpRiJ1KUPn/3fDZr1CD8stYGkcAFvWM4rO5ZMg4YMcQJ0imp4qHNjt+wQ==
Received: from DM6PR02CA0130.namprd02.prod.outlook.com (2603:10b6:5:1b4::32)
 by CY1PR12MB9582.namprd12.prod.outlook.com (2603:10b6:930:fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 17:37:14 +0000
Received: from CY8PEPF00000054.namprd05.prod.outlook.com
 (2603:10b6:5:1b4:cafe::d) by DM6PR02CA0130.outlook.office365.com
 (2603:10b6:5:1b4::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 17:37:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY8PEPF00000054.mail.protection.outlook.com (10.167.247.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 17:37:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 28 Oct
 2026 10:36:53 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 28 Oct
 2026 10:36:50 -0700
From: Jacky Huang <jackyhuang@nvidia.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley
	<joel@jms.id.au>
CC: <devicetree@vger.kernel.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<openbmc@lists.ozlabs.org>, Jacky Huang <jackyhuang@nvidia.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai
	<billy_tsai@aspeedtech.com>
Subject: [PATCH v2 7/8] ARM: dts: aspeed: Declare SPI NOR flashes on remaining boards
Date: Thu, 29 Oct 2026 02:36:14 +0900
Message-ID: <685ab598d3d5e2bea63024b5d4940a2e027c2043.1793179064.git.jackyhuang@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY8PEPF00000054:EE_|CY1PR12MB9582:EE_
X-MS-Office365-Filtering-Correlation-Id: dae93b85-de45-45bf-24fd-08df351a1aae
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|82310400026|36860700016|11063799006|56012099006|261009223027099003|261021121427099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 O1Ix3L3bJp9T2810qoVT+K9tlXa+yqvMMgwdmm/8YGm2/2mLnDIjZLU4xJejCao/od5H376oKbfBY7FjbY6J7q9kZPIEgS99fwdaKnrstTKszgNyfqBz1J3SNL/OsoiZMS44995nQALpV5ry0NSl2ZrN0HS+FGDhlyKlI5HvMtUsUPYTwU6N762eK3DFYns2xleenMsgCLlk1WQqVs/Ejp4vCQvzN0mGNeZHyE8yxv9DTjEplH4qSl91ybyczeyZmxij89tvvlv83vaNZJFYpXFNGZZCPEAsX4G2nrKYtaPrOt4vpleapyH7Rvmk92umZ6P418FIE+vDcQxYRkvizj9qdriWo0CoLWHgoxZvGyWGDFZ8ymcDcV3ZqVHQFRm+EyytD86XBu0LOnzsQWvdJ2qB77uYBLzcfDp60qQ4iWfHJskFplGJ6jJqrMb9/8DudgcbyxZOdXnTJanC3U2+OWqp8cbg1NkIoHE7QbEGKqf9CiaLHKo97IwHEpwfgnzVDlDKBGDJwSGnx4DBxeNEqw1njKCMzUC9oFGTq21SHNFzOVHB4C313KPPUzkKNyg0py+i7SlnLCOvNBcjXlpYvgdy4yj58dqjsFsDBPKy2+rA8srXws4KWljb+90j9bxq8lCWjjayFe9pdZL+oJ/cZsPiyZRv4gl+SR9wHbNyKp9lZ9y8OmxJRUpj+AOduLQ4FEsl6g4047UDEzI8y7UKtg==
X-Forefront-Antispam-Report:
 CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(82310400026)(36860700016)(11063799006)(56012099006)(261009223027099003)(261021121427099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 7SI3RrUf63EbY+VOe+NWjSO7lE8JU+MXVWs3fZW8G1Udgp8koMVpGSX0u9AO75Z69U1ia8AjZ35HtsA7YDnhtO7a1sHUkmze9MC330zY74tcW8g4hsazylDvniN9wf6Dsh29GRokyqiJrfMI0ohE1D/ERexutYDZPee2Wn8eqb97XFdCMpp9rhzuuGT+x4HgQtqhLQdmK/OzB1e+u88A8D19wPhmZhaSHtjga+1wVJ6EnJ7yKf7gsJgArjQBPiWxgN4zeOUqmtJ6sE+4NImtQo2LXO/a6d5/yxCUL4PmUmqqDw+HKwFfkUWqWiqsBh+atDx4EcBUfgTK3f7WNQpkxJT486WtDlPNFh2pkaTZ1l9y4eujAn5VvK5777sn2U7u3m+nt/EP8pTz3XWQgjHd1S4knmhxOetMfClNAXQmugf8pUzNU8q57usJPoVAuV/x
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 17:37:14.1580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dae93b85-de45-45bf-24fd-08df351a1aae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY8PEPF00000054.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9582
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index 3f2ca9da0..38f8d7c03 100644
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
index 259ef3f54..882b68248 100644
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
index 864512278..70791b3c0 100644
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
index 7ab29129d..d8f7939ab 100644
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


