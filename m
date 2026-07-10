Return-Path: <linux-aspeed+bounces-4460-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E9DC43458
	for <linux-aspeed@archiver.kernel.org>; Sun, 12 Jul 2026 01:01:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gyS250wp6z2ylj;
	Sun, 12 Jul 2026 11:01:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c101::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783662613;
	cv=pass; b=FRVkoWCTLAs8snu9EayYga8BPHFI8r0F4W06iDxPc+iy3mGQismf52wDfWcbimOiqTtBxhJdEHYa3VxBkkmjJw12EDbTn+DKuOFgRfWUKKTHdCge9dH36hUD5ZZSaaytZTiPoykDpDKbX85wziEOl8lMRfucNd7UN4KcG9tYBcuHX0/0aZNun2Efg8RWZh7uEHFg0FrKma2XF0FICGk3AJqCUIJ1lIUaCsKRYM9OywXtdnqJu/Yjk3EfUCPubqh4c3M1Ovc1ByWq79GKZg9SufoABjzymECbW79u5TzY/VDm6GRbtRNrMTuJp1Fm1YqqkoTPCj0sBf0mDVYHUrpVmw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783662613; c=relaxed/relaxed;
	bh=dDmGPjrXGkz+KZjv2SJWhtAlymfWVB4F9hxa1pGKoiA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jray7ksO3oufFjI6zmILAIiD4TxLvJXLeXN/aLC1lHcEzh1IjECqn/BE4ykfXImuvSdyAux3E91b060i8AJrF+IJBfmdnyRmfOby1CC6c+fySTJt+9OSXbUrbvhxSHOhpl9A7gE3PnfYczerZ2OeOOf2znoLJYs+Y9LVeipgbYFvELJlJDS6RgI2M+eQYSs7DB8McJnsT6jkKWYvr7zyzBgMGUBTf7gf8iaYoL0ftaqfLrez3szQYtxWC6JpSY5jX2kccStB9ZTXDio44uzU05AWkl0aMBUvEnT//f4CPdjlE+3taGDKymLSe6Jtw2OB7RaHf7QgMq8LLpUEjPwu+Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=acLjbSpq; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c101::7; helo=bl0pr03cu003.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=acLjbSpq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c101::7; helo=bl0pr03cu003.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org)
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazlp170120007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c101::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gxLX30Jf8z2yQH;
	Fri, 10 Jul 2026 15:50:11 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qjv4hfhY3z6t1heK3hbSq+28QANuPWelEH3ood9cV7f51yidW3ZI/2duhUtXenn+qBYgeVS2ik5ptyQEDippsnXljg3x+yibD5TrASAvODjR2rzfnWBqIAaMy0lti+lBctQdwvmhp9iezUTnPx3LfESPc4EBanmAOhIibmO+exervWRRh2XAbhfYHuUSr1q+JNYouAzuzY8ZN6O+TKFxneUlpFpCRa7+MEj4Mff7HgOY2fyV1ZKMc2PlH5KQYaYkyHrWDBlm87K+VgsPBl4jDZQhOqOQaihJ7yj+6Ba2mm07C2ARRBee0xE8yBYWWqvmQhhiAh2OGKJgG9Va54IAcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDmGPjrXGkz+KZjv2SJWhtAlymfWVB4F9hxa1pGKoiA=;
 b=whIHezl+D6s4RJz7G5EIexHJ/qu5XBttLACG+9y6GKBH7x8J8Ois7xiIojMSzUoNW3VcbbzPSP9rfP9xejYM2BUw3oZtYM8kFkOx5JM5eNqB38i9YfVxTgBw22wUZDmJLsRjIJMHTy5FhRc3raXN7DdNEyvnUbBDCHaov++IH2Wc1frPL1xgmpTKWdRXYvN/uzsJ5HWvCK1N+eKaihItaco5dhrDvPOyaW9ptvEntOMq+TgD1ecXkmCBv+fVrOGCQJYU9ys4RCvsMyb4aGMnvyc7oa2XydtS+8MJWTXKjurQogD38j2/joXCgwtLQfxuDw23c43mmSsZBXMQIvkgNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDmGPjrXGkz+KZjv2SJWhtAlymfWVB4F9hxa1pGKoiA=;
 b=acLjbSpqIQJxQUUETdFWVMUKIvSrp0xDu1/LAL7/OY2Q9Q5WJaArehTbxfLSstVSWve8HazMb6EYC+gItR6KUiRsYxl/47yxwAIMG/MdIx7WupySYN7tw52rO6l8TmGxbW6oW0mptGn0fbF51tgp681fEd1qrO4vq7sl5oPacITENz1ktdm4mKOdI9bmyFR4bFw7Lc2iNbsW8XG04U29d5x26QS0tj5IPkrzoA9VqTaWKZz1fJ6PUa0FwbYaoAObapLioRhVbE7cXI+OkFp0p6nD2uZK8J6MVB7HwwJjWWTDPXB96oz5B5LwsGvrYJWR4ggH/mL2FxMqjBFcCz3Vgg==
