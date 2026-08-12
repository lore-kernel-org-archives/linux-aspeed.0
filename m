Return-Path: <linux-aspeed+bounces-4690-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2648C5AD5A
	for <linux-aspeed@archiver.kernel.org>; Wed, 12 Aug 2026 20:28:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hL0Sn0dzbz304r;
	Thu, 13 Aug 2026 06:28:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20b::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786566537;
	cv=pass; b=MfrRgoqX9nv9u0mumJRvWdx9vgZu0oXHaluSDfG1xmtxzlTb5DABHT+7JgXk9NQateyfnEfYYfE5xIZrylG4V6cyjKCl1fGrUep8hrta/zspi3LxXVdjnIKq7DhvIFwyQhNqGRseeRTg+wne5RHdNb5JcL9fFjtEOQZAJ/uVKOLfkRe8XmZpUhZf7TSGhXV5UxLy51xlI329x0/Nn2JMMAxDKOVr0DdWHCrFdmY8TO/uEqOgje8jc4+ccz3Xd9jNijNK65zYoyn5G1o/HVugYBQrRF95skFdmEe9+DDkG73Oq8T+Tkaq5bxR0xZcdYn/0ngddS6/xje8onJE31LOLA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786566537; c=relaxed/relaxed;
	bh=AjpFkMsKmW6u4G9qYTxDb/1ny+R2gqVI/GEnKwza6RI=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=VwRk0vZ31lOshLm8jJq/IaFaUmgmVzP6BdIrG6qKBAjaOdNjxbktXJUPKEjdT2OmEWbUfCbwo/Dz8Tsulk8W9A43h8h2lw2OOZVrGjRjAmg6MeOvBBrJ0KaM3GCJh2MawvrLaUZMAigDvzT3NM45KOMS23FMtzVD491naQuOHgSvxGhs82TBUApgMJuYfg6rZFl5sxnxnnoMWabkT455+U7nQ42kr5b1RWHC1qE2Dth/sIEmSMv1I9L44Nq/6VOiyr13ixmlRwetx5zyLC1ysRIw7hs6JxCS1lg/urSg/x5EOaoCF6cTf340M/RutabnbOQ7j0wc226xhFikS5CFaw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=siewert.io; spf=pass (client-ip=2a01:111:f403:c20b::1; helo=beup281cu002.outbound.protection.outlook.com; envelope-from=tan@siewert.io; receiver=lists.ozlabs.org) smtp.mailfrom=siewert.io
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=siewert.io
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=siewert.io (client-ip=2a01:111:f403:c20b::1; helo=beup281cu002.outbound.protection.outlook.com; envelope-from=tan@siewert.io; receiver=lists.ozlabs.org)
Received: from BEUP281CU002.outbound.protection.outlook.com (mail-germanynorthazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20b::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hL0Sl6r5Bz302l
	for <linux-aspeed@lists.ozlabs.org>; Thu, 13 Aug 2026 06:28:55 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHHJTZYelOscfyjrnZZZd9YgZlURe6ybIsbWerG/2B1q6U6gijQ8ImouW80JTen9+WBsSrXGC5xb24Ccbqb6tVLXfNKNR2feO7ikINddt/T9UI17DxcsBC4hwqcaRZQylPEHZmPAu4h4Qbg1xXTaYuPrBPTJfjMj6kiysWip5N1tDsFzNtDEfe8XgeH4jzQI+VwM11YITs38byvEjuW+ExPPb06OBqC+CxQSLE7m99LrGkm+7qcSqI5LRghG4pFuM+cdfvdgq6vYsV3s49iWePjlWOTP0Ob+Kk+oNGRkqIZA6Nb3408xCgIU1ool/+BagpMjv+aq5fP8euvK2kk+uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjpFkMsKmW6u4G9qYTxDb/1ny+R2gqVI/GEnKwza6RI=;
 b=r7pGAVpyjeYdtC++dltHLSB6+zNig3syP7T9UC8CWfnkk1omEy6K80KJyknOrGXgFzEj9f7wzMIyEyFc7PQCE2WH/GCrxasLvXzZwKDmfMkpGzvD9j2Qe76JVaiSLCuXh0ZuKvurs6w1LQ4WCXeoeEb2ciXnG+EB1JQ9lhu9FKANuvPo8XnQe8Oj9GJhahuwfkEwCst8N9dlyAFxZqVY5IAzhq93lmXKv3xbHR8rycjOlEA3tt3K+n0vcYFjaDcwyZkKPSxVxTGU0jfQb9SWx1E26nndT0w2UPRqRYvSPJ81UhBRF18hsIuIboIUUxNNrZULax1n6nIk9e1ll1IQbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siewert.io; dmarc=pass action=none header.from=siewert.io;
 dkim=pass header.d=siewert.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siewert.io;
Received: from FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::182)
 by BEUP281MB3788.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Wed, 12 Aug
 2026 20:28:29 +0000
