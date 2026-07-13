Return-Path: <linux-aspeed+bounces-4482-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC368C44501
	for <linux-aspeed@archiver.kernel.org>; Wed, 15 Jul 2026 07:36:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h0Sfx2mFbz2ywn;
	Wed, 15 Jul 2026 17:36:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c40f::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783948551;
	cv=pass; b=oW7qfBv20m6UdhoBqBAm7CgwAsQyJlhaAsgxEuXjbLe5FL5uZU0ta+JHQlZNCVLlfKqrCWVawgfBIAFBO8/9TZStmoHZVG1CX4b3EoZMTztoTkRYJ+JGkqakTLoyQgUlzaEfIhJ3u7g2LB/7OKf3r95Vd//ZhxcElVdK7Kuuju5Krndm/IFkjT3wEnNlpFabFjnkSNb9FbLQCHut6af3WWSTU3cq4927npdYEVb+TzAhvrh9UZuMmGNRFd/Wp3Lxj7DClgvowiA7JKNLmLQu1lzpnLbRFK5qwyWzwY13R0bt1K/+dDvOH23wporiTT+h3FusnmfrEnGm/CsJohRiEw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783948551; c=relaxed/relaxed;
	bh=U6eTlxKi+bX+an97+d+PYjrbRdz+iCttr0f5VAGep9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=QOY6Uo+a3+5ySEpVdch1s+O71i6P4o19pBnRUCI7HyaO/VObRNj51wIt4HWrUXkg44PYMi4Q7DbaC+BSIMcgtxG9YAx4uoYll4VR+KTgBRe/idk81NbDQQ+4fGXfzx1hDU0ddsFyIbizrmqKZ29M536snzelbZhFV+3f6RmVYxUU3vtu0wrGHhvgvTUF2Hq3rQmynMCRSo3nAzGE6oLjSEizBHknY5ZrBaZYAH1jE9la8b3uH6pq6KwfAQqYWDRCGs25RZXCR6M0R4Qn+fBzFYyy4yU6K/S4PwmzqSFpAaGocJF42nESwxN3phaH8dejCgGUMEy5uwx4VlTSrb3exA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=n/6gYGbm; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=panchuang@vivo.com; receiver=lists.ozlabs.org) smtp.mailfrom=vivo.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=n/6gYGbm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f403:c40f::6; helo=seypr02cu001.outbound.protection.outlook.com; envelope-from=panchuang@vivo.com; receiver=lists.ozlabs.org)
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c40f::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzNGr2QBlz2xqJ
	for <linux-aspeed@lists.ozlabs.org>; Mon, 13 Jul 2026 23:15:47 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QmFydzbdc/EFr4a0fCeiGTMBRt5VoVR3uqjjab6LrhTzmjwbRfDRYSf43k7+Lp48XAGgYSEg3daGdv6Ct2PDvHqyNooVCbsYgg8qKNw37u0LBFZmcg5KMjM5nHm8/bdVzVdb5TAa2J2RwFsc2VNsCaB2WS17uQiBFfZe7dih+4CbV3EzXz2LrJGUtHd2KHD5VVN7O/TsjqKKClkpkup8TLquzucMwr7Wo4jS2JYJRwJuYLtptEoKhpCVcMUfWM+8Kl9tyKNoWdEz6XP51B9X6TmtC2Wn8FieYGnUyNB6Hag5XCrxSPEzZNUsX0nopYcBl1HbLvQ30xeuQPfr6DIvMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6eTlxKi+bX+an97+d+PYjrbRdz+iCttr0f5VAGep9Y=;
 b=wwA2oadil3VNoZ5nkA9Kzo301Waht3B/OagK+Uq+zMATnVspU4tTQYcjRlX8oeMGBfDP3sU8CJRkn3I7/pMwsfgU3RakOAB3fOiH8PSWVZZvjLeYK6MyUCu85JYqYu1AOTZ0MMHt+C1jrjGXhXtElY9+T63UupvkxBFCQ13bFNqPl5onHvo5jn/JDOEU6nFC+nnWc3nKAf9jQQa6H0xW/p2HC1Lwwks2GfbM+Nk5IX7ehNUtMk+C7lCV4LRVx30V6PvxtvfX3qjtmEurrOXxXgcDzuFCNZcjckXBoEzYoJA4A4S7FucOrju2XQ3itLzxWobEgo83ZWKv2hWBjdqRXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6eTlxKi+bX+an97+d+PYjrbRdz+iCttr0f5VAGep9Y=;
 b=n/6gYGbmywqXK+rtk5/djHXHb8x3f5Sb+dTxRASjwzcW8x3cDsX9zGhJqswmUg8Y50l8mDlAc65hChP1gKcfK6owIOpbHlDWQ0vMvQimXlFmcsvIQsqNYG+iXvH7zpPRjX0gMPCYzj8FHM4bWQFttYFlxtt9CzzT+3y7qpEywmgp0Pm4B/jVBlmcITOlMl9MwO8+wbK8YKN5H57wQED2thgous4rH4Ij2y7DS7Qb5056DUMndLDdyKHGXtIczLhG3nqylOHHmHUWdeIAmP9iXjN6RliCRO2CqLtWKyjd7UxYyCsJsovvCP/Az9Ggls5eFgkheLHW4E22OAw9c2fYMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SI2PR06MB5316.apcprd06.prod.outlook.com (2603:1096:4:1eb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 13:15:22 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 13:15:22 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Talel Shenhar <talel@amazon.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Stefan Schaeckeler <sschaeck@cisco.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Andre Przywara <andre.przywara@arm.com>,
	Robert Richter <rric@kernel.org>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	linux-edac@vger.kernel.org (open list:EDAC-CORE),
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/ASPEED MACHINE SUPPORT),
	linux-aspeed@lists.ozlabs.org (moderated list:ARM/ASPEED MACHINE SUPPORT)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH] EDAC: Remove redundant dev_err()
