Return-Path: <linux-aspeed+bounces-1749-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73BB9C83F3B
	for <linux-aspeed@archiver.kernel.org>; Sat, 19 Jul 2025 01:55:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bkV9W4g47z305v;
	Sat, 19 Jul 2025 11:55:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:2405::605" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752880343;
	cv=pass; b=KnpJtJ6JpmQD0ZK8XlpxDg64Zrl8Fx5dNIwE+uxUTk7S1Xf/z+okEhHGENnWbMJGpYwlpU9vqB9NSKzov2XFi9TqG7Hv6ZQ6siXNhjlPpnT7iiAU5nbNCDq0pdw7WW1tjigkQC77oQQrCRmPgMXS0T7dFBTZn4SXHAtxmyUF6KqxN5EFk82vhDsb6xBr5t8WtdboCTTZqevTyZNP9KZvt5pje1cCQ0N25mj6GKWJByHGk998c83dNCU81VqrPkwDayeJWWpmIP/RjDad4yXdynzHu5dHEi7YOuTqAopFHMSKwmo6xZyPshNIS2rIvO7QxbsS1yI2xEWynetc/wRBhQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752880343; c=relaxed/relaxed;
	bh=Gwj61VdGZbmkj1z8gtIXqp+9+EvND36erwsUAlu04no=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TnZqyWUpmR+vSAHJsojH07S47RLaRNDHEf21KEuks6deBS4+t2NeLMnS9hR7AUZU7FmFzieKL61zUJY8Cta8Tb7XzZ9BoDWCFQE82wOTsqofF9ClVgAm6kdzzdsL/d7HNeBm6ku6iwSgsTk9W2z98D9SBT2LWPXOhyhxi9epEL/bH9HroOuQ+D8fyCLyAHdpZt5Bj5BrPJO1nzS3VHJ6j1D8ea+hlEBuKisbRD2pvaqKQCn2M+nMKW0sC9YPbbblyS/lf180qR394I+EYmGS6CFv9NUG8vP4rRRBIF/euQ6kfWlP2/Dd7fYFxEgjHvNG0NlH8y5ku8Z00SKYDVV4WA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=tBFYSJga; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:2405::605; helo=nam02-dm3-obe.outbound.protection.outlook.com; envelope-from=donalds@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=tBFYSJga;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:2405::605; helo=nam02-dm3-obe.outbound.protection.outlook.com; envelope-from=donalds@nvidia.com; receiver=lists.ozlabs.org)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on20605.outbound.protection.outlook.com [IPv6:2a01:111:f403:2405::605])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bkQYM1RHkz2yrT
	for <linux-aspeed@lists.ozlabs.org>; Sat, 19 Jul 2025 09:12:23 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VsZdfJ0C0LVNGIjzgmCwUpio372aet2Pxg8Rl0qx3Ts0uHUGvWif5zSs65KBs9ZvAPiv6DDUCR67aSZy10AFh1cU+5EH6o+emU6m7n7FmultfsgnGmkB8vZWKIcUYmqJ3HX0rdms+B6/tMvSIRrzWftbSmoDbmtIBG/ES7HnUh0m05pnW3MyhLmen36N3yqsgTKrz96aMJUk/nhclGrmFlQeYE4+QuzINv4OPK4l9z1fOYPnRZ0HnfsoaMi0w8nwNdLHrhQa8P8whLF4EB3d+wl0BEDySEVc2QsdYxqFozaPYwA5apFmeNsmyvw/fJc4YngLcaHuPS4H6xB6Biv6Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gwj61VdGZbmkj1z8gtIXqp+9+EvND36erwsUAlu04no=;
 b=TVlksoZ3i+krvJZrCGebZzsafLweWFohsQFbM7bAr6O7+RYJaUm+a6cu2nTEkrOF3Dy9vCfzQ14uK03w2XQkfVOv6dNpBY32rCjkkzczrbZ6rVHDMWKw+SZAYGmTlZE/HWWy/oEdb5dqXNkIO2yob01TNaF8VGE1j49czo+1jKoq+YMUXlnTfO27dHrdrAifc8dJmeKlH/5S2EAWWXj5W79ADA1k9pFbbacAvk/2vtEB98rTcgos3701R4zmTZyHu5bxWRQe6KY4GvwrCy/3XnZzS/3dlHBa1OIuQdtQMSz0QhnBu41ZC61BG+0DfWLtG0O0/V47nq6hKukmbO6Mew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gwj61VdGZbmkj1z8gtIXqp+9+EvND36erwsUAlu04no=;
 b=tBFYSJgaExL6kF/hiG9T/2VcvzmR9R4r70tcZBJBKbSQgfniFv9ecJj5V1O8fdkQJqZeMafSuYD83CNZfiVxQeH0LrYLvf+cVvMZBOAMpIXLYdL4MARrKG4KEyIcUFstabfGzOtpVrxwRRU+qBN1mp0p59vRGvOdwQYPrCZJPjg12QkYURBbwBlyh0M4eFMOb08VIEMadUSj9+cU+4XqW919btTKaetwumTwcZeE8foLnWAHRKU+M0DsPf5pPzuw3GEzTJmufatOBB9Xs0yQp/llZiw0im7GjaBCUNx9Va3Ze/+i3KnP2DQTFLGcFa5AFLtg0xB2xKm30QuVm/R/MA==
