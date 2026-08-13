Return-Path: <linux-aspeed+bounces-4725-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 179CBC5DF67
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Aug 2026 01:11:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLkh4150hz2xyk;
	Fri, 14 Aug 2026 11:11:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c005::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786616644;
	cv=pass; b=aDxVi3ZQevoxwx5KzYkjz9CYiwP+fY0JKROqnVaODevJltR3Jo9moWoTGkycIxRUyI8gK+WOd/XFLfAxINtSFkGXp6GGSHaGB2+xbjd8ZZirPM237J2xt3FrqrisHXxK2CFwqK1qBPqUDakE+nxLN9cNKulXH13w6MVQJb1XCZd653MhAKHoL6y/yjSgjR4hAQVUy5zNJxQh4EYaafEysiBg2cGX9AxhdRZKP4pgvwpsiRTQR2eWjz5AFNZa48JAqKcGNrFm3jhl5eXzfaMmiZ4ljuHcJoRtUG0qbrYtLe+sYEZkrs9xa5i+8aQ7++EejgtEFvvZfp4ZZpi4oXwqQQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786616644; c=relaxed/relaxed;
	bh=v/2i4P8CGRhuM3zoa4ua8EG/kR830HFwDvJHIuR7MqQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ki0yXTHg/oQhAaEHEzzuU7cnIZ/Oyyofns/k0M26TL2Y7MAwGseAlOWCsX2q7HNW0/C5ttxmmqVCbpkEEVZhwr+On2k9f5YiZkRtAWuphVpA7eCoSjlvJrfhev6A6cKjd7NfkvOyEaiWkaWnzdbuXH2Jm3nmklkqJmlgdIpohOwpaqAvcInhJPS76d0W0sz5aFXoNOfy4Sv7cQxCF0+1Rif1RzSQi1AeeiuS+k550sZxJTdoI2WM+QdDsMCHoFPLHgXzn3Rk9C79UZtodoUNRwrGdtf7j2yCSeE1VFbnmE9ltlblYporvWzACiORWOAXw3lYE5GLUoZEzVoBxv9XwA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=afAYetcM; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c005::5; helo=co1pr03cu002.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=afAYetcM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c005::5; helo=co1pr03cu002.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org)
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azlp170100005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c005::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLM0M3BR1z2xyl;
	Thu, 13 Aug 2026 20:24:03 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g60w+w1BySBLq/Po+CAbS7RcnTkS80crAKiRJeJtClI31su7lKOolj3gcSktqB2LQ3/yVb8geMPdu3rbtwGakqaSVnC5gXRqL/wgDEYgC0wLW2kf51Iaf2JBtD4gUvifJOvWTrCZpoxaKAVZCBuxhOogm/du1Wd4pQxDCyaU1wba0WmydsEWCJ9LPHvdF3/uZKtfgc9T1XBrEK/RDrLNnnOosKhP9z9rCEfuQ+wZp8UlWzXQAiSCFK7oN8mWZdIq540BKT4cAA0wb8V2K7XnI5mJsxgBHPIcP8QpmmLWkMA/IHXjoz1uMtsPB8Nu5MVfQgOlODjEt/U1uoHgXUgGKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/2i4P8CGRhuM3zoa4ua8EG/kR830HFwDvJHIuR7MqQ=;
 b=R53mLbIhd3u1+6ESYjwUCNej9VJRO9RFqFHYaQG45KYe1Hkg/hx5DHUouwO7Bk/uCrk62Ipbo3RYi9ky+m8qRRfdHhShfYHu2PMNXAV/weeCHOcWrHobe2pdiNQGLd5MR5LrLIF4OnxCFwtrlJcL6TBehQplpmyzhbmqX+2Wo/dI4ED+eGMMJPAoAncHM7uVnLKuB0AJ/bYNmnQFm3Y74no4TMpUdTDEujhzQ/ajzRscIhUhhegA76e7eltbFJUZgcPWYrnhJXOCv5dNgmNpH6Vj3T/+JrEeJase3w8asthqMdL8KqiNjt9yS4UaU/wiOnFfDtjW/hBGzDjn3KXtUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/2i4P8CGRhuM3zoa4ua8EG/kR830HFwDvJHIuR7MqQ=;
 b=afAYetcM2pUeGaQnbxreE7mHLcoMgHNyXH96C9LEM7tNnTbfexSSJePAt+GqxlRJtYjPNArjWd8+LLydML5dklE7/N+ycijKLokMiSsovy2840WCbq+8of26khhjwotgqxlIXbJ7XbfAZ1GUllreewfSppPspLqsSH3rtmPp8u3qnM7xaHC92mogE/vfu55KVL3z0LeKINxhM66NQTdOrS3Zh5wfknSXV69XDv8DD2M47aOc7Dnuz8dX5pW9sMRgAPvzsaFlHabXsyBpIls/oAQn3pCL4cl0FaSlrw3HuxVo+WJe6EZyFSAQc9o6GfsYDNDqggNQxnvI8YPigXZPAA==
