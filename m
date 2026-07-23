Return-Path: <linux-aspeed+bounces-4549-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABBFDC531C9
	for <linux-aspeed@archiver.kernel.org>; Fri, 24 Jul 2026 05:18:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5x9H6d7Rz2xYh;
	Fri, 24 Jul 2026 15:18:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c110::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784791909;
	cv=pass; b=kh3O1RWGV7ZLGwpWwukhly9JUDaiO/DJ895Exuow+/smVn22pfw6lmZcJ0ITnJ26Hl1XWuifB7L+6rV7IWM1yX50Q8it5HfITS4Xx0Hdocd1ILivBI03cS7Bqjk7fAO5TNjyCdTan8OXkrQ3Pcu9rxcIOxbYSvj0MzoUqYeISNb/HvUnwGi11CDJVRc16UJXhsgg+fF6ehW+YMXMAHrEUONREgd0a2ZW7VWSdtiKE9ZzBXl7yZAPHTerhTXq42jrdx8GnaYyBJTc+GRBs3leNqbyUL+MyJWlEMKaQb/9QbFuEhXzaZXk4RcSmM7smOMOfsM27ZDcekxLAVzIAWS3HQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784791909; c=relaxed/relaxed;
	bh=MYVKE5mmJtjTn82FVjCAbZIeCYNYBOqPUJMSpmeG3ps=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lmATKJum/q8u5JL1Yr98ffN5BVAiIlk/wInF8pEzGJ05wyedwke2hDhU7rSgBTMjGQwSKglQtWLfnAejl7S1YLXU4OsWSs5U6Z9R6fxCQrZTncgHdJaiFhOD/SQi66QiaULA5OLarB7Chaz31nRHbwASAVW14KtWO5jI4haZVfU17rlxcuZt1LDEfxlLdJVEva2yu4LEJIkNrsmKM0f8wkCHA+pt2++Q1meqUT1621pbn8maBRE6jZyPfMv2HYNFwc+VdYhKj3ayqBccXGD8QcRJwnY4avtpyMhJi/c45fpAgqRprF0cycgMbWy6BiAiRPtmZYbmt30f0FkGMiFOUg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=slec681P; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c110::3; helo=bn8pr05cu002.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=slec681P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c110::3; helo=bn8pr05cu002.outbound.protection.outlook.com; envelope-from=jackyhuang@nvidia.com; receiver=lists.ozlabs.org)
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c110::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5N9J1YKHz2xs1;
	Thu, 23 Jul 2026 17:31:46 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wozJle++uxB+kMApqZfEa5wQTcw7N1B7DwlUIvIahFLrq3BnQD8Bcwi4uIRyNqGdGsx5KqIzFyTcO9h7vlh4wmhOk15HmlCyDmjZvPpq1P/0RfTjdKnRmY1gYogy1sBniY9Nh+WrXVcUrwAB6reKA1MH81BjButV+xH1K6C9SkA58sUZjjAN21Ia0VBEcw2n4DAj7fdZ46jHNRZTzTfNXukkBzJ4DbXcqDJAEezBNGzF3Lz0PxFhmTYo1W9fY8JZG7fJkmZktytzA/Uu4RbXWi2VnXQjhraPrs+uXhGan2M70XMGV4vy8u7BKk8vBqqpDPNFP1zGyYL7HKojp51mWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYVKE5mmJtjTn82FVjCAbZIeCYNYBOqPUJMSpmeG3ps=;
 b=CLQyd0laxttIa980ZUbWep8xKSTq7Q0pSeHqfPJ62Bmc2hx1CDkJUWHHxDXUVVJ2tnFvhW7RADORvqXQkN3Wgr0hQkHVj5YBt+oxpG46TBiZjvIdOEiYriesjjb6rMDbNEvIN4zc05OF1TY35jR4C3ToCLCnjf1DrDSFgkLppXidMKAMKUDrRVQ9u5s4WCwKwyvrZdJlIS5UU/npEEF/9YMyC361PhH/p2wD8qr774lQs9ZjGtk8oi2P5d+VQZOvi3/5+idIB6SotxP+ANWRMVpzCfNdzMs1wZ82CxZcyPaQY6J5GtXu5zAUT9rBxoxe4UcvyI37/E+WDA9kGPV19Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=codeconstruct.com.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYVKE5mmJtjTn82FVjCAbZIeCYNYBOqPUJMSpmeG3ps=;
 b=slec681PwAQ3piONRgV61w22T5Z0GlIvnZPIfbXdZaez2qz9YSh97noROK8ulYpC/njjmkLBzM0lVxwI2UhN6v2aeYSqG/MoySx8Jhc/ceFHES0U7Ev45uprtvztakDwNp7/Amcs6wt1ayCQR9gVpnNVrRMxESTfmle7XGrbgSV5QCC3TbOAJnEccq7HNQ/D9DoRY/nCQiphmeyVNknEQSnQHy6SK/EqD5AWjKBo5jhwQp3AhmfkbsJjTX3m0hIAUzcuPIXdf2yFyqKOLE6FfiOmygQ9C7kwBhpERZuv8KcQzfAGaTyYPZb9Y8YWn5C+cXo5Vz+cxVvN9/p1I0xJpw==
