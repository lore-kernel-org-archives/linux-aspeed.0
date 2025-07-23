Return-Path: <linux-aspeed+bounces-1792-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11AEC83F17
	for <linux-aspeed@archiver.kernel.org>; Wed, 23 Jul 2025 21:58:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bnSgy6FjHz30HB;
	Thu, 24 Jul 2025 07:58:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:2413::604" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753307918;
	cv=pass; b=bk0Y3RuGLoIPGRjrY1UBBwYMXEWniG/2KuL7sEGTLG3zp6UB0XroVbbwAEb9pbRU+NnI1Zp2dUdHRd4TR4tooRZHBgNQfV+XtAVTjYnNZAYdS6X4FyItqNQUubh7Y5maCIFZJLHbRQSWfMrTVEQd5kNbP7VRtQIVU8vIHP1N87Jn38QS1PpEVVeMstzTtLu0INtxJlViUQrxJxhHRoPtOSUcpFN/gdq1Mv7HN6v/CYbtwokSJRwzyidlEoMMhqnd+5PfGK+wlvLp1VxWCp1Zai8V8YDVowcRUthf3MaY/k3cBSysVLTmSR37WMHwDE7Pd26lHhKFcGhjeTIT3lwkZQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753307918; c=relaxed/relaxed;
	bh=MMLi8xbcv2dp/UTpCPbDDINCPqrXSIVLa4F8B8JljJ0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GBTa6eyu2KmyoBD/u2uV4nDKHqJdOrutZodSbCM0p5OQ/CWHNPwrAppExaCL+tJ+DMdt21ojxbhWKn3XpkYp08A8q93N2XE+5Gobr+MTbgPX4Cetd3UrawBFzlUdaqvPqsVHcx7CI5hR2NRF2oEvQTeTQZW3lWKZD2Xka+wqAZUj9422bqfG2Bkp/udlUymmPni/9t+h9o536EzJWiEOaXXcsg2YhYzeiHyurgMXEnci8dj39sZftcFtqa4b+CVsnEeO74ZF5PYXrxzzvpnSC7rlZDM6JcwWQvwFtdBbFd/ZIamS2byrwHPNAPOzz+v9UTcXfhu+WBns2S2G/WvTGg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kY3G28tA; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:2413::604; helo=nam10-dm6-obe.outbound.protection.outlook.com; envelope-from=donalds@nvidia.com; receiver=lists.ozlabs.org) smtp.mailfrom=nvidia.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kY3G28tA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nvidia.com (client-ip=2a01:111:f403:2413::604; helo=nam10-dm6-obe.outbound.protection.outlook.com; envelope-from=donalds@nvidia.com; receiver=lists.ozlabs.org)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20604.outbound.protection.outlook.com [IPv6:2a01:111:f403:2413::604])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bnSgw3s94z30QJ
	for <linux-aspeed@lists.ozlabs.org>; Thu, 24 Jul 2025 07:58:35 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PPH/ke1nnLmCumnTadwktiXPd9zIhWuBGaSXYfqy6CUTWnMAlC1gthvUHshEw5zPsLZfveeV6Rma9fATbszajTMY5pxPYQaUWa3PCbh075sZPLmGXoWq96Tz801XIGK3M7ofPcekuxql9ouFM/0zbRQ+qMib/KqBzFLCBtOqVUDrG5hibBj4zDmINimflFepira8NjOclEi9MAMceB8olSgDYrUBwgRzld85EEphapNEmZ6Yp+kuh0CTJph/4pKIHKti0hLK37uNGodQQdY6gWJTHApglZG1o/VOzOiT8v2gKWGCYDsmhBgSXnZqZTPIhsa0lNxhpsdR5C/sH9Zu/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMLi8xbcv2dp/UTpCPbDDINCPqrXSIVLa4F8B8JljJ0=;
 b=yK9h4z5W0xKqtsKS2VX+6CL4CE+sjBTMAtmROY4p+aLXvHGygbNYaSRZqx9ocepIyCBKkcKaHobbzwIcIB53i+2biaUN0wJNWtyN0svH1gH8SyiT8XHBrzdiqQXH8SHBveWb4xeX64JktKFX98Pp4Gh3ge5ovuy14p4l+saB4Lv2C9phqtNLUxzAKnJ0NBXTiMtXWg462lp9Oc0k7qy9O1G49DJkCIr5EnCfSe/PvFG7c2qClpowNfPhy50ZSpBk+/uBA8HjlFJ0Qq+O82Iml70VSIhNjlbZN/aLWSi2MO0Oqz3UG+lSb4Mb85nQ+gQJJhudGaRGVuTRCYoXYEax3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMLi8xbcv2dp/UTpCPbDDINCPqrXSIVLa4F8B8JljJ0=;
 b=kY3G28tARcI3P157ED8KZdc6WN7Zav54nsoFF0aF83Vqe5Xp7eIZgSHYQTOo1ZNx+tsCA9cAP6R4oxx1n6hGUTkI8oTVJE+bRLZOC5xixharadCDhABBNDLHEyu2gt9WJTLHqDjUzE0JpfCj1BUgw+iAJNt2JUCcNej60P/CVo0+QhsEaWr/QHGdndttY/zeA2I14ehadFn/6/teG87b87Bryag26Mvf+ZnfpBm5sAOnbPx9Ux/zCsZ1alXi2DCxKpuQq6ASsPxwNP/3HnQPXqGrKb1OWkcgsqV6AVt14ryTRiWSln2RADqdolzAjzh5XdKEhmhUXaUI/O9J57/9Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7)
 by MN0PR12MB6001.namprd12.prod.outlook.com (2603:10b6:208:37d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 21:58:15 +0000
Received: from PH7PR12MB7282.namprd12.prod.outlook.com
 ([fe80::6f03:f851:7f6c:c68d]) by PH7PR12MB7282.namprd12.prod.outlook.com
 ([fe80::6f03:f851:7f6c:c68d%7]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 21:58:15 +0000
Message-ID: <24ce8704-1f9c-437e-ae72-1c6c3c672c2b@nvidia.com>
Date: Wed, 23 Jul 2025 14:58:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] dt-bindings: arm: aspeed: Add NVIDIA GB200-UT3.0b
 board
To: Krzysztof Kozlowski <krzk@kernel.org>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20250723014239.22667-1-donalds@nvidia.com>
 <20250723014239.22667-2-donalds@nvidia.com>
 <d85fa0c5-f155-431e-bc09-0bb74d96d670@kernel.org>
Content-Language: en-US
From: Donald Shannon <donalds@nvidia.com>
In-Reply-To: <d85fa0c5-f155-431e-bc09-0bb74d96d670@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::21) To PH7PR12MB7282.namprd12.prod.outlook.com
 (2603:10b6:510:209::7)
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
X-MS-TrafficTypeDiagnostic: PH7PR12MB7282:EE_|MN0PR12MB6001:EE_
X-MS-Office365-Filtering-Correlation-Id: 04fb2a31-787c-495a-b8e5-08ddca340680
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3djaGNQeUFtTks5QVk5cjYvNk5wVTRRSW95R0dPTWxpVEhFRnZrSUtSZklk?=
 =?utf-8?B?dGFVM3NqdzUyY2lTRkM2QXRKYklKZmw1d01rY0NTVUkwRnRsWDhBQXJiZEpE?=
 =?utf-8?B?RnNITHYzNEdvR0VNRFI3YU4wWGY3RHcyVGtrc2RsY1NQU1hxTEJqQmxselVq?=
 =?utf-8?B?SEU2UDNOUzJaRXllL0VsbWI2dVRHWXozc3VaOWxRc2ZhQ2o3TThjRFRTM24r?=
 =?utf-8?B?M2d3YTFpa2QzaXhCYWp3c0N1Mk8vWXRrazFXRFVTT3o5VmdCZkJ6N1RQSWpz?=
 =?utf-8?B?THFKcXl5OS8yWFRoQ2JGRGRjNzB2d0lXMEFQZTBHUm9aaEIxZldUbDIrY3dD?=
 =?utf-8?B?UjZWb3JlQThlZkYzVXpuZmZBQXdYaklyZytqOVo3YnFoSmhmSEo2TGRZVlBl?=
 =?utf-8?B?RnlqV3pRRTlLUGRMcDBOdzdjTk82Vy9vUXg4dlFITEozTnMvWG1TLy9XSzhH?=
 =?utf-8?B?ZHhsY2QvQ0xwSXJkQjRsQnFkQzlQd0RCc0ltOEZ1QzAzYWc2NUQ3WDRPeVBp?=
 =?utf-8?B?RE9IdGNGYzVLd0FLVXk3dDNIaDFvZ3J0aG5zVzh0ZXZ4Yis2YS9qcmVzdXlV?=
 =?utf-8?B?N3lBdEV0UnI5Wm8xTWpGNWV3TVRnSkZmZVViWkM0NWRjM3hKMU5TUlpZSEJK?=
 =?utf-8?B?TWh5Ky9nVDRXNzdUcnA0L1ZvbklLbG14dnVNOEJEYlgyT05IbTRQem1DQVlz?=
 =?utf-8?B?OW51UVRtQVY3U2N5VUpOQXVuUS94OGw4aEI2bytKZmRtcFN1cDBDNkNHMEVX?=
 =?utf-8?B?cnd4YThKN25qMVJOUnllVDhNUGI2YUxXSkZNdDhya3l3amRvazZ5Z1V1QkFX?=
 =?utf-8?B?WitKWktDaTBQTVYyUFlHa205YjRjUnFDVlM3bzVML1Uvdlo1UUtRYXIwYlVV?=
 =?utf-8?B?VitNNmZpRmt1emRlS2RicWExZXVjYnZFV2dSL1R2d0R2Qk02N1NxZ2srM3VM?=
 =?utf-8?B?TCtneHYweXI3UklZK1phd1h3WTZxZDVJd01zdVJ1S2FNd1JMQ0ZrYTVqd09u?=
 =?utf-8?B?T1NoaDJoTEIzV0RzQ0tTWXZ0VFNmQjRkR1Bia3dBN2kwS1d5VEI5a0lrQVB4?=
 =?utf-8?B?QmQ3Um1DQk9DU1JwaUUrbHlVdURPbklXNStnU0xxcGxsQWlNazlsTkZlVGhO?=
 =?utf-8?B?SXhqOXB6aDJSTzZ2ZkxCRTV5ZGM0ZExpTEJoQW5CcUlUNDJ0RCs2a3VYNDBz?=
 =?utf-8?B?cVA3ZjhFQTl3d2NGWm44VkZkanB3VXpjbUthRko3RlJQMjV6aFNOY3hyZU85?=
 =?utf-8?B?eDVOa3lLK2hZeGN0eXNaZzBCL0I4VU5uc0pITklvN0VGVlNOSmlGTWgwcmxT?=
 =?utf-8?B?UmNEckx3aUlmeW1JR2tCeW9lYndNM0JZaDB5STN6RVdSb2Joc1d4eEs1Ti9D?=
 =?utf-8?B?MUxDRVptUmFTbVNldEtFWnh1VGJyZTNULysrUHlGSnJxQjJ1b0xKT1Vzb04w?=
 =?utf-8?B?TEpwTExkczRra0N5SnV1a0VxdkMraXVnQ3FmTzZkYWE4NStlbFg0NzZ5MnNG?=
 =?utf-8?B?KzlMSm1qeHI1bDJOd1JjdW85UkZKdU5ET1JSYmIvNFhUSmNUdkdZcSthT1g4?=
 =?utf-8?B?V0RMZzJ1ay8yK1lyL3pxcVJXQ2ptaUNMaHRXMWdXelg3U3hlYTZ0VlVUYXFW?=
 =?utf-8?B?cjBlUjc2VlRocSs4eG5WUlZKSTVpSUg1OGRvR3VacXlNMFZRUWlHSCtFNnI0?=
 =?utf-8?B?Rmpsd3JGbkcyaStQYUpXVHNOWHA3eHdSQ2pVZUhZUUJCcTg4bkQyQk96VGVK?=
 =?utf-8?B?NXpOYm9Dczg2eXhnZW44OEZ6L1BBNWVBa2NnQkxQLzQxeEc5UStrVjluUTlu?=
 =?utf-8?B?RENFVis3UHd6RGJYSE5pVEw3d2xEYUxpZ2tUcWRGUnAxSkcxNmJVTDVZRkcy?=
 =?utf-8?B?c0J1RSszeUdGZmoySDRFRXZxVTVwMXdHdTQwQXE1TXBQNVUxM0JRRStoUjRM?=
 =?utf-8?Q?mabqUkvgnZU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7282.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDY1ZHBPcnlyL1I1ZmVoWUNhdUxwSlB5SWJmeUFYTkdSUm1tQ0JqaVBlK2FX?=
 =?utf-8?B?M09ERmtkZnZQQXdnQmZlY2R4Yklwb2x4a1E1TytLMm5SRStZdFl5ZHcvNEs5?=
 =?utf-8?B?MDhUb3RtQmtWTnY0Wk4vNkpDclNJSytQWmR0S3Q1ck03MDFjK2FsRGNsaDhz?=
 =?utf-8?B?L2NvOTNQenYzcFFrMlFxMUZHZFcvY1I3TElhb1dhNVk4Lzk4eHFVVHlacU1x?=
 =?utf-8?B?d0liQTA4N3UrQ3JESklHOVFvZktIUE1QbTJXR3dRNzVOaEpQcTN6SnU0VW5u?=
 =?utf-8?B?RHdPb1AyMTBld0ZDNFpHL3EzZFYvamo4eE1LZDlkY2JhM2J0dTVOYkUva3E1?=
 =?utf-8?B?S2huUWdLeTFxdzFqUVRiRWQrTExHYnZUd1BYMDlkV3dOaktJOGI1Ym1ySzE0?=
 =?utf-8?B?cnpZaFhlVUNMcmxmZkM2aEt6WmJMbVBQZ3RBMWxrQXBYUFN2OXhpVmYreG1L?=
 =?utf-8?B?bWxyRXRTNXRkbFJEemNOMUN3bW9WWHJpenZTSzFJUzFvSDRxa05uM1hudHdW?=
 =?utf-8?B?UUM4amg5UmtnRC9pZk5nT3BCNnpiZENGY0tPSUtmci9KZkFxZDNSaXREQjJk?=
 =?utf-8?B?K2pPWUxIRlZZaXhiS3JYSE9RRWtwZGRjWXV6bEZjMmdHQkdHWFNPeUZqODJw?=
 =?utf-8?B?NzA5amE4MEVHQy9xSUp3aHE3TzRnUDNVcytvS1FiV0VkaTFSMmEzQWlrNUFR?=
 =?utf-8?B?dmE2bGJQS1FlMEloN1ZuSHRaQlpYZFFhUWo4SGpFU3VQcmZNb0pNSFpuclV5?=
 =?utf-8?B?Q0hsbG9MblpMdm5FMnVyelBiYzZnYmhvMTI5bjkzTnUvQTNiS2xxT0ZvczJT?=
 =?utf-8?B?bnZ0b1Q4Mk54akNVeE5QRzFYWnRlT0sxWnRncjFPTks4czVlLzYxZUYwam4r?=
 =?utf-8?B?QVRtOHVGNHdRcmZnaFFNRkNVM1lRS3crdldPMVVBWGozcmN1SnRoK0JWK2dj?=
 =?utf-8?B?NWRVWHk0TVpqKzJ6Nm1ZcGVyQ3d5RDlVcmM2aEVRRUR4ZjhuSUtUZDE2NmN4?=
 =?utf-8?B?VlQ2dmdBOWdZdGF4NExYeHVodCs0UlhUR0JxeGVMcTArZ3F5Q2FuK3ovQ0h1?=
 =?utf-8?B?MDhrZ1JGVVFrTi9XL3RnNXRIZDN0ZDFJRWRaTG5DSVY4QXJyMTFvdWNKVGhQ?=
 =?utf-8?B?U1Q3dENncTZJK2RmNE5XbW1xUXlwRXcrWXZuZ203c0hsK21FR3NIZXNmdm9m?=
 =?utf-8?B?Y1ZuTDFRekZrSXpDdHJTK2xTL0JCRFRSTmJSenhvK1hKY0ZqdjhSWU9XcnB2?=
 =?utf-8?B?VWFxemtlRzVtOEJScEVmV2ZPRkRPQlZMWTc1YUxFMy9vb2lRSVpWQ2lkV0s0?=
 =?utf-8?B?VW9BVGNFYnVlaW1xeVVmRVp4cHE3Q05nY1N0Ukp3cUFOb3U5dkxJZUxXdXBD?=
 =?utf-8?B?VjBEbkc2TXFFVkpiOUFmTVBpcnhlZWwzK0lpWG9lT2RDOVcyeVUwQmQvZG5u?=
 =?utf-8?B?SDFUOGpIeGZqd092QTQ5VDNjTkM4Sk5UYjJVSXdxMzZackMwdWEySE56T1BL?=
 =?utf-8?B?dWJYRGJtTzNtblVRenJWMU90a0pHWFZjWkVyOFQzUjd2OVZNQTc3b1hWOElQ?=
 =?utf-8?B?amV6SGFIVlJNdisxYThjNTNMZG5rNHB2K3UrR3JHcVlsK010Q0tYMHJPZnp6?=
 =?utf-8?B?TDJwNTNxZGVacEszcmZMdHdHZ1ZwSWJBV3FDVi82N1VKL1VySk5DdnFaZkRo?=
 =?utf-8?B?Tk9XTG5melZlSzkzM0dyUXJGMy9qN0VMeWZqNDZNTDkwcmE2YzhsK080Vi9K?=
 =?utf-8?B?NU93eXZ4VzN1STVLZ2N3UjU2WGJyVW5sMHRkUis2Q3FONThUSFNvUVBvSmJK?=
 =?utf-8?B?VEVBNEtzK2tKRVBNY0ljM1FaSTVSSzNNcllIMCtab2FoaFJvZEdoZzI2Qmto?=
 =?utf-8?B?N2hXMmNjWDJ5cnF6YzQ4TTdISy9IWEhuWGY0ZW5zNm9tMEo4VTBBTzEvTnlw?=
 =?utf-8?B?blhkVC8zNHFyNGYzYVhuQmNES1UyWWx4WUoxQlVOSE1CRGgxU3djRUVwTjNq?=
 =?utf-8?B?ZkowRnhvYkc4RW96OEx3RXd2NlN5TXRmdGpMaFg3RTYrbnR2RkdwcGo5TGt6?=
 =?utf-8?B?ZGtZaHBGQXJ3SlJFdU93Uy9EN3E1YUZxd3QwaEppZVVjSWxBRkVwYW5RTzd6?=
 =?utf-8?Q?JZ/DyE/9jhgXl+HVcDm+eagQt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04fb2a31-787c-495a-b8e5-08ddca340680
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7282.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 21:58:15.4298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/xg38/ES0eA+LX9iLdSpCpvfCuaaPT6HKiP2rnUtRJPt2DTFtpvnErPmhX8f9IehSzHmc8cMK6+5WzeFzcY8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6001

