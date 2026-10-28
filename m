Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374AD606A31A
	for <linux-aspeed@archiver.kernel.org>; Wed, 28 Oct 2026 23:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=dZ83+HfF
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFNR42DLcz2ygK;
	Thu, 29 Oct 2026 10:11:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c001::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793209067;
	cv=pass; b=Alh236rhlUTTuVduzvcybjb3QLsI/MIUmTKTElNTrVNbeeAPmwyjelNohhn4nPmM7GScp/T3C0Z6jZ9vVd5Qb+IOQvrAVGmHQdD9oF0RqtJzFDXwklvp2ODFF3tkEyTJdsShND6dDtdv/Yvy58FB/k7jn7ggYJgz80ADTbP+ar9LebkXse64I3wXdFQZPKOsDIyiEAL4lq4PsNDDsK6dLqPwg4IWWfPKKVXjSEo5lv2dbmGgAxnIRSY7ghLt1ELpWm+6NKJNIUjs0cphuumMVNY0745T72Pu982Iu455sJVN4BHGt2BpqSdDUXQjyr5z14ZpQEIXaxRECmyH+MNKvg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793209067; c=relaxed/relaxed;
	bh=VRp6He+df6jnk4yVbTrWOHfgNaPmnw08rHN3iaNftp8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bbVah5Crbe67xt06iuAP3wFpsMGY7VvN99cSGL5otr2EXOyDyhd/tmFaSWAEzVJ2ivfHC2C7Lv5QOOaMRgGPGB5joMnqVCdl4SN2aYM3z+DhjM8l6FvMEppjRX6tzAadgg1bV7+EyZa6mOiEi0TJBDH72c2GiRkDHFTsYokKVuZ9w9XL/s4Vt5y8+nYNb5WgWhewxMVcO6dC6o3ANoh6XXjwvi76lwYMz23oS5mexcGB3NKI4QBJK097y6gUb3wc6a66vz/7fi3XMssGHolVVo9TurpEDJbM9ZMfSaxrzFW6f5H/lzdEeznNIfkIRhfZvpYr/ix4N2p+7cAY2YClMg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=dZ83+HfF; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c001::5; helo=byapr05cu005.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=dZ83+HfF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c001::5; helo=byapr05cu005.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org)
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazlp170100005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c001::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFF1k4FVTz2ySl;
	Thu, 29 Oct 2026 04:37:46 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c3MQZr9tK6oIOeJHReyq20lkKvK6dN+KWW9YoHqryb4i3WVCsmUtaCGignzit9EvbNeR3VrZmIxcmSQ1GWDqVQMYDopppEaiw+UpMnyrQtUj1rIm8+o5M2c3rlDMk4ugi2mHBk6XlxYBSkeRte4CucSnH+k6IzlMtIw1z121dGBxFIsCRgzIz9lNoOnLo6DNNgG5OOLpv9hNhUvvDPSpaRuCc51TNXb04BDITAx4Il0LHmmSi6MCevNrUkDfxeGF7dyxPHTG6o4dVsSh3YaQ+7QsX0wq/eqYOneyduBxByR9Xqblg9Nheev4n7o3bqlgL2BOOqKwoa5Wn61FF58VHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRp6He+df6jnk4yVbTrWOHfgNaPmnw08rHN3iaNftp8=;
 b=RbYzQ6HVFO6S/iQZEVWEqBLmAEyrUUBGGBv1Nq4WpnfBtJ4J4NHW+nykfXicyIGejNxm8X1tnPZL3C7bPK9h5OJfFwCGy9fI+dfJ4MnERsXASiUDVvLN/uMZsWy/1WpE29IOzvOPQWC0ZMRxjQxe+4xe5/XnDn0AeXCx4bIHTe4Ppg2+rMbuJ2xUVfkr0HaEfx1fTPTGRX8MrcDkqqtI7Ptu+YLR2Y4FXqzjBxdiJxexpxQCYvrgHYtXi4htKPXD6umtXRFSMlysNN6hkUZcbG+tZjkC013cWnPu1bHxCXB4iSD4iH3eNsrpghZ3QGy86uH63s2pJLr0R9B0QRsYqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRp6He+df6jnk4yVbTrWOHfgNaPmnw08rHN3iaNftp8=;
 b=dZ83+HfFYdjIWIkPoZ8Rj5CWLEmIcIGhmIq9buwGeIK7a3u693OT0u5Xsf7anhWOQoCluK+GRHEZ4lc+uMTd+84GlwjaqjdpTvGX0rLvgU1mWDgjap8mSOeWQx9S+ypQWHtvt1fOL6LfpPiHX8aFd3kvLHS6Zr/Wp33qhE9aSHZuRYzogS0DKdAnYRnz1cvWHaJ/rZUIN6SsF6q3hSC9hLSGZ4bH3nVugDiBBW/v9T3ZL6Qz/0cAzVL44YVIC/hHDHvwLtbC4VabBAC+fOcsAS/XvUSkyQRtHgKDfX+J/qGwVpHHwTgXFDMRgKezM+4uEyk4cU2oH6KtLCzUBBbAcw==