Received: from FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 ([fe80::aa8e:db31:b886:2365]) by FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 ([fe80::aa8e:db31:b886:2365%7]) with mapi id 15.21.0315.014; Wed, 12 Aug 2026
 20:28:29 +0000
From: Tan Siewert <tan@siewert.io>
Subject: [PATCH v3 0/2] ARM: dts: aspeed: ASRock Rack X470D4U BMC support
Date: Wed, 12 Aug 2026 22:28:25 +0200
Message-Id: <20260812-ts-x470d4u-v3-0-c8e266f1663b@siewert.io>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGnXfGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0Nz3ZJi3QoTc4MUk1JdU5Mky1RLi1QTY2NjJaCGgqLUtMwKsGHRsRB
 +UWphKdDMEqhgbS0AmL38vnEAAAA=
X-Change-ID: 20251017-ts-x470d4u-54b9e98e4333
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Tan Siewert <tan@siewert.io>, Zev Weiss <zev@bewilderbeest.net>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786566507; l=2337;
 i=tan@siewert.io; s=20260731; h=from:subject:message-id;
 bh=bZ7/A9xzSjKm2HtVrjt3b8g+WbNKe3NcCLeojeIiTKs=;
 b=BlvS5JwAn/HlbAce94h0vpjmGbpHs9rg4KpJ/3ThZlyeSvFqUMFVqZPdJCgKNhu75ILyXU14C
 oWEI4aKCAH8DgRE9R7KR1Qvk3u7TB6W/c4/QcSi/0sZt8dethyUAIYA
X-Developer-Key: i=tan@siewert.io; a=ed25519;
 pk=TXy9xEw3OCAd0QBR/ZZowx3QJfMcoe0ROFfoghqLnU4=