On 7/22/25 22:56, Krzysztof Kozlowski wrote:
> External email: Use caution opening links or attachments
>
>
> On 23/07/2025 03:42, Donald Shannon wrote:
>> This is an Aspeed AST2600 based unit testing platform for GB200.
>> UT3.0b is different than nvidia-gb200nvl-bmc due to networking topology
>> differences, additional gpio expanders, and voltage regulator gating
>> some devices.
>>
>> Reference to Ast2600 SOC [1].
>> Reference to Blackwell GB200NVL Platform [2].
>>
>> Link: https://www.aspeedtech.com/server_ast2600/ [1]
>> Link: https://nvdam.widen.net/s/wwnsxrhm2w/blackwell-datasheet-3384703 [2]
>> Signed-off-by: Donald Shannon <donalds@nvidia.com>
>> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> Why are you faking tags? No, you cannot just add whatever you want.
>
> Best regards,
> Krzysztof

Hi Krzysztof,

I think I was confused by your message on my V5 patch. I will remove the Acked-by and resubmit:

>A nit, subject: drop second/last, redundant "binding". The
>"dt-bindings" prefix is already stating that these are bindings.
>See also:
>https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
>
>With above two:
>
>Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
>
><form letter>
>This is an automated instruction, just in case, because many review
>tags are being ignored. If you know the process, just skip it entirely
>(please do not feel offended by me posting it here - no bad intentions
>intended, no patronizing, I just want to avoid wasted efforts). If you
>do not know the process, here is a short explanation:
>
>Please add Acked-by/Reviewed-by/Tested-by tags when posting new
>versions of patchset, under or above your Signed-off-by tag, unless
>patch changed significantly (e.g. new properties added to the DT
>bindings). Tag is "received", when provided in a message replied to you
>on the mailing list. Tools like b4 can help here ('b4 trailers -u ...').
>However, there's no need to repost patches *only* to add the tags. The
>upstream maintainer will do that for tags received on the version they
>apply.

Thanks,
Donald


