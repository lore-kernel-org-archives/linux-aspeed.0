Return-Path: <linux-aspeed+bounces-4719-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B259BC5DF66
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Aug 2026 01:04:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLkXm0g9hz2yrL;
	Fri, 14 Aug 2026 11:04:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c107::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786616638;
	cv=pass; b=g7v6lhy9xmMbDXgroL+2ky28ZErk0KQNUWWHiCtcOkhs30ZEz8eUTRx/Q18zpDiNZMJ4W9+la0mhulaaCQYoOLXGZnsaxAdQ1O2EwREFb8C4qs6hCjRA8Myp7u9uf04zvU20yF+UimmFYXb0Yt3yTdvH5SDZoZ0+K121gMq3bdp6zZ8VHqQhhYhJtrgIx0s6GeFm/zXLWJERFiPaGYV7vUeuMG2R2vKVxGUJSW52bjFjCvibVK1AFBsw9xx2rqFCLZH5mea1+UNAPCfj2vttw1GHFvvy5gQNoxR2pfksBky3q49DsNSOfB8mDglKJKrIiCOEtiGuFoyrfVRpNDAOHA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786616638; c=relaxed/relaxed;
	bh=rl9IHulDDn77bEqosAdpIWdVzxt30MaAe2/s0Bcwu1I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lpspngnFSSJkMHpp6TC38MOolqOx6jPw0o/PFF2+uVZ9bW3BSI1oRC5ITHBpA+sYeNDdQbdoUa0U8uItRUMlcsCQqtxLHyXHlYmkrJAmR4ZeXiFYPEVBEKG3hbegf7WWaUFkhzw+ZLv1aOsckFLBoZKSdX6hxTuYUCeqCiEfPSrdWJuCA0Babpz2frkEAAr5zhYbA8iDTYg2vu4SfZK0spS7T0h1UVxzpXZdK/9lpiuinV2ZjeElSiTywI0eOHbkvuh31h7dVrJY5DNqRcuK7fJvUq2FZsIFUcUJSd4LTZEKMNM3fp/4ZVQ4i2OwjVUqUxvM7LtY7xkiLtFq56S4Ww==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cT+bMMyZ; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c107::1; helo=ph8pr06cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cT+bMMyZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c107::1; helo=ph8pr06cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org)
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azlp170120001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c107::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLM0F0g46z2ypm;
	Thu, 13 Aug 2026 20:23:56 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ed3eN6tTi8fgY9Odp54L+rIpeOWt24zqUSe2oBdMNtheF3lmrwCuvrQXQrdXV0AyK/DE067v5vr2yO2XMaTMcuoevVxSPL6d0Z6ezH/9qJaZ0Xw0qUYjEcoGmFmOGIKbL1dHzIByLhoEJe+YE6IwlzsF4qTILx9r3l6tSPDHbOuNRXk9VS3MUWeJ6u1jmSY6Qnqf6X1tBZi4Z8kB3BWsdbW9+2OpxpKBYps9PlH/wZa2qGTz6tt7Y6CxxLjZwR85CR+LEAqq+SPb/VL4/QdMw1S4WBrD+NNVRGdofJKHFhsxEROhw8IrHkHMSc4U4y/O3+3lHDHUqkasPVlWBba1+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rl9IHulDDn77bEqosAdpIWdVzxt30MaAe2/s0Bcwu1I=;
 b=FtTm1cghq+TTsnjATmTVYGuVN3U/DxOEcvcyWVzfui7ZHXHY2XJ3eJxXWXTDz1EqpwP8bN3+E7H9I+GVAUDg8rlcCgsSSh9dLaSeG02Muce6DkdW//PNAHrtMrhg8TfUJmZoP7jjje5n94h4ilFrUwBjZFvAs5IOZiWO9CK+s/RTIjkmCc6kMpYLX4kAuq1Lao8biPiSoaA+KvBWe8xQDSdYpgtrGiws+phLxqUFGiC/X2Dvpg8qD/ma7p+22DYrtykvH8vjKIGTtF9T5oi9dXvW/3rVwt0hWAc1VeSf8LtpZ/IRfnFnvNqXgeB6KQytUwDPJEQt4/iY3VFA76Et/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rl9IHulDDn77bEqosAdpIWdVzxt30MaAe2/s0Bcwu1I=;
 b=cT+bMMyZXJ5KeVlyzjE65ahey9VmqGqpVZuLvD9zSsIApF40+i+NkipIoFhsnSWGl3yw88WHn94z3SHnDYWRvW53Tg1+NBJgmUUoIsbOqXABTi+HFqg1wJOXnMb092oVMKZm+3AlKPGtTmGmVhMNmASBlb2zAka2H0vL95+hBd4z/TaqMs6bQvftblvKc6FuGxEmqkAZd3+ftM9ZDPgz/UlM9Q+p9lJf/MMLeWzxVzY9b6BTXIubBXFuPdHeaCTJMpTEBHX8ievX1NfEGFh7jSjJeFB34VYW2of2ht0xxCQMhCNoGYRrzDUwwU+Y/OltTYhD/ccpCtSmZkNt6k8P9g==
