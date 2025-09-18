Return-Path: <linux-aspeed+bounces-2285-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA0DCA1013
	for <linux-aspeed@archiver.kernel.org>; Thu, 18 Sep 2025 23:12:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cSWcg2Qs4z2yys;
	Fri, 19 Sep 2025 09:12:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c10d::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758237139;
	cv=pass; b=Rn0s6TYtWY1o7Zx9udn/zz65n+T3e8+jxJEHMblcOxqrb2dIy9Si9VBh6THns5mvyi3coKYpq9ObxKJ2waYzr5bn0v/2FyUSKv8fnZevilOBwzv6vj+mXyMO9TMzK1nxUTVOOaue3A5gwTjTydYb8lwZQi0M9oqHo09mIYFESQN63hdjb72lNL+fRC7sl+3POboNbbqBvgjYCTDhokKTRPGtFhIV0Mj1Id4Uh/dMqEqwm4EkPnunuZT0iM+msC440UvQXkZIU3bxosRD9HhuvYDN2rmL/A9rPqFqmrBGL+EQtd9OLLGjzpZwnDd1aQiTR4gPPqgM8QBx5SamjhanPQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758237139; c=relaxed/relaxed;
	bh=rN4SdrbP3hVHhtzCEDjSAnUXqr77l4jj6fJwfT3KFJ0=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=mPGJJhribMXkNF55SCYwKX4xxi8TXT71go9+KUXKBLMke2pCOW6CT3ycfZNAHuGp/+cM8buSd3bGdw6r1LMXlYpGfmb9zwk6jfKjL1pKm2NvEg1pGcJd+WniN2o1UNfKUv7A3BOKyZk0791U5l700yC6o5ObOZQrVSfUcW7YqhPuwabZ3v2RcIf98LgW+wUK1/JS+JBvD491tSuSriHrrNg8vD7uhKLKzFzUN/CXHRj3P3/r+BZIB5bBO0sLpH+CV8A4b0hG79vR2YABBMcjiIN1VAxFwh1009a2JUbsXEdixG1MqygdPQj25IUAbrWZlNZDOmm1vFOJoDb0Mv9p4w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Z2+lRACu; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c10d::3; helo=sn4pr0501cu005.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Z2+lRACu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:c10d::3; helo=sn4pr0501cu005.outbound.protection.outlook.com; envelope-from=molberding@nvidia.com; receiver=lists.ozlabs.org)
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c10d::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cSWcd5DSmz2yD5
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Sep 2025 09:12:17 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BXzldPRQlhxlMd64WYU0SrqJb67530Gnl3N2OsQzYnCYeua9qnNmtNUpc8MhS3LMrVcE50qVDpSbZJQz1Fn3f7Et2zfIHJHyTbisDuKSA36oKEtKCKlf4SZoFGLsVwfyg+3ypnQEbJ58wlWhWA8eRxKr07eWrFhemzIA8JcZTFlTGW+jCG3Ss2wnwybyJmjVNZMb2beHJ+sLSD+Mm696o9AfI3oMnf1jW/RZ/PAdP/uEPrKTiJ3jIu3g1heruSKqfA9xvXr/lOGQNjlpiTX1nfZ29g4RrUPO8TaCDqRyhxN4YCBjW+cmLk9le9wAp+Nd1Cmodj7DxUYz4djylf1iuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rN4SdrbP3hVHhtzCEDjSAnUXqr77l4jj6fJwfT3KFJ0=;
 b=isQLmUsBrARrvTnD613Ocfb0LntzivyuPzKNLPYZjNvPuUyMloOnaFvJb3PqNm+agjPCqeETx2KeJY7/M8dkwpoUj086Bahu5KwmhFn7/5BR7usEXIGgU9NMpMohQ1p6PbYj4oHSSRCloAXlchQHm/NyZuhfEanKMyYCHwPNSJ5j8aggdY7AUTGQTrBuVgU36pNiN/FoffEnWK1t66AQnxzcYI9QKzOoTCC8ippilBI6JbaNIoXFcug57Ww4NsXwjqsE+fRi0PFmsyQidNuj+pNuQOiWDTZCll01isOzwEQX1+Eue/jsnYq/0cnRrrIhta4+g03kN22F9uDlwJD0sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rN4SdrbP3hVHhtzCEDjSAnUXqr77l4jj6fJwfT3KFJ0=;
 b=Z2+lRACuC/lcPisx2/kOXpmQ/xV9xo85bch3GogqQGCMwUcMmvbqCFWrjz0BYEPd1OhYwu/6ro4vxkHlUYbUZAID7zDQl2dvx8fN3B5Iygmwl18T69kbP1CTN1Nbl9AcEwZYU1+Rl/diwv4vr5/K/5M9ir1OrWtJITJr8WlD8rFG4eYBTKo05kClw3sPOfKeT5EpVLXDLY/uOzhs2eNSE/tUlW4/6G9lUtnrhzgevR7lA3kCu2quVC+Vwgll9HUCpeVzUkExNEdfV0WWWcm1pFHG73egxL+44q/GyRKhN+yEELHiLMBXAqGgcVFNWxVg4MgLCZi6pW9c7q+5nvaQQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::627) by IA1PR12MB6483.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 18 Sep
 2025 23:11:52 +0000