Received: from CH5PR05CA0020.namprd05.prod.outlook.com (2603:10b6:610:1f0::13)
 by MW3PR12MB4346.namprd12.prod.outlook.com (2603:10b6:303:58::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Thu, 13 Aug
 2026 10:23:37 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::9e) by CH5PR05CA0020.outlook.office365.com
 (2603:10b6:610:1f0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.5 via Frontend Transport; Thu, 13
 Aug 2026 10:23:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 10:23:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 03:23:23 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Aug
 2026 03:23:21 -0700
From: Jacky Huang <jackyhuang@nvidia.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley
	<joel@jms.id.au>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>, <devicetree@vger.kernel.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>, Jacky Huang
	<jackyhuang@nvidia.com>
Subject: [PATCH 8/8] ARM: dts: aspeed: g6: Remove board-level flash stubs
Date: Thu, 13 Aug 2026 19:22:33 +0900
Message-ID: <20260813102233.3088939-9-jackyhuang@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|MW3PR12MB4346:EE_
X-MS-Office365-Filtering-Correlation-Id: c1ac03e7-ac83-4f6f-8255-08def924efd2
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|36860700016|23010399003|7416014|376014|1800799024|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 K7dRX/RyhRyoGD3nsEM2cH1Z6NyfEDKh/W+NCpfS0ws5j4we8tpHERuRmYR4JwIaeZPjg/TfN6Gvys8qeGQsWi0XX6cdvxQsNasq5eS8GExMCFaT8dElsZaCZNzz6losHf3DqdsMlSfLkSZvTMT7ZeUY/4ufC65Ic9nPsvwm9CqBjCs/aXluFKbNu6XvGhkfNMst94GgARQ3YpPimmsLq8cEMP2OXTDcA/SYnxi6l+LMca6/JMP6EzD+Ve3Z2ax92kgdofjdZyiw5wbXjt9ep0HXFlfiP1TKxZxLzdWcmSweN1qYYOKe2acHjQdM0jwIK3QH6LSph8BiFlA/cNcJyv2Z1XnRakTMiJZU/9/qj2JcPC0twgRS1vNG8yOjGVcekOp2eV32dyK5+WppWtqYdHIojQglgMfMhQBas24tikmOk+QfwHyoTKYyiOeaTV/yOA2P8wOMrVR4logzvOfjy9DQWSrsnWMwozNTFm86lqNgAhM3HTQK9tfoasZzy1fDX3QD+BPijaHniSBQM9XUSc1KLg6DZEm5cxWitVHvqTDylnn5NoEYMwnh1oaHNfhfvLwsxRF2n7f3bQ/qQkBugl0+o6yj2kTQF/kAp4gsUVSM5LPpF4v1W+S9S4LRx7Bgyi//aPJRQSeT6ibO5QtGZZyW0RIJTafnU7sA/XU5Ji1Tu6Z2FKst2hmiTpCbetVBAyVk+ZOczU3jcMUHY0FIQw==
X-Forefront-Antispam-Report:
 CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(7416014)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 az7FLPFEmdOK42U+exp2XbuQt52zyB64LTxn0YdeDs3+hmLNM+pcgXsKVD3jyFc4Pehyw8t/rsZhCbwyHeyEX/L0hyYAqnkntmOWc9WUKgW+wvSrRHJjyelbjZKzLukSzIcILheB2saq8cluURjhfC6cEYnmuxX7Rx+0wepJC3g8Xpua0lK/GxXGFtwi2gdCYFBC4NhsBcdhCJ6OnY1PVHnNu9qH/ehL2wlgCHozYd4LDaJvtx4Y/l4keAbwLwED3ZJpEViE57InY85sbqHNB/S4GQp5Vf+sZdIZZbqQjRC2JBwKOvkqaSGdKsBiL1zKMU/xJUXeaJJiiQ5Rvq54Y3+M/4QPeJTYzRFvERaY3mgNbIhZ8P2+i6fvQRVZitHT5PLoBspIRgVhTIDsL16pEqeA2YAusk9qV24Ij87kGtmSIInIG5yLfgWsjLbohtCc
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 10:23:36.9494
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ac03e7-ac83-4f6f-8255-08def924efd2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4346

SPI NOR flashes describe board population, not SoC IP. With boards
now declaring the flashes they use, drop the disabled flash@*
stubs from aspeed-g6.dtsi and leave only the FMC/SPI controllers.

Signed-off-by: Jacky Huang <jackyhuang@nvidia.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 56 -------------------------
 1 file changed, 56 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index edf4b74f5aba..de705c544847 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -119,27 +119,6 @@ fmc: spi@1e620000 {
 			clocks = <&syscon ASPEED_CLK_AHB>;
 			status = "disabled";
 			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
-			flash@0 {
-				reg = < 0 >;
-				compatible = "jedec,spi-nor";
-				spi-max-frequency = <50000000>;
-				spi-rx-bus-width = <2>;
-				status = "disabled";
-			};
-			flash@1 {
-				reg = < 1 >;
-				compatible = "jedec,spi-nor";
-				spi-max-frequency = <50000000>;
-				spi-rx-bus-width = <2>;
-				status = "disabled";
-			};
-			flash@2 {
-				reg = < 2 >;
-				compatible = "jedec,spi-nor";
-				spi-max-frequency = <50000000>;
-				spi-rx-bus-width = <2>;
-				status = "disabled";
-			};
 		};
 
 		spi1: spi@1e630000 {
@@ -149,20 +128,6 @@ spi1: spi@1e630000 {
 			compatible = "aspeed,ast2600-spi";
 			clocks = <&syscon ASPEED_CLK_AHB>;
 			status = "disabled";
-			flash@0 {
-				reg = < 0 >;
-				compatible = "jedec,spi-nor";
-				spi-max-frequency = <50000000>;
-				spi-rx-bus-width = <2>;
-				status = "disabled";
-			};
-			flash@1 {
-				reg = < 1 >;
-				compatible = "jedec,spi-nor";
-				spi-max-frequency = <50000000>;
-				spi-rx-bus-width = <2>;
-				status = "disabled";
-			};
 		};
 
 		spi2: spi@1e631000 {
@@ -172,27 +137,6 @@ spi2: spi@1e631000 {
 			compatible = "aspeed,ast2600-spi";
 			clocks = <&syscon ASPEED_CLK_AHB>;
 			status = "disabled";
-			flash@0 {
-				reg = < 0 >;
-				compatible = "jedec,spi-nor";
-				spi-max-frequency = <50000000>;
-				spi-rx-bus-width = <2>;
-				status = "disabled";
-			};
-			flash@1 {
-				reg = < 1 >;
-				compatible = "jedec,spi-nor";
-				spi-max-frequency = <50000000>;
-				spi-rx-bus-width = <2>;
-				status = "disabled";
-			};
-			flash@2 {
-				reg = < 2 >;
-				compatible = "jedec,spi-nor";
-				spi-max-frequency = <50000000>;
-				spi-rx-bus-width = <2>;
-				status = "disabled";
-			};
 		};
 
 		mdio0: mdio@1e650000 {
-- 
2.43.0


