Return-Path: <linux-aspeed+bounces-4720-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8268C5CFCF
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Aug 2026 01:05:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLkXq35Tfz2yrW;
	Fri, 14 Aug 2026 11:04:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c110::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786616634;
	cv=pass; b=DgvQWEqHCVfizrKA22TcpHI68wtva6zBCvhJnwYH5oFHBcYrKnKSSfuGxukYJtTFmBi8mWlLxXB08M/7bQONA5OmyFS08m2631ZO31wdnu2hryUIbCyaXHH419hiMhcPmtkkLpefkcOqTvhMmxriIaXT98Ot/XaxGbH0nglM/H8Q3aSPZL5PznbI4XXgN2vzTZCbPTKL8vZxNU+BLoDKtIfO/UuoseYITqAw92cszWyFeYSKBy06eMK7T6cBVgne43SUMymxIg79UbQyr6QmnrTbM5U5LmoCLOxj6pdrQAEQd2QMeONH/YVlaxA6FSg66GK3rcG1JetUKdBCBmBt6Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786616634; c=relaxed/relaxed;
	bh=pRcBAX5gHZTkjKW6bEA60cfRVbw8eYq+BgSG0rpxf04=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j9eYk75KK31YSx4lboGfKq+5M1ZgTOqxrfLHLayOTg+QTNGIfe1Xz4a6VJpPifyCZdYQ04DYODrSiX7cVzrmi2fAl4afp7r81x4vEDirsMRG0NvkKItkoWFd/b/P3y602AMKyuzGRmXP5x6kWuHfxqzRBaEVIuPlaJubXa7CVPxoHm9SVtPyl/AMewD6/5YTUfr2IgymyJSknWN38QSVhC7fKM4M9HpgmrcBWPgySHWUDkzCgiK+/6edNkOq2KQwEAllKm+t8lfiriRCdNEU6Bkhypjxx4nP9YfnkKRWPfmtA3EPToUt24LYLH4bqbXMM/iuG4ww+X0JZ7ezFtZP1Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WnS4gQ28; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c110::1; helo=bn1pr04cu002.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WnS4gQ28;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c110::1; helo=bn1pr04cu002.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org)
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c110::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLM0B1Rhnz2yl0;
	Thu, 13 Aug 2026 20:23:53 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4bIhnEBfLs+DgbHnx5NewWwB+hYLGmjsTgXvTbFWIt9GcYP0TWktn5EpyAV2OzUdOLwMBNW20vnMxJkXYApoKIT1TzhItB+Un/bAzhDWWbY3eYpfRcCh68bsLqEqDv6Ojtbi9/PT/CrBI1ixnNRcJecCkF1oCfX5v1AjdgeCxJABU2bGc/Y7IrrZ5Mzzam3+mED8LKx64BRKYS7tuwOyv7FC5TwQyc2Y8rANkO/Bq/qYW1htkeD1i4vJ8OepEbD7AIUKZM6aIImlDIjdUMlqsv5N0fORLts9TR+zGL//iC/gIeICH1DYjHgHck7M3tSLuk1L1pjQP+eSoEkthauqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRcBAX5gHZTkjKW6bEA60cfRVbw8eYq+BgSG0rpxf04=;
 b=hoK4E7QjQAMITbLyY1akLSusU9FYI07ATe6yh3AAJp3K/dDkhlZJVzc7pRa3BfVa+aBov5E1kO46R5DG/2n+QW8jyiiqirem4UC2z3LP/MWZPWvCwxmN73K/oXIdjsl3u4IuarKHyrbDCzOB6RRJd+F+HO5Jdanu7vVAn00dy2WLpiR/CUklSbo02BO/utvtJNZIAG1m8YpcFYfGkjgtFGdRj/1gAKXa3xdbKZyXG+M77vFg1dMkEBULvxUf1V5Z11HGM34Au+RQPoxOUhdH9H1YLTtt7pp79VYp+dteeNy1JzGOZEZq9FQmwen1xwhnV7+D/u0Zw6y1Y/3WETaY0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRcBAX5gHZTkjKW6bEA60cfRVbw8eYq+BgSG0rpxf04=;
 b=WnS4gQ286vJk9FP09lIYK/GAlMJyHmiK6+nQnn7efJU7DFkDYyWC8+gqlTwLOLAaUoIaoRkZ8h+nmYVpY3//J32Pvqr+NaYZ+Qu6czYVRQaZ5g9Z09zfmVTgh06lwpmVRpLUE65wybE1pb3o3KR7hvBJQX3oaZrX/QFe+pm9JC0Li+5k8Z4wFJbp/dMTNCd2S7TfHeni4ugrglsX9HbjOGWPGyLZsLCned8s9PNJ4ZsHM1SW7pdLi56jUgVF2d2mAyQZYfAdkgGiJgDVCWumFmPplDlhPzQcGRHFXmUNJbL3P9QUrIEvB0zxQxt7Q7/ymc8krPADoCjy8nhZznxCkA==
