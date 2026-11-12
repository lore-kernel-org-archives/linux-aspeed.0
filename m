Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9777560A2619
	for <linux-aspeed@archiver.kernel.org>; Thu, 12 Nov 2026 08:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=G3ehzeG4
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQD1V6kMNz2yKn;
	Thu, 12 Nov 2026 19:23:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c005::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794471822;
	cv=pass; b=B08Th5IgFczUN86a7ETr9da2pEZOR3dmhSVfLmW80le4OAxtCynwXEZW39rB46uHvHsWTzfDRZPd7D8+vyiziC+ysl6fd4Y2fYgWuepdaloAZiKEjW4KoGcKbjAGUMQS1xnYjBjNa+Q6ezyGHggnM5ZDx+S3n7rCUOMGNYPIyGMmYN3kNi39MX+hfJ+VAo/C+qA5Do7yuyHkLBmaVwnM9kUIaqsILUiiuqK3KjaNQiVE1XDSI31m3S0X6QMHZtBKmbQvCZ4ZnyFRKkENlkSGrO8Vc2f0WJJO9lhkhIIXuLVjGFD6ItUD2w82t1MfwJ6EksnwJS2Ja/BHU+5L4dVp8A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794471822; c=relaxed/relaxed;
	bh=e4LILQ0oDyxIIfLvvUdZA5CSXKsoR90I44cO0Par/ZE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nlm0REbZdwr1o2GfsQ2NV5bWmok9lscHibxTBb/K0nCEwMHlkOww5WV4BHRbBUcHnlV6UKl22N8uvqdD8H/pYhUYVCSW0KWOBQWKgXIoB5Tp6ZsOzwCSWdXH0n+eiJoV7ypN+JluwFbfpdIHiLo2MGoYik1OEeUi25ffuyv/zhV54uPhv/VYXsxLSlKHSDQjJA7K7ilU9cpNpTk0YQ/copOfRZql2nsaYdVuJxu6WdQ8Zg4AF+nlHNSq1+8BXSOtPpElK0EG9kUgFwgWk7gcSXSvRNndgSwqIVLQz/6ZN5jEmrWMwbIjQp7KuOX/EbhoRARe/y0COm5CI86SyrVRCA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=G3ehzeG4; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c005::5; helo=co1pr03cu002.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=G3ehzeG4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c005::5; helo=co1pr03cu002.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org)
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azlp170100005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c005::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQD1T4MyQz2y8F;
	Thu, 12 Nov 2026 19:23:40 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d0sOyoZ6ziLDuPWsp1p44E/FEikwoGQ6gJ7EiV/H7V18Ho81iBpAk4cNpFb61HMTpUFk/WVtUuu0pNyaBrSs9BDuPWIW2EX3t+w90WJVgQgmEgg4OTlHS97U8ctPjCxAwA8jWhq2bzRlOqseD0DQ136uJkt+EQXBDiEzEWus8wzE6qZxlwSqub43ohp5st3DBlSsZHFl7C3OY5FO8l4wfeYg/M2KWAthHK0dzD3Zux+tsASNSUqOxbw0kVGrwuZxMxHjy3MhtWTrz9RtK0BdCyGxaRRfXa8iV06WH6AFRoe3sKM3Jnl42lhAx+MxE6oLp6ElJyuNE8fjK6fnnw8W6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4LILQ0oDyxIIfLvvUdZA5CSXKsoR90I44cO0Par/ZE=;
 b=wjkr0XL3vSxwPePrDmLQLwN4MIz5JVyM2xYoFmFoBMWCBDF+qMvg6DPoY5NWXlCsCNnlFS0QDAi4hcwtLplbyFEn1p7sBnZZFD1YvMsB9K+YXMjkFnfzVISjQhUOu+VeBnNKG6IIeGAq3TMuSdIoGcy8X329L/io1w4iNEtVZk39BMLrf5mIcQlGz14KU+G1ngxc7b5GKsz4LqbCRHSwh1bBynm8Vof3NEYeN1jjEaK3mrvkjlKDc1N2mb7rqsCWSIPUb/EdsygZ1KXfrSmWV5cHHbjuSQqRVRHZu+JIV9dixDFEKQez7ud4JC+4ZVkH908F5W1cwx9TDdi1zQMJjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4LILQ0oDyxIIfLvvUdZA5CSXKsoR90I44cO0Par/ZE=;
 b=G3ehzeG4SWAxGrFOUbHjWxQlJ5fz3hjJyTeaOqnI1vnsoiu/ZccTbQZtKYkw1qJmf/flODKZ3yrlu2T9KFu3Uuayots67XRgNbVAi6sdfsylpjYvr3o99JVcB1JBSg0ETU13YCAj/Wxe+VYzV3qEg78bFC1apXYCdNSTGM7fgiY72ELFKTCn7QoA7kowuZ7DAbIlYBcy2/pde5twdMXrF4ajlgYS7ZPhafmfHpcTgf1gkjkaFViNEVrSJQbJ4HWXv8cB6DKxfpM5jU8I63X8izDBn/d0OqGbNPzsSsm9LHQxXWaL2DthJE0C5U9/qDz1mnLVyZvRaVY27Vu86/NTbA==
