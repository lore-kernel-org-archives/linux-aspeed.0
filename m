Return-Path: <linux-aspeed+bounces-5080-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF77C9830E
	for <linux-aspeed@archiver.kernel.org>; Wed, 30 Sep 2026 06:14:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvlBP6JB9z2yqT;
	Wed, 30 Sep 2026 16:14:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c007::2" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790748877;
	cv=pass; b=osuoWYfWzPL6RDNeEVDE1RdD02WZ2hesMUiRKE6Hf/PBWPy+r9Hf8floGXOtNxxaVfbIeQ+ve/r00PHEGmzVCAPLae61t3VvCf1AAgDZRWqNUp0eR6aIDxr3dOA7W5jc9zBKqm1/S19ZkFPam2o67jVRZY3Nb0k4AVI6OBF8FxCr0zPP+HsZgZ+pNzRuZvoVv213ncEpukXUxz7eJb0iwiaVJ59cifOfcAQjcTT2nNXetCN7pAqiL4a+ZFJr6j/7FzhqRcDEuOSvBGKKiIhlWRWZu8EIrDQG0D1xg7oRzkdylAMnKZmVsl450g2QcclLm12/APqEM6lEgL3Ovn5WRw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790748877; c=relaxed/relaxed;
	bh=HtrsMB1RjM1MBDhb0CEcq1/Q0Z0cEZH0EfimO8/yelg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=NvirloXzVa/lBMUSr9WwcGVgkfc2a/xcUdL7k9P/prEmJJV7XVhCvNJX7ihg0mCIkn3Z88jYORFZkt0CxbcebgXyM2JLddi87tI846x0+C/TG1ZjE4NErPpPIkE96mw9seWSAoYXMGTSqIHW713up3WrCtB2bkyXmCvAgZbknOM2rHNJ54CGOCmpYzC8rLL0+x70qhJO6v7gwHK8CKxmb5Bsm1Ph/W+J6zC5pqQSH2ajtHloIQJbgfCRvkT4LR3XBT+fojZXcN0modcQZwlEthFxBIrrhIiqpj9Ftg+Y1TnWmmpXpK7X3f0+ungioZstLBeKooa3NcT/BSLKw94jbQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=RsLeLti7; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c007::2; helo=mw6pr02cu001.outbound.protection.outlook.com; envelope-from=bounces+srs=ha9og=hw@amdcloud.onmicrosoft.com; receiver=lists.ozlabs.org) smtp.mailfrom=amdcloud.onmicrosoft.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-amdcloud-onmicrosoft-com header.b=RsLeLti7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amdcloud.onmicrosoft.com (client-ip=2a01:111:f403:c007::2; helo=mw6pr02cu001.outbound.protection.outlook.com; envelope-from=bounces+srs=ha9og=hw@amdcloud.onmicrosoft.com; receiver=lists.ozlabs.org)
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azlp170120002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c007::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvlBP1pjyz2yn2
	for <linux-aspeed@lists.ozlabs.org>; Wed, 30 Sep 2026 16:14:37 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cM1BbjM2ISbnOdmVBgoXrvUssn0647QLmdu1aO/KQ/03RYhL8Kp1Qj9yyPYjE5AcijYs4JLR8We11IayfJJJZkLZKj3BQD79pJWgDcuUfG7/TKf6XwsL2RIYH1TyKKjH7m7E8Ukg/JYiFUwaEFj3J+IpkSiOWGetOEe94vqNrYjPonq8UXT6Fqn/g9sNwDKvQ0Blnn9CWjKDBe3+zq/YS+cjPytHLvkqRlOyPZl0cgw5AZZM6BKXs948CPqxxxpL5nvLAW0CEPcFA+DHGtcDKIi2MyyS1uJBzYCueikO3/BZG9YSMNXeYlzbQWEZAQ6trQTFNtWrfbP3plCqvQsF+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtrsMB1RjM1MBDhb0CEcq1/Q0Z0cEZH0EfimO8/yelg=;
 b=ClG3K+hSbhP/kBjKDIiLU7DazYwLrLhz/FvM7OMi4VZ/VD5dUml0bdahv7+mOOraNnU93pfVp1z6HsydMVGFunyHNkLUpL56VhIaGgrHigG84XUPkMoUcFU0jL3Sy+OXih7diRTLPvDGfDEGU5eNE6y1b0F3j9msuVM6qiDw03zlP0nBDPW8XEZmHWz088fOS65Da5kaGznQYhwa/0kGhNgaNo7f2A3IZTN/OJLvNxLvH9ojkb29ocfnC5J5ACZ3EbM4hk/0mdDwZCSAYL1a6qcJVsXf1c4WLqj8x3mxbZ9i3TYgI5e7c1KnS0EzphseOFwNNoj5rS9rtep+Me3jSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=gmail.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtrsMB1RjM1MBDhb0CEcq1/Q0Z0cEZH0EfimO8/yelg=;
 b=RsLeLti7rrHWr+Ttj7mWEdUgf3Ry2JRkWkFlRa9O+JgPSHueyJztvIofVsKaWcPKOWAOV9J4LA7QYbAUCHxEmFJrdN3qfSfxnAxzWus3Exuyv3yPVJcXe9cBY8iAA4CtAUg18oRU0bduUfRtGXIkoZtCftFz3pjMeYvMg/ldPayJEho/+pac2hsZ5MKP7s6j7HkeHWPE6/DQUcVTsS/AgeJp1gNz6qBUm0fMEL2enDTNKzTlTNccUgeqxmv1IiKCJKZ02OH8SYnCQZeVsqr5r8Um70yBYoZ/793SugDMqcVMVYd/Dl4OFXZtAK2jQdiy9uUCLFqydMmXlkgNRow+Mw==
