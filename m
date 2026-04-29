Return-Path: <linux-aspeed+bounces-3977-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3605FF887E
	for <linux-aspeed@archiver.kernel.org>; Wed, 29 Apr 2026 16:32:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5NBT2YSBz2ySf;
	Thu, 30 Apr 2026 02:32:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c000::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777480353;
	cv=pass; b=fApnAkFtwQD9DXVovBPCNOQP8cnLZqL9pel20VOsViHuVlL6fWdYsY4J0n5lGONrLYrsri1R0ezTuh96/dchQgKgd6LZGQcSNdbdpjGzj/J1l5WST/2NB51cGezDrAQ+5CBAMEb2UuA31d7tFNtTPhE5qRWQ6hjw2lVzGdGCDWgHEmCPWuZ95b3D+W0GBhVIDOjwkA6tlgJnrNG5/4amDxHaGSOA6MBKXx0XmYZn55+0VH1PVTixTnoYK6aozKCPM2/cQklFOBM2N2ZBCNKBcQhqNwn+qXvpdVBlnHpQ6lfprDIxyENuTFOgXSNSHfy4+a/i9M78ImpkEfx6Uf87EQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777480353; c=relaxed/relaxed;
	bh=cFrJADjjMPsC/3hrmGFUtAWKD9TwBjKFckxSK3D0XmY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LJUlWDSYGh9Ux6WECbnJFXHLiV3afRuuRNcJWzlPneRINMxEz8XbmM3khrHsR44uWatl7CPdcGsk2QaWsDVHwZYwOB9DzsGbay//5HfbVE+cTqld3oG1rj6Y5Q+qBqW1AzS3oR9fz0A0xZmB98CNGzNs1N3nQJ1bhYLTd+Q4d5Q73l/y9TiNcgKeBAyw6INjDMV58Gdp0n/AJUffBU1/m42HR6fsu1rRLxpH1gAS2xFRTXRWOcWz0cNWI+U2xomYvBsdX/HySGguZS699LjteyKiXJ8hX/9EJZ2AYUooMBikt8kIYMwN2BMfcXyOCVK0SO61zBZ+Ktg9RDSpqeu2sg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HIM7LFCx; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c000::1; helo=byapr05cu005.outbound.protection.outlook.com; envelope-from=andhsieh@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=HIM7LFCx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c000::1; helo=byapr05cu005.outbound.protection.outlook.com; envelope-from=andhsieh@nvidia.com; receiver=lists.ozlabs.org)
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c000::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5NBR5Ngcz2y7M
	for <linux-aspeed@lists.ozlabs.org>; Thu, 30 Apr 2026 02:32:30 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XxBGfZnlIZeyf9wPRhOAm8RTQDj0nC8KMcsD8Eoo2wA/IZ6ecsRQVrjUYv1on6zk/0V7glHu4RsTWQBzkqLTgoC67wpJV20I3kRxJuPmqzgJlLaozcVPJqzeDDGCeBSAq78tiyJdJG6evQPVp9/auLv9/TBvxBgFTotOF7xRPMAXZMUJ9cB94eLFgdu1gAr1X05XPgSA9RKOdndzoUmJZ0LKsepAJ1qChzn9xWXqHZaRk6ZbaMsGL1bH7OgY8cZZm5ZdHxjvpTPqlODf2oNZgLosTqwofgQT41ru1yGsjqSKs/sJoNmYO8HVgCBf0+33FLZKtU7Vs3fZTsmxBKuqsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFrJADjjMPsC/3hrmGFUtAWKD9TwBjKFckxSK3D0XmY=;
 b=L+vJoJCttF8cwHhRjE7GdkVMXl+WFhrQN/SN3ghjTTh1ETW/6rVJRBgxx3U9Sn4aqzqFpspL6jVi4hjbPwSKNa/vOQVSc5fANQ9bIWQRsssQgCqe8nkBKxH3uE0jgl1OQb+XTmXlyl2E4wFv4/0jwAjTbjXwix+y0osj9ASI03cTdEhki6Zr8eqBfHcHWwlWXV+w6ylmSgmRHYUf2DyVO2xO1mY0cPabUH4ayyTs1l6GAiXxU5aEjVtRxEVy9i8IRGn7RCAtU/dDgeh7dNTWNVydj+iNl6LL2wEfN9PbL95sWbKD1LHItUCf7MBenym9kZsN6mPFYpmZiq3Wf7Sacg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFrJADjjMPsC/3hrmGFUtAWKD9TwBjKFckxSK3D0XmY=;
 b=HIM7LFCxHJsexjDpYd6ck1/wv/cAsKBpiguICnTvIkiOdCRGi7bcNw+Doj1d7cg6QEW2+OAMkSVWnhJuPK4uI5hufbGmkKXtVbOSBxAsiLljupM+OVP4kCMgCWjYyczVG7grzq2mTk8Bo9oowtwA9q8+UJvdgiSL4XxPKHpBxBBar0sisaGVBR+HfoXIVJdL4SZtrQM6rY9o8Gaqp6HyuSHJ8y7pgPwTSstp/PY4F7oYDAl/AxQXM5K5221X8k/n3zI1W+xqxs5vfwnkiU+b5lFqG5AFZqpmMc7eJLRODBKdRBDOgZX9y7p4L9EItmGl2e/7kkpZM8tIqy9dpwkyhg==
