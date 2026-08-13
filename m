Return-Path: <linux-aspeed+bounces-4722-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86434C5CFCF
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Aug 2026 01:05:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLkXz0KSLz2yrf;
	Fri, 14 Aug 2026 11:05:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c10d::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786616633;
	cv=pass; b=IBNsqW4y012F2QRcPtKHzHbMKUPMuI8wv6tE1Ntz5zBfWS52OcIjm0g+lpTfE83c6vzUc3Sr+o/n+rh3kW+dU4dKpk63KagcVQcIzKU5fE7+i+zMJORr9Vjssch7UQ3M4qgZ2lg2dIGxJjvbZbLteMEpinPPVFas03HN0RDtqm2iA91BGP+mw8aAz03D5Y2mkCtx0SZDhjpqzc7VonGoIQLnva+yIoeB7bzeApnwoLVj/i7PIToczdPOsP/xCwe2MVmb/SkA2ubLgN96/Fkx8uwbZdzv52f3fbqtGK9aMgDJeIeyyafY2z52F9NmdreIeJDmz1bRBiZcVW4jmSZT7A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786616633; c=relaxed/relaxed;
	bh=gP8XYLrsqR4NpfNfrUqNuw5T8OS37R+Tew6ah4j0bzs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U/KwbimLWIdBaLOB8ev77iyKhb4j5MtH6uJdtLhkzn1nMbPNRoPsesmSHwJkTFrwKlCVzwkreHuVnGtDvtOhNeHEq9Pq9g2goPHkPnKSgIJF9FprpazinTfdlwNWuwUTxJZf/W/bW2FaLWdIPf/JcC3VdYsRI4xh2GDQOjZm4iSUkL85uWqSu4TqokUsEg0UqIN0csV8EGXraWNlnVlbQwq2eJ4x5mLsICkdZWamf8ozyxloWl8vJEP1BZH85tXRq/Tyho6HrupPbHbbc5oKD4pW3mtw2Dqc+ugGlu54xm1cqTI/YhEsqmffXQGbbQh32pjUz3ecGVKF6g2/ORtCLw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=njp+jeof; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c10d::1; helo=sn4pr2101cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=njp+jeof;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c10d::1; helo=sn4pr2101cu001.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org)
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazlp170120001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10d::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLM084kZlz2xyl;
	Thu, 13 Aug 2026 20:23:52 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TajS0/1TLHNPmeDhXHxAGmMu99U18B2UKiuf5cFjYJ0qUK6aw8C48R1MGTOL+QOkfYuGnXkSoBhRd44WeypuNgNCo0npN0pu4+G0kPWcn7hqWJbsEAeMrHQhazZMcRuikuR8gepNk1yXS2LU222Vgm8yUQc29AN1aQukrCrBgreLzlviFCeNWg0ZMHQXjvtvr0diZZvwkaqpmV2/mLotPUzbRq7PoKdAAj2FIKMng5GUDjcHv+/rVis6FiZDm+PySqn6ZiVzn+EpCsYp2djo+hov7hcHQvGLwv+QSWi926FrEOwVpUDp/OWstATd9LLMVRDpWhyl5wDu+Zj0xuBvCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gP8XYLrsqR4NpfNfrUqNuw5T8OS37R+Tew6ah4j0bzs=;
 b=sXpeqhAe4lexcNodCqwGvBJJyo18MaOi8LaBNxJQXfS9FyqDAEGRBsFSH3846qQCChqVfIg9H5Sb8Uuusx79vM369/Z4ZkFxlmeydiZjOvlkb4eky6WJyVnE/r6/dxRVy/cQqLqWjLDwMt79o8AwK8fVBsGT86yGVqdALEhnsI4wE+TuiLerU0p16bfTTUu0L3JP9N+7ttZswIMaRfwB1ogAAhnYaVj4NkuACV9gjjLqNO44NobhY1SaalYZ17hBLvm8JA2165rlgbqiLxACStFslFskLftf0+f6vKwc7W33hpsCb+ZXXdzO7fw2c0aVanqsf8DXUa1b7AyHs94RVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gP8XYLrsqR4NpfNfrUqNuw5T8OS37R+Tew6ah4j0bzs=;
 b=njp+jeofY930SfKx/2nMENrxGNdbMIaaRkJSJc7HDu2MaCPgEndJjPhR0QRDFOCeKUkD8cnG63XlqFe0fqAYqvmf/IMbPTV51GbZuVgpWW22rXpA8LC7kBzFta4a11kWFLkMNJgvcx7fM2FjJ1NdlhT4ipcW05XQJiOJ0J8XWqsCK+qPeDrncsWFQ5zPBiONOOBJrSXKPrGT9sa7720nwxWwavmPLXKcSPhXx1IpdNnsNkQnLW3NJQQaB72OR4A/yl63DxGmccOgdR3n8jvaJrvt+RUAEdxOZvpjgnh9Kaj9Fhj1d3bzTneOSTnFBZ+GC6ONicG5YJY1DsFj+xilgg==