X-ClientProxiedBy: FR4P281CA0080.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::15) To FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d18:2::182)
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
X-MS-TrafficTypeDiagnostic: FR3PPFB3D0CF1D2:EE_|BEUP281MB3788:EE_
X-MS-Office365-Filtering-Correlation-Id: 9163e407-44ca-4b50-c6c3-08def8b0451c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|376014|7416014|52116014|1800799024|366016|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	ekTmyW5ulEc6WUb69aIvo1PdkWOY8RJYPYQmQ1PoMLFa6bQ3YLg7jqLO9huv9NC0lNpXDhDkDeV73I3a4vmE5WUaqigjudU41EZHoWFHruzv4CjDLxOF1wezxd8TgWeylmZzmTIB90K5K+XleRNAJOR2/DZFTrHrB9J7u9ZBOej5lLJ/FyOJWLvYOuO80x0CCePVRlXuLvHwEuCfc5OaFs12sXnaYGpAjz+y3B0nIhoVef/qZdVLyPSrLtQOJsaPME89ZHL1yvErDBvj+VGyDiuBuMr9Lz3BZtQvnZ10aPrY4hyiCZJBsIdd5Bf1ivpR2F5I/I9hGsgZO2ePUim93nYr9ovVPQ6itBX6Sbm/Vyg836W4JAkaPBIVawF4hyzZO6G2dLL5Bljw3Kz5KLsWSw5PRfFzQAsUJX09O9DHiqkRZlTpRtmKGOSgyzz4et1S1bfY8CbSs02qKShA7bCwH2UXjcuWIKjidbUhxJO8TdCQ11D4J1TWfzLjxfOX9l1XsO6617RVIvTG/27lQrevNkGGxikh71VfXgPEQAJUnnrFOp0cTeJiMHL19fafiFM3U8oaqcV9tqDGZMqN+EpMiEOwi2Qk7A0Zma2alLoknjLgNgufW6zT/ZeQbqVrg0jIqOy0I2mc1w+dfzY6E1U/swFjC+xt8w+A+otUAWHV/m4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(376014)(7416014)(52116014)(1800799024)(366016)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2ZvdUxvcWY1NFRqZFhrbldkMW5TVUd3TEZjeFZISWErTm10U1UwblJzblNK?=
 =?utf-8?B?Z2xKT1ZlQW1rTG1QNXhFaHlIQVZTNk5KcnlEc2pPMSsxL0NlR2x3YUhjYysx?=
 =?utf-8?B?VTRiRWhvekN6RDRQRGhoRUtNM2RYbXJ6eGlxNTlxVlVVVG82dEdaRkhsOHBJ?=
 =?utf-8?B?UEppUnBXVnN5U0J0SkZrT01mdnp0RjR3MTJOWW1JNXk4YmNXK3FScmhaRVRV?=
 =?utf-8?B?NUY4VDNvdWNCNHhLbDJMdkNKclA4VDA3MHY1ZzMxMFMyd1ppMURCMUU5ZGMw?=
 =?utf-8?B?cGpGU3NEVzNpcWhMZHlrV1VYZkxzNTJtTmNoN1lQcWdFcCtsQ2gvOU5nQzMy?=
 =?utf-8?B?UkJQUGF6ajJIYWxDQVBuSkt3Q1RxamwxdGJHcno4NGFMb0MyYlBFYlRpd2ZF?=
 =?utf-8?B?WERBM25TdC94eTJ0UDBnM2h2ejErTEx3UVpWZlBJemppallRUW9WQ215OVZT?=
 =?utf-8?B?bFJ2MkZNSklXUU1Cc2lER2JtRy9DTzNaQ2xzSEg1VG0yWVNwQlJ2dDhnVnR2?=
 =?utf-8?B?cXZVSExVTHRmYnAyMkhWcW1mNUgxQ2NBdTdPV2l6ajljM2JaWEVUcUVrYlpN?=
 =?utf-8?B?K1QyeDFWTmR3V05PM1pMWlIvRUt3d2ZROEhVNndwU1ZLMjFmUlFOM0VFQ0dR?=
 =?utf-8?B?T2ZXcnNEODYxZjJnSXVSY2JwQ095RVpvN0lEM2llQTRTSWthVTRZU1RJWENP?=
 =?utf-8?B?T3l1NVNTL0JNOXAwK1VMbXdWSmNFMk9GMzcwemY3dytFY0hPNW53Uk95MDRH?=
 =?utf-8?B?V3p1eHh5d01naEVGLzJVeXVFZWRZUmdxOUNabFpWalF2OTZPWERQVWpWSXBp?=
 =?utf-8?B?dFVxY2xLclN1UDdENmhTaTZTWGRSSzVEbkhKZjZjdnlnSHo0VWk0dmM0cXBH?=
 =?utf-8?B?V0dPMmRQNzJHWW1sM3pIMDhtK3czeHUvcDRPd2hpS1ZxQ1ZodmV6YjVtQ3NM?=
 =?utf-8?B?bzREbVZaMzduNkUxREtvL3BuUVFoM2VGZ0dtSXJvQWZqcG8vbmRDMDUrcHBy?=
 =?utf-8?B?Z0pwaWJqdFVhN3lTcVJjODlXWHhSK0FoT0Flb1FCZmpHaVZ0d3U4dkx6Ly90?=
 =?utf-8?B?ZVJXaGhYcU5vTXNQVmdKZ09zN29DUWxmRVd6MHpBYXdITEdaK1BYMmxBL09l?=
 =?utf-8?B?SFovK3pNZnFkVXA1bjF1OVpoZ0J3dmViNDlXdVZDWnVYVldLeHhBZHphNzE0?=
 =?utf-8?B?cG9HYm1xUndJZDBNY0hWVy9vWHRwUHVjOTVQcldQOEhDZ3Y2bSs0SDd5eUd1?=
 =?utf-8?B?R1JudU5HLy9JZldXWTdabFZIUGE0eFVhOHhTNXdDZ1I3Z2pZNFdzNjl3ajZV?=
 =?utf-8?B?Y0kvbmxTZEo4UFVWOWs1RjIvQ3NEcU82U0IzVWUzWTNDTldxNXY4YlhMeW5S?=
 =?utf-8?B?T04vbjk2YzNyTVRvaFVVaVVINlVHdDVvZ3h4azVOMVpWMHp6VEYvQ251ODVW?=
 =?utf-8?B?T2VLM3NNRXFvSUwvNlZVRlJEOHlWTENZbEllRjYrbTA2dnlFR3krQlptMGxS?=
 =?utf-8?B?WTJUUkhvZkF3UFJQdzJkZkZLTE9zZHk4NUQ2czlPak9ZS1lKeW51TGZFTnJa?=
 =?utf-8?B?c1dzS1VTeGVZQlVEd2tzUGZFejRyV3I2VkRiQ3ZUNUVmQ2I3S0xRMEZuR0Q4?=
 =?utf-8?B?cEhDSmNsSnJmdW9xRGJQajZKMDlNSXhwVy9oeWFWRHJKalhBTTdPZFU5VWJW?=
 =?utf-8?B?cytZUW1UMEsycU9ieEk4M3FrYmRzc3pMQjNjUnNvNmg0dXlzOEE0SE9MZDZT?=
 =?utf-8?B?ZUllS1BSdW02Q1FSSVFwYkVPaFNWemtyTDhNVTNXUDBock8wU1l3dDdaYWlt?=
 =?utf-8?B?TnBXRTZhQ1dHQ1BVY1g0cVl2VGpxVk1HV1pjVytEcVdFbENCUWxRMWgvV3Bv?=
 =?utf-8?B?akRlTDFlWEpDSU05V3hmN0UxVFhPOGJnZmZSV0FYSnRFSFBhTi9UVjd1eHVH?=
 =?utf-8?B?ZlU3aUh3Q2xzelZ1cVVQQXNUZWNzUHlLS2ZiNHk0eHI5d1hWc1pjenJZdXE2?=
 =?utf-8?B?UGVOZHdMTm1sai9oSit6Qyt4TUdvN2Nlbm9WOHJRMEJXSGV1eFV5S0JvcTVR?=
 =?utf-8?B?ZHhkbUlpRlBPL21VVUJqcW9aNG8ybHNJR00xMnVQbnNJOFEwK2VFUFZCUjFF?=
 =?utf-8?B?cjB0YytHWWU0VkpxdHA4M2N4dEJnOUVVc1JHbEg3blJvcmZCazlnakFtSVBZ?=
 =?utf-8?B?R1A2cEN2UUcveHMrNWhpdDl2eXd6Vm1kcG8xVnJkOWJaR3VtOGJHUGxpbnMx?=
 =?utf-8?B?MmNxa1d2dWR5VVdDdjBhRDRXSzZ6djVOVlg1dmdGeSt1dWtBS3lScVltVC9P?=
 =?utf-8?B?MTNDaXpxZTc3WWNTSFp3MDlodDJtMEJOYUxobW1mTG5SZUN4a3dtNW9Cdnlu?=
 =?utf-8?Q?WD7igqAtoMTutHkCg3Qy7x+nvnMYZ6dMfXfOF?=