Received: from DS1PR03CA0014.namprd03.prod.outlook.com (2603:10b6:8:450::11)
 by SA0PR12MB7464.namprd12.prod.outlook.com (2603:10b6:806:24b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 10 Jul
 2026 05:49:47 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:8:450:cafe::4e) by DS1PR03CA0014.outlook.office365.com
 (2603:10b6:8:450::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.13 via Frontend Transport; Fri,
 10 Jul 2026 05:49:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.0 via Frontend Transport; Fri, 10 Jul 2026 05:49:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Jul
 2026 22:49:35 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Jul
 2026 22:49:33 -0700
From: Jacky Huang <jackyhuang@nvidia.com>
To: <andrew@codeconstruct.com.au>, <joel@jms.id.au>, <robh@kernel.org>,
	<krzysztof.kozlowski@oss.qualcomm.com>, <conor+dt@kernel.org>,
	<andrew@lunn.ch>
CC: <devicetree@vger.kernel.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<openbmc@lists.ozlabs.org>, Jacky Huang <jackyhuang@nvidia.com>
Subject: [PATCH v3 1/2] dt-bindings: arm: aspeed: Add NVIDIA VR-NVL BMC
Date: Fri, 10 Jul 2026 14:46:55 +0900
Message-ID: <20260710054849.3178747-2-jackyhuang@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710054849.3178747-1-jackyhuang@nvidia.com>
References: <20260710054849.3178747-1-jackyhuang@nvidia.com>
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
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|SA0PR12MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: 56ac5cad-44d8-4f9c-2889-08dede470cc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|7416014|1800799024|376014|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BY5emiJ5ZLefIRpFxGQpbm+SCyfY2eQRT6n4etUREnKi4CE480KrNMPB6D3Gz2dtMLsfg9axW8wLLsBnRO3cB+09/mQjVyKk3OHM67Tcp4417O6oVRyQrRwxIxCaB3MhWjEp1q0vJ76ak9IY/y/bQh6tT+X9Ain7im6vYM5T3F4ooeYPqV5+lM0qiAguHYoTF6okt9aVphd+f1HH9mSSPph7tyQTCbmiUhgttl5sltBw4IyjZaJthbnWc7lHYs3a+VYV7s0xBIYCKqZmWrNr8etXFYn1Aw0ojTiOg64/M8B6Fn2/cbP46JJBA7/rdEEgoeNNgWbsAG5CbZD+aB6R2zSak1NH+2ljqIbXPC9+mhARW5RkjsacZoBFq3h/GpPjDQcs5s+PrJnzMhHTVsU4ak8PXnIiQApciVurSUbQSC1s2yRtItAF8z2TqqCuX4FmAgIwvrAOHFfb928938EhHFW+fMevQ+1tGbcc46avuXltQj1cyaznSW9onUm2c4ZMfNrKvOJQWc8toeoemxL4ZZf8vQHLy8Uxcm6C1DQagKLnLCr7RNxrxdXNpu+0NN12Axk/0v+DzDgG8z0G+ZgA3vnBYgBcbzi/+cLMW8HCRm/R0lMZX9tvHJlqWGDdFOlZgQ2T1qzZ+ztwn1RO1kqlLfL0xmkOQ+c5bYIRJhv31+huoEqLZphUZKTK06E+WdGD1lEJOHRtADH2Ot2F/b/dPg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(7416014)(1800799024)(376014)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iCEOyKbaKa81XxkaF0bVynwbllMNCqdb71nx6haQjHhoAMaWgMny86YLFVPetEGru6EdYsgOADclSv6NqCAva7M/lOFxIhmssbPbqCKDtCM/MRFYwiRA8gsNmsmW2AxQ7zmgL0oC5e1WQ1v6o0rn/HNV5aoW1TmZFk43zwRYjSH8l3TgwgcqkilVc4GfFhAqHXORDea1MKkuxgM9A+hW7lvcO+bzRUPFmmWmI4X5ImA6El866wjOyyIViSC0oRMj47+JcYK9fRHHSQYQsmBjZXuAQuKlDgErUgoJQQYRYDME64sot8ylxMc5Xg76ntmIlBGMKXCTQ98WAhk/IuFaOSfIG8DvPoWYrglx/BIoitKdS5Ukr7A31sHilE1aABuCKuBO3K97HTbvccnEEEvtLZD9Pji5r96xIk1R/2ZsQE65+jpWc+ExAF49uowLInGG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 05:49:47.0050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ac5cad-44d8-4f9c-2889-08dede470cc1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7464

Add NVIDIA's VR-NVL BMC board compatible.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Jacky Huang <jackyhuang@nvidia.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index dd7996960de3..ce893553cfc3 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -114,6 +114,7 @@ properties:
               - jabil,rbp-bmc
               - nvidia,gb200nvl-bmc
               - nvidia,msx4-bmc
+              - nvidia,vr-nvl-bmc
               - qcom,dc-scm-v1-bmc
               - quanta,s6q-bmc
               - ufispace,ncplite-bmc
-- 
2.43.0