Received: from CH5PR05CA0024.namprd05.prod.outlook.com (2603:10b6:610:1f0::29)
 by CH0PR12MB8462.namprd12.prod.outlook.com (2603:10b6:610:190::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 06:14:12 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::2d) by CH5PR05CA0024.outlook.office365.com
 (2603:10b6:610:1f0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 06:14:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 165.204.84.17) smtp.mailfrom=gmail.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 165.204.84.17 as permitted sender)
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 06:14:12 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 01:14:11 -0500
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 30 Sep 2026 01:14:08 -0500
From: Colin Huang <u8813345@gmail.com>
Date: Wed, 30 Sep 2026 14:10:19 +0800
Subject: [PATCH v9 11/15] ARM: dts: aspeed: anacapa: Add SPI flash VCC
 supply
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260930-anacapa-devlop-phase-devicetree-v9-11-f08aa0d7182d@gmail.com>
References: <20260930-anacapa-devlop-phase-devicetree-v9-0-f08aa0d7182d@gmail.com>
In-Reply-To: <20260930-anacapa-devlop-phase-devicetree-v9-0-f08aa0d7182d@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<colin.huang2@amd.com>, Colin Huang <u8813345@gmail.com>, Rex Fu
	<rex.fu.amd@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790748641; l=1484;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=5PWO7D0zuBpdKoQ8bwidQqu/R+kIa6VCkTBo+x6SPOA=;
 b=CRI5TGTSmwTctxWi6B7mUEROXsIPC+bGiZEo5B6a88WRBsceiaedyIEjJVam87q3tJAj3FprY
 UdDzJahkYOADhKjvNZXuVWaQjNPdyHUeMEvNZ6K+04oocf6AIiTzfmI
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|CH0PR12MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: 800bdb65-fbf7-4ae2-4453-08df1eba0bd3
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7093399015|7416014|376014|35950700016|48200799018|61400799027|82310400026|10067099003|11063799006|56012099006|6133799003|22082099003|18002099003|16102099003|4128699003;
X-Microsoft-Antispam-Message-Info:
	bE2SaSQsVxD9N4Sf1e1BwWlrF3s1LPPf5wxkjkWg3LnkAgQDF2App1ufmdGzNVEPlUFBLy/vMnJwwVGy5m9oAJLfscqOiajd5JMA8ZwX/az00Ymk8uSDgGqP40i/ieFId2GrM5qJ4U1jjVoc28r/JxGLBp69mkx0WcEF681xa0ipO9YxR6tU3NgSrzrx+XtjVGMHkBSpefMj1IZH53CTGBRORC1viPBWFVpaGICHDJb+t8dDaN4Xg7qK+/P7H8Ty22ZKFJApZJmZlJgE2THG22DS70hSmL8XhMmxvYdckKRlyslTmUIHoWB8pAulMDItkQwLQapT5I142OlUB/hf3WHw40s5wLQizchyzxY4FFhGf+9zdBz4OGq7jnJplJnJXTir0y3HFRseUFZhkJ4YobVTd9BK3Ku5BZsSRfIqlH87j8mf4oJzRuS+U8du9MygNEKXWv1v3DSiVLALqtX/ig7IaTg5x+vD5PitfalvFdkq5+2NIZlfjS7yV0KZzgvu/Vy4gMqjFeuhRAEQFV8EXhIlE5YsLEbp/iWKFS2365nf+wMvwOyDDZYd7N0puH4BCbdFDIRqGitLN2wUMxyXv73j3w+wtAG//3e9Sgk9aOeHK5XPvwm4z66OEwf9IXGxK3hdFYHxsPaxRILMTyMfFl23IYWA8eKrItTT6cH4yrJS1eppz7frHNOA5LtuIlFgMfNycAtghE9jGa1URECUvQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7093399015)(7416014)(376014)(35950700016)(48200799018)(61400799027)(82310400026)(10067099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003)(16102099003)(4128699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	puIxAAiod3kO5sEntBIdFanpth6jXvUia/Ear3yjhuDnonhGyuQobvW2MoSXyYQTGNXmpTIw8qGY+5Y3QELiTPDEn8xS0fS5BNutVXhTvBMgULHqfMirbPYCKKk/NBqxcLl+tcO5HLgQL02ARQsVmMhw75Opr9PAZPP+7YsOfrwKl8vD8Qzrr2ALelfSRHcMogpKghuyijF4+aeRrLcPOLw1hHD3R41CPH0rveAiXDjQaWbSRYOd7ER7ieGBcJlAyGYMCRT9K2xaXlDKRULAyTVdgmYdDUynNfp9en+S7loyH9RY7OLvMjUKx50CcHsCO/E2h/waS/z+GY5taNQ31hYUyNPMbvAOqtPdmAGX5ORYK0Y+yePg1t9sfzmpIWHGfKxEL5eawIlTCB5RKzZlZUngXD3+Lnw833SowfTgWal9P/JKXcZ8v2YFYJXwM1vF