Received: from SJ0PR13CA0152.namprd13.prod.outlook.com (2603:10b6:a03:2c7::7)
 by DS4PR12MB9769.namprd12.prod.outlook.com (2603:10b6:8:2a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Wed, 29 Apr
 2026 16:32:05 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::1c) by SJ0PR13CA0152.outlook.office365.com
 (2603:10b6:a03:2c7::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Wed,
 29 Apr 2026 16:32:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 16:32:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Apr
 2026 09:31:35 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Apr
 2026 09:31:33 -0700
From: Ender Hsieh <andhsieh@nvidia.com>
To: <andrew@lunn.ch>
CC: <jacky_chou@aspeedtech.com>, <linux-aspeed@lists.ozlabs.org>,
	<molberding@nvidia.com>
Subject: =?UTF-8?q?Re=3A=20NVL32=20BMC=20enablement=20=E2=80=94=20offering=20help=20on=20ftgmac100=20work?=
Date: Thu, 30 Apr 2026 01:31:17 +0900
Message-ID: <20260429163117.2228665-1-andhsieh@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <eac09481-0ba1-4ac2-ad8c-d859822ff0d5@lunn.ch>
References: <eac09481-0ba1-4ac2-ad8c-d859822ff0d5@lunn.ch>
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
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|DS4PR12MB9769:EE_
X-MS-Office365-Filtering-Correlation-Id: 0154997c-8bde-4b3f-2279-08dea60cd8ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mVvgPsiIE7owKNYZO0XwTsBPePqx1f2e8jUWyfHMh/xzX12xYLupDYT30UjsMUDeroNVsbj4HKUSFYaYzjMBtcTjDseQO1A/qAoKaPCOPnCiJJshAsIquxk67mi7Aa3+JrER687bBDaKt1XuDTQAaQd1Vfy8HP6u5hVVT8rOq01HCTxHyQ3Uz/OpifG2KWMnP1N8HTnaF/Malm4wq0twhdBEhpxikGtKCLrxnLIFAbrWblPJtP+z3PsmrrafRFsKWMYLXad/XUI7Xsa2qLDas9yHNbCBm49Fzert84CIaGyvr6n+KaIidB1zIzBrwmAk3P6gD+LRW/7mAnbBgbNmd0GQp1rHUq5xD4oElrC52EpU1jN3hVf79CTLFO6yRz0JlBAQeqhMIYhRN78o6OkHbczhM1isW+4HgrE8VpXfonqfuSb6FW/+RmNyV7I7qotoPak33al4fCB8bFlG2xXzvOPfdrmlpdqFDNQdlf8x8SNz8vxlV3gsJ9h9s83jriexRnhOT5S12XgOQ5el58v/M63hTdXBOLcxsMGj71rDYKNEz7i5WyVcRiKxJcx+Ns5kov2G5IpG6JPVe4634y0oWV1zX2KmCmVl+JP2g6JbUwRseUy99mAsaiSU47KX404GvKpV6M5Z3EI7N5sugbpKSqQLVCfH4qVdVSNKSRvnoCmFx4ckp9HZCzmwvVVcnZRS9t3SBczA2BhiLNfHv0XV7bBjA/GXqY9Sue3e4C/lpm3l4pjaXK4jdA53pOAuailICId/R7Dn81KyIV0JJ8Odow==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BY4GuJIrbUNeO+4H0L6gDGKkmwYf9SVOqb3yDjyLz7QJX3cDs/8xGWbWcYnUHSwVoud3UsJFY9pDmuWzK9cXJQ4dbhyIfzG1tnDfBZNAOsvd8xjPlFsuxqQNDYefqHEuhrAy/JhjH3cWaoyPFSCDZdFN75qdWdtXgmIZhPT0eaQ0ZFF690VkDZLvIUEdt604IfjlDpl/KJQoIkMbEs+KzT7ta6OGTY7+H98lSKkJVAYtaTO2BG6m2a51TqKls9Z42YnstuO8gh73dhCY+u1BVEzuRON34i6fE8WmJIczIgc7IUoUXHusjBjKG3DLeIIj8EoAscTQjEPe7mf75/i4STcz5DFVXlFQQHiXY3hvDQSLbF1I+OutrwsmmLpi0W3dv8XifUxpi/rA3MNbrXDdS0M8w7s4FD58wshba88kNsWSoHYUqQm1DjH49zI51zF4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 16:32:04.2313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0154997c-8bde-4b3f-2279-08dea60cd8ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9769

> The quick and easy fix for getting patches merged into Mainline Linux
> is to patch the bootloader. Stop it enabling delays in the MAC. You
> can then use the correct phy-mode. If you go this way, place make it
> clear in the commit message you have modified the bootloader.

Thanks Andrew — and thanks Jacky for the earlier steer too.

We're already on this path. I have a local branch with both U-Boot and
kernel dts switched to phy-mode = "rgmii-id", and the &scu
mac0-clk-delay block removed from the U-Boot dts.

We'll validate end-to-end on hardware first, then send the patches.
I'll make sure the commit messages on both the U-Boot and kernel sides
clearly note that the bootloader has been modified to stop enabling
the MAC delays, so reviewers see the relationship between the two.

> If you decide you want to make changes to the MAC driver, do it,
> post patches, and they will get reviewed.

Appreciated — but unfortunately tight timelines on our side mean I
can't take on the smarter MAC driver work right now. I'll keep it on
my radar as a follow-up if bandwidth allows.

Thanks again,
Ender

