Return-Path: <linux-aspeed+bounces-1232-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE119C5AD49
	for <linux-aspeed@archiver.kernel.org>; Sun, 25 May 2025 23:21:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b5FJR3s8qz2xlP;
	Mon, 26 May 2025 09:21:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:2409::613" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748197264;
	cv=pass; b=jOzj63iavNe1aXvW8dmsH5Q7BUJG/BU0A8IWduP4lYeRQHjQuD7jhmklXWRSs6l7rGB3VNICB4Bsh4rM3e/GDnWjD2lC8nnHrnoTfEOXzFnrf8+6r45dmuDKFX2+oz+Om3L3jnyZcNrBu0xAclNPAEDfvCdEj1fEuCwaA/yisW72QzJQrdbraloIzKNqQw9jwBA8DfJOxdv14S5hYbhtj+dSnS0l0We8hFykkL7y2eL22OhSR5zMdPDsugtGncO+Gk8J5PF2H14CiJjSuouJyXvqSFHwKeAvDxnUhC5/4bHKnW13a9gh2PaVjTzuPHeAPooVNEMPjP5qxRZ7okZk4A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748197264; c=relaxed/relaxed;
	bh=do4K8Loh3OdyJx8PFc5+z6xBC87vcf7taXsMv8fGluM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nnokRBNqoDsyFKvFlVYrV2MYtXkBkReYsJd7NWm3hUqnA1dme3BXsBaabovgLewAAUM9z805bvGU2wY87regmcUlB42sjDexfnpUwpGu3TqSSYTMjnUbB1WYkTnvwigtSLWRB80oKFs3DnuPSayA40JiIKH+CI9A5vqgwqYT9T6ni8CiZumOpnFz7VtEGl7xhV2gyLIVEGd0ZERoZf2ZWewPhTEsLASwILqMOVMQpnyeIjGlwLeqG/sT0Dlqb0TK0I3yLOJCd64JtVk3Ik9dP8tdABHtoaIGErInwLZw5FQtGx+UeZBVKwGYQVwdQUmrCxPIgywOFkVYYqh4627Akw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=H1Lm+LNZ; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:2409::613; helo=nam04-dm6-obe.outbound.protection.outlook.com; envelope-from=wthai@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=H1Lm+LNZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:2409::613; helo=nam04-dm6-obe.outbound.protection.outlook.com; envelope-from=wthai@nvidia.com; receiver=lists.ozlabs.org)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on20613.outbound.protection.outlook.com [IPv6:2a01:111:f403:2409::613])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4b56f76BbTz2xlM
	for <linux-aspeed@lists.ozlabs.org>; Mon, 26 May 2025 04:21:03 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BlveloSxnEZ+bwUnRvB+cAoHfV3Qz9YuxgwDagJ1C5hYIRrFDgvuWsggBLnr8UAmqwLb0kvw9yooXxhYT0cknLLtN8v00lGsqAH6kRU5hLKE4l9TGLaHrA7NTqaDaro787el8J7Sur8fSs906c06RsVGw9kZ4MZQUKMigH83i3tiIfNSkpLQr0zlMmycMpCjdZ/D3WkQcjWEBJMlSuAqjC444KBdHnXjefV+yvCTeuO9+O+uJpD30bRetWCFHOlRl/x2bpPPdFuIuMoEpOqeK5zytpP6SQXG/DB96hOKuXyCDEaDASBSiCYBc/EYPHeyzMb4RvaXVoyZjfK6ZcE5sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=do4K8Loh3OdyJx8PFc5+z6xBC87vcf7taXsMv8fGluM=;
 b=o+cV+9ulNeydE6olV7vZu08CPC1c81ds35+P5dHc9ASsXFz8/6686B7j5kySfwMo8GSG2/Yd4q75RTi2ennhwu5H9oohmVJ1TAZA1VQaaGDrej2RWfYc7GOt6hLAroBuTkSK5KrMErgKN4AE12YbH25xcH/jA0R6RCjiePg8LQvc+NIAvUnxT+RNypb1etD3/tvpikyNhlAdQ2HtRYJ0Expechtl/Q4v5sGFn79NWt6s/maLDWJwZEk6ZWGmXcl9B9xRp3bhpGC3SFJrwg2bSWuQEnnHbpIavuMUXRXCxyN5c6mhQxoBAbCG0HEFG6RATV7q9+qlKgQ9ezPJfkW3PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=do4K8Loh3OdyJx8PFc5+z6xBC87vcf7taXsMv8fGluM=;
 b=H1Lm+LNZO6BFCx8JzK+1xe3KgvB+IKRwIrPKqfAVZAWahcfohRHKnQN3NOp23mDy9suowCVXm9meMLueq8jv4d6UPMku+rK7K8ZPF9RzQ9k0O7L9nan2fzXGICaPQHg/efrzvmRg7wFsLbSzYlhrwzeoR3PSU4kAQElkXIzAr3rWBqCi2OwCrujgsd64ikhA+Yro+xXYZbzdvSVNxR/CXOaS/sBPdp14xKI/C6gEXJi8bmAax7iXtdz9t1kfCAFUaWDfzcwuD0iWKrPDojmInfqosV4GKPRjxqQDXDAUrTzVZhvrvRagaLDs7T4494sJwi/EPppvl0x1lMD1GMtwgQ==