Received: from DM6PR02CA0126.namprd02.prod.outlook.com (2603:10b6:5:1b4::28)
 by PH7PR12MB7308.namprd12.prod.outlook.com (2603:10b6:510:20c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 07:31:19 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:5:1b4:cafe::8b) by DM6PR02CA0126.outlook.office365.com
 (2603:10b6:5:1b4::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Thu,
 23 Jul 2026 07:31:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.0 via Frontend Transport; Thu, 23 Jul 2026 07:31:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Jul
 2026 00:31:02 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Jul
 2026 00:31:00 -0700
From: Jacky Huang <jackyhuang@nvidia.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Krzysztof Kozlowski
	<krzysztof.kozlowski@oss.qualcomm.com>
CC: Jacky Huang <jackyhuang@nvidia.com>, Joel Stanley <joel@jms.id.au>, "Rob
 Herring" <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, <devicetree@vger.kernel.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH v3 2/2] ARM: dts: aspeed: Add NVIDIA VR-NVL BMC
Date: Thu, 23 Jul 2026 16:29:55 +0900
Message-ID: <20260723073032.1666282-1-jackyhuang@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3b6aa85161702da4322cc361e500a90c832af6a7.camel@codeconstruct.com.au>
References: <20260710054849.3178747-1-jackyhuang@nvidia.com> <20260710054849.3178747-3-jackyhuang@nvidia.com> <b707f061cbdfe52f8d72ccd33ec177113e20a5e5.camel@codeconstruct.com.au> <3523fefc-8ba8-4512-b088-7a94a2df73f8@oss.qualcomm.com> <3b6aa85161702da4322cc361e500a90c832af6a7.camel@codeconstruct.com.au>
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
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|PH7PR12MB7308:EE_
X-MS-Office365-Filtering-Correlation-Id: b48fcbfc-e735-4993-3226-08dee88c631a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|7416014|376014|36860700016|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8cIsfS6CTP7x6Do6tFgWn2ZyznvzelN3y+Kn0r/bQ39LC+pcsnJntlLPEUGW8wRE/dol8HCX2jXmey0zvy0NEzwNzG+F+3oPK+rz2WrwdSX7AxDBo1LnfYBv+js07VH59UDGnCtSw4t2imiXRaWZFUwHkaenb40z2aJsOfFve2VfjkG1rbOA7IkkFc3kcHOR7hT93/yBfyR2c65q5XrZDeIFK75afr94xwc5cI7mbAg/nMknhk64afkh2AzqEuvQMCWrjWnjQMeKrkLMpFzpTZtnGewTUeRj55F8RS0xuJSS1VqCHRb0an9M/GYqQTY4+Y3l/iphrPNOMZAiKVNP/B+IeJI1CfglVs4VirN/BMnRzqNqK41A0u+3esp4Aly7vUS/eZbQDrXuK42Gw4sMuNFvP698TMT8crMSa+XizqLDd0Krc1fZ+MAgXpVsNM2udTJnOWYGgYHIOQ+1hYcgotozTGwLcMplCEVK5qbhFMesjC11JZYoXee/yRg9kKQGeMmV+pdJJdc4AUDpAj3ItGerIShd0S7izJkE8Ph+mxGFdRLhMkhhu1jyqx7jRZKlLodDp3GBbz9jIvv5SomuZ/NaJKvVZNtC4Cf9vNex/ZAoYtxKhSW+yYawkGG5RjKAajRV+LXBHaF8DN1bj7+K9DjfP6UC3UHmTuHpl0CvzNUdwuhHROAaWPcQRYFgU8BZpq7HNTZEF1NWFmp85wjxDw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(7416014)(376014)(36860700016)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Z8rxm3BZdAMw5MnG9djBN1yq3CFH8Q2nNrrDsHcipvGTtEf9J95mI6lqyBiXTEF6xlCkPtVJCnBMKUDzrE8HIjRzW2ku1/q273zmIT1hHpbfI2+BPAyene7qbqcJms5tn5pvNPXdD1Q2PPV8CXsJVQb+qA9uJZqKD71Nm2f1SsmGJYKIjgwpRelFDZ2KP3CCnU53lSqbdFZds0WTRzy/9XsbAHGLUXSbL4Hx+31abLFM7K/B7Bbnu+Ltpq6E2qAeaJfvudP0wFsr+k87UbqULIVpliB4gMBNMk7Bfy7wD3v0p6JcuzyCZf5Puk4vJuyGry0ZDCWZDikXedHSzxpyy7GK+MFp6HyBi5GHEXnYKmM0erjK2iJFARRA1gTfiGUs18hiAWXJfhnE6mc75UkABGl/he77lgSpxMF2RYi7ragjFA2l22USkESM91PyD4Wj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 07:31:18.7273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b48fcbfc-e735-4993-3226-08dee88c631a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7308

Hi Andrew and Krzysztof,

Appreciate the guidance and clarification! I will address the warnings
and prepare the next version.

Thanks,
Jacky