Received: from CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::9de5:7299:4ee9:21e8]) by CH1PPFDAD84AB72.namprd12.prod.outlook.com
 ([fe80::9de5:7299:4ee9:21e8%4]) with mapi id 15.20.9115.020; Thu, 18 Sep 2025
 23:11:52 +0000
From: Marc Olberding <molberding@nvidia.com>
Subject: [PATCH 0/2] Add device tree for Nvidia BMC msx4 cx8 switchboard
Date: Thu, 18 Sep 2025 16:11:36 -0700
Message-Id: <20250918-msx1_devicetree-v1-0-18dc07e02118@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKmRzGgC/x2MWwqAIBAAryL7neAK0uMqESG61n5koRFCePekz
 4GZeSFTYsowiRcSPZz5jA2wE+B2GzeS7BuDVtqoUQ3yyAVX30xHdyKSvQ3aYXBovIJWXYkCl/8
 4L7V+7/W2NWEAAAA=
X-Change-ID: 20250908-msx1_devicetree-7af2c1fc15d0
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Marc Olberding <molberding@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758237110; l=947;
 i=molberding@nvidia.com; s=20250815; h=from:subject:message-id;
 bh=MWl52JM1QF9v1Tp1X5hyflKkCYT5XkJtTb1tpPWhfsY=;
 b=+RncYwPvKCBBWFbM9/5l/ajfK0jksc3ps07JpW7yhRVEYVnExnN064swMdroW2Me07szzCgbq
 EwPY8UP8kcWB8GtsfHyavTNaFZGlKXDr8KAs1d6yVeQX6LNr0q8ZmKD
X-Developer-Key: i=molberding@nvidia.com; a=ed25519;
 pk=qCpZ1WFEf5YiaL88PDdYhG+A/bKk7rHp7KF2K3GmkH0=
