Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EED3606A31C
	for <linux-aspeed@archiver.kernel.org>; Wed, 28 Oct 2026 23:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FVRPzWeM
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFNR52DwJz2yY0;
	Thu, 29 Oct 2026 10:11:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c005::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793209060;
	cv=pass; b=jdXpF4d29YiN0NMCiXtuoDvq8Rg6FP/d+qmYJV6JTNzZNxFR6ANgcctTT2IE6SNmKEMeAiWiAaDX59Bt9cZIU3GeCm7reonEhnKlBWycdsgIyDzPiJV4tgHTycVXBLEsxe3yeaXrQeTzvjhlmqyZ+eYCyARO/OlijoXFqKXZgX9k0HMUer4KRgFafrctnL2V5CNICtiQPYODcDfBDY0oLswI46sShCo2+8jdzg/o7wBlylDEyTLJrOKs4YDF9XZDWvmh11ivnHhmaRdP/dzCEFFEpDxpv05zUClYW3qQjJPiyLCip+0TsfBfKCe+Pld13rjhae/WQabLVCO2ibbJmg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793209060; c=relaxed/relaxed;
	bh=fVaK4ADZfTpFy0KBC1SZQYE5drO916vj+ZhMklXVOv8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X1EUyyjP19BS5cO/eDsN1C5Q2eBi8dvqsTd3zw2rLLcikDARPPY9sESa8PX4TE3NpGj7ahskmj0UtxMhL6O0VVN88uAotubaP4pXU5YR9NPJDktGJqm8HQrf8bfWcNZ7lMGIf3LajsXQ9eA2YMfR40VAh9nxj3vbP/n8sZwRTZRQy3gOIVoM9SfO8Uru0+aa6Hc6jTlmmAv6RF6CauQJtbPG52zsU8QvhkGYNSrmae0Ob2ecWklOnkQXwkHzwcZux9UfA+gwOH05je5CKJ4McxDPbixmq38EaqhmRI0mmQkK/wcFnXH9N5cema14bw4NJdB5a0wrPynPvRIlB/zcsA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FVRPzWeM; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c005::5; helo=co1pr03cu002.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FVRPzWeM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c005::5; helo=co1pr03cu002.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org)
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azlp170100005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c005::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFF1c0WNfz2ySl;
	Thu, 29 Oct 2026 04:37:40 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oui9qd4DjopTKlt0/zG/NfXXT2K7Nf608mRjc+O+QHBnRCXGnt0Y5S3++8fre1aUU2rJnV35XU8+w/0owRjabF+bi5P16gjRnTn7hKXUVYaBs9cEfHEwO4LuezTrEWS0X6DRAC9a9jbQHC/YYuwE6sBbI6n51VVc+O9MzNYKY8IXdEQcQ9JsjXn4Gy1KIDMqssUTLW03a81aemBUmmexmnKovgF61lftW03kxBIau8QzTkbrAOg/hKa+s2yXxkZRLqoH8tKBzN4Oa8+Sj2XP5jBWlvxqWFHILyz7LKlXungUWNGIgyeTLmSwHoYcvacqHMAHWuxjhxxY7hYN96eA7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVaK4ADZfTpFy0KBC1SZQYE5drO916vj+ZhMklXVOv8=;
 b=ZdXQ0uOGil9mSgmHuCGvyEynq9vIsktNGI4yDESk6++j7CYftBelSaL7sWRl6jvGdhoA+09ABhjWhESiNcY+lgkducPyXdRY6z9nTXeWjdOCq6xdJGG46CtOJ8sVXPKTFWq/bfNu3oJBxCgWdEc3HHMkdBsrkfQ6tPV/8holCz3D6yExPAmkrUQamhXLTQLhoYXpUtvu4GulzdDBcge0c96oG+x9OIAtnnX/adzb2FSYMyedFPX5vy+F0VUBeJ/0/AXSiD8yd3HsWBcjWRMRhC1Traj8SLSZTNFHf9tB2cW3//7NwuqijnOPEllf3ke+Vs/aUTHqC8yua7Wfyf5Xlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVaK4ADZfTpFy0KBC1SZQYE5drO916vj+ZhMklXVOv8=;
 b=FVRPzWeMxCDls4h4XCIDNqGLGyD9/Gl2suZFQIRmgiHd9IxTv8q/oCsqKoFtpdXvkEmSMlkoYbe5jsIj28PrWVoFqxErSB9sIX9oFBWHOMGOiG4m0Ck/tGIpCRzXsUHHOfPhh+gGW9BebQL8UHxmtlH1jSZYO/Vdgs/RTwqlD/KboGV4J8p65AndCKDMazkxYqVzD6QrUGyDJ2m9ZKhSkkst3bAFJeQEIHwSTHVX8rR8phKdmjmgF00safpdwPg/VY22SSz6oRM7JLi+JeuV7kJG4zvjHrRHJnuoy8U82NQCdUbLt2u4ebdgQBxV/BS59S5Bt/OZ5YuBri/G2OtRUw==