Received: from BN9PR03CA0986.namprd03.prod.outlook.com (2603:10b6:408:109::31)
 by DS0PR12MB8415.namprd12.prod.outlook.com (2603:10b6:8:fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Sun, 25 May
 2025 18:20:41 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:408:109:cafe::fa) by BN9PR03CA0986.outlook.office365.com
 (2603:10b6:408:109::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Sun,
 25 May 2025 18:20:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8813.0 via Frontend Transport; Sun, 25 May 2025 18:20:41 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 25 May
 2025 11:20:27 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 25 May
 2025 11:20:26 -0700
Received: from willie-obmc-builder.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 25 May 2025 11:20:26 -0700
From: Willie Thai <wthai@nvidia.com>
To: <wthai@nvidia.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, "Deepak
 Kodihalli" <dkodihalli@nvidia.com>, Ed Tanous <etanous@nvidia.com>, Leo Huang
	<leohu@nvidia.com>
Subject: [PATCH 2/3] ARM: dts: aspeed: nvidia: gb200nvl: Enable i2c3 bus
Date: Sun, 25 May 2025 18:20:18 +0000
Message-ID: <20250525-dts-v1-2-9ac63ad3bf15@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250525-dts-v1-0-9ac63ad3bf15@nvidia.com>
References: <20250525-dts-v1-0-9ac63ad3bf15@nvidia.com>
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748196599; l=868; i=wthai@nvidia.com; s=20250525; h=from:subject:message-id; bh=q+N/omn+ggT9/THkrPJFVeKH/3EorWLmD7dd4Jd47RE=; b=boXuMmg59+yTIYFdgEOh27jfDyyiv/ntcVPZSYBg3GYqKk8i2YaH0RE4CB2WaZclzN8gRtt5q PSjjdlmBZdqBW11IqBMdvRe9WPp+85z0QpVxmGJpX3sx+t/79QKLMsK
X-Developer-Key: i=wthai@nvidia.com; a=ed25519; pk=i/6dxnUqKdr7Z6GA0KECRkwz5HX4RCiodw0v6kB9fbs=
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|DS0PR12MB8415:EE_
X-MS-Office365-Filtering-Correlation-Id: 73d9c31d-c63f-44fd-df30-08dd9bb8db93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUdsekZ6Z3EyQXdEQVVGZHFXd1FMdHJ5TFV5dklWNXlPN1RUcFJQUFViWFVB?=
 =?utf-8?B?MHlrNUh1YUlORkk2dWxUSGpHVi9sSU12NFUyREpWdStPeWdMSUZjdnhWU0Zs?=
 =?utf-8?B?TmYzcEZNVGpvYmNmT0gyT0JQbjloblVsUnFyUHBMNisyYjE2U3N5ay9vWUIw?=
 =?utf-8?B?VmxPVHZWTURQc3ZZT2tkdWE0NXAvOGh1OUJhK0oraHlIQlpkellkcFpGZ3Jw?=
 =?utf-8?B?VkRSaW02eHZuUEJ3L3h6WjFlY0xZSkJlbnlmOGJtdnd2Zk5QcDFLdUZ3Y2gv?=
 =?utf-8?B?Z25mUlZZRnVjNTh2dkFRR2l1aGRHWm1qTGd3aDdmTXhQZ2U4bEVYRVNYSFlS?=
 =?utf-8?B?eHl1VHlSQSt0eFAyUm54Y1FSUm9xY1Y2N2pBMHNFMWZsZmN1OGs3TlBKd24x?=
 =?utf-8?B?RVgyL2c2Q3VaNVJTQytVZkJ5MW5IVlgxaUpZemxsM3VEci9YVlR5eU5zVjli?=
 =?utf-8?B?SkwwRy9MaVZPUXJYRFZ4cnNCc3l0Nm1HNXBqVXQ2d1J5bGV6ZFBsVjBUREg4?=
 =?utf-8?B?MUNOd090eHZZNzNmMVhXVkNxUjB2cVZhVXQ4VjlFWUsyZUs2aHIrVUV2Ym9O?=
 =?utf-8?B?bVIvQStPSklTTnl6cWpBQ1ozQkFYUzhyazBYaG52aFNyd1hxN2wrbEo0OWZa?=
 =?utf-8?B?dkZ0bkZma1JyYVlTQ3pxVUQyRUNvR0MwZ0lTNGw2dGJ2OWdCVWdadTdlOVdL?=
 =?utf-8?B?V2pDaW9Xc0E5OVk5cVMwRWtQcVJCcEQ2UEx0SDJlM2lDditac3ZleTJHcEVv?=
 =?utf-8?B?MTY3ZXBJRnRsSmZzVFExUDcvWGZCVzlQeVA2b21EUnBWOERuQVZjeTVrVFRC?=
 =?utf-8?B?TGpWMnJNbmlQRXA4R1FQQlNiRDJpUVh5b2lhdmxsNEtPSGRGTittaVBhKzZz?=
 =?utf-8?B?SjFYbnVCNWp1VktZaFFLZHcyS1QyTkdRV2J6cW12ZGNESGNVdmovdENQbXFE?=
 =?utf-8?B?NjgvOXR5dERod1k5M2dZMUNzZnZYYWxIMlFRZG9lZGNncnppOGo4ZEFTM0Er?=
 =?utf-8?B?WCt3aTRwaG40V3BFTDRJZzZzbnlXcFVSaFpIUE9ueVkxTFhwVkNiVE90aW5G?=
 =?utf-8?B?MGxQbmptM0lZN0pBcElPZVUwcnZaNmV5cmMrQkw4bWZoOFNReDBqM0xBd2Uw?=
 =?utf-8?B?aTdseXJVOU1nRDR5dXNMMk9QdHQzZld4TXhWRnowSVlkcWt0RGd3c2plNmJR?=
 =?utf-8?B?dGpnc2lUalhxRC9KUE50THdaTWJqS1FiRC9aK091UTdpQlJDVWUrcDZSZkpD?=
 =?utf-8?B?aTVvWm83OUhNZzBlS2UvZEdvL3FxanBTbDhtZmRMZ2VTOE1kY3JQSm5Rb09u?=
 =?utf-8?B?SCtGK3pzM2JzUmh2dzBxc0kxajBsbDN1dlBoN0lTd1pmVXRNT01lMDJvSktv?=
 =?utf-8?B?MGNHTUUwZjVaN0pSUnN4VWJRVW14WFJmUDNuZFJQSWlZVE1jenRNcEJDQXQ4?=
 =?utf-8?B?ZklwTDJHd0IyTC9BSHlLWmFlNVpCSFRwMThzV3R3bXJ6VmErMlJKNjdyb05X?=
 =?utf-8?B?QVZaeFA0bk9jeW1GTDNZWjFJOHc4SHNsMk9Ya0VPNEZWNHM4dHl2L1lmMXJX?=
 =?utf-8?B?SDJHeFN0eXBKS0JHS0Q3L3RJeS90eUdYK3hzN2VMb29obDIva0w3UkR3cUQ2?=
 =?utf-8?B?STBiT2FWWkEvM1FsN3RRVE9zUVE4YXVvOVd5c0ZXczhCN280UTlFUEtvcDh4?=
 =?utf-8?B?UnN6TVRXdmpCNjM0K3IrdUlFbGJrTWttb2VwNTFLTmFkUERsOGhBUzFsd09S?=
 =?utf-8?B?cXpLQm1NTW9MNmFmUjhnTWQ2elM2VGhtR1FGZ2xQYmd5SGNvM2daN1hkN2c0?=
 =?utf-8?B?OVNjanY2NUoyZUp1elVadXE5TUpTUFpXenhrbWZQdm5nZUhDcTBTdGNtbC9I?=
 =?utf-8?B?QW9BaTlmWmNEOHhzaGV3Z1R1YkpuZ0xGcnhwcnVBOGxaR0VQdTZ6VlJ6Rmpl?=
 =?utf-8?B?TVZyOERiOGM0WDNwR2s0VVV4cVM5d3NkZ3JUUXFNbHNVWmxxS1ladDV2NWJy?=
 =?utf-8?B?bjVCN2lsQlBDM05wNUxYN1N4Zy83dEtCakdyWW5PYjQwVXd1VE0rVkwveGxh?=
 =?utf-8?Q?vobWpN?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 18:20:41.4581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d9c31d-c63f-44fd-df30-08dd9bb8db93
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8415

Enable i2c3 bus for telemetry fetching purpose.

Signed-off-by: Deepak Kodihalli <dkodihalli@nvidia.com>
Signed-off-by: Ed Tanous <etanous@nvidia.com>
Signed-off-by: Willie Thai <wthai@nvidia.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts
index 0b0abb259ca3a68b43dcfa61df69b8a15421d67c..1240f6ee92c8164dc642a83d94719a73c1c9bfd5 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200nvl-bmc.dts
@@ -421,7 +421,8 @@ &i2c2 {
 
 // I2C4
 &i2c3 {
-	status = "disabled";
+	status = "okay";
+	vcc-supply = <&standby_power_regulator>;
 };
 
 // I2C5

-- 
2.25.1


