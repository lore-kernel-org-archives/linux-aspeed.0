Return-Path: <linux-aspeed+bounces-1318-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44EB1C5B543
	for <linux-aspeed@archiver.kernel.org>; Thu,  5 Jun 2025 23:21:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bD0nP1ZQTz2yZ6;
	Fri,  6 Jun 2025 09:21:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:2409::600" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749096996;
	cv=pass; b=TB6lvxldD149VF2Whc+theeua+3GDWxoRAGVt6giuhuW4KAnlzoM2Fg3pMM88TpQwJzPaSUn3Fu2XblLhMVYLRjQj4T/j4Vuysdggk8YFvKouOFbLx5vMvg1SUc67iqhNqiFq8WnRpwTH1nA8W8rLOeKfAgr3EeV5JvHrmvFO+Uj4NxVqNFheHraNkTi6AZfix2czv7hiYwO8mvDPLhq/aOS3tZInP4AJqqH0Kg/gqyxjFFEL/gUYfkGppzMX9csYtmxstvlECQVisVFpfdfBSzwff3l1MF7KAfFIT8y1K+bKZL0QcSOB+ih5YYtVfbHXcxjPf6YU/kOI2mfdSolpA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749096996; c=relaxed/relaxed;
	bh=aVOdLN/GlQDhYHJITNNqciVLcqkHjM8lLQdL1EbpJ+0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XQfb5gfaDopkRah/KK4vgukj+UOB0SKLJWTLJEBvkkgyvF29Zv2pat8I75Tpr09/SC7suCiTUwOoZHqkCurAPc7HGPrkNgq1JutlVbbbgpXMDATP06gfnNjRnXqjJizxVkN+q3UwdYwkoHMjeAvv4cgXQe7FNrxW4CLgXcfMYdy84uZ3o0LaNz968z+dsxAcOcUqEe4EcbhS00bK9cKkLFx9txIQC7RiddiMswLCxQygd74ts/htPFAWzUTnwlXrlzKbZnyf3f/sx42/fDscwVRuZDWGuUtHQNyUXokgW8pNFD95TRiXtC6BTO/KfP+Bxro0gQK6J4PlP62ydHXewg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=tA3FB8Qg; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:2409::600; helo=nam04-dm6-obe.outbound.protection.outlook.com; envelope-from=donalds@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=tA3FB8Qg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:2409::600; helo=nam04-dm6-obe.outbound.protection.outlook.com; envelope-from=donalds@nvidia.com; receiver=lists.ozlabs.org)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on20600.outbound.protection.outlook.com [IPv6:2a01:111:f403:2409::600])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bCWNg4JkWz2xRs
	for <linux-aspeed@lists.ozlabs.org>; Thu,  5 Jun 2025 14:16:35 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PO0FUd6W7EMOT/oZonf/Lm5WaC8xJTjXcCPLsTe15BKb/HZ7SJfQXDGN8PRuwdnRjRH8ej7iwEXZH09oH8cnqykwcx27ATxUsi1cj5ekqWVfFakmUqtq5b+u21BZh6hJgMejzOeM8CCnv0vTJLQEof2Nnj8Rn37ur72duyHhiHpb7kq5VZfL/LKVKaRnUYpkrZHvKiNaonEgkZSm/dq/WruDvTo8/ejBbCxY982coyTwSRoHSAEdXPkpv7mYqC64HsA6qO2sYbdHkZ3r1gcVCbbxm/Bt7ru/zyqw8k3dzxvRUVBN2OFktDL9bPaEaoWauoJpa3CCAZc/+GAR3b6K/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVOdLN/GlQDhYHJITNNqciVLcqkHjM8lLQdL1EbpJ+0=;
 b=Sthu1CNziOzvdn92n/jkSr9lYtoojazPUmFP6bmTfX1teGc6QK0q9ncK8Ur85shtaYiHtcGB0prlq6neY2ivANg0Xu4gBE+WeVdPJhZP9uQhXo7PTuEfIBmcnB3E8Oh5XgjQyVnDPUQjmlLuh98hNhQMcvTgJnj7ZLrDC7wV+iXKWYeTN1oHMSbiea+VpDRDZgh9myDieDJJhgp+Qor9JJoVmiULW7C0YZlCwrMfpNqLctjL3dc1hUpSl305terYOXOborvyDyKVMAEHW0QEwrKo2PQpFhHvWYTJnL+Pwah997Bm2MJ19CRDsGbUJk5SworJSun2S1J/bAqcuY9fxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVOdLN/GlQDhYHJITNNqciVLcqkHjM8lLQdL1EbpJ+0=;
 b=tA3FB8QgzsepADoA0nuCoEoZq5lgbOBunQw/vpyYtp2lX/APgzb6+dQrGHKc2+0jQebRe2sl5A3ctjNU5ogeTTy+hIjNl0rkQOpWsR2yMY/KwmF0/QvtbZOz58zbVr0YfDCgOfJepy4mHYAujPfKhZ8/GHNmlyaZblJ/eSKwQsUGhGmdnjj8pTo6n2VJmyN+o+ET/IJSWRih94YcVa8hEuVbOuwpOMQIJ/Jyfy4C4Dy8VXVKwIcnaXwaL4XYAHJg4UxdKBlqJdgVsbUM9M0eXRVJ3g9vGlR8GZBOrIV9C9n6P3U3/DjYAEmXQnRvoytWFaVhBIjf6KHGuskENdZfZw==
