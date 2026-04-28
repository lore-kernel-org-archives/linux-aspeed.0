Return-Path: <linux-aspeed+bounces-3964-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D65BFF8864
	for <linux-aspeed@archiver.kernel.org>; Tue, 28 Apr 2026 03:31:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4QwD5CJZz2xNT;
	Tue, 28 Apr 2026 13:31:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c001::2" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777347116;
	cv=pass; b=N+1IZ3f1zv3rSj/VyikxtnlggZjObgx74c+7DmwxyRtx5jnindhqSquoB/AUt9Krqkm2fwMrpQSsLy0CQa9eSIYzTh2xeLBVU23NOV8gvcmVrKkHKC0xtISTcW993b65FDEt2nlbZw2FhO51WdazMseLWzsRIiZ2wIhaX0CN8CxdpKLT02U+0qQ6CLzfyhYuDMUy/1KbpbEA2sf98peKDCpi/ZATKFNPH8YrAxUL01/xCziq7mLC7e8wKXwxK369iII47C49tEzHiXXEVcN/tZVIXE4yhj39Lv1gmnDe5B3AG4HqmHCpp6dYsrpwh6uU6LEPAtSJ+4Myjeg4njEY2w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777347116; c=relaxed/relaxed;
	bh=IPAw+VXC8+y3YUlxVpxzSlfr8Uy/2ZiQSS3mhg31VXo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W6OgGDRKgmzW+mNguqu5tISwGA90pe3R0+ZxYczTG3+iDBchecYBgUTJ0NUFNk7XkhTCwJrWrpzRPNvfDLNUBNY30EpvQ38BfIjsVSsmlYK7LxcHF1LKfIiskzlHh0fjzmxvzn6dtiYx1FcUUOIqJEFezdS1yjtXKduhgoTEe+/Knx1XBT8pXuNh5p8CIq3A2LDXhnUZQkn82JqwMiyFrGT2Om2EcZO1hWtRSwHm/2RrkYMN27mPCj5iNYNoM1aYKE97eEdKJLCpaMr+/4XtWt3luoaTC6+YGTLP1uNzXa69TUP5whcOunISZoycyMyVYC/ncPGiF9GBWkUQcTcjiQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=etJg0UI5; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c001::2; helo=sj2pr03cu001.outbound.protection.outlook.com; envelope-from=andhsieh@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=etJg0UI5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c001::2; helo=sj2pr03cu001.outbound.protection.outlook.com; envelope-from=andhsieh@nvidia.com; receiver=lists.ozlabs.org)
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazlp170120002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c001::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4QwC64Sqz2xGY
	for <linux-aspeed@lists.ozlabs.org>; Tue, 28 Apr 2026 13:31:55 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6TKGGVQlAJHkE9vc5A9r9qjk1xGsWEvRCj4uVx02KS9R/bnH6/DIIWs4KdM6YprRTQ1hGp6QW7bjxUU8KetCotpJQ68kayInSu0zzMvOYaaol8cxbmFtxAWfsyJBWlbQIXy73cbnB/A2OOKgdy19u1EMVzePWTdHvu6B3pMn+1H2QJvzcq6mUWXdvEBaVjrpE5wc+BYsayNuxZ2GXFoYgcfzQvOtPfW+E2CuDQgT7YGeXvTXRF0mOiRnXE/RdrQW4+WrnqYsUgXNlPds3bVZPeEhWRNykzB5dsy6mTiERj2R3FbZ9d6ulxRiq+Px0yMrc9qd1OLX4bmHGXZRLP9PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPAw+VXC8+y3YUlxVpxzSlfr8Uy/2ZiQSS3mhg31VXo=;
 b=v9jYI3qDrNi4+zqPeNy1/96v//ND9IYNPuXtW8vjp1MdU7JQSc31j4BFgSwJGWHTsfUk0NxIf6hvq/04HoL1yUfXbXyhwHCcUTp23/GIN8cMPzO2XOwUh8eBnDf50FOLpCz1hchl8lde2sjVMSvnkWelgE48PDZy6FPuBYvf1uOYq2A1WYJngSxoEbHajHz98YodgpH3UMVk3rT+6n6dvhmxZXqdKGoRULMZgSGKafakkDJG60Up86LevGOHGv1H0wORhv/KQrPJ+PCl6zCCG+ZaEwUMO9X26iJHPqQl89EEIgJ0VZjqYZPKL5vawEmS7KALwaWwAzGh8H/B9F2yTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.ozlabs.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPAw+VXC8+y3YUlxVpxzSlfr8Uy/2ZiQSS3mhg31VXo=;
 b=etJg0UI5Blub70eDYNV8K2dhU6fmxwkcPc6OZL2k1Gp0bbT65D01AGc2ZDJVRMlncOzd/Cd8ukCzuMzd6tkD4C2ajMtaMxe/YjPiwTo8Td1k2Ion8DBIL3Mp37zyJi9S0cA5mwn60pFbNgcOhQ7ZPNHKDoepcC1mfgrAlS+YARaBgqKruYsMKnTjerBQxNnpN+RdYPS22NUdCRR7An4+6vYsODcHYJcm4lkf8gcKnP4fL3upId3W6Kyo4qmq2M7fQJTeIa/GbdRUcTd9GTUjtGHLc9LhdLmpb4DHsWMjg3lZKiQ+1y9rR+nM1Uo4JdcSAZKAEMWxzZLdcsZKJBMOhg==