X-OriginatorOrg: siewert.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 9163e407-44ca-4b50-c6c3-08def8b0451c
X-MS-Exchange-CrossTenant-AuthSource: FR3PPFB3D0CF1D2.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 20:28:29.4311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e8b4abbe-444b-4835-b8fd-87ac97451a7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n7FjsYqO5cCPdjO0f5XCJNqUMVaPgKAXD3H3NlQA/OYzmlMKbh9COvn/LSe2Gwk9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEUP281MB3788

This series adds support for the BMC of the ASRock Rack X470D4U mainboard,
which uses an ASPEED AST2500.

The mainboard exists in three known flavors, the "normal" X470D4U, the
X470D4U2-2T (with 2x10G RJ45) and the X470D4U2/1N1 (an ODM version with
2x1G RJ45 that is now available in retail). The 1N1 version also has a 64MB
BMC SPI by default, but they are all swappable.

There are two device trees, one that has all the config and uses a 32MB
flash layout, and another one called "data64" (similar to facebook-fuji)
that uses the 64MB flash layout.

Please note that this board has been fully reverse-engineered.

Thanks,
Tan

Signed-off-by: Tan Siewert <tan@siewert.io>
---
Changes in v3:
- remove mdio pinctrl from mac1 nc-si interface [Andrew Jeffrey]
- remove "st,24c128" compatibility from fru eeprom [Tan]
- enable uart1-4 [Tan]
- add a data64 tree as alternative for boards with a 64M SPI [Zev]
- add hog to bmc-ready GPIO pin as required by the host BIOS [Tan]
- fix offenses reported by scripts/dtc/dt-check-style --mode strict [Tan]
- Link to v2: https://lore.kernel.org/all/20251011112124.17588-1-tan@siewert.io/

Changes in v2:
- fix led node names [robh]
- fix missing gfx memory region and other fixable dtbs_check issues [Tan]
- Link to v1: https://lore.kernel.org/all/20250919185621.6647-1-tan@siewert.io/

To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Joel Stanley <joel@jms.id.au>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Zev Weiss <zev@bewilderbeest.net>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-aspeed@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org

---
Tan Siewert (2):
      dt-bindings: arm: aspeed: add ASRock X470D4U BMC
      ARM: dts: aspeed: add asrock x470d4u bmc

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |   2 +
 arch/arm/boot/dts/aspeed/Makefile                  |   2 +
 .../aspeed/aspeed-bmc-asrock-x470d4u-data64.dts    |  15 +
 .../boot/dts/aspeed/aspeed-bmc-asrock-x470d4u.dts  | 381 +++++++++++++++++++++
 4 files changed, 400 insertions(+)
---
base-commit: 749c34389679f8d56cb200a69b62f9a64670034f
change-id: 20251017-ts-x470d4u-54b9e98e4333

Best regards,
--  
Tan Siewert <tan@siewert.io>