Received: from CH2PR07CA0052.namprd07.prod.outlook.com (2603:10b6:610:5b::26)
 by PH7PR12MB6788.namprd12.prod.outlook.com (2603:10b6:510:1ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 10:23:24 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::5) by CH2PR07CA0052.outlook.office365.com
 (2603:10b6:610:5b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Thu,
 13 Aug 2026 10:23:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 10:23:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 03:23:08 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Aug
 2026 03:23:06 -0700
From: Jacky Huang <jackyhuang@nvidia.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley
	<joel@jms.id.au>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>, <devicetree@vger.kernel.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>, Jacky Huang
	<jackyhuang@nvidia.com>
Subject: [PATCH 2/8] ARM: dts: aspeed: ibm: Declare SPI NOR flashes on boards
Date: Thu, 13 Aug 2026 19:22:27 +0900
Message-ID: <20260813102233.3088939-3-jackyhuang@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|PH7PR12MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: 91fcdb6b-5c89-4cea-db6f-08def924e807
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|23010399003|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
 0VvsQPKsRWgVFzOtLD+HvfiOxszVGFkiBb/t6KQT5uGkP3UY0dGBdA8YAW0XR8JnNbpXkJOExcxq2346VMpCfo7WsyYIkihooMqd1xBO0tQxNKXN8Vy24+oovkoSFLYP9ia0tGlwkWwnwXSLuI7W7SNqZBxe6UoPef/+akhtyRswBtlU6mSiI3LLGdRZNfoj344RZN9rj4/DoJD9AzVyOGFcP0V/P6T3B8bf1h7Sp/6oAtvHTDEE6hfKrObA72rHJOw+eMcjWT75m2YtrN9bLI2yRAx2CWnnFc7aGNRhGl+rqhoAJNXmproTEEBpcYrreM/amAoEYtR5YsuSJGadJDzue+f4VaOYeT0LmSCFlOjIwBQDarzM6oFShydEOPc++4CjhKKq6NUbg+3DlbL2ecwbkYqEwFctZeZ07JSEhHxL2DQog3L9E4a/8czkdCLjI5CgLgtlJX+pWnLntKaXDNoC2biTKO7nhsOrQgLl+hXiGf7SDoLsjSUq6yDB8+GK5/+pscn2QTXKzN375DNPJi+ld0VOj41K3gRsF0oHPg0DfyXjmQC2/2ffZIqp7JR3A62tHMnfdJcyYjC5upSJD4d4HBgW9wHmSSKGqS7jt4V2eHciy3YekO+0vwk8Jwmc3e7ZUTknFQf0IgBOAuk4+/Z9U0alm5pGql67cRsTG2DrdiNeuZqarosz5DcOk0AR3LbT29/w/JAq033ftQI36A==
X-Forefront-Antispam-Report:
 CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 oAZiSP3BHVYuuL8srcRsOUH9EFyCWqr7Hy98MceJoicqoBcPn6CIr8LFESxLMqDCemQYUH9a86gIZHbdXZkkbrpaP5bVCl3H7XV/G2ZYBUX/VPBV2oMPxBJf+Xwsi3Et4xz2AdDZt4PgpDzL/rcWTiX7p+d1u9Av4gpuxJUokpsYhBkOGsBlIWK6ppNRRUoiecIS81drooHO4RN0b2x2SGmssI2TePSJdb7JJVFIZYsMPeAyaZyPCrdyKUu1QIusoQ8rnaqoKuQf4I3h6TBteEHtQPUGuZM3RWbfx2tCdnoyvY/IdkXU4tSTpBGfiUJQN1lzCD/5A2Ebxoh+QCoyBNc1dEKm++Q+Lxf5ERyDmYgy9MfqWjC+d6qLyP8+mqxjJ79whExncriKDjxz7ubthcTZ2cMVfEhtwrFjV4BLQYlgdS62XfnWW6HPjb321MKo
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 10:23:23.8653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91fcdb6b-5c89-4cea-db6f-08def924e807
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6788

Declare jedec,spi-nor flash nodes with the properties previously
inherited from aspeed-g6.dtsi stubs. Keep status = "okay" so these
boards stay enabled while the SoC stubs still exist.

Signed-off-by: Jacky Huang <jackyhuang@nvidia.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts   | 6 ++++++
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts | 9 +++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts
index dbadba8eb698..df45f619273f 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dts
@@ -1551,20 +1551,26 @@ &lpc_snoop {
 &fmc {
 	status = "okay";
 	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc";
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <4>;
+		spi-max-frequency = <50000000>;
 #include "openbmc-flash-layout-64.dtsi"
 	};
 
 	flash@1 {
+		compatible = "jedec,spi-nor";
+		reg = <1>;
 		status = "okay";
 		m25p,fast-read;
 		label = "alt-bmc";
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <4>;
+		spi-max-frequency = <50000000>;
 #include "openbmc-flash-layout-64-alt.dtsi"
 	};
 };
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts
index 6fe7023599e8..d886f24789b1 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts
@@ -140,18 +140,24 @@ &gpio0 {
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
 
@@ -161,10 +167,13 @@ &spi1 {
 	pinctrl-0 = <&pinctrl_spi1_default>;
 
 	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
 		status = "okay";
 		m25p,fast-read;
 		label = "pnor";
 		spi-max-frequency = <100000000>;
+		spi-rx-bus-width = <2>;
 	};
 };
 
-- 
2.43.0