Received: from BYAPR05CA0077.namprd05.prod.outlook.com (2603:10b6:a03:e0::18)
 by PH7PR12MB8426.namprd12.prod.outlook.com (2603:10b6:510:241::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 04:16:08 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:e0:cafe::9a) by BYAPR05CA0077.outlook.office365.com
 (2603:10b6:a03:e0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.19 via Frontend Transport; Thu,
 5 Jun 2025 04:16:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 04:16:07 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Jun 2025
 21:16:02 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 4 Jun 2025 21:16:01 -0700
Received: from dondevbox.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 4 Jun 2025 21:16:01 -0700
From: Donald Shannon <donalds@nvidia.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, "Donald
 Shannon" <donalds@nvidia.com>
Subject: [PATCH v3 0/1] ARM: dts: aspeed: Add device tree for Nvidia's GB200 UT3.0b platform BMC
Date: Wed, 4 Jun 2025 21:15:50 -0700
Message-ID: <20250605041550.1940089-2-donalds@nvidia.com>
X-Mailer: git-send-email 2.43.0
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
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|PH7PR12MB8426:EE_
X-MS-Office365-Filtering-Correlation-Id: e6c80653-e5cc-4224-3cc9-08dda3e7b246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QcUuX8JjB3SdNRfheSLrF2Led5FwmcbXtZw5VLdWqx0J/qEynL9QhXNSc2fC?=
 =?us-ascii?Q?rk18wKja/e5rc36O12nvDV2v971lfEKqFkg6cyuO+v6+Xa/Lf8DB/SddPGUv?=
 =?us-ascii?Q?75Ar6/0GDPBXchKHA+Bldm7/R6F5B6o+DMWtcspgEPaDfDetu7dZUXvhZMc/?=
 =?us-ascii?Q?LW+OmiFPVYpyweOjx7LZjN4uV+n/ou7ftKMSL4+CFF6Hyd+QMrZl/UQdjTq0?=
 =?us-ascii?Q?8u6FmfxxEaO3HWYA3Etzv2hyKeEF2uzwTtUOAlIcA1/nXFTajODV2gqic/l/?=
 =?us-ascii?Q?zHGVRra6v/3++oRDE1ddGP/xvuXhGa/2d1RtGmBZix/hT6bbjF2yjzRxVr1o?=
 =?us-ascii?Q?vXrWLyqE0SeHgEhzau/104TYCYD9DdAkTeouyGWgwa7jmfcTE5rkBFoQDcYY?=
 =?us-ascii?Q?wPMXrAWbL25Nn+zN6rECpbTIF/r19Y6AVBn++T+9lzXcJzOapq1i2bE6dSeI?=
 =?us-ascii?Q?rYFcmlCdYsiI/nBxR72WI3VIRwUyXRTbil15EEx9IPISDnfFLQjPzfLfYMIU?=
 =?us-ascii?Q?EW5TiPxFkiczgfAanJg1YFHd9CPxQrX8Sq7L30n5BJ28p9CSMxcz+81gukzD?=
 =?us-ascii?Q?C1f4FFK353Uq1CP4yns3Ou3yAoSlif1p6iK4AzhWhAP9xgCkUAQQfqt19wig?=
 =?us-ascii?Q?92lLivFwg2zdziItOP163Sz8QyYGSDy8fe0bHqT5RvzTy2pbA/rb8O6wZyZT?=
 =?us-ascii?Q?JB9FPIE1mydgbC1G9d+hvlYcek69sO27cUwBsw4GOBDDxyWWYCsMQfGjKsId?=
 =?us-ascii?Q?xTOVg9L5DmRpP2gIHhPbheg/d93PSZoIhFtXgNiwVl+r/aPt5js50mJfP+rK?=
 =?us-ascii?Q?ZIA4TvJY4FHxK12chLxw2EQTF8i52S22q6RUEh+x/EbhcVZqAOLCUv++CZ6Z?=
 =?us-ascii?Q?MqmTvIUCJvxAIW3HIrI3CZx/2OQJeRFMxdXZ7FemoivejAqwP7JgSKqzW52c?=
 =?us-ascii?Q?8K+7ODeeXHe3MCP5IMRNsx94Z9etxTd74g7PEysCFBAMEP0MK5w6E4u8v+on?=
 =?us-ascii?Q?O55RIvrr++7xrxWeOfKmgBr/93P+Yzuxi1Q4T9OR8wvNh8UU8PraRJ7hMTtQ?=
 =?us-ascii?Q?HXgP5+jrQimEjxKRnrWluku87nivYel0Cz3jRXdeLtbnGMhto5Xra5U9hbiM?=
 =?us-ascii?Q?ZmZdDtHGbdGmqZu8BwR6DebXdVQFjXIy1FNtfrzndzt2fnoOb3qDTnhMmCuI?=
 =?us-ascii?Q?qFGAUm2fZOAOp+LmxeCc/IoKJeC2W94Q4XVTugcUZuGSCeOEqy/WHdpGadgV?=
 =?us-ascii?Q?e+VY34Lzuc/aM4uPiZV3x5mFFHUstxE6FHbP7XCO0AmvNpwD3NfH9buPF/J3?=
 =?us-ascii?Q?yiQqc5wllY8vDEp33h66v/syxBZEGTfcITumJESka5zr+OufmcSQ2RenpbOq?=
 =?us-ascii?Q?aRNI4SIGhUnYK8pFoSY1QlBEhQBY8LcCzHPQw5Hz4t7H44/krJdpAFehwZHx?=
 =?us-ascii?Q?HKNwR5t8zNk1/pD2lK9TPFXMnpeCEIMhrQBYTbP+yCAR7UZMjWXrrIvC+1ak?=
 =?us-ascii?Q?NvGnHf/l8uwBZXdC+ct6FHZbnImuptUNAqor?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 04:16:07.9922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c80653-e5cc-4224-3cc9-08dda3e7b246
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8426

Fixed whitespace issues
Fixed schema validation issues from my end, but there are still issues with the aspeed dtsi file that are not related to this new dts
Reordered to follow style guide
Removed redundant status okays

Donald Shannon (1):
  ARM: dts: aspeed: Add device tree for Nvidia's GB200 UT3.0b platform
    BMC

 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../aspeed/aspeed-bmc-nvidia-gb200-ut30b.dts  | 1125 +++++++++++++++++
 2 files changed, 1126 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200-ut30b.dts

-- 
2.43.0