Date: Mon, 13 Jul 2026 21:15:10 +0800
Message-Id: <20260713131510.332386-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0004.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::14) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
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
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SI2PR06MB5316:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bc3ed0d-7fc3-46a9-9752-08dee0e0cb6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|23010399003|38350700014|921020|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	yWBVqoK0wJaXVHsIIt8F43+RlM/uzwfteqKV3459A+lz/aIA3kozxWl1BTmhEsUVe9f3oo5yTagl/HMNML5Wt+VhKa4fUWNPcZHVNdJspopRaJ7rO1xqi7SIDrFy1UFdhxvL/Sh51mKwtbpjdn0SGtXS4gJ/1M1cLkxoPntU0u2xfS0QjPOtKhJ8V+0yZj3M4WLRSjxZbfKaBpN6gtVg90mdboJI0hWfJaEargcAV7F+yNRGUpAPjxyBLYpRZ7pzJU1ijy8f+q2ronXzht9Fo11YnKd78euWOz2nBfuIaizqmiEyDZ0YLsE/plLGD0hyLzoJMaNUpjtX7Nr/cNMq2bkVG96o1oA63Kq40Ilu+6iSTAHf1DCVF0eqN9CU3rRMn5Vitr+qnXIgwqnTidoIdrgtGk6TX7IBFXF6eBqcQLB2IAUW6TWzbZHr2BpdWMKmtDVqEvfl7cihYlJ9HO5VWeHTMrUBR31ibdXa54rxhX51Z9K0v8Fx4x5uPj7v1LoiZWN1LNtaKSCNQWRJYpg6YY9FuyQLSAJe7breJhqZrhv/zVVmayiNhSUGoLqPGvO2HyUpQR0xqwsRzmLxFxGYxcNNttZOmig5VgqNkArglON4Tt8/2sq5s0VuapiOslRM2bATLrWxBbs5q8EmU0RB0ybnZUXGoEHGkqwNW1cVTkenxfCN86VtC0kj1bLx5AQragIbo7eSAEdBd8gHnvm0tsMBo2+bmDEtYkp9foNjHrD5g3uWBcOo/rhse/EHuH4s
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(23010399003)(38350700014)(921020)(18002099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lswbXar5YL/XNmHBzCtlosyocxOrDBAab2WtpVtNrBjYKEBCzpYbC6WwSP+f?=
 =?us-ascii?Q?Wx06WdxTELF4E19EUpUz2aCS+edbBEYgHpKxmDeoyXtK8ca0jorUsunNhR+Q?=
 =?us-ascii?Q?M2irZAIkruWRR7in1X1gBewK4NyE+g+QoaRaoWSq6CayXY3cPVCqAcWnYCG8?=
 =?us-ascii?Q?1wSJpsGhvLDoCioywUpraaRdWWD3/bI1Yldv3F8dPzqrPj47eStdnyCezus8?=
 =?us-ascii?Q?Qhz57OepfI9b/HnBOethh8OnCM2EtzsIKsH4cCw8k2WflE+RBEi9N00pogWa?=
 =?us-ascii?Q?ULiWntVRrbQ3vv6W+xf1ZKALIA1GyOWRoXeR1do3rbPKNoORmrHxzuD4FCGO?=
 =?us-ascii?Q?vYoEr28S2dEPwmdyMua7T/kVLYco2tNKqg8OwGg1pUr8mxgMthlqQRJQjq/V?=
 =?us-ascii?Q?dM5DFuByulRMI5x8dQe8XiLYmjYj2arhB43PEC6fDxZ3NEJsjl6QtYFeE2zf?=
 =?us-ascii?Q?yvGD+ojMV2vM1tto9neJkxLx+lVXZKC0wtA+WKgQ9WInnCyni2IaVCmnAuyA?=
 =?us-ascii?Q?BPbp0IOES3EzFiRL77W8O89trMQ4hLy5rHLxIqPI48ivVLSTHuPV6MqA26Gj?=
 =?us-ascii?Q?vJPLlKARqhHmqYGpVbRBZiPbM4M+x1y38PKnVECEipyWgO1+Dyx2r9h/HQC3?=
 =?us-ascii?Q?z2IIg7CwYzLr5M+eio+cM9DqPypItQD1Nclsl6Cpbs+ZZnWMtF4fc6mg6K7i?=
 =?us-ascii?Q?LNbdprn+7VHbiqer6d6tGUfp2z8Xfk1jZldM6W17GtffLNFcikfO8DCVvNcH?=
 =?us-ascii?Q?K8uB4aUxg7UGTZo5E3q3MoBpcEQWudx6fCMasWZWuzLRv2zUkE91QwXkTFCK?=
 =?us-ascii?Q?z31wWOF+4VWJE5/EX+HLvihaUfJjw7OmSGSRe/RiSuqw/+knPrXYx5ITNprD?=
 =?us-ascii?Q?/hEy2kERWQ4MrttrsoHwwZLMThYhb+X1my7I1S1CbGxcAi88VRM7UcoXj6DD?=
 =?us-ascii?Q?DUJ0DfDvCPo0JkhXulW36xVqeoN+NJFcNaV6zKmI5W1J/Bp67buF2YWF00Cd?=
 =?us-ascii?Q?fNEWtkIct3LNidv8j/Hyz7QXLxdiNNxOvoEBcOYkXaNANQ69O1d1//t14+/O?=
 =?us-ascii?Q?onkzqhvXmTqIE1P1b0klfm96aqLHdXxwuRPNFOeamK0L6kNb5wXCPgf7FINQ?=
 =?us-ascii?Q?qkkxfCSfbcVtO53Tmt2+G+McJCigjygqHFjBLYc2iQiRUrUndPzr7X4b/xFH?=
 =?us-ascii?Q?+Z+Zy/TzOnLA0XXkfTNXaZWphsvN43tS3do4fEY4/tfpdrr6KJd+4hm4peqF?=
 =?us-ascii?Q?oYGE4YWLiqmesKaXlg6tBT5ASvxz+ayjJvtsy6I9UIGRJF5Fm0PE2SbW87WM?=
 =?us-ascii?Q?eeM+o7sbOkLslkUUbIley/LBtirtcBjKNqIDI9Na84ICnRfbop6R+nqf9qNo?=
 =?us-ascii?Q?FKLZzj3CEWjmu3lv/N/hQlxaAcYbi5SH1LLA+4UcKQXmJtr2MgDoCBTEyHc4?=
 =?us-ascii?Q?fhyasNcOrbetOcF3ks6aGudeJ6ixiIS7Q7i1UFL6dlAHB+/i9EmpmJM8NOXw?=
 =?us-ascii?Q?cBDvJFV3hC95FKdbWqLUs+CvRKnTL2RNSBrw8KYlmP/+MhAuI6P/uTGdczhc?=
 =?us-ascii?Q?uU/8lfq0mwQmVqSA9YAt678V52UhfoL+svICf1VrA7YZ83fdm/j9m4tkM97Y?=
 =?us-ascii?Q?yc2F89eZwaxKNeowGJLypSL8DONllyI9sUHo2Ox1Vtlus7ZioR3On6t5ekz6?=
 =?us-ascii?Q?Q74h85SBvwDnxM4c2xs0PdsyV25YMUN/ZcaV4Qgz0ksDiPWwWf9ZMcRVrk+Y?=
 =?us-ascii?Q?NNgBIDdr1w=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc3ed0d-7fc3-46a9-9752-08dee0e0cb6f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 13:15:22.6478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q9Z+ngA2FBZ5ej/pBXq//c+ZE2JrJGKHmob6nOp2z+wkwHVh+bl2BtePfyVfcq9Gl1NxDTLvwsgPKouNjPTEAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5316

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"),
devm_request_irq() and devm_request_threaded_irq() automatically log
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/edac/al_mc_edac.c       | 12 ++----------
 drivers/edac/aspeed_edac.c      |  4 +---
 drivers/edac/highbank_mc_edac.c |  4 +---
 drivers/edac/thunderx_edac.c    |  4 +---
 drivers/edac/xgene_edac.c       |  5 +----
 5 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/drivers/edac/al_mc_edac.c b/drivers/edac/al_mc_edac.c
index 178b9e581a72..bf6921d8890b 100644
--- a/drivers/edac/al_mc_edac.c
+++ b/drivers/edac/al_mc_edac.c
@@ -302,12 +302,8 @@ static int al_mc_edac_probe(struct platform_device *pdev)
 				       IRQF_SHARED,
 				       pdev->name,
 				       pdev);