X-OriginatorOrg: amdcloud.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 06:14:12.0182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 800bdb65-fbf7-4ae2-4453-08df1eba0bd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8462

From: Rex Fu <rex.fu.amd@gmail.com>

Specify the 3.3 V auxiliary rail as the SPI flash VCC supply to
avoid using the dummy regulator during device initialization.

Signed-off-by: Rex Fu <rex.fu.amd@gmail.com>
Signed-off-by: Colin Huang <u8813345@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dtsi b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dtsi
index 5f9cfeec39cb..e429f7be46db 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt1.dtsi
@@ -92,7 +92,7 @@ memory@80000000 {
 		device_type = "memory";
 	};
 
-	regulator-p3v3-bmc-aux {
+	p3v3_bmc_aux: regulator-p3v3-bmc-aux {
 		compatible = "regulator-fixed";
 		regulator-always-on;
 		regulator-max-microvolt = <3300000>;
@@ -170,6 +170,7 @@ &fmc {
 	flash@0 {
 		label = "bmc";
 		spi-max-frequency = <50000000>;
+		vcc-supply = <&p3v3_bmc_aux>;
 		m25p,fast-read;
 
 		status = "okay";
@@ -179,6 +180,7 @@ flash@0 {
 	flash@1 {
 		label = "alt-bmc";
 		spi-max-frequency = <50000000>;
+		vcc-supply = <&p3v3_bmc_aux>;
 		m25p,fast-read;
 
 		status = "okay";
@@ -1073,6 +1075,7 @@ flash@0 {
 		spi-max-frequency = <12000000>;
 		spi-rx-bus-width = <2>;
 		spi-tx-bus-width = <2>;
+		vcc-supply = <&p3v3_bmc_aux>;
 
 		status = "okay";
 	};

-- 
2.34.1


