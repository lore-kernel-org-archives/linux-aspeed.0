Return-Path: <linux-aspeed+bounces-3970-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F34CFF885A
	for <linux-aspeed@archiver.kernel.org>; Tue, 28 Apr 2026 15:15:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4kX66R22z2xld;
	Wed, 29 Apr 2026 01:15:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c101::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777389334;
	cv=pass; b=hRwxsLXjBuKz4m3v/quc2Qq9HPETZ1VgPHatYe/fbzWczJZSNJaWr8hRLwfkvWUBD/Nux71IxOo5E4JFO7P7/ktxOmcvdJrMfR0EAll3wa6zlhyRugQsTG6zITaBRq4roq5p0y6oTRFkWz/KWpMwnbhn4KdS8uCxGtzbKRpXv4R37a/2N4O8eP1xyjpOjsZ7B9l91rhO34xCxIuiofJPd6TmGLdsWRYfQAqyQcYDVa08vlv9CxTGNhi+hkBIiWDlUdAZ2nEZPbEk2delUB7NPGKEhSWqBbdD3LWum+TRzH5odsiOP4eUup/JevR8P+uDE9ey/lAlvldxkPLsFl0zYw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777389334; c=relaxed/relaxed;
	bh=0L3OySi0f383c06u2+5YGu6U5X/f5IqT1ml9wXivUEs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lJlrLQHcbitR/OF7az9zRtks/oKnJfL5XJlpmWKRyMpOW6jrPg8Zjf+IgJMrhys6yYK7opIBD4XE9v09WxdMBD167JqCwqEXQH8wo69J9GW7cmZssGtXkiFWXll3DVDSm6zVzGIVVfq+AxvsW5VE7CLoOjX2JJYYKL4gzP887cdqdmuVzZChMm9+l978LCZUxMpJiX5/LhyJGi3nOqhBYI+FGB3T6JqY/PzDIgOMuODuzdj75OJSjYaA7eb4Uz6ix9QChhHK75xg3nq+xBZKmOqQbZJP7EoGcU7tA8ZVVumJ9R9MpQEeOctSMG/A7Z+jTrbpRnjgM++K5CWi21cJtA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TVwEBhTq; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c101::7; helo=bl0pr03cu003.outbound.protection.outlook.com; envelope-from=andhsieh@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TVwEBhTq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c101::7; helo=bl0pr03cu003.outbound.protection.outlook.com; envelope-from=andhsieh@nvidia.com; receiver=lists.ozlabs.org)
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazlp170120007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c101::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4kX455Plz2xSG
	for <linux-aspeed@lists.ozlabs.org>; Wed, 29 Apr 2026 01:15:31 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hhpH73ObuO+EzgUTtrcxbdQ3+FSS5rC9vzBRO4iqTS6zhUjtVLK/9wIPUiwHvejbIwifIZUgwEpH7kpPqKAaWaHG4ZV71RcqA/uB8SzHNOFuMAWFIv+sJM3zlusOmDQWqgBT3csSLYrCOqkQAM8vHyR3qpP5iRunTdkHrzbovFV3m4S6+Xu3l4yYx3bvHhHXfzlYfAeR/8Ms2dd7gjgNwS72aQX13wq6VdAPc+qTHdl5PuH2oR8egGpKuFNEy20gkp+JC22iOIiWWL/mbilQCYC9LxEGjAeHl+mLeaPRNvFdUFqoBAdiIFdJMnTSPaYebBBFLEPmxGTkEujdl5kruA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0L3OySi0f383c06u2+5YGu6U5X/f5IqT1ml9wXivUEs=;
 b=nomd8ei6JyUhpyLWP143B6PSBFnAMBpm932pSaGyIjS9F/HpwGhuyl2du/I9ByjLsVaN6z8VLH/WtKywBFxZVN25IIn5MBm32f09SeEV2S/iiWtOs5sXXMlBr//veb2MtUcPyHQMzVADWiXEZW5o3Ju9+YXKXr9WHMHVEM+AjIZyjDOriag3zJEdg632TXL4n0wsCc0kT1UhRqbrSLmNUnroGpWz2UK3RRcUK4/PohM8FKqBEWXei8VQUTCAkKyKeI6E06GG3bFBR2duywjHgRK0PhVUAaVhdhRHGcKGjS9AxT0Llc5vBzXjiJsjACNxwQgQhMnA5owQ2ryWh3q0mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=aspeedtech.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0L3OySi0f383c06u2+5YGu6U5X/f5IqT1ml9wXivUEs=;
 b=TVwEBhTqxwii+vpTIIyw0AgE0CLNLchEUVKgHi8PC0OdhJIZrI1jbTip/IQDkPksFkRwZJfypL9Y1GbNW/+/df49wb8kBOXuiA0bwZf5/u7ItXXnxWucUh6bnSnwjpTP2rKrPr0WmK1r/p7HjgHnVEyiE5Y2IaWF+PkRqZo0x3JG+57LV4CVrjpsqZhA+pSD9y8PlwD/ixIDH0WtjKrZ0WWtJgrKrm484mvshXN3a/r5Q9P5G1ewAKpI4gNBFz8FAtJEPNSxpc11YMTnuvAeSyRK1AvEEuXyLl57xgUTC3iuJolBql1ZARiqDMdLbrW1sNHXdk6DzsyowqAtq1DJmQ==