Received: from CH0PR03CA0076.namprd03.prod.outlook.com (2603:10b6:610:cc::21)
 by MW4PR12MB7166.namprd12.prod.outlook.com (2603:10b6:303:224::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Thu, 13 Aug
 2026 10:23:28 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::2c) by CH0PR03CA0076.outlook.office365.com
 (2603:10b6:610:cc::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Thu,
 13 Aug 2026 10:23:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 10:23:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 03:23:13 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Aug
 2026 03:23:11 -0700
From: Jacky Huang <jackyhuang@nvidia.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley
	<joel@jms.id.au>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>, <devicetree@vger.kernel.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>, Jacky Huang
	<jackyhuang@nvidia.com>
Subject: [PATCH 4/8] ARM: dts: aspeed: ampere: Declare SPI NOR flashes on boards
Date: Thu, 13 Aug 2026 19:22:29 +0900
Message-ID: <20260813102233.3088939-5-jackyhuang@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|MW4PR12MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f473a03-375f-46d4-5f6e-08def924ea5d
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|36860700016|82310400026|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 98EGf8VDHK6zRYqDRrSwMgNBBxxF81uNmC9XPNbJsvvo3DXCIE9Kmw6vQpuHreu0MX8XeoYBU/qq6wqfPbLanTdZrz0UlDXQakprP14NXt/WH+2C46Twg4zJCkijELvZdOQHnXMc0tju60S0RCjPpWrHZFgR3WXu44eABWoO726I/sCJbGHBjYbRa7Ql9wmr5JR5/xNNU5iM5Sw6zBuwJUgFca/ZVpu7CIFDg6X8P0p/kKRZPMWx30Jv8EUi1IcukhdMjgos42lOjs+vk+fjUX0MOvpYDFTRNLkSxYmrC/T4Jv7kQgUWsVZYlvA0CLrtdzwtTQ35KrmKPYAb82Mu3GioNrbLTNqAEgl+Fu/ODMqmcfbMn6k4n1YYoXMgXkLQFacp2khUlexfUw6qyZpY8mChCnO34TJEf4ipAUqH4EF8eP1Id2hG4tUWAzRWITSoqlfDZ2IVehKl5rPI5sb8z31CS/mPOsq7UqBhs69jJpMAZYOks1s+iocjtbnx4WSbwin4fTDZm+dNGOO2fw+6bGu7IyK5vnnCdhMGbxi04pG2kuZPE3RIHROe1ajEP7ejJnRoOjJR+AB1M4OMf1tn+pfh3ZmjZgLA5vdHvgMjXxIsCRFLUqQBoSkcyfSMvaq7dAwRMICy/n9TCDL0zR+/TEpXyvBQ25/lSQeoLo1UY9ogQfEW6sgDtCqWz6zjx24fJ32YYd8wjobPGTFqIQisDA==
X-Forefront-Antispam-Report:
 CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(36860700016)(82310400026)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 0yiGS5qx/hymgCFsDGjoSjUhDNp8uV+oR0WNjhlSi6oqSQR0PB8rSciZQ+GfaYe/s3ehI4beNdxi+L0Xskiq/b9/0Yo1nWO/lDWSwvqSUxnnSFGYhItQ6aQkcSYY1Q0MrXlYA5MtuTws3+6syc0Lv6DIKWgWNDr8J2Ln8NDpS1N8Mzm04lzgFrYMcdHYbouJTzBUkeaiO7WCPYmrMwDr5sJsMYH2oXr9JcxYyTHWKi1xmRxd6sjXKzoVwdpepMUEBPBo5SKGwAQKBOMJmyGRvoYVrNQyCRtunc5DFpa3kvmrdNivQ6g5YfVNA7sUJQFvuHBJmqzR4XJk2G1zArTsnWJ5wX0yZlIHPgiLMi+0gRy+Qkus1TymJLbdno/kC+41bGR7z29KzID9vec3P31GhGqRO/4ElLsY055do8stOe+VWP5LfP4c1DxzB3Ds7x9Q
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 10:23:27.7760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f473a03-375f-46d4-5f6e-08def924ea5d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7166

Declare jedec,spi-nor flash nodes with the properties previously
inherited from aspeed-g6.dtsi stubs. Keep status = "okay" so these
boards stay enabled while the SoC stubs still exist.

Signed-off-by: Jacky Huang <jackyhuang@nvidia.com>
---
 .../boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dts    | 9 +++++++++
 .../arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dts
index 53b4372f1a08..44332d1ba9f9 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dts
@@ -149,18 +149,24 @@ &mac3 {
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
@@ -171,10 +177,13 @@ &spi1 {
 	pinctrl-0 = <&pinctrl_spi1_default>;
 
 	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
 		status = "okay";
 		m25p,fast-read;
 		label = "pnor";
 		spi-max-frequency = <20000000>;
+		spi-rx-bus-width = <2>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
index 2b336aa0146d..cd7cd012d295 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dts
@@ -379,18 +379,24 @@ &mac3 {
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
@@ -401,10 +407,13 @@ &spi1 {
 	pinctrl-0 = <&pinctrl_spi1_default>;
 
 	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
 		status = "okay";
 		m25p,fast-read;
 		label = "pnor";
 		spi-max-frequency = <20000000>;
+		spi-rx-bus-width = <2>;
 	};
 };
 
-- 
2.43.0