Received: from SJ0PR03CA0065.namprd03.prod.outlook.com (2603:10b6:a03:331::10)
 by DS4PR12MB9610.namprd12.prod.outlook.com (2603:10b6:8:277::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 03:31:28 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:331:cafe::10) by SJ0PR03CA0065.outlook.office365.com
 (2603:10b6:a03:331::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 03:31:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 03:31:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 20:31:04 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 20:31:03 -0700
From: Ender Hsieh <andhsieh@nvidia.com>
To: <linux-aspeed@lists.ozlabs.org>
CC: Jacky Chou <jacky_chou@aspeedtech.com>, Marc Olberding
	<molberding@nvidia.com>, Andrew Lunn <andrew@lunn.ch>
Subject: =?UTF-8?q?NVL32=20BMC=20enablement=20=E2=80=94=20offering=20help=20on=20ftgmac100=20work?=
Date: Tue, 28 Apr 2026 12:30:48 +0900
Message-ID: <20260428033048.2694433-1-andhsieh@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|DS4PR12MB9610:EE_
X-MS-Office365-Filtering-Correlation-Id: 70dc8cee-d69e-4fa3-1031-08dea4d6a150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	1z10QO4EPKsC7gboYhp31z3qJInfbCTtDHGzX9buuxHZtpiz1ztU4o7Ph1ioOZx8Eevpid/SnHL/1iceIXgtxDCmY535sLGrE2ZLPdvZT7BE5iOMHNKjBSpAbpZxiWJwGbX3wTRk7f/IsAf1gL8YYaQ7Spd5xt1yEYS/ub6fop8wvwR8aLcfoWGiLnWciJL9ih6/mjbIEIL/J2ieyzyud78cv3UU5MXVD6CBJD0h0d201St9qPhEMS+nNw0QBUdWypBmqPmmef5U6oNP0sOSM3748br/S/miPKpiS0htwyQqOvvWRkMYdxuU01RT3ZaJqQSsIvHTEMlo59JbTL/ktU9NxiDvFZapwPpkWzpv4satMx/tSAcC5E6rRmlQvdvBexclAej7TWDGlH1YGK/c5JvCaC1RqIbiz7vg1uudxSVfJk+6jqUfxLzWJfjEqLYGB8YLUmYhgsblqFHkG7GQyEalFNEah3PWiQeQK/Db3CkPDsqxQYFV0RvbR1K/GT2wHpvA61SbQQQ9nkChyir+cYGb00CpH8UN6H54dfkPifY4XaCPrs6MU9/lXtJmlGoxt4t3FwaVL58smOdgGa2eAqv4HOvgCUXJo00KSfTdr3W4MRQFVS2YokGnpetlvzIMZ5Z2UItbE0ToNtGHRmcmZB5qccdd8bW+Vkx6oSnO0kxadpnoUmwtz8jJYrJZqgTt47WtgO3Wpj5nbausR3TX6J4dDLoAxQXfzbr8O1I5nCg7hLXwD8p6BvVCFUHJQdnjmttrU7wZMVAP7FgJTuDDSA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WpAY5cOWzwx5k30HXs+sYSi8njwUGuemhUtsMbaV5b6OAddE2nWVU1mcGQrk2a0dw9eZpawAWtTawJsmKjLNdVPlQ405lQ+G1L3ahj9UFL2gjBKuw//VhhKu5aE3xIKKy9eb8yddd4smOUvZFlluAHjbJJgTNtAGP5nrmlubdEW2iNaErFMt0oZSipePNW6CLyZS88sJDtT/sKDjFV8mzo+7PkVlucITDjmgYximnpfmAHxnLcgqbo1E15rTQGByz/hXd4zJPupDgW9WisPp/QrcVyZNjZqRNA5gsC8XNNhxeK0htWXUoxv2N2zwYF7PTlCNqBu26NctlJNJCH4UftEEF0EpkBeYXzrMrYXeHrvjUR3E15paN+AL5vpoKjy82Zkuy4hejPmIHNA66m3gIOukIAgvb5kypWi88su4HDb9G86popLyVK4BqtsJdorp
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 03:31:26.7887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70dc8cee-d69e-4fa3-1031-08dea4d6a150
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9610

Hi Jacky, hi linux-aspeed,

I'm Ender Hsieh from NVIDIA, working on enabling the NVL32 BMC
platform (AST2600, msx4 design — the one Marc Olberding added in
commit f28674fab34f) on upstream OpenBMC.

I've been tracking the ftgmac100 cleanup work going on recently
(the 2025-07 .. 2026-02 batch around DT probe, MDIO setup, match
data refactoring) — looks like solid groundwork.

Could you share a summary of where the Aspeed networking stack
work is at right now? Happy to coordinate on-list or off-list,
whichever works for you.

Thanks,
Ender Hsieh
andhsieh@nvidia.com