Received: from BN1PR14CA0003.namprd14.prod.outlook.com (2603:10b6:408:e3::8)
 by CH3PR12MB7620.namprd12.prod.outlook.com (2603:10b6:610:150::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Tue, 28 Apr
 2026 15:15:01 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:e3:cafe::1e) by BN1PR14CA0003.outlook.office365.com
 (2603:10b6:408:e3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.27 via Frontend Transport; Tue,
 28 Apr 2026 15:15:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 15:15:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Apr
 2026 08:14:36 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Apr
 2026 08:14:35 -0700
From: Ender Hsieh <andhsieh@nvidia.com>
To: <jacky_chou@aspeedtech.com>
CC: Andrew Lunn <andrew@lunn.ch>, <linux-aspeed@lists.ozlabs.org>, "Marc
 Olberding" <molberding@nvidia.com>
Subject: =?UTF-8?q?Re=3A=20NVL32=20BMC=20enablement=20=E2=80=94=20offering=20help=20on=20ftgmac100=20work?=
Date: Wed, 29 Apr 2026 00:14:16 +0900
Message-ID: <20260428151416.1700609-1-andhsieh@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <SEYPR06MB513489D0B8F5BC77258EA1FF9D372@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <SEYPR06MB513489D0B8F5BC77258EA1FF9D372@SEYPR06MB5134.apcprd06.prod.outlook.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|CH3PR12MB7620:EE_
X-MS-Office365-Filtering-Correlation-Id: b41da099-90c2-474d-d186-08dea538eaaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	CCNxxIhC+eqGgVdfQFphBhENU5p98dBLqTxkFqwK+yJPjYX3KQ+x8P3nlxUzPRDpB2DcOtzwdnQwOyfpqpymjrnTsnpcCDzxcZGdCmRxZ6XTLLEZE4nACIkmuRDdzgq48sij2oh40jU6cdpSVVvlbxinId7m3Jr9ESBkcxwkaV4+GBojHM4NrtXIcYIsJjXmKz3nYMBWHFYxWfzufA9/1L67qdyDPgXnYM3W6iGHUywNKHqPpCV4xHzapv21kTJiqC+mrLVd+xBw39OMOytoyNUAa4vA+a6x5VcCvDGGYKkH0tpDaBQQZINzi7hh6DVyQiNzg4DHGiFAi8ZPjbjbmfJLzxuWIr0ze/pGgW4QEiQdqmzWQh2VPaWoC0YmXmAfTRCv3yUYVdgP/ninB1dP+xg1SgyeE4bvwDgOT6/js1ZvZJtduRhGf443V9pnnJ10LgmHUTuDoX9OfitKmB6uVZuDDMDo22JxPjf97QhLIlPUiv7JhUQx6LEwnKm5KVwl2Jfauu5jJJ5Z4C6PVfB2AnTr02u4CQlAkpf9HFdAO8igE3P+Qs3qJcQAhzhDIwKVFud0q5gye/P0F/S+Gi3tyioE13hlT066LypDNMq36WipH0V0n5pcIuoD/ASv7ERIoGbuz8zza4/sD9jMHgs5h2yuY6whV/5oGAJ0NiB80S01DZ109ZICYkhnhpL+PQHJ+c27EyDBdctxLWoNhMxt6qkMnST9fL9kzxBdqDmcmuvee/Btz/xLNLFRf1O+uJ2Hsj4P45s3Wy0DGRfoPsKCgQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zxOvvbevU4hl2JtdSHp9118qRs2FlVO5aftvmBh1pImJmmCYj+vRwiL7jRw1P7cMW3dNaOKNZPh2HqtMNHSesSypWgz0CkWbAq2hK/oa6fEW4PJN45hMQUSA8RoA1Hp7bKlRmIvx7Ua8lFlZFm1ao0433vSrJkGPhvjeSeELa9goEhryeTPm1uR6fX/XHPeL9jKzfqu5R8MXObN1QaA7CAvdp9Ue4vdZvt8gzaM0+LgUecEfPZV6k5jUGavT24o8saMobpSBFp3dTRwDW6NwYlDGtSwHQUju4sbPMus1Q+W6KLayTXLaKJvZjEFwI10O7kAJkY24yid5nBX2NRJ5yRff/znDPv4t5ZupU8zaI6n2oyhMeaz2RyyQJkc5jdwaCn+In6fN44Gv/+B0SwHM8PrFi2rnoKGtXP8T7fR0/PByWPJupdZ9WxY9RNbcI9t1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 15:15:00.5943
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b41da099-90c2-474d-d186-08dea538eaaf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7620

Hi Jacky,

Thanks for the update on the AST2700 ftgmac100 plans.

A bit of context from our side: we're working on the OpenBMC upstream
effort for nvl32 (the AST2600-based msx4 platform Marc Olberding
upstreamed in commit f28674fab34f). To get host networking working on
our test platform we currently carry a local kernel patch in the
OpenBMC layer that re-adds the mac0/mdio3/ethphy3 nodes, but holding
it there long-term goes against upstream-first principles and the
Gerrit reviewer has flagged it.

Given AST2600 ftgmac100 work is sequenced after the AST2700 series,
do you have any suggestions on how we could resolve this using
upstream resources — e.g. an interim path that's acceptable to the
community while we wait for the proper driver fix? Any pointer on
the right shape (RFC PATCH, openbmc/linux backport, something else)
would help us a lot.

Thanks,
Ender