Received: from DS7PR03CA0207.namprd03.prod.outlook.com (2603:10b6:5:3b6::32)
 by PH0PR12MB8005.namprd12.prod.outlook.com (2603:10b6:510:26c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 17:37:18 +0000
Received: from CY8PEPF00000052.namprd05.prod.outlook.com
 (2603:10b6:5:3b6:cafe::9c) by DS7PR03CA0207.outlook.office365.com
 (2603:10b6:5:3b6::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 17:37:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY8PEPF00000052.mail.protection.outlook.com (10.167.247.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 17:37:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 28 Oct
 2026 10:36:55 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 28 Oct
 2026 10:36:53 -0700
From: Jacky Huang <jackyhuang@nvidia.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley
	<joel@jms.id.au>
CC: <devicetree@vger.kernel.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<openbmc@lists.ozlabs.org>, Jacky Huang <jackyhuang@nvidia.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai
	<billy_tsai@aspeedtech.com>
Subject: [PATCH v2 8/8] ARM: dts: aspeed: g6: Remove board-level flash stubs
Date: Thu, 29 Oct 2026 02:36:15 +0900
Message-ID: <9a5af3be251d15aef269cc6c2c92eef1668f7cec.1793179064.git.jackyhuang@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY8PEPF00000052:EE_|PH0PR12MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: ce970946-6939-4cee-ea17-08df351a1c59
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|36860700016|82310400026|1800799024|23010399003|18002099003|22082099003|56012099006|11063799006|261021123027099003|10067099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
 Notg6GY3uFGSggBIdES02flPqO1QndcYuaWxtlNAF1GcH62zR0UAiyFzog6ioXbWmHMrE7FZSfNmsReGMR5qG0HMS2XpSxdyh1KOarFVMlZwS+O9BZwRAG1cmn5zy4TFq5M5tRRKpup3kQrMUCt6Njiw8U5P+BaN4wSi1477LxMDb+fuqWyjfmp9uCTq+LMrFcgwTu/EpGs0YkmeVUS+no98xEj0B6Q7MUUPiIhq9OHWZOgfVrE3Tw4bF7IfhN1MDPfEoD4f+P9tdSlqc6xcKSCE7DJLJSVHBOzmt6tm0jMRUs58sX9vPLXioihNowvfiM+ysyionK/NeUsI4Icv+bWVNDbikp+w4bMfxLqI38sNDohVlraWJJxln+sK0UeJZi1np6XsPCIXSrcNyFfGV1koL1t7PnQZt/BMson40b3s0qcTk3xxeFMFZuHA5oY6WoDzxJJozHtcrPui6azbRilVce8Yc0reKoHzhi49umDdNX6H5Jcr/kJRbXLojsymWYx+LXWZCvbxgAVclhVVPBhWwNSYgFjR3xlAjDrPpICpRVhkW7dmfjnMCMSTpJts1UDTcE+CByYCAmHMNmW/aSQB9KYXsezttXZjbtFrIC9cJDCVm3qrmbVdSe/wpIpWYZGf8IrpYx0WUZCy/yfRCjFKcXhf1pu56nMuMVqNRLNHOOUubmLn3ofwOgBstTiIA6inVW4J+gsXhdvf30U8+w==
X-Forefront-Antispam-Report:
 CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(261021123027099003)(10067099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 2N3Inpe9Eb/o/Y8XT8ILJiAqboTni7cl4auZh79RHIIc0qFGk09ndzyO1M8jIIVx/3ssmEHZofFyRJXnQJUG1NT5QCWGy8KvCbKp5fV8BwCPDxZethdNxtxf39xIIpB92TgYStM1kTdzTH2+gk0XwfbGmXo73e1EWwQyhtScPQwxWRAnNQFoX5qy0+LN/WqhpRUmacwA1IwlwTY+DMXMp2w35HanpQidM4/9fN6MLJoQHBkSeUFWJ3alnwX6KLEowNI0TNpihqbj9qnri82Z9JjlxgXe/wpqbCT9o+suyypjmqOt2SiUixsa02vyL2+QQPvMOj9NbDiG/DSB2F8Bjd8n1DY2Ol1t2R6kex+RdMe4m7pf12UQOYV4sLD5vSEHSUH/HbbCNMoY/AWKGtra9RgdnmohWPjMQvWRT3LgivIW0Gd4OE3mcWLMx0WgQCeC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 17:37:16.9686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce970946-6939-4cee-ea17-08df351a1c59
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY8PEPF00000052.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8005
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SPI NOR flashes describe board population, not SoC IP. With boards
now declaring the flashes they use, drop the disabled flash@*
stubs from aspeed-g6.dtsi and leave only the FMC/SPI controllers.

Signed-off-by: Jacky Huang <jackyhuang@nvidia.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 56 -------------------------
 1 file changed, 56 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index edf4b74f5..de705c544 100644
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