Received: from CH2PR07CA0060.namprd07.prod.outlook.com (2603:10b6:610:5b::34)
 by CY5PR12MB6527.namprd12.prod.outlook.com (2603:10b6:930:30::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 10:23:22 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::74) by CH2PR07CA0060.outlook.office365.com
 (2603:10b6:610:5b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Thu,
 13 Aug 2026 10:23:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 10:23:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 03:23:06 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Aug
 2026 03:23:03 -0700
From: Jacky Huang <jackyhuang@nvidia.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley
	<joel@jms.id.au>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>, <devicetree@vger.kernel.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>, Jacky Huang
	<jackyhuang@nvidia.com>
Subject: [PATCH 1/8] ARM: dts: aspeed: facebook: Declare SPI NOR flashes on boards
Date: Thu, 13 Aug 2026 19:22:26 +0900
Message-ID: <20260813102233.3088939-2-jackyhuang@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|CY5PR12MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: 1873da85-bda0-4db7-500f-08def924e6bb
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|82310400026|23010399003|1800799024|36860700016|6133799003|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
 Lv4lEHsLSJvU31IsfSUQv0Ki0joLpUX1GeNuHsPo8iL5yYrvAhcdXjJ73U4E/vCJO6R8BiwvpU0nk7fexFpcMube+NP15suP1jIpxDBEjkP+tskmJ7Ts2sMkUI+tUT+Y9D9G2vxsOZAy9u50MurMJ3/my2Et3AOR6Gl3UrI2DCLkNINiiqaBKXq/KOX+JshT3l2vMZYg1iRcarJz46KJkwLadKN0exfNe3Z2GJrqY/LkP/w5KyVjjEEraQ/5QIfw/zZ2bzVocwvlWeLJ99nTBT/j8pa5EgnAhW3VntAe9G2xUX80qv7J2r+OhNLbgS6DtknHD7myOdeH8XfsyhvVQMbTGPHeReBuBihntmSUI0WKf40ZAm5rt9RX6IWDoY0XzYKu7czid/mPgr7UXl3tOOAc3c7PoAFSnwWUPQLPxBojxhoX7YUGqF9uRcx+EjFFurArcX4mOC0lPVsfkOCVg77zKSDfSzHPUASzeQHcljbeGEskjXz0dwabIvEF24UzeiDa6LD1K5lMf48aUTj8xpH3XHBkj+TPQC+0fpVWEeDgYzryMcZJZDGisYyLJcIPr8ofjmU6On3MvE/cF5TSeKN1G+Hwxw12x5r7suzRLErCnzKPJOv2j/xsJDiJKH+1mqzkkFzcsw5whFW3yoa2uu4H0RHIeUwP5CdIWNq0PserNQWNseBAt2Dp1vH0Zx2SStM/i2q+k7tyvSWtMXbRog==
X-Forefront-Antispam-Report:
 CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 +S30VV/KzNdpg97QDRtTAb3nvdLR4g6Wd2zq1UxgtimuYeJVcMH1Ckun/rw2Qr/DCHW/M+6FZ60e7MzM3NW+EbyP59TjrYiHldC5tZ2PS27T6WGGJrm9oUB4iglfRLv1s2g1hO7Nc6HYdRWTpzN8cyYpVKtDC0psFTyFE+IueuPJhUf81NjRH11a3XKBAejMg/XOvT8ZxLJD5PyEvtkx/QRI8oHKqvn/kHIU4Zefdq6j74LZCV6d6EtSA46pUIIvwJk5sTlwI1T0r9XnJ1ODrE4/7IxUVgBiyV3KMxm4gIEjFi0A0bZV+kvmXKPO5bQCLiFX1R73PYqTzjgXGJXaF6xa9cDiPyH7SaTnVoooM1SyEYTaeTEILdfZEBc8s9zL5sJrLG/EgsbPd30MhAPrjYHjTg2sL/lJmJDNuA95RzXmEBs9TanhHZYU4KsUgNC6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 10:23:21.6716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1873da85-bda0-4db7-500f-08def924e6bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6527

Declare jedec,spi-nor flash nodes with the properties previously
inherited from aspeed-g6.dtsi stubs. Keep status = "okay" so these
boards stay enabled while the SoC stubs still exist.

Signed-off-by: Jacky Huang <jackyhuang@nvidia.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts | 7 +++++++
 .../boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts    | 9 +++++++++
 .../arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 6 ++++++
 .../arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts | 6 ++++++
 .../boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dts   | 4 ++++
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts   | 8 ++++++++
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts | 6 ++++++
 .../boot/dts/aspeed/aspeed-bmc-facebook-rainiera6.dts    | 8 ++++++++
 .../boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts    | 6 ++++++
 .../boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts | 8 ++++++++
 .../boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts    | 4 ++++
 .../boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts    | 8 ++++++++
 .../boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi  | 8 ++++++++
 13 files changed, 88 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
index 1fddf3a5d138..e3b0e21e8e03 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
@@ -166,18 +166,24 @@ &fmc {
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
 
@@ -1023,6 +1029,7 @@ &spi2 {
 
 	flash@0 {
 		compatible = "jedec,spi-nor";
+		reg = <0>;
 		label = "pnor";
 		spi-max-frequency = <12000000>;
 		spi-tx-bus-width = <2>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
index d1a04b63df9e..409757a10120 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
@@ -314,17 +314,23 @@ fixed-link {
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
 
@@ -334,10 +340,13 @@ &spi2 {
 	pinctrl-0 = <&pinctrl_spi2_default>;
 
 	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
 		status = "okay";
 		m25p,fast-read;
 		label = "pnor";
 		spi-max-frequency = <50000000>;
+		spi-rx-bus-width = <2>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 14dd0ab64130..c6b9c67bd965 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -170,17 +170,23 @@ &mac3 {
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
 
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
index 820d39a92974..82e5d7b9ab71 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
@@ -189,18 +189,24 @@ &ehci0 {
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
 
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dts
index 49914a4a179f..a7df5e7ed650 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dts
@@ -82,6 +82,8 @@ &rtc {
 &fmc {
 	status = "okay";
 	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc";
@@ -90,6 +92,8 @@ flash@0 {
 #include "openbmc-flash-layout-64.dtsi"
 	};
 	flash@1 {
+		compatible = "jedec,spi-nor";
+		reg = <1>;
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc2";
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 5602a502d07b..e35041946d33 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -139,18 +139,24 @@ &fmc {
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
 
@@ -161,6 +167,8 @@ &spi2 {
 	pinctrl-0 = <&pinctrl_spi2_default>;
 
 	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
 		status = "okay";
 		m25p,fast-read;
 		label = "pnor";
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index eb8d4b95596c..3bf8945691c8 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -161,17 +161,23 @@ &mdio3 {
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
 
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-rainiera6.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-rainiera6.dts
index b29e08cea254..cb41b78536bf 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-rainiera6.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-rainiera6.dts
@@ -128,18 +128,24 @@ &fmc {
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
 
@@ -969,6 +975,8 @@ &spi2 {
 	status = "okay";
 
 	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
 		m25p,fast-read;
 		label = "pnor";
 		spi-max-frequency = <12000000>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts
index 3cc6e772cc8c..73d013cf3dc6 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts
@@ -117,20 +117,26 @@ &fmc {
 	status = "okay";
 
 	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
 		label = "bmc";
 		spi-max-frequency = <50000000>;
 		m25p,fast-read;
 
 		status = "okay";
+		spi-rx-bus-width = <2>;
 #include "openbmc-flash-layout-128.dtsi"
 	};
 
 	flash@1 {
+		compatible = "jedec,spi-nor";
+		reg = <1>;
 		label = "alt-bmc";
 		spi-max-frequency = <50000000>;
 		m25p,fast-read;
 
 		status = "okay";
+		spi-rx-bus-width = <2>;
 #include "openbmc-flash-layout-128-alt.dtsi"
 	};
 };
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
index 0a3e2e241063..efe1a2ea52fd 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
@@ -173,18 +173,24 @@ &fmc {
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
 
@@ -1867,6 +1873,8 @@ &spi2 {
 	status = "okay";
 
 	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
 		m25p,fast-read;
 		label = "pnor";
 		spi-max-frequency = <12000000>;
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index e4172be84e7f..bfc7df61bfc8 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -162,6 +162,8 @@ &mac3 {
 &fmc {
 	status = "okay";
 	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc";
@@ -171,6 +173,8 @@ flash@0 {
 #include "openbmc-flash-layout-128.dtsi"
 	};
 	flash@1 {
+		compatible = "jedec,spi-nor";
+		reg = <1>;
 		status = "okay";
 		m25p,fast-read;
 		label = "alt-bmc";
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
index 6287f80d70d9..e2d4aafb6437 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
@@ -128,18 +128,24 @@ &fmc {
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
 
@@ -1028,6 +1034,8 @@ &spi2 {
 	status = "okay";
 
 	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
 		m25p,fast-read;
 		label = "pnor";
 		spi-max-frequency = <12000000>;
diff --git a/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi b/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
index 0ef225acddfc..180015ccb209 100644
--- a/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
+++ b/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
@@ -51,17 +51,25 @@ &fmc {
 	status = "okay";
 
 	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
 		status = "okay";
 		m25p,fast-read;
 		label = "spi0.0";
+		spi-max-frequency = <50000000>;
+		spi-rx-bus-width = <2>;
 
 #include "facebook-bmc-flash-layout-128.dtsi"
 	};
 
 	flash@1 {
+		compatible = "jedec,spi-nor";
+		reg = <1>;
 		status = "okay";
 		m25p,fast-read;
 		label = "spi0.1";
+		spi-max-frequency = <50000000>;
+		spi-rx-bus-width = <2>;
 
 		partitions {
 			compatible = "fixed-partitions";
-- 
2.43.0