Received: from BLAPR03CA0148.namprd03.prod.outlook.com (2603:10b6:208:32e::33)
 by LY0PR12MB114387.namprd12.prod.outlook.com (2603:10b6:404:231::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 08:20:31 +0000
Received: from IA0PEPF00000037.namprd03.prod.outlook.com
 (2603:10b6:208:32e:cafe::7d) by BLAPR03CA0148.outlook.office365.com
 (2603:10b6:208:32e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 08:20:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 IA0PEPF00000037.mail.protection.outlook.com (10.167.249.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 08:20:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 00:20:14 -0800
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 00:20:12 -0800
From: Jacky Huang <jackyhuang@nvidia.com>
To: <andrew@lunn.ch>
CC: <andrew@codeconstruct.com.au>, <joel@jms.id.au>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <ryan_chen@aspeedtech.com>,
	<billy_tsai@aspeedtech.com>, <devicetree@vger.kernel.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>, Jacky Huang
	<jackyhuang@nvidia.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: aspeed: Add NVIDIA MGX Vera C2 BMC
Date: Thu, 12 Nov 2026 16:19:41 +0800
Message-ID: <179446463981.2115010.3419271617807766116@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <9e83c1b9-0bfa-4a37-8253-3740dd7d0b62@lunn.ch>
References: <9e83c1b9-0bfa-4a37-8253-3740dd7d0b62@lunn.ch>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000037:EE_|LY0PR12MB114387:EE_
X-MS-Office365-Filtering-Correlation-Id: d116a03e-5141-4b1c-287e-08df4095d127
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|23010399003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 SZ93cp2lVfz5ALJNSScXV6k8EUovjESz7p/VR81ixhdtRvkuoz9w9TsB8eb57cQEuGLXz0jIGe+k3mTjJxDkNlm0SSff/JsTSDz84wvX5rwydR+v7V5CAbcfl2uIDu5nTBn5ckESdi/AbOdHYmYooERcWfpUcGgOROKDddW5m82+KnhkuOsvQd/p72MjrM1rxyI3vFCS8Y83sSYxAJVBwFGHmfCzF4WHk1bBKA4+0SKDwUzVrwW2r1UOUKembC44jpiaq3h3ETDR0GhsLzin27uIq13EqulJcK/Wjlt2wzNAD+l+vcs8tcJnDG5M+/gXaXMdbySyG1owNWC6ar2FbLX6cUQ99uHKrHU2m/l1fizFhZgWjQ5WxQq4/a64hP7+HcLjjJllA9oXDU2LK93MI2jL3PDMS+7rxxo41meZSDRbBpH3NdJoGFGN0+V3qUGpu3wSaziUXBstle4IkxgEn5JCz4mipHlb4BxTmYcxAYJOhMJAqoWmH0RAfBzErArBIS4yxMnWiMBIFoTiRAQ5UZr1BUgaT4N5576q8vLqcrvwNqbXxiEZZGV3xpljuohGR/zVe+dIlWB+7rqMZBelL8EQrZgLRwFYKTXvrXDW+EjYqIj2Z2onkk6p28KPxwNZCD1HMbatTNzFNfClcGEkuxouUYxL/djPtOgU2Hsw7J8+I6WmO+zIIy/rV/P04Q9owYa095AIY3nBwFAjm4+jXg==
X-Forefront-Antispam-Report:
 CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 Jr2faccgnFS/iFRtwdNuLqOqoBAM8dBF+tSMW7GYYy+Nb94bkUu+ob7P6KlJ26sV9x+akfSlETo6rNSQEDJEm0WJJntTsFgT0+zlM2Ad/92OLXaR+NYTTY03CM0jhAoR2sV3xlVGV/bewwQ6G2DvZhPa3hU6WiTS5x+wFmZTiD5Sh0RWLUCU1Z3dvFMzPlWktO+aVxA13sfcl9+x6VqEYadTPZelguParHMMt5NU0j1jQcuvUPHJ7xxdvr2aNSlKLhIFCEH/q1HE1x7efM5c3gATow3H0RrgzxApP/MdjmxwK32f6Oo28x0QYbda043vpdinD6RWvz6CaJ3fU9h0sCDn+Wh8QiltlGqsEhC88KzYQWHMdDIWPEi7MzHyrlrUsxGnN/9SycAJE3NMyts+jYv+XcfZchzgzX9UbshJsy1lVuopdobVfEBOX0Ipentt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 08:20:31.1532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d116a03e-5141-4b1c-287e-08df4095d127
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF00000037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB114387
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Andrew,=0D
=0D
> This comment is not really correct.=0D
=0D
Got it. Many thanks for reviewing the patch. I will remove the=0D
misleading comment in v3.=0D
=0D
Best regards,=0D
Jacky=0D