Received: from BY5PR16CA0016.namprd16.prod.outlook.com (2603:10b6:a03:1a0::29)
 by SJ2PR12MB8034.namprd12.prod.outlook.com (2603:10b6:a03:4cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Fri, 18 Jul
 2025 23:12:03 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::e1) by BY5PR16CA0016.outlook.office365.com
 (2603:10b6:a03:1a0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Fri,
 18 Jul 2025 23:12:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 23:12:03 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 18 Jul
 2025 16:11:37 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 18 Jul
 2025 16:11:37 -0700
Received: from dondevbox.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Fri, 18 Jul 2025 16:11:36 -0700
From: Donald Shannon <donalds@nvidia.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, "Donald
 Shannon" <donalds@nvidia.com>
Subject: [PATCH v5 1/2] Documentation: devicetree: Add binding for NVIDIA  GB200-UT3.0b platform
Date: Fri, 18 Jul 2025 16:11:17 -0700
Message-ID: <20250718231118.3330855-2-donalds@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250718231118.3330855-1-donalds@nvidia.com>
References: <20250718231118.3330855-1-donalds@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|SJ2PR12MB8034:EE_
X-MS-Office365-Filtering-Correlation-Id: 97c103e7-89a2-4b99-309b-08ddc65081f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PJ5V3H32jzkBBuVM48EcDlEdqMylrcGOiArmUOWQoydgBoR08UFcffwIK6Nd?=
 =?us-ascii?Q?7txZGMVxOj2gro6xaENfQsc3dLu05Db4/pmxNQbjTSF5K/xh+KscGI7RLWQw?=
 =?us-ascii?Q?lZiGev9NYFZ9OKlrWFJpfcV2zUtjLKjW1HUzxvDfWC+bFQPOXDS/c5Os9XgO?=
 =?us-ascii?Q?5RJzRHVbChxTf6hlYPKX3wq2V6aIj8MDeHVGFkV3XTpsgqs0C2IVSvZAoiSn?=
 =?us-ascii?Q?hOGdQK8cP1YFJWAsboCK7nSVZltXMbkCAYJaA2GtYRORtc7hdOJTqXVKJ74d?=
 =?us-ascii?Q?YP4irEJ1f1wzX4KC2xe3Xy77kdckW7YwwUad2YArf+hzgEPCQq6HTO2Zqji2?=
 =?us-ascii?Q?cE2ASXjr/5U0+iWc0s1tkEoERU47NgJqgboYXfq9ES0mki/9GpgfPEaMznH5?=
 =?us-ascii?Q?mQu2uYid0OwXmbKghCr3AhnvC3bm3FwjQGzIFhqb429yvhR72ho5cuF9uP7m?=
 =?us-ascii?Q?tTS2Tiv2gPytEVcMNFG4FTuXEsbw4xZPkhqYNDK0MczNBPPOM6NCOSI62rQT?=
 =?us-ascii?Q?bqowbFznqEUPwlqEZm5gycJmj971q7c5rWor1AVcNfrOO9LqY4eeBiEfgTLd?=
 =?us-ascii?Q?xUZZRLJ/UoR9tYEIcei4ALw0U22864BZuSt5QilSGmY/U7jrSamtVwPYCGOg?=
 =?us-ascii?Q?Lh2xzBlEJYsYk6iB8svk9IEPIX3vy4Rg26JMOr2kK6T26T/gTb/qAKgXf3ch?=
 =?us-ascii?Q?L89Uv7irE3LXWLZvcHzhiWL8RHhIJi32NlLvWM/hswDfg28gTXHrSaOt+zL5?=
 =?us-ascii?Q?fKWzZJ7FQikuqWI84dRegftz8hFMT0huTC513GySii8YnVjBZEKmKt8CkeI7?=
 =?us-ascii?Q?r/FISc3uQhmVjfX1Kz6PpdZQPfkEuz8dKbsoTAF6bvwqWKLURKEcNzAKCreM?=
 =?us-ascii?Q?e6w1MV3gF6/2YuLlh0NtwmuGvLDjJdTk6WH8ckTqJ26czh7D5FDqpdJziyJC?=
 =?us-ascii?Q?bj3MBc7OKUbTCrn71r4UJmZNJ/6HiEfIeuEkBW7Y0kU8zW0kUL6yHb+V11WS?=
 =?us-ascii?Q?c5kDS8+rCjqlVlJAOE6jBHb3oVp16WS6XIYk6R3O6+7S/UDHGa9JxuWHyaZc?=
 =?us-ascii?Q?VyVbkWrhW79VhZvBmg2QXPuE6n/XOzJjEHHXu8Bli7fD3m96dlYrkp1C3Wnq?=
 =?us-ascii?Q?FoWYnOeCYoIkTZlHtyiSQAre826lpDZ5Fd3aJUMk7x1w9mna6AGE+0AkQijT?=
 =?us-ascii?Q?6dGNhvWfFf/llG2r2T57neBaMd/NeUajfiTdvVq26QI2KoElG9RHJYinfQEL?=
 =?us-ascii?Q?ddFgMzIQH4+YL+m61gwElKbi+3SjWeiM4qm23SZAktiQw5tExJF8Tb8gi+Xz?=
 =?us-ascii?Q?gfnnhBTRmLOYg/EiAJqJ2bYIZyhgh59OYEk6KeVl1IvY8JA4ifVFDx4fbM26?=
 =?us-ascii?Q?K6CLhSP8sI0xxRbrb1kg5A6uwrEHAqK7t7ceO6HDDNWLzfwaIvPeP4aHBZDF?=
 =?us-ascii?Q?MH2DhstbbK3OlPH6sJwrDCNE68Q9WH36F4l0OgkmxK1AmP+/+Qs4cqcHKj2t?=
 =?us-ascii?Q?U8oNGSl6YIDhM1lQhaVMbWMdXEROmw9wWM+E?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 23:12:03.4913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c103e7-89a2-4b99-309b-08ddc65081f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8034

This is an Aspeed AST2600 based unit testing platform for GB200.
UT3.0b is different than nvidia-gb200nvl-bmc due to networking topology
differences, additional gpio expanders, and voltage regulator gating
some devices.

Reference to Ast2600 SOC [1].
Reference to Blackwell GB200NVL Platform [2].

Link: https://www.aspeedtech.com/server_ast2600/ [1]
Link: https://nvdam.widen.net/s/wwnsxrhm2w/blackwell-datasheet-3384703 [2]
Signed-off-by: Donald Shannon <donalds@nvidia.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 456dbf7b5ec8..624581db2330 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -99,6 +99,7 @@ properties:
               - inventec,starscream-bmc
               - inventec,transformer-bmc
               - jabil,rbp-bmc
+              - nvidia,gb200-ut30b
               - nvidia,gb200nvl-bmc
               - qcom,dc-scm-v1-bmc
               - quanta,s6q-bmc
-- 
2.43.0