X-ClientProxiedBy: MW4PR04CA0061.namprd04.prod.outlook.com
 (2603:10b6:303:6b::6) To CH1PPFDAD84AB72.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::627)
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
X-MS-TrafficTypeDiagnostic: CH1PPFDAD84AB72:EE_|IA1PR12MB6483:EE_
X-MS-Office365-Filtering-Correlation-Id: afbcff95-fc3b-493e-4198-08ddf708c087
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmErbGs1RDNEeCsyUjY1bWorajJJbjYvWDhLNzRFRjVYZkFoYzU0c0loU09K?=
 =?utf-8?B?L2R6WVZwQjNuaXROZFRqWHkzQVRneHdtZytjcjhRYmhCemZCN2RhbEQ5UlJW?=
 =?utf-8?B?TzJNQkh4WHdjRmErRmVzZGN0Y0NxSlc4YnhiNkVFc01zTFFVcnJ0TGU5ek5C?=
 =?utf-8?B?VituK3RoaTlCdHpBYUl5RGh5Q0hERjZ5WWZtdFhIQTA2MFAwNmtIbXhSam5t?=
 =?utf-8?B?VzdteDNBcUhwWG8yZnVTTzJFYlR2aFZ5S2dCVU5xZ2lIalNSOTJYTmV1SWNE?=
 =?utf-8?B?a0w5RmVCN0pZdDc0dEJmNlV5SUZrN1hkc0lmazMyWHp1VEJTY1N2U3Fia2ZF?=
 =?utf-8?B?WWNEb1lhRE1vQzdJYXR1Z2VJQTlQMU15OUMwMlVpOXhoRHU5WVRuWVdESk56?=
 =?utf-8?B?bndVNHFDT1BhaE8rbDZyYktjaENNTUJqVnZnaWJNeVVPaERSMlYxclF5d01a?=
 =?utf-8?B?Qjk5YTI4UTlIWjRiS2hFdFQ5ZUNWMjhMc2VSVUpzZitqUnB1OHlsak5ZckJQ?=
 =?utf-8?B?c1pFNExMSEM4UFRqOWJ2S0ZPV2hrWGFPRnhYYTFGV3J3a1kyeWMrY3lMa28y?=
 =?utf-8?B?eHpDUXdvWG4vTmJWa0xrZEg0L0VxNDU2a1l0dVZkeXp4SVdpUHNqQjc4WUxR?=
 =?utf-8?B?TzNaQ2tYRnBPMEhrNHRHNGJMazRyalFzbVRMcUV5MnpNTC9LdHlocU9NNkhY?=
 =?utf-8?B?UHNRYzNwcFN3anA3NkZSVmJYZlg5NDNSZnh1WTVKd1B3UnFYSWRMOTlCY2J4?=
 =?utf-8?B?b0lSZ01IczVEMFNNTFVxOUNKcXoxcHFPeEVFMEVPT2VnWFk2eWdSaDZONE5I?=
 =?utf-8?B?ekZHOWNGbC91VWE4K203V0hMKzJ0YmYwZWtpSHJoVXg2SlhwN0wrSVlhNm1Y?=
 =?utf-8?B?WVhTc29NMkVZdEwwZUExNUVsUFV2UDVKVUJwOU42ZWtrTkpSTlF2UzBhb3Vq?=
 =?utf-8?B?T0pGckNpNXZqMUgxSkl6OGxzNWpudVJHU3A4ck1PLzE4T3hiMVo0K0FqdFpj?=
 =?utf-8?B?WUlQN24zaTRpMTVuY0FSdVJINzNVTTdYaTlXaE1lbktxQzJLM2l6cjgyM2Zm?=
 =?utf-8?B?bEp4RkdJVzNNSTZ1VS8vSC8vRmM3eExHQ0MvN28xcjA2YTQ2K1YzakVxMi9B?=
 =?utf-8?B?YzhNSEJmaDRwUm1yeFhsV3RTcmEyaXhHN3R3WE00bnEyY2dyRHJ2QUViVW96?=
 =?utf-8?B?VzZieVFWVjEza3E1WStBSmthRXZWRUpxVXovOWl4U2xyK0NJcHdJRFhDVXcx?=
 =?utf-8?B?WkdTM3J5akJydkxBLzdYaVI3YTJKanBHTjkxUGtVa01HSm10eGVzTjdZanpX?=
 =?utf-8?B?OEhzL2JwOUdWSDd6cWE2ZDJVK1RRYzd3alRMeENOblZLRmRNYkorRjYxQ3Br?=
 =?utf-8?B?bFpUcm5rNUM4YVNtK3hRaE9OaEhJaG9vSzU4a2U5K3o0Mnp5VFcyNlRUWDl2?=
 =?utf-8?B?WTR3M1VmRmxXSEVwMk8zcVBlaW9kQ3lqS2ZCa0pPOUJOM3BhbXBjZDF0bDF0?=
 =?utf-8?B?ZlcxdER6NDhSOUpGaStWV3BFeGJlU1J3ZUFqU1RsSXF3dXU5RTdzWmNzYmE0?=
 =?utf-8?B?Wi8waitxUVUyWGZibTA4ZGdibXN2U29UKzN5RGIyMmg3aWR3UGJOdjBRc2g0?=
 =?utf-8?B?eUdyTmNMY0ZVemgxUW43Vyt1bHVmZnNIbDllbXAvNjZJOWVQcmRRV2NWeDNv?=
 =?utf-8?B?KzlBMjZ6S29ZR0RuZDMrbTc3MjdUUkR1elNCQ0dVcGxEdGJXb0tickFRNk5K?=
 =?utf-8?B?ZEQzdnRMRkhCS0ZNWHEwQkNseUYyUWZNcDNYRGxZWEw4NGVUdWFVcWg2U3or?=
 =?utf-8?B?SHlxUGhmR2JzVGI3ZTBrVzMzdTV2QUJDU3hGcHEyUEFaMTJtM1pzaVhCNlRu?=
 =?utf-8?B?cm9HRmFqWHAvcmpvRzFGUlpaeExnY29kaWMxcmNSTGxoMU9Bc3JQbjZ3c3k0?=
 =?utf-8?Q?RqbASoQeIKE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH1PPFDAD84AB72.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VExMWWtMR0lUZlp6RU5KSUl6UmhIZjJQeHg0S2JlM1p3OHpUaHIvOXlmUUVn?=
 =?utf-8?B?UGdSVkNEb3lHc2VMN2N0Ymlvbm9iTHpUbUpFazgySDlJTDhybm5LcVhmdko0?=
 =?utf-8?B?bkNoc1VzNGtnWDRBbit3a1NVcEtYUm9Pb2xnTGc3NVZOd3VyanpvUitkbm1C?=
 =?utf-8?B?c3VZUFdEZXhBamx6dksxdytrMldFUDhFUm82S1NtU21NVTZpc2lMYWNrQVNM?=
 =?utf-8?B?eXZqUUdmTDVxOElEc3VTWDZucGJGWHZrOUszR2VyMDlYV0tLWEUrWEpyY0VO?=
 =?utf-8?B?STVXL1dPNENMcFBFMGE2MEFxbXNKRDAzYWtnL3NWbE1FM3V1dmN2NjdrczVR?=
 =?utf-8?B?L09qOURMdngxODhNaGlGTnZlbEtQKzVwK2xFV2Y4aE4xR0luMDNXSEpWd1Bm?=
 =?utf-8?B?MHdmOFMxOGg0eTc3SHZ6VnRGN3hHeE9DeDU0YVJjV3p6YmJ3TGJSY3dLRlRB?=
 =?utf-8?B?U3R0U2ZkeENlMTdTV0tnZ1NxRWpVeWtmU3EvMHFwL2hMZWhyaDQrbnZXbURR?=
 =?utf-8?B?REMwT0V4TlNZZHlLSGI3WlcrcnhFZGFLUXNzTHRWN3JqdG1HQVFmaXNFR2Fm?=
 =?utf-8?B?MTFuMXIybHNwTkxIaXFaSkxNV00rb3F3Q1NMeVlXVjRpRFp5Z1FOaU0vSUpw?=
 =?utf-8?B?L3JNTXpFZnp6LzYrSlgxM1FMMExFVzAxSmZKay80bVZBdE9ocVV1eDBUeG1S?=
 =?utf-8?B?MWlwWDl1MStqTFZZNE9iNDZEREU0bVM2dzBpcHZWaHZjeVpXb0ZkNTNrdXlk?=
 =?utf-8?B?MkRkZEtUL1RLTEUyL1d1NEJ5L2ZFMW5JNERtKzRzS2dyR1NZUGV2Tk1LZVhm?=
 =?utf-8?B?aWhPcVl6SEhMRDFwY1poTDBva0ZzMDJpS1dzNjNYd3BQbGZSdFBsZnpwUnB1?=
 =?utf-8?B?Q0taVTVYK3BNSW83QndKNGl3TDMrTnMrb0Z0eEl4VDVnMy9Wb3ZIaFNxaE1s?=
 =?utf-8?B?bEJEaWYvTGRIMnRaRDVKTFdUMTN3eXgvQnFNbHdhdWxMWXFxbEQzTnpGajZw?=
 =?utf-8?B?QVlnODJraHo3UHU1UktNdnBnMXA5KzdLSm42cnRyZDB0dnRzZVpUUVJBOUhY?=
 =?utf-8?B?RGk0LzhERVFFSkFNVFVNMXVDT1dRL2UyMFdHV3c3dWVBT1lJVU4zT2xPZUww?=
 =?utf-8?B?MGhIWjhPOFAzL3B5a3RoYXlDK21RN0ZaUDBwcStxVG0xeFp2MTNPRnVnRnZM?=
 =?utf-8?B?UElSWjFRSTBZZzl0M0NlakRNNzhXWmhxdzZOTUZSdlJwd0ZuNVVrMXhzWjBr?=
 =?utf-8?B?R1NaRDlNeE1OVkRPci9KaXZPVFRRaXFxTXFYWmhsNVJ0YW1wQ0IwYjNFdVpt?=
 =?utf-8?B?M1pRYUV1eHNRV21RUWFIbk96Q2c3dVJiV2E3bjNIRGRHSXpINm5SaUZtWEZt?=
 =?utf-8?B?NENobVUxdEtTNmZERU1yZlZ2Z3BheSt3YzI5dDVFWnpvaTVwYnBuOGIySUQ4?=
 =?utf-8?B?OUphSW1wZUJDbzhTaWlGNUg5ankxZEJvU2ZLK1IrVTl0anhQaEdGdTU3aTJu?=
 =?utf-8?B?aTFpZTIxMWVUUEhSbFVQdTFXbnpSbU1qdCs1VERwNGdQZmtPSTRuV3NWMHpa?=
 =?utf-8?B?eTFBQXdqa0drNXBvaGpwVzI4TGZNQTFuVWZWV3F4dlZvejMyUFRlMDhoV29h?=
 =?utf-8?B?SEVvUEVDTi9yL1VaTjQzdWVWNFpMQktTR2Z4eFN4U1lxNnppbHVXd3Zid2sy?=
 =?utf-8?B?VUVGTDNheHNzT2t1bmZkQVIyZm1IeUw0M2IrNmIvQ1NFa2gxZkl4T200VWZO?=
 =?utf-8?B?eVlnNldHeUNXSnNNeUtvMEQ4YmVraFZTcFZvUm92YXFyVnpiRDhKbzgrY0g2?=
 =?utf-8?B?QkthL053SlNJb3prZXNycFRVaVVTbWV1WlBlZWJiYytOQkIvNVY5RVBNUjlW?=
 =?utf-8?B?clNYdkYxQ2k3NWNlaWFhOUI5WWtVNGlGQk5KaHRidkdVS1kyKzZGNmNrZncz?=
 =?utf-8?B?U2FiUStHVmRmLzJGMFErNlRnaW1xbER2cW9NOFVpMXk1QThWKzcyRk5wN01Y?=
 =?utf-8?B?RnJpZVphTTZ3b1dzemc4dlF1SmVjaFpHbFI4QnhyZlJ1L3ZXNi9KZDdnTXRG?=
 =?utf-8?B?QlBwcFVCZ1JYMmtCVktub0xrcEsyWlNKT0EzUklQZDFTaXY0OHNLTVdGaGJU?=
 =?utf-8?Q?6eU3qcdmEoLr1dj2coD46SwOA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afbcff95-fc3b-493e-4198-08ddf708c087