Received: from PH5P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::12)
 by SJ2PR12MB7824.namprd12.prod.outlook.com (2603:10b6:a03:4c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 17:37:15 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:510:34a:cafe::62) by PH5P220CA0007.outlook.office365.com
 (2603:10b6:510:34a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.7 via Frontend Transport; Wed, 28
 Oct 2026 17:37:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 17:37:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 28 Oct
 2026 10:36:50 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 28 Oct
 2026 10:36:48 -0700
From: Jacky Huang <jackyhuang@nvidia.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley
	<joel@jms.id.au>
CC: <devicetree@vger.kernel.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<openbmc@lists.ozlabs.org>, Jacky Huang <jackyhuang@nvidia.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai
	<billy_tsai@aspeedtech.com>
Subject: [PATCH v2 6/8] ARM: dts: aspeed: inventec: Declare SPI NOR flashes on boards
Date: Thu, 29 Oct 2026 02:36:13 +0900
Message-ID: <fe591a336ef3e4aced8dcf8df9f14c4899b0b217.1793179064.git.jackyhuang@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|SJ2PR12MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: 570083b4-f68f-4b59-f51b-08df351a1ab3
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|36860700016|82310400026|11063799006|261009223027099003|56012099006|261021121427099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 nLJMtpNl0Tpo4DJqgrjrO6lAsOUl+cI2dJA/AWcLvLzaSXwIVSVvAeMHidV0NpwisXjCI8AXL4RYbByaBuZ0ZqQzJxs0N7bS4iKZdmP5/tS2TOfgdZKIT6UAUclt1LkBeb0WvahFh3SlXec1SJFC+tjfM73L2RQRqXfHhAU5N2l/J5KmOYU5db57uBUCJ/hU4XZHfDB+zdf1MPdpPa5tvw02aLajs3MwrPr62baP8WwQ658lCcvB5K+831NbResnOdkj7UXtHFnaU6ygEA8DJjszNxrU0ROMBlBhm7H5WP3APfG/dFNH9AuIwhul4tN29kvW1fEWeC7vrL6Ev8gmBDG8gztegAUTKbRMtoTUnsXmDRimmXm4zCECm3ce/rvN1GaKNw3vib88GeMhVLriliqbiSJ1Y1SFCpxK5NEVXLvLxfrrmTHQiS4vkZnCvoLUacci4lbeFNyrhlr8Xey7+t5rMM/hxQj/ae40d3KWbQH6eCRfUdfE6pOd5At3FzRJ5vQMDsg5fWsi0Wzj7p85wJ/rK7nhpmhQ2wtNqyrlQRAgEPW1Nddz0FK4MAjMYtvYcBvg+vqhOchKY/7/GT9u1LuCmbfugkZ94JMeB/OluKqn6Y+PQVMVfIBGK1F9CBLI0kMFcOzH0lJqYTXWbmuqYttAIt4S/dkl5d+q3ZINZ+xicIxyyGRQ60q8EMP35fqhERTKR023IIu862yM6ykAuA==
X-Forefront-Antispam-Report:
 CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(36860700016)(82310400026)(11063799006)(261009223027099003)(56012099006)(261021121427099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 svcLh3ujUUqTjyOo2iOVCHaOLd2c/G34uEq2wGv9mLnMRDitspS+73fDKnL49ilVNYhMIR0UXXCMFbnETxh8/+mfX+WvfUZBNf9iXo4PMLtKVjtVIeaLoKRIXqmlwT7sx0g6UWUnYvrHvMSdxMB/c+WckI+9QljFjXsqERHXMgEfs4+G+srM/iENEeWvfuOK6IEKdXbiT/qUghpQLRA3ofaBVwPWJb4oW2Rvkrs0iUz3X0qduJvfbKEBP5tbjWG62OIGW3I1ozhVvdXANdSu9cNoHnXRpViH1vzfieJmY8HLuWcK/ZjphVLRjaNAfi+4hly1+JtYdglTk/Seu8jlJUTtnLHxySIdhTwZdnV6S2ZPtkAUn7RvfYalRf5cmpMJNIARtsu3IWPq21jdyxwEyYV6fV2F+EJJyo9w7cmJbI0io6d+DdQq5XciC9nXlq/g
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 17:37:14.1841
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 570083b4-f68f-4b59-f51b-08df351a1ab3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7824
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
 arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-starscream.dts | 6 ++++++
 .../boot/dts/aspeed/aspeed-bmc-inventec-transformers.dts    | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-starscream.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-starscream.dts
index ec82af94e..0bb3c6ab7 100644
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
index 45ee0f2cc..35f28799f 100644
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