-		if (ret != 0) {
-			dev_err(&pdev->dev,
-				"failed to request UE IRQ %d (%d)\n",
-				al_mc->irq_ue, ret);
+		if (ret != 0)
 			return ret;
-		}
 	}
 
 	if (al_mc->irq_ce > 0) {
@@ -317,12 +313,8 @@ static int al_mc_edac_probe(struct platform_device *pdev)
 				       IRQF_SHARED,
 				       pdev->name,
 				       pdev);
-		if (ret != 0) {
-			dev_err(&pdev->dev,
-				"failed to request CE IRQ %d (%d)\n",
-				al_mc->irq_ce, ret);
+		if (ret != 0)
 			return ret;
-		}
 	}
 
 	return 0;
diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
index dadb8acbee3d..6e069b255595 100644
--- a/drivers/edac/aspeed_edac.c
+++ b/drivers/edac/aspeed_edac.c
@@ -214,10 +214,8 @@ static int config_irq(void *ctx, struct platform_device *pdev)
 
 	rc = devm_request_irq(&pdev->dev, irq, mcr_isr, IRQF_TRIGGER_HIGH,
 			      DRV_NAME, ctx);
-	if (rc) {
-		dev_err(&pdev->dev, "unable to request irq %d\n", irq);
+	if (rc)
 		return rc;
-	}
 
 	/* enable interrupts */
 	regmap_update_bits(aspeed_regmap, ASPEED_MCR_INTR_CTRL,
diff --git a/drivers/edac/highbank_mc_edac.c b/drivers/edac/highbank_mc_edac.c
index a8879d72d064..68d16cc8298d 100644
--- a/drivers/edac/highbank_mc_edac.c
+++ b/drivers/edac/highbank_mc_edac.c
@@ -235,10 +235,8 @@ static int highbank_mc_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	res = devm_request_irq(&pdev->dev, irq, highbank_mc_err_handler,
 			       0, dev_name(&pdev->dev), mci);
-	if (res < 0) {
-		dev_err(&pdev->dev, "Unable to request irq %d\n", irq);
+	if (res < 0)
 		goto err2;
-	}
 
 	devres_close_group(&pdev->dev, NULL);
 	return 0;
diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
index 75c04dfc3962..9c0a1e48f96f 100644
--- a/drivers/edac/thunderx_edac.c
+++ b/drivers/edac/thunderx_edac.c
@@ -729,10 +729,8 @@ static int thunderx_lmc_probe(struct pci_dev *pdev,
 					thunderx_lmc_err_isr,
 					thunderx_lmc_threaded_isr, 0,
 					"[EDAC] ThunderX LMC", mci);
-	if (ret) {
-		dev_err(&pdev->dev, "Cannot set ISR: %d\n", ret);
+	if (ret)
 		goto err_free;
-	}
 
 	lmc->node = FIELD_GET(THUNDERX_NODE, pci_resource_start(pdev, 0));
 
diff --git a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
index 9955396c9a52..62b8166dc287 100644
--- a/drivers/edac/xgene_edac.c
+++ b/drivers/edac/xgene_edac.c
@@ -1924,11 +1924,8 @@ static int xgene_edac_probe(struct platform_device *pdev)
 			rc = devm_request_irq(&pdev->dev, irq,
 					      xgene_edac_isr, IRQF_SHARED,
 					      dev_name(&pdev->dev), edac);
-			if (rc) {
-				dev_err(&pdev->dev,
-					"Could not request IRQ %d\n", irq);
+			if (rc)
 				goto out_err;
-			}
 		}
 	}
 
-- 
2.34.1