X-MS-Exchange-CrossTenant-AuthSource: CH1PPFDAD84AB72.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 23:11:51.9950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nLUjd7yEntIajdCD8aUMgI32IrRCEwwhAqyggOLWWZAQEtuBMu+YcIyl9LZ4XRQz8VsS+S5xC4EcM8E5lvV8xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6483

Patch 1 Adds the binding for the msx4 cx8 switchboard
Patch 2 Adds the device tree for the msx4 cx8 switchboard reference implementation.

This is an Aspeed AST2600 based reference implementation for a BMC
managing the nvidia mgx cx8 switchboard.

Reference to Ast2600 Soc [1].

Link: https://www.aspeedtech.com/server_ast2600/ [1]

Signed-off-by: Marc Olberding <molberding@nvidia.com>
---
Marc Olberding (2):
      dt-bindings: arm: aspeed: Add Nvidia msx4 board
      dts: aspeed: Add a dts for the nvidia msx4 hpm

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |   1 +
 arch/arm/boot/dts/aspeed/Makefile                  |   1 +
 .../boot/dts/aspeed/aspeed-bmc-nvidia-msx4-bmc.dts | 254 +++++++++++++++++++++
 3 files changed, 256 insertions(+)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250908-msx1_devicetree-7af2c1fc15d0

Best regards,
-- 
Marc Olberding <molberding@nvidia.com>


